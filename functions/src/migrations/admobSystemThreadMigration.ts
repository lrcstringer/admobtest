/**
 * Platform Setup: iMaliChat AdMob Client, Thread & Opportunity
 *
 * Creates the IMaliChat platform client as a normal client with:
 * 1. A proper ledger account (so it appears on the Clients page)
 * 2. A default sub-account (so token earnings are debited from it)
 * 3. The "Watch & Earn" thread for AdMob rewarded videos
 * 4. The initial AdMob opportunity with the configured ad unit ID
 *
 * Run via Admin Portal → Platform Setup → "Run Setup"
 * Or call via HTTP: POST /runAdMobSystemMigration with admin Bearer token
 */

import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { createClientAccount, getClientAccount, unfreezeAccount } from "../ledger/accounts";
import { AccountId } from "../ledger/types";

// Note: Firebase Admin is initialized in index.ts before this module is loaded
// For standalone execution (npx ts-node), initialize conditionally
if (require.main === module && !admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();

// IMaliChat Platform Configuration
const ADMOB_CONFIG = {
  // Client identifiers
  CLIENT_ID: "imalichat",
  CLIENT_NAME: "IMaliChat",
  THREAD_ID: "imalichat_watch_earn",
  THREAD_TITLE: "Watch & Earn",
  THREAD_DESCRIPTION: "Watch short video ads to earn tokens instantly!",
  THREAD_AVATAR_COLOR: "#4CAF50", // Green

  // Opportunity configuration
  OPPORTUNITY_ID: "imalichat_watch_earn_ad",
  OPPORTUNITY_TITLE: "Watch Ad",
  OPPORTUNITY_DESCRIPTION:
    "Watch a short video ad and answer a question to earn tokens.",

  // Reward configuration
  TOKEN_REWARD: 5,
  STREAK_POINTS: 1,
  DURATION_SECONDS: 30,
  DAILY_LIMIT_PER_USER: 3,

  // Default sub-account
  SUB_ACCOUNT_ID: "default",
  SUB_ACCOUNT_NAME: "AdMob Revenue",

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

async function createClient(): Promise<void> {
  const clientRef = db.collection("clients").doc(ADMOB_CONFIG.CLIENT_ID);
  const clientDoc = await clientRef.get();

  if (clientDoc.exists && clientDoc.data()?.isDeleted !== true) {
    console.log("Client already exists:", ADMOB_CONFIG.CLIENT_ID);
    return;
  }

  // Create or reactivate ledger account
  const existingLedger = await getClientAccount(ADMOB_CONFIG.CLIENT_ID);
  if (existingLedger && existingLedger.status !== "active") {
    console.log("Reactivating closed ledger account...");
    await unfreezeAccount(
      AccountId.client(ADMOB_CONFIG.CLIENT_ID),
      "Platform setup: recreating client",
      "platform_setup"
    );
  } else if (!existingLedger) {
    await createClientAccount(ADMOB_CONFIG.CLIENT_ID, ADMOB_CONFIG.CLIENT_NAME, {
      contactEmail: "platform@imalichat.com",
      contactName: "Platform",
      industry: "platform",
    });
  }

  // Create client profile document (same shape as adminCreateClient)
  await clientRef.set({
    id: ADMOB_CONFIG.CLIENT_ID,
    companyName: ADMOB_CONFIG.CLIENT_NAME,
    contactEmail: "platform@imalichat.com",
    contactName: "Platform",
    companyRegistration: null,
    industry: "platform",
    billingAddress: null,
    vatNumber: null,
    ledgerAccountId: `client:${ADMOB_CONFIG.CLIENT_ID}`,
    status: "active",
    isActive: true,
    displayName: ADMOB_CONFIG.CLIENT_NAME,
    avatarImage: null,
    avatarColor: ADMOB_CONFIG.THREAD_AVATAR_COLOR,
    brandAccountTypeId: null,
    budgetWarningThreshold: 0.20,
    totalCampaigns: 0,
    activeCampaigns: 0,
    totalSpent: 0,
    totalImpressions: 0,
    totalEngagements: 0,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    createdBy: "platform_setup",
  });

  console.log("Created client:", ADMOB_CONFIG.CLIENT_ID);
}

async function createDefaultSubAccount(): Promise<void> {
  const subAccountRef = db
    .collection("clients")
    .doc(ADMOB_CONFIG.CLIENT_ID)
    .collection("subAccounts")
    .doc(ADMOB_CONFIG.SUB_ACCOUNT_ID);

  const subAccountDoc = await subAccountRef.get();

  if (subAccountDoc.exists && subAccountDoc.data()?.isDeleted !== true) {
    console.log("Default sub-account already exists");
    return;
  }

  await subAccountRef.set({
    id: ADMOB_CONFIG.SUB_ACCOUNT_ID,
    name: ADMOB_CONFIG.SUB_ACCOUNT_NAME,
    balance: 0,
    initialBudget: 0,
    isActive: true,
    warningNotifiedAt: null,
    depletedAt: null,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    createdBy: "platform_setup",
  });

  console.log("Created default sub-account:", ADMOB_CONFIG.SUB_ACCOUNT_ID);
}

async function createThread(): Promise<void> {
  const threadRef = db.collection("earnThreads").doc(ADMOB_CONFIG.THREAD_ID);
  const threadDoc = await threadRef.get();

  if (threadDoc.exists && threadDoc.data()?.isDeleted !== true) {
    console.log("Thread already exists:", ADMOB_CONFIG.THREAD_ID);
    return;
  }

  await threadRef.set({
    id: ADMOB_CONFIG.THREAD_ID,
    clientId: ADMOB_CONFIG.CLIENT_ID,
    clientName: ADMOB_CONFIG.CLIENT_NAME,
    clientAvatarColor: ADMOB_CONFIG.THREAD_AVATAR_COLOR,
    title: ADMOB_CONFIG.THREAD_TITLE,
    description: ADMOB_CONFIG.THREAD_DESCRIPTION,
    isPinned: true,
    isFeatured: true,
    isActive: true,
    availableOpportunities: 1,
    completedOpportunities: 0,
    completedUniqueUsers: 0,
    // Client-funded: tokens will be debited from this sub-account
    tokenSourceSubAccountId: ADMOB_CONFIG.SUB_ACCOUNT_ID,
    // Earnings go to user's default wallet
    tokenDestAccountTypeId: null,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log("Created thread:", ADMOB_CONFIG.THREAD_ID);
}

async function createAdMobOpportunity(): Promise<void> {
  const opportunityRef = db
    .collection("earnOpportunities")
    .doc(ADMOB_CONFIG.OPPORTUNITY_ID);
  const opportunityDoc = await opportunityRef.get();

  if (opportunityDoc.exists && opportunityDoc.data()?.isDeleted !== true) {
    console.log("AdMob opportunity already exists:", ADMOB_CONFIG.OPPORTUNITY_ID);
    return;
  }

  await opportunityRef.set({
    id: ADMOB_CONFIG.OPPORTUNITY_ID,
    threadId: ADMOB_CONFIG.THREAD_ID,
    clientId: ADMOB_CONFIG.CLIENT_ID,
    clientName: ADMOB_CONFIG.CLIENT_NAME,
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
    adUnitId: ADMOB_CONFIG.AD_UNIT_ID,
    bonusReward: ADMOB_CONFIG.BONUS_REWARD,
    bonusRewardMultiplier: ADMOB_CONFIG.BONUS_MULTIPLIER,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log("Created AdMob opportunity:", ADMOB_CONFIG.OPPORTUNITY_ID);
}

async function runMigration(): Promise<void> {
  console.log("Starting IMaliChat platform setup...\n");

  try {
    // Step 0: Ensure Trust Ledger system accounts exist (treasury, pots, etc.)
    console.log("Step 0: Initializing Trust Ledger system accounts...");
    const { initializeLedger } = await import("../ledger");
    await initializeLedger();

    // Step 1: Create client with proper ledger account
    console.log("Step 1: Creating IMaliChat client...");
    await createClient();

    // Step 2: Create default sub-account for budget tracking
    console.log("\nStep 2: Creating default sub-account...");
    await createDefaultSubAccount();

    // Step 3: Create Watch & Earn thread
    console.log("\nStep 3: Creating Watch & Earn thread...");
    await createThread();

    // Step 4: Create AdMob opportunity
    console.log("\nStep 4: Creating AdMob opportunity...");
    await createAdMobOpportunity();

    console.log("\n✅ Platform setup completed successfully!");
    console.log("\nSummary:");
    console.log(`  - Client ID: ${ADMOB_CONFIG.CLIENT_ID}`);
    console.log(`  - Sub-Account: ${ADMOB_CONFIG.SUB_ACCOUNT_ID}`);
    console.log(`  - Thread ID: ${ADMOB_CONFIG.THREAD_ID}`);
    console.log(`  - Opportunity ID: ${ADMOB_CONFIG.OPPORTUNITY_ID}`);
    console.log(`  - Token Reward: ${ADMOB_CONFIG.TOKEN_REWARD}`);
    console.log(`  - Daily Limit: ${ADMOB_CONFIG.DAILY_LIMIT_PER_USER}`);
    console.log(`  - Ad Unit ID: ${ADMOB_CONFIG.AD_UNIT_ID}`);
    console.log("\n⚠️  Remember to fund the IMaliChat client sub-account via Clients → Fund!");
  } catch (error) {
    console.error("\n❌ Platform setup failed:", error);
    throw error;
  }
}

/**
 * Update the questions array on the existing AdMob opportunity document.
 * Call once after deploying to apply question text changes to the live document.
 */
async function updateAdMobQuestion(): Promise<void> {
  const opportunityRef = db
    .collection("earnOpportunities")
    .doc(ADMOB_CONFIG.OPPORTUNITY_ID);
  const opportunityDoc = await opportunityRef.get();

  if (!opportunityDoc.exists) {
    console.log("AdMob opportunity does not exist — run the full setup first");
    return;
  }

  await opportunityRef.update({
    questions: [SAMPLE_QUESTION],
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log("Updated questions on:", ADMOB_CONFIG.OPPORTUNITY_ID);
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
 * Callable function for Admin Portal to run platform setup.
 * Requires admin custom claim.
 */
export const adminRunPlatformSetup = functions.https.onCall(async (_data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Must be authenticated");
  }
  const token = context.auth.token;
  if (!token.admin && !token.superAdmin) {
    throw new functions.https.HttpsError("permission-denied", "Admin access required");
  }

  await runMigration();

  return {
    success: true,
    message: "IMaliChat platform setup completed successfully",
    config: {
      clientId: ADMOB_CONFIG.CLIENT_ID,
      threadId: ADMOB_CONFIG.THREAD_ID,
      opportunityId: ADMOB_CONFIG.OPPORTUNITY_ID,
      subAccountId: ADMOB_CONFIG.SUB_ACCOUNT_ID,
      tokenReward: ADMOB_CONFIG.TOKEN_REWARD,
      dailyLimit: ADMOB_CONFIG.DAILY_LIMIT_PER_USER,
      adUnitId: ADMOB_CONFIG.AD_UNIT_ID,
    },
  };
});

/**
 * HTTP endpoint to run the IMaliChat platform setup.
 * Requires admin authentication.
 */
export const runAdMobSystemMigration = functions.https.onRequest(async (req, res) => {
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
      message: "IMaliChat platform setup completed successfully",
      config: {
        clientId: ADMOB_CONFIG.CLIENT_ID,
        threadId: ADMOB_CONFIG.THREAD_ID,
        opportunityId: ADMOB_CONFIG.OPPORTUNITY_ID,
        subAccountId: ADMOB_CONFIG.SUB_ACCOUNT_ID,
        tokenReward: ADMOB_CONFIG.TOKEN_REWARD,
        dailyLimit: ADMOB_CONFIG.DAILY_LIMIT_PER_USER,
        adUnitId: ADMOB_CONFIG.AD_UNIT_ID,
      },
    });
  } catch (error) {
    console.error("Platform setup failed:", error);
    res.status(500).json({
      success: false,
      error: String(error),
    });
  }
});

// Run setup if this file is executed directly
if (require.main === module) {
  runMigration()
    .then(() => process.exit(0))
    .catch(() => process.exit(1));
}

export { runMigration, ADMOB_CONFIG };
