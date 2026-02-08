/**
 * Migration to create the system AdMob thread and opportunity
 *
 * This migration sets up:
 * 1. A system client entry (if not exists)
 * 2. The "Watch & Earn" thread for AdMob rewarded videos
 * 3. The initial AdMob opportunity with the configured ad unit ID
 *
 * Run with: npx ts-node src/migrations/admobSystemThreadMigration.ts
 * Or call via HTTP: POST /runAdMobSystemMigration with admin token
 */

import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

// Note: Firebase Admin is initialized in index.ts before this module is loaded
// For standalone execution (npx ts-node), initialize conditionally
if (require.main === module && !admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();

// AdMob Configuration
const ADMOB_CONFIG = {
  // System client/thread identifiers
  SYSTEM_CLIENT_ID: "system_admob",
  SYSTEM_CLIENT_NAME: "iMali Rewards",
  THREAD_ID: "system_admob_thread",
  THREAD_TITLE: "Watch & Earn",
  THREAD_DESCRIPTION: "Watch short video ads to earn tokens instantly!",
  THREAD_AVATAR_COLOR: "#4CAF50", // Green

  // Opportunity configuration
  OPPORTUNITY_TITLE: "Watch Ad",
  OPPORTUNITY_DESCRIPTION:
    "Watch a short video ad and answer a question to earn tokens.",

  // Reward configuration
  TOKEN_REWARD: 5,
  STREAK_POINTS: 1,
  DURATION_SECONDS: 30,
  DAILY_LIMIT_PER_USER: 3,

  // AdMob IDs
  AD_UNIT_ID: "ca-app-pub-9331591670168644/1108724925",

  // Bonus configuration (optional)
  BONUS_REWARD: false,
  BONUS_MULTIPLIER: 1.0,
};

// Feedback question for the AdMob opportunity
const SAMPLE_QUESTION = {
  id: "admob_feedback_q1",
  text: "What best describes your view of the video?",
  options: ["It was interesting", "It was enjoyable", "I didn't like it"],
  orderIndex: 0,
  isAttentionCheck: false,
  correctAnswer: null,
};

async function createSystemClient(): Promise<void> {
  const clientRef = db.collection("clients").doc(ADMOB_CONFIG.SYSTEM_CLIENT_ID);
  const clientDoc = await clientRef.get();

  if (clientDoc.exists) {
    console.log("System client already exists");
    return;
  }

  await clientRef.set({
    id: ADMOB_CONFIG.SYSTEM_CLIENT_ID,
    name: ADMOB_CONFIG.SYSTEM_CLIENT_NAME,
    isSystem: true,
    isActive: true,
    avatarColor: ADMOB_CONFIG.THREAD_AVATAR_COLOR,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log("Created system client:", ADMOB_CONFIG.SYSTEM_CLIENT_ID);
}

async function createSystemThread(): Promise<void> {
  const threadRef = db.collection("earnThreads").doc(ADMOB_CONFIG.THREAD_ID);
  const threadDoc = await threadRef.get();

  if (threadDoc.exists) {
    console.log("System thread already exists");
    return;
  }

  await threadRef.set({
    id: ADMOB_CONFIG.THREAD_ID,
    clientId: ADMOB_CONFIG.SYSTEM_CLIENT_ID,
    clientName: ADMOB_CONFIG.SYSTEM_CLIENT_NAME,
    clientAvatarColor: ADMOB_CONFIG.THREAD_AVATAR_COLOR,
    title: ADMOB_CONFIG.THREAD_TITLE,
    description: ADMOB_CONFIG.THREAD_DESCRIPTION,
    isPinned: true, // Always show at top
    isFeatured: true,
    isActive: true,
    isSystemThread: true, // Mark as system-generated
    availableOpportunities: 1,
    completedOpportunities: 0,
    completedUniqueUsers: 0,
    // No token source - system doesn't debit from a client account
    tokenSourceSubAccountId: null,
    tokenDestAccountTypeId: null,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log("Created system thread:", ADMOB_CONFIG.THREAD_ID);
}

async function createAdMobOpportunity(): Promise<void> {
  const opportunityId = "system_admob_opportunity";
  const opportunityRef = db.collection("earnOpportunities").doc(opportunityId);
  const opportunityDoc = await opportunityRef.get();

  if (opportunityDoc.exists) {
    console.log("AdMob opportunity already exists");
    return;
  }

  await opportunityRef.set({
    id: opportunityId,
    threadId: ADMOB_CONFIG.THREAD_ID,
    clientId: ADMOB_CONFIG.SYSTEM_CLIENT_ID,
    clientName: ADMOB_CONFIG.SYSTEM_CLIENT_NAME,
    clientAvatarColor: ADMOB_CONFIG.THREAD_AVATAR_COLOR,
    title: ADMOB_CONFIG.OPPORTUNITY_TITLE,
    description: ADMOB_CONFIG.OPPORTUNITY_DESCRIPTION,
    earningType: "adVideo",
    mediaType: "adMob",
    tokenReward: ADMOB_CONFIG.TOKEN_REWARD,
    streakPoints: ADMOB_CONFIG.STREAK_POINTS,
    durationSeconds: ADMOB_CONFIG.DURATION_SECONDS,
    dailyLimitPerUser: ADMOB_CONFIG.DAILY_LIMIT_PER_USER,
    questions: [SAMPLE_QUESTION],
    isActive: true,
    // AdMob configuration
    adUnitId: ADMOB_CONFIG.AD_UNIT_ID,
    // Bonus configuration
    bonusReward: ADMOB_CONFIG.BONUS_REWARD,
    bonusRewardMultiplier: ADMOB_CONFIG.BONUS_MULTIPLIER,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log("Created AdMob opportunity:", opportunityId);
}

async function runMigration(): Promise<void> {
  console.log("Starting AdMob system thread migration...\n");

  try {
    // Step 0: Ensure Trust Ledger system accounts exist (treasury, pots, etc.)
    console.log("Step 0: Initializing Trust Ledger system accounts...");
    const { initializeLedger } = await import("../ledger");
    await initializeLedger();

    // Step 1: Create system client
    console.log("Step 1: Creating system client...");
    await createSystemClient();

    // Step 2: Create system thread
    console.log("\nStep 2: Creating system thread...");
    await createSystemThread();

    // Step 3: Create AdMob opportunity
    console.log("\nStep 3: Creating AdMob opportunity...");
    await createAdMobOpportunity();

    console.log("\n✅ Migration completed successfully!");
    console.log("\nSummary:");
    console.log(`  - Client ID: ${ADMOB_CONFIG.SYSTEM_CLIENT_ID}`);
    console.log(`  - Thread ID: ${ADMOB_CONFIG.THREAD_ID}`);
    console.log(`  - Token Reward: ${ADMOB_CONFIG.TOKEN_REWARD}`);
    console.log(`  - Daily Limit: ${ADMOB_CONFIG.DAILY_LIMIT_PER_USER}`);
    console.log(`  - Ad Unit ID: ${ADMOB_CONFIG.AD_UNIT_ID}`);
  } catch (error) {
    console.error("\n❌ Migration failed:", error);
    throw error;
  }
}

/**
 * Update the questions array on the existing AdMob opportunity document.
 * Call once after deploying to apply question text changes to the live document.
 */
async function updateAdMobQuestion(): Promise<void> {
  const opportunityId = "system_admob_opportunity";
  const opportunityRef = db.collection("earnOpportunities").doc(opportunityId);
  const opportunityDoc = await opportunityRef.get();

  if (!opportunityDoc.exists) {
    console.log("AdMob opportunity does not exist — run the full migration first");
    return;
  }

  await opportunityRef.update({
    questions: [SAMPLE_QUESTION],
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log("Updated questions on:", opportunityId);
}

/**
 * HTTP endpoint to update the AdMob opportunity question (one-shot).
 * POST /updateAdMobQuestion with admin Bearer token.
 */
export const runUpdateAdMobQuestion = functions.https.onRequest(async (req, res) => {
  const authHeader = req.headers.authorization;
  if (!authHeader?.startsWith("Bearer ")) {
    res.status(401).json({error: "Missing authorization header"});
    return;
  }

  const idToken = authHeader.split("Bearer ")[1];
  try {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    const adminDoc = await db.collection("admins").doc(decodedToken.uid).get();
    if (!adminDoc.exists) {
      res.status(403).json({error: "Admin access required"});
      return;
    }
  } catch {
    res.status(401).json({error: "Invalid token"});
    return;
  }

  try {
    await updateAdMobQuestion();
    res.status(200).json({
      success: true,
      message: "AdMob question updated successfully",
      question: SAMPLE_QUESTION,
    });
  } catch (error) {
    console.error("Question update failed:", error);
    res.status(500).json({success: false, error: String(error)});
  }
});

/**
 * HTTP endpoint to run the AdMob system migration
 * Requires admin authentication
 */
export const runAdMobSystemMigration = functions.https.onRequest(async (req, res) => {
  // Verify admin token
  const authHeader = req.headers.authorization;
  if (!authHeader?.startsWith("Bearer ")) {
    res.status(401).json({ error: "Missing authorization header" });
    return;
  }

  const idToken = authHeader.split("Bearer ")[1];
  try {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    const adminDoc = await db.collection("admins").doc(decodedToken.uid).get();
    if (!adminDoc.exists) {
      res.status(403).json({ error: "Admin access required" });
      return;
    }
  } catch {
    res.status(401).json({ error: "Invalid token" });
    return;
  }

  try {
    await runMigration();
    res.status(200).json({
      success: true,
      message: "AdMob system migration completed successfully",
      config: {
        clientId: ADMOB_CONFIG.SYSTEM_CLIENT_ID,
        threadId: ADMOB_CONFIG.THREAD_ID,
        tokenReward: ADMOB_CONFIG.TOKEN_REWARD,
        dailyLimit: ADMOB_CONFIG.DAILY_LIMIT_PER_USER,
        adUnitId: ADMOB_CONFIG.AD_UNIT_ID,
      },
    });
  } catch (error) {
    console.error("Migration failed:", error);
    res.status(500).json({
      success: false,
      error: String(error),
    });
  }
});

// Run migration if this file is executed directly
if (require.main === module) {
  runMigration()
    .then(() => process.exit(0))
    .catch(() => process.exit(1));
}

export { runMigration, ADMOB_CONFIG };
