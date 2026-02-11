/**
 * Encryption utilities for reward code values.
 *
 * Uses AES-256-GCM for encryption/decryption and SHA-256 for hashing.
 * The encryption key is loaded from the REWARD_CODE_ENCRYPTION_KEY env var.
 */

import * as crypto from "crypto";

const ALGORITHM = "aes-256-gcm";
const IV_LENGTH = 12; // 96 bits recommended for GCM
const AUTH_TAG_LENGTH = 16; // 128 bits

/**
 * Get the encryption key from environment variables.
 * Key must be a 64-character hex string (32 bytes).
 */
function getEncryptionKey(): Buffer {
  const keyHex = process.env.REWARD_CODE_ENCRYPTION_KEY;
  if (!keyHex) {
    throw new Error("REWARD_CODE_ENCRYPTION_KEY environment variable is not set");
  }
  if (keyHex.length !== 64) {
    throw new Error("REWARD_CODE_ENCRYPTION_KEY must be a 64-character hex string (32 bytes)");
  }
  return Buffer.from(keyHex, "hex");
}

/**
 * Encrypt a plaintext code value using AES-256-GCM.
 * Returns the encrypted value (base64) and IV (base64).
 */
export function encryptCode(plaintext: string): { encrypted: string; iv: string } {
  const key = getEncryptionKey();
  const iv = crypto.randomBytes(IV_LENGTH);
  const cipher = crypto.createCipheriv(ALGORITHM, key, iv, { authTagLength: AUTH_TAG_LENGTH });

  let encrypted = cipher.update(plaintext, "utf8", "base64");
  encrypted += cipher.final("base64");
  const authTag = cipher.getAuthTag();

  // Combine encrypted data + auth tag for storage
  const combined = Buffer.concat([
    Buffer.from(encrypted, "base64"),
    authTag,
  ]);

  return {
    encrypted: combined.toString("base64"),
    iv: iv.toString("base64"),
  };
}

/**
 * Decrypt an encrypted code value using AES-256-GCM.
 * Expects the encrypted value (base64, includes auth tag) and IV (base64).
 */
export function decryptCode(encryptedBase64: string, ivBase64: string): string {
  const key = getEncryptionKey();
  const iv = Buffer.from(ivBase64, "base64");
  const combined = Buffer.from(encryptedBase64, "base64");

  // Split encrypted data and auth tag
  const encrypted = combined.subarray(0, combined.length - AUTH_TAG_LENGTH);
  const authTag = combined.subarray(combined.length - AUTH_TAG_LENGTH);

  const decipher = crypto.createDecipheriv(ALGORITHM, key, iv, { authTagLength: AUTH_TAG_LENGTH });
  decipher.setAuthTag(authTag);

  let decrypted = decipher.update(encrypted);
  decrypted = Buffer.concat([decrypted, decipher.final()]);

  return decrypted.toString("utf8");
}

/**
 * Hash a plaintext code value using SHA-256.
 * Used for uniqueness checks without needing to decrypt.
 */
export function hashCode(plaintext: string): string {
  return crypto.createHash("sha256").update(plaintext, "utf8").digest("hex");
}
