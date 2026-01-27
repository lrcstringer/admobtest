/**
 * Pot-related Cloud Functions
 * Handles daily and weekly pot draws
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Run daily pot draw at 8 PM SAST
 */
export const runDailyPotDraw = functions.pubsub
  .schedule("0 20 * * *")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const dateStr = today.toISOString().split("T")[0];

    // Get or create today's pot
    const potRef = db.collection("potPools").doc(`daily_${dateStr}`);
    const potDoc = await potRef.get();

    if (!potDoc.exists) {
      console.log("No pot found for today");
      return null;
    }

    const potData = potDoc.data();
    if (potData?.status !== "active") {
      console.log("Pot is not active");
      return null;
    }

    // Get all entries for today
    const entriesSnapshot = await db.collection("potEntries")
      .where("date", "==", dateStr)
      .get();

    if (entriesSnapshot.empty) {
      console.log("No entries for today's pot");
      await potRef.update({ status: "completed", winnerId: null });
      return null;
    }

    // Build weighted entry list
    const entries: { userId: string; weight: number }[] = [];
    entriesSnapshot.docs.forEach((doc) => {
      const data = doc.data();
      entries.push({
        userId: data.oddienceUserId,
        weight: data.entries,
      });
    });

    // Select winner based on weighted random selection
    const totalWeight = entries.reduce((sum, e) => sum + e.weight, 0);
    let random = Math.random() * totalWeight;

    let winner: string | null = null;
    for (const entry of entries) {
      random -= entry.weight;
      if (random <= 0) {
        winner = entry.userId;
        break;
      }
    }

    if (!winner) {
      winner = entries[entries.length - 1].userId;
    }

    const prizeAmount = potData.prizePool || 10000; // Default 10000 tokens

    // Process winner
    await db.runTransaction(async (transaction) => {
      // Update pot
      transaction.update(potRef, {
        status: "completed",
        winnerId: winner,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Get winner's wallet
      const walletQuery = await db.collection("wallets")
        .where("oddienceUserId", "==", winner)
        .limit(1)
        .get();

      if (!walletQuery.empty) {
        const walletDoc = walletQuery.docs[0];

        // Add prize to winner's wallet
        transaction.update(walletDoc.ref, {
          tokenBalance: admin.firestore.FieldValue.increment(prizeAmount),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // Create transaction record
        const transactionRef = db.collection("transactions").doc();
        transaction.set(transactionRef, {
          id: transactionRef.id,
          walletId: walletDoc.id,
          oddienceUserId: winner,
          type: "pot_win",
          tokenAmount: prizeAmount,
          zarAmount: prizeAmount * 0.01,
          description: "Daily pot winner!",
          status: "completed",
          referenceId: potRef.id,
          referenceType: "pot",
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // Create winner record
        const winnerRef = db.collection("potWinners").doc();
        transaction.set(winnerRef, {
          id: winnerRef.id,
          potId: potRef.id,
          potType: "daily",
          oddienceUserId: winner,
          prizeAmount: prizeAmount,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
    });

    // Create next day's pot
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    const tomorrowStr = tomorrow.toISOString().split("T")[0];

    await db.collection("potPools").doc(`daily_${tomorrowStr}`).set({
      id: `daily_${tomorrowStr}`,
      type: "daily",
      date: tomorrowStr,
      prizePool: 10000, // Base prize
      contributionPool: 0,
      status: "active",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`Daily pot draw completed. Winner: ${winner}, Prize: ${prizeAmount} tokens`);
    return null;
  });

/**
 * Run weekly pot draw on Sundays at 8 PM SAST
 */
export const runWeeklyPotDraw = functions.pubsub
  .schedule("0 20 * * 0")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    const today = new Date();
    const weekNumber = getWeekNumber(today);
    const year = today.getFullYear();
    const potId = `weekly_${year}_w${weekNumber}`;

    const potRef = db.collection("potPools").doc(potId);
    const potDoc = await potRef.get();

    if (!potDoc.exists || potDoc.data()?.status !== "active") {
      console.log("No active weekly pot found");
      return null;
    }

    const potData = potDoc.data();

    // Get week start and end dates
    const weekStart = getWeekStart(today);
    const weekEnd = new Date(weekStart);
    weekEnd.setDate(weekEnd.getDate() + 6);

    // Aggregate entries for the week
    const entriesSnapshot = await db.collection("potEntries")
      .where("date", ">=", weekStart.toISOString().split("T")[0])
      .where("date", "<=", weekEnd.toISOString().split("T")[0])
      .get();

    if (entriesSnapshot.empty) {
      console.log("No entries for weekly pot");
      await potRef.update({ status: "completed", winnerId: null });
      return null;
    }

    // Aggregate entries by user
    const userEntries: Map<string, number> = new Map();
    entriesSnapshot.docs.forEach((doc) => {
      const data = doc.data();
      const current = userEntries.get(data.oddienceUserId) || 0;
      userEntries.set(data.oddienceUserId, current + data.entries);
    });

    // Select winner
    const entries = Array.from(userEntries.entries()).map(([userId, weight]) => ({
      userId,
      weight,
    }));

    const totalWeight = entries.reduce((sum, e) => sum + e.weight, 0);
    let random = Math.random() * totalWeight;

    let winner: string | null = null;
    for (const entry of entries) {
      random -= entry.weight;
      if (random <= 0) {
        winner = entry.userId;
        break;
      }
    }

    if (!winner) {
      winner = entries[entries.length - 1].userId;
    }

    const prizeAmount = potData?.prizePool || 50000; // Default 50000 tokens for weekly

    // Process winner (same as daily)
    await db.runTransaction(async (transaction) => {
      transaction.update(potRef, {
        status: "completed",
        winnerId: winner,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      const walletQuery = await db.collection("wallets")
        .where("oddienceUserId", "==", winner)
        .limit(1)
        .get();

      if (!walletQuery.empty) {
        const walletDoc = walletQuery.docs[0];

        transaction.update(walletDoc.ref, {
          tokenBalance: admin.firestore.FieldValue.increment(prizeAmount),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        const transactionRef = db.collection("transactions").doc();
        transaction.set(transactionRef, {
          id: transactionRef.id,
          walletId: walletDoc.id,
          oddienceUserId: winner,
          type: "pot_win",
          tokenAmount: prizeAmount,
          zarAmount: prizeAmount * 0.01,
          description: "Weekly pot winner!",
          status: "completed",
          referenceId: potRef.id,
          referenceType: "pot",
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        const winnerRef = db.collection("potWinners").doc();
        transaction.set(winnerRef, {
          id: winnerRef.id,
          potId: potRef.id,
          potType: "weekly",
          oddienceUserId: winner,
          prizeAmount: prizeAmount,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }
    });

    // Create next week's pot
    const nextWeekNumber = weekNumber === 52 ? 1 : weekNumber + 1;
    const nextYear = weekNumber === 52 ? year + 1 : year;
    const nextPotId = `weekly_${nextYear}_w${nextWeekNumber}`;

    await db.collection("potPools").doc(nextPotId).set({
      id: nextPotId,
      type: "weekly",
      weekNumber: nextWeekNumber,
      year: nextYear,
      prizePool: 50000,
      contributionPool: 0,
      status: "active",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`Weekly pot draw completed. Winner: ${winner}, Prize: ${prizeAmount} tokens`);
    return null;
  });

// Helper functions
function getWeekNumber(date: Date): number {
  const d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
  const dayNum = d.getUTCDay() || 7;
  d.setUTCDate(d.getUTCDate() + 4 - dayNum);
  const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
  return Math.ceil((((d.getTime() - yearStart.getTime()) / 86400000) + 1) / 7);
}

function getWeekStart(date: Date): Date {
  const d = new Date(date);
  const day = d.getDay();
  const diff = d.getDate() - day + (day === 0 ? -6 : 1);
  return new Date(d.setDate(diff));
}
