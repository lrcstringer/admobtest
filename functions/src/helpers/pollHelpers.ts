/**
 * Shared poll helper functions.
 */

import * as admin from "firebase-admin";
import { logger } from "firebase-functions/v2";

const db = admin.firestore();

/**
 * Check if a poll has expired (closesAt in the past) and close it inline.
 *
 * Called from submitPollVote, getPollResults, and getPollAdminDetails
 * so that expired polls are closed on first interaction — no need
 * for frequent scheduled sweeps.
 *
 * Returns true if the poll was closed, false if it was still open.
 */
export async function checkAndCloseExpiredPoll(
  pollRef: FirebaseFirestore.DocumentReference,
  pollData: FirebaseFirestore.DocumentData
): Promise<boolean> {
  if (pollData.status !== "open" || !pollData.closesAt) return false;

  const closesAtDate = pollData.closesAt.toDate
    ? pollData.closesAt.toDate()
    : new Date(pollData.closesAt);

  if (closesAtDate.getTime() > Date.now()) return false;

  // Poll has expired — close it
  try {
    await closeExpiredPoll(pollRef, pollData);
    logger.info(`Inline-closed expired poll ${pollRef.id}`);
    return true;
  } catch (err) {
    logger.error(`Failed to inline-close poll ${pollRef.id}:`, err);
    return false;
  }
}

/**
 * Close an expired poll: set status to "closed", deactivate opportunity,
 * decrement thread counter. Used by both inline check and daily sweep.
 */
export async function closeExpiredPoll(
  pollRef: FirebaseFirestore.DocumentReference,
  pollData: FirebaseFirestore.DocumentData
): Promise<void> {
  const batch = db.batch();
  const now = admin.firestore.FieldValue.serverTimestamp();

  batch.update(pollRef, {
    status: "closed",
    closedAt: now,
    updatedAt: now,
  });

  if (pollData.opportunityId) {
    const oppRef = db.collection("earnOpportunities").doc(pollData.opportunityId);
    batch.update(oppRef, {
      isActive: false,
      updatedAt: now,
    });

    if (pollData.threadId) {
      const threadRef = db.collection("earnThreads").doc(pollData.threadId);
      batch.update(threadRef, {
        availableOpportunities: admin.firestore.FieldValue.increment(-1),
        lastActivityAt: now,
      });
    }
  }

  await batch.commit();
}
