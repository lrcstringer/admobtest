/**
 * Jest Test Setup
 *
 * This file runs before each test file and sets up:
 * - Firebase Admin SDK mocks
 * - Global test utilities
 * - Console output suppression (optional)
 */

import { mockFirebaseAdmin, resetMocks } from "./mocks/admin.mock";

// Mock firebase-admin before any imports
jest.mock("firebase-admin", () => mockFirebaseAdmin);

// Mock firebase-functions (logger used by many Gen2 files)
jest.mock("firebase-functions", () => ({
  logger: {
    log: jest.fn(),
    info: jest.fn(),
    warn: jest.fn(),
    error: jest.fn(),
    debug: jest.fn(),
  },
}));

// Mock firebase-functions/v2 (Gen2)
jest.mock("firebase-functions/v2/https", () => ({
  onCall: jest.fn((...args: unknown[]) => {
    const handler = typeof args[0] === "function" ? args[0] : args[1];
    return (data: unknown, context: unknown) =>
      (handler as Function)({ data, ...(context as object) });
  }),
  onRequest: jest.fn((handler) => handler),
  HttpsError: class HttpsError extends Error {
    constructor(
      public code: string,
      public message: string,
      public details?: unknown
    ) {
      super(message);
      this.name = "HttpsError";
    }
  },
}));

jest.mock("firebase-functions/v2/firestore", () => ({
  onDocumentCreated: jest.fn((...args: unknown[]) => {
    const handler = args.length === 2 ? args[1] : args[0];
    return handler;
  }),
  onDocumentUpdated: jest.fn((...args: unknown[]) => {
    const handler = args.length === 2 ? args[1] : args[0];
    return handler;
  }),
  onDocumentDeleted: jest.fn((...args: unknown[]) => {
    const handler = args.length === 2 ? args[1] : args[0];
    return handler;
  }),
  onDocumentWritten: jest.fn((...args: unknown[]) => {
    const handler = args.length === 2 ? args[1] : args[0];
    return handler;
  }),
}));

jest.mock("firebase-functions/v2/scheduler", () => ({
  onSchedule: jest.fn((...args: unknown[]) => {
    const handler = args.length === 2 ? args[1] : args[0];
    return handler;
  }),
}));

// Reset all mocks before each test
beforeEach(() => {
  jest.clearAllMocks();
  resetMocks();
});

// Global test timeout
jest.setTimeout(10000);

// Suppress console output during tests (uncomment to enable)
// global.console = {
//   ...console,
//   log: jest.fn(),
//   info: jest.fn(),
//   warn: jest.fn(),
//   error: jest.fn(),
// };

// Export test utilities
export { mockFirebaseAdmin, resetMocks };
