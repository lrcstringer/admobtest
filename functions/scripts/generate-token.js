#!/usr/bin/env node
/**
 * Generate a Firebase custom auth token for local debugging.
 *
 * Usage:
 *   node scripts/generate-token.js <uid>
 *
 * Example:
 *   node scripts/generate-token.js phone_27723713621
 *
 * Requires a service account key file at functions/service-account-key.json.
 * To get one: Firebase Console → Project Settings → Service accounts
 *             → "Generate new private key"
 */

const path = require("path");
const fs = require("fs");
const admin = require("firebase-admin");

const uid = process.argv[2];
if (!uid) {
  console.error("Usage: node scripts/generate-token.js <uid>");
  console.error("Example: node scripts/generate-token.js phone_27723713621");
  process.exit(1);
}

// Look for service account key relative to functions/ dir
const keyPath = path.resolve(__dirname, "..", "service-account-key.json");
if (!fs.existsSync(keyPath)) {
  console.error("Service account key not found at:", keyPath);
  console.error("");
  console.error("To create one:");
  console.error("  1. Go to Firebase Console → Project Settings → Service accounts");
  console.error("  2. Click 'Generate new private key'");
  console.error("  3. Save the file as: functions/service-account-key.json");
  process.exit(1);
}

const serviceAccount = require(keyPath);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

admin
  .auth()
  .createCustomToken(uid)
  .then((token) => {
    console.log("\n--- Custom Auth Token ---");
    console.log(token);
    console.log("--- End Token ---\n");
    console.log("Paste this token into the debug sign-in dialog on the welcome screen.");
    console.log("(Long-press the debug badge in the top-right corner)");
    process.exit(0);
  })
  .catch((err) => {
    console.error("Failed to create custom token:", err.message);
    process.exit(1);
  });
