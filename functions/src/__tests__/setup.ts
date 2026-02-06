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

// Mock firebase-functions
jest.mock("firebase-functions", () => ({
  https: {
    onCall: jest.fn((handler) => handler),
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
  },
  pubsub: {
    schedule: jest.fn(() => ({
      timeZone: jest.fn(() => ({
        onRun: jest.fn((handler) => handler),
      })),
    })),
  },
  config: jest.fn(() => ({})),
  logger: {
    log: jest.fn(),
    info: jest.fn(),
    warn: jest.fn(),
    error: jest.fn(),
    debug: jest.fn(),
  },
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
