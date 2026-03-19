/**
 * Poll Scheduled Functions
 *
 * Daily sweep to catch any expired polls that weren't closed inline.
 * The primary close mechanism is inline in submitPollVote / getPollResults /
 * getPollAdminDetails — this is just the safety net.
 */

import * as admin from "firebase-admin";
import { onSchedule } from "firebase-functions/v2/scheduler";
import { logger } from "firebase-functions/v2";
import { closeExpiredPoll } from "./helpers/pollHelpers";

const db = admin.firestore();

/**
 * Daily sweep: auto-close any polls whose closesAt has passed.
 *
 * Runs once per day at midnight SAST. Most expired polls will already
 * be closed inline when a user interacts, so this typically finds nothing.
 */
export const autoCloseExpiredPolls = onSchedule(
  {
    schedule: "0 0 * * *", // Daily at midnight
    timeZone: "Africa/Johannesburg",
    region: "europe-west1",
    labels: { area: "polls" },
    timeoutSeconds: 120,
  },
  async () => {
    const now = admin.firestore.Timestamp.now();

    // Find open polls whose closesAt has passed
    const expiredPolls = await db
      .collection("polls")
      .where("status", "==", "open")
      .where("closesAt", "<=", now)
      .get();

    if (expiredPolls.empty) {
      return;
    }

    logger.info(`Daily sweep: auto-closing ${expiredPolls.size} expired poll(s)`);

    for (const pollDoc of expiredPolls.docs) {
      try {
        await closeExpiredPoll(pollDoc.ref, pollDoc.data());
        logger.info(`Auto-closed poll ${pollDoc.id}`);
      } catch (err) {
        logger.error(`Failed to auto-close poll ${pollDoc.id}:`, err);
      }
    }
  }
);
