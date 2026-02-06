/**
 * Firestore Query Builder Mock
 *
 * Provides a fluent API for building mock queries with filtering support.
 * Used for testing complex Firestore queries in Cloud Functions.
 */

import { setMockDoc, setMockCollection } from "./admin.mock";

export interface MockDocument {
  id: string;
  data: Record<string, unknown>;
}

/**
 * Helper to create a mock Firestore Timestamp
 */
export function createTimestamp(date: Date | string | number): {
  toDate: () => Date;
  toMillis: () => number;
  seconds: number;
  nanoseconds: number;
} {
  const d = date instanceof Date ? date : new Date(date);
  const ms = d.getTime();
  return {
    toDate: () => d,
    toMillis: () => ms,
    seconds: Math.floor(ms / 1000),
    nanoseconds: (ms % 1000) * 1000000,
  };
}

/**
 * Helper to set up a complete collection with documents
 */
export function setupMockCollection(
  collectionName: string,
  documents: MockDocument[]
): void {
  setMockCollection(
    collectionName,
    documents.map((doc) => ({
      id: doc.id,
      data: doc.data,
    }))
  );
}

/**
 * Helper to set up a single document
 */
export function setupMockDocument(
  collectionName: string,
  docId: string,
  data: Record<string, unknown>
): void {
  setMockDoc(collectionName, docId, data);
}

/**
 * Create a mock context object for Cloud Functions
 */
export function createMockCallContext(options: {
  uid?: string;
  email?: string;
  token?: Record<string, unknown>;
  admin?: boolean;
  appCheckToken?: boolean;
  rawRequest?: {
    ip?: string;
    headers?: Record<string, string>;
  };
} | null = {}): {
  auth: { uid: string; token: Record<string, unknown> } | null;
  app?: { appId: string };
  rawRequest?: { ip?: string; headers?: Record<string, string> };
} {
  // Handle null for unauthenticated context
  if (options === null) {
    return { auth: null };
  }

  return {
    auth: options.uid
      ? {
          uid: options.uid,
          token: {
            email: options.email || `${options.uid}@test.com`,
            admin: options.admin || false,
            ...(options.token || {}),
          },
        }
      : null,
    app: options.appCheckToken ? { appId: "test-app" } : undefined,
    rawRequest: options.rawRequest,
  };
}

/**
 * Create a mock scheduled context for Pub/Sub functions
 */
export function createMockScheduledContext(): {
  eventId: string;
  timestamp: string;
  eventType: string;
  resource: { name: string };
} {
  return {
    eventId: `test-event-${Date.now()}`,
    timestamp: new Date().toISOString(),
    eventType: "google.pubsub.topic.publish",
    resource: {
      name: "projects/test-project/topics/test-topic",
    },
  };
}

/**
 * Filter mock documents based on query conditions
 */
export function filterDocuments(
  documents: MockDocument[],
  conditions: Array<{
    field?: string;
    op?: string;
    value?: unknown;
    orderBy?: string;
    direction?: "asc" | "desc";
    limit?: number;
    startAfter?: unknown;
  }>
): MockDocument[] {
  let result = [...documents];

  for (const condition of conditions) {
    if (condition.field && condition.op && condition.value !== undefined) {
      result = result.filter((doc) => {
        const fieldValue = getNestedValue(doc.data, condition.field!);
        return compareValues(fieldValue, condition.op!, condition.value);
      });
    }

    if (condition.orderBy) {
      result.sort((a, b) => {
        const aVal = getNestedValue(a.data, condition.orderBy!);
        const bVal = getNestedValue(b.data, condition.orderBy!);
        const cmp = compareForSort(aVal, bVal);
        return condition.direction === "desc" ? -cmp : cmp;
      });
    }

    if (condition.limit) {
      result = result.slice(0, condition.limit);
    }
  }

  return result;
}

/**
 * Get a nested value from an object using dot notation
 */
function getNestedValue(obj: Record<string, unknown>, path: string): unknown {
  return path.split(".").reduce((current: unknown, key) => {
    if (current && typeof current === "object" && key in current) {
      return (current as Record<string, unknown>)[key];
    }
    return undefined;
  }, obj);
}

/**
 * Compare values based on Firestore operators
 */
function compareValues(
  fieldValue: unknown,
  operator: string,
  targetValue: unknown
): boolean {
  switch (operator) {
    case "==":
      return fieldValue === targetValue;
    case "!=":
      return fieldValue !== targetValue;
    case "<":
      return (fieldValue as number) < (targetValue as number);
    case "<=":
      return (fieldValue as number) <= (targetValue as number);
    case ">":
      return (fieldValue as number) > (targetValue as number);
    case ">=":
      return (fieldValue as number) >= (targetValue as number);
    case "in":
      return Array.isArray(targetValue) && targetValue.includes(fieldValue);
    case "not-in":
      return Array.isArray(targetValue) && !targetValue.includes(fieldValue);
    case "array-contains":
      return Array.isArray(fieldValue) && fieldValue.includes(targetValue);
    case "array-contains-any":
      return (
        Array.isArray(fieldValue) &&
        Array.isArray(targetValue) &&
        targetValue.some((v) => fieldValue.includes(v))
      );
    default:
      return false;
  }
}

/**
 * Compare values for sorting
 */
function compareForSort(a: unknown, b: unknown): number {
  if (a === undefined && b === undefined) return 0;
  if (a === undefined) return 1;
  if (b === undefined) return -1;

  if (typeof a === "string" && typeof b === "string") {
    return a.localeCompare(b);
  }

  if (typeof a === "number" && typeof b === "number") {
    return a - b;
  }

  if (a instanceof Date && b instanceof Date) {
    return a.getTime() - b.getTime();
  }

  // Handle mock timestamps
  if (
    typeof a === "object" &&
    a !== null &&
    "toMillis" in a &&
    typeof b === "object" &&
    b !== null &&
    "toMillis" in b
  ) {
    return (
      (a as { toMillis: () => number }).toMillis() -
      (b as { toMillis: () => number }).toMillis()
    );
  }

  return 0;
}

/**
 * Create a mock batch writer for testing batch operations
 */
export function createMockBatch(): {
  operations: Array<{ type: string; ref: unknown; data?: unknown }>;
  set: jest.Mock;
  update: jest.Mock;
  delete: jest.Mock;
  commit: jest.Mock;
} {
  const operations: Array<{ type: string; ref: unknown; data?: unknown }> = [];

  return {
    operations,
    set: jest.fn((ref, data) => {
      operations.push({ type: "set", ref, data });
    }),
    update: jest.fn((ref, data) => {
      operations.push({ type: "update", ref, data });
    }),
    delete: jest.fn((ref) => {
      operations.push({ type: "delete", ref });
    }),
    commit: jest.fn().mockResolvedValue(operations.map(() => ({ writeTime: new Date() }))),
  };
}

/**
 * Create a mock transaction for testing transactional operations
 */
export function createMockTransaction(): {
  operations: Array<{ type: string; ref: unknown; data?: unknown }>;
  get: jest.Mock;
  set: jest.Mock;
  update: jest.Mock;
  delete: jest.Mock;
} {
  const operations: Array<{ type: string; ref: unknown; data?: unknown }> = [];

  return {
    operations,
    get: jest.fn().mockImplementation(async (docRef) => {
      return docRef.get();
    }),
    set: jest.fn((ref, data) => {
      operations.push({ type: "set", ref, data });
    }),
    update: jest.fn((ref, data) => {
      operations.push({ type: "update", ref, data });
    }),
    delete: jest.fn((ref) => {
      operations.push({ type: "delete", ref });
    }),
  };
}
