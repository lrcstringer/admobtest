/**
 * Gooi-Gooi Scheduled Cloud Functions
 *
 * Automated background jobs for the Gooi-Gooi rotating savings feature:
 * - Cycle advancement (PENDING → COLLECTING) + auto-debit processing
 * - Contribution reminders (3 days, 1 day, due date)
 * - Grace period closure (COLLECTING → AWAITING_TRIGGER, flag MISSED)
 * - Auto-trigger payouts (72h fallback)
 * - Retry failed payouts
 * - Expire delegations
 * - Expire invitations
 */

import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import {
  GooiCollections,
  getGooiConfig,
  writeGooiAuditLog,
} from "./helpers/gooiGooiHelpers";
import {
  processGooiContribution,
  processGooiReserve,
  processGooiPayout,
  processGooiReserveTopup,
} from "./ledger/gooiGooiEscrow";

const db = admin.firestore();
const GOOI_SCHEDULE_LABELS = { area: "gooi-gooi-scheduled" };

// ============================================================================
// 1. ADVANCE CYCLES (PENDING → COLLECTING + auto-debit)
// ============================================================================

export const advanceGooiCycles = onSchedule(
  {
    schedule: "0 * * * *", // Every hour
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    timeoutSeconds: 300,
    memory: "512MiB",
    labels: GOOI_SCHEDULE_LABELS,
  },
  async () => {
    const now = admin.firestore.Timestamp.now();

    let advanced = 0;
    let autoDebited = 0;

    // Paginate through ACTIVE groups
    let lastDoc: any;
    let hasMore = true;

    while (hasMore) {
      let query = db.collection(GooiCollections.GROUPS)
        .where("status", "==", "ACTIVE")
        .where("isDeleted", "==", false)
        .limit(500);

      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const groupsSnap = await query.get();
      if (groupsSnap.empty) break;
      lastDoc = groupsSnap.docs[groupsSnap.docs.length - 1];
      hasMore = groupsSnap.docs.length === 500;

      for (const groupDoc of groupsSnap.docs) {
        const group = groupDoc.data();

        const pendingCyclesSnap = await groupDoc.ref
          .collection(GooiCollections.CYCLES)
          .where("status", "==", "PENDING")
          .where("dueDate", "<=", now)
          .get();

        for (const cycleDoc of pendingCyclesSnap.docs) {
          // Transition to COLLECTING
          await cycleDoc.ref.update({ status: "COLLECTING" });
          advanced++;

          await writeGooiAuditLog(groupDoc.id, "CYCLE_OPENED", "SYSTEM", {
            entityType: "CYCLE",
            entityId: cycleDoc.id,
            afterState: { cycleNumber: cycleDoc.data().cycleNumber },
          });

          // Process auto-debit for opted-in members
          const membersSnap = await groupDoc.ref
            .collection(GooiCollections.MEMBERS)
            .where("autoContribute", "==", true)
            .where("isActive", "==", true)
            .where("status", "==", "ACTIVE")
            .get();

          for (const memberDoc of membersSnap.docs) {
            const memberData = memberDoc.data();
            const cycle = cycleDoc.data();

            // Skip recipient if they don't contribute
            if (!group.recipientContributes && memberData.userId === cycle.recipientUserId) continue;

            // Find their pending contribution
            const contribSnap = await groupDoc.ref
              .collection(GooiCollections.CONTRIBUTIONS)
              .where("cycleId", "==", cycleDoc.id)
              .where("userId", "==", memberData.userId)
              .where("status", "==", "PENDING")
              .limit(1)
              .get();

            if (contribSnap.empty) continue;

            const contrib = contribSnap.docs[0];
            const contribData = contrib.data();

            try {
              const baseResult = await processGooiContribution(
                memberData.userId, groupDoc.id, cycleDoc.id, contribData.amountBase
              );

              if (baseResult.success) {
                await processGooiReserve(
                  memberData.userId, groupDoc.id, cycleDoc.id, contribData.amountReserve
                );

                const batch = db.batch();
                batch.update(contrib.ref, {
                  status: "PAID",
                  journalId: baseResult.journalId,
                  paidAt: now,
                });
                batch.update(cycleDoc.ref, {
                  totalCollected: admin.firestore.FieldValue.increment(contribData.amountBase),
                  reserveCollected: admin.firestore.FieldValue.increment(contribData.amountReserve),
                });
                batch.update(memberDoc.ref, {
                  contributedCycles: admin.firestore.FieldValue.increment(1),
                });
                await batch.commit();

                autoDebited++;

                await writeGooiAuditLog(groupDoc.id, "CONTRIBUTION_PAID", "SYSTEM", {
                  targetId: memberData.userId,
                  entityType: "CONTRIBUTION",
                  entityId: contrib.id,
                  metadata: { autoDebit: true },
                });
              }
            } catch (err) {
              logger.warn(`Auto-debit failed for ${memberData.userId} in group ${groupDoc.id}:`, err);
            }
          }
        }
      }
    }

    logger.info(`advanceGooiCycles: ${advanced} cycles advanced, ${autoDebited} auto-debits processed`);
  }
);

// ============================================================================
// 2. SEND REMINDERS (3 days, 1 day, due date morning)
// ============================================================================

export const sendGooiReminders = onSchedule(
  {
    schedule: "0 * * * *", // Every hour
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    timeoutSeconds: 120,
    labels: GOOI_SCHEDULE_LABELS,
  },
  async () => {
    const now = new Date();
    const hour = now.getHours(); // SAST hour

    // Only send at 06:00 and 09:00 SAST
    if (hour !== 6 && hour !== 9) return;

    let sent = 0;

    // Paginate through ACTIVE groups
    let lastDoc: any;
    let hasMore = true;

    while (hasMore) {
      let query = db.collection(GooiCollections.GROUPS)
        .where("status", "==", "ACTIVE")
        .where("isDeleted", "==", false)
        .limit(500);

      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const groupsSnap = await query.get();
      if (groupsSnap.empty) break;
      lastDoc = groupsSnap.docs[groupsSnap.docs.length - 1];
      hasMore = groupsSnap.docs.length === 500;

      for (const groupDoc of groupsSnap.docs) {
        const cyclesSnap = await groupDoc.ref
          .collection(GooiCollections.CYCLES)
          .where("status", "in", ["PENDING", "COLLECTING"])
          .get();

        for (const cycleDoc of cyclesSnap.docs) {
          const cycle = cycleDoc.data();
          const dueDate = cycle.dueDate.toDate();
          const diffHours = (dueDate.getTime() - now.getTime()) / (1000 * 60 * 60);

          let reminderType: string | null = null;

          if (hour === 9 && diffHours > 60 && diffHours <= 84) {
            reminderType = "3_days_before";
          } else if (hour === 9 && diffHours > 12 && diffHours <= 36) {
            reminderType = "1_day_before";
          } else if (hour === 6 && diffHours >= -6 && diffHours <= 6) {
            reminderType = "due_date";
          }

          if (!reminderType) continue;

          // Get unpaid members
          const unpaidSnap = await groupDoc.ref
            .collection(GooiCollections.CONTRIBUTIONS)
            .where("cycleId", "==", cycleDoc.id)
            .where("status", "in", ["PENDING", "LATE"])
            .get();

          for (const contribDoc of unpaidSnap.docs) {
            const contrib = contribDoc.data();
            const userDoc = await db.collection("users").doc(contrib.userId).get();
            const fcmToken = userDoc.data()?.fcmToken;

            if (fcmToken) {
              try {
                await admin.messaging().send({
                  token: fcmToken,
                  notification: {
                    title: "Gooi-Gooi Reminder",
                    body: reminderType === "due_date"
                      ? `Your Gooi-Gooi contribution for ${groupDoc.data().name} is due today!`
                      : `Your Gooi-Gooi contribution for ${groupDoc.data().name} is due soon.`,
                  },
                  data: {
                    type: "gooi_gooi_reminder",
                    groupId: groupDoc.id,
                    cycleId: cycleDoc.id,
                    reminderType,
                  },
                  android: { notification: { channelId: "gooi_gooi" } },
                });
                sent++;
              } catch (err) {
                logger.warn(`Failed to send reminder to ${contrib.userId}:`, err);
              }
            }
          }
        }
      }
    }

    logger.info(`sendGooiReminders: ${sent} reminders sent`);
  }
);

// ============================================================================
// 3. CLOSE GRACE PERIODS (COLLECTING → AWAITING_TRIGGER, flag MISSED)
// ============================================================================

export const closeGooiGracePeriods = onSchedule(
  {
    schedule: "0 * * * *", // Every hour
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    timeoutSeconds: 300,
    labels: GOOI_SCHEDULE_LABELS,
  },
  async () => {
    const now = admin.firestore.Timestamp.now();
    let closed = 0;
    let missed = 0;

    // Paginate through ACTIVE groups
    let lastDoc: any;
    let hasMore = true;

    while (hasMore) {
      let query = db.collection(GooiCollections.GROUPS)
        .where("status", "==", "ACTIVE")
        .where("isDeleted", "==", false)
        .limit(500);

      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const groupsSnap = await query.get();
      if (groupsSnap.empty) break;
      lastDoc = groupsSnap.docs[groupsSnap.docs.length - 1];
      hasMore = groupsSnap.docs.length === 500;

      for (const groupDoc of groupsSnap.docs) {
        const cyclesSnap = await groupDoc.ref
          .collection(GooiCollections.CYCLES)
          .where("status", "==", "COLLECTING")
          .where("graceCloseDate", "<=", now)
          .get();

        for (const cycleDoc of cyclesSnap.docs) {
          // Flag unpaid contributions as MISSED
          const unpaidSnap = await groupDoc.ref
            .collection(GooiCollections.CONTRIBUTIONS)
            .where("cycleId", "==", cycleDoc.id)
            .where("status", "in", ["PENDING", "LATE"])
            .get();

          const batch = db.batch();
          const defaulterIds: string[] = [];

          for (const contribDoc of unpaidSnap.docs) {
            const contrib = contribDoc.data();
            batch.update(contribDoc.ref, { status: "MISSED" });
            defaulterIds.push(contrib.userId);

            // Increment missed cycles on member
            const memberSnap = await groupDoc.ref
              .collection(GooiCollections.MEMBERS)
              .where("userId", "==", contrib.userId)
              .where("isActive", "==", true)
              .limit(1)
              .get();

            if (!memberSnap.empty) {
              batch.update(memberSnap.docs[0].ref, {
                missedCycles: admin.firestore.FieldValue.increment(1),
                outstandingDebt: admin.firestore.FieldValue.increment(contrib.amountTotal),
              });
            }

            missed++;
          }

          batch.update(cycleDoc.ref, {
            status: "AWAITING_TRIGGER",
            defaulterMemberIds: defaulterIds,
          });

          await batch.commit();
          closed++;

          for (const uid of defaulterIds) {
            await writeGooiAuditLog(groupDoc.id, "CONTRIBUTION_MISSED", "SYSTEM", {
              targetId: uid,
              entityType: "CYCLE",
              entityId: cycleDoc.id,
            });
          }
        }
      }
    }

    logger.info(`closeGooiGracePeriods: ${closed} cycles closed, ${missed} contributions flagged MISSED`);
  }
);

// ============================================================================
// 4. AUTO-TRIGGER PAYOUTS (72h fallback)
// ============================================================================

export const autoTriggerGooiPayouts = onSchedule(
  {
    schedule: "0 * * * *", // Every hour
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    timeoutSeconds: 300,
    memory: "512MiB",
    labels: GOOI_SCHEDULE_LABELS,
  },
  async () => {
    const now = admin.firestore.Timestamp.now();
    let triggered = 0;

    // Paginate through ACTIVE groups
    let lastDoc: any;
    let hasMore = true;

    while (hasMore) {
      let query = db.collection(GooiCollections.GROUPS)
        .where("status", "==", "ACTIVE")
        .where("isDeleted", "==", false)
        .limit(500);

      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const groupsSnap = await query.get();
      if (groupsSnap.empty) break;
      lastDoc = groupsSnap.docs[groupsSnap.docs.length - 1];
      hasMore = groupsSnap.docs.length === 500;

      for (const groupDoc of groupsSnap.docs) {
        const group = groupDoc.data();

        const cyclesSnap = await groupDoc.ref
          .collection(GooiCollections.CYCLES)
          .where("status", "==", "AWAITING_TRIGGER")
          .where("autoTriggerAt", "<=", now)
          .get();

        for (const cycleDoc of cyclesSnap.docs) {
          const cycle = cycleDoc.data();

          try {
            let payoutAmount = cycle.totalCollected;
            const shortfall = cycle.totalExpected - cycle.totalCollected;

            if (shortfall > 0) {
              const topupResult = await processGooiReserveTopup(groupDoc.id, cycleDoc.id, shortfall);
              if (topupResult.success) {
                payoutAmount += shortfall;
              }
            }

            const payoutResult = await processGooiPayout(groupDoc.id, cycleDoc.id, cycle.recipientUserId, payoutAmount);
            if (!payoutResult.success) {
              await cycleDoc.ref.update({ status: "PAYOUT_FAILED" });
              logger.error(`Auto-trigger payout failed for group ${groupDoc.id}:`, payoutResult.error);
              continue;
            }

            const payoutRef = groupDoc.ref.collection(GooiCollections.PAYOUTS).doc();
            const batch = db.batch();

            batch.set(payoutRef, {
              id: payoutRef.id,
              cycleId: cycleDoc.id,
              cycleNumber: cycle.cycleNumber,
              recipientMemberId: cycle.recipientMemberId,
              recipientUserId: cycle.recipientUserId,
              amountFromContributions: cycle.totalCollected,
              amountFromReserve: payoutAmount - cycle.totalCollected,
              totalPayoutAmount: payoutAmount,
              shortfallAmount: cycle.totalExpected - payoutAmount,
              status: "COMPLETED",
              retryCount: 0,
              lastRetryAt: null,
              journalId: payoutResult.journalId,
              triggeredBy: "SYSTEM",
              triggeredAt: now,
              completedAt: now,
              defaulterMemberIds: cycle.defaulterMemberIds || [],
            });

            batch.update(cycleDoc.ref, {
              status: "COMPLETE",
              payoutAmount,
              triggeredBy: "SYSTEM",
              triggeredAt: now,
              completedAt: now,
            });

            // Check if group is complete
            const nextCycleNumber = cycle.cycleNumber + 1;
            if (nextCycleNumber > group.totalCycles) {
              batch.update(groupDoc.ref, {
                status: "COMPLETED",
                completedAt: now,
                isActive: false,
              });
            } else {
              batch.update(groupDoc.ref, { currentCycleNumber: nextCycleNumber });
            }

            await batch.commit();
            triggered++;

            await writeGooiAuditLog(groupDoc.id, "PAYOUT_TRIGGERED", "SYSTEM", {
              entityType: "PAYOUT",
              entityId: payoutRef.id,
              metadata: { autoTriggered: true, payoutAmount },
            });
          } catch (err) {
            logger.error(`Auto-trigger error for group ${groupDoc.id} cycle ${cycleDoc.id}:`, err);
          }
        }
      }
    }

    logger.info(`autoTriggerGooiPayouts: ${triggered} payouts auto-triggered`);
  }
);

// ============================================================================
// 5. RETRY FAILED PAYOUTS
// ============================================================================

export const retryFailedGooiPayouts = onSchedule(
  {
    schedule: "*/15 * * * *", // Every 15 minutes
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    timeoutSeconds: 120,
    labels: GOOI_SCHEDULE_LABELS,
  },
  async () => {
    const config = await getGooiConfig();
    const now = admin.firestore.Timestamp.now();
    let retried = 0;

    // Paginate through ACTIVE groups
    let lastDoc: any;
    let hasMore = true;

    while (hasMore) {
      let query = db.collection(GooiCollections.GROUPS)
        .where("status", "==", "ACTIVE")
        .where("isDeleted", "==", false)
        .limit(500);

      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const groupsSnap = await query.get();
      if (groupsSnap.empty) break;
      lastDoc = groupsSnap.docs[groupsSnap.docs.length - 1];
      hasMore = groupsSnap.docs.length === 500;

      for (const groupDoc of groupsSnap.docs) {
        const payoutsSnap = await groupDoc.ref
          .collection(GooiCollections.PAYOUTS)
          .where("status", "==", "FAILED")
          .get();

        for (const payoutDoc of payoutsSnap.docs) {
          const payout = payoutDoc.data();

          if (payout.retryCount >= config.maxPayoutRetries) continue;

          // Exponential backoff: 5min, 15min, 60min
          const backoffMinutes = [5, 15, 60][payout.retryCount] || 60;
          const lastRetry = payout.lastRetryAt?.toMillis() || 0;
          if (now.toMillis() - lastRetry < backoffMinutes * 60 * 1000) continue;

          try {
            const payoutResult = await processGooiPayout(
              groupDoc.id, payout.cycleId, payout.recipientUserId, payout.totalPayoutAmount
            );

            if (payoutResult.success) {
              await payoutDoc.ref.update({
                status: "COMPLETED",
                journalId: payoutResult.journalId,
                completedAt: now,
                retryCount: admin.firestore.FieldValue.increment(1),
                lastRetryAt: now,
              });

              // Update cycle status too
              await groupDoc.ref.collection(GooiCollections.CYCLES).doc(payout.cycleId).update({
                status: "COMPLETE",
                completedAt: now,
              });

              await writeGooiAuditLog(groupDoc.id, "PAYOUT_RETRIED", "SYSTEM", {
                entityType: "PAYOUT",
                entityId: payoutDoc.id,
                afterState: { retryCount: payout.retryCount + 1, success: true },
              });

              retried++;
            } else {
              await payoutDoc.ref.update({
                retryCount: admin.firestore.FieldValue.increment(1),
                lastRetryAt: now,
              });
            }
          } catch (err) {
            logger.warn(`Payout retry failed for ${payoutDoc.id}:`, err);
            await payoutDoc.ref.update({
              retryCount: admin.firestore.FieldValue.increment(1),
              lastRetryAt: now,
            });
          }
        }
      }
    }

    logger.info(`retryFailedGooiPayouts: ${retried} payouts retried successfully`);
  }
);

// ============================================================================
// 6. EXPIRE DELEGATIONS
// ============================================================================

export const expireGooiDelegations = onSchedule(
  {
    schedule: "0 0 * * *", // Daily at midnight
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    timeoutSeconds: 120,
    labels: GOOI_SCHEDULE_LABELS,
  },
  async () => {
    const now = admin.firestore.Timestamp.now();
    let expired = 0;

    // Paginate through ACTIVE groups
    let lastDoc: any;
    let hasMore = true;

    while (hasMore) {
      let query = db.collection(GooiCollections.GROUPS)
        .where("status", "==", "ACTIVE")
        .where("isDeleted", "==", false)
        .limit(500);

      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const groupsSnap = await query.get();
      if (groupsSnap.empty) break;
      lastDoc = groupsSnap.docs[groupsSnap.docs.length - 1];
      hasMore = groupsSnap.docs.length === 500;

      for (const groupDoc of groupsSnap.docs) {
        const delegatesSnap = await groupDoc.ref
          .collection(GooiCollections.MEMBERS)
          .where("role", "==", "TRIGGER_DELEGATE")
          .where("isActive", "==", true)
          .get();

        for (const memberDoc of delegatesSnap.docs) {
          const member = memberDoc.data();
          if (member.delegationExpiresAt && member.delegationExpiresAt.toMillis() < now.toMillis()) {
            await memberDoc.ref.update({
              role: "MEMBER",
              delegationExpiresAt: null,
            });

            await writeGooiAuditLog(groupDoc.id, "DELEGATION_EXPIRED", "SYSTEM", {
              targetId: member.userId,
              entityType: "MEMBER",
              entityId: memberDoc.id,
            });

            expired++;
          }
        }
      }
    }

    logger.info(`expireGooiDelegations: ${expired} delegations expired`);
  }
);

// ============================================================================
// 7. EXPIRE INVITATIONS
// ============================================================================

export const expireGooiInvitations = onSchedule(
  {
    schedule: "0 0 * * *", // Daily at midnight
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    timeoutSeconds: 120,
    labels: GOOI_SCHEDULE_LABELS,
  },
  async () => {
    const config = await getGooiConfig();
    const now = admin.firestore.Timestamp.now();
    const expiryMs = config.invitationExpiryDays * 24 * 60 * 60 * 1000;
    let expired = 0;

    // Paginate through FORMING groups
    let lastDoc: any;
    let hasMore = true;

    while (hasMore) {
      let query = db.collection(GooiCollections.GROUPS)
        .where("status", "==", "FORMING")
        .where("isDeleted", "==", false)
        .limit(500);

      if (lastDoc) {
        query = query.startAfter(lastDoc);
      }

      const groupsSnap = await query.get();
      if (groupsSnap.empty) break;
      lastDoc = groupsSnap.docs[groupsSnap.docs.length - 1];
      hasMore = groupsSnap.docs.length === 500;

      for (const groupDoc of groupsSnap.docs) {
        const invitedSnap = await groupDoc.ref
          .collection(GooiCollections.MEMBERS)
          .where("status", "==", "INVITED")
          .get();

        for (const memberDoc of invitedSnap.docs) {
          const member = memberDoc.data();
          if (now.toMillis() - member.invitedAt.toMillis() > expiryMs) {
            await memberDoc.ref.update({
              status: "REMOVED",
              isActive: false,
              removedAt: now,
            });

            await groupDoc.ref.update({
              memberUserIds: admin.firestore.FieldValue.arrayRemove(member.userId),
              memberCount: admin.firestore.FieldValue.increment(-1),
            });

            expired++;
          }
        }
      }
    }

    logger.info(`expireGooiInvitations: ${expired} invitations expired`);
  }
);
