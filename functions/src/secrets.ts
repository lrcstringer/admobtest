/**
 * Centralized secret definitions using firebase-functions/params.
 *
 * Gen2 secrets are fetched from Google Secret Manager at runtime.
 * Each function that uses a secret must declare it in its options:
 *   onCall({ secrets: [MYMOBILEAPI_CLIENT_ID] }, async (request) => { ... })
 *
 * Access the value inside the handler with: MYMOBILEAPI_CLIENT_ID.value()
 */

import { defineSecret } from "firebase-functions/params";

export const MYMOBILEAPI_CLIENT_ID = defineSecret("MYMOBILEAPI_CLIENT_ID");
export const MYMOBILEAPI_API_KEY = defineSecret("MYMOBILEAPI_API_KEY");
export const MYMOBILEAPI_SENDER_ID = defineSecret("MYMOBILEAPI_SENDER_ID");
export const SMS_APP_HASH = defineSecret("SMS_APP_HASH");
export const REWARD_CODE_ENCRYPTION_KEY = defineSecret("REWARD_CODE_ENCRYPTION_KEY");
