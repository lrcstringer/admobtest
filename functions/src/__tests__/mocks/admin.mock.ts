/**
 * Firebase Admin SDK Mocks
 *
 * Provides comprehensive mocks for firebase-admin used in Cloud Functions testing.
 * Supports Firestore operations, Auth, and FieldValue operations.
 */

// Store for mock data
const mockCollections: Map<string, Map<string, unknown>> = new Map();
const mockSubcollections: Map<string, Map<string, Map<string, unknown>>> =
  new Map();

// Track operations for verification
export const mockOperations = {
  gets: [] as Array<{ collection: string; doc: string }>,
  sets: [] as Array<{ collection: string; doc: string; data: unknown }>,
  updates: [] as Array<{ collection: string; doc: string; data: unknown }>,
  deletes: [] as Array<{ collection: string; doc: string }>,
  queries: [] as Array<{ collection: string; conditions: unknown[] }>,
};

/**
 * Reset all mock data and operation tracking
 */
export function resetMocks(): void {
  mockCollections.clear();
  mockSubcollections.clear();
  mockOperations.gets = [];
  mockOperations.sets = [];
  mockOperations.updates = [];
  mockOperations.deletes = [];
  mockOperations.queries = [];
}

/**
 * Set mock data for a document
 */
export function setMockDoc(
  collection: string,
  docId: string,
  data: unknown
): void {
  if (!mockCollections.has(collection)) {
    mockCollections.set(collection, new Map());
  }
  mockCollections.get(collection)!.set(docId, data);
}

/**
 * Get mock data for a document
 */
export function getMockDoc(collection: string, docId: string): unknown {
  return mockCollections.get(collection)?.get(docId);
}

/**
 * Set mock data for multiple documents in a collection
 */
export function setMockCollection(
  collection: string,
  docs: Array<{ id: string; data: unknown }>
): void {
  const collectionMap = new Map<string, unknown>();
  docs.forEach(({ id, data }) => collectionMap.set(id, data));
  mockCollections.set(collection, collectionMap);
}

/**
 * Clear mock data for a collection
 */
export function clearMockCollection(collection: string): void {
  mockCollections.delete(collection);
}

// Create mock document reference
function createMockDocRef(
  collectionName: string,
  docId: string
): Record<string, unknown> {
  // Create the ref object first so we can reference it in the snapshot
  const docRef: Record<string, unknown> = {
    id: docId,
    path: `${collectionName}/${docId}`,
    get: jest.fn(),
    set: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
    collection: jest.fn(),
  };

  // Now set up the implementations
  docRef.get = jest.fn().mockImplementation(async () => {
    mockOperations.gets.push({ collection: collectionName, doc: docId });
    const data = mockCollections.get(collectionName)?.get(docId);
    return {
      exists: data !== undefined,
      id: docId,
      ref: docRef, // Return the full docRef with update method
      data: () => data,
    };
  });

  docRef.set = jest.fn().mockImplementation(async (data, options) => {
    mockOperations.sets.push({ collection: collectionName, doc: docId, data });
    if (!mockCollections.has(collectionName)) {
      mockCollections.set(collectionName, new Map());
    }
    if (options?.merge) {
      const existing = mockCollections.get(collectionName)?.get(docId) || {};
      mockCollections
        .get(collectionName)!
        .set(docId, { ...(existing as object), ...(data as object) });
    } else {
      mockCollections.get(collectionName)!.set(docId, data);
    }
    return { writeTime: new Date() };
  });

  docRef.update = jest.fn().mockImplementation(async (data) => {
    mockOperations.updates.push({
      collection: collectionName,
      doc: docId,
      data,
    });
    if (!mockCollections.has(collectionName)) {
      mockCollections.set(collectionName, new Map());
    }
    const existing = mockCollections.get(collectionName)?.get(docId) || {};
    mockCollections
      .get(collectionName)!
      .set(docId, { ...(existing as object), ...(data as object) });
    return { writeTime: new Date() };
  });

  docRef.delete = jest.fn().mockImplementation(async () => {
    mockOperations.deletes.push({ collection: collectionName, doc: docId });
    mockCollections.get(collectionName)?.delete(docId);
    return { writeTime: new Date() };
  });

  docRef.collection = jest.fn().mockImplementation((subcollectionName: string) => {
    return createMockCollectionRef(`${collectionName}/${docId}/${subcollectionName}`);
  });

  return docRef;
}

// Create mock query
function createMockQuery(
  collectionName: string,
  conditions: unknown[]
): Record<string, unknown> {
  const query = {
    where: jest.fn().mockImplementation((field, op, value) => {
      conditions.push({ field, op, value });
      return createMockQuery(collectionName, conditions);
    }),
    orderBy: jest.fn().mockImplementation((field, direction) => {
      conditions.push({ orderBy: field, direction });
      return createMockQuery(collectionName, conditions);
    }),
    limit: jest.fn().mockImplementation((n) => {
      conditions.push({ limit: n });
      return createMockQuery(collectionName, conditions);
    }),
    startAfter: jest.fn().mockImplementation((value) => {
      conditions.push({ startAfter: value });
      return createMockQuery(collectionName, conditions);
    }),
    get: jest.fn().mockImplementation(async () => {
      mockOperations.queries.push({ collection: collectionName, conditions });
      const collectionData = mockCollections.get(collectionName);
      const docs: Array<{
        id: string;
        exists: boolean;
        ref: { id: string; path: string };
        data: () => unknown;
      }> = [];

      if (collectionData) {
        collectionData.forEach((data, id) => {
          docs.push({
            id,
            exists: true,
            ref: { id, path: `${collectionName}/${id}` },
            data: () => data,
          });
        });
      }

      return {
        empty: docs.length === 0,
        size: docs.length,
        docs,
        forEach: (callback: (doc: unknown) => void) => docs.forEach(callback),
      };
    }),
    count: jest.fn().mockReturnValue({
      get: jest.fn().mockImplementation(async () => {
        const collectionData = mockCollections.get(collectionName);
        return {
          data: () => ({ count: collectionData?.size || 0 }),
        };
      }),
    }),
    select: jest.fn().mockImplementation((..._fields: string[]) => {
      // select() returns the same query with limited fields (we return all for simplicity)
      return createMockQuery(collectionName, conditions);
    }),
  };
  return query;
}

// Create mock collection reference
function createMockCollectionRef(
  collectionName: string
): Record<string, unknown> {
  return {
    doc: jest.fn().mockImplementation((docId?: string) => {
      const id = docId || `auto_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
      return createMockDocRef(collectionName, id);
    }),
    add: jest.fn().mockImplementation(async (data) => {
      const docId = `auto_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
      if (!mockCollections.has(collectionName)) {
        mockCollections.set(collectionName, new Map());
      }
      mockCollections.get(collectionName)!.set(docId, data);
      mockOperations.sets.push({ collection: collectionName, doc: docId, data });
      return createMockDocRef(collectionName, docId);
    }),
    where: jest.fn().mockImplementation((field, op, value) => {
      return createMockQuery(collectionName, [{ field, op, value }]);
    }),
    orderBy: jest.fn().mockImplementation((field, direction) => {
      return createMockQuery(collectionName, [{ orderBy: field, direction }]);
    }),
    limit: jest.fn().mockImplementation((n) => {
      return createMockQuery(collectionName, [{ limit: n }]);
    }),
    get: jest.fn().mockImplementation(async () => {
      const collectionData = mockCollections.get(collectionName);
      const docs: Array<{
        id: string;
        exists: boolean;
        ref: { id: string; path: string };
        data: () => unknown;
      }> = [];

      if (collectionData) {
        collectionData.forEach((data, id) => {
          docs.push({
            id,
            exists: true,
            ref: { id, path: `${collectionName}/${id}` },
            data: () => data,
          });
        });
      }

      return {
        empty: docs.length === 0,
        size: docs.length,
        docs,
        forEach: (callback: (doc: unknown) => void) => docs.forEach(callback),
      };
    }),
    count: jest.fn().mockReturnValue({
      get: jest.fn().mockImplementation(async () => {
        const collectionData = mockCollections.get(collectionName);
        return {
          data: () => ({ count: collectionData?.size || 0 }),
        };
      }),
    }),
  };
}

// Shared batch mock — returned by every batch() call so tests can inspect it
const mockBatch = {
  set: jest.fn().mockImplementation((docRef: { path: string; id: string }, data: unknown) => {
    const path = docRef.path || "";
    const parts = path.split("/");
    const docId = parts.pop() || docRef.id;
    const collection = parts.join("/");
    mockOperations.sets.push({ collection, doc: docId, data });
  }),
  update: jest.fn().mockImplementation((docRef: { path: string; id: string }, data: unknown) => {
    const path = docRef.path || "";
    const parts = path.split("/");
    const docId = parts.pop() || docRef.id;
    const collection = parts.join("/");
    mockOperations.updates.push({ collection, doc: docId, data });
  }),
  delete: jest.fn(),
  commit: jest.fn().mockResolvedValue([]),
};

// Mock Firestore instance
const mockFirestore = {
  collection: jest.fn().mockImplementation((name: string) => {
    return createMockCollectionRef(name);
  }),
  doc: jest.fn().mockImplementation((path: string) => {
    const parts = path.split("/");
    if (parts.length >= 2) {
      return createMockDocRef(parts[0], parts[1]);
    }
    throw new Error(`Invalid document path: ${path}`);
  }),
  batch: jest.fn().mockReturnValue(mockBatch),
  runTransaction: jest.fn().mockImplementation(async (callback) => {
    const transaction = {
      get: jest.fn().mockImplementation(async (docRef: { get: () => Promise<unknown> }) => {
        return docRef.get();
      }),
      set: jest.fn(),
      update: jest.fn().mockImplementation((docRef: { path: string; id: string }, data: unknown) => {
        const path = docRef.path || "";
        const parts = path.split("/");
        const docId = parts.pop() || docRef.id;
        const collection = parts.join("/");
        mockOperations.updates.push({ collection, doc: docId, data });
      }),
      delete: jest.fn(),
    };
    return callback(transaction);
  }),
};

// Mock Timestamp class
class MockTimestamp {
  constructor(
    public readonly seconds: number,
    public readonly nanoseconds: number
  ) {}

  toDate(): Date {
    return new Date(this.seconds * 1000 + this.nanoseconds / 1000000);
  }

  toMillis(): number {
    return this.seconds * 1000 + Math.floor(this.nanoseconds / 1000000);
  }

  static now(): MockTimestamp {
    const now = Date.now();
    return new MockTimestamp(Math.floor(now / 1000), (now % 1000) * 1000000);
  }

  static fromDate(date: Date): MockTimestamp {
    const ms = date.getTime();
    return new MockTimestamp(Math.floor(ms / 1000), (ms % 1000) * 1000000);
  }

  static fromMillis(milliseconds: number): MockTimestamp {
    return new MockTimestamp(
      Math.floor(milliseconds / 1000),
      (milliseconds % 1000) * 1000000
    );
  }
}

// Mock FieldValue
const mockFieldValue = {
  serverTimestamp: jest.fn().mockReturnValue({ _serverTimestamp: true }),
  increment: jest.fn().mockImplementation((n: number) => ({ _increment: n })),
  arrayUnion: jest.fn().mockImplementation((...elements: unknown[]) => ({
    _arrayUnion: elements,
  })),
  arrayRemove: jest.fn().mockImplementation((...elements: unknown[]) => ({
    _arrayRemove: elements,
  })),
  delete: jest.fn().mockReturnValue({ _delete: true }),
};

// Mock Firebase Admin SDK
export const mockFirebaseAdmin = {
  initializeApp: jest.fn(),
  credential: {
    cert: jest.fn(),
    applicationDefault: jest.fn(),
  },
  firestore: jest.fn().mockReturnValue(mockFirestore),
  auth: jest.fn().mockReturnValue({
    getUser: jest.fn(),
    createUser: jest.fn(),
    updateUser: jest.fn(),
    deleteUser: jest.fn(),
    verifyIdToken: jest.fn(),
    setCustomUserClaims: jest.fn(),
  }),
  storage: jest.fn().mockReturnValue({
    bucket: jest.fn().mockReturnValue({
      file: jest.fn().mockReturnValue({
        save: jest.fn(),
        download: jest.fn(),
        delete: jest.fn(),
        exists: jest.fn().mockResolvedValue([true]),
        getSignedUrl: jest.fn().mockResolvedValue(["https://example.com/signed-url"]),
      }),
    }),
  }),
};

// Attach Timestamp and FieldValue to firestore namespace
(mockFirebaseAdmin.firestore as unknown as Record<string, unknown>).Timestamp = MockTimestamp;
(mockFirebaseAdmin.firestore as unknown as Record<string, unknown>).FieldValue = mockFieldValue;

// Export utilities
export { mockFirestore, MockTimestamp, mockFieldValue };
