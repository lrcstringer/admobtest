/**
 * Gooi-Gooi Rotating Savings Cloud Functions
 *
 * All callable functions for the Gooi-Gooi feature.
 * Handles group lifecycle: creation, invitation, roster, activation,
 * contributions, payouts, delegation, grace extensions, late fees,
 * bidding, withdrawals, dissolution, and debt management.
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";
import {
  GooiCollections,
  GooiErrorCodes,
  getGooiConfig,
  validateContributionAmount,
  validateCycleFrequency,
  validateRosterMethod,
  validateTotalCycles,
  validateLateFeePercent,
  validateGracePeriodHours,
  requireInitiator,
  requireGroupStatus,
  getGooiMember,
  countActiveGooiGroups,
  hasOutstandingDebts,
  writeGooiAuditLog,
  calculateDueDate,
  seededShuffle,
  isAuthorizedToTrigger,
  GooiGroupStatus,
  GooiCycleFrequency,
  GooiRosterMethod,
} from "./helpers/gooiGooiHelpers";
import {
  processGooiContribution,
  processGooiReserve,
  processGooiPayout,
  processGooiReserveTopup,
  processGooiLateFee,
  processGooiBadDebtWriteoff,
  getOrCreateGooiGroupAccount,
} from "./ledger/gooiGooiEscrow";
import { validateMainWalletBalance } from "./ledger";

const db = admin.firestore();

const GOOI_LABELS = { area: "gooi-gooi" };

// ============================================================================
// CREATE GROUP
// ============================================================================

export const createGooiGroup = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "createGooiGroup");

    const userId = request.auth.uid;
    const {
      name, contributionAmount, cycleFrequency, totalCycles,
      rosterMethod, gracePeriodHours, lateFeePercent,
      recipientContributes,
    } = request.data;

    // Validate inputs
    if (!name || typeof name !== "string" || name.trim().length < 3 || name.trim().length > 50) {
      throw new HttpsError("invalid-argument", "Group name must be 3-50 characters");
    }

    const config = await getGooiConfig();

    validateContributionAmount(contributionAmount, config);
    validateCycleFrequency(cycleFrequency);
    validateRosterMethod(rosterMethod);
    validateTotalCycles(totalCycles, config);

    const gp = gracePeriodHours ?? 48;
    validateGracePeriodHours(gp);

    const lfp = lateFeePercent ?? 5;
    validateLateFeePercent(lfp, config);

    // Check active groups limit
    const activeCount = await countActiveGooiGroups(userId);
    if (activeCount >= config.maxActiveGroups) {
      throw new HttpsError("resource-exhausted", GooiErrorCodes.MAX_ACTIVE_GROUPS);
    }

    // Check outstanding debts
    if (await hasOutstandingDebts(userId)) {
      throw new HttpsError("failed-precondition", GooiErrorCodes.OUTSTANDING_DEBT);
    }

    const now = admin.firestore.Timestamp.now();
    const groupRef = db.collection(GooiCollections.GROUPS).doc();
    const groupId = groupRef.id;

    const groupData = {
      id: groupId,
      name: name.trim(),
      contributionAmount,
      cycleFrequency,
      memberCount: 1,
      totalCycles,
      currentCycleNumber: 0,
      status: "FORMING" as GooiGroupStatus,
      rosterMethod,
      reserveRate: 0.03,
      gracePeriodHours: gp,
      recipientContributes: recipientContributes ?? true,
      lateFeePercent: lfp,
      initiatorUserId: userId,
      conversationId: null,
      ledgerAccountId: null,
      potSubAccountId: null,
      reserveSubAccountId: null,
      rosterOrder: [],
      memberUserIds: [userId],
      createdAt: now,
      activatedAt: null,
      completedAt: null,
      biddingDiscountPool: 0,
      isActive: true,
      isDeleted: false,
    };

    const memberRef = groupRef.collection(GooiCollections.MEMBERS).doc();

    await db.runTransaction(async (t) => {
      const userDoc = await t.get(db.collection("users").doc(userId));
      const userData = userDoc.data() || {};

      t.set(groupRef, groupData);
      t.set(memberRef, {
        id: memberRef.id,
        userId,
        displayName: userData.displayName || "Unknown",
        avatarUrl: userData.avatarUrl || null,
        position: 0,
        role: "INITIATOR",
        status: "ACCEPTED",
        contributedCycles: 0,
        missedCycles: 0,
        outstandingDebt: 0,
        autoContribute: false,
        autoContributeSubAccountId: null,
        preferredSubAccountId: null,
        delegateTriggerTo: null,
        delegationExpiresAt: null,
        joinedAt: now,
        invitedAt: now,
        removedAt: null,
        isActive: true,
      });
    });

    await writeGooiAuditLog(groupId, "GROUP_CREATED", userId, {
      afterState: { name: name.trim(), contributionAmount, cycleFrequency, totalCycles, rosterMethod },
    });

    logger.info(`Gooi-Gooi group ${groupId} created by ${userId}`);
    return { success: true, groupId };
  }
);

// ============================================================================
// INVITE MEMBER
// ============================================================================

export const inviteGooiMember = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "inviteGooiMember");

    const userId = request.auth.uid;
    const { groupId, inviteeUserId } = request.data;

    if (!groupId || !inviteeUserId) throw new HttpsError("invalid-argument", "groupId and inviteeUserId required");
    if (userId === inviteeUserId) throw new HttpsError("invalid-argument", "Cannot invite yourself");

    const groupDoc = await requireInitiator(groupId, userId);
    const group = groupDoc.data()!;
    requireGroupStatus(group, "FORMING");

    const config = await getGooiConfig();
    if (group.memberCount >= config.maxGroupSize) {
      throw new HttpsError("resource-exhausted", GooiErrorCodes.GROUP_FULL);
    }

    // Check if already a member
    const existing = await getGooiMember(groupId, inviteeUserId);
    if (existing) throw new HttpsError("already-exists", GooiErrorCodes.ALREADY_MEMBER);

    // Check invitee's active group count
    const inviteeActiveCount = await countActiveGooiGroups(inviteeUserId);
    if (inviteeActiveCount >= config.maxActiveGroups) {
      throw new HttpsError("resource-exhausted", "Invitee has reached maximum active groups");
    }

    // Check invitee debts
    if (await hasOutstandingDebts(inviteeUserId)) {
      throw new HttpsError("failed-precondition", "Invitee has outstanding Gooi-Gooi debts");
    }

    const now = admin.firestore.Timestamp.now();
    const memberRef = db.collection(GooiCollections.GROUPS).doc(groupId).collection(GooiCollections.MEMBERS).doc();
    const groupRef = db.collection(GooiCollections.GROUPS).doc(groupId);

    await db.runTransaction(async (t) => {
      const inviteeDoc = await t.get(db.collection("users").doc(inviteeUserId));
      const inviteeData = inviteeDoc.data() || {};
      const freshGroupDoc = await t.get(groupRef);
      const freshGroup = freshGroupDoc.data()!;

      t.set(memberRef, {
        id: memberRef.id,
        userId: inviteeUserId,
        displayName: inviteeData.displayName || "Unknown",
        avatarUrl: inviteeData.avatarUrl || null,
        position: 0,
        role: "MEMBER",
        status: "INVITED",
        contributedCycles: 0,
        missedCycles: 0,
        outstandingDebt: 0,
        autoContribute: false,
        autoContributeSubAccountId: null,
        preferredSubAccountId: null,
        delegateTriggerTo: null,
        delegationExpiresAt: null,
        joinedAt: null,
        invitedAt: now,
        removedAt: null,
        isActive: true,
      });
      t.update(groupRef, {
        memberCount: freshGroup.memberCount + 1,
        memberUserIds: [...freshGroup.memberUserIds, inviteeUserId],
      });
    });

    await writeGooiAuditLog(groupId, "MEMBER_INVITED", userId, {
      targetId: inviteeUserId,
      entityType: "MEMBER",
      entityId: memberRef.id,
    });

    return { success: true, memberId: memberRef.id };
  }
);

// ============================================================================
// RESPOND TO INVITATION
// ============================================================================

export const respondGooiInvitation = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "respondGooiInvitation");

    const userId = request.auth.uid;
    const { groupId, accept } = request.data;

    if (!groupId || typeof accept !== "boolean") throw new HttpsError("invalid-argument", "groupId and accept required");

    const groupDoc = await db.collection(GooiCollections.GROUPS).doc(groupId).get();
    if (!groupDoc.exists) throw new HttpsError("not-found", GooiErrorCodes.GROUP_NOT_FOUND);
    requireGroupStatus(groupDoc.data()!, "FORMING");

    // Find invitation
    const membersSnap = await db
      .collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.MEMBERS)
      .where("userId", "==", userId)
      .where("status", "==", "INVITED")
      .limit(1)
      .get();

    if (membersSnap.empty) throw new HttpsError("not-found", GooiErrorCodes.INVITATION_NOT_FOUND);

    const memberDoc = membersSnap.docs[0];
    const memberData = memberDoc.data();
    const config = await getGooiConfig();
    const now = admin.firestore.Timestamp.now();

    // Check expiry
    const expiryMs = memberData.invitedAt.toMillis() + config.invitationExpiryDays * 24 * 60 * 60 * 1000;
    if (now.toMillis() > expiryMs) {
      throw new HttpsError("deadline-exceeded", GooiErrorCodes.INVITATION_EXPIRED);
    }

    if (accept) {
      await memberDoc.ref.update({ status: "ACCEPTED", joinedAt: now });
      await writeGooiAuditLog(groupId, "MEMBER_ACCEPTED", userId, { entityType: "MEMBER", entityId: memberDoc.id });
    } else {
      await memberDoc.ref.update({ status: "REMOVED", isActive: false, removedAt: now });
      await db.collection(GooiCollections.GROUPS).doc(groupId).update({
        memberCount: admin.firestore.FieldValue.increment(-1),
        memberUserIds: admin.firestore.FieldValue.arrayRemove(userId),
      });
      await writeGooiAuditLog(groupId, "MEMBER_DECLINED", userId, { entityType: "MEMBER", entityId: memberDoc.id });
    }

    return { success: true };
  }
);

// ============================================================================
// LOCK ROSTER
// ============================================================================

export const lockGooiRoster = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "lockGooiRoster");

    const userId = request.auth.uid;
    const { groupId, proposedOrder } = request.data;

    const groupDoc = await requireInitiator(groupId, userId);
    const group = groupDoc.data()!;
    requireGroupStatus(group, "FORMING");

    if (group.rosterOrder && group.rosterOrder.length > 0) {
      throw new HttpsError("failed-precondition", GooiErrorCodes.ROSTER_ALREADY_LOCKED);
    }

    // Get accepted members
    const membersSnap = await db
      .collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.MEMBERS)
      .where("status", "in", ["ACCEPTED"])
      .get();

    if (membersSnap.size < 2) {
      throw new HttpsError("failed-precondition", GooiErrorCodes.NOT_ENOUGH_MEMBERS);
    }

    const memberUserIds = membersSnap.docs.map(d => d.data().userId);
    let rosterOrder: string[];

    switch (group.rosterMethod as GooiRosterMethod) {
      case "AGREED":
        // Initiator provides the order via proposedOrder
        if (!proposedOrder || !Array.isArray(proposedOrder)) {
          throw new HttpsError("invalid-argument", "proposedOrder required for AGREED roster method");
        }
        // Validate all members are in the proposed order
        const proposedSet = new Set(proposedOrder);
        for (const uid of memberUserIds) {
          if (!proposedSet.has(uid)) throw new HttpsError("invalid-argument", `Member ${uid} missing from proposed order`);
        }
        if (proposedOrder.length !== memberUserIds.length) {
          throw new HttpsError("invalid-argument", "proposedOrder must contain exactly all accepted members");
        }
        rosterOrder = proposedOrder;
        break;

      case "RANDOM":
        rosterOrder = seededShuffle(memberUserIds, groupId);
        break;

      case "BIDDING":
        // For bidding, positions are assigned after the bidding phase.
        // Lock roster with placeholder order (will be finalized after bidding).
        rosterOrder = memberUserIds; // temporary order
        break;

      default:
        throw new HttpsError("invalid-argument", "Invalid roster method");
    }

    await db.runTransaction(async (t) => {
      for (let i = 0; i < rosterOrder.length; i++) {
        const memberDoc = membersSnap.docs.find(d => d.data().userId === rosterOrder[i]);
        if (memberDoc) {
          t.update(memberDoc.ref, { position: i + 1 });
        }
      }
      t.update(db.collection(GooiCollections.GROUPS).doc(groupId), {
        rosterOrder,
      });
    });

    await writeGooiAuditLog(groupId, "ROSTER_LOCKED", userId, {
      afterState: { rosterOrder, method: group.rosterMethod },
    });

    return { success: true, rosterOrder };
  }
);

// ============================================================================
// SUBMIT BID (BIDDING roster only)
// ============================================================================

export const submitGooiBid = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "submitGooiBid");

    const userId = request.auth.uid;
    const { groupId, targetPosition, bidPercent } = request.data;

    const groupDoc = await db.collection(GooiCollections.GROUPS).doc(groupId).get();
    if (!groupDoc.exists) throw new HttpsError("not-found", GooiErrorCodes.GROUP_NOT_FOUND);
    const group = groupDoc.data()!;

    if (group.rosterMethod !== "BIDDING") {
      throw new HttpsError("failed-precondition", GooiErrorCodes.NOT_BIDDING_GROUP);
    }
    requireGroupStatus(group, "FORMING");

    const config = await getGooiConfig();
    if (typeof bidPercent !== "number" || bidPercent < config.minBidPercent || bidPercent > 100) {
      throw new HttpsError("invalid-argument", `Bid must be between ${config.minBidPercent}% and 100%`);
    }
    if (typeof targetPosition !== "number" || targetPosition < 1 || targetPosition > group.memberCount) {
      throw new HttpsError("invalid-argument", "Invalid target position");
    }

    const member = await getGooiMember(groupId, userId);
    if (!member) throw new HttpsError("permission-denied", GooiErrorCodes.NOT_MEMBER);

    const fullPot = group.contributionAmount * group.memberCount;
    const bidAmount = Math.floor(fullPot * bidPercent / 100);

    const now = admin.firestore.Timestamp.now();
    const bidRef = db.collection(GooiCollections.GROUPS).doc(groupId).collection(GooiCollections.BIDS).doc();

    await bidRef.set({
      id: bidRef.id,
      memberId: member.id,
      userId,
      targetPosition,
      bidAmount,
      bidPercent,
      status: "ACTIVE",
      createdAt: now,
      resolvedAt: null,
    });

    await writeGooiAuditLog(groupId, "BID_SUBMITTED", userId, {
      entityType: "BID",
      entityId: bidRef.id,
      afterState: { targetPosition, bidPercent, bidAmount },
    });

    return { success: true, bidId: bidRef.id };
  }
);

// ============================================================================
// FINALIZE BIDDING
// ============================================================================

export const finalizeBidding = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "finalizeBidding");

    const userId = request.auth.uid;
    const { groupId } = request.data;

    const groupDoc = await requireInitiator(groupId, userId);
    const group = groupDoc.data()!;
    requireGroupStatus(group, "FORMING");

    if (group.rosterMethod !== "BIDDING") {
      throw new HttpsError("failed-precondition", GooiErrorCodes.NOT_BIDDING_GROUP);
    }

    // Get all active bids
    const bidsSnap = await db
      .collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.BIDS)
      .where("status", "==", "ACTIVE")
      .get();

    // Get all accepted members
    const membersSnap = await db
      .collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.MEMBERS)
      .where("status", "in", ["ACCEPTED"])
      .get();

    const memberUserIds = membersSnap.docs.map(d => d.data().userId);

    const sortedBids = bidsSnap.docs
      .map(d => {
        const data = d.data();
        return {
          ref: d.ref,
          userId: data.userId as string,
          bidAmount: data.bidAmount as number,
          targetPosition: data.targetPosition as number,
          bidPercent: data.bidPercent as number,
          createdAt: data.createdAt as FirebaseFirestore.Timestamp,
        };
      })
      .sort((a, b) => {
        if (a.bidPercent !== b.bidPercent) return a.bidPercent - b.bidPercent;
        return a.createdAt.toMillis() - b.createdAt.toMillis();
      });

    const assignedPositions = new Map<number, string>();
    const assignedUsers = new Set<string>();
    let totalDiscount = 0;
    const fullPot = group.contributionAmount * memberUserIds.length;

    const bidUpdates: { ref: FirebaseFirestore.DocumentReference; status: string }[] = [];

    for (const bid of sortedBids) {
      if (assignedPositions.has(bid.targetPosition) || assignedUsers.has(bid.userId)) {
        bidUpdates.push({ ref: bid.ref, status: "OUTBID" });
        continue;
      }
      assignedPositions.set(bid.targetPosition, bid.userId);
      assignedUsers.add(bid.userId);
      totalDiscount += (fullPot - bid.bidAmount);
      bidUpdates.push({ ref: bid.ref, status: "WON" });
    }

    let nextPosition = 1;
    for (const uid of memberUserIds) {
      if (assignedUsers.has(uid)) continue;
      while (assignedPositions.has(nextPosition)) nextPosition++;
      assignedPositions.set(nextPosition, uid);
      nextPosition++;
    }

    const rosterOrder: string[] = [];
    for (let i = 1; i <= memberUserIds.length; i++) {
      rosterOrder.push(assignedPositions.get(i)!);
    }

    await db.runTransaction(async (t) => {
      for (const { ref, status } of bidUpdates) {
        t.update(ref, { status, resolvedAt: admin.firestore.Timestamp.now() });
      }

      for (const memberDoc of membersSnap.docs) {
        const uid = memberDoc.data().userId;
        const pos = rosterOrder.indexOf(uid) + 1;
        t.update(memberDoc.ref, { position: pos });
      }

      t.update(db.collection(GooiCollections.GROUPS).doc(groupId), {
        rosterOrder,
        biddingDiscountPool: totalDiscount,
      });
    });

    await writeGooiAuditLog(groupId, "BIDDING_FINALIZED", userId, {
      afterState: { rosterOrder, totalDiscount },
    });

    return { success: true, rosterOrder, totalDiscount };
  }
);

// ============================================================================
// CONFIRM ACTIVATION
// ============================================================================

export const confirmGooiActivation = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "confirmGooiActivation");

    const userId = request.auth.uid;
    const { groupId } = request.data;

    const groupDoc = await db.collection(GooiCollections.GROUPS).doc(groupId).get();
    if (!groupDoc.exists) throw new HttpsError("not-found", GooiErrorCodes.GROUP_NOT_FOUND);
    const group = groupDoc.data()!;
    requireGroupStatus(group, "FORMING");

    if (!group.rosterOrder || group.rosterOrder.length === 0) {
      throw new HttpsError("failed-precondition", "Roster must be locked before activation");
    }

    // Find member and mark as confirmed
    const membersSnap = await db
      .collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.MEMBERS)
      .where("userId", "==", userId)
      .where("status", "==", "ACCEPTED")
      .limit(1)
      .get();

    if (membersSnap.empty) throw new HttpsError("permission-denied", GooiErrorCodes.NOT_MEMBER);

    const memberDoc = membersSnap.docs[0];

    const allMembersSnap = await db
      .collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.MEMBERS)
      .where("isActive", "==", true)
      .get();

    const willAllBeActive = allMembersSnap.docs.every(d =>
      d.id === memberDoc.id ? true : d.data().status === "ACTIVE"
    );

    if (willAllBeActive) {
      const now = admin.firestore.Timestamp.now();

      const ledgerAccount = await getOrCreateGooiGroupAccount(groupId);

      const cycleRef = db.collection(GooiCollections.GROUPS).doc(groupId)
        .collection(GooiCollections.CYCLES).doc();

      const dueDate = calculateDueDate(now.toDate(), 1, group.cycleFrequency as GooiCycleFrequency);
      const graceCloseDate = new Date(dueDate.getTime() + group.gracePeriodHours * 60 * 60 * 1000);
      const autoTriggerDate = new Date(graceCloseDate.getTime() + 72 * 60 * 60 * 1000);

      const activeMemberCount = allMembersSnap.size;
      const totalExpected = group.recipientContributes
        ? group.contributionAmount * activeMemberCount
        : group.contributionAmount * (activeMemberCount - 1);

      await db.runTransaction(async (t) => {
        t.update(memberDoc.ref, { status: "ACTIVE" });

        t.update(db.collection(GooiCollections.GROUPS).doc(groupId), {
          status: "ACTIVE",
          activatedAt: now,
          currentCycleNumber: 1,
          ledgerAccountId: ledgerAccount.accountId,
          potSubAccountId: ledgerAccount.potSubAccountId,
          reserveSubAccountId: ledgerAccount.reserveSubAccountId,
        });

        t.set(cycleRef, {
          id: cycleRef.id,
          cycleNumber: 1,
          rotationNumber: 1,
          recipientMemberId: allMembersSnap.docs.find(d => d.data().position === 1)?.id || null,
          recipientUserId: group.rosterOrder[0],
          dueDate: admin.firestore.Timestamp.fromDate(dueDate),
          graceCloseDate: admin.firestore.Timestamp.fromDate(graceCloseDate),
          status: "PENDING",
          totalExpected,
          totalCollected: 0,
          reserveCollected: 0,
          payoutAmount: 0,
          shortfallAmount: 0,
          defaulterMemberIds: [],
          triggeredBy: null,
          triggeredAt: null,
          completedAt: null,
          autoTriggerAt: admin.firestore.Timestamp.fromDate(autoTriggerDate),
          graceExtendedBy: 0,
          graceExtensionVoteId: null,
          graceExtendedAt: null,
        });

        for (const mDoc of allMembersSnap.docs) {
          const mData = mDoc.data();
          const isRecipient = mData.userId === group.rosterOrder[0];
          if (!group.recipientContributes && isRecipient) continue;

          const contribRef = db.collection(GooiCollections.GROUPS).doc(groupId)
            .collection(GooiCollections.CONTRIBUTIONS).doc();

          t.set(contribRef, {
            id: contribRef.id,
            cycleId: cycleRef.id,
            cycleNumber: 1,
            memberId: mDoc.id,
            userId: mData.userId,
            amountBase: group.contributionAmount,
            amountReserve: Math.floor(group.contributionAmount * group.reserveRate),
            amountTotal: group.contributionAmount + Math.floor(group.contributionAmount * group.reserveRate),
            lateFee: 0,
            status: "PENDING",
            journalId: null,
            paidAt: null,
            createdAt: now,
          });
        }
      });

      await writeGooiAuditLog(groupId, "GROUP_ACTIVATED", "SYSTEM", {
        afterState: { memberCount: activeMemberCount, firstRecipient: group.rosterOrder[0] },
      });

      return { success: true, activated: true, cycleId: cycleRef.id };
    }

    await db.runTransaction(async (t) => {
      t.update(memberDoc.ref, { status: "ACTIVE" });
    });

    return { success: true, activated: false };
  }
);

// ============================================================================
// CONTRIBUTE TO CYCLE
// ============================================================================

export const contributeGooiCycle = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "contributeGooiCycle");

    const userId = request.auth.uid;
    const { groupId, cycleId, subAccountId: _subAccountId } = request.data;

    const groupDoc = await db.collection(GooiCollections.GROUPS).doc(groupId).get();
    if (!groupDoc.exists) throw new HttpsError("not-found", GooiErrorCodes.GROUP_NOT_FOUND);
    const group = groupDoc.data()!;
    requireGroupStatus(group, "ACTIVE");

    // Find member
    const member = await getGooiMember(groupId, userId);
    if (!member) throw new HttpsError("permission-denied", GooiErrorCodes.NOT_MEMBER);
    if (member.data().status === "SUSPENDED") {
      throw new HttpsError("failed-precondition", GooiErrorCodes.MEMBER_SUSPENDED);
    }

    // Find cycle
    const cycleDoc = await db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.CYCLES).doc(cycleId).get();
    if (!cycleDoc.exists) throw new HttpsError("not-found", "Cycle not found");
    const cycle = cycleDoc.data()!;

    if (cycle.status !== "COLLECTING" && cycle.status !== "PENDING") {
      throw new HttpsError("failed-precondition", GooiErrorCodes.CYCLE_NOT_COLLECTING);
    }

    // Find contribution record
    const contribSnap = await db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.CONTRIBUTIONS)
      .where("cycleId", "==", cycleId)
      .where("userId", "==", userId)
      .where("status", "in", ["PENDING", "LATE"])
      .limit(1)
      .get();

    if (contribSnap.empty) throw new HttpsError("failed-precondition", GooiErrorCodes.ALREADY_CONTRIBUTED);

    const contribDoc = contribSnap.docs[0];
    const contrib = contribDoc.data();
    const baseAmount = contrib.amountBase;
    const reserveAmount = contrib.amountReserve;
    const totalAmount = contrib.amountTotal;

    // Validate balance
    const balanceCheck = await validateMainWalletBalance(userId, totalAmount);
    if (!balanceCheck.sufficient) {
      throw new HttpsError("failed-precondition", GooiErrorCodes.INSUFFICIENT_BALANCE);
    }

    // Process base contribution
    const baseResult = await processGooiContribution(userId, groupId, cycleId, baseAmount);
    if (!baseResult.success) {
      throw new HttpsError("internal", baseResult.error || "Contribution failed");
    }

    // Process reserve split — must succeed for contribution to be valid
    const reserveResult = await processGooiReserve(userId, groupId, cycleId, reserveAmount);
    if (!reserveResult.success) {
      logger.error(`Reserve split failed for ${userId} in group ${groupId}:`, reserveResult.error);
      // TODO: Reverse the base contribution via a reversal journal entry.
      // For now, fail the entire contribution so we don't mark PAID without reserve.
      throw new HttpsError("internal", "Reserve split failed — contribution not recorded. Please retry.");
    }

    const now = admin.firestore.Timestamp.now();

    await db.runTransaction(async (t) => {
      const freshCycleDoc = await t.get(cycleDoc.ref);
      const freshCycle = freshCycleDoc.data()!;
      const freshMemberDoc = await t.get(member.ref);
      const freshMember = freshMemberDoc.data()!;

      t.update(contribDoc.ref, {
        status: "PAID",
        journalId: baseResult.journalId,
        paidAt: now,
      });

      t.update(cycleDoc.ref, {
        totalCollected: freshCycle.totalCollected + baseAmount,
        reserveCollected: freshCycle.reserveCollected + reserveAmount,
      });

      t.update(member.ref, {
        contributedCycles: freshMember.contributedCycles + 1,
      });
    });

    await writeGooiAuditLog(groupId, "CONTRIBUTION_PAID", userId, {
      entityType: "CONTRIBUTION",
      entityId: contribDoc.id,
      afterState: { baseAmount, reserveAmount, totalAmount },
    });

    return { success: true, journalId: baseResult.journalId };
  }
);

// ============================================================================
// TOGGLE AUTO-CONTRIBUTE
// ============================================================================

export const toggleAutoContribute = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "toggleAutoContribute");

    const userId = request.auth.uid;
    const { groupId, enabled, walletSubAccountId } = request.data;

    const db = admin.firestore();
    await db.runTransaction(async (t) => {
      const memberSnap = await t.get(
        db.collection("gooiGroups").doc(groupId).collection("members")
          .where("userId", "==", userId).where("isActive", "==", true).limit(1)
      );
      if (memberSnap.empty) throw new HttpsError("permission-denied", GooiErrorCodes.NOT_MEMBER);

      const memberRef = memberSnap.docs[0].ref;
      t.update(memberRef, {
        autoContribute: !!enabled,
        autoContributeSubAccountId: walletSubAccountId || null,
      });
    });

    await writeGooiAuditLog(groupId, "AUTO_CONTRIBUTE_TOGGLED", userId, {
      entityType: "MEMBER",
      entityId: userId,
      afterState: { autoContribute: !!enabled, walletSubAccountId },
    });

    return { success: true };
  }
);

// ============================================================================
// TRIGGER PAYOUT
// ============================================================================

export const triggerGooiPayout = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "triggerGooiPayout");

    const userId = request.auth.uid;
    const { groupId, cycleId } = request.data;

    // Check authorization (Initiator or delegate)
    const authorized = await isAuthorizedToTrigger(groupId, userId);
    if (!authorized) throw new HttpsError("permission-denied", GooiErrorCodes.NOT_AUTHORIZED_TO_TRIGGER);

    const groupDoc = await db.collection(GooiCollections.GROUPS).doc(groupId).get();
    if (!groupDoc.exists) throw new HttpsError("not-found", GooiErrorCodes.GROUP_NOT_FOUND);
    const group = groupDoc.data()!;
    requireGroupStatus(group, "ACTIVE");

    const cycleDoc = await db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.CYCLES).doc(cycleId).get();
    if (!cycleDoc.exists) throw new HttpsError("not-found", "Cycle not found");
    const cycle = cycleDoc.data()!;

    if (cycle.status !== "AWAITING_TRIGGER") {
      throw new HttpsError("failed-precondition", GooiErrorCodes.CYCLE_NOT_AWAITING_TRIGGER);
    }

    const now = admin.firestore.Timestamp.now();
    let payoutAmount = cycle.totalCollected;
    let shortfall = cycle.totalExpected - cycle.totalCollected;

    // Cover shortfall from reserve if needed
    if (shortfall > 0) {
      const topupResult = await processGooiReserveTopup(groupId, cycleId, shortfall);
      if (topupResult.success) {
        payoutAmount += shortfall;
        shortfall = 0;
      } else {
        // Partial coverage — payout what we have
        logger.warn(`Could not fully cover shortfall for group ${groupId} cycle ${cycleId}`);
      }
    }

    // Process payout
    const payoutResult = await processGooiPayout(groupId, cycleId, cycle.recipientUserId, payoutAmount);
    if (!payoutResult.success) {
      await cycleDoc.ref.update({ status: "PAYOUT_FAILED" });
      throw new HttpsError("internal", payoutResult.error || "Payout failed");
    }

    const payoutRef = db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.PAYOUTS).doc();

    const nextCycleNumber = cycle.cycleNumber + 1;
    const groupRef = db.collection(GooiCollections.GROUPS).doc(groupId);

    await db.runTransaction(async (t) => {
      const freshCycleDoc = await t.get(cycleDoc.ref);
      const freshCycle = freshCycleDoc.data()!;

      t.set(payoutRef, {
        id: payoutRef.id,
        cycleId,
        cycleNumber: freshCycle.cycleNumber,
        recipientMemberId: freshCycle.recipientMemberId,
        recipientUserId: freshCycle.recipientUserId,
        amountFromContributions: freshCycle.totalCollected,
        amountFromReserve: payoutAmount - freshCycle.totalCollected,
        totalPayoutAmount: payoutAmount,
        shortfallAmount: shortfall,
        status: "COMPLETED",
        retryCount: 0,
        lastRetryAt: null,
        journalId: payoutResult.journalId,
        triggeredBy: userId,
        triggeredAt: now,
        completedAt: now,
        defaulterMemberIds: freshCycle.defaulterMemberIds || [],
      });

      t.update(cycleDoc.ref, {
        status: "COMPLETE",
        payoutAmount,
        shortfallAmount: shortfall,
        triggeredBy: userId,
        triggeredAt: now,
        completedAt: now,
      });

      if (nextCycleNumber <= group.totalCycles) {
        const nextRecipientUserId = group.rosterOrder[nextCycleNumber - 1] || group.rosterOrder[0];
        const membersQuery = db.collection(GooiCollections.GROUPS).doc(groupId)
          .collection(GooiCollections.MEMBERS)
          .where("isActive", "==", true);
        const membersSnap = await t.get(membersQuery);
        const nextRecipientMember = membersSnap.docs.find(d => d.data().userId === nextRecipientUserId);

        const dueDate = calculateDueDate(group.activatedAt.toDate(), nextCycleNumber, group.cycleFrequency as GooiCycleFrequency);
        const graceCloseDate = new Date(dueDate.getTime() + group.gracePeriodHours * 60 * 60 * 1000);
        const autoTriggerDate = new Date(graceCloseDate.getTime() + 72 * 60 * 60 * 1000);

        const activeMemberCount = membersSnap.size;
        const totalExpected = group.recipientContributes
          ? group.contributionAmount * activeMemberCount
          : group.contributionAmount * (activeMemberCount - 1);

        const nextCycleRef = db.collection(GooiCollections.GROUPS).doc(groupId)
          .collection(GooiCollections.CYCLES).doc();

        t.set(nextCycleRef, {
          id: nextCycleRef.id,
          cycleNumber: nextCycleNumber,
          rotationNumber: Math.ceil(nextCycleNumber / activeMemberCount),
          recipientMemberId: nextRecipientMember?.id || null,
          recipientUserId: nextRecipientUserId,
          dueDate: admin.firestore.Timestamp.fromDate(dueDate),
          graceCloseDate: admin.firestore.Timestamp.fromDate(graceCloseDate),
          status: "PENDING",
          totalExpected,
          totalCollected: 0,
          reserveCollected: 0,
          payoutAmount: 0,
          shortfallAmount: 0,
          defaulterMemberIds: [],
          triggeredBy: null,
          triggeredAt: null,
          completedAt: null,
          autoTriggerAt: admin.firestore.Timestamp.fromDate(autoTriggerDate),
          graceExtendedBy: 0,
          graceExtensionVoteId: null,
          graceExtendedAt: null,
        });

        for (const mDoc of membersSnap.docs) {
          const mData = mDoc.data();
          const isRecipient = mData.userId === nextRecipientUserId;
          if (!group.recipientContributes && isRecipient) continue;

          const contribRef = db.collection(GooiCollections.GROUPS).doc(groupId)
            .collection(GooiCollections.CONTRIBUTIONS).doc();
          t.set(contribRef, {
            id: contribRef.id,
            cycleId: nextCycleRef.id,
            cycleNumber: nextCycleNumber,
            memberId: mDoc.id,
            userId: mData.userId,
            amountBase: group.contributionAmount,
            amountReserve: Math.floor(group.contributionAmount * group.reserveRate),
            amountTotal: group.contributionAmount + Math.floor(group.contributionAmount * group.reserveRate),
            lateFee: 0,
            status: "PENDING",
            journalId: null,
            paidAt: null,
            createdAt: now,
          });
        }

        t.update(groupRef, {
          currentCycleNumber: nextCycleNumber,
        });
      } else {
        t.update(groupRef, {
          status: "COMPLETED",
          completedAt: now,
          isActive: false,
        });
      }
    });

    await writeGooiAuditLog(groupId, "PAYOUT_TRIGGERED", userId, {
      entityType: "PAYOUT",
      entityId: payoutRef.id,
      afterState: { payoutAmount, recipientUserId: cycle.recipientUserId, cycleNumber: cycle.cycleNumber },
    });

    return { success: true, payoutAmount, payoutId: payoutRef.id };
  }
);

// ============================================================================
// DELEGATE TRIGGER
// ============================================================================

export const delegateGooiTrigger = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "delegateGooiTrigger");

    const userId = request.auth.uid;
    const { groupId, delegateUserId, durationDays } = request.data;

    if (userId === delegateUserId) throw new HttpsError("invalid-argument", GooiErrorCodes.CANNOT_DELEGATE_TO_SELF);

    await requireInitiator(groupId, userId);

    const config = await getGooiConfig();
    const days = durationDays || 7;
    if (days > config.maxDelegationDays) {
      throw new HttpsError("invalid-argument", GooiErrorCodes.DELEGATION_TOO_LONG);
    }

    const delegateMember = await getGooiMember(groupId, delegateUserId);
    if (!delegateMember) throw new HttpsError("not-found", GooiErrorCodes.MEMBER_NOT_FOUND);

    const expiresAt = new Date(Date.now() + days * 24 * 60 * 60 * 1000);

    await delegateMember.ref.update({
      role: "TRIGGER_DELEGATE",
      delegationExpiresAt: admin.firestore.Timestamp.fromDate(expiresAt),
    });

    await writeGooiAuditLog(groupId, "DELEGATION_GRANTED", userId, {
      targetId: delegateUserId,
      entityType: "MEMBER",
      entityId: delegateMember.id,
      afterState: { delegateUserId, durationDays: days, expiresAt: expiresAt.toISOString() },
    });

    return { success: true, expiresAt: expiresAt.toISOString() };
  }
);

// ============================================================================
// REVOKE DELEGATION
// ============================================================================

export const revokeGooiDelegation = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "revokeGooiDelegation");

    const userId = request.auth.uid;
    const { groupId } = request.data;

    await requireInitiator(groupId, userId);

    // Find active delegate
    const delegateSnap = await db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.MEMBERS)
      .where("role", "==", "TRIGGER_DELEGATE")
      .where("isActive", "==", true)
      .limit(1)
      .get();

    if (delegateSnap.empty) throw new HttpsError("not-found", GooiErrorCodes.NO_ACTIVE_DELEGATION);

    const delegateDoc = delegateSnap.docs[0];
    await delegateDoc.ref.update({
      role: "MEMBER",
      delegationExpiresAt: null,
    });

    await writeGooiAuditLog(groupId, "DELEGATION_REVOKED", userId, {
      targetId: delegateDoc.data().userId,
      entityType: "MEMBER",
      entityId: delegateDoc.id,
    });

    return { success: true };
  }
);

// ============================================================================
// EXTEND GRACE PERIOD
// ============================================================================

export const extendGooiGracePeriod = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "extendGooiGracePeriod");

    const userId = request.auth.uid;
    const { groupId, cycleId, extensionHours } = request.data;

    const groupDoc = await requireInitiator(groupId, userId);
    const group = groupDoc.data()!;
    requireGroupStatus(group, "ACTIVE");

    const cycleDoc = await db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.CYCLES).doc(cycleId).get();
    if (!cycleDoc.exists) throw new HttpsError("not-found", "Cycle not found");
    const cycle = cycleDoc.data()!;

    if (cycle.status !== "COLLECTING") {
      throw new HttpsError("failed-precondition", "Cycle must be in COLLECTING status");
    }

    const config = await getGooiConfig();
    const currentExtension = cycle.graceExtendedBy || 0;

    if (extensionHours <= config.maxUnilateralExtensionHours && currentExtension === 0) {
      // Unilateral extension (up to 24h, first time only)
      const newGraceClose = new Date(cycle.graceCloseDate.toMillis() + extensionHours * 60 * 60 * 1000);
      const newAutoTrigger = new Date(newGraceClose.getTime() + config.autoTriggerHours * 60 * 60 * 1000);

      await cycleDoc.ref.update({
        graceCloseDate: admin.firestore.Timestamp.fromDate(newGraceClose),
        autoTriggerAt: admin.firestore.Timestamp.fromDate(newAutoTrigger),
        graceExtendedBy: currentExtension + extensionHours,
        graceExtendedAt: admin.firestore.Timestamp.now(),
      });

      await writeGooiAuditLog(groupId, "GRACE_EXTENDED_UNILATERAL", userId, {
        entityType: "CYCLE",
        entityId: cycleId,
        afterState: { extensionHours, totalExtension: currentExtension + extensionHours },
      });

      return { success: true, type: "unilateral", newGraceClose: newGraceClose.toISOString() };
    }

    // Need a vote for further extension
    const maxTotal = config.maxUnilateralExtensionHours + config.maxVotedExtensionHours;
    if (currentExtension + extensionHours > maxTotal) {
      throw new HttpsError("failed-precondition", GooiErrorCodes.MAX_EXTENSION_REACHED);
    }

    if (cycle.graceExtensionVoteId) {
      throw new HttpsError("failed-precondition", GooiErrorCodes.VOTE_ALREADY_ACTIVE);
    }

    // Create a vote doc on the cycle
    const voteId = `vote_${cycleId}_${Date.now()}`;
    const voteExpiry = new Date(Date.now() + config.graceExtensionVoteWindowHours * 60 * 60 * 1000);

    await cycleDoc.ref.update({
      graceExtensionVoteId: voteId,
      [`graceVote_${voteId}`]: {
        extensionHours,
        initiatedBy: userId,
        yesVotes: [userId],
        noVotes: [],
        expiresAt: admin.firestore.Timestamp.fromDate(voteExpiry),
        status: "ACTIVE",
      },
    });

    await writeGooiAuditLog(groupId, "GRACE_EXTENSION_VOTE_STARTED", userId, {
      entityType: "CYCLE",
      entityId: cycleId,
      afterState: { voteId, extensionHours, expiresAt: voteExpiry.toISOString() },
    });

    return { success: true, type: "vote_started", voteId };
  }
);

// ============================================================================
// VOTE ON GRACE EXTENSION
// ============================================================================

export const voteGooiGraceExtension = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "voteGooiGraceExtension");

    const userId = request.auth.uid;
    const { groupId, cycleId, voteId, approve } = request.data;

    const member = await getGooiMember(groupId, userId);
    if (!member) throw new HttpsError("permission-denied", GooiErrorCodes.NOT_MEMBER);

    const cycleDoc = await db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.CYCLES).doc(cycleId).get();
    if (!cycleDoc.exists) throw new HttpsError("not-found", "Cycle not found");
    const cycle = cycleDoc.data()!;

    const voteData = cycle[`graceVote_${voteId}`];
    if (!voteData || voteData.status !== "ACTIVE") {
      throw new HttpsError("not-found", GooiErrorCodes.VOTE_NOT_FOUND);
    }

    // Check expiry
    if (admin.firestore.Timestamp.now().toMillis() > voteData.expiresAt.toMillis()) {
      throw new HttpsError("deadline-exceeded", "Vote has expired");
    }

    // Check if already voted
    if (voteData.yesVotes.includes(userId) || voteData.noVotes.includes(userId)) {
      throw new HttpsError("already-exists", GooiErrorCodes.ALREADY_VOTED);
    }

    if (approve) {
      await cycleDoc.ref.update({
        [`graceVote_${voteId}.yesVotes`]: admin.firestore.FieldValue.arrayUnion(userId),
      });
    } else {
      await cycleDoc.ref.update({
        [`graceVote_${voteId}.noVotes`]: admin.firestore.FieldValue.arrayUnion(userId),
      });
    }

    // Check if vote has passed (simple majority)
    const activeMembersSnap = await db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.MEMBERS)
      .where("isActive", "==", true)
      .where("status", "==", "ACTIVE")
      .get();

    const totalMembers = activeMembersSnap.size;
    const yesCount = voteData.yesVotes.length + (approve ? 1 : 0);
    const noCount = voteData.noVotes.length + (approve ? 0 : 1);
    const majority = Math.floor(totalMembers / 2) + 1;

    if (yesCount >= majority) {
      // Vote passed — extend grace
      const config = await getGooiConfig();
      const newGraceClose = new Date(cycle.graceCloseDate.toMillis() + voteData.extensionHours * 60 * 60 * 1000);
      const newAutoTrigger = new Date(newGraceClose.getTime() + config.autoTriggerHours * 60 * 60 * 1000);

      await cycleDoc.ref.update({
        graceCloseDate: admin.firestore.Timestamp.fromDate(newGraceClose),
        autoTriggerAt: admin.firestore.Timestamp.fromDate(newAutoTrigger),
        graceExtendedBy: (cycle.graceExtendedBy || 0) + voteData.extensionHours,
        graceExtendedAt: admin.firestore.Timestamp.now(),
        graceExtensionVoteId: null,
        [`graceVote_${voteId}.status`]: "PASSED",
      });

      await writeGooiAuditLog(groupId, "GRACE_EXTENSION_VOTE_PASSED", "SYSTEM", {
        entityType: "CYCLE",
        entityId: cycleId,
        afterState: { voteId, extensionHours: voteData.extensionHours, yesCount, noCount },
      });

      return { success: true, votePassed: true };
    }

    if (noCount > totalMembers - majority) {
      // Vote failed
      await cycleDoc.ref.update({
        graceExtensionVoteId: null,
        [`graceVote_${voteId}.status`]: "FAILED",
      });

      await writeGooiAuditLog(groupId, "GRACE_EXTENSION_VOTE_FAILED", "SYSTEM", {
        entityType: "CYCLE",
        entityId: cycleId,
        afterState: { voteId, yesCount, noCount },
      });

      return { success: true, votePassed: false };
    }

    return { success: true, votePending: true, yesCount, noCount, needed: majority };
  }
);

// ============================================================================
// APPLY LATE FEE (Initiator manual action)
// ============================================================================

export const applyGooiLateFee = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "applyGooiLateFee");

    const userId = request.auth.uid;
    const { groupId, contributionId } = request.data;

    const groupDoc = await requireInitiator(groupId, userId);
    const group = groupDoc.data()!;

    const contribDoc = await db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.CONTRIBUTIONS).doc(contributionId).get();
    if (!contribDoc.exists) throw new HttpsError("not-found", GooiErrorCodes.CONTRIBUTION_NOT_FOUND);
    const contrib = contribDoc.data()!;

    if (contrib.status !== "LATE") throw new HttpsError("failed-precondition", GooiErrorCodes.CONTRIBUTION_NOT_LATE);
    if (contrib.lateFee > 0) throw new HttpsError("failed-precondition", GooiErrorCodes.LATE_FEE_ALREADY_APPLIED);

    const feeAmount = Math.floor(group.contributionAmount * group.lateFeePercent / 100);

    const feeResult = await processGooiLateFee(contrib.userId, groupId, contrib.cycleId, feeAmount);
    if (!feeResult.success) {
      throw new HttpsError("internal", feeResult.error || "Late fee processing failed");
    }

    await contribDoc.ref.update({ lateFee: feeAmount });

    await writeGooiAuditLog(groupId, "LATE_FEE_APPLIED", userId, {
      targetId: contrib.userId,
      entityType: "CONTRIBUTION",
      entityId: contributionId,
      afterState: { feeAmount, contributionId },
    });

    return { success: true, feeAmount };
  }
);

// ============================================================================
// WAIVE LATE FEE (Initiator manual action)
// ============================================================================

export const waiveGooiLateFee = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "waiveGooiLateFee");

    const userId = request.auth.uid;
    const { groupId, contributionId } = request.data;

    await requireInitiator(groupId, userId);

    const contribDoc = await db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.CONTRIBUTIONS).doc(contributionId).get();
    if (!contribDoc.exists) throw new HttpsError("not-found", GooiErrorCodes.CONTRIBUTION_NOT_FOUND);
    const contrib = contribDoc.data()!;

    if (contrib.status !== "LATE") throw new HttpsError("failed-precondition", GooiErrorCodes.CONTRIBUTION_NOT_LATE);

    await contribDoc.ref.update({ lateFee: -1 }); // -1 = waived marker

    await writeGooiAuditLog(groupId, "LATE_FEE_WAIVED", userId, {
      targetId: contrib.userId,
      entityType: "CONTRIBUTION",
      entityId: contributionId,
    });

    return { success: true };
  }
);

// ============================================================================
// REQUEST WITHDRAWAL
// ============================================================================

export const requestGooiWithdrawal = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "requestGooiWithdrawal");

    const userId = request.auth.uid;
    const { groupId, reason } = request.data;

    const groupDoc = await db.collection(GooiCollections.GROUPS).doc(groupId).get();
    if (!groupDoc.exists) throw new HttpsError("not-found", GooiErrorCodes.GROUP_NOT_FOUND);
    requireGroupStatus(groupDoc.data()!, "ACTIVE");

    const member = await getGooiMember(groupId, userId);
    if (!member) throw new HttpsError("permission-denied", GooiErrorCodes.NOT_MEMBER);

    // Store withdrawal request as a top-level field on the group
    const withdrawalId = `withdrawal_${userId}_${Date.now()}`;
    const config = await getGooiConfig();
    const voteExpiry = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000); // 7 days to vote

    await db.collection(GooiCollections.GROUPS).doc(groupId).update({
      [`withdrawals.${withdrawalId}`]: {
        userId,
        reason: reason || "",
        votes: {},
        requiredPercent: config.withdrawalVotePercent,
        expiresAt: admin.firestore.Timestamp.fromDate(voteExpiry),
        status: "PENDING",
        createdAt: admin.firestore.Timestamp.now(),
      },
    });

    await writeGooiAuditLog(groupId, "WITHDRAWAL_REQUESTED", userId, {
      metadata: { withdrawalId, reason },
    });

    return { success: true, withdrawalId };
  }
);

// ============================================================================
// VOTE ON WITHDRAWAL
// ============================================================================

export const voteGooiWithdrawal = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "voteGooiWithdrawal");

    const userId = request.auth.uid;
    const { groupId, withdrawalId, approve } = request.data;

    const member = await getGooiMember(groupId, userId);
    if (!member) throw new HttpsError("permission-denied", GooiErrorCodes.NOT_MEMBER);

    const groupDoc = await db.collection(GooiCollections.GROUPS).doc(groupId).get();
    const group = groupDoc.data()!;
    const withdrawal = group.withdrawals?.[withdrawalId];

    if (!withdrawal || withdrawal.status !== "PENDING") {
      throw new HttpsError("not-found", "Withdrawal request not found or already resolved");
    }

    if (userId === withdrawal.userId) {
      throw new HttpsError("invalid-argument", "Cannot vote on your own withdrawal");
    }

    await db.collection(GooiCollections.GROUPS).doc(groupId).update({
      [`withdrawals.${withdrawalId}.votes.${userId}`]: approve,
    });

    // Check if vote threshold reached
    const activeMembersSnap = await db.collection(GooiCollections.GROUPS).doc(groupId)
      .collection(GooiCollections.MEMBERS)
      .where("isActive", "==", true)
      .where("status", "==", "ACTIVE")
      .get();

    const eligibleVoters = activeMembersSnap.size - 1; // exclude withdrawing member
    const updatedVotes = { ...withdrawal.votes, [userId]: approve };
    const yesVotes = Object.values(updatedVotes).filter(v => v === true).length;
    const requiredVotes = Math.ceil(eligibleVoters * withdrawal.requiredPercent / 100);

    if (yesVotes >= requiredVotes) {
      // Withdrawal approved — remove member
      const withdrawingMember = await getGooiMember(groupId, withdrawal.userId);
      if (withdrawingMember) {
        await withdrawingMember.ref.update({
          status: "REMOVED",
          isActive: false,
          removedAt: admin.firestore.Timestamp.now(),
        });
        await db.collection(GooiCollections.GROUPS).doc(groupId).update({
          memberUserIds: admin.firestore.FieldValue.arrayRemove(withdrawal.userId),
          memberCount: admin.firestore.FieldValue.increment(-1),
          [`withdrawals.${withdrawalId}.status`]: "APPROVED",
        });

        await writeGooiAuditLog(groupId, "WITHDRAWAL_APPROVED", "SYSTEM", {
          targetId: withdrawal.userId,
          metadata: { withdrawalId, yesVotes, requiredVotes },
        });
      }
      return { success: true, approved: true };
    }

    return { success: true, approved: false, yesVotes, requiredVotes };
  }
);

// ============================================================================
// DISSOLVE GROUP
// ============================================================================

export const dissolveGooiGroup = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "dissolveGooiGroup");

    const userId = request.auth.uid;
    const { groupId } = request.data;

    const groupDoc = await db.collection(GooiCollections.GROUPS).doc(groupId).get();
    if (!groupDoc.exists) throw new HttpsError("not-found", GooiErrorCodes.GROUP_NOT_FOUND);
    const group = groupDoc.data()!;

    if (group.status === "COMPLETED" || group.status === "DISSOLVED") {
      throw new HttpsError("failed-precondition", "Group is already completed or dissolved");
    }

    // Pre-active: Initiator can dissolve unilaterally
    if (group.status === "FORMING") {
      if (group.initiatorUserId !== userId) {
        throw new HttpsError("permission-denied", GooiErrorCodes.NOT_INITIATOR);
      }
    } else {
      // Active: requires Initiator to initiate (unanimous consent is Phase 2 feature)
      if (group.initiatorUserId !== userId) {
        throw new HttpsError("permission-denied", GooiErrorCodes.NOT_INITIATOR);
      }
    }

    const now = admin.firestore.Timestamp.now();
    await db.collection(GooiCollections.GROUPS).doc(groupId).update({
      status: "DISSOLVED",
      completedAt: now,
      isActive: false,
    });

    await writeGooiAuditLog(groupId, "GROUP_DISSOLVED", userId, {
      metadata: { previousStatus: group.status },
    });

    return { success: true };
  }
);

// ============================================================================
// GET MY GOOI GROUPS
// ============================================================================

export const getMyGooiGroups = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "getMyGooiGroups");

    const userId = request.auth.uid;

    const groupsSnap = await db
      .collection(GooiCollections.GROUPS)
      .where("memberUserIds", "array-contains", userId)
      .where("isDeleted", "==", false)
      .orderBy("createdAt", "desc")
      .limit(50)
      .get();

    const groups = await Promise.all(
      groupsSnap.docs.map(async (doc) => {
        const data = doc.data();

        // Get current cycle info if active
        let currentCycle = null;
        if (data.status === "ACTIVE" && data.currentCycleNumber > 0) {
          const cycleSnap = await db.collection(GooiCollections.GROUPS).doc(doc.id)
            .collection(GooiCollections.CYCLES)
            .where("cycleNumber", "==", data.currentCycleNumber)
            .limit(1)
            .get();
          if (!cycleSnap.empty) {
            currentCycle = cycleSnap.docs[0].data();
          }
        }

        return {
          id: data.id,
          name: data.name,
          status: data.status,
          memberCount: data.memberCount,
          contributionAmount: data.contributionAmount,
          cycleFrequency: data.cycleFrequency,
          totalCycles: data.totalCycles,
          currentCycleNumber: data.currentCycleNumber,
          rosterMethod: data.rosterMethod,
          initiatorUserId: data.initiatorUserId,
          createdAt: data.createdAt,
          activatedAt: data.activatedAt,
          currentCycle: currentCycle ? {
            cycleNumber: currentCycle.cycleNumber,
            status: currentCycle.status,
            recipientUserId: currentCycle.recipientUserId,
            dueDate: currentCycle.dueDate,
            totalCollected: currentCycle.totalCollected,
            totalExpected: currentCycle.totalExpected,
          } : null,
        };
      })
    );

    return { success: true, groups };
  }
);

// ============================================================================
// WRITE OFF BAD DEBT (Initiator manual action at round close)
// ============================================================================

export const writeOffGooiBadDebt = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "writeOffGooiBadDebt");

    const userId = request.auth.uid;
    const { groupId } = request.data;

    const groupDoc = await requireInitiator(groupId, userId);
    const group = groupDoc.data()!;

    if (group.status !== "COMPLETED" && group.status !== "ACTIVE") {
      throw new HttpsError("failed-precondition", "Group must be ACTIVE or COMPLETED for bad debt writeoff");
    }

    // Check if reserve is negative (meaning there's bad debt)
    const groupAccount = await getOrCreateGooiGroupAccount(groupId);
    const reserveDoc = await db.collection("ledgerAccounts")
      .doc(groupAccount.accountId)
      .collection("subAccounts")
      .doc(groupAccount.reserveSubAccountId)
      .get();

    const reserveBalance = reserveDoc.exists ? (reserveDoc.data()?.balance || 0) : 0;
    if (reserveBalance >= 0) {
      throw new HttpsError("failed-precondition", GooiErrorCodes.NO_BAD_DEBT);
    }

    const writeoffAmount = Math.abs(reserveBalance);
    const result = await processGooiBadDebtWriteoff(groupId, writeoffAmount, userId);
    if (!result.success) {
      throw new HttpsError("internal", result.error || "Bad debt writeoff failed");
    }

    await writeGooiAuditLog(groupId, "BAD_DEBT_WRITTEN_OFF", userId, {
      afterState: { writeoffAmount, previousReserveBalance: reserveBalance },
    });

    return { success: true, writeoffAmount };
  }
);

// ============================================================================
// APPLY GOOI PENALTY (suspend/remove defaulter)
// ============================================================================

export const applyGooiPenalty = onCall(
  { labels: GOOI_LABELS },
  async (request) => {
    if (!request.auth) throw new HttpsError("unauthenticated", "Must be authenticated");
    requireAppCheck(request, "applyGooiPenalty");

    const userId = request.auth.uid;
    const { groupId, targetUserId, action } = request.data;

    await requireInitiator(groupId, userId);

    const targetMember = await getGooiMember(groupId, targetUserId);
    if (!targetMember) throw new HttpsError("not-found", GooiErrorCodes.MEMBER_NOT_FOUND);

    const now = admin.firestore.Timestamp.now();

    if (action === "suspend") {
      await targetMember.ref.update({ status: "SUSPENDED" });
      await writeGooiAuditLog(groupId, "MEMBER_SUSPENDED", userId, {
        targetId: targetUserId,
        entityType: "MEMBER",
        entityId: targetMember.id,
      });
    } else if (action === "remove") {
      const memberData = targetMember.data();

      // Record debt if they have outstanding obligations
      if (memberData.outstandingDebt > 0) {
        const debtRef = db.collection(GooiCollections.DEBTS).doc();
        await debtRef.set({
          id: debtRef.id,
          userId: targetUserId,
          groupId,
          amount: memberData.outstandingDebt,
          reason: "Removed from Gooi-Gooi group with outstanding debt",
          status: "OUTSTANDING",
          createdAt: now,
          resolvedAt: null,
        });

        await writeGooiAuditLog(groupId, "DEBT_RECORDED", "SYSTEM", {
          targetId: targetUserId,
          metadata: { debtId: debtRef.id, amount: memberData.outstandingDebt },
        });
      }

      await targetMember.ref.update({
        status: "REMOVED",
        isActive: false,
        removedAt: now,
      });

      await db.collection(GooiCollections.GROUPS).doc(groupId).update({
        memberUserIds: admin.firestore.FieldValue.arrayRemove(targetUserId),
        memberCount: admin.firestore.FieldValue.increment(-1),
      });

      await writeGooiAuditLog(groupId, "MEMBER_REMOVED", userId, {
        targetId: targetUserId,
        entityType: "MEMBER",
        entityId: targetMember.id,
      });
    }

    return { success: true };
  }
);
