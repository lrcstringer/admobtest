# iMaliChat — Unified Chat & Communities
## Complete Implementation Plan

**Version:** 3.4 (Comprehensive Review — State Machines, Atomicity Fixes, Admin Portal, Edge Cases, Error Handling)
**Date:** February 17, 2026
**Scope:** All Phases (14 weeks)
- Phase 1-2: P2P Messaging + Communities (Regular + Stokvel) — with E2EE from day one
- Phase 3: iMali Gifts + Token Spray
- Phase 4: Sharing, Deep Links, Notifications, Security, Media, Polish & Launch

---

## 1. Context & Motivation

The app currently has **two separate, disconnected systems**:

1. **P2P Chat** (Chat tab, Tab 2)
   - Collections: `chatThreads`, `chatMessages` (flat)
   - BLoC: `ChatBloc` (19 events, 349 lines)
   - Cloud Functions: `chat.ts` (814 lines) — token transfers via ledger
   - 8 screens in `lib/presentation/screens/chat/`

2. **Stokvel Groups** (standalone `/groups` route, outside bottom nav)
   - Collections: `groups/{id}` with `members`, `transactions`, `pendingApprovals` subcollections
   - BLoC: `GroupBloc` (~24 events, 722 lines)
   - Cloud Functions: `groups.ts` (~1900 lines) — full financial lifecycle
   - Ledger: `ledger/groupAccounts.ts` — double-entry bookkeeping
   - 5 screens in `lib/presentation/screens/groups/`

**Goal:** Build ONE unified Chat/Community/Group system where:
- P2P messaging and community group chats live in the same Chat tab
- Stokvel communities are "super-charged" regular communities with full accounting
- All existing stokvel financial features (contributions, payouts, penalties, approvals) are retained
- The user experience is seamless — one inbox, one navigation tree

---

## 2. Key Architectural Decisions

### 2.1 New Collections (Clean Cut)

The app is pre-production with only test data. We create fresh Firestore collections rather than migrating existing ones.

```
Firestore Structure (New):

/conversations/{conversationId}              ← P2P direct messages (replaces chatThreads)
  └─ /messages/{messageId}                   ← Subcollection (replaces flat chatMessages)

/communities/{communityId}                   ← All community types (replaces groups)
  ├─ /messages/{messageId}                   ← Community chat (NEW — groups had no messaging)
  ├─ /members/{userId}                       ← Membership records (from groups/members)
  ├─ /transactions/{transactionId}           ← Financial transactions (from groups/transactions)
  └─ /pendingApprovals/{approvalId}          ← Approval workflows (from groups/pendingApprovals)
```

**Rationale:**
- Existing `chatMessages` is flat (not subcollection) — can't apply per-conversation security rules
- Existing `chatThreads` has single `unreadCount` int — needs per-user map for communities
- Existing `groups` has no messaging capability — adding it requires a new subcollection anyway
- Clean schema avoids data integrity issues from incremental migration

### 2.2 Backend Reuse Strategy

- **Ledger code stays unchanged.** `ledger/groupAccounts.ts` uses account format `group:{id}`. We'll use `group:{communityId}` — the ledger doesn't care about the Firestore collection name.
- **Extract helpers** from `groups.ts` into `helpers/communityHelpers.ts` (validation, permissions, member checks).
- **Create `communities.ts`** (~1800 lines) adapted from `groups.ts`, referencing `communities` collection.
- **Create `conversations.ts`** (~600 lines) adapted from `chat.ts`, using subcollection messages.
- Old `chat.ts` and `groups.ts` remain exported in `index.ts` but deprecated.

### 2.3 Three Separate BLoCs

| BLoC | Scope | Replaces | Provider Level |
|------|-------|----------|----------------|
| **ConversationBloc** | P2P thread list + messages | ChatBloc | App-level (powers tab badge) |
| **CommunityBloc** | Community CRUD, membership, financials | GroupBloc | App-level (powers tab badge) |
| **CommunityMessagingBloc** | One community's chat messages | — (new) | Scoped per community detail screen |

### 2.4 Entity Naming

| Existing | New | Notes |
|----------|-----|-------|
| `ChatThread` | `Conversation` | P2P direct messages |
| `ChatCard` | `Message` | Unified for both P2P and community |
| `Group` | `Community` | Regular + stokvel types |
| `GroupMember` | `CommunityMember` | Same 5-role hierarchy |
| `GroupTransaction` | `CommunityTransaction` | Same financial flow |
| `PendingApproval` | `CommunityApproval` | Same approval workflow |
| `GroupSettings` | `CommunitySettings` | Extended with messaging settings |
| `StokvelSettings` | `StokvelSettings` | **Reused as-is** |
| `StokvelAnalytics` | `StokvelAnalytics` | **Reused as-is** |

### 2.5 Deprecation Strategy

Old files marked `@deprecated` but left compilable. Removed in a follow-up cleanup PR after the unified system is verified stable in testing. This prevents breaking the app during the transition.

### 2.6 Scope Exclusions (Deferred to Follow-Up)

The following are deliberately **out of scope** for this plan and will be addressed in follow-up work:

| Item | Reason | Follow-Up |
|------|--------|-----------|
| **Admin portal — community management** | The admin portal (`lib/presentation/admin/`) currently has no group management screens. Adding community moderation, member oversight, and financial dashboards to the admin portal is a separate workstream. | Create admin community screens after consumer app is stable. Reuse existing admin patterns (sidebar shell, role guards, CRUD tables). |
| **Admin portal — message moderation** | Content moderation for community messages requires a dedicated moderation queue, reported messages review, and bulk actions. | Phase 5: Admin moderation dashboard. For now, community admins moderate via the consumer app. |
| **Old data migration** | Existing `chatThreads`, `chatMessages`, `groups` collections are NOT migrated. The app is pre-production with test data only. | If needed later, write a one-time migration script. |
| **Multi-device support** | Single-device-per-user assumption (Section 2.7). Multi-device would require multi-device Signal Protocol sessions (sesame). | Evaluate post-launch based on user feedback. |
| **Deprecated file removal** | Old `chat_*` and `group_*` files are marked `@deprecated` but left compilable. | Cleanup PR after unified system verified stable. |

### 2.7 End-to-End Encryption (E2EE) — Foundational Layer

All personal message content is encrypted end-to-end from day one. The server never sees plaintext message bodies.

**Protocol:**
- **P2P Conversations:** Signal Protocol — X3DH (Extended Triple Diffie-Hellman) key agreement + Double Ratchet for forward secrecy and post-compromise security.
- **Community Messages:** Sender Keys — each member holds a symmetric Sender Key for the community. One encryption per send (vs N encryptions for pairwise). Sender Keys are distributed to each member via their individual P2P Signal sessions.
- **Symmetric Cipher:** AES-256-GCM for all message content and media encryption.

**Simplifying Assumptions (Pre-Production):**
1. **Single device per user.** The app enforces one active device via Play Integrity + device binding. No multi-device key synchronisation needed.
2. **Trusted server.** Google Cloud infrastructure is trusted for key distribution. No out-of-band safety number verification required. The server stores public key bundles but never has access to private keys.
3. **Re-registration = new keys.** When a user gets a new phone, they re-register. Fresh identity and pre-keys are generated. Old messages are only recoverable via key backup.

**What Is Encrypted:**
| Data | Encrypted? | Rationale |
|------|-----------|-----------|
| Message text content | Yes (E2EE) | Personal/sensitive content |
| Image/voice media files | Yes (AES-256-GCM) | Personal media |
| Media thumbnails | Yes (AES-256-GCM) | Could reveal content |
| Inbox preview text | Yes (per-user encryption) | Each user gets their own encrypted preview they can decrypt locally |
| Gift personal messages | Yes (E2EE) | Personal content |
| Token Spray celebration messages | Yes (E2EE) | Personal content |

**What Is NOT Encrypted (Intentionally):**
| Data | Why Plaintext |
|------|--------------|
| Token amounts, transaction IDs, ledger references | Cloud Functions must process financial operations server-side |
| Message type, status, timestamps | Needed for queries, pagination, ordering |
| Sender ID, sender name | Needed for push notifications and display |
| Reactions (emoji + userId) | Not sensitive content; needed for real-time aggregation |
| System messages (member joined, payout completed) | Generated server-side, no personal content |
| Community metadata (name, settings, membership) | Needed for server-side access control and queries |
| Gift/spray status, amounts, financial metadata | Needed for Cloud Function lifecycle management |

**Key Backup:**
- Users can back up their identity key + all session states to Google Drive, encrypted with a user-chosen passphrase (PBKDF2-derived key).
- On re-registration with a new phone, the user restores from backup to decrypt old message history.
- Without backup restoration, old messages cannot be decrypted (by design — forward secrecy).
- Stokvel community conversations are especially important to preserve, so key backup is strongly encouraged during onboarding.

**Impact on Architecture:**
- Messages store `ciphertext` (Base64) instead of plaintext `textContent` on the server.
- Conversation/community docs store per-user encrypted `lastMessage` previews.
- Media files in Cloud Storage are encrypted blobs (not readable by server).
- Cloud Functions handle message routing, unread counts, and financial operations — but never read message content.
- New Firestore documents: `/users/{id}/keys/bundle` (public key bundle), `/users/{id}/keys/backup` (encrypted backup metadata).
- New Flutter services: `CryptoService`, `KeyManagementService`, `KeyBackupService`.

---

## 3. Firestore Schema — Complete

### 3.1 Conversations Collection

```javascript
/conversations/{conversationId}
{
  id: string,                          // Auto-generated Firestore ID
  type: "p2p",                         // Always "p2p" for direct messages

  // Participants (always exactly 2)
  participantIds: [userId1, userId2],  // Array for array-contains queries

  // Denormalized participant data (avoids extra reads for list display)
  participants: {
    [userId1]: {
      displayName: string,
      avatarUrl: string | null,
    },
    [userId2]: {
      displayName: string,
      avatarUrl: string | null,
    }
  },

  // Last message preview (for inbox list) — E2EE encrypted per user
  lastMessage: {
    senderId: string,
    senderName: string,
    type: "text" | "image" | "voice" | "tokenSend" | "tokenRequest" | "gift" | "tokenSpray" | "system",
    timestamp: Timestamp,
    // Per-user encrypted preview: each participant gets their own encrypted copy
    // so they can decrypt and display "Hey, are you coming to..." in the inbox
    encryptedPreviews: {
      [userId1]: string,               // Base64 AES-256-GCM ciphertext of truncated preview (100 chars)
      [userId2]: string,               // Encrypted with each user's current message key
    },
    // Fallback for system messages (unencrypted)
    plaintextPreview: string | null,   // Only set for system messages (e.g., "User joined")
  },
  lastMessageAt: Timestamp,           // Top-level for sort index

  // Per-user state (maps scale to N users)
  unreadCounts: {
    [userId1]: number,
    [userId2]: number,
  },
  archived: {
    [userId1]: boolean,
    [userId2]: boolean,
  },
  pinned: {
    [userId1]: boolean,
    [userId2]: boolean,
  },
  muted: {
    [userId1]: boolean,
    [userId2]: boolean,
  },

  // Metadata
  createdAt: Timestamp,
  createdBy: string,
  updatedAt: Timestamp | null,
}
```

### 3.2 Conversation Messages Subcollection

```javascript
/conversations/{conversationId}/messages/{messageId}
{
  id: string,
  conversationId: string,              // Denormalized parent ID

  // Sender
  senderId: string,
  senderName: string,
  senderAvatarUrl: string | null,

  // Content (E2EE)
  type: "text" | "image" | "voice" | "tokenSend" | "tokenRequest" | "gift" | "tokenSpray" | "system",
  status: "sending" | "sent" | "failed" | "paid" | "declined",
  ciphertext: string | null,            // Base64-encoded encrypted message content (E2EE)
  textContent: null,                     // ALWAYS null on server — plaintext only exists on client after decryption

  // E2EE metadata
  e2ee: {
    protocol: "signal" | "sender_key",   // "signal" for P2P, "sender_key" for communities
    senderKeyChainId: number | null,     // For sender_key protocol: which chain version
    messageNumber: number | null,        // Ratchet message counter (for ordering/dedup)
    dhPublicKey: string | null,          // Current DH ratchet public key (Base64) — needed for Double Ratchet DH ratchet step
  } | null,                              // null for system messages (unencrypted)

  // X3DH session establishment header (only on FIRST message in a new P2P session)
  x3dhHeader: {
    identityKey: string,                 // Sender's identity public key (Base64)
    ephemeralKey: string,                // Sender's ephemeral public key (Base64)
    oneTimePreKeyId: number | null,      // Which OTK was consumed (null if none available)
  } | null,                              // null for all messages after session established

  // Token operations (UNENCRYPTED — needed for Cloud Function processing)
  tokenAmount: number | null,
  recipientId: string | null,          // For tokenSend/tokenRequest
  ledgerJournalId: string | null,      // Reference to ledger journal entry

  // Media (E2EE — encrypted blobs in Cloud Storage)
  media: {
    url: string,                       // Points to encrypted blob in Cloud Storage
    thumbnailUrl: string | null,       // Points to encrypted thumbnail blob
    fileName: string,                  // Original filename (unencrypted for display)
    fileSize: number,                  // Encrypted file size in bytes
    mimeType: string,                  // "image/jpeg", "audio/m4a" (unencrypted for UI rendering hints)
    duration: number | null,           // Seconds (voice only, unencrypted for UI)
    width: number | null,              // Pixels (images only, unencrypted for layout)
    height: number | null,
    mediaKey: string | null,           // AES-256-GCM key for this media file, encrypted inside the message ciphertext
    thumbKey: string | null,           // AES-256-GCM key for thumbnail, encrypted inside the message ciphertext
  } | null,

  // Gift metadata (unencrypted — for card UI rendering and server-side lifecycle management)
  gift: {
    giftId: string,
    amount: number,
    style: "ndlovukazi" | "celebration" | "love" | "birthday" | "professional",
    status: "pending" | "opened" | "claimed" | "expired",  // Updated by server on lifecycle events
    recipientId: string | null,        // For community gifts (targeted to a member)
    recipientName: string | null,
    // NOTE: Personal message is NOT here — it is in the E2EE ciphertext
  } | null,

  // Token Spray metadata (unencrypted — for card UI rendering and server-side updates)
  tokenSpray: {
    sprayId: string,
    recipientId: string,
    recipientName: string,
    occasion: string,                  // "birthday", "new_job", etc.
    currentTotal: number,              // Live-updated by server on each contribution
    contributorCount: number,          // Live-updated by server
    status: "active" | "closed" | "claimed" | "expired",
    targetAmount: number | null,
    expiresAt: Timestamp,
    // NOTE: Personal celebration message is NOT here — it is in the E2EE ciphertext
  } | null,

  // Interactions
  reactions: {                         // Max 6 emoji types per message
    "heart": [userId1, userId2],
    "thumbsup": [userId3],
  },
  replyTo: {
    messageId: string,
    senderName: string,
    text: string,                      // Truncated preview (50 chars)
    type: string,
  } | null,

  // Timestamps
  createdAt: Timestamp,
  expiresAt: Timestamp | null,         // Token requests: 7 days from creation
  actionedAt: Timestamp | null,        // When token request was accepted/declined

  // Deletion
  deletedFor: [string],                // UserIds who deleted for themselves
  deletedForEveryone: boolean,
  deletedAt: Timestamp | null,
}
```

### 3.3 Communities Collection

```javascript
/communities/{communityId}
{
  id: string,
  type: "regular" | "stokvel",

  // Basic info
  name: string,                        // Max 50 chars
  description: string | null,          // Max 200 chars
  avatarUrl: string | null,

  // Membership
  ownerId: string,                     // Creator userId
  memberIds: [string],                 // All members (2-100) — for array-contains queries
                                       // NOTE: Firestore array-contains works efficiently up to ~100 members.
                                       // Max community size is capped at 100 members in settings.maxMembers.
                                       // If future scaling beyond 100 is needed, switch to subcollection-based
                                       // membership queries (already have /members/{userId} subcollection).
  adminIds: [string],                  // Owner + promoted admins
  memberCount: number,                 // Denormalized count

  // Status
  status: "active" | "suspended" | "closed",

  // Settings
  settings: {
    maxMembers: number,                // Default: 100
    allowMemberInvites: boolean,       // Default: true
    onlyAdminsPost: boolean,           // Default: false
    membersCanShareMedia: boolean,     // Default: true
    enableFinancials: boolean,         // Always true for stokvel, toggle for regular
    requireApprovalAbove: number,      // Token threshold for approval flow (default: 5000)
    allowMemberWithdrawals: boolean,   // Default: false for stokvel
    contributionCycle: "none" | "weekly" | "monthly",
    contributionAmount: number,        // In tokens
    penaltyPercentage: number,         // Late penalty %
  },

  // Stokvel-specific (null if type = "regular")
  stokvel: {
    payoutType: "rotating" | "lottery" | "fixed_date" | "goal_reached",
    payoutSchedule: string,            // Cron expression
    currentPayoutRecipient: string | null,
    nextPayoutDate: Timestamp | null,
    payoutOrder: [string],             // Ordered member IDs for rotating
    totalCyclesCompleted: number,
    totalContributed: number,          // All-time in tokens
    rules: {
      latePenaltyAmount: number | null,
      latePenaltyDays: number | null,
      maxMissedPayments: number,
      allowPartialPayments: boolean,
    },
  } | null,

  // Last message preview (for inbox list) — E2EE encrypted per user
  lastMessage: {
    senderId: string,
    senderName: string,
    type: string,
    timestamp: Timestamp,
    // Per-user encrypted preview: each member gets their own encrypted copy
    encryptedPreviews: {
      [userId]: string,                // Base64 AES-256-GCM ciphertext of truncated preview
    },
    plaintextPreview: string | null,   // Only set for system messages (unencrypted)
  },
  lastMessageAt: Timestamp,

  // Per-user state
  unreadCounts: {
    [userId]: number,                  // Per-member unread count
  },
  muted: {
    [userId]: boolean,
  },

  // Financial (denormalized from ledger)
  totalBalance: number,                // Current token balance

  // Timestamps
  createdAt: Timestamp,
  updatedAt: Timestamp,
}
```

### 3.4 Community Messages Subcollection

```javascript
/communities/{communityId}/messages/{messageId}
{
  // Same structure as conversation messages (section 3.2), plus:
  communityId: string,                 // Denormalized parent

  // E2EE: community messages use Sender Keys protocol
  // The e2ee.protocol field will be "sender_key" instead of "signal"
  // ciphertext is encrypted once using the sender's Sender Key for this community

  // Community-specific system events (UNENCRYPTED — server-generated)
  systemEventType: string | null,      // "member_joined", "member_left", "payout_completed", etc.
  systemEventData: {} | null,          // Additional data for system messages
}
```

### 3.5 Community Members Subcollection

```javascript
/communities/{communityId}/members/{userId}
{
  id: string,                          // Same as userId
  communityId: string,
  userId: string,
  displayName: string,
  avatarUrl: string | null,
  role: "owner" | "admin" | "treasurer" | "member" | "viewer",
  status: "active" | "invited" | "blocked",
  contributionBalance: number,         // Running total of this member's contributions
  joinedAt: Timestamp | null,          // Null if still invited
  invitedBy: string,
  invitedAt: Timestamp,
  lastReadAt: Timestamp | null,        // For unread tracking
}
```

### 3.6 Community Transactions Subcollection

```javascript
/communities/{communityId}/transactions/{transactionId}
{
  id: string,
  communityId: string,
  type: "contribution" | "withdrawal" | "transfer_in" | "transfer_out" | "penalty" | "payout",
  status: "pending" | "approved" | "completed" | "rejected",
  amount: number,                      // In tokens
  memberId: string,                    // Who initiated
  memberName: string,
  description: string | null,
  journalId: string | null,            // Ledger journal reference
  createdAt: Timestamp,
  completedAt: Timestamp | null,
  approvedBy: string | null,
  rejectedBy: string | null,
  rejectionReason: string | null,
}
```

### 3.7 Community Pending Approvals Subcollection

```javascript
/communities/{communityId}/pendingApprovals/{approvalId}
{
  id: string,
  communityId: string,
  transactionId: string,               // Reference to the transaction
  requestedBy: string,
  requestedByName: string,
  amount: number,
  type: string,                        // Transaction type
  description: string | null,
  approvers: [string],                 // UserIds who have approved
  requiredApprovals: number,           // How many needed
  status: "pending" | "approved" | "rejected",
  createdAt: Timestamp,
  expiresAt: Timestamp,                // Auto-reject after expiry
}
```

### 3.8 Firestore Indexes Required

```yaml
# Conversations
conversations:
  - participantIds (array-contains) + lastMessageAt (desc)
  - participantIds (array-contains) + archived.{userId} + lastMessageAt (desc)

# Conversation messages (subcollection)
conversations/{id}/messages:
  - createdAt (desc)

# Communities
communities:
  - memberIds (array-contains) + lastMessageAt (desc)
  - memberIds (array-contains) + type + lastMessageAt (desc)
  - memberIds (array-contains) + status + lastMessageAt (desc)

# Community messages (subcollection)
communities/{id}/messages:
  - createdAt (desc)

# Community transactions (subcollection)
communities/{id}/transactions:
  - createdAt (desc)
  - status + createdAt (desc)

# Community members (subcollection)
communities/{id}/members:
  - status + role

# Community pending approvals (subcollection)
communities/{id}/pendingApprovals:
  - status + createdAt (desc)
```

### 3.9 Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    function isAuthenticated() {
      return request.auth != null;
    }

    function isParticipant(data) {
      return request.auth.uid in data.participantIds;
    }

    function isCommunityMember(data) {
      return request.auth.uid in data.memberIds;
    }

    // Conversations — read if participant, all writes via Cloud Functions
    match /conversations/{convId} {
      allow read: if isAuthenticated() && isParticipant(resource.data);
      allow write: if false;

      match /messages/{msgId} {
        allow read: if isAuthenticated() &&
          isParticipant(get(/databases/$(database)/documents/conversations/$(convId)).data);
        allow write: if false;
      }
    }

    // Communities — read if member, all writes via Cloud Functions
    match /communities/{commId} {
      allow read: if isAuthenticated() && isCommunityMember(resource.data);
      allow write: if false;

      match /messages/{msgId} {
        allow read: if isAuthenticated() &&
          isCommunityMember(get(/databases/$(database)/documents/communities/$(commId)).data);
        allow write: if false;
      }

      match /members/{memberId} {
        allow read: if isAuthenticated() &&
          isCommunityMember(get(/databases/$(database)/documents/communities/$(commId)).data);
        allow write: if false;
      }

      match /transactions/{txId} {
        allow read: if isAuthenticated() &&
          isCommunityMember(get(/databases/$(database)/documents/communities/$(commId)).data);
        allow write: if false;
      }

      match /pendingApprovals/{approvalId} {
        allow read: if isAuthenticated() &&
          isCommunityMember(get(/databases/$(database)/documents/communities/$(commId)).data);
        allow write: if false;
      }
    }
  }
}
```

### 3.10 User Key Bundle (E2EE)

```javascript
/users/{userId}/keys/bundle
{
  // Identity Key (long-lived, generated once at registration)
  identityPublicKey: string,           // Base64-encoded Curve25519 public key

  // Signed Pre-Key (rotated monthly)
  signedPreKey: {
    id: number,                        // Incrementing key ID
    publicKey: string,                 // Base64-encoded Curve25519 public key
    signature: string,                 // XEdDSA signature by identity key
    createdAt: Timestamp,
  },

  // One-Time Pre-Keys (consumed on first message from new contact)
  oneTimePreKeys: [
    {
      id: number,                      // Unique key ID
      publicKey: string,               // Base64-encoded Curve25519 public key
    }
  ],                                   // Replenished when count drops below 20 (target: 100)

  // Metadata
  registrationId: number,             // Unique device registration ID
  uploadedAt: Timestamp,
  signedPreKeyRotatedAt: Timestamp,
}
```

**Security Rules:**
```javascript
// Key bundles — anyone authenticated can read (for X3DH), only owner writes via Cloud Function
match /users/{userId}/keys/bundle {
  allow read: if isAuthenticated();
  allow write: if false;  // All writes via Cloud Functions (uploadKeyBundle)
}
```

### 3.11 Encrypted Key Backup (E2EE)

```javascript
/users/{userId}/keys/backup
{
  // Backup metadata (the actual encrypted blob is on Google Drive)
  backupExists: boolean,
  lastBackupAt: Timestamp | null,
  backupVersion: number,               // Incremented on each backup
  driveFileId: string | null,          // Google Drive file ID for the encrypted backup

  // Key derivation parameters (needed to reconstruct decryption key from passphrase)
  kdf: {
    algorithm: "PBKDF2-SHA256",
    salt: string,                      // Base64-encoded random salt (32 bytes)
    iterations: 600000,                // OWASP-recommended for PBKDF2-SHA256
  },

  // Backup contents (encrypted, stored on Google Drive):
  // - Identity key pair (public + private)
  // - Current signed pre-key pair
  // - All active Double Ratchet session states
  // - All Sender Keys for communities
  // - Registration ID
  //
  // Encrypted with AES-256-GCM using the PBKDF2-derived key from user passphrase.
  // The server NEVER has the passphrase or derived key.
}
```

### 3.12 Community Sender Keys (E2EE)

```javascript
/communities/{communityId}/senderKeys/{userId}
{
  userId: string,
  chainId: number,                     // Incremented on re-key
  publicKey: string,                   // Base64-encoded sender key public part
  chainKey: string,                    // Encrypted per-member (distributed via P2P Signal sessions)
  iteration: number,                   // Current chain step
  createdAt: Timestamp,
  rotatedAt: Timestamp | null,
}
```

**Note:** Sender Keys are NOT stored in Firestore in plaintext. Each member receives the Sender Key encrypted via their individual Signal session with the sender. The Firestore document stores only the public component and metadata. The symmetric `chainKey` field above is a placeholder — in practice, Sender Key distribution happens via encrypted P2P messages, and each client stores received Sender Keys locally in secure storage.

---

## 4. Flutter Domain Layer — Entities & Interfaces

### 4.1 Enums

```dart
// lib/domain/enums/conversation_type.dart
enum ConversationType { p2p, brand, system }

// lib/domain/enums/community_type.dart
enum CommunityType { regular, stokvel }

// lib/domain/enums/message_type.dart
enum MessageType { text, image, voice, tokenSend, tokenRequest, gift, tokenSpray, system }

// lib/domain/enums/message_status.dart
enum MessageStatus { sending, sent, failed, paid, declined }

// lib/domain/enums/member_role.dart
enum MemberRole { owner, admin, treasurer, member, viewer }

// lib/domain/enums/member_status.dart
enum MemberStatus { active, invited, blocked }

// lib/domain/enums/transaction_type.dart
enum TransactionType { contribution, withdrawal, transferIn, transferOut, penalty, payout }

// lib/domain/enums/transaction_status.dart
enum TransactionStatus { pending, approved, completed, rejected }

// lib/domain/enums/approval_status.dart
enum ApprovalStatus { pending, approved, rejected, expired }

// lib/domain/enums/community_status.dart
enum CommunityStatus { active, suspended, closed }
```

### 4.2 Conversation Entity

```dart
// lib/domain/entities/conversation.dart
@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required ConversationType type,
    required List<String> participantIds,
    required Map<String, ParticipantInfo> participants,

    // Last message preview (E2EE encrypted per user)
    String? lastMessageText,                           // Decrypted preview (client-side only, populated after decryption)
    String? lastMessageEncryptedPreview,                // Per-user encrypted preview from server (Base64)
    String? lastMessagePlaintextPreview,                // System message preview (unencrypted, server-set)
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    DateTime? lastMessageAt,

    required Map<String, int> unreadCounts,
    required Map<String, bool> archived,
    required Map<String, bool> pinned,
    required Map<String, bool> muted,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Conversation;

  const Conversation._();

  /// Get unread count for a specific user
  int unreadCountFor(String userId) => unreadCounts[userId] ?? 0;

  /// Check if pinned for a specific user
  bool isPinnedFor(String userId) => pinned[userId] ?? false;

  /// Check if muted for a specific user
  bool isMutedFor(String userId) => muted[userId] ?? false;

  /// Check if archived for a specific user
  bool isArchivedFor(String userId) => archived[userId] ?? false;

  /// Get the other participant's info (for P2P)
  ParticipantInfo getOtherParticipant(String currentUserId) {
    final otherId = participantIds.firstWhere((id) => id != currentUserId);
    return participants[otherId]!;
  }

  /// Get display name for the other participant
  String displayNameFor(String currentUserId) =>
      getOtherParticipant(currentUserId).displayName;
}

@freezed
class ParticipantInfo with _$ParticipantInfo {
  const factory ParticipantInfo({
    required String displayName,
    String? avatarUrl,
  }) = _ParticipantInfo;
}
```

### 4.3 Message Entity

```dart
// lib/domain/entities/message.dart
@freezed
class Message with _$Message {
  const factory Message({
    required String id,

    // Parent reference — exactly one must be non-null
    String? conversationId,            // Set for P2P messages
    String? communityId,               // Set for community messages

    required String senderId,
    required String senderName,
    String? senderAvatarUrl,
    required MessageType type,
    required MessageStatus status,

    // E2EE content — textContent is ONLY populated after client-side decryption
    // On the wire/Firestore, only ciphertext is stored
    String? ciphertext,                // Base64 encrypted content (from server)
    String? textContent,               // Decrypted plaintext (client-only, never persisted to server)
    E2eeMetadata? e2ee,                // Encryption protocol metadata
    X3dhHeader? x3dhHeader,            // Only on first message in new P2P session (X3DH key exchange)

    int? tokenAmount,
    String? recipientId,
    String? ledgerJournalId,
    MessageMedia? media,

    // Gift/Spray embedded metadata (unencrypted — server-managed lifecycle + card UI)
    GiftMessageData? gift,             // Present when type == MessageType.gift
    TokenSprayMessageData? tokenSpray, // Present when type == MessageType.tokenSpray

    @Default({}) Map<String, List<String>> reactions,
    MessageReply? replyTo,
    String? systemEventType,
    Map<String, dynamic>? metadata,
    required DateTime createdAt,
    DateTime? expiresAt,
    DateTime? actionedAt,
    DateTime? deletedAt,
    @Default([]) List<String> deletedFor,
    @Default(false) bool deletedForEveryone,
  }) = _Message;

  const Message._();

  bool get isTextMessage => type == MessageType.text;
  bool get isTokenTransfer => type == MessageType.tokenSend || type == MessageType.tokenRequest;
  bool get isGift => type == MessageType.gift;
  bool get isTokenSpray => type == MessageType.tokenSpray;
  bool get isSystem => type == MessageType.system;
  bool get isEncrypted => ciphertext != null && e2ee != null;
  bool get isDecrypted => textContent != null;
  bool get hasMedia => media != null;
  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);
  bool isSentBy(String userId) => senderId == userId;

  /// Total reaction count across all emoji
  int get totalReactions => reactions.values.fold(0, (sum, list) => sum + list.length);
}

@freezed
class MessageMedia with _$MessageMedia {
  const factory MessageMedia({
    required String url,               // Cloud Storage URL (points to encrypted blob)
    String? thumbnailUrl,              // Cloud Storage URL (points to encrypted thumbnail)
    required String fileName,
    required int fileSize,
    required String mimeType,
    int? duration,
    int? width,
    int? height,
    String? mediaKey,                  // AES-256-GCM key for this media (embedded in message ciphertext, decrypted client-side)
    String? thumbKey,                  // AES-256-GCM key for thumbnail (embedded in message ciphertext)
  }) = _MessageMedia;
}

@freezed
class MessageReply with _$MessageReply {
  const factory MessageReply({
    required String messageId,
    required String senderName,
    required String text,
    required String type,
  }) = _MessageReply;
}
```

### 4.4 Community Entity

```dart
// lib/domain/entities/community.dart
@freezed
class Community with _$Community {
  const factory Community({
    required String id,
    required CommunityType type,
    required String name,
    String? description,
    String? avatarUrl,
    required String ownerId,
    required List<String> memberIds,
    required List<String> adminIds,
    required int memberCount,
    required int totalBalance,
    required CommunityStatus status,
    required CommunitySettings settings,
    StokvelSettings? stokvelSettings,

    // Last message preview (E2EE encrypted per user)
    String? lastMessageText,                           // Decrypted preview (client-side only)
    String? lastMessageEncryptedPreview,                // Per-user encrypted preview from server (Base64)
    String? lastMessagePlaintextPreview,                // System message preview (unencrypted)
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,                               // "text", "image", "gift", etc.
    DateTime? lastMessageAt,

    required Map<String, int> unreadCounts,
    required Map<String, bool> muted,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Community;

  const Community._();

  bool get isStokvel => type == CommunityType.stokvel;
  bool get isActive => status == CommunityStatus.active;
  bool get isSuspended => status == CommunityStatus.suspended;
  bool get isClosed => status == CommunityStatus.closed;
  bool get hasFinancials => settings.enableFinancials;
  bool isMember(String userId) => memberIds.contains(userId);
  bool isAdmin(String userId) => adminIds.contains(userId);
  bool isOwner(String userId) => ownerId == userId;
  int unreadCountFor(String userId) => unreadCounts[userId] ?? 0;
  bool isMutedFor(String userId) => muted[userId] ?? false;

  /// Token balance as ZAR (100 tokens = R1)
  double get balanceZar => totalBalance / 100;
}

@freezed
class CommunitySettings with _$CommunitySettings {
  const factory CommunitySettings({
    @Default(100) int maxMembers,
    @Default(true) bool allowMemberInvites,
    @Default(false) bool onlyAdminsPost,
    @Default(true) bool membersCanShareMedia,
    @Default(false) bool enableFinancials,
    @Default(5000) int requireApprovalAbove,
    @Default(false) bool allowMemberWithdrawals,
    @Default('none') String contributionCycle,
    @Default(0) int contributionAmount,
    @Default(0) int penaltyPercentage,
  }) = _CommunitySettings;
}
```

### 4.5 CommunityMember Entity

```dart
// lib/domain/entities/community_member.dart
@freezed
class CommunityMember with _$CommunityMember {
  const factory CommunityMember({
    required String id,
    required String communityId,
    required String userId,
    required String displayName,
    String? avatarUrl,
    required MemberRole role,
    required MemberStatus status,
    @Default(0) int contributionBalance,
    DateTime? joinedAt,
    required String invitedBy,
    required DateTime invitedAt,
    DateTime? lastReadAt,
  }) = _CommunityMember;

  const CommunityMember._();

  bool get isActive => status == MemberStatus.active;
  bool get isInvited => status == MemberStatus.invited;
  bool get isOwner => role == MemberRole.owner;
  bool get isAdmin => role == MemberRole.owner || role == MemberRole.admin;
  bool get canManageMembers => role == MemberRole.owner || role == MemberRole.admin;
  bool get canApproveFunds => role == MemberRole.owner || role == MemberRole.admin || role == MemberRole.treasurer;
  bool get canTransferFunds => role != MemberRole.viewer;
}
```

### 4.6 CommunityTransaction & CommunityApproval Entities

```dart
// lib/domain/entities/community_transaction.dart
@freezed
class CommunityTransaction with _$CommunityTransaction {
  const factory CommunityTransaction({
    required String id,
    required String communityId,
    required TransactionType type,
    required TransactionStatus status,
    required int amount,                   // In tokens
    required String memberId,
    required String memberName,
    String? description,
    String? journalId,                     // Ledger journal reference
    required DateTime createdAt,
    DateTime? completedAt,
    String? approvedBy,
    String? rejectedBy,
    String? rejectionReason,
  }) = _CommunityTransaction;

  const CommunityTransaction._();

  bool get isPending => status == TransactionStatus.pending;
  bool get isCompleted => status == TransactionStatus.completed;
  bool get isRejected => status == TransactionStatus.rejected;
  bool get isApproved => status == TransactionStatus.approved;
  double get amountZar => amount / 100;
}
```

```dart
// lib/domain/entities/community_approval.dart
@freezed
class CommunityApproval with _$CommunityApproval {
  const factory CommunityApproval({
    required String id,
    required String communityId,
    required String transactionId,
    required String requestedBy,
    required String requestedByName,
    required int amount,
    required String type,                  // Transaction type
    String? description,
    @Default([]) List<String> approvers,   // UserIds who have approved
    required int requiredApprovals,
    required ApprovalStatus status,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) = _CommunityApproval;

  const CommunityApproval._();

  bool get isPending => status == ApprovalStatus.pending;
  bool get isApproved => status == ApprovalStatus.approved;
  bool get isRejected => status == ApprovalStatus.rejected;
  bool get isExpired => status == ApprovalStatus.expired || DateTime.now().isAfter(expiresAt);
  int get remainingApprovals => requiredApprovals - approvers.length;
  double get approvalProgress => approvers.length / requiredApprovals;
}
```

### 4.7 Repository Interfaces

**ConversationRepository** — `lib/domain/repositories/conversation_repository.dart`:

```dart
abstract class ConversationRepository {
  // Conversation list
  Future<Either<Failure, List<Conversation>>> getConversations();
  Stream<Either<Failure, List<Conversation>>> watchConversations();
  Future<Either<Failure, Conversation>> getOrCreateConversation({required String participantId});
  Future<Either<Failure, Conversation>> getConversationById(String id);

  // Messages
  Future<Either<Failure, List<Message>>> getMessages({required String conversationId, int? limit, DateTime? before});
  Stream<Either<Failure, List<Message>>> watchMessages({required String conversationId, int? limit});
  Future<Either<Failure, Message>> sendTextMessage({required String conversationId, required String text, String? replyToMessageId});
  Future<Either<Failure, Message>> sendMediaMessage({required String conversationId, required String mediaUrl, required String mediaType, String? caption});

  // Token operations (reuses existing ledger)
  Future<Either<Failure, Message>> sendTokens({required String conversationId, required String recipientId, required int amount, String? message});
  Future<Either<Failure, Message>> requestTokens({required String conversationId, required String recipientId, required int amount, String? message});
  Future<Either<Failure, Message>> acceptTokenRequest({required String messageId, required String conversationId});
  Future<Either<Failure, Message>> declineTokenRequest({required String messageId, required String conversationId});

  // Thread management
  Future<Either<Failure, void>> markAsRead({required String conversationId});
  Future<Either<Failure, void>> togglePin({required String conversationId, required bool pinned});
  Future<Either<Failure, void>> toggleMute({required String conversationId, required bool muted});
  Future<Either<Failure, void>> archiveConversation(String conversationId);

  // Reactions
  Future<Either<Failure, void>> addReaction({required String conversationId, required String messageId, required String emoji});
  Future<Either<Failure, void>> removeReaction({required String conversationId, required String messageId, required String emoji});

  // Unread count
  Future<Either<Failure, int>> getTotalUnreadCount();
  Stream<Either<Failure, int>> watchTotalUnreadCount();
}
```

**CommunityRepository** — `lib/domain/repositories/community_repository.dart`:

```dart
abstract class CommunityRepository {
  // CRUD
  Future<Either<Failure, Community>> createCommunity(CreateCommunityParams params);
  Future<Either<Failure, Community>> getCommunity(String communityId);
  Future<Either<Failure, List<Community>>> getUserCommunities();
  Stream<Either<Failure, List<Community>>> watchUserCommunities();
  Future<Either<Failure, void>> updateCommunity(String communityId, UpdateCommunityParams params);
  Future<Either<Failure, void>> deleteCommunity(String communityId);

  // Membership
  Future<Either<Failure, void>> inviteMember(String communityId, String userId, MemberRole role);
  Future<Either<Failure, void>> acceptInvitation(String communityId);
  Future<Either<Failure, void>> declineInvitation(String communityId);
  Future<Either<Failure, void>> removeMember(String communityId, String memberId);
  Future<Either<Failure, void>> updateMemberRole(String communityId, String memberId, MemberRole role);
  Future<Either<Failure, void>> leaveCommunity(String communityId);
  Future<Either<Failure, List<CommunityMember>>> getMembers(String communityId);
  Stream<Either<Failure, List<CommunityMember>>> watchMembers(String communityId);
  Future<Either<Failure, List<CommunityMember>>> getPendingInvitations();

  // Messaging
  Future<Either<Failure, List<Message>>> getMessages({required String communityId, int? limit, DateTime? before});
  Stream<Either<Failure, List<Message>>> watchMessages({required String communityId, int? limit});
  Future<Either<Failure, Message>> sendTextMessage({required String communityId, required String text, String? replyToMessageId});
  Future<Either<Failure, Message>> sendMediaMessage({required String communityId, required String mediaUrl, required String mediaType, String? caption});

  // Financial
  Future<Either<Failure, CommunityTransaction>> contribute(String communityId, int amount, {String? description});
  Future<Either<Failure, CommunityTransaction>> withdraw(String communityId, int amount, {String? description});
  Future<Either<Failure, void>> approveTransaction(String communityId, String transactionId);
  Future<Either<Failure, void>> rejectTransaction(String communityId, String transactionId, {String? reason});
  Future<Either<Failure, List<CommunityTransaction>>> getTransactions(String communityId, {int? limit});
  Stream<Either<Failure, List<CommunityTransaction>>> watchTransactions(String communityId);
  Future<Either<Failure, List<CommunityApproval>>> getPendingApprovals(String communityId);
  Stream<Either<Failure, List<CommunityApproval>>> watchPendingApprovals(String communityId);
  Future<Either<Failure, int>> getBalance(String communityId);

  // Stokvel
  Future<Either<Failure, StokvelPayoutResult>> triggerPayout(String communityId, {String? recipientId});
  Future<Either<Failure, StokvelAnalytics>> getAnalytics(String communityId, {int months = 6});

  // Reactions
  Future<Either<Failure, void>> addReaction({required String communityId, required String messageId, required String emoji});
  Future<Either<Failure, void>> removeReaction({required String communityId, required String messageId, required String emoji});

  // Unread
  Stream<Either<Failure, int>> watchTotalCommunityUnreadCount();
}
```

### 4.8 Parameter Classes

```dart
// lib/domain/entities/create_community_params.dart
@freezed
class CreateCommunityParams with _$CreateCommunityParams {
  const factory CreateCommunityParams({
    required CommunityType type,
    required String name,
    String? description,
    String? avatarUrl,
    @Default(CommunitySettings()) CommunitySettings settings,
    StokvelSettings? stokvelSettings,         // Required if type == stokvel
    @Default([]) List<String> initialMemberIds, // Users to invite immediately
  }) = _CreateCommunityParams;
}

// lib/domain/entities/update_community_params.dart
@freezed
class UpdateCommunityParams with _$UpdateCommunityParams {
  const factory UpdateCommunityParams({
    String? name,
    String? description,
    String? avatarUrl,
    CommunitySettings? settings,
    StokvelSettings? stokvelSettings,
  }) = _UpdateCommunityParams;
}
```

---

## 5. Cloud Functions — Complete Specification

### 5.1 `functions/src/conversations.ts` (~600 lines)

| Function | Parameters | Security | Description |
|----------|-----------|----------|-------------|
| `getOrCreateConversation` | `{participantId}` | Auth + AppCheck | Finds existing conversation by participantIds pair, or creates new one with denormalized participant info |
| `sendConversationMessage` | `{conversationId, ciphertext, e2ee, x3dhHeader?, encryptedPreviews, replyToMessageId?, mediaUrl?, mediaType?}` | Auth + AppCheck | **Atomic batch write:** writes E2EE ciphertext to message subcollection + updates parent `lastMessage` (encrypted previews) + increments `unreadCounts.{otherUserId}`. Server never decrypts. |
| `sendConversationTokens` | `{conversationId, recipientId, amount, ciphertext?, e2ee?, encryptedPreviews?, subAccountId?, idempotencyKey}` | Auth + AppCheck + PlayIntegrity | **Idempotent + atomic:** validates balance, calls `processP2PTransfer()` from ledger with idempotency key, batch writes tokenSend message + parent update |
| `requestConversationTokens` | `{conversationId, recipientId, amount, ciphertext?, e2ee?, encryptedPreviews?}` | Auth + AppCheck | **Atomic batch:** creates tokenRequest message with 7-day expiry + updates parent |
| `acceptConversationTokenRequest` | `{conversationId, messageId}` | Auth + AppCheck + PlayIntegrity | Validates pending + not expired, processes payment via ledger, updates message status to "paid" |
| `declineConversationTokenRequest` | `{conversationId, messageId}` | Auth + AppCheck | Updates message status to "declined" |
| `markConversationRead` | `{conversationId}` | Auth + AppCheck | Sets `unreadCounts.{userId}` to 0 |
| `toggleMessageReaction` | `{conversationId, messageId, emoji}` | Auth + AppCheck | Adds userId to `reactions.{emoji}` array if not present, removes if present |
| `toggleConversationPin` | `{conversationId, pinned}` | Auth + AppCheck | Sets `pinned.{userId}` to `pinned` value. Security rules block direct writes, so this must be a CF. |
| `toggleConversationMute` | `{conversationId, muted}` | Auth + AppCheck | Sets `muted.{userId}` to `muted` value. Same rationale — all writes via CFs. |
| `archiveConversation` | `{conversationId}` | Auth + AppCheck | Sets `archived.{userId}` to `true`. Archived conversations are hidden from the inbox list by default. |
| `deleteMessageForMe` | `{conversationId, messageId}` | Auth + AppCheck | Adds userId to `deletedFor[]` array on message doc. Message hidden only for this user. |
| `deleteMessageForEveryone` | `{conversationId, messageId}` | Auth + AppCheck | Validates sender == userId AND createdAt within 1 hour. Sets `deletedForEveryone: true`. Replaces message content with "[This message was deleted]" for all. |
| `blockUser` | `{userIdToBlock}` | Auth + AppCheck | Adds `userIdToBlock` to caller's `chat.blockedUserIds` array. Soft-deletes any existing P2P conversation between the two users (sets a `blocked: true` flag). |
| `unblockUser` | `{userIdToUnblock}` | Auth + AppCheck | Removes `userIdToUnblock` from caller's `chat.blockedUserIds` array. |

### 5.2 `functions/src/communities.ts` (~1800 lines)

**Adapted from `groups.ts` — same battle-tested logic, new collection references.**

| Function Group | Functions | Adapted From |
|----------------|-----------|--------------|
| **CRUD** | `createCommunity`, `updateCommunity`, `deleteCommunity`, `getUserCommunities`, `getCommunityDetails` | `groups.ts` group CRUD (~400 lines) |
| **Membership** | `inviteCommunityMember`, `acceptCommunityInvitation`, `declineCommunityInvitation`, `removeCommunityMember`, `updateCommunityMemberRole`, `leaveCommunity`, `blockCommunityMember` | `groups.ts` membership (~450 lines) |
| **Messaging** | `sendCommunityMessage`, `markCommunityRead` | NEW (~200 lines) |
| **Financial** | `contributeToCommunity` (+ idempotencyKey), `withdrawFromCommunity` (+ idempotencyKey), `approveCommunityTransaction`, `rejectCommunityTransaction` | `groups.ts` financial (~400 lines) — all financial mutations use idempotency keys and `db.runTransaction()` |
| **Stokvel** | `triggerCommunityPayout`, `getCommunityAnalytics` | `groups.ts` stokvel (~200 lines) |
| **Scheduled** | `processCommunityPayouts`, `calculateCommunityPenalties`, `sendCommunityContributionReminders` | `groups.ts` scheduled jobs (~300 lines) |

**Key: `sendCommunityMessage`** (new function — E2EE aware):
```typescript
// Pseudocode — server NEVER decrypts ciphertext
export const sendCommunityMessage = functions.https.onCall(async (data, context) => {
  requireAuth(context);
  requireAppCheck(context);

  const { communityId, ciphertext, e2ee, encryptedPreviews, mediaUrl, mediaType, replyToMessageId } = data;
  const userId = context.auth!.uid;

  // 1. Validate membership
  const community = await getCommunityOrThrow(communityId);
  await requireCommunityMember(communityId, userId);

  // 2. Check if onlyAdminsPost
  if (community.settings.onlyAdminsPost && !community.adminIds.includes(userId)) {
    throw new functions.https.HttpsError('permission-denied', 'Only admins can post');
  }

  // 3. Get sender info (unencrypted metadata)
  const userDoc = await db.collection('users').doc(userId).get();
  const userData = userDoc.data()!;

  // 4. Prepare message + parent update as ATOMIC BATCH (prevents orphaned messages)
  const messageRef = db.collection('communities').doc(communityId).collection('messages').doc();
  const replyContext = replyToMessageId ? await getReplyContext(communityId, replyToMessageId) : null;

  const batch = db.batch();

  // 4a. Write E2EE message to subcollection — ciphertext stored as-is
  batch.set(messageRef, {
    id: messageRef.id,
    communityId,
    senderId: userId,
    senderName: userData.displayName,
    senderAvatarUrl: userData.profilePicThumbUrl || null,
    type: mediaUrl ? 'image' : 'text',
    status: 'sent',
    ciphertext: ciphertext,                // E2EE: server stores opaque ciphertext
    textContent: null,                     // ALWAYS null on server
    e2ee: e2ee,                            // { protocol: 'sender_key', senderKeyChainId, messageNumber }
    media: mediaUrl ? { url: mediaUrl, mimeType: mediaType, /* ... */ } : null,
    replyTo: replyContext,
    reactions: {},
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // 4b. Update community lastMessage with per-user encrypted previews
  const unreadUpdates: Record<string, any> = {};
  for (const memberId of community.memberIds) {
    if (memberId !== userId) {
      unreadUpdates[`unreadCounts.${memberId}`] = admin.firestore.FieldValue.increment(1);
    }
  }

  batch.update(db.collection('communities').doc(communityId), {
    lastMessage: {
      senderId: userId,
      senderName: userData.displayName,
      type: mediaUrl ? 'image' : 'text',
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
      encryptedPreviews: encryptedPreviews,  // E2EE: per-user encrypted inbox preview
      plaintextPreview: null,                // Only set for system messages
    },
    lastMessageAt: admin.firestore.FieldValue.serverTimestamp(),
    ...unreadUpdates,
  });

  await batch.commit();

  return { success: true, messageId: messageRef.id };
});
```

### 5.3 `functions/src/helpers/communityHelpers.ts` (~200 lines)

```typescript
// Extracted from groups.ts helper functions
export async function getCommunityOrThrow(communityId: string) { ... }
export async function requireCommunityMember(communityId: string, userId: string) { ... }
export function getMemberPermissions(role: string): Permissions { ... }
export function requirePermission(member: any, permission: string) { ... }
export async function requireActiveCommunity(community: any) { ... }

// Notification helpers
export async function sendPushNotification(userId: string, payload: NotificationPayload) { ... }
export async function sendBatchPushNotifications(userIds: string[], payload: NotificationPayload) {
  // Reads FCM tokens from user docs, sends in batches of 500 (FCM limit)
  // Handles token cleanup (removes invalid tokens from user docs)
}
export function getE2EENotificationBody(messageType: string): string {
  // Returns generic preview based on message type since E2EE content is unreadable
  switch (messageType) {
    case 'text': return 'New message';
    case 'image': return 'Sent an image';
    case 'voice': return 'Sent a voice message';
    case 'tokenSend': return 'Sent tokens';
    case 'tokenRequest': return 'Requested tokens';
    case 'gift': return 'Sent a gift';
    case 'tokenSpray': return 'Started a celebration';
    default: return 'New message';
  }
}

// Unread increment helper
export function buildUnreadIncrements(
  parentId: string, senderId: string, collection: 'conversations' | 'communities'
): Record<string, any> {
  // Reads memberIds/participantIds and returns a map of FieldValue.increment(1) for all except sender
}

// Idempotency helper
export async function getUserOrThrow(userId: string) { ... }
```

### 5.4 `functions/src/keyManagement.ts` (~250 lines)

E2EE key management Cloud Functions. These handle public key bundle storage and maintenance — private keys NEVER leave the client device.

| Function | Parameters | Security | Description |
|----------|-----------|----------|-------------|
| `uploadKeyBundle` | `{identityPublicKey, signedPreKey, oneTimePreKeys, registrationId}` | Auth + AppCheck | Writes public key bundle to `/users/{userId}/keys/bundle`. Called at registration and on key rotation. |
| `fetchKeyBundle` | `{userId}` | Auth + AppCheck | Reads target user's public key bundle. Atomically removes one consumed One-Time Pre-Key from the bundle. Returns the bundle to the caller for X3DH. |
| `replenishOneTimePreKeys` | `{newPreKeys}` | Auth + AppCheck | Appends new One-Time Pre-Keys to the user's bundle. Client calls this when local count drops below 20. |
| `rotateSignedPreKey` | `{newSignedPreKey}` | Auth + AppCheck | Replaces the signed pre-key on the bundle. Called monthly by the client. |
| `saveBackupMetadata` | `{driveFileId, kdfSalt, kdfIterations, backupVersion}` | Auth + AppCheck | Writes backup metadata to `/users/{userId}/keys/backup`. The actual encrypted backup blob lives on Google Drive. |
| `getBackupMetadata` | `{}` | Auth + AppCheck | Reads the caller's backup metadata (to check if backup exists on new device). |

```typescript
// Key pseudocode: fetchKeyBundle with atomic one-time pre-key consumption
export const fetchKeyBundle = functions.https.onCall(async (data, context) => {
  requireAuth(context);
  requireAppCheck(context);

  const { userId } = data;
  const bundleRef = db.collection('users').doc(userId).collection('keys').doc('bundle');

  // Atomic transaction: read bundle + consume one OTK
  return db.runTransaction(async (tx) => {
    const bundleDoc = await tx.get(bundleRef);
    if (!bundleDoc.exists) throw new HttpsError('not-found', 'No key bundle for user');

    const bundle = bundleDoc.data()!;
    const otks = bundle.oneTimePreKeys || [];
    let consumedOtk = null;

    if (otks.length > 0) {
      consumedOtk = otks[0];  // Take the first available
      tx.update(bundleRef, {
        oneTimePreKeys: admin.firestore.FieldValue.arrayRemove(consumedOtk),
      });
    }

    return {
      identityPublicKey: bundle.identityPublicKey,
      signedPreKey: bundle.signedPreKey,
      oneTimePreKey: consumedOtk,  // null if none available (X3DH works without it)
      registrationId: bundle.registrationId,
    };
  });
});
```

### 5.5 `functions/src/messagingNotifications.ts` (~200 lines)

Firestore triggers for push notifications.

**E2EE Note:** The server cannot read message content (ciphertext only). Push notification body uses a generic message like "New message" or the unencrypted message type (e.g., "Sent an image", "Sent tokens"). The actual message preview is only visible once the client opens the app and decrypts.

```typescript
// Trigger: new message in conversation
exports.onConversationMessageCreated = functions.firestore
  .document('conversations/{convId}/messages/{msgId}')
  .onCreate(async (snap, context) => {
    const message = snap.data();
    const convDoc = await db.collection('conversations').doc(context.params.convId).get();
    const conv = convDoc.data()!;

    // Find recipient (the other participant)
    const recipientId = conv.participantIds.find((id: string) => id !== message.senderId);
    if (!recipientId) return;

    // Check if muted
    if (conv.muted?.[recipientId]) return;

    // Send FCM — E2EE: cannot include message content, use type-based preview
    await sendPushNotification(recipientId, {
      title: message.senderName,
      body: getE2EENotificationBody(message.type),  // "New message", "Sent an image", "Sent tokens", etc.
      data: { type: 'new_message', conversationId: context.params.convId },
    });
  });

// Trigger: new message in community
exports.onCommunityMessageCreated = functions.firestore
  .document('communities/{commId}/messages/{msgId}')
  .onCreate(async (snap, context) => {
    const message = snap.data();
    const commDoc = await db.collection('communities').doc(context.params.commId).get();
    const community = commDoc.data()!;

    // Send to all members except sender, respecting mute preferences
    const recipients = community.memberIds.filter((id: string) =>
      id !== message.senderId && !community.muted?.[id]
    );

    // Batch send FCM — E2EE: cannot include message content
    await sendBatchPushNotifications(recipients, {
      title: `${community.name}`,
      body: `${message.senderName}: ${getE2EENotificationBody(message.type)}`,
      data: { type: 'new_community_message', communityId: context.params.commId },
    });
  });
```

### 5.6 Ledger Integration (No Changes)

The existing `functions/src/ledger/groupAccounts.ts` is reused as-is:

| Function | Called By | Purpose |
|----------|----------|---------|
| `getOrCreateGroupAccount(communityId)` | `createCommunity` | Creates ledger account `group:{communityId}` |
| `getGroupBalance(communityId)` | `getCommunityDetails` | Reads current balance |
| `processGroupContribution(communityId, memberId, amount, txId)` | `contributeToCommunity` | Debit user, credit community treasury |
| `processGroupWithdrawal(communityId, memberId, amount, txId)` | `withdrawFromCommunity` | Debit community, credit user |
| `processGroupPayout(communityId, payouts[], txId)` | `processCommunityPayouts` | Batch payout to members |

The existing `functions/src/ledger/index.ts` `processP2PTransfer` is reused for conversation token transfers.

**New ledger functions for Gifts & Sprays (added to `ledger/index.ts`):**

| Function | Debit Account | Credit Account | Called By |
|----------|--------------|----------------|----------|
| `processGiftDebit(userId, amount, description, idempotencyKey)` | `user:{userId}` | `GIFT_ESCROW` | `sendGift` |
| `processGiftCredit(recipientId, amount, giftId)` | `GIFT_ESCROW` | `user:{recipientId}` | `claimGift` |
| `processGiftRefund(senderId, amount, giftId)` | `GIFT_ESCROW` | `user:{senderId}` | `expireGifts` |
| `processSprayContributionDebit(userId, amount, sprayId, idempotencyKey)` | `user:{userId}` | `SPRAY_ESCROW` | `contributeToSpray` |
| `processSprayPayout(recipientId, amount, sprayId)` | `SPRAY_ESCROW` | `user:{recipientId}` | `closeTokenSpray` / `claimTokenSpray` |

**New system accounts:**
- `GIFT_ESCROW` — holds tokens between gift send and claim/expiry
- `SPRAY_ESCROW` — holds tokens between spray contributions and payout

These follow the same double-entry bookkeeping pattern as existing system accounts (`ENGAGEMENT_ESCROW`, `DAILY_POT`, etc.).

---

## 6. BLoC Specifications

**E2EE Design Note:** BLoC events deal in **plaintext** — they accept/emit plaintext strings for message content. Encryption and decryption happen transparently in the **repository/datasource layer**:
- **Sending:** BLoC calls `repository.sendTextMessage(text: "Hello")` → repository encrypts plaintext via `SignalProtocolService.encryptP2P()` → datasource sends ciphertext + e2ee metadata to Cloud Function.
- **Receiving:** Firestore delivers ciphertext → datasource reads it → repository calls `SignalProtocolService.decryptP2P()` → BLoC receives `Message` entity with `textContent` populated.
This keeps BLoCs clean of crypto concerns and makes testing easier (mock the repository, not the crypto).

### 6.1 ConversationBloc

**Events:**
```dart
@freezed
class ConversationEvent with _$ConversationEvent {
  // List management
  const factory ConversationEvent.loadConversations() = _LoadConversations;
  const factory ConversationEvent.watchConversations() = _WatchConversations;
  const factory ConversationEvent.conversationsUpdated(List<Conversation> conversations) = _ConversationsUpdated;

  // Conversation selection
  const factory ConversationEvent.selectConversation(String id) = _SelectConversation;
  const factory ConversationEvent.getOrCreateConversation(String participantId) = _GetOrCreateConversation;

  // Messages
  const factory ConversationEvent.loadMessages({required String conversationId, int? limit, DateTime? before}) = _LoadMessages;
  const factory ConversationEvent.watchMessages({required String conversationId, int? limit}) = _WatchMessages;
  const factory ConversationEvent.messagesUpdated(List<Message> messages) = _MessagesUpdated;
  const factory ConversationEvent.sendTextMessage({required String conversationId, required String text, String? replyToMessageId}) = _SendTextMessage;
  const factory ConversationEvent.sendMediaMessage({required String conversationId, required String mediaUrl, required String mediaType, String? caption}) = _SendMediaMessage;

  // Token operations
  const factory ConversationEvent.sendTokens({required String conversationId, required String recipientId, required int amount, String? message}) = _SendTokens;
  const factory ConversationEvent.requestTokens({required String conversationId, required String recipientId, required int amount, String? message}) = _RequestTokens;
  const factory ConversationEvent.acceptTokenRequest({required String messageId, required String conversationId}) = _AcceptTokenRequest;
  const factory ConversationEvent.declineTokenRequest({required String messageId, required String conversationId}) = _DeclineTokenRequest;

  // Thread management
  const factory ConversationEvent.markAsRead(String conversationId) = _MarkAsRead;
  const factory ConversationEvent.togglePin({required String conversationId, required bool pinned}) = _TogglePin;
  const factory ConversationEvent.toggleMute({required String conversationId, required bool muted}) = _ToggleMute;
  const factory ConversationEvent.archiveConversation(String conversationId) = _ArchiveConversation;

  // Reactions
  const factory ConversationEvent.addReaction({required String conversationId, required String messageId, required String emoji}) = _AddReaction;
  const factory ConversationEvent.removeReaction({required String conversationId, required String messageId, required String emoji}) = _RemoveReaction;

  // Retry failed message
  const factory ConversationEvent.retryMessage({required String conversationId, required String localMessageId}) = _RetryMessage;

  // Unread
  const factory ConversationEvent.unreadCountUpdated(int count) = _UnreadCountUpdated;

  // Error
  const factory ConversationEvent.clearError() = _ClearError;
}
```

**State:**
```dart
enum ConversationStatus { initial, loading, loaded, error }

@freezed
class ConversationState with _$ConversationState {
  const factory ConversationState({
    @Default(ConversationStatus.initial) ConversationStatus status,
    @Default([]) List<Conversation> conversations,
    @Default([]) List<Message> messages,
    Conversation? selectedConversation,
    @Default(false) bool isLoadingMessages,
    @Default(false) bool hasMoreMessages,
    @Default(false) bool isSending,
    @Default(0) int totalUnreadCount,
    String? errorMessage,
  }) = _ConversationState;

  const ConversationState._();

  /// Conversations sorted: pinned first, then by lastMessageAt descending
  List<Conversation> sortedConversations(String currentUserId) {
    final sorted = List<Conversation>.from(conversations);
    sorted.sort((a, b) {
      final aPinned = a.isPinnedFor(currentUserId);
      final bPinned = b.isPinnedFor(currentUserId);
      if (aPinned != bPinned) return aPinned ? -1 : 1;
      final aTime = a.lastMessageAt ?? a.createdAt;
      final bTime = b.lastMessageAt ?? b.createdAt;
      return bTime.compareTo(aTime);
    });
    return sorted;
  }
}
```

### 6.2 CommunityBloc

~28 events mirroring existing GroupBloc structure. Events cover:
- CRUD: `loadUserCommunities`, `watchUserCommunities`, `createCommunity`, `updateCommunity`, `deleteCommunity`
- Selection: `loadCommunityDetails`, `selectCommunity`, `clearSelectedCommunity`
- Membership: `inviteMember`, `acceptInvitation`, `declineInvitation`, `removeMember`, `updateMemberRole`, `leaveCommunity`, `loadPendingInvitations`
- Streams: `watchMembers`, `membersUpdated`, `watchTransactions`, `transactionsUpdated`, `watchPendingApprovals`, `pendingApprovalsUpdated`
- Financial: `contribute`, `withdraw`, `approveTransaction`, `rejectTransaction`
- Stokvel: `triggerPayout`, `loadAnalytics`
- Utilities: `clearError`

### 6.3 CommunityMessagingBloc (Lightweight, Scoped)

```dart
@freezed
class CommunityMessagingEvent with _$CommunityMessagingEvent {
  const factory CommunityMessagingEvent.loadMessages({int? limit, DateTime? before}) = _LoadMessages;
  const factory CommunityMessagingEvent.watchMessages({int? limit}) = _WatchMessages;
  const factory CommunityMessagingEvent.messagesUpdated(List<Message> messages) = _MessagesUpdated;
  const factory CommunityMessagingEvent.sendTextMessage({required String text, String? replyToMessageId}) = _SendTextMessage;
  const factory CommunityMessagingEvent.sendMediaMessage({required String mediaUrl, required String mediaType, String? caption}) = _SendMediaMessage;
  const factory CommunityMessagingEvent.addReaction({required String messageId, required String emoji}) = _AddReaction;
  const factory CommunityMessagingEvent.removeReaction({required String messageId, required String emoji}) = _RemoveReaction;
  const factory CommunityMessagingEvent.markAsRead() = _MarkAsRead;
  const factory CommunityMessagingEvent.clearError() = _ClearError;
}

@freezed
class CommunityMessagingState with _$CommunityMessagingState {
  const factory CommunityMessagingState({
    required String communityId,
    @Default([]) List<Message> messages,
    @Default(false) bool isLoading,
    @Default(false) bool isSending,
    @Default(false) bool hasMore,
    String? errorMessage,
  }) = _CommunityMessagingState;
}
```

---

## 7. Navigation & Routes

### 7.1 New Chat Tab Routes

```
/chat                                    → MessagingScreen (unified inbox)
├── /chat/conversation/:conversationId   → ConversationDetailScreen (P2P messages)
├── /chat/community/:communityId         → CommunityDetailScreen (tabbed: Chat/Members/Finances)
│   ├── /settings                        → CommunitySettingsScreen
│   ├── /members                         → CommunityMembersScreen
│   ├── /invite                          → InviteMemberScreen
│   ├── /contribute                      → CommunityTransactionScreen (type=contribute)
│   ├── /withdraw                        → CommunityTransactionScreen (type=withdraw)
│   └── /approvals                       → PendingApprovalsScreen
├── /chat/create-community               → CreateCommunityScreen
├── /chat/send-wallet                    → (existing send wallet selection)
└── /chat/send-amount                    → (existing send amount flow)
```

### 7.2 Removed Routes

The standalone `/groups` route block is removed entirely. All group/community functionality lives under `/chat/community/`.

**Redirect handling:** Since the app is pre-production with no external deep links in circulation, no redirect from `/groups/*` is needed. However, add a GoRouter redirect guard that catches any stale `/groups/:id` path and sends it to `/chat/community/:id` as a safety net:
```dart
redirect: (context, state) {
  if (state.matchedLocation.startsWith('/groups/')) {
    final id = state.pathParameters['id'];
    return '/chat/community/$id';
  }
  return null;
},
```

---

## 8. Screen Descriptions

### 8.1 Messaging Screen (Unified Inbox)
- **Replaces:** `chat_screen.dart`
- Shows ALL conversations AND communities in one list, sorted by `lastMessageAt`
- Pinned items appear at top
- Each list tile shows: avatar, display name, last message preview, timestamp, unread badge
- Community tiles have a small group icon overlay on the avatar
- FAB with expandable actions: "New Chat" + "New Community"
- Pull-to-refresh, search bar

### 8.2 Conversation Detail Screen
- **Replaces:** `chat_detail_screen.dart`
- Message list (reverse chronological, paginated with infinite scroll)
- Message input bar: text field, send button, attachment button, token shortcuts
- Long-press on message: reaction picker (6 emoji)
- Swipe right on message: reply
- AppBar: other participant's name + avatar, menu (pin, mute, archive)

### 8.3 Community Detail Screen
- **Replaces:** `group_detail_screen.dart`
- 3-tab layout: **Chat** | **Members** | **Finances**
- Chat tab: community messages with sender names above each bubble
- Members tab: member list with roles, invite button (for admins)
- Finances tab (only if `settings.enableFinancials`): balance card, contribute/withdraw buttons, transaction list, pending approvals, stokvel analytics (if stokvel type)
- AppBar: community name + avatar, settings gear icon

### 8.4 Create Community Screen
- **Replaces:** `create_group_screen.dart`
- Step 1: Choose type (Regular / Stokvel)
- Step 2: Name, description, avatar upload
- Step 3: Settings (varies by type)
- Step 4 (stokvel only): Contribution cycle, payout type, contribution amount

---

## 9. Implementation Timeline (Phase 1-2)

| Week | Phase | Deliverable |
|------|-------|-------------|
| 1 | Domain Layer + E2EE Crypto Foundation | All entities, enums, repo interfaces, E2EE types + CryptoService + KeyManagementService + SignalProtocolService + SenderKeyService |
| 2 | Conversation Data Layer + Key Management | Conversation models/datasource/repo, `keyManagement.ts` Cloud Function, key bundle upload at registration |
| 3 | Conversation Cloud Functions + E2EE Testing | `conversations.ts` (ciphertext-aware), Firestore indexes, security rules, Jest tests, E2EE encrypt/decrypt integration tests |
| 4 | Community Data Layer + Cloud Functions | Community models/datasource/repo, `communities.ts`, `communityHelpers.ts`, Sender Key distribution |
| 5 | BLoC Layer + Navigation | 3 BLoCs (with encrypt-on-send / decrypt-on-receive), DI wiring, router updates |
| 6 | Screens & Widgets | All 9 screens, 7 widgets, unified inbox (decrypted previews) |
| 7 | Media Encryption + Notifications + Key Backup + Polish | Encrypted media upload/download, KeyBackupService (Google Drive), FCM triggers (type-based, no content), unread badges, deprecation |

---

## 10. File Inventory (Phase 1-2)

### New Flutter Files (57)

**Domain (17):** 6 enums + 7 entities (conversation, message, community, community_member, community_transaction, community_approval, e2ee_types) + 2 repository interfaces + 2 additional (e2ee repo interface or included in conversation/community repos)
**Data (11):** 6 models (conversation, message, community, community_member, community_transaction, community_approval) + 3 datasources (conversation_remote, community_remote, media_upload) + 2 repository implementations (conversation, community)
**BLoC (9):** 3 BLoCs x 3 files each (bloc, event, state)
**Screens (9):** messaging_screen, conversation_detail, community_detail, create_community, community_settings, community_members, invite_member, community_transaction, pending_approvals
**Widgets (7):** message_bubble, message_input_bar, conversation_list_tile, community_list_tile, reaction_picker, message_reactions_bar, media_picker_widget
**E2EE Services (5):** crypto_service, key_management_service, key_backup_service, signal_protocol_service, sender_key_service

### New Cloud Function Files (5)

- `functions/src/conversations.ts` (~600 lines)
- `functions/src/communities.ts` (~1800 lines)
- `functions/src/helpers/communityHelpers.ts` (~150 lines)
- `functions/src/keyManagement.ts` (~250 lines)
- `functions/src/messagingNotifications.ts` (~200 lines)

### Files to Modify (5)

- `lib/presentation/router/app_router.dart` — replace Chat tab routes, remove `/groups`
- `lib/app.dart` — replace ChatBloc with ConversationBloc + CommunityBloc
- `lib/presentation/widgets/common/bottom_nav_bar.dart` — unified unread badge
- `functions/src/index.ts` — add exports for new files
- `firestore.rules` — add rules for `conversations` and `communities`

### Existing Code Reused (Not Modified)

| File | Reuse |
|------|-------|
| `functions/src/ledger/groupAccounts.ts` | All financial functions as-is |
| `functions/src/ledger/index.ts` | `processP2PTransfer` for token ops |
| `lib/domain/entities/stokvel_analytics.dart` | StokvelAnalytics entity |
| `lib/domain/value_objects/token_amount.dart` | TokenAmount value object |
| `lib/core/services/play_integrity_service.dart` | Play Integrity validation |

### Files to Deprecate (16+)

All existing `chat_*` and `group_*` files across domain/data/presentation layers. Left compilable, removed in follow-up cleanup PR.

---

## 11. Verification Checklist (Phase 1-2)

### Per-Phase Checks
- [ ] `dart run build_runner build --delete-conflicting-outputs` succeeds
- [ ] `flutter analyze --fatal-infos` passes
- [ ] `cd functions && npm run build` compiles
- [ ] `cd functions && npm test` passes

### E2EE Crypto Tests
- [ ] Key generation: Identity, Signed Pre-Key, One-Time Pre-Keys all generate correctly
- [ ] Key bundle upload + fetch round-trip works via `keyManagement.ts`
- [ ] X3DH key agreement produces matching shared secrets on both sides
- [ ] Double Ratchet: encrypt → decrypt round-trip for multiple messages
- [ ] Double Ratchet: out-of-order message delivery decrypts correctly
- [ ] Sender Key: generate → distribute → encrypt → decrypt for community messages
- [ ] Sender Key re-key on member leave: old keys cannot decrypt new messages
- [ ] AES-256-GCM media encryption/decryption round-trip (image + voice)
- [ ] Key backup: create backup → restore on fresh install → decrypt old messages
- [ ] Key backup: wrong passphrase fails gracefully
- [ ] Per-user encrypted preview: each participant decrypts their own inbox preview
- [ ] System messages remain plaintext (no encryption applied)
- [ ] Financial metadata (token amounts, transaction IDs) remains unencrypted

### End-to-End Tests
- [ ] Create P2P conversation → send text (E2EE) → verify ciphertext in Firestore → decrypt on recipient
- [ ] Send image (encrypted) → verify Cloud Storage blob is not a readable image → decrypt + display on recipient
- [ ] Send tokens → verify amount is unencrypted → verify personal message is encrypted
- [ ] Create regular community → invite member → Sender Keys distributed → send messages → react → reply
- [ ] Create stokvel community → contribute → withdraw → approve → trigger payout
- [ ] Push notifications arrive (with type-based preview, NOT message content)
- [ ] Encrypted media upload + decrypted display works (images, voice)
- [ ] Reactions work (add, remove, display — unencrypted)
- [ ] Unread badges update on Chat tab
- [ ] Inbox preview shows decrypted text for each user
- [ ] New device registration → key backup restore → old messages decrypt
- [ ] New device registration → NO backup → old messages show "[Cannot decrypt]"
- [ ] Navigation: all routes work, deep links resolve correctly
- [ ] Back navigation: no orphaned screens

---

## 12. End-to-End Encryption — Complete Specification

E2EE is built in from the start, not retrofitted. Every message-sending path encrypts on the client before calling the Cloud Function. Every message-receiving path decrypts on the client after Firestore delivers the ciphertext.

### 12.1 Cryptographic Primitives

| Primitive | Algorithm | Purpose |
|-----------|-----------|---------|
| Identity Key | Curve25519 | Long-lived key pair, generated at registration |
| Signed Pre-Key | Curve25519 + XEdDSA | Medium-lived (rotated monthly), signed by identity key |
| One-Time Pre-Keys | Curve25519 | Ephemeral, consumed on first contact (batch of 100) |
| Key Agreement | X3DH (Extended Triple Diffie-Hellman) | Establishes shared secret between two users who may be offline |
| Session Ratchet | Double Ratchet (Diffie-Hellman + symmetric) | Per-message forward secrecy + post-compromise recovery |
| Message Encryption | AES-256-GCM | Symmetric encryption of message content |
| Media Encryption | AES-256-GCM | Symmetric encryption of image/voice file blobs |
| Community Messages | Sender Keys + AES-256-GCM | One encryption per message (sender's key), all members decrypt |
| Key Derivation (backup) | PBKDF2-SHA256 (600k iterations) | Derives encryption key from user passphrase for backup |

### 12.2 Registration & Key Generation Flow

```
User Registration / New Device Setup:
  1. Generate Identity Key Pair (Curve25519)
  2. Generate Signed Pre-Key pair, sign public part with Identity Key (XEdDSA)
  3. Generate 100 One-Time Pre-Key pairs
  4. Store ALL private keys in Android Keystore / iOS Keychain (hardware-backed)
  5. Upload public key bundle to Firestore via Cloud Function: uploadKeyBundle()
     → Writes to /users/{userId}/keys/bundle
  6. Prompt user to create key backup passphrase (strongly recommended)
  7. If passphrase provided: encrypt all key material + back up to Google Drive
```

### 12.3 P2P Session Establishment (X3DH)

```
Alice wants to message Bob for the first time:

  1. Alice fetches Bob's key bundle from /users/{bobId}/keys/bundle
  2. Alice performs X3DH:
     - DH1 = DH(Alice_Identity_Private, Bob_Signed_PreKey_Public)
     - DH2 = DH(Alice_Ephemeral_Private, Bob_Identity_Public)
     - DH3 = DH(Alice_Ephemeral_Private, Bob_Signed_PreKey_Public)
     - DH4 = DH(Alice_Ephemeral_Private, Bob_OneTime_PreKey_Public)  [if available]
     - SharedSecret = KDF(DH1 || DH2 || DH3 || DH4)
  3. Alice initialises Double Ratchet with SharedSecret
  4. Alice encrypts first message with Double Ratchet output key
  5. Alice sends via Cloud Function: sendConversationMessage({
       conversationId, ciphertext, e2ee: { protocol: 'signal', messageNumber: 0 },
       x3dhHeader: { identityKey, ephemeralKey, oneTimePreKeyId }
     })
  6. Cloud Function writes ciphertext to Firestore (never decrypts)
  7. Cloud Function consumes the used One-Time Pre-Key from Bob's bundle
  8. Bob receives message via Firestore listener
  9. Bob performs X3DH from his side using the header, derives same SharedSecret
  10. Bob initialises Double Ratchet, decrypts message locally
  11. Subsequent messages: Double Ratchet advances automatically (no more X3DH)
```

### 12.4 Double Ratchet (Ongoing P2P Messages)

```
Each message send:
  1. Advance symmetric ratchet → get new message key
  2. Encrypt plaintext with AES-256-GCM using message key → ciphertext
  3. Send ciphertext + ratchet header (DH public key, message number, chain number)

Each message receive:
  1. Read ratchet header
  2. If new DH public key: perform DH ratchet step (post-compromise recovery)
  3. Advance symmetric chain to correct message number
  4. Decrypt ciphertext with derived message key → plaintext
  5. Display plaintext in UI

Properties:
  - Forward secrecy: compromising current keys cannot decrypt past messages
  - Post-compromise recovery: new DH ratchet step heals after key compromise
  - Out-of-order delivery: message numbers allow decryption of out-of-order messages
```

### 12.5 Community Messages (Sender Keys)

**Storage:** Sender Keys are stored **locally on each device** in `flutter_secure_storage` (Android Keystore / iOS Keychain). Firestore does NOT store Sender Key symmetric material. The `/communities/{id}/senderKeys/{userId}` doc (Section 3.12) stores only the public signing key and metadata — the symmetric chain key is distributed peer-to-peer.

**Distribution:** When a Sender Key needs to be shared (join, re-key), the distributing user encrypts it via their existing P2P Signal session with each recipient and sends it as a special "key distribution" message through Firestore. Recipients decrypt with their P2P session and store the Sender Key locally.

**Failure handling:** If distribution to a member fails (e.g., no P2P session exists), the distributing user first establishes a P2P session via X3DH, then retries distribution. If a member is offline, the encrypted Sender Key message waits in Firestore until they come online and process it. Until a member has the Sender Key, they see "[Encrypted — key not yet received]" for messages from that sender.

```
When a user joins a community:
  1. User generates a new Sender Key for this community (AES-256-GCM key + Curve25519 signing key)
  2. For each existing member: encrypt the Sender Key using their P2P Signal session
     - If no P2P session exists: establish one via X3DH first
  3. Send encrypted Sender Key to each member via a "key distribution" message in Firestore
  4. Store own Sender Key locally in secure storage

When a user sends a community message:
  1. Advance Sender Key chain → get new symmetric key
  2. Encrypt message with AES-256-GCM using chain key → ciphertext
  3. Sign ciphertext with Sender Key signing key
  4. Send via Cloud Function: sendCommunityMessage({
       communityId, ciphertext, e2ee: { protocol: 'sender_key', senderKeyChainId, messageNumber }
     })
  5. ALL members decrypt using the sender's Sender Key (one encryption, many decryptions)

When a member LEAVES a community:
  1. All remaining members generate NEW Sender Keys (re-key)
  2. Distribute new Sender Keys to all remaining members via P2P sessions
  3. This ensures the departed member cannot decrypt future messages

When a new member JOINS:
  1. Existing members send their current Sender Keys to the new member (via P2P sessions)
  2. New member generates and distributes their own Sender Key to all existing members
  3. The new member CANNOT decrypt messages sent before they joined (by design)
```

### 12.6 Encrypted Inbox Preview

Each participant sees a decryptable preview in the conversation/community list:

```
When sending a message:
  1. Client generates preview text: truncate(plaintext, 100 chars)
  2. For each participant (P2P: 1 other, Community: all members):
     - Derive a preview key from the current session/sender key
     - Encrypt preview with AES-256-GCM → per-user ciphertext
  3. Include encryptedPreviews map in the Cloud Function call
  4. Cloud Function stores encryptedPreviews on the parent doc's lastMessage field

When displaying inbox list:
  1. Client reads conversation/community doc
  2. Finds their own encrypted preview in lastMessage.encryptedPreviews[myUserId]
  3. Decrypts with their local key → displays "Hey, are you coming to..."
  4. Falls back to lastMessage.plaintextPreview for system messages
  5. Falls back to "[Encrypted message]" if key is unavailable (e.g., new device without backup)
```

### 12.7 Media Encryption

```
Sending an image or voice message:
  1. Generate random AES-256-GCM key (media key) — unique per file
  2. Compress/process the media file (resize image, encode audio)
  3. Encrypt the processed file with the media key → encrypted blob
  4. Also encrypt thumbnail (if image) with a separate media key
  5. Upload encrypted blobs to Cloud Storage (server sees only encrypted bytes)
  6. Embed BOTH media keys inside the message ciphertext:
     plaintext = { text: "caption", mediaKey: "base64...", thumbKey: "base64..." }
  7. Encrypt the entire plaintext (including media keys) with Signal/Sender Key → ciphertext
  8. Send ciphertext via Cloud Function

Receiving an image or voice message:
  1. Decrypt ciphertext → plaintext (includes embedded media keys)
  2. Download encrypted blob from Cloud Storage URL
  3. Decrypt blob with embedded media key → original image/audio
  4. Display in UI

Cloud Storage paths (unchanged from Section 20):
  /conversations/{id}/images/{messageId}_full.enc    ← encrypted JPEG
  /conversations/{id}/images/{messageId}_thumb.enc   ← encrypted thumbnail
  /conversations/{id}/voice/{messageId}.enc          ← encrypted M4A
  /communities/{id}/images/{messageId}_full.enc
  /communities/{id}/images/{messageId}_thumb.enc
  /communities/{id}/voice/{messageId}.enc
```

### 12.8 Key Backup & Restoration

```
Creating a backup:
  1. User chooses a passphrase (min 8 chars, strength meter shown)
  2. Generate random salt (32 bytes)
  3. Derive encryption key: PBKDF2-SHA256(passphrase, salt, 600000 iterations) → 256-bit key
  4. Serialise all key material:
     - Identity key pair
     - Current signed pre-key pair
     - All active Double Ratchet session states (per conversation)
     - All Sender Keys (per community)
     - Registration ID
  5. Encrypt serialised blob with AES-256-GCM using derived key
  6. Upload encrypted blob to Google Drive (via Google Drive API)
  7. Write backup metadata to /users/{userId}/keys/backup:
     { backupExists: true, lastBackupAt: now, driveFileId: "...", kdf: { salt, iterations } }

Restoring on new device:
  1. User logs in on new phone → fresh registration starts
  2. App detects backup metadata in /users/{userId}/keys/backup
  3. Prompts: "We found an encrypted backup. Enter your passphrase to restore message history."
  4. Download encrypted blob from Google Drive
  5. Derive key from passphrase + stored salt + iterations
  6. Decrypt blob → restore all key material to Android Keystore / iOS Keychain
  7. Replace freshly-generated keys with restored keys
  8. Upload restored public key bundle (in case signed pre-key rotated)
  9. All existing sessions resume — old messages can be decrypted from Firestore cache

Without backup:
  1. Fresh keys are generated
  2. New key bundle uploaded
  3. All contacts see a "security keys changed" indicator (informational, not blocking)
  4. Old messages in Firestore cannot be decrypted (ciphertext remains, plaintext lost)
  5. New messages work normally from this point forward

Automatic backup:
  - After initial backup, the app auto-updates the backup every 24 hours (if new sessions exist)
  - Backup is silent (no user interaction needed after initial passphrase setup)
  - Badge shown in settings if backup is older than 7 days
```

### 12.9 Key Rotation

| Key Type | Rotation Schedule | Trigger |
|----------|------------------|---------|
| Identity Key | Never (except re-registration) | Generated once at registration |
| Signed Pre-Key | Every 30 days | Automatic via Cloud Function scheduled job |
| One-Time Pre-Keys | Consumed on use, replenished when < 20 remain | Client checks on app launch + after receiving any `fetchKeyBundle` response indicating low count. Cloud Function `replenishOneTimePreKeys` appends new keys. Server can also push a silent notification when OTK count drops below 20 (via `onWrite` trigger on key bundle doc). |
| Double Ratchet | Every message (symmetric), every reply pair (DH) | Automatic per protocol |
| Sender Keys | On member leave from community | All remaining members re-key |

### 12.10 Flutter E2EE Services

```dart
// lib/core/services/crypto_service.dart
@injectable
class CryptoService {
  /// Generate AES-256-GCM key
  Uint8List generateAesKey();

  /// Encrypt plaintext with AES-256-GCM
  CiphertextResult encrypt(Uint8List plaintext, Uint8List key);

  /// Decrypt ciphertext with AES-256-GCM
  Uint8List decrypt(String ciphertext, Uint8List key, Uint8List nonce);

  /// Generate Curve25519 key pair
  KeyPair generateCurve25519KeyPair();

  /// Perform X25519 Diffie-Hellman
  Uint8List diffieHellman(Uint8List privateKey, Uint8List publicKey);

  /// HKDF key derivation
  Uint8List hkdf(Uint8List inputKeyMaterial, Uint8List salt, Uint8List info, int length);

  /// PBKDF2 key derivation (for backup passphrase)
  Uint8List pbkdf2(String passphrase, Uint8List salt, int iterations);
}

// lib/core/services/key_management_service.dart
@injectable
class KeyManagementService {
  /// Generate full key bundle at registration
  Future<KeyBundle> generateKeyBundle();

  /// Upload public key bundle to Firestore
  Future<void> uploadKeyBundle(KeyBundle bundle);

  /// Fetch another user's public key bundle
  Future<PublicKeyBundle> fetchKeyBundle(String userId);

  /// Consume a one-time pre-key (called by Cloud Function)
  Future<void> consumeOneTimePreKey(String userId, int preKeyId);

  /// Replenish one-time pre-keys if count < 20
  Future<void> replenishOneTimePreKeysIfNeeded();

  /// Rotate signed pre-key (monthly)
  Future<void> rotateSignedPreKey();

  /// Store private keys in secure storage (Android Keystore / iOS Keychain)
  Future<void> storePrivateKeys(PrivateKeyMaterial keys);

  /// Load private keys from secure storage
  Future<PrivateKeyMaterial> loadPrivateKeys();
}

// lib/core/services/key_backup_service.dart
@injectable
class KeyBackupService {
  /// Create encrypted backup of all key material
  Future<void> createBackup(String passphrase);

  /// Restore key material from backup
  Future<bool> restoreFromBackup(String passphrase);

  /// Check if backup exists
  Future<bool> hasBackup();

  /// Get backup metadata (last backup time, etc.)
  Future<BackupMetadata?> getBackupMetadata();

  /// Auto-backup if new sessions exist (called periodically)
  Future<void> autoBackupIfNeeded();
}

// lib/core/services/signal_protocol_service.dart
@injectable
class SignalProtocolService {
  /// Establish new session with a user (X3DH + Double Ratchet init)
  Future<SessionState> establishSession(String userId, PublicKeyBundle theirBundle);

  /// Encrypt message for P2P conversation
  Future<EncryptedMessage> encryptP2P(String conversationId, String recipientId, String plaintext);

  /// Decrypt P2P message
  Future<String> decryptP2P(String conversationId, String senderId, String ciphertext, E2eeMetadata metadata);

  /// Check if session exists with user
  bool hasSession(String userId);
}

// lib/core/services/sender_key_service.dart
@injectable
class SenderKeyService {
  /// Generate Sender Key for a community
  Future<SenderKeyState> generateSenderKey(String communityId);

  /// Distribute Sender Key to a specific member (via their P2P Signal session)
  Future<void> distributeSenderKey(String communityId, String memberId);

  /// Distribute Sender Key to all members
  Future<void> distributeSenderKeyToAll(String communityId, List<String> memberIds);

  /// Encrypt community message with Sender Key
  Future<EncryptedMessage> encryptCommunity(String communityId, String plaintext);

  /// Decrypt community message with sender's Sender Key
  Future<String> decryptCommunity(String communityId, String senderId, String ciphertext, E2eeMetadata metadata);

  /// Re-key all Sender Keys for a community (on member leave)
  Future<void> rekeyAllSenderKeys(String communityId, List<String> remainingMemberIds);

  /// Process received Sender Key from another member
  Future<void> processReceivedSenderKey(String communityId, String senderId, String encryptedSenderKey);
}
```

### 12.11 E2EE Data Types

```dart
// lib/domain/entities/e2ee_types.dart

@freezed
class KeyBundle with _$KeyBundle {
  const factory KeyBundle({
    required KeyPair identityKeyPair,
    required SignedPreKey signedPreKey,
    required List<OneTimePreKey> oneTimePreKeys,
    required int registrationId,
  }) = _KeyBundle;
}

@freezed
class PublicKeyBundle with _$PublicKeyBundle {
  const factory PublicKeyBundle({
    required String identityPublicKey,      // Base64
    required int signedPreKeyId,
    required String signedPreKeyPublic,     // Base64
    required String signedPreKeySignature,  // Base64
    List<OneTimePreKeyPublic>? oneTimePreKeys,
    required int registrationId,
  }) = _PublicKeyBundle;
}

@freezed
class EncryptedMessage with _$EncryptedMessage {
  const factory EncryptedMessage({
    required String ciphertext,             // Base64-encoded AES-256-GCM output
    required E2eeMetadata e2ee,
    Map<String, String>? encryptedPreviews, // Per-user encrypted inbox preview
    X3dhHeader? x3dhHeader,                 // Only on first message in a session
  }) = _EncryptedMessage;
}

@freezed
class E2eeMetadata with _$E2eeMetadata {
  const factory E2eeMetadata({
    required String protocol,               // "signal" or "sender_key"
    int? senderKeyChainId,                  // Sender Key chain version (sender_key protocol only)
    int? messageNumber,                     // Ratchet message counter (ordering/dedup)
    String? dhPublicKey,                    // Current DH ratchet public key (signal protocol — needed for Double Ratchet DH step)
  }) = _E2eeMetadata;
}

@freezed
class X3dhHeader with _$X3dhHeader {
  const factory X3dhHeader({
    required String identityKey,            // Sender's identity public key (Base64)
    required String ephemeralKey,           // Sender's ephemeral public key (Base64)
    int? oneTimePreKeyId,                  // Which one-time pre-key was used (null if none available)
  }) = _X3dhHeader;
}

@freezed
class BackupMetadata with _$BackupMetadata {
  const factory BackupMetadata({
    required bool backupExists,
    DateTime? lastBackupAt,
    required int backupVersion,
    String? driveFileId,
  }) = _BackupMetadata;
}
```

### 12.12 Dart/Flutter Libraries

| Library | Purpose | Notes |
|---------|---------|-------|
| `cryptography` (pub.dev) | AES-256-GCM, X25519, HKDF, PBKDF2 | Pure Dart, well-maintained, >1000 likes |
| `pointycastle` (pub.dev) | Low-level crypto if `cryptography` lacks a primitive | Fallback only |
| `flutter_secure_storage` | Private key storage (Android Keystore / iOS Keychain) | Already in project for other secure data |
| `googleapis` / `google_sign_in` | Google Drive API for key backup upload/download | Standard Flutter packages |

**Note:** We implement the Signal Protocol (X3DH, Double Ratchet, Sender Keys) from scratch using the `cryptography` package's primitives, rather than using `libsignal_protocol_dart` (which is unmaintained). The protocol is well-documented and the primitives (X25519, AES-GCM, HKDF, HMAC-SHA256) are all available in `cryptography`.

---

# PHASE 3: iMali Gifts & Token Spray (Weeks 9-11)

---

## 13. Firestore Schema — Gifts & Token Sprays

### 13.1 Gifts Collection

```javascript
/gifts/{giftId}
{
  id: string,

  // Transaction participants
  senderId: string,
  senderName: string,
  recipientId: string,
  recipientName: string,
  amount: number,                    // Tokens

  // Context (where gift was sent)
  conversationId: string | null,     // If in direct message
  communityId: string | null,        // If in community
  messageId: string,                 // Associated message ID

  // Presentation
  // NOTE: Personal message is NOT stored on the gift doc (it's E2EE in the message ciphertext).
  // The gift doc only stores unencrypted financial/status metadata.
  style: "ndlovukazi" | "celebration" | "love" | "birthday" | "professional",

  // Status tracking
  status: "pending" | "opened" | "claimed" | "expired",

  // Timestamps
  createdAt: Timestamp,
  openedAt: Timestamp | null,        // When recipient tapped "open"
  claimedAt: Timestamp | null,       // When tokens transferred
  expiresAt: Timestamp,              // 7 days from creation

  // Accounting (references to ledger)
  debitTransactionId: string,        // Sender's wallet debit
  creditTransactionId: string | null, // Recipient's credit (when claimed)

  // Metadata
  notificationSent: boolean,
  reminderSent: boolean,             // Reminder 2 days before expiry
}
```

### 13.2 Token Sprays Collection

```javascript
/tokenSprays/{sprayId}
{
  id: string,

  // Community context
  communityId: string,
  communityName: string,
  messageId: string,                 // Associated message in community

  // Celebration details
  creatorId: string,                 // Who started spray
  creatorName: string,
  recipientId: string,               // Celebrant
  recipientName: string,
  occasion: "new_job" | "birthday" | "graduation" | "new_baby" | "wedding" | "achievement" | "custom",
  occasionText: string,              // Display text (unencrypted — not personal content, just "Birthday", "New Job", etc.)
  // NOTE: Personal celebration message is NOT stored on the spray doc.
  // It lives E2EE-encrypted in the community message ciphertext.
  // The spray doc only stores unencrypted financial/status/occasion metadata.

  // Financial tracking
  targetAmount: number | null,       // Optional target
  currentTotal: number,              // Sum of all contributions

  // Contributors (map for scale)
  contributions: {
    [userId]: {
      amount: number,
      contributedAt: Timestamp,
      displayName: string,
      message: string | null,        // Optional contributor message
    }
  },
  contributorCount: number,          // Denormalized

  // Leaderboard (top 5 for display)
  topContributors: [
    {
      userId: string,
      displayName: string,
      amount: number,
      rank: number,                  // 1-5
    }
  ],

  // Status
  status: "active" | "closed" | "claimed" | "expired",

  // Timestamps
  createdAt: Timestamp,
  closedAt: Timestamp | null,        // Manual or auto-close
  claimedAt: Timestamp | null,       // When recipient claimed
  expiresAt: Timestamp,              // Auto-close after 24 hours

  // Accounting
  debitTransactionIds: [string],     // All contributor debits
  creditTransactionId: string | null, // Recipient credit

  // Notifications
  notificationsSent: {
    created: boolean,
    reminders: [Timestamp],
    closed: boolean,
  },
}
```

### 13.3 Firestore Security Rules (Gifts & Sprays)

```javascript
// Gifts (read-only for clients — create/update via Cloud Functions)
match /gifts/{giftId} {
  allow read: if isAuthenticated() &&
    (resource.data.senderId == request.auth.uid ||
     resource.data.recipientId == request.auth.uid);
  allow write: if false;
}

// Token Sprays (read-only for clients — create/update via Cloud Functions)
match /tokenSprays/{sprayId} {
  allow read: if isAuthenticated() &&
    isCommunityMember(
      get(/databases/$(database)/documents/communities/$(resource.data.communityId)).data
    );
  allow write: if false;
}
```

### 13.4 Indexes (Gifts & Sprays)

```yaml
# Gifts
gifts:
  - recipientId + status + createdAt (desc)
  - senderId + createdAt (desc)
  - status + expiresAt (asc)           # For expiry scheduled job

# Token Sprays
tokenSprays:
  - communityId + status + createdAt (desc)
  - status + expiresAt (asc)            # For auto-close scheduled job
  - recipientId + status + createdAt (desc)
```

---

## 14. Flutter Domain Layer — Gifts & Token Spray

### 14.1 Gift Enums

```dart
// lib/domain/enums/gift_style.dart
enum GiftStyle {
  @JsonValue('ndlovukazi')
  ndlovukazi,        // Zulu queen — grandest
  @JsonValue('celebration')
  celebration,       // Party
  @JsonValue('love')
  love,              // Hearts
  @JsonValue('birthday')
  birthday,          // Candles
  @JsonValue('professional')
  professional,      // Business-like
}

// lib/domain/enums/gift_status.dart
enum GiftStatus {
  @JsonValue('pending')
  pending,           // Created, not yet opened
  @JsonValue('opened')
  opened,            // Recipient saw it
  @JsonValue('claimed')
  claimed,           // Tokens transferred
  @JsonValue('expired')
  expired,           // 7-day expiry passed
}

// lib/domain/enums/spray_occasion.dart
enum SprayOccasion {
  @JsonValue('new_job')
  newJob,
  @JsonValue('birthday')
  birthday,
  @JsonValue('graduation')
  graduation,
  @JsonValue('new_baby')
  newBaby,
  @JsonValue('wedding')
  wedding,
  @JsonValue('achievement')
  achievement,
  @JsonValue('custom')
  custom,
}

// lib/domain/enums/spray_status.dart
enum SprayStatus {
  @JsonValue('active')
  active,
  @JsonValue('closed')
  closed,
  @JsonValue('claimed')
  claimed,
  @JsonValue('expired')
  expired,
}
```

### 14.2 Gift Entity

```dart
// lib/domain/entities/gift.dart
@freezed
class Gift with _$Gift {
  const factory Gift({
    required String id,
    required String senderId,
    required String senderName,
    required String recipientId,
    required String recipientName,
    required int amount,
    String? conversationId,
    String? communityId,
    required String messageId,
    // NOTE: Personal message is NOT stored on the Gift entity.
    // It lives in the E2EE ciphertext of the associated message.
    // After decryption, the personal text is in Message.textContent.
    required GiftStyle style,
    required GiftStatus status,
    required DateTime createdAt,
    DateTime? openedAt,
    DateTime? claimedAt,
    required DateTime expiresAt,
    String? debitTransactionId,
    String? creditTransactionId,
  }) = _Gift;

  const Gift._();

  bool get isPending => status == GiftStatus.pending;
  bool get isOpened => status == GiftStatus.opened;
  bool get isClaimed => status == GiftStatus.claimed;
  bool get isExpired => status == GiftStatus.expired || DateTime.now().isAfter(expiresAt);
  bool get isInConversation => conversationId != null;
  bool get isInCommunity => communityId != null;
  double get amountZar => amount / 100;

  /// Display name for the gift style
  String get styleDisplayName {
    switch (style) {
      case GiftStyle.ndlovukazi: return 'Ndlovukazi';
      case GiftStyle.celebration: return 'Celebration';
      case GiftStyle.love: return 'Love';
      case GiftStyle.birthday: return 'Birthday';
      case GiftStyle.professional: return 'Professional';
    }
  }
}
```

### 14.3 TokenSpray Entity

```dart
// lib/domain/entities/token_spray.dart
@freezed
class TokenSpray with _$TokenSpray {
  const factory TokenSpray({
    required String id,
    required String communityId,
    required String communityName,
    required String messageId,
    required String creatorId,
    required String creatorName,
    required String recipientId,
    required String recipientName,
    required SprayOccasion occasion,
    required String occasionText,
    // NOTE: Personal celebration message is NOT stored on the TokenSpray entity.
    // It lives in the E2EE ciphertext of the associated community message.
    int? targetAmount,
    required int currentTotal,
    required Map<String, SprayContribution> contributions,
    required int contributorCount,
    @Default([]) List<SprayTopContributor> topContributors,
    required SprayStatus status,
    required DateTime createdAt,
    DateTime? closedAt,
    DateTime? claimedAt,
    required DateTime expiresAt,
  }) = _TokenSpray;

  const TokenSpray._();

  bool get isActive => status == SprayStatus.active;
  bool get isClosed => status == SprayStatus.closed;
  bool get isClaimed => status == SprayStatus.claimed;
  bool get isExpired => status == SprayStatus.expired || DateTime.now().isAfter(expiresAt);
  double get currentTotalZar => currentTotal / 100;
  double get progressPercent => targetAmount != null && targetAmount! > 0
      ? (currentTotal / targetAmount!).clamp(0.0, 1.0)
      : 0.0;
  bool hasContributed(String userId) => contributions.containsKey(userId);
}

@freezed
class SprayContribution with _$SprayContribution {
  const factory SprayContribution({
    required int amount,
    required DateTime contributedAt,
    required String displayName,
    String? message,
  }) = _SprayContribution;
}

@freezed
class SprayTopContributor with _$SprayTopContributor {
  const factory SprayTopContributor({
    required String userId,
    required String displayName,
    required int amount,
    required int rank,
  }) = _SprayTopContributor;
}
```

### 14.4 Extended Message Types for Gifts & Spray

The existing `MessageType` enum (Section 4.1) needs two additions:

```dart
enum MessageType { text, image, voice, tokenSend, tokenRequest, gift, tokenSpray, system }
```

The `Message` entity (Section 4.3) needs two optional embedded fields:

```dart
// Added to Message entity:
GiftMessageData? gift,
TokenSprayMessageData? tokenSpray,

// Embedded data classes:
//
// E2EE NOTE: Gift and Spray messages are HYBRID encrypted:
// - The personal message text is part of the encrypted ciphertext (E2EE).
// - The Firestore message doc stores unencrypted financial/status metadata
//   in the `gift` / `tokenSpray` embedded fields below, so the server can
//   process lifecycle events (open, claim, expire) and clients can render
//   the card UI (amount, style, status) without decrypting the ciphertext.
// - The personal text only becomes visible after the client decrypts the
//   ciphertext and populates `textContent` (which includes the personal message).

@freezed
class GiftMessageData with _$GiftMessageData {
  const factory GiftMessageData({
    required String giftId,
    required int amount,                // Unencrypted — needed for card UI
    required GiftStyle style,           // Unencrypted — needed for card UI
    required GiftStatus status,         // Unencrypted — updated by server on open/claim/expire
    String? recipientId,                // For community gifts (targeted to a member)
    String? recipientName,
    // NOTE: Personal message is NOT here — it lives in the E2EE ciphertext.
    // After decryption, `Message.textContent` contains the gift personal message.
  }) = _GiftMessageData;
}

@freezed
class TokenSprayMessageData with _$TokenSprayMessageData {
  const factory TokenSprayMessageData({
    required String sprayId,
    required String recipientId,        // Unencrypted — needed for card UI
    required String recipientName,      // Unencrypted — needed for card UI
    required String occasion,           // Unencrypted — "birthday", "new_job", etc.
    required int currentTotal,          // Unencrypted — live-updated by server
    required int contributorCount,      // Unencrypted — live-updated by server
    required SprayStatus status,        // Unencrypted — updated by server
    int? targetAmount,                  // Unencrypted — set at creation
    required DateTime expiresAt,        // Unencrypted — needed for countdown
    // NOTE: Personal celebration message is NOT here — it lives in the E2EE ciphertext.
    // After decryption, `Message.textContent` contains the celebration message.
  }) = _TokenSprayMessageData;
}
```

### 14.5 Gift Repository Interface

```dart
// lib/domain/repositories/gift_repository.dart
abstract class GiftRepository {
  // Send gift (creates gift + associated message)
  Future<Either<Failure, Gift>> sendGift({
    required String recipientId,
    required int amount,
    required String message,
    required GiftStyle style,
    String? conversationId,    // One of these must be provided
    String? communityId,
  });

  // Gift lifecycle
  Future<Either<Failure, Gift>> openGift(String giftId);
  Future<Either<Failure, Gift>> claimGift(String giftId);

  // Query
  Future<Either<Failure, List<Gift>>> getSentGifts({int? limit});
  Future<Either<Failure, List<Gift>>> getReceivedGifts({int? limit});
  Future<Either<Failure, Gift>> getGift(String giftId);
  Stream<Either<Failure, Gift>> watchGift(String giftId);

  // Stats
  Future<Either<Failure, GiftStats>> getGiftStats();
}

@freezed
class GiftStats with _$GiftStats {
  const factory GiftStats({
    required int totalSent,
    required int totalReceived,
    required int totalAmountSent,
    required int totalAmountReceived,
  }) = _GiftStats;
}
```

### 14.6 TokenSpray Repository Interface

```dart
// lib/domain/repositories/token_spray_repository.dart
abstract class TokenSprayRepository {
  // Create spray
  Future<Either<Failure, TokenSpray>> createSpray({
    required String communityId,
    required String recipientId,
    required SprayOccasion occasion,
    required String message,
    int? targetAmount,
  });

  // Contribute
  Future<Either<Failure, TokenSpray>> contributeToSpray({
    required String sprayId,
    required int amount,
    String? message,
  });

  // Lifecycle
  Future<Either<Failure, TokenSpray>> closeSpray(String sprayId);
  Future<Either<Failure, TokenSpray>> claimSpray(String sprayId);

  // Query
  Future<Either<Failure, TokenSpray>> getSpray(String sprayId);
  Stream<Either<Failure, TokenSpray>> watchSpray(String sprayId);
  Future<Either<Failure, List<TokenSpray>>> getCommunitySprayHistory(String communityId, {int? limit});
}
```

---

## 15. Cloud Functions — Gifts & Token Spray

### 15.1 `functions/src/gifts.ts` (~500 lines)

| Function | Parameters | Security | Description |
|----------|-----------|----------|-------------|
| `sendGift` | `{recipientId, amount, ciphertext, e2ee, encryptedPreviews, style, conversationId?, communityId?, idempotencyKey}` | Auth + AppCheck + PlayIntegrity | Validates balance, debits sender via ledger (idempotent), creates `/gifts/{id}` doc, writes E2EE gift message to conversation/community messages subcollection. Personal message is in the ciphertext, NOT stored on the gift doc. |
| `openGift` | `{giftId}` | Auth + AppCheck | Updates gift status to "opened", sets `openedAt`. Only recipient can open. |
| `claimGift` | `{giftId}` | Auth + AppCheck + PlayIntegrity | Validates gift is opened + not expired, credits recipient via ledger, updates status to "claimed", sets `claimedAt` |
| `expireGifts` | (scheduled) | Scheduled (hourly) | Finds gifts where `status in ["pending", "opened"]` and `expiresAt < now`, refunds sender from GIFT_ESCROW via ledger, updates status to "expired". Both pending AND opened gifts can expire — opened-but-unclaimed gifts must not lock tokens permanently. |
| `sendGiftExpiryReminders` | (scheduled) | Scheduled (daily) | Finds gifts expiring in 2 days, sends push notification to recipient |

**Key: `sendGift` pseudocode (E2EE + fully atomic transaction + idempotent):**
```typescript
export const sendGift = functions.https.onCall(async (data, context) => {
  requireAuth(context);
  requireAppCheck(context);
  requirePlayIntegrity(context);

  const { recipientId, amount, ciphertext, e2ee, encryptedPreviews,
          style, conversationId, communityId, idempotencyKey } = data;
  const userId = context.auth!.uid;

  // 1. Validate amount (min 10 tokens)
  if (amount < 10) throw new HttpsError('invalid-argument', 'Minimum gift is 10 tokens');

  // 2. Validate context (must have conversationId OR communityId)
  if (!conversationId && !communityId) throw new HttpsError('invalid-argument', 'Must specify context');

  // 3. Get user data (outside transaction — immutable reads)
  const sender = await getUserOrThrow(userId);
  const recipient = await getUserOrThrow(recipientId);

  // 4. SINGLE Firestore transaction wraps idempotency check + ledger debit + gift/message creation
  //    This prevents RC-15: ledger debit succeeding but gift doc creation failing.
  const result = await db.runTransaction(async (transaction) => {
    // 4a. Idempotency check INSIDE transaction (prevents TOCTOU race — RC-11)
    const idempotencyRef = db.collection('idempotencyKeys').doc(idempotencyKey);
    const existing = await transaction.get(idempotencyRef);
    if (existing.exists) return existing.data()!.result;  // Return cached result

    // 4b. Debit sender via ledger INSIDE the transaction (escrow to GIFT_ESCROW)
    //     The ledger function accepts the transaction object to participate in the same scope.
    const debitTxId = await processGiftDebit(userId, amount,
      `Gift to ${recipient.displayName}`, idempotencyKey, transaction);

    // 4c. Create gift doc + gift message + update parent lastMessage — all in same transaction
    const giftRef = db.collection('gifts').doc();
    const collection = conversationId ? 'conversations' : 'communities';
    const parentId = conversationId || communityId!;
    const msgRef = db.collection(collection).doc(parentId).collection('messages').doc();

  // 5a. Gift document — NO personal message stored (E2EE: message is in ciphertext)
  batch.set(giftRef, {
    id: giftRef.id,
    senderId: userId,
    senderName: sender.displayName,
    recipientId,
    recipientName: recipient.displayName,
    amount,
    conversationId: conversationId || null,
    communityId: communityId || null,
    messageId: msgRef.id,
    style,
    status: 'pending',
    createdAt: serverTimestamp(),
    expiresAt: Timestamp.fromDate(addDays(new Date(), 7)),
    debitTransactionId: debitTxId,
    creditTransactionId: null,
    notificationSent: false,
    reminderSent: false,
  });

    // 4d. Gift message — ciphertext contains the personal message (E2EE)
    transaction.set(msgRef, {
      id: msgRef.id,
      [conversationId ? 'conversationId' : 'communityId']: parentId,
      senderId: userId,
      senderName: sender.displayName,
      senderAvatarUrl: sender.profilePicThumbUrl || null,
      type: 'gift',
      status: 'sent',
      ciphertext,                            // E2EE: encrypted personal message
      textContent: null,                     // ALWAYS null on server
      e2ee,                                  // { protocol, messageNumber, ... }
      gift: {                                // Unencrypted gift metadata for card UI
        giftId: giftRef.id,
        amount,
        style,
        status: 'pending',
        recipientId,
        recipientName: recipient.displayName,
      },
      reactions: {},
      createdAt: serverTimestamp(),
    });

    // 4e. Update parent lastMessage with encrypted previews
    transaction.update(db.collection(collection).doc(parentId), {
      lastMessage: {
        senderId: userId,
        senderName: sender.displayName,
        type: 'gift',
        timestamp: serverTimestamp(),
        encryptedPreviews: encryptedPreviews,
        plaintextPreview: null,
      },
      lastMessageAt: serverTimestamp(),
      // Increment unread for all other participants/members
      ...buildUnreadIncrements(parentId, userId, collection),
    });

    // 4f. Save idempotency result
    const txResult = { success: true, giftId: giftRef.id };
    transaction.set(idempotencyRef, { result: txResult, createdAt: serverTimestamp(), expiresAt: Timestamp.fromDate(addDays(new Date(), 1)) });

    return txResult;
  });  // END db.runTransaction

  // 5. Send push notification OUTSIDE transaction (non-E2EE: no message content revealed)
  await sendPushNotification(recipientId, {
    title: `${sender.displayName} sent you a gift!`,
    body: `Tap to open your ${amount} token gift`,
    data: { type: 'gift_received', giftId: result.giftId, conversationId, communityId },
  });

  return result;
});
```

### 15.2 `functions/src/tokenSprays.ts` (~600 lines)

| Function | Parameters | Security | Description |
|----------|-----------|----------|-------------|
| `createTokenSpray` | `{communityId, recipientId, occasion, ciphertext, e2ee, encryptedPreviews, targetAmount?}` | Auth + AppCheck | Creates spray doc (occasion text is unencrypted metadata; personal celebration message is E2EE encrypted in ciphertext), writes `token_spray` message to community chat with E2EE ciphertext, notifies community. The `message` field on the spray doc is set to a generic occasion label (e.g., "Birthday celebration"), NOT the personal message. |
| `contributeToSpray` | `{sprayId, amount, message?, idempotencyKey}` | Auth + AppCheck + PlayIntegrity | Validates spray is active + not expired (inside transaction), debits contributor (idempotent), atomically updates spray totals + leaderboard + message embed |
| `closeTokenSpray` | `{sprayId}` | Auth + AppCheck | Only creator/admin can close. Credits recipient, updates status. |
| `claimTokenSpray` | `{sprayId}` | Auth + AppCheck + PlayIntegrity | Only recipient can claim. Transfers accumulated tokens. |
| `closeExpiredSprays` | (scheduled) | Scheduled (hourly) | Finds active sprays where `expiresAt < now`, sets status='closed' + autoExpired=true + closedAt=now. Does NOT auto-credit — recipient must claim. Posts system message to community chat. |

**Key: `contributeToSpray` pseudocode (atomic transaction + idempotent):**
```typescript
export const contributeToSpray = functions.https.onCall(async (data, context) => {
  requireAuth(context);
  requireAppCheck(context);
  requirePlayIntegrity(context);

  const { sprayId, amount, message, idempotencyKey } = data;
  const userId = context.auth!.uid;

  // 0. Idempotency check — prevent double-contribution on retry
  const idempotencyRef = db.collection('idempotencyKeys').doc(idempotencyKey);
  const existing = await idempotencyRef.get();
  if (existing.exists) return existing.data()!.result;

  // 1. Validate amount upfront (before transaction)
  if (amount < 10) throw new HttpsError('invalid-argument', 'Minimum contribution is 10 tokens');

  // 2. Get contributor info upfront
  const user = await getUserOrThrow(userId);

  // 3. Run everything in a Firestore transaction to prevent race conditions
  //    (e.g., spray closing while contribution is being processed)
  const result = await db.runTransaction(async (tx) => {
    const sprayRef = db.collection('tokenSprays').doc(sprayId);
    const sprayDoc = await tx.get(sprayRef);
    if (!sprayDoc.exists) throw new HttpsError('not-found', 'Spray not found');
    const spray = sprayDoc.data()!;

    // 3a. Validate spray state (inside transaction for consistency)
    if (spray.status !== 'active') throw new HttpsError('failed-precondition', 'Spray is not active');
    if (spray.expiresAt.toDate() < new Date()) throw new HttpsError('failed-precondition', 'Spray expired');
    if (userId === spray.recipientId) throw new HttpsError('permission-denied', 'Recipient cannot contribute');

    // 3b. Verify community membership
    await requireCommunityMember(spray.communityId, userId);

    // 3c. Debit contributor via ledger INSIDE the transaction
    //     The ledger function accepts the `tx` transaction object to avoid nested transactions (RC-16).
    //     Firestore does NOT support nested db.runTransaction() — both the spray update
    //     and ledger debit MUST share the same transaction scope.
    const debitTxId = await processSprayContributionDebit(userId, amount, sprayId, idempotencyKey, tx);

    // 3d. Calculate new totals
    const existingContribution = spray.contributions?.[userId];
    const newAmount = (existingContribution?.amount || 0) + amount;
    const newTotal = spray.currentTotal + amount;
    const newContributorCount = existingContribution
      ? spray.contributorCount
      : spray.contributorCount + 1;

    // 3e. Update spray doc atomically
    tx.update(sprayRef, {
      [`contributions.${userId}`]: {
        amount: newAmount,
        contributedAt: serverTimestamp(),
        displayName: user.displayName,
        message: message || existingContribution?.message || null,
      },
      currentTotal: FieldValue.increment(amount),
      contributorCount: newContributorCount,
      debitTransactionIds: FieldValue.arrayUnion([debitTxId]),
      topContributors: recalculateLeaderboard(spray.contributions, userId, newAmount),
    });

    // 3f. Update the spray message embed in community chat
    const msgRef = db.collection('communities').doc(spray.communityId)
      .collection('messages').doc(spray.messageId);
    tx.update(msgRef, {
      'tokenSpray.currentTotal': newTotal,
      'tokenSpray.contributorCount': newContributorCount,
    });

    return { success: true, newTotal };
  });

  // 4. Save idempotency result (outside transaction — acceptable if this fails)
  await idempotencyRef.set({ result, createdAt: serverTimestamp(), expiresAt: Timestamp.fromDate(addDays(new Date(), 1)) });

  // 5. Post system message (non-critical — outside transaction)
  await sendSystemMessage(spray.communityId,
    `${user.displayName} contributed ${amount} tokens to the spray!`);

  return result;
});
```

---

## 16. BLoC Specifications — Gifts & Token Spray

### 16.1 GiftBloc

```dart
@freezed
class GiftEvent with _$GiftEvent {
  // Send
  const factory GiftEvent.sendGift({
    required String recipientId,
    required int amount,
    required String message,
    required GiftStyle style,
    String? conversationId,
    String? communityId,
  }) = _SendGift;

  // Lifecycle
  const factory GiftEvent.openGift(String giftId) = _OpenGift;
  const factory GiftEvent.claimGift(String giftId) = _ClaimGift;

  // Load
  const factory GiftEvent.loadSentGifts() = _LoadSentGifts;
  const factory GiftEvent.loadReceivedGifts() = _LoadReceivedGifts;
  const factory GiftEvent.watchGift(String giftId) = _WatchGift;
  const factory GiftEvent.giftUpdated(Gift gift) = _GiftUpdated;

  // Stats
  const factory GiftEvent.loadGiftStats() = _LoadGiftStats;

  const factory GiftEvent.clearError() = _ClearError;
}

@freezed
class GiftState with _$GiftState {
  const factory GiftState({
    @Default([]) List<Gift> sentGifts,
    @Default([]) List<Gift> receivedGifts,
    Gift? activeGift,                  // Currently being opened/viewed
    GiftStats? stats,
    @Default(false) bool isLoading,
    @Default(false) bool isSending,
    @Default(false) bool isClaiming,
    String? errorMessage,
  }) = _GiftState;
}
```

### 16.2 TokenSprayBloc (Scoped per community)

```dart
@freezed
class TokenSprayEvent with _$TokenSprayEvent {
  const factory TokenSprayEvent.createSpray({
    required String recipientId,
    required SprayOccasion occasion,
    required String message,
    int? targetAmount,
  }) = _CreateSpray;

  const factory TokenSprayEvent.contribute({
    required String sprayId,
    required int amount,
    String? message,
  }) = _Contribute;

  const factory TokenSprayEvent.closeSpray(String sprayId) = _CloseSpray;
  const factory TokenSprayEvent.claimSpray(String sprayId) = _ClaimSpray;

  const factory TokenSprayEvent.watchSpray(String sprayId) = _WatchSpray;
  const factory TokenSprayEvent.sprayUpdated(TokenSpray spray) = _SprayUpdated;

  const factory TokenSprayEvent.loadHistory() = _LoadHistory;

  const factory TokenSprayEvent.clearError() = _ClearError;
}

@freezed
class TokenSprayState with _$TokenSprayState {
  const factory TokenSprayState({
    required String communityId,
    TokenSpray? activeSpray,           // Currently viewing
    @Default([]) List<TokenSpray> history,
    @Default(false) bool isLoading,
    @Default(false) bool isContributing,
    String? errorMessage,
  }) = _TokenSprayState;
}
```

---

## 17. Screens — Gifts & Token Spray

### 17.1 Gift Screens

| Screen | Route | Description |
|--------|-------|-------------|
| `GiftComposerScreen` | `/chat/conversation/:id/send-gift` or `/chat/community/:id/send-gift` | Select recipient (community only), amount, message, gift style. Shows balance. Preview before sending. |
| `GiftOpeningScreen` | Modal overlay | Full-screen animated reveal. Style-specific animations (Ndlovukazi = gold particles, Birthday = confetti, etc). Shows amount + personal message. "Claim Tokens" button. |
| `GiftHistoryScreen` | `/profile/gift-history` | Tabs: Sent / Received. Each item shows recipient/sender, amount, style icon, status badge, timestamp. |

### 17.2 Token Spray Screens

| Screen | Route | Description |
|--------|-------|-------------|
| `CreateSprayScreen` | `/chat/community/:id/create-spray` | Select recipient from member list, choose occasion, write message, optional target amount. |
| `SprayDetailScreen` | Modal/bottom sheet | Live-updating spray card: progress bar (if target), contributor list with amounts, leaderboard (top 5 with crown/medal icons), countdown timer, "Contribute" button. |
| `SprayContributeSheet` | Bottom sheet | Amount input, quick-amount chips (50/100/200/500), optional message, balance display, contribute button. |

### 17.3 Widgets — Gifts & Spray

| Widget | Used In | Description |
|--------|---------|-------------|
| `GiftBubble` | Message list | Gift-style card in message stream. Wrapped present icon, amount, "Tap to open" for recipient, status for sender. |
| `GiftStylePicker` | GiftComposerScreen | Horizontal scroll of 5 gift styles with preview animations. |
| `SprayBubble` | Community message list | Live-updating spray card: occasion icon, progress bar, contributor count, countdown timer, "Contribute" button for non-recipients. |
| `SprayLeaderboard` | SprayDetailScreen | Top 5 contributors with rank medals, amounts, and optional crown for #1. |
| `SprayCountdown` | SprayBubble, SprayDetailScreen | Animated countdown timer showing hours:minutes remaining. |

---

# PHASE 4: Sharing, Notifications, Security, Media, Polish & Launch (Weeks 12-14)

---

## 18. Sharing & Deep Linking

### 18.1 Share Service

```dart
// lib/core/services/share_service.dart
@injectable
class ShareService {
  /// Share achievement to external platforms
  Future<void> shareAchievement({
    required String achievement,
    required int amount,
  }) async {
    final referralCode = await _getReferralCode();
    final text = '''
I just earned $amount tokens on iMaliChat!
$achievement

Join me and start earning rewards:
https://imalichat.app/join?ref=$referralCode
''';
    await Share.share(text, subject: 'Check out what I earned on iMaliChat!');
  }

  /// Generate community invite link
  Future<String> generateCommunityInviteLink(String communityId) async {
    final currentUserId = await _getCurrentUserId();
    final parameters = DynamicLinkParameters(
      uriPrefix: 'https://imalichat.page.link',
      link: Uri.parse('https://imalichat.app/join/community/$communityId?inviter=$currentUserId'),
      androidParameters: AndroidParameters(packageName: 'com.imalichat.app', minimumVersion: 1),
      iosParameters: IOSParameters(bundleId: 'com.imalichat.app', minimumVersion: '1.0.0'),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Join our community on iMaliChat',
      ),
    );
    final shortLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return shortLink.shortUrl.toString();
  }
}
```

### 18.2 Deep Link Handler

```dart
// lib/core/services/deep_link_service.dart
@injectable
class DeepLinkService {
  Future<void> initialize() async {
    final initialLink = await getInitialLink();
    if (initialLink != null) _handleDeepLink(initialLink);
    linkStream.listen((link) { if (link != null) _handleDeepLink(link); });
  }

  Future<void> _handleDeepLink(String link) async {
    final uri = Uri.parse(link);

    if (uri.path.startsWith('/join/community/')) {
      final communityId = uri.pathSegments.last;
      final inviterId = uri.queryParameters['inviter'];
      _navigateToCommunityJoin(communityId, inviterId);
    } else if (uri.path.startsWith('/chat/')) {
      final userId = uri.pathSegments.last;
      _navigateToConversation(userId);
    } else if (uri.path == '/join') {
      final referralCode = uri.queryParameters['ref'];
      _handleReferral(referralCode);
    }
  }
}
```

### 18.3 QR Code System

| Feature | Implementation |
|---------|---------------|
| User QR Code | `imalichat://user/{userId}` — scan to start conversation |
| Community QR Code | `imalichat://community/{communityId}` — scan to join |
| QR Scanner Screen | Camera-based scanner with overlay, routes to appropriate action |
| QR Generation | `qr_flutter` package, embedded app logo, share button |

### 18.4 Routes

```
/profile/qr-code              → Show user's QR code
/chat/community/:id/qr-code   → Show community's QR code
/scan                          → QR scanner camera screen
```

---

## 19. Notifications System

### 19.1 Notification Types

```dart
enum NotificationType {
  // Messages
  newMessage,
  newMessageInCommunity,

  // Gifts
  giftReceived,
  giftOpened,
  giftExpired,
  giftExpiringSoon,

  // Token Spray
  tokenSprayStarted,
  tokenSprayContribution,
  tokenSprayClosed,
  tokenSprayReceived,
  tokenSprayTopContributor,

  // Communities
  communityInvite,
  addedToCommunity,
  removedFromCommunity,
  promotedToAdmin,

  // Stokvels
  contributionDue,
  contributionOverdue,
  allContributionsReceived,
  payoutDay,
  payoutReceived,

  // System
  announcement,
}
```

### 19.2 FCM Cloud Function Triggers

Already specified in Section 5.5 (`messagingNotifications.ts`). Additional triggers for Phase 3-4:

```typescript
// functions/src/giftNotifications.ts (~150 lines)

// Trigger: gift created → notify recipient
exports.onGiftCreated = functions.firestore
  .document('gifts/{giftId}')
  .onCreate(async (snap, context) => { ... });

// Trigger: gift opened → notify sender
exports.onGiftOpened = functions.firestore
  .document('gifts/{giftId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    if (before.status === 'pending' && after.status === 'opened') {
      await sendPushNotification(after.senderId, {
        title: `${after.recipientName} opened your gift!`,
        body: `Your ${after.amount} token gift was opened`,
      });
    }
  });

// functions/src/sprayNotifications.ts (~150 lines)

// Trigger: new contribution → notify community + recipient
exports.onSprayContribution = functions.firestore
  .document('tokenSprays/{sprayId}')
  .onUpdate(async (change, context) => { ... });

// Trigger: spray closed → notify recipient + all contributors
exports.onSprayClosed = functions.firestore
  .document('tokenSprays/{sprayId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    if (before.status === 'active' && after.status === 'closed') {
      // Notify recipient
      await sendPushNotification(after.recipientId, {
        title: 'You received a Token Spray!',
        body: `The community celebrated with ${after.currentTotal} tokens!`,
      });
      // Notify top contributor
      if (after.topContributors.length > 0) {
        await sendPushNotification(after.topContributors[0].userId, {
          title: "You're the Top Donor!",
          body: `You contributed the most to ${after.recipientName}'s celebration!`,
        });
      }
    }
  });
```

### 19.3 Flutter Notification Handling

```dart
// lib/core/services/notification_service.dart
@injectable
class NotificationService {
  Future<void> initialize() async {
    await _requestPermission();
    final token = await FirebaseMessaging.instance.getToken();
    await _saveTokenToFirestore(token);
    FirebaseMessaging.instance.onTokenRefresh.listen(_saveTokenToFirestore);
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
  }

  void _handleNotificationTap(RemoteMessage message) {
    final type = message.data['type'];
    switch (type) {
      case 'new_message':
        _router.go('/chat/conversation/${message.data['conversationId']}');
      case 'new_community_message':
        _router.go('/chat/community/${message.data['communityId']}');
      case 'gift_received':
        _router.go('/chat/conversation/${message.data['conversationId']}');
      case 'token_spray_received':
        _router.go('/chat/community/${message.data['communityId']}');
      case 'stokvel_contribution_due':
        _router.go('/chat/community/${message.data['communityId']}');
    }
  }
}
```

### 19.4 User Document Chat Extensions

```javascript
// Additions to /users/{userId} document:
{
  // Chat status
  chat: {
    status: "online" | "offline" | "away",
    lastSeen: Timestamp,
    blockedUserIds: [string],
  },

  // Quick references
  conversationIds: [string],
  communityIds: [string],

  // Notification preferences
  notificationSettings: {
    allMessages: boolean,            // Default: true
    mentionsOnly: boolean,           // Default: false
    mutedConversationIds: [string],
    mutedCommunityIds: [string],
    quietHoursStart: string | null,  // "22:00"
    quietHoursEnd: string | null,    // "07:00"
  },

  // Stats (for gamification)
  stats: {
    totalMessagesSent: number,
    totalGiftsSent: number,
    totalGiftsReceived: number,
    communitiesCreated: number,
    stokvelsJoined: number,
  },
}
```

---

## 20. Security & Privacy

### 20.1 Block User

```dart
// Cloud Function: blockUser
// 1. Add userToBlockId to blockedUserIds array on user doc
// 2. Soft-delete any existing P2P conversation between the two
// 3. (Optional) Remove from shared communities
// Blocking is NOT symmetric — only affects the blocker's view
```

### 20.2 Report User/Message

```javascript
// /reports/{reportId}
{
  type: "message" | "user" | "community",
  targetId: string,              // messageId, userId, or communityId
  reporterId: string,
  reason: "spam" | "harassment" | "inappropriate_content" | "scam" | "other",
  additionalInfo: string | null,
  status: "pending" | "reviewed" | "actioned",
  createdAt: Timestamp,
}
```

### 20.3 Message Deletion Rules

| Action | Who Can | Effect |
|--------|---------|--------|
| Delete for me | Any participant | Adds userId to `deletedFor[]` — message hidden only for that user |
| Delete for everyone | Message sender only, within 1 hour | Sets `deletedForEveryone: true` — replaced with "This message was deleted" for all |
| Admin delete (community) | Community admin | Sets `deletedForEveryone: true` |

**E2EE + deletion time enforcement:** The 1-hour window is enforced by the Cloud Function using `createdAt` (server timestamp, trusted). The client passes `messageId` — the server reads the message's `createdAt` and rejects if `now - createdAt > 1 hour`. This is secure because `createdAt` is set server-side and the client cannot tamper with it.

**What "delete for everyone" does to E2EE messages:** The Cloud Function sets `deletedForEveryone: true`, `ciphertext: null`, and `e2ee: null` — effectively erasing the encrypted content. The message stub remains with "This message was deleted" as a system-generated plaintext indicator.

### 20.4 POPIA Compliance

```yaml
User Data Collected:
  - Name, email, phone (required for account)
  - Profile photo (optional)
  - Messages, media (encrypted at rest by Firestore)
  - Token transaction history
  - Community membership
  - Device tokens (for notifications)

User Rights:
  - Access their data (export functionality)
  - Delete their data (account deletion)
  - Control sharing (privacy settings)
  - Opt out of notifications

Data Retention:
  - Active accounts: Indefinite
  - Deleted accounts: 30 days then purged
  - Messages in deleted conversations: 90 days
  - Analytics data: Anonymized, 24 months

Account Deletion:
  1. Anonymize user's messages (senderName → "Deleted User")
  2. Remove from all communities
  3. Refund pending gifts
  4. Cancel pending transactions
  5. Soft-delete user doc (status: "deleted")
  6. Schedule permanent deletion after 30 days
```

---

## 21. Media Handling

### 21.1 Image Processing Pipeline

```
User selects image → Compress (max 1920px, 85% quality JPEG)
                   → Generate thumbnail (150px square, 80% quality)
                   → Generate random AES-256-GCM media key + thumb key
                   → Encrypt full image with media key → encrypted blob
                   → Encrypt thumbnail with thumb key → encrypted blob
                   → Upload encrypted blobs to Cloud Storage (NOT readable on server)
                   → Embed media key + thumb key inside the message ciphertext
                   → Send E2EE message via Cloud Function
```

Storage paths (encrypted blobs — `.enc` extension):
```
/conversations/{id}/images/{messageId}_full.enc
/conversations/{id}/images/{messageId}_thumb.enc
/communities/{id}/images/{messageId}_full.enc
/communities/{id}/images/{messageId}_thumb.enc
```

### 21.2 Voice Message Pipeline

```
User presses & holds → Record (AAC/M4A codec via flutter_sound)
                     → Generate random AES-256-GCM media key
                     → Encrypt audio file with media key → encrypted blob
                     → Upload encrypted blob to Cloud Storage
                     → Embed media key inside the message ciphertext
                     → Send E2EE message via Cloud Function
```

Storage paths (encrypted blobs):
```
/conversations/{id}/voice/{messageId}.enc
/communities/{id}/voice/{messageId}.enc
```

### 21.3 Media Upload Datasource

```dart
// lib/data/datasources/remote/media_upload_datasource.dart
@injectable
class MediaUploadDatasource {
  Future<MediaUploadResult> uploadImage({
    required File imageFile,
    required String parentCollection,  // "conversations" or "communities"
    required String parentId,
    required String messageId,
  }) async { ... }

  Future<MediaUploadResult> uploadVoice({
    required File voiceFile,
    required String parentCollection,
    required String parentId,
    required String messageId,
  }) async { ... }
}

class MediaUploadResult {
  final String url;
  final String? thumbnailUrl;
  final String fileName;
  final int fileSize;
  final String mimeType;
  final int? duration;
  final int? width;
  final int? height;
}
```

### 21.4 Cloud Storage Security Rules

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Conversation media — only participants can read
    match /conversations/{convId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if false;  // Uploads via Cloud Functions
    }
    // Community media — only members can read
    match /communities/{commId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if false;  // Uploads via Cloud Functions
    }
  }
}
```

---

## 22. Performance Optimization

### 22.1 Message Pagination

- Initial load: 50 messages (most recent)
- Load more: cursor-based pagination using `startAfterDocument`
- Real-time: Firestore snapshot listener on latest 50 messages
- Older messages: one-shot queries on scroll-up

### 22.2 Image Caching

- Use `cached_network_image` package for all message/avatar images
- `memCacheWidth`/`memCacheHeight` set to display size to reduce memory
- Thumbnails loaded first in message list, full image on tap

### 22.3 Firestore Query Optimization

- Compound indexes (Section 3.8) for all list queries
- `array-contains` on `participantIds`/`memberIds` for membership checks
- `lastMessageAt` descending sort for inbox ordering
- Denormalized `lastMessage` on parent docs avoids subcollection reads for list display
- Per-user maps (`unreadCounts`, `muted`, `pinned`) avoid extra subcollection reads

### 22.4 Offline Support

- Firestore's built-in offline persistence handles message caching
- Optimistic UI: messages appear instantly in list with "sending" status
- Failed messages show retry button
- Conversation/community list available offline from cache

---

## 23. Analytics & Tracking

```dart
// lib/core/services/chat_analytics_service.dart
@injectable
class ChatAnalyticsService {
  final FirebaseAnalytics _analytics;

  Future<void> trackMessageSent({required MessageType type, required bool isConversation}) async {
    await _analytics.logEvent(name: 'message_sent', parameters: {
      'type': type.name, 'is_conversation': isConversation,
    });
  }

  Future<void> trackGiftSent({required int amount, required GiftStyle style}) async {
    await _analytics.logEvent(name: 'gift_sent', parameters: {
      'amount': amount, 'style': style.name,
    });
  }

  Future<void> trackSprayCreated({required SprayOccasion occasion}) async {
    await _analytics.logEvent(name: 'spray_created', parameters: {
      'occasion': occasion.name,
    });
  }

  Future<void> trackCommunityCreated({required CommunityType type}) async {
    await _analytics.logEvent(name: 'community_created', parameters: {
      'type': type.name,
    });
  }
}
```

---

## 24. Testing Strategy

### 24.1 Unit Tests

| Test File | Covers |
|-----------|--------|
| `conversation_bloc_test.dart` | All ConversationBloc events/states |
| `community_bloc_test.dart` | All CommunityBloc events/states |
| `community_messaging_bloc_test.dart` | CommunityMessagingBloc events/states |
| `gift_bloc_test.dart` | GiftBloc send/open/claim lifecycle |
| `token_spray_bloc_test.dart` | TokenSprayBloc create/contribute/close |
| `conversation_repository_test.dart` | Repository methods with mocked datasource |
| `community_repository_test.dart` | Repository methods with mocked datasource |
| `gift_repository_test.dart` | Gift lifecycle |
| `token_spray_repository_test.dart` | Spray lifecycle |

### 24.2 Widget Tests

| Test File | Covers |
|-----------|--------|
| `message_bubble_test.dart` | Text, image, voice, token message rendering |
| `gift_bubble_test.dart` | Gift card rendering, tap-to-open interaction |
| `spray_bubble_test.dart` | Spray card, progress bar, contribute button |
| `conversation_list_tile_test.dart` | Unread badge, avatar, last message preview |
| `community_list_tile_test.dart` | Group icon overlay, member count |

### 24.3 Cloud Functions Tests (Jest)

| Test File | Covers |
|-----------|--------|
| `conversations.test.ts` | getOrCreate, sendMessage, token ops, markRead |
| `communities.test.ts` | CRUD, membership, financial, messaging, stokvel |
| `gifts.test.ts` | Send, open, claim, expiry, refund |
| `tokenSprays.test.ts` | Create, contribute, close, auto-expire |

### 24.4 Integration Tests

```dart
// Scenario 1: P2P messaging flow
// Login → open chat → send text → send image → send tokens → accept request

// Scenario 2: Community flow
// Create community → invite member → send message → react → reply → leave

// Scenario 3: Stokvel flow
// Create stokvel → contribute → withdraw → approve → trigger payout

// Scenario 4: Gift flow
// Open conversation → compose gift → select style → send → recipient opens → claim

// Scenario 5: Token Spray flow
// Open community → create spray → 3 members contribute → spray closes → recipient claims
```

---

## 25. Complete Implementation Timeline (All Phases — 14 Weeks)

### Phase 1: Core Chat + E2EE Foundation (Weeks 1-4)

| Week | Deliverable |
|------|-------------|
| 1 | Domain layer (entities, enums, repos, E2EE types) + CryptoService + KeyManagementService + SignalProtocolService + SenderKeyService |
| 2 | Conversation data layer (models, datasource, repo impl) + `keyManagement.ts` Cloud Function + key bundle upload at registration |
| 3 | `conversations.ts` Cloud Functions (ciphertext-aware) + Firestore indexes + security rules + Jest tests + E2EE encrypt/decrypt integration tests |
| 4 | Community data layer + `communities.ts` + `communityHelpers.ts` + Sender Key distribution |

**Milestone:** P2P messaging + communities backend working, E2EE crypto layer verified

### Phase 2: Communities + UI + Key Backup (Weeks 5-8)

| Week | Deliverable |
|------|-------------|
| 5 | 3 BLoCs (with encrypt-on-send / decrypt-on-receive) + DI wiring + router updates |
| 6 | All 9 screens + 7 widgets + unified inbox (decrypted previews) |
| 7 | Encrypted media upload/download (images/voice) + KeyBackupService (Google Drive) |
| 8 | FCM notification triggers (type-based, no content) + unread badges + deprecate old files |

**Milestone:** Full E2EE messaging + communities UI working, key backup operational

### Phase 3: Gifts & Celebrations (Weeks 9-11)

| Week | Deliverable |
|------|-------------|
| 9 | Gift entities/models/repos + `gifts.ts` Cloud Functions + GiftBloc + gift composer/opening screens (encrypted gift messages) |
| 10 | Token Spray entities/models/repos + `tokenSprays.ts` Cloud Functions + TokenSprayBloc + spray screens (encrypted celebration messages) |
| 11 | Gift style animations + spray leaderboard polish + gift/spray notification triggers + scheduled expiry jobs |

**Milestone:** Complete gifting + celebration system with E2EE

### Phase 4: Polish & Launch (Weeks 12-14)

| Week | Deliverable |
|------|-------------|
| 12 | Share service + deep link handling + QR code generation/scanning + community invite links |
| 13 | Full test suite (unit, widget, Cloud Functions, E2EE integration) + bug fixes + performance tuning + security audit |
| 14 | POPIA compliance review + beta testing + documentation + app store prep + marketing assets |

**Milestone:** Production-ready unified chat system with end-to-end encryption

---

## 26. Complete File Inventory (All Phases)

### New Flutter Files (105 total)

**Domain (30):**
- 14 enums: conversation_type, community_type, message_type, message_status, member_role, member_status, transaction_type, transaction_status, approval_status, community_status, gift_style, gift_status, spray_occasion, spray_status
- 12 entities + params: conversation, message (includes `MediaDecryptionInfo`), community, community_member, community_transaction, community_approval, gift, token_spray, e2ee_types, create_community_params, update_community_params, encrypted_media_upload_result
- 4 repository interfaces: conversation_repository, community_repository, gift_repository, token_spray_repository

**Data (24):**
- 8 models + 6 sub-models: conversation_model (+ participant_info_model), message_model (+ message_media_model, message_reply_model, e2ee_metadata_model, x3dh_header_model, gift_message_data_model, token_spray_message_data_model), community_model, community_member_model, community_transaction_model, community_approval_model, gift_model, token_spray_model (+ spray_contribution_model, spray_top_contributor_model)
- 5 datasources (abstract + impl): conversation_remote_datasource, community_remote_datasource, gift_remote_datasource, token_spray_remote_datasource, media_upload_datasource
- 4 repository impls: conversation_repository_impl, community_repository_impl, gift_repository_impl, token_spray_repository_impl

**BLoC (15):**
- 5 BLoCs x 3 files: ConversationBloc, CommunityBloc, CommunityMessagingBloc, GiftBloc, TokenSprayBloc

**Screens (16):**
- Phase 1-2: messaging_screen, conversation_detail, community_detail, create_community, community_settings, community_members, invite_member, community_transaction, pending_approvals
- Phase 3: gift_composer, gift_opening (modal), gift_history, spray_create, spray_detail (modal)
- Phase 4: qr_scanner, key_backup_prompt (interstitial after registration)

**Widgets (13):**
- Phase 1-2: message_bubble, message_input_bar, conversation_list_tile, community_list_tile, reaction_picker, message_reactions_bar, media_picker_widget
- Phase 3: gift_bubble, gift_style_picker, spray_bubble, spray_leaderboard, spray_countdown, spray_contribute_sheet

**E2EE Services (5):**
- crypto_service, key_management_service, key_backup_service, signal_protocol_service, sender_key_service

**Other Services (4):**
- chat_analytics_service, share_service, deep_link_service, notification_service

### New Cloud Function Files (9 total)

| File | Lines | Phase | Notes |
|------|-------|-------|-------|
| `functions/src/conversations.ts` | ~700 | 1 | Includes `generateSignedUploadUrl` (Section 32.1) |
| `functions/src/communities.ts` | ~1900 | 1 | Includes `generateSignedUploadUrl` for community media |
| `functions/src/helpers/communityHelpers.ts` | ~200 | 1 | |
| `functions/src/keyManagement.ts` | ~350 | 1 | Includes `uploadKeyBundle`, `fetchKeyBundle`, `consumeOneTimePreKey` (Section 32.8) |
| `functions/src/messagingNotifications.ts` | ~300 | 2 | Includes `onKeyBundleUpdated` trigger (Section 32.9.3) |
| `functions/src/gifts.ts` | ~500 | 3 | |
| `functions/src/tokenSprays.ts` | ~600 | 3 | |
| `functions/src/giftNotifications.ts` | ~150 | 3 | |
| `functions/src/ledger/giftAccounts.ts` | ~150 | 3 | |

### Files to Modify (12)

- `lib/presentation/router/app_router.dart` — replace Chat tab routes, remove `/groups`, add gift/spray/QR routes, add `/groups/:id` → `/chat/community/:id` redirect guard (see Section 31.1)
- `lib/app.dart` — replace ChatBloc with ConversationBloc + CommunityBloc + GiftBloc, add E2EE service initialization (see Section 30.3)
- `lib/presentation/blocs/auth/auth_bloc.dart` — add key generation step after successful registration, key backup prompt navigation (see Section 32.8)
- `lib/presentation/widgets/common/bottom_nav_bar.dart` — unified unread badge combining conversation + community counts (see Section 30.4)
- `lib/core/di/register_module.dart` — add third-party registrations for FlutterSecureStorage, FirebaseStorage (see Section 30.2)
- `functions/src/index.ts` — add exports for all 9 new Cloud Function files (see Section 31.2)
- `functions/src/ledger/index.ts` — add optional `overrideIdempotencyKey` param to `processP2PTransfer()`, add re-exports for gift/spray ledger functions (see Sections 31.5, 33.2)
- `functions/src/ledger/types.ts` — add GIFT_ESCROW/SPRAY_ESCROW to SystemAccounts, 6 JournalType entries, 2 referenceType entries, 6 IdempotencyKey helpers (see Section 33.1)
- `functions/src/ledger/accounts.ts` — add GIFT_ESCROW + SPRAY_ESCROW to `initializeSystemAccounts()` (see Section 33.8)
- `firestore.rules` — add rules for `conversations`, `communities`, `gifts`, `tokenSprays`, `users/{id}/keys`, `idempotencyKeys`, `reports` (see Section 31.3)
- `storage.rules` — add rules for encrypted media blobs in `conversations/` and `communities/` paths (see Section 31.4)
- `functions/src/wallet.ts` — no changes needed, but verify `validateMainWalletBalance()` is exported (used by `giftAccounts.ts`)

### Existing Code Reused (Not Modified)

| File | Reuse |
|------|-------|
| `functions/src/ledger/groupAccounts.ts` | All financial functions as-is |
| `functions/src/ledger/index.ts` | `processP2PTransfer` for token ops + gift/spray debits/credits |
| `lib/domain/entities/stokvel_analytics.dart` | StokvelAnalytics entity |
| `lib/domain/value_objects/token_amount.dart` | TokenAmount value object |
| `lib/core/services/play_integrity_service.dart` | Play Integrity validation |

### Files to Deprecate (16+)

All existing `chat_*` and `group_*` files across domain/data/presentation layers. Left compilable, removed in follow-up cleanup PR.

---

## 27. Full Verification Checklist

### Per-Phase Build Checks
- [ ] `dart run build_runner build --delete-conflicting-outputs` succeeds
- [ ] `flutter analyze --fatal-infos` passes
- [ ] `cd functions && npm run build` compiles
- [ ] `cd functions && npm test` passes

### E2EE Crypto Layer (Phase 1)
- [ ] Key generation: Identity Key, Signed Pre-Key, 100 One-Time Pre-Keys generate correctly
- [ ] Key bundle upload to Firestore via `uploadKeyBundle` Cloud Function
- [ ] Key bundle fetch + atomic One-Time Pre-Key consumption via `fetchKeyBundle`
- [ ] One-Time Pre-Key replenishment when count drops below 20
- [ ] Signed Pre-Key rotation (monthly)
- [ ] X3DH key agreement: both parties derive matching shared secret
- [ ] Double Ratchet: encrypt → decrypt round-trip for sequential messages
- [ ] Double Ratchet: out-of-order message delivery decrypts correctly
- [ ] Double Ratchet: DH ratchet step advances on reply (post-compromise recovery)
- [ ] Sender Key: generate → distribute via P2P sessions → encrypt → all members decrypt
- [ ] Sender Key re-key on member leave: departed member cannot decrypt new messages
- [ ] New member join: receives existing Sender Keys, distributes their own
- [ ] AES-256-GCM media encryption: image encrypt → decrypt round-trip
- [ ] AES-256-GCM media encryption: voice message encrypt → decrypt round-trip
- [ ] Per-user encrypted inbox preview: each participant decrypts their own preview
- [ ] System messages stored as plaintext (no encryption applied)
- [ ] Financial metadata (amounts, tx IDs, ledger refs) stored unencrypted
- [ ] Reactions stored unencrypted
- [ ] Key backup: create backup with passphrase → upload to Google Drive
- [ ] Key backup: restore on fresh device → decrypt old messages
- [ ] Key backup: wrong passphrase fails gracefully with clear error
- [ ] Key backup: auto-backup runs silently every 24h after initial setup
- [ ] No backup scenario: old messages show "[Cannot decrypt]", new messages work normally

### Phase 1-2: Messaging & Communities
- [ ] Create P2P conversation → send text (E2EE) → verify Firestore stores ciphertext only → recipient decrypts
- [ ] Send image (encrypted blob in Storage) → verify blob is not readable → recipient decrypts + displays
- [ ] Send voice message (encrypted) → recipient decrypts + plays
- [ ] Send tokens → amount unencrypted in Firestore → personal message encrypted
- [ ] Accept/decline token request works with E2EE
- [ ] Create regular community → invite member → Sender Keys distributed → send messages → react → reply
- [ ] Create stokvel community → contribute → withdraw → approve → trigger payout
- [ ] Push notifications arrive with type-based preview (NOT message content)
- [ ] Encrypted media upload + decrypted display works (images, voice)
- [ ] Reactions work (add, remove, display — unencrypted)
- [ ] Unread badges update on Chat tab
- [ ] Inbox preview shows decrypted text for each user
- [ ] Navigation: all routes work, deep links resolve correctly
- [ ] Back navigation: no orphaned screens

### Phase 3: Gifts & Token Spray
- [ ] Send gift in conversation → encrypted personal message → recipient opens → claim → tokens arrive
- [ ] Send gift in community to specific member → same lifecycle
- [ ] Gift expires after 7 days → sender refunded
- [ ] Gift expiry reminder sent 2 days before
- [ ] Create token spray in community → encrypted celebration message → members contribute → leaderboard updates live
- [ ] Token spray auto-closes after 24h → recipient receives tokens
- [ ] Token spray manual close by creator → same result
- [ ] Top contributor notification sent on close
- [ ] Gift/spray messages render correctly in message lists (decrypt embedded data)

### Data Layer & DI (Every Phase)
- [ ] All new BLoCs are registered with `@injectable` and appear in `injection.config.dart` after `build_runner`
- [ ] All repository impls are registered with `@LazySingleton(as: RepositoryInterface)`
- [ ] All datasources are registered with `@LazySingleton(as: DataSourceInterface)`
- [ ] All models have `fromJson`/`toJson`, `fromFirestore`, `toEntity`/`fromEntity`
- [ ] All DateTime fields use `@TimestampConverter()` / `@NullableTimestampConverter()`
- [ ] `build_runner` regenerates all `.config`, `.freezed`, `.g` files without errors
- [ ] Firestore rules compile without syntax errors (`firebase deploy --only firestore:rules --dry-run`)
- [ ] Storage rules cover all new media paths
- [ ] Cloud Function exports include all new functions (verify `npm run build` compiles)
- [ ] Route disambiguation works (conversation vs community IDs are different Firestore doc IDs)
- [ ] Bottom nav shows combined unread counts from ConversationBloc + CommunityBloc
- [ ] E2EE key initialization completes before first message send attempt
- [ ] Old `/groups` deep links redirect to `/chat/community/:id`
- [ ] Old `chatThreads` and `groups` Firestore collections are NOT queried by new code
- [ ] Legacy redirect guards prevent 404s for old route paths

### Phase 4: Polish & Launch
- [ ] Share achievement generates correct deep link
- [ ] Community invite link opens join flow
- [ ] QR code scan starts conversation / joins community
- [ ] All notification types route to correct screen on tap
- [ ] Quiet hours respected
- [ ] Block user hides conversations, prevents new messages
- [ ] Unblock user restores conversation visibility
- [ ] Report user/message creates pending report
- [ ] Delete for me hides message only for user
- [ ] Delete for everyone replaces message text for all (within 1 hour)
- [ ] Offline: cached messages display, pending messages queue
- [ ] Performance: inbox loads under 2s, message list scrolls smoothly
- [ ] POPIA: account deletion anonymizes messages, refunds gifts, removes from communities
- [ ] E2EE security audit: verify server never stores plaintext, keys never leave device (except backup)
- [ ] Suspended community: messaging blocked, financials blocked, reads allowed
- [ ] Expired approval auto-rejection: scheduled job runs hourly and transitions stale approvals

### E2EE Data Flow Integration (Section 32)
- [ ] Media upload: `generateSignedUploadUrl` validates membership before issuing signed URL
- [ ] Media upload: client encrypts blob locally with random AES-256-GCM key before upload
- [ ] Media upload: encrypted blob upload via HTTP PUT to signed URL succeeds
- [ ] Media keys embedded in message ciphertext JSON (`mediaKey`, `thumbKey`, nonces) — NOT stored on server
- [ ] Media receive: repository decrypts ciphertext → extracts mediaKey → `MediaDecryptionInfo` on entity → widget decrypts blob
- [ ] Gift in P2P: personal message encrypted with P2P Signal session (only sender+recipient see it)
- [ ] Gift in community: personal message encrypted with Sender Key (all members see it — public celebration)
- [ ] Spray in community: celebration message encrypted with Sender Key
- [ ] Preview key derivation: HKDF-SHA256 with domain separation (`imali-preview-v1` / `imali-community-preview-v1`)
- [ ] Community preview optimization: one encrypted preview duplicated per member in `encryptedPreviews` map
- [ ] ConversationModel `toEntity(decryptedPreview:)` — repo decrypts preview for current user
- [ ] CommunityModel same pattern for community inbox preview decryption
- [ ] Optimistic UI: BLoC creates temporary message with `status: sending` + plaintext, repo handles encryption async
- [ ] Optimistic UI: on Cloud Function error, message status changes to `failed` with retry button
- [ ] Optimistic UI: on success, Firestore listener replaces optimistic message with server-confirmed message
- [ ] Registration: key generation runs after Firebase Auth registration, before home navigation
- [ ] Registration: key bundle upload failure rolls back both Auth + Firestore user doc
- [ ] Key backup prompt: shown as interstitial after successful registration, dismissible with "Remind me later"
- [ ] Key backup prompt: re-prompts via Settings badge after 7 days if not set up
- [ ] Lock icon: small green lock in AppBar of ConversationDetail and CommunityDetail screens
- [ ] `[Cannot decrypt]` fallback: grey box with lock icon + "Restore backup" hint, no retry mechanism
- [ ] "Security keys changed": system message in conversation when contact's identity key changes
- [ ] "Security keys changed": `onKeyBundleUpdated` Firestore trigger writes system message
- [ ] Community member without Sender Key: shows "Waiting for encryption key..." with auto-retry on key arrival
- [ ] `auth_bloc.dart` modified: key generation step + KeyBackupPromptScreen navigation after registration

### Ledger Integration (Section 33)
- [ ] `GIFT_ESCROW` and `SPRAY_ESCROW` system accounts created in `initializeSystemAccounts()`
- [ ] 6 new JournalType entries added to `ledger/types.ts` (gift_debit, gift_credit, gift_refund, spray_contribution, spray_payout, conversation_transfer)
- [ ] 2 new referenceType entries: "gift", "token_spray"
- [ ] 6 IdempotencyKey helpers added (giftDebit, giftCredit, giftRefund, sprayContribution, sprayContributionN, sprayPayout)
- [ ] `processP2PTransfer()` accepts optional `overrideIdempotencyKey` param
- [ ] `processGiftDebit()` calls `validateMainWalletBalance()` (checks available, not raw balance)
- [ ] `processSprayContributionDebit()` calls `validateMainWalletBalance()`
- [ ] Gift/spray debit functions use `db.runTransaction()` for atomicity
- [ ] Gift/spray debit functions support idempotency via `IdempotencyKey.giftDebit(giftId)` / `sprayContribution()`
- [ ] All 5 gift/spray ledger functions follow double-entry pattern (equal debits and credits)
- [ ] Gifts and sprays do NOT apply 90/5/5 pot split (user receives 100%)
- [ ] `getOrCreateGroupAccount(communityId)` works as-is — comment added in `communities.ts`
- [ ] Stokvel payouts credit main wallet only (no sub-account routing)
- [ ] Account deletion atomically handles pending gifts (refund) + active sprays (close+payout)
- [ ] Account deletion race-safe: sets gift/spray status before ledger ops, scheduled jobs skip already-handled items
- [ ] `validateMainWalletBalance()` is exported from wallet.ts for use in `giftAccounts.ts`

---

## 28. Edge Cases & Race Conditions — Mitigation Strategy

Every Cloud Function that performs financial operations or state transitions must handle the edge cases below. This section documents each known edge case and the required mitigation.

### 28.1 Key Management Edge Cases

| # | Edge Case | Mitigation |
|---|-----------|-----------|
| 1 | **Key bundle upload fails mid-registration** | Registration is not complete until key bundle upload succeeds. Client retries upload up to 3 times with exponential backoff. If all retries fail, registration is rolled back and user is prompted to retry. The `uploadKeyBundle` Cloud Function is idempotent (re-upload overwrites). |
| 2 | **OTK consumed by 2 concurrent X3DH sessions** | `fetchKeyBundle` uses a Firestore transaction to atomically read + remove one OTK. Two concurrent calls will serialize — the second gets a different OTK (or none if depleted). X3DH works without an OTK (DH4 is skipped), so session establishment still succeeds. |
| 3 | **Sender Key distribution partial failure** | When distributing Sender Keys to N members, track distribution status per member. Failed distributions are retried on next app launch. Members without the Sender Key see "[Encrypted — key not yet received]" and the message is queued for local decryption when the key arrives. |
| 4 | **Key backup restore fails (wrong passphrase)** | PBKDF2 derivation produces a wrong key → AES-GCM decryption fails with authentication error. Client shows clear error "Wrong passphrase" and allows retry. After 5 failures, add a 30-second cooldown. Backup blob remains intact on Google Drive. |
| 5 | **Key backup restore fails (corrupted backup)** | AES-GCM authentication tag check fails even with correct passphrase. Client falls back to fresh key generation path (Section 12.8 "Without backup"). User is warned that old messages won't be decryptable. |
| 6 | **Sender Key re-key during bulk message send** | Use the Sender Key version that was current when encryption started. The `senderKeyChainId` in `e2ee` metadata tells the recipient which version to use for decryption. Old Sender Keys are kept locally for a grace period (7 days) to handle in-flight messages. |
| 7 | **Key rotation while user is offline** | Signed Pre-Key rotation is client-initiated (not server-pushed). When the user comes online, the client checks if rotation is overdue and performs it. Other users' sessions with the old Signed Pre-Key continue to work — the Double Ratchet doesn't depend on the Signed Pre-Key after initial X3DH. |
| 8 | **Backup restore on new device while old device still active** | Single-device enforcement (Play Integrity + device binding) means the old device is deactivated when the new one registers. There is no split-brain scenario — only one device is active at a time. |

### 28.2 Financial Race Conditions

| # | Edge Case | Mitigation |
|---|-----------|-----------|
| 9 | **Gift claimed at exact expiry moment** | `claimGift` and `expireGifts` both run inside Firestore transactions that check `status` and `expiresAt`. Only ONE can succeed — the transaction that reads `status == 'opened'` first wins. The other gets a transaction conflict and retries, but finds the status already changed, and returns an appropriate error. |
| 10 | **Token spray contribution during close** | `contributeToSpray` and `closeTokenSpray` both use Firestore transactions. The transaction that reads `status == 'active'` first proceeds. If `closeTokenSpray` wins, the contribution transaction retries, finds `status != 'active'`, and returns "Spray is not active". If contribution wins, close waits and includes the new contribution in the payout. |
| 11 | **Stokvel payout concurrent with withdrawal** | Both `triggerCommunityPayout` and `withdrawFromCommunity` use ledger transactions with balance checks. The ledger's `db.runTransaction()` ensures atomic read-check-write. If the balance is insufficient after the first operation, the second fails with "Insufficient balance". |
| 12 | **Double-tap on "Send Gift" / "Contribute"** | Client-side: disable button immediately on tap + show loading spinner. Server-side: idempotency key (UUID generated on the client before the call) prevents duplicate processing. The second call returns the cached result from the first. Idempotency keys expire after 24 hours. |
| 13 | **Insufficient balance check then debit not atomic** | All financial operations that check balance + debit run inside `db.runTransaction()` in the ledger layer. The balance read and journal entry write are in the same transaction — no window for concurrent debit. |
| 14 | **Gift/Spray status transitions skip states** | Cloud Functions validate the exact `from` state before transitioning. `claimGift` requires `status == 'opened'` (not just "not expired"). `openGift` requires `status == 'pending'` **AND** `expiresAt > now` (prevents opening already-expired gifts). Invalid transitions return `failed-precondition` error. State machine: `pending → opened → claimed` or `pending → expired` or `opened → expired`. No other paths. |

### 28.3 Messaging Race Conditions

| # | Edge Case | Mitigation |
|---|-----------|-----------|
| 15 | **Dual `getOrCreateConversation` calls create duplicates** | `getOrCreateConversation` runs inside a Firestore transaction: query for existing conversation with the same `participantIds` pair → if found, return it; if not, create one. The transaction serializes concurrent calls. Additionally, a unique Firestore compound constraint on sorted `participantIds` prevents duplicate writes. |
| 16 | **User removed from community mid-message-send** | `sendCommunityMessage` validates membership inside the batch/transaction. If the user was removed between the client's encrypt step and the server's write step, the Cloud Function returns `permission-denied`. The client shows "You are no longer a member" and removes the optimistic message. |
| 17 | **Community deleted while member sends message** | `sendCommunityMessage` calls `requireActiveCommunity()` which checks `status == 'active'`. Deleted communities have `status == 'closed'`. The function returns `failed-precondition`. |
| 18 | **Message reaction on deleted message** | `toggleMessageReaction` reads the message doc first. If `deletedForEveryone == true`, it returns `failed-precondition` ("Cannot react to deleted message"). If message doesn't exist, returns `not-found`. |
| 19 | **`markAsRead` concurrent with new message** | `markAsRead` sets `unreadCounts.{userId}` to `0` (absolute set). A concurrent `sendMessage` uses `FieldValue.increment(1)`. If `markAsRead` runs first, the increment brings count to 1 (correct — there's a new unread). If `sendMessage` runs first, `markAsRead` resets to 0 (user is reading, so all messages are seen — slightly incorrect if the new message arrived after the user's viewport, but acceptable UX). |
| 20 | **Conversation `archived` + new message arrives** | When a new message is sent to an archived conversation, the Cloud Function sets `archived.{recipientId}: false` (un-archives it). This ensures archived conversations resurface when new messages arrive. |

### 28.4 Membership Edge Cases

| # | Edge Case | Mitigation |
|---|-----------|-----------|
| 21 | **Invite accepted after community deleted** | `acceptCommunityInvitation` calls `requireActiveCommunity()` which checks the community `status`. Deleted communities return `failed-precondition`. The invitation is left in `invited` status (stale but harmless). |
| 22 | **Owner leaves community** | `leaveCommunity` checks if the user is the owner. If so, the function requires the owner to transfer ownership first (via `updateCommunityMemberRole` to promote another admin to owner). If the owner is the ONLY member, `leaveCommunity` deletes/closes the community instead. |
| 23 | **Block user after gift sent but before claimed** | Blocking does NOT cancel pending gifts. The gift lifecycle continues independently (claim/expire). Blocking only prevents new conversations and hides existing ones. This is intentional — the gift tokens are already in escrow and the recipient has a legitimate claim. |

### 28.5 Cloud Function Reliability

| # | Edge Case | Mitigation |
|---|-----------|-----------|
| 24 | **Partial write failure (message written, parent not updated)** | All message-sending functions use Firestore **batch writes** (Section 5.2) which are atomic — either all writes succeed or none do. If the batch fails, no data is written. The client retries the entire operation. |
| 25 | **Cloud Function timeout + automatic retry** | Cloud Functions may timeout (60s default) and be automatically retried by the client or infrastructure. All functions that perform side effects (ledger debits, document creation) use **idempotency keys** (Section 28.2 #12). Retried calls return the cached result without re-executing. |
| 26 | **`FieldValue.increment` on `unreadCounts` with concurrent messages** | `FieldValue.increment` is an atomic server-side operation — multiple concurrent increments are correctly serialized by Firestore. No data loss occurs even with high message throughput. |

### 28.6 Account Lifecycle Edge Cases

| # | Edge Case | Mitigation |
|---|-----------|-----------|
| 27 | **Account deletion with pending gifts** | The account deletion Cloud Function (Section 20.4) checks for pending/opened gifts where the user is the sender. For each: if `status == 'pending'` or `status == 'opened'`, refund the sender from `GIFT_ESCROW` → `user:{senderId}` before proceeding with deletion. For gifts where the user is the recipient, update status to `expired` (unclaimed gifts go back to sender). |
| 28 | **Account deletion mid-spray** | For sprays where the deleted user is a contributor: their contribution stays (already debited, tokens in `SPRAY_ESCROW`). For sprays where the deleted user is the recipient: `closeTokenSpray` is called immediately, crediting `SPRAY_ESCROW` → `user:{recipientId}` before the account is purged. For sprays where the deleted user is the creator: spray auto-closes (any admin or the scheduled job can close it). |

### 28.7 Idempotency Key Management

```javascript
// /idempotencyKeys/{key}
{
  result: any,                         // Cached function return value
  createdAt: Timestamp,
  expiresAt: Timestamp,                // Auto-delete after 24 hours
}

// Cleanup: Scheduled Cloud Function runs daily to delete expired idempotency keys
// TTL: Can also use Firestore TTL policy on the `expiresAt` field for automatic cleanup
```

**Client-side idempotency key generation:**
```dart
// Generate a UUID v4 before each financial operation
// Store it locally until the operation completes
// On retry (network error, timeout), reuse the SAME key
final idempotencyKey = const Uuid().v4();
```

### 28.8 Optimistic UI & Error Recovery

| Scenario | Optimistic Behavior | Error Recovery |
|----------|--------------------|----|
| Send text message | Message appears immediately with `status: sending` | On Cloud Function error: change to `status: failed`, show retry button |
| Send gift | Gift card appears in chat with "Sending..." overlay | On error: remove gift card, refund is automatic (gift was never created server-side), show toast |
| Contribute to spray | Contribution amount added to local total, button disabled | On error: revert local total, re-enable button, show error toast |
| Send tokens | Token send message appears with spinner | On error: change to `status: failed`, show "Retry" — idempotency key ensures no double-send |
| Accept token request | Request status changes to "Paying..." | On error: revert to "Accept"/"Decline" buttons, show error |

### 28.9 Additional Race Conditions (Review Round 2)

| # | Edge Case | Mitigation |
|---|-----------|-----------|
| 29 | **Multiple admins approving same transaction simultaneously** | `approveCommunityTransaction` runs inside a Firestore transaction. It reads the approval doc, checks if `userId` is already in `approvers[]` (returns `failed-precondition` "Already approved" if so), then atomically appends the userId and checks if `approvers.length >= requiredApprovals`. If threshold met, both the approval status AND the associated transaction status transition to `approved` → `completed` in the same transaction. |
| 30 | **Community deletion while spray is active** | `deleteCommunity` checks for active sprays in the community. For each active spray: calls `closeTokenSpray` to credit `SPRAY_ESCROW` → `user:{recipientId}` before proceeding with community deletion. This prevents orphaned escrow balances. |
| 31 | **`acceptConversationTokenRequest` without idempotency** | Added idempotency key parameter to `acceptConversationTokenRequest`. Client generates UUID before call. If the function already processed this key, it returns the cached result. This prevents double-payment on network retry. |
| 32 | **Concurrent community creation with identical name** | Community names are NOT required to be unique (same as group chats in WhatsApp). Two users can create "Book Club" — they're different communities with different IDs. No unique index needed. |
| 33 | **Approval expires while approver is clicking "Approve"** | Client-side: `ApproveButton` widget checks `!approval.isExpired` before rendering (disabled if expired). Server-side: `approveCommunityTransaction` validates `now <= expiresAt` inside the transaction. If expired, returns `failed-precondition` "Approval has expired". |
| 34 | **Expired approval auto-rejection** | New scheduled Cloud Function `expirePendingApprovals` runs hourly. Finds approvals where `status == 'pending'` AND `expiresAt < now`. Sets `status = 'expired'` on approval and `status = 'rejected'` on linked transaction (with `rejectionReason: 'Approval expired'`). |
| 35 | **`memberCount` desync with `memberIds` array** | All membership operations (invite, accept, remove, leave) update BOTH `memberIds` (via `FieldValue.arrayUnion`/`arrayRemove`) and `memberCount` (via `FieldValue.increment(1)`/`FieldValue.increment(-1)`) in the same batch/transaction. This ensures atomic consistency. |
| 36 | **Token request expiry status** | Token requests do NOT have a server-side `expired` status. Expiry is computed client-side via `isExpired` getter (`expiresAt != null && DateTime.now().isAfter(expiresAt!)`). `acceptConversationTokenRequest` validates `message.expiresAt > now` server-side before processing. This avoids the need for a scheduled expiry job on token requests. |

### 28.10 State Machine — Complete Diagrams

**Gift State Machine:**
```
                  ┌──────── expired (scheduled) ──────────┐
                  │                                        │
pending ──► opened ──► claimed                             │
   │                                                       │
   └──────── expired (scheduled) ──────────────────────────┘

Valid transitions only:
  pending → opened      (openGift: requires status==pending AND expiresAt > now)
  pending → expired     (expireGifts: scheduled, expiresAt < now)
  opened  → claimed     (claimGift: requires status==opened AND expiresAt > now)
  opened  → expired     (expireGifts: scheduled, expiresAt < now)
```

**Spray State Machine:**
```
active ──► closed ──► claimed
   │
   └──► closed (autoExpired: true) ──► claimed

Valid transitions only:
  active  → closed      (closeTokenSpray: creator/admin manual close)
  active  → closed      (closeExpiredSprays: scheduled, sets autoExpired=true flag)
  closed  → claimed     (claimTokenSpray: recipient claims accumulated tokens)

REMOVED "expired" status — previously ambiguous. Instead, auto-expiry sets
status to "closed" with an `autoExpired: boolean` flag on the spray doc.
This eliminates the orphan state and simplifies the state machine to 3 states.
SprayStatus enum: { active, closed, claimed }

Spray claim is a SEPARATE action from close — creator/scheduled job closes the spray
(stops new contributions), then recipient explicitly claims the tokens.
closeExpiredSprays scheduled job: finds active sprays where expiresAt < now,
  sets status='closed', autoExpired=true, closedAt=now.
  Does NOT auto-credit recipient — recipient must explicitly claim.
```

**Community Status State Machine:**
```
active ──► suspended ──► active (reactivated)
   │            │
   │            └──► closed
   └──────────────► closed

Valid transitions:
  active    → suspended  (suspendCommunity: superAdmin or platform-level action)
  active    → closed     (deleteCommunity: owner)
  suspended → active     (reactivateCommunity: superAdmin)
  suspended → closed     (deleteCommunity: superAdmin)

While suspended: messaging blocked, financial operations blocked,
membership reads allowed, stokvel scheduled jobs paused.
```

**Message Status State Machine:**
```
Client-only:
  sending ──► sent       (CF returns success)
  sending ──► failed     (CF returns error OR network timeout)
  failed  ──► sending    (retryMessage: user taps retry → re-encrypt + re-send with same idempotency key)

Server-managed (tokenRequest messages only):
  sent ──► paid          (acceptConversationTokenRequest: recipient accepts, ledger debit succeeds)
  sent ──► declined      (declineConversationTokenRequest: recipient declines)

Note: "sending" is client-only (never persisted to Firestore). On app restart,
any locally-cached "sending" messages with no matching server doc transition to "failed".
"paid" and "declined" are ONLY valid for tokenRequest messages — Cloud Functions
MUST validate `type == 'tokenRequest'` before allowing these transitions.
```

**CommunityMember Status State Machine:**
```
invited ──► active       (acceptCommunityInvitation: member accepts invite)
invited ──► [deleted]    (declineCommunityInvitation: member declines → member doc DELETED from subcollection)
active  ──► blocked      (blockCommunityMember: admin blocks disruptive member)
active  ──► [deleted]    (removeCommunityMember / leaveCommunity → member doc DELETED, userId removed from memberIds)
blocked ──► active       (unblockCommunityMember: admin unblocks → restores active status)
blocked ──► [deleted]    (removeCommunityMember: admin removes blocked member permanently)

Note: "blocked" members remain in memberIds (for security rule reads) but cannot send messages,
contribute, or participate in approvals. Unblocking restores full access.
Declining an invitation DELETES the member doc (not a status change) and does NOT add to memberIds.
```

**CommunityTransaction Status State Machine:**
```
pending ──► completed    (amount ≤ requireApprovalAbove: instant processing, ledger debit+credit in same CF)
pending ──► approved ──► completed  (amount > threshold: approval required → once approved, ledger processes)
pending ──► rejected     (rejectCommunityTransaction: admin/treasurer rejects)
pending ──► expired      (expirePendingApprovals: scheduled → linked transaction set to rejected)

Note: "pending" transactions above the threshold create a corresponding PendingApproval doc.
Below-threshold transactions skip approval and go directly pending → completed within the CF.
The ledger debit+credit happens at the completed transition (NOT at pending creation).
```

**Approval Status State Machine:**
```
pending ──► approved (threshold met)
   │
   ├──► rejected (admin rejects)
   │
   └──► expired  (expirePendingApprovals: scheduled hourly)
```

---

## 29. Data Layer — Models, Mappers, Datasources, Repository Implementations

The domain layer (entities, enums, repos) was defined in Sections 4-14. This section completes the **data layer** — the missing half of the Flutter clean architecture. Every entity needs a corresponding model for Firestore serialization, and every repository interface needs a concrete implementation.

### 29.1 Pattern Reference

All data layer classes follow the existing codebase pattern (e.g., `GroupRepositoryImpl`, `GroupRemoteDataSource`):

```dart
// Model pattern (data/models/)
@freezed
class FooModel with _$FooModel {
  const factory FooModel({...}) = _FooModel;
  factory FooModel.fromJson(Map<String, dynamic> json) => _$FooModelFromJson(json);
  factory FooModel.fromFirestore(DocumentSnapshot doc) =>
      FooModel.fromJson(doc.data()! as Map<String, dynamic>);
  factory FooModel.fromEntity(Foo entity) => FooModel(...); // Entity → Model
  const FooModel._();
  Foo toEntity() => Foo(...); // Model → Entity
}

// Repository impl pattern (data/repositories/)
@LazySingleton(as: FooRepository)
class FooRepositoryImpl implements FooRepository {
  final FooRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  FooRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Foo>> getFoo(String id) async {
    if (!await _networkInfo.isConnected) return const Left(Failure.network());
    try {
      final model = await _remoteDataSource.getFoo(id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    }
  }
}

// Datasource pattern (data/datasources/remote/)
abstract class FooRemoteDataSource {
  Future<FooModel> getFoo(String id);
}

@LazySingleton(as: FooRemoteDataSource)
class FooRemoteDataSourceImpl implements FooRemoteDataSource {
  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;
  FooRemoteDataSourceImpl(this._functions, this._firestore);

  @override
  Future<FooModel> getFoo(String id) async {
    final result = await _functions.httpsCallable('getFoo').call({'id': id});
    return FooModel.fromJson(result.data);
  }
}
```

### 29.2 Conversation Data Layer

**`lib/data/models/conversation_model.dart`:**
```dart
@freezed
class ConversationModel with _$ConversationModel {
  const factory ConversationModel({
    required String id,
    required String type,
    required List<String> participantIds,
    required Map<String, ParticipantInfoModel> participants,
    String? lastMessageText,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    @TimestampConverter() DateTime? lastMessageAt,
    required Map<String, int> unreadCounts,
    required Map<String, bool> archived,
    required Map<String, bool> pinned,
    required Map<String, bool> muted,
    @TimestampConverter() required DateTime createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
    // E2EE inbox preview (per-user encrypted)
    Map<String, String>? lastMessageEncryptedPreviews,
  }) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) => _$ConversationModelFromJson(json);
  factory ConversationModel.fromFirestore(DocumentSnapshot doc) =>
      ConversationModel.fromJson({'id': doc.id, ...doc.data()! as Map<String, dynamic>});
  factory ConversationModel.fromEntity(Conversation entity) => ConversationModel(
    id: entity.id,
    type: entity.type.name,
    participantIds: entity.participantIds,
    participants: entity.participants.map((k, v) => MapEntry(k, ParticipantInfoModel.fromEntity(v))),
    lastMessageText: entity.lastMessageText,
    lastMessageSenderId: entity.lastMessageSenderId,
    lastMessageSenderName: entity.lastMessageSenderName,
    lastMessageType: entity.lastMessageType,
    lastMessageAt: entity.lastMessageAt,
    unreadCounts: entity.unreadCounts,
    archived: entity.archived,
    pinned: entity.pinned,
    muted: entity.muted,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
  );

  const ConversationModel._();

  Conversation toEntity() => Conversation(
    id: id,
    type: ConversationType.values.byName(type),
    participantIds: participantIds,
    participants: participants.map((k, v) => MapEntry(k, v.toEntity())),
    lastMessageText: lastMessageText,
    lastMessageSenderId: lastMessageSenderId,
    lastMessageSenderName: lastMessageSenderName,
    lastMessageType: lastMessageType,
    lastMessageAt: lastMessageAt,
    unreadCounts: unreadCounts,
    archived: archived,
    pinned: pinned,
    muted: muted,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

@freezed
class ParticipantInfoModel with _$ParticipantInfoModel {
  const factory ParticipantInfoModel({
    required String displayName,
    String? avatarUrl,
  }) = _ParticipantInfoModel;

  factory ParticipantInfoModel.fromJson(Map<String, dynamic> json) => _$ParticipantInfoModelFromJson(json);
  factory ParticipantInfoModel.fromEntity(ParticipantInfo entity) =>
      ParticipantInfoModel(displayName: entity.displayName, avatarUrl: entity.avatarUrl);

  const ParticipantInfoModel._();
  ParticipantInfo toEntity() => ParticipantInfo(displayName: displayName, avatarUrl: avatarUrl);
}
```

**`lib/data/models/message_model.dart`:**
```dart
@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    String? conversationId,
    String? communityId,
    required String senderId,
    required String senderName,
    String? senderAvatarUrl,
    required String type,                    // MessageType.name
    required String status,                  // MessageStatus.name
    String? textContent,                     // Always null on server (E2EE)
    String? ciphertext,                      // E2EE ciphertext (base64)
    int? tokenAmount,
    String? recipientId,
    String? ledgerJournalId,
    MessageMediaModel? media,
    @Default({}) Map<String, List<String>> reactions,
    MessageReplyModel? replyTo,
    X3dhHeaderModel? x3dhHeader,
    E2eeMetadataModel? e2ee,
    GiftMessageDataModel? gift,
    TokenSprayMessageDataModel? tokenSpray,
    String? systemEventType,
    Map<String, dynamic>? metadata,
    @TimestampConverter() required DateTime createdAt,
    @NullableTimestampConverter() DateTime? expiresAt,
    @NullableTimestampConverter() DateTime? actionedAt,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default([]) List<String> deletedFor,
    @Default(false) bool deletedForEveryone,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
  factory MessageModel.fromFirestore(DocumentSnapshot doc) =>
      MessageModel.fromJson({'id': doc.id, ...doc.data()! as Map<String, dynamic>});

  const MessageModel._();

  /// Convert to entity. Note: textContent comes from client-side E2EE decryption,
  /// not from this model's textContent field (which is always null on server).
  Message toEntity({String? decryptedText}) => Message(
    id: id,
    conversationId: conversationId,
    communityId: communityId,
    senderId: senderId,
    senderName: senderName,
    senderAvatarUrl: senderAvatarUrl,
    type: MessageType.values.byName(type),
    status: MessageStatus.values.byName(status),
    textContent: decryptedText,    // Populated by repository after decryption
    tokenAmount: tokenAmount,
    recipientId: recipientId,
    ledgerJournalId: ledgerJournalId,
    media: media?.toEntity(),
    reactions: reactions,
    replyTo: replyTo?.toEntity(),
    x3dhHeader: x3dhHeader?.toEntity(),
    gift: gift?.toEntity(),
    tokenSpray: tokenSpray?.toEntity(),
    systemEventType: systemEventType,
    metadata: metadata,
    createdAt: createdAt,
    expiresAt: expiresAt,
    actionedAt: actionedAt,
    deletedAt: deletedAt,
    deletedFor: deletedFor,
    deletedForEveryone: deletedForEveryone,
  );
}

// Sub-models: MessageMediaModel, MessageReplyModel, E2eeMetadataModel,
// X3dhHeaderModel, GiftMessageDataModel, TokenSprayMessageDataModel
// follow the same @freezed + fromJson/toJson + toEntity/fromEntity pattern.
```

**Other models** (community_model, community_member_model, community_transaction_model, community_approval_model, gift_model, token_spray_model) follow identical patterns with their respective fields from Section 3 (Firestore schemas) and Section 4 (entities). Each includes:
- `@TimestampConverter()` / `@NullableTimestampConverter()` on DateTime fields
- `fromFirestore(DocumentSnapshot)` factory
- `toEntity()` method returning the domain entity
- `fromEntity()` factory for outbound conversion

### 29.3 Remote Datasources

**`lib/data/datasources/remote/conversation_remote_datasource.dart`:**
```dart
abstract class ConversationRemoteDataSource {
  Future<List<ConversationModel>> getConversations();
  Stream<List<ConversationModel>> watchConversations();
  Future<ConversationModel> getOrCreateConversation({required String participantId});
  Future<ConversationModel> getConversationById(String id);
  Future<List<MessageModel>> getMessages({required String conversationId, int? limit, DateTime? before});
  Stream<List<MessageModel>> watchMessages({required String conversationId, int? limit});
  Future<MessageModel> sendTextMessage({required String conversationId, required String ciphertext, required Map<String, dynamic> e2ee, Map<String, dynamic>? x3dhHeader, required Map<String, String> encryptedPreviews, String? replyToMessageId});
  Future<MessageModel> sendMediaMessage({required String conversationId, required String mediaUrl, required String mediaType, required String ciphertext, required Map<String, dynamic> e2ee, required Map<String, String> encryptedPreviews});
  Future<MessageModel> sendTokens({required String conversationId, required String recipientId, required int amount, String? ciphertext, Map<String, dynamic>? e2ee, Map<String, String>? encryptedPreviews, String? subAccountId, required String idempotencyKey});
  Future<MessageModel> requestTokens({required String conversationId, required String recipientId, required int amount, String? ciphertext, Map<String, dynamic>? e2ee, Map<String, String>? encryptedPreviews});
  Future<MessageModel> acceptTokenRequest({required String conversationId, required String messageId, required String idempotencyKey});
  Future<MessageModel> declineTokenRequest({required String conversationId, required String messageId});
  Future<void> markAsRead({required String conversationId});
  Future<void> togglePin({required String conversationId, required bool pinned});
  Future<void> toggleMute({required String conversationId, required bool muted});
  Future<void> archiveConversation(String conversationId);
  Future<void> addReaction({required String conversationId, required String messageId, required String emoji});
  Future<void> removeReaction({required String conversationId, required String messageId, required String emoji});
  Future<int> getTotalUnreadCount();
  Stream<int> watchTotalUnreadCount();
}
```

**`lib/data/datasources/remote/conversation_remote_datasource_impl.dart`:**

The implementation wraps Cloud Function calls (`FirebaseFunctions.httpsCallable`) and direct Firestore reads/streams:
- **Reads** (conversations list, messages list, unread count): Direct Firestore queries on `conversations` collection using `participantIds` array-contains filter. This avoids Cloud Function overhead for frequent reads.
- **Writes** (send message, send tokens, mark read, etc.): Cloud Function calls to `sendConversationMessage`, `sendConversationTokens`, etc.
- **Streams** (watchConversations, watchMessages): Firestore snapshot listeners on the relevant collections/subcollections.

**`lib/data/datasources/remote/community_remote_datasource.dart`** — same pattern, wrapping `communities.ts` Cloud Functions + direct Firestore reads on `communities` collection.

**`lib/data/datasources/remote/gift_remote_datasource.dart`** — wraps `gifts.ts` Cloud Functions + direct Firestore reads on `gifts` collection.

**`lib/data/datasources/remote/token_spray_remote_datasource.dart`** — wraps `tokenSprays.ts` Cloud Functions + Firestore reads.

### 29.4 Repository Implementations

**`lib/data/repositories/conversation_repository_impl.dart`:**
```dart
@LazySingleton(as: ConversationRepository)
class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final SignalProtocolService _signalService;  // E2EE encryption/decryption

  ConversationRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._signalService,
  );

  @override
  Future<Either<Failure, Message>> sendTextMessage({
    required String conversationId,
    required String text,
    String? replyToMessageId,
  }) async {
    if (!await _networkInfo.isConnected) return const Left(Failure.network());
    try {
      // 1. Encrypt plaintext via Signal Protocol (Double Ratchet)
      final recipientId = _getRecipientId(conversationId);
      final encrypted = await _signalService.encryptP2P(
        recipientId: recipientId,
        plaintext: text,
      );

      // 2. Generate per-user encrypted inbox previews
      final preview = text.length > 100 ? text.substring(0, 100) : text;
      final encryptedPreviews = await _signalService.encryptPreviewForParticipants(
        conversationId: conversationId,
        preview: preview,
      );

      // 3. Call datasource with ciphertext
      final model = await _remoteDataSource.sendTextMessage(
        conversationId: conversationId,
        ciphertext: encrypted.ciphertext,
        e2ee: encrypted.e2eeMetadata,
        x3dhHeader: encrypted.x3dhHeader,
        encryptedPreviews: encryptedPreviews,
        replyToMessageId: replyToMessageId,
      );

      // 4. Return entity with decrypted text (we already have it)
      return Right(model.toEntity(decryptedText: text));
    } on ServerException catch (e) {
      return Left(Failure.serverError(message: e.message));
    }
  }

  @override
  Stream<Either<Failure, List<Message>>> watchMessages({
    required String conversationId,
    int? limit,
  }) {
    return _remoteDataSource.watchMessages(conversationId: conversationId, limit: limit)
        .asyncMap((models) async {
      try {
        final messages = <Message>[];
        for (final model in models) {
          if (model.deletedForEveryone) {
            // Deleted message — no decryption needed
            messages.add(model.toEntity(decryptedText: null));
          } else if (model.ciphertext != null && model.e2ee != null) {
            // Decrypt E2EE message
            try {
              final plaintext = await _signalService.decryptP2P(
                senderId: model.senderId,
                ciphertext: model.ciphertext!,
                e2eeMetadata: model.e2ee!,
                x3dhHeader: model.x3dhHeader,
              );
              messages.add(model.toEntity(decryptedText: plaintext));
            } catch (_) {
              // Decryption failed (missing keys, corrupt data)
              messages.add(model.toEntity(decryptedText: '[Cannot decrypt]'));
            }
          } else {
            // System message (plaintext) or token message (no text content)
            messages.add(model.toEntity(decryptedText: model.textContent));
          }
        }
        return Right<Failure, List<Message>>(messages);
      } catch (e) {
        return Left<Failure, List<Message>>(Failure.serverError(message: e.toString()));
      }
    });
  }

  // Other methods follow same encrypt-on-send / decrypt-on-receive pattern
}
```

**`lib/data/repositories/community_repository_impl.dart`:**
Same pattern as `ConversationRepositoryImpl`, using `SenderKeyService` instead of `SignalProtocolService` for community message encryption/decryption. Uses `@LazySingleton(as: CommunityRepository)`.

**`lib/data/repositories/gift_repository_impl.dart`:**
Uses `@LazySingleton(as: GiftRepository)`. Gift financial metadata is unencrypted. Personal gift messages are encrypted as part of the associated chat message (handled by conversation/community repository).

**`lib/data/repositories/token_spray_repository_impl.dart`:**
Uses `@LazySingleton(as: TokenSprayRepository)`. Spray metadata (amounts, contributors) is unencrypted. Celebration messages are encrypted as part of community messages.

### 29.5 Timestamp Converters

Reuse existing converters from the codebase (`lib/core/utils/timestamp_converter.dart`):
```dart
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();
  @override DateTime fromJson(Timestamp timestamp) => timestamp.toDate();
  @override Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

class NullableTimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const NullableTimestampConverter();
  @override DateTime? fromJson(Timestamp? timestamp) => timestamp?.toDate();
  @override Timestamp? toJson(DateTime? date) => date != null ? Timestamp.fromDate(date) : null;
}
```

---

## 30. DI Registration & Service Initialization

### 30.1 New Injectable Classes

All new classes require `@injectable` or `@LazySingleton` annotations for GetIt registration via `build_runner`:

```dart
// === BLoCs (all @injectable — new instance per injection) ===
@injectable ConversationBloc
@injectable CommunityBloc
@injectable CommunityMessagingBloc
@injectable GiftBloc
@injectable TokenSprayBloc

// === Repository Implementations (all @LazySingleton) ===
@LazySingleton(as: ConversationRepository) ConversationRepositoryImpl
@LazySingleton(as: CommunityRepository)    CommunityRepositoryImpl
@LazySingleton(as: GiftRepository)         GiftRepositoryImpl
@LazySingleton(as: TokenSprayRepository)   TokenSprayRepositoryImpl

// === Remote Datasources (all @LazySingleton) ===
@LazySingleton(as: ConversationRemoteDataSource) ConversationRemoteDataSourceImpl
@LazySingleton(as: CommunityRemoteDataSource)    CommunityRemoteDataSourceImpl
@LazySingleton(as: GiftRemoteDataSource)         GiftRemoteDataSourceImpl
@LazySingleton(as: TokenSprayRemoteDataSource)    TokenSprayRemoteDataSourceImpl
@LazySingleton                                    MediaUploadDatasource

// === E2EE Services (all @LazySingleton) ===
@LazySingleton CryptoService
@LazySingleton KeyManagementService
@LazySingleton KeyBackupService
@LazySingleton SignalProtocolService
@LazySingleton SenderKeyService

// === Other Services (all @LazySingleton) ===
@LazySingleton ChatAnalyticsService
@LazySingleton ShareService
@LazySingleton DeepLinkService
@LazySingleton NotificationService
```

### 30.2 Third-Party Registrations (`core/di/register_module.dart`)

New bindings needed in the existing `RegisterModule`:
```dart
@module
abstract class RegisterModule {
  // ... existing registrations ...

  // E2EE: flutter_secure_storage for key material
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  // Firebase Functions (already registered — verify exists)
  @lazySingleton
  FirebaseFunctions get functions => FirebaseFunctions.instance;

  // Firebase Storage (for media upload)
  @lazySingleton
  FirebaseStorage get storage => FirebaseStorage.instance;
}
```

### 30.3 App-Level BLoC Providers (`lib/app.dart`)

**Current state (to replace):**
```dart
late final ChatBloc _chatBloc;
// ... in initState:
_chatBloc = getIt<ChatBloc>();
// ... in MultiBlocProvider:
BlocProvider<ChatBloc>.value(value: _chatBloc),
```

**New state:**
```dart
late final ConversationBloc _conversationBloc;
late final CommunityBloc _communityBloc;
late final GiftBloc _giftBloc;

@override
void initState() {
  super.initState();
  // ... existing init ...

  // Replace ChatBloc with new BLoCs
  _conversationBloc = getIt<ConversationBloc>();
  _communityBloc = getIt<CommunityBloc>();
  _giftBloc = getIt<GiftBloc>();

  // Initialize E2EE (fire-and-forget, like RaspService)
  _initializeE2EE();
}

Future<void> _initializeE2EE() async {
  try {
    final keyMgmt = getIt<KeyManagementService>();
    await keyMgmt.initialize().timeout(const Duration(seconds: 10));
  } catch (e) {
    debugPrint('E2EE init failed: $e');
    // Non-fatal — E2EE will retry on first message send
  }
}

// In MultiBlocProvider children:
BlocProvider<ConversationBloc>.value(value: _conversationBloc),
BlocProvider<CommunityBloc>.value(value: _communityBloc),
BlocProvider<GiftBloc>.value(value: _giftBloc),
// Note: CommunityMessagingBloc and TokenSprayBloc are SCOPED,
// provided locally in their respective screens, not app-level.
```

### 30.4 Bottom Nav Bar — Unified Unread Badge

**`lib/presentation/widgets/common/bottom_nav_bar.dart`:**

The Chat tab (index 1) needs a combined unread badge from both ConversationBloc and CommunityBloc:

```dart
// In the Chat tab badge:
BlocBuilder<ConversationBloc, ConversationState>(
  buildWhen: (prev, curr) => prev.totalUnreadCount != curr.totalUnreadCount,
  builder: (context, convState) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      buildWhen: (prev, curr) => prev.totalUnreadCount != curr.totalUnreadCount,
      builder: (context, commState) {
        final total = convState.totalUnreadCount + commState.totalUnreadCount;
        if (total == 0) return const SizedBox.shrink();
        return Badge(
          label: Text(total > 99 ? '99+' : '$total'),
          child: const Icon(Icons.chat_outlined),
        );
      },
    );
  },
)
```

CommunityBloc needs `totalUnreadCount` in its state (mirroring ConversationBloc):
```dart
// Added to CommunityState:
@Default(0) int totalUnreadCount,
```

### 30.5 E2EE Initialization Flow

```
App Launch
  └─► AuthBloc emits authenticated state
       └─► KeyManagementService.initialize()
            ├─► Check if identity key exists in flutter_secure_storage
            │    ├─ YES → Load existing keys, verify signed pre-key freshness
            │    │         ├─ Signed pre-key > 30 days → rotate + upload new bundle
            │    │         └─ OTK count < 20 → generate + upload more OTKs
            │    │
            │    └─ NO → First-time setup:
            │           1. Generate identity key pair
            │           2. Generate signed pre-key
            │           3. Generate 100 OTKs
            │           4. Upload key bundle via uploadKeyBundle Cloud Function
            │           5. Prompt user for key backup passphrase (optional, deferrable)
            │
            └─► On success: set state.e2eeReady = true
                On failure: retry on next app foreground, messages queued locally
```

---

## 31. Files to Modify — Detailed Specifications

This section expands on the brief list in Section 26 with exact modification details.

### 31.1 `lib/presentation/router/app_router.dart`

**Changes:**
1. **Remove imports** for old chat and group screens (lines 27-34, 103-107)
2. **Add imports** for new messaging, conversation, community, gift, spray screens
3. **Remove** standalone `/groups` GoRoute block (current lines ~315-370)
4. **Replace** `/chat` StatefulShellBranch (current line ~525) with unified routes:

```dart
// Chat tab (index 1 in StatefulShellRoute)
StatefulShellBranch(
  routes: [
    GoRoute(
      path: '/chat',
      builder: (context, state) => const MessagingScreen(),
      routes: [
        GoRoute(
          path: 'conversation/:conversationId',
          builder: (context, state) => ConversationDetailScreen(
            conversationId: state.pathParameters['conversationId']!,
          ),
          routes: [
            GoRoute(path: 'send-gift', builder: (context, state) => GiftComposerScreen(...)),
          ],
        ),
        GoRoute(
          path: 'community/:communityId',
          builder: (context, state) => CommunityDetailScreen(
            communityId: state.pathParameters['communityId']!,
          ),
          routes: [
            GoRoute(path: 'settings', builder: ...),
            GoRoute(path: 'members', builder: ...),
            GoRoute(path: 'invite', builder: ...),
            GoRoute(path: 'contribute', builder: ...),
            GoRoute(path: 'withdraw', builder: ...),
            GoRoute(path: 'approvals', builder: ...),
            GoRoute(path: 'send-gift', builder: ...),
            GoRoute(path: 'create-spray', builder: ...),
          ],
        ),
        GoRoute(path: 'create-community', builder: ...),
        GoRoute(path: 'send-wallet', builder: ...), // Existing
        GoRoute(path: 'send-amount', builder: ...), // Existing
      ],
    ),
  ],
),
```

5. **Add redirect guard** at top-level router for old `/groups` paths:
```dart
redirect: (context, state) {
  final location = state.matchedLocation;
  if (location.startsWith('/groups/')) {
    final id = state.pathParameters['id'];
    return '/chat/community/$id';
  }
  if (location == '/groups') return '/chat';
  return null;
},
```

### 31.2 `functions/src/index.ts` — New Exports

Add after existing exports (keeping old `chat.ts` and `groups.ts` exports for backward compat):

```typescript
// ============================================================
// Chat & Communities (unified system — replaces chat.ts + groups.ts)
// ============================================================
export * from './conversations';         // Phase 1
export * from './communities';           // Phase 1
export * from './keyManagement';         // Phase 1 (E2EE)
export * from './messagingNotifications'; // Phase 2
export * from './gifts';                 // Phase 3
export * from './tokenSprays';           // Phase 3
export * from './giftNotifications';     // Phase 3

// Note: helpers/communityHelpers.ts is NOT exported (internal utility)
```

### 31.3 `firestore.rules` — Complete New Rules

Add to existing rules (after current `groups` match block):

```javascript
// ============================================================
// Chat & Communities (new unified system)
// ============================================================

// Conversations — read if participant, all writes via Cloud Functions
match /conversations/{convId} {
  allow read: if isAuthenticated() && isParticipant(resource.data);
  allow write: if false;
  match /messages/{msgId} {
    allow read: if isAuthenticated() && isParticipant(get(/databases/$(database)/documents/conversations/$(convId)).data);
    allow write: if false;
  }
}

// Communities — read if member, all writes via Cloud Functions
match /communities/{commId} {
  allow read: if isAuthenticated() && isCommunityMember(resource.data);
  allow write: if false;
  match /messages/{msgId} {
    allow read: if isAuthenticated() && isCommunityMember(get(/databases/$(database)/documents/communities/$(commId)).data);
    allow write: if false;
  }
  match /members/{memberId} {
    allow read: if isAuthenticated() && isCommunityMember(get(/databases/$(database)/documents/communities/$(commId)).data);
    allow write: if false;
  }
  match /transactions/{txId} {
    allow read: if isAuthenticated() && isCommunityMember(get(/databases/$(database)/documents/communities/$(commId)).data);
    allow write: if false;
  }
  match /pendingApprovals/{approvalId} {
    allow read: if isAuthenticated() && isCommunityMember(get(/databases/$(database)/documents/communities/$(commId)).data);
    allow write: if false;
  }
}

// Gifts — read if sender or recipient
match /gifts/{giftId} {
  allow read: if isAuthenticated() && (resource.data.senderId == request.auth.uid || resource.data.recipientId == request.auth.uid);
  allow write: if false;
}

// Token Sprays — read if community member
match /tokenSprays/{sprayId} {
  allow read: if isAuthenticated() && isCommunityMember(get(/databases/$(database)/documents/communities/$(resource.data.communityId)).data);
  allow write: if false;
}

// E2EE Key Bundles — owner can read/write, others can read public keys
match /users/{userId}/keys/bundle {
  allow read: if isAuthenticated();  // Anyone can fetch public keys for X3DH
  allow write: if false;              // Writes via Cloud Function only
}
match /users/{userId}/keys/backup {
  allow read: if isAuthenticated() && request.auth.uid == userId;
  allow write: if false;              // Writes via Cloud Function only
}

// Idempotency keys — no client access
match /idempotencyKeys/{keyId} {
  allow read, write: if false;
}

// Reports — write-only for authenticated users, no read
match /reports/{reportId} {
  allow create: if isAuthenticated();
  allow read, update, delete: if false;
}

// Helper functions (add to existing helper block)
function isParticipant(data) {
  return request.auth.uid in data.participantIds;
}
function isCommunityMember(data) {
  return request.auth.uid in data.memberIds;
}
```

### 31.4 `storage.rules` — Encrypted Media Paths

Add to existing storage rules:

```javascript
// Encrypted conversation media
match /conversations/{convId}/images/{fileName} {
  allow read: if request.auth != null;
  allow write: if false;  // Uploads via Cloud Functions or signed URLs
}
match /conversations/{convId}/voice/{fileName} {
  allow read: if request.auth != null;
  allow write: if false;
}

// Encrypted community media
match /communities/{commId}/images/{fileName} {
  allow read: if request.auth != null;
  allow write: if false;
}
match /communities/{commId}/voice/{fileName} {
  allow read: if request.auth != null;
  allow write: if false;
}
```

### 31.5 `functions/src/ledger/index.ts` — New Exports

Add to existing re-exports:

```typescript
// Gift & Spray escrow functions (added in Phase 3)
export {
  processGiftDebit,
  processGiftCredit,
  processGiftRefund,
  processSprayContributionDebit,
  processSprayPayout,
} from "./giftAccounts";

// System account initialization (add GIFT_ESCROW + SPRAY_ESCROW)
// In initializeSystemAccounts(), add:
//   { id: 'GIFT_ESCROW', type: 'system', name: 'Gift Escrow' },
//   { id: 'SPRAY_ESCROW', type: 'system', name: 'Token Spray Escrow' },
```

New file: **`functions/src/ledger/giftAccounts.ts`** (~150 lines) — contains the 5 gift/spray ledger functions. Follows the same pattern as existing `groupAccounts.ts`.

### 31.6 Additional Cloud Functions (not in original list)

| Function | File | Purpose |
|----------|------|---------|
| `suspendCommunity` | `communities.ts` | Admin action to freeze community |
| `reactivateCommunity` | `communities.ts` | Admin action to unfreeze |
| `unblockUser` | `conversations.ts` | Remove userId from blockedUserIds array |
| `expirePendingApprovals` | `communities.ts` (scheduled) | Hourly: auto-expire approvals past expiresAt |

---

## 32. E2EE Data Flow — Detailed Integration Specifications

This section addresses the precise integration points where E2EE meets the data layer, presentation layer, and Cloud Functions — filling gaps identified in the protocol specification (Section 12) and the data layer pattern (Section 29).

### 32.1 Media Upload Mechanism — Signed URL Flow

**Problem:** Section 21.3 defines `MediaUploadDatasource` and Section 21.4 says `allow write: if false; // Uploads via Cloud Functions` — but no upload Cloud Function or signed URL generator is defined.

**Decision:** Use **Cloud Function–generated signed upload URLs**. The client encrypts locally, obtains a signed URL from a Cloud Function, uploads the encrypted blob directly to Cloud Storage via HTTP PUT, then sends the message via a second Cloud Function call.

**New Cloud Function in `conversations.ts`:**

```typescript
// Also duplicated in communities.ts for community media

export const generateSignedUploadUrl = functions.https.onCall(async (data, context) => {
  requireAuth(context);
  requireAppCheck(context);

  const { parentCollection, parentId, messageId, fileType } = data;
  // parentCollection: "conversations" | "communities"
  // fileType: "image_full" | "image_thumb" | "voice"

  const userId = context.auth!.uid;

  // Validate membership
  if (parentCollection === 'conversations') {
    const conv = await db.collection('conversations').doc(parentId).get();
    if (!conv.exists || !conv.data()!.participantIds.includes(userId)) {
      throw new functions.https.HttpsError('permission-denied', 'Not a participant');
    }
  } else {
    const comm = await db.collection('communities').doc(parentId).get();
    if (!comm.exists || !comm.data()!.memberIds.includes(userId)) {
      throw new functions.https.HttpsError('permission-denied', 'Not a member');
    }
  }

  // Build storage path
  const subfolder = fileType === 'voice' ? 'voice' : 'images';
  const extension = '.enc'; // Always .enc — encrypted blob
  const suffix = fileType === 'image_thumb' ? '_thumb' : fileType === 'image_full' ? '_full' : '';
  const storagePath = `${parentCollection}/${parentId}/${subfolder}/${messageId}${suffix}${extension}`;

  // Generate signed URL (15 min expiry, write-only)
  const bucket = admin.storage().bucket();
  const file = bucket.file(storagePath);
  const [url] = await file.getSignedUrl({
    version: 'v4',
    action: 'write',
    expires: Date.now() + 15 * 60 * 1000,
    contentType: 'application/octet-stream', // Encrypted blob — always binary
  });

  return { url, storagePath };
});
```

**Updated `MediaUploadDatasource` flow:**

```dart
@injectable
class MediaUploadDatasource {
  final FirebaseFunctions _functions;
  final CryptoService _cryptoService;
  final http.Client _httpClient;

  Future<EncryptedMediaUploadResult> uploadEncryptedImage({
    required Uint8List processedImageBytes,     // Already compressed/resized
    required Uint8List processedThumbBytes,     // Already generated thumbnail
    required String parentCollection,
    required String parentId,
    required String messageId,
  }) async {
    // 1. Generate media keys (random AES-256-GCM keys)
    final mediaKey = _cryptoService.generateRandomKey(32);
    final thumbKey = _cryptoService.generateRandomKey(32);

    // 2. Encrypt both files
    final encryptedImage = _cryptoService.encryptAesGcm(processedImageBytes, mediaKey);
    final encryptedThumb = _cryptoService.encryptAesGcm(processedThumbBytes, thumbKey);

    // 3. Get signed upload URLs from Cloud Function
    final imageUrlResult = await _functions.httpsCallable('generateSignedUploadUrl').call({
      'parentCollection': parentCollection,
      'parentId': parentId,
      'messageId': messageId,
      'fileType': 'image_full',
    });
    final thumbUrlResult = await _functions.httpsCallable('generateSignedUploadUrl').call({
      'parentCollection': parentCollection,
      'parentId': parentId,
      'messageId': messageId,
      'fileType': 'image_thumb',
    });

    // 4. Upload encrypted blobs via HTTP PUT
    await _httpClient.put(
      Uri.parse(imageUrlResult.data['url']),
      body: encryptedImage.ciphertextBytes,
      headers: {'Content-Type': 'application/octet-stream'},
    );
    await _httpClient.put(
      Uri.parse(thumbUrlResult.data['url']),
      body: encryptedThumb.ciphertextBytes,
      headers: {'Content-Type': 'application/octet-stream'},
    );

    // 5. Return storage paths + keys (keys go into message ciphertext, not to server)
    return EncryptedMediaUploadResult(
      storagePath: imageUrlResult.data['storagePath'],
      thumbStoragePath: thumbUrlResult.data['storagePath'],
      mediaKey: mediaKey,
      thumbKey: thumbKey,
      imageNonce: encryptedImage.nonce,
      thumbNonce: encryptedThumb.nonce,
      fileSize: processedImageBytes.length,
      thumbSize: processedThumbBytes.length,
    );
  }

  // uploadEncryptedVoice() follows same pattern with single file (no thumbnail)
}

class EncryptedMediaUploadResult {
  final String storagePath;
  final String? thumbStoragePath;
  final Uint8List mediaKey;       // NOT sent to server — embedded in E2EE ciphertext
  final Uint8List? thumbKey;
  final Uint8List imageNonce;
  final Uint8List? thumbNonce;
  final int fileSize;
  final int? thumbSize;
}
```

**Updated Storage Security Rules** (replaces Section 21.4):

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /conversations/{convId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if false;  // Writes via signed URLs generated by Cloud Functions
    }
    match /communities/{commId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if false;  // Writes via signed URLs generated by Cloud Functions
    }
  }
}
// Note: Signed URLs bypass storage security rules. The Cloud Function
// validates membership before issuing the signed URL, so the rules
// only govern direct SDK access (which we block for writes).
```

### 32.2 Gift & Spray Encryption Key Specification

**Problem:** When a gift is sent in a community to a specific recipient, which key encrypts the personal message — Sender Key (all members see) or P2P Signal session (only recipient sees)?

**Decision: Context-based encryption:**

| Context | Encryption Key | Who Sees Personal Message |
|---------|---------------|--------------------------|
| P2P gift (conversationId) | P2P Signal session (Double Ratchet) | Only sender and recipient |
| Community gift (communityId) | **Sender Key** | All community members |
| Token Spray (communityId) | **Sender Key** | All community members |

**Rationale:** Community gifts and sprays are inherently **public celebrations** — the personal message is part of the community experience. If a user wants a private gift message, they should send the gift via a P2P conversation.

**Implementation in Repository:**

```dart
// In ConversationRepositoryImpl.sendGift():
// → Gift in a P2P conversation: encrypt with P2P Signal session
final encrypted = await _signalService.encryptP2P(
  recipientId: recipientId,
  plaintext: personalMessage,
);

// In CommunityRepositoryImpl.sendGift():
// → Gift in a community: encrypt with Sender Key (all members can decrypt)
final encrypted = await _senderKeyService.encryptCommunity(
  communityId: communityId,
  plaintext: personalMessage,
);
```

**Gift/Spray Cloud Functions receive the same parameters regardless:**
```typescript
// gifts.ts sendGift receives:
{ recipientId, amount, ciphertext, e2ee, encryptedPreviews, style, conversationId?, communityId?, idempotencyKey }
// The server doesn't know or care which key was used — it stores ciphertext as-is.
```

### 32.3 Preview Key Derivation Algorithm

**Problem:** Section 12.6 says "Derive a preview key from the current session/sender key" without specifying HOW.

**Specification:**

```
Preview Key Derivation (HKDF-SHA256):

For P2P conversations:
  previewKey = HKDF-Expand(
    prk: currentDoubleRatchetChainKey,    // From the active sending chain
    info: "imali-preview-v1",             // Fixed info string for domain separation
    length: 32                            // 256-bit AES key
  )

For communities (Sender Key):
  previewKey = HKDF-Expand(
    prk: currentSenderKeyMaterial,        // The sender's active Sender Key
    info: "imali-community-preview-v1",   // Different info string
    length: 32
  )

Encryption:
  encryptedPreview = AES-256-GCM(
    key: previewKey,
    nonce: random(12 bytes),
    plaintext: truncatedPreviewText
  )

Output format (base64):
  base64(nonce || ciphertext || tag)      // 12 + len + 16 bytes
```

**Why per-user:**
- In P2P: each participant has a different Double Ratchet chain key → different preview key → independent ciphertexts.
- In communities: the sender encrypts one preview with the Sender Key, but each member still needs to be able to decrypt it. Since ALL members have the sender's Sender Key, the sender generates ONE encrypted preview and stores it under EACH member's userId key in the `encryptedPreviews` map (same ciphertext for all, but indexed by userId for lookup).

**Optimization for communities:** Since all members decrypt with the same Sender Key, the sender encrypts the preview once and duplicates the ciphertext for each member in the map. This avoids N separate encryptions while maintaining the per-userId map structure for efficient lookup.

### 32.4 ConversationModel Preview Extraction — Repository Integration

**Problem:** `ConversationModel` stores `lastMessageEncryptedPreviews: Map<String, String>?` but `toEntity()` maps `lastMessageText: lastMessageText` without extracting the current user's encrypted preview.

**Solution:** The **repository** (not the model/mapper) handles preview decryption. The model passes the full map through to the entity, and the repository decrypts the current user's preview when converting models to entities.

**Updated `Conversation` entity** (add field):
```dart
// In Conversation entity (Section 4.2), add:
Map<String, String>? lastMessageEncryptedPreviews,   // Raw encrypted previews (per-user)
// lastMessageText is populated by the repository after decryption
```

**Updated `ConversationModel.toEntity()`:**
```dart
Conversation toEntity({String? decryptedPreview}) => Conversation(
  id: id,
  type: ConversationType.values.byName(type),
  participantIds: participantIds,
  participants: participants.map((k, v) => MapEntry(k, v.toEntity())),
  lastMessageText: decryptedPreview,   // ← Set by repository after preview decryption
  lastMessageSenderId: lastMessageSenderId,
  lastMessageSenderName: lastMessageSenderName,
  lastMessageType: lastMessageType,
  lastMessageAt: lastMessageAt,
  unreadCounts: unreadCounts,
  archived: archived,
  pinned: pinned,
  muted: muted,
  createdAt: createdAt,
  updatedAt: updatedAt,
);
```

**Updated `ConversationRepositoryImpl.watchConversations()`:**
```dart
@override
Stream<Either<Failure, List<Conversation>>> watchConversations() {
  final currentUserId = _authService.currentUserId;
  return _remoteDataSource.watchConversations().asyncMap((models) async {
    try {
      final conversations = <Conversation>[];
      for (final model in models) {
        String? decryptedPreview;

        // 1. Try to decrypt this user's encrypted preview
        final myEncryptedPreview = model.lastMessageEncryptedPreviews?[currentUserId];
        if (myEncryptedPreview != null) {
          try {
            final otherId = model.participantIds.firstWhere((id) => id != currentUserId);
            decryptedPreview = await _signalService.decryptPreview(
              senderId: otherId,
              encryptedPreview: myEncryptedPreview,
            );
          } catch (_) {
            decryptedPreview = '[Encrypted message]';
          }
        }

        // 2. Fall back to plaintext for system messages
        if (decryptedPreview == null && model.lastMessageType == 'system') {
          decryptedPreview = model.lastMessageText;
        }

        conversations.add(model.toEntity(decryptedPreview: decryptedPreview));
      }
      return Right<Failure, List<Conversation>>(conversations);
    } catch (e) {
      return Left<Failure, List<Conversation>>(Failure.serverError(message: e.toString()));
    }
  });
}
```

**Same pattern applies to `CommunityRepositoryImpl.watchUserCommunities()`** — uses `SenderKeyService.decryptPreview()` instead.

### 32.5 Media Encryption/Decryption in Repository — Complete Flow

**Problem:** Section 29.4 shows `sendTextMessage` and `watchMessages` decrypt patterns but NOT the media message flow.

**`ConversationRepositoryImpl.sendMediaMessage()`:**

```dart
@override
Future<Either<Failure, Message>> sendMediaMessage({
  required String conversationId,
  required String mediaUrl,       // NOT USED — we encrypt + upload locally
  required String mediaType,      // "image" | "voice"
  String? caption,
}) async {
  if (!await _networkInfo.isConnected) return const Left(Failure.network());
  try {
    final recipientId = _getRecipientId(conversationId);
    final messageId = const Uuid().v4();  // Pre-generate for storage path

    // 1. Process media file (compress, resize, generate thumbnail)
    final processed = await _mediaProcessor.processMedia(
      filePath: mediaUrl,  // Local file path
      type: mediaType,
    );

    // 2. Encrypt + upload via MediaUploadDatasource
    EncryptedMediaUploadResult uploadResult;
    if (mediaType == 'image') {
      uploadResult = await _mediaUploadDatasource.uploadEncryptedImage(
        processedImageBytes: processed.imageBytes!,
        processedThumbBytes: processed.thumbBytes!,
        parentCollection: 'conversations',
        parentId: conversationId,
        messageId: messageId,
      );
    } else {
      uploadResult = await _mediaUploadDatasource.uploadEncryptedVoice(
        processedVoiceBytes: processed.voiceBytes!,
        parentCollection: 'conversations',
        parentId: conversationId,
        messageId: messageId,
      );
    }

    // 3. Build plaintext JSON (caption + embedded media keys)
    final plaintextJson = jsonEncode({
      'text': caption,
      'mediaKey': base64Encode(uploadResult.mediaKey),
      'mediaNonce': base64Encode(uploadResult.imageNonce),
      'thumbKey': uploadResult.thumbKey != null ? base64Encode(uploadResult.thumbKey!) : null,
      'thumbNonce': uploadResult.thumbNonce != null ? base64Encode(uploadResult.thumbNonce!) : null,
    });

    // 4. Encrypt plaintext JSON with Signal Protocol
    final encrypted = await _signalService.encryptP2P(
      recipientId: recipientId,
      plaintext: plaintextJson,
    );

    // 5. Generate encrypted preview ("Sent an image" / "Voice message")
    final previewText = mediaType == 'image' ? '📷 Photo' : '🎤 Voice message';
    final encryptedPreviews = await _signalService.encryptPreviewForParticipants(
      conversationId: conversationId,
      preview: caption != null ? '$previewText: ${caption.substring(0, 50)}' : previewText,
    );

    // 6. Call datasource with ciphertext + storage paths (NOT keys)
    final model = await _remoteDataSource.sendMediaMessage(
      conversationId: conversationId,
      mediaUrl: uploadResult.storagePath,          // Encrypted blob path
      mediaType: mediaType,
      ciphertext: encrypted.ciphertext,
      e2ee: encrypted.e2eeMetadata,
      encryptedPreviews: encryptedPreviews,
    );

    // 7. Return entity with decrypted caption
    return Right(model.toEntity(decryptedText: caption));
  } on ServerException catch (e) {
    return Left(Failure.serverError(message: e.message));
  }
}
```

### 32.6 Media Key Extraction on Receive

**Problem:** When receiving a media message, how does the repository extract the embedded `mediaKey` and `thumbKey` from the decrypted plaintext JSON?

**In `ConversationRepositoryImpl.watchMessages()` — media message decryption branch:**

```dart
// Inside the message loop in watchMessages() (Section 29.4):
if (model.ciphertext != null && model.e2ee != null) {
  try {
    final decryptedString = await _signalService.decryptP2P(
      senderId: model.senderId,
      ciphertext: model.ciphertext!,
      e2eeMetadata: model.e2ee!,
      x3dhHeader: model.x3dhHeader,
    );

    // Check if this is a media message with embedded keys
    if (model.media != null) {
      // decryptedString is JSON: { text, mediaKey, mediaNonce, thumbKey, thumbNonce }
      final decryptedJson = jsonDecode(decryptedString) as Map<String, dynamic>;
      final caption = decryptedJson['text'] as String?;

      // Attach decrypted media keys to the entity
      messages.add(model.toEntity(
        decryptedText: caption,
        decryptedMediaKey: decryptedJson['mediaKey'] != null
            ? base64Decode(decryptedJson['mediaKey'] as String) : null,
        decryptedMediaNonce: decryptedJson['mediaNonce'] != null
            ? base64Decode(decryptedJson['mediaNonce'] as String) : null,
        decryptedThumbKey: decryptedJson['thumbKey'] != null
            ? base64Decode(decryptedJson['thumbKey'] as String) : null,
        decryptedThumbNonce: decryptedJson['thumbNonce'] != null
            ? base64Decode(decryptedJson['thumbNonce'] as String) : null,
      ));
    } else {
      // Plain text message
      messages.add(model.toEntity(decryptedText: decryptedString));
    }
  } catch (_) {
    messages.add(model.toEntity(decryptedText: '[Cannot decrypt]'));
  }
}
```

**Updated `MessageModel.toEntity()` signature:**
```dart
Message toEntity({
  String? decryptedText,
  Uint8List? decryptedMediaKey,
  Uint8List? decryptedMediaNonce,
  Uint8List? decryptedThumbKey,
  Uint8List? decryptedThumbNonce,
}) => Message(
  // ... all existing fields ...
  textContent: decryptedText,
  // Media keys are stored on the Message entity for the UI to use when downloading/decrypting blobs
  mediaDecryptionInfo: (decryptedMediaKey != null) ? MediaDecryptionInfo(
    mediaKey: decryptedMediaKey,
    mediaNonce: decryptedMediaNonce!,
    thumbKey: decryptedThumbKey,
    thumbNonce: decryptedThumbNonce,
  ) : null,
);
```

**New `MediaDecryptionInfo` on `Message` entity:**
```dart
// Added to lib/domain/entities/message.dart
@freezed
class MediaDecryptionInfo with _$MediaDecryptionInfo {
  const factory MediaDecryptionInfo({
    required Uint8List mediaKey,
    required Uint8List mediaNonce,
    Uint8List? thumbKey,
    Uint8List? thumbNonce,
  }) = _MediaDecryptionInfo;
}

// In Message entity, add field:
MediaDecryptionInfo? mediaDecryptionInfo,  // Populated after E2EE decryption, used by media widgets
```

**Widget usage:**
```dart
// In MessageBubble widget, for image messages:
if (message.hasMedia && message.mediaDecryptionInfo != null) {
  // Download encrypted blob from Cloud Storage
  final encryptedBytes = await FirebaseStorage.instance
      .ref(message.media!.url)
      .getData();

  // Decrypt with embedded key
  final decryptedBytes = cryptoService.decryptAesGcm(
    encryptedBytes!,
    message.mediaDecryptionInfo!.mediaKey,
    message.mediaDecryptionInfo!.mediaNonce,
  );

  // Display decrypted image
  return Image.memory(decryptedBytes);
}
```

### 32.7 Optimistic UI with E2EE — BLoC Integration

**Problem:** How does the BLoC display a message instantly (optimistic UI) while encryption + Cloud Function call happens asynchronously?

**Pattern:**

```dart
// In ConversationBloc, on<SendTextMessage>:
on<_SendTextMessage>((event, emit) async {
  // 1. Create optimistic message immediately
  final optimisticMessage = Message(
    id: const Uuid().v4(),   // Temporary local ID
    senderId: _authService.currentUserId,
    senderName: _authService.currentUserName,
    type: MessageType.text,
    status: MessageStatus.sending,  // ← Optimistic status
    textContent: event.text,        // ← Plaintext — already available
    createdAt: DateTime.now(),
    // ... other fields
  );

  // 2. Emit state with optimistic message prepended
  emit(state.copyWith(
    messages: [optimisticMessage, ...state.messages],
    isSending: true,
  ));

  // 3. Repository handles encryption + network call
  final result = await _repository.sendTextMessage(
    conversationId: event.conversationId,
    text: event.text,
    replyToMessageId: event.replyToMessageId,
  );

  // 4. Replace optimistic message with server-confirmed message
  result.fold(
    (failure) {
      // Replace optimistic message with failed status
      final updatedMessages = state.messages.map((m) =>
        m.id == optimisticMessage.id
            ? m.copyWith(status: MessageStatus.failed)
            : m
      ).toList();
      emit(state.copyWith(messages: updatedMessages, isSending: false, errorMessage: failure.message));
    },
    (confirmedMessage) {
      // Replace optimistic message with server-confirmed message
      final updatedMessages = state.messages.map((m) =>
        m.id == optimisticMessage.id ? confirmedMessage : m
      ).toList();
      emit(state.copyWith(messages: updatedMessages, isSending: false));
    },
  );
});
```

**Key insight:** The BLoC always works with **plaintext**. It creates the optimistic message from the user's plaintext input. The repository handles encryption transparently and returns a `Message` entity with the same plaintext (since the sender already knows it). The real-time Firestore listener will also deliver the same message (decrypted from ciphertext), and the BLoC deduplicates by `id`.

### 32.8 Registration & Key Generation Integration

**Problem:** Section 12.2 defines the key generation flow but doesn't specify which screen/BLoC it integrates with.

**Integration point:** `lib/presentation/blocs/auth/auth_bloc.dart` (existing)

**Flow:**
```
Existing registration flow (unchanged):
  1. User fills registration form (name, email, phone)
  2. AuthBloc.register() → Firebase Auth creates user + Firestore /users/{id} doc
  3. On success → navigate to home

New step INSERTED between 2 and 3:
  2a. AuthBloc detects successful registration
  2b. AuthBloc dispatches KeyGenerationEvent to a new E2EE initialization event
  2c. KeyManagementService.generateAndUploadKeyBundle() is called:
      - Generate IdentityKeyPair (Curve25519)
      - Generate SignedPreKey
      - Generate 100 one-time pre-keys
      - Store private keys in Android Keystore / iOS Keychain (via FlutterSecureStorage)
      - Upload public key bundle via uploadKeyBundle Cloud Function
      - Retry up to 3 times with exponential backoff
  2d. If key bundle upload succeeds:
      - Registration complete → navigate to KeyBackupPromptScreen (new)
  2e. If all retries fail:
      - Delete user from Firebase Auth (rollback)
      - Delete /users/{id} doc from Firestore (rollback)
      - Show error: "Registration failed. Please try again."
      - Navigate back to registration form

Key backup prompt (2d):
  - KeyBackupPromptScreen is a one-time interstitial after registration
  - "Secure your messages" with explanation of key backup
  - Two buttons: "Set up now" → KeyBackupSetupScreen, "Remind me later" → Home
  - "Remind me later" sets a flag in SharedPreferences
  - After 3 days, a banner appears in Settings: "Set up message backup"
  - After 7 days, a subtle badge appears on Settings tab icon
```

**New Cloud Function:**
```typescript
// Add to conversations.ts (or a new keys.ts if preferred)

export const uploadKeyBundle = functions.https.onCall(async (data, context) => {
  requireAuth(context);
  // No AppCheck required here — registration may not have Play Integrity yet

  const { identityPublicKey, signedPreKey, signedPreKeySignature, oneTimePreKeys, registrationId } = data;
  const userId = context.auth!.uid;

  // Write to /users/{userId}/keys/bundle (subcollection)
  await db.collection('users').doc(userId).collection('keys').doc('bundle').set({
    identityPublicKey,        // Base64 Curve25519 public key
    signedPreKey,             // Base64 signed pre-key public
    signedPreKeySignature,    // Base64 XEdDSA signature
    oneTimePreKeys,           // Array of Base64 one-time pre-key publics
    registrationId,           // Unique per-device integer
    uploadedAt: admin.firestore.FieldValue.serverTimestamp(),
    keyVersion: 1,
  }, { merge: true });  // Idempotent — re-upload overwrites

  return { success: true };
});
```

### 32.9 E2EE UI Indicators

**Problem:** No specification for lock icon, `[Cannot decrypt]` fallback UI, or "security keys changed" indicator.

#### 32.9.1 Lock Icon / Encryption Indicator

**Spec:** A small lock icon (🔒) appears in the **AppBar** of `ConversationDetailScreen` and `CommunityDetailScreen` (chat tab), next to the conversation/community name. It is NOT per-message.

```dart
// In ConversationDetailScreen AppBar:
AppBar(
  title: Row(
    children: [
      Text(conversation.displayNameFor(currentUserId)),
      const SizedBox(width: 4),
      const Icon(Icons.lock, size: 14, color: Colors.green),
      // Tooltip on tap: "Messages are end-to-end encrypted"
    ],
  ),
)
```

**Design decision:** Lock icon is always present (all messages are E2EE). No need to distinguish per-message. The icon is informational — users trust that all conversations are encrypted.

#### 32.9.2 `[Cannot decrypt]` Fallback Widget

**When:** Message ciphertext exists but decryption fails (missing keys, corrupted data, new device without backup).

**Widget in `MessageBubble`:**
```dart
if (message.textContent == '[Cannot decrypt]') {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.lock_outline, color: Colors.grey, size: 20),
        const SizedBox(height: 4),
        Text(
          'Message cannot be decrypted',
          style: TextStyle(color: Colors.grey.shade600, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 4),
        Text(
          'Restore your message backup to read this message',
          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
        ),
      ],
    ),
  );
}
```

**No retry mechanism:** Decryption failure is deterministic — if the key doesn't exist locally, retrying won't help. The only recovery path is restoring from backup.

#### 32.9.3 "Security Keys Changed" Indicator

**When:** A contact re-registers on a new device without restoring backup. Their `identityPublicKey` in `/users/{userId}/keys/bundle` changes.

**Detection:** Firestore trigger on key bundle update writes a notification to the conversation doc:

```typescript
// In messagingNotifications.ts:
exports.onKeyBundleUpdated = functions.firestore
  .document('users/{userId}/keys/bundle')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    const userId = context.params.userId;

    // Only trigger if identity key changed (not just pre-key rotation)
    if (before.identityPublicKey === after.identityPublicKey) return;

    // Find all conversations involving this user
    const convs = await db.collection('conversations')
      .where('participantIds', 'array-contains', userId)
      .get();

    // Write system message to each conversation
    const batch = db.batch();
    for (const conv of convs.docs) {
      const msgRef = conv.ref.collection('messages').doc();
      batch.set(msgRef, {
        id: msgRef.id,
        conversationId: conv.id,
        senderId: 'system',
        senderName: 'System',
        type: 'system',
        status: 'sent',
        systemEventType: 'security_keys_changed',
        metadata: { userId, displayName: after.displayName || 'A contact' },
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
  });
```

**UI in `MessageBubble` for `systemEventType == 'security_keys_changed'`:**
```dart
// Renders as a centered system message (like "Alice joined the group"):
Container(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.vpn_key, size: 14, color: Colors.amber),
      const SizedBox(width: 6),
      Text(
        '${metadata['displayName']}\'s security keys have changed',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
    ],
  ),
)
```

**Not blocking:** This is informational only. Messaging continues automatically after re-establishing the Signal session with the new key bundle.

#### 32.9.4 Community "Member Without Sender Key" Fallback

**When:** A member joins a community but hasn't yet received the sender's Sender Key distribution message (brief race condition during join).

**Detection:** In `CommunityRepositoryImpl.watchMessages()`, when `SenderKeyService.decryptCommunity()` throws `MissingSenderKeyException`.

**UI:** Same as `[Cannot decrypt]` but with different text:
```dart
Text(
  'Waiting for encryption key from ${message.senderName}...',
  style: TextStyle(color: Colors.grey.shade600, fontStyle: FontStyle.italic),
),
// Auto-resolves: when the Sender Key distribution message arrives,
// the Firestore listener re-fires and the message gets decrypted.
```

**Auto-retry mechanism:** The Firestore snapshot listener naturally re-fires when the Sender Key distribution message arrives and updates local key storage. The `asyncMap` in the repository re-decrypts all messages. This is automatic — no user action needed.

### 32.10 Updated Cloud Function Table — New Functions

| Function | File | Phase | Description |
|----------|------|-------|-------------|
| `generateSignedUploadUrl` | `conversations.ts` + `communities.ts` | 2 | Validates membership, generates signed Cloud Storage URL for encrypted blob upload |
| `uploadKeyBundle` | `conversations.ts` | 1 | Stores user's public key bundle to `/users/{id}/keys/bundle` |
| `fetchKeyBundle` | `conversations.ts` | 1 | Returns a user's public key bundle (needed to initiate X3DH) |
| `consumeOneTimePreKey` | `conversations.ts` | 1 | Atomically removes one pre-key from the bundle (part of X3DH) |
| `onKeyBundleUpdated` | `messagingNotifications.ts` | 2 | Firestore trigger: writes "security keys changed" system message |

These 5 functions are added to the existing Cloud Function files — no new files needed.

---

## 33. Ledger Integration — Detailed Specifications

This section addresses precise integration points between the new chat/community/gift/spray features and the existing double-entry ledger system (`functions/src/ledger/`).

### 33.1 Required Changes to `functions/src/ledger/types.ts`

#### 33.1.1 New System Accounts

Add to `SystemAccounts` object (existing: ~line 38):

```typescript
// Add after ENGAGEMENT_ESCROW
GIFT_ESCROW: "system:gift_escrow",
SPRAY_ESCROW: "system:spray_escrow",
```

#### 33.1.2 New JournalType Entries

Add to the `JournalType` union (existing: ~line 85):

```typescript
// Add after existing types:
| "gift_debit"          // User debit for gift send (user → GIFT_ESCROW)
| "gift_credit"         // Recipient credit for gift claim (GIFT_ESCROW → user)
| "gift_refund"         // Sender refund on gift expiry (GIFT_ESCROW → user)
| "spray_contribution"  // Contributor debit for spray (user → SPRAY_ESCROW)
| "spray_payout"        // Recipient credit for spray closure (SPRAY_ESCROW → user)
| "conversation_transfer" // P2P token send in conversation (reuses existing p2p_transfer, but distinct type for audit)
```

#### 33.1.3 New referenceType Entries

Add to `PostJournalInput.referenceType` union (existing: ~line 148):

```typescript
| "gift"           // References /gifts/{giftId}
| "token_spray"    // References /tokenSprays/{sprayId}
```

#### 33.1.4 New IdempotencyKey Helpers

Add to `IdempotencyKey` object (existing: ~line 473):

```typescript
// Gift operations
giftDebit: (giftId: string) => `gift_debit:${giftId}`,
giftCredit: (giftId: string) => `gift_credit:${giftId}`,
giftRefund: (giftId: string) => `gift_refund:${giftId}`,

// Spray operations — include userId for per-contributor uniqueness
sprayContribution: (sprayId: string, userId: string) => `spray_contrib:${sprayId}:${userId}`,
// Note: multi-contribution by same user uses incrementing suffix:
sprayContributionN: (sprayId: string, userId: string, n: number) => `spray_contrib:${sprayId}:${userId}:${n}`,
sprayPayout: (sprayId: string) => `spray_payout:${sprayId}`,
```

**Important:** The `sendGift` Cloud Function receives a **client-provided UUID** as `idempotencyKey`. However, the ledger function `processGiftDebit` uses the **server-generated** `IdempotencyKey.giftDebit(giftId)` internally — the client UUID is used as the Firestore `giftId` for deduplication at the Cloud Function level (check-before-create), while the ledger uses a deterministic key derived from the giftId. This two-level idempotency prevents:
- Duplicate gift creation (client UUID → Firestore doc dedup)
- Duplicate ledger debits (deterministic ledger key → journal dedup)

### 33.2 `processP2PTransfer` Idempotency Key Modification

**Problem:** `sendConversationTokens` in `conversations.ts` needs to pass a client-provided idempotency key to `processP2PTransfer()`, but the current signature generates the key internally from `transferId`.

**Solution:** Add an optional `overrideIdempotencyKey` parameter to `processP2PTransfer()`:

```typescript
// In functions/src/ledger/index.ts, modify processP2PTransfer signature:
export async function processP2PTransfer(
  senderId: string,
  recipientId: string,
  amount: number,
  transferId: string,
  senderSubAccountId?: string,
  recipientSubAccountId?: string,
  message?: string,
  metadata?: Record<string, unknown>,
  overrideIdempotencyKey?: string,     // ← NEW: if provided, use this instead of generated key
): Promise<PostJournalResult> {
  // ...existing code...
  const idempotencyKey = overrideIdempotencyKey || IdempotencyKey.p2pTransfer(transferId);
  // ...rest unchanged...
}
```

**Usage in `conversations.ts`:**
```typescript
// sendConversationTokens
const result = await processP2PTransfer(
  userId,
  recipientId,
  amount,
  messageRef.id,               // transferId = message doc ID
  subAccountId || undefined,
  undefined,
  message || undefined,
  { conversationId },
  data.idempotencyKey,         // Client-provided UUID for retry safety
);
```

### 33.3 Balance Validation — `validateMainWalletBalance` Requirement

**Problem:** The existing `processP2PTransfer()` calls `validateMainWalletBalance()` to check available balance (total balance minus allocated sub-account balances). The new gift/spray debit functions MUST do the same — otherwise a user could spend tokens that are allocated to sub-accounts.

**Required pattern for `processGiftDebit()` in `functions/src/ledger/giftAccounts.ts`:**

```typescript
export async function processGiftDebit(
  userId: string,
  amount: number,
  description: string,
  giftId: string,
  metadata?: Record<string, unknown>,
): Promise<PostJournalResult> {
  return db.runTransaction(async (transaction) => {
    // 1. CRITICAL: Validate AVAILABLE balance (not raw account balance)
    const userAccountId = AccountId.user(userId);
    const accountDoc = await transaction.get(db.collection("ledgerAccounts").doc(userAccountId));
    const accountData = accountDoc.data();

    if (!accountData) {
      return { success: false, error: "Account not found", errorCode: "ACCOUNT_NOT_FOUND" };
    }

    const totalBalance = accountData.balance || 0;
    const allocatedBalance = accountData.allocatedBalance || 0;
    const availableBalance = totalBalance - allocatedBalance;

    if (availableBalance < amount) {
      return {
        success: false,
        error: `Insufficient available balance: has ${availableBalance}, needs ${amount}`,
        errorCode: "INSUFFICIENT_BALANCE",
      };
    }

    // 2. Check idempotency
    const idempotencyKey = IdempotencyKey.giftDebit(giftId);
    const existingJournal = await transaction.get(
      db.collection("ledgerJournals").where("idempotencyKey", "==", idempotencyKey).limit(1)
    );
    if (!existingJournal.empty) {
      // Already processed — return existing result
      return { success: true, journalId: existingJournal.docs[0].id, alreadyProcessed: true };
    }

    // 3. Post double-entry journal: debit user, credit GIFT_ESCROW
    const journalRef = db.collection("ledgerJournals").doc();
    const journalEntry: PostJournalInput = {
      idempotencyKey,
      type: "gift_debit",
      entries: [
        { accountId: userAccountId, entryType: "debit", amount, description },
        { accountId: SystemAccounts.GIFT_ESCROW, entryType: "credit", amount, description },
      ],
      referenceType: "gift",
      referenceId: giftId,
      metadata: { userId, ...metadata },
    };

    // 4. Write journal + update account balances atomically
    transaction.set(journalRef, { ...journalEntry, createdAt: FieldValue.serverTimestamp() });
    transaction.update(db.collection("ledgerAccounts").doc(userAccountId), {
      balance: FieldValue.increment(-amount),
    });
    transaction.update(db.collection("ledgerAccounts").doc(SystemAccounts.GIFT_ESCROW), {
      balance: FieldValue.increment(amount),
    });

    // 5. Audit trail
    await logJournalPostedAudit(journalRef.id, journalEntry);

    return { success: true, journalId: journalRef.id };
  });
}
```

**Same pattern applies to `processSprayContributionDebit()`** — always call `validateMainWalletBalance()` or implement the equivalent check inside the transaction.

**`processGiftCredit()`, `processGiftRefund()`, `processSprayPayout()`** do NOT need balance validation — they debit escrow accounts (system accounts always have sufficient balance if debits were processed correctly).

### 33.4 Token Split — Gifts & Sprays Exempt from 90/5/5

**Decision: Gifts and sprays do NOT trigger the 90/5/5 pot contribution.**

**Rationale:**
- The 90/5/5 split (`processEarningWithSplit`) applies ONLY to brand-funded engagement earnings
- Gifts and sprays are **peer-to-peer** transfers — users sending their own tokens to other users
- Applying a pot tax to gifts would create a poor user experience (send 100, recipient gets 90)
- This matches the existing `processP2PTransfer()` which also does NOT apply the split

**Flow comparison:**

| Operation | Split Applied | Debit Account | Credit Account |
|-----------|--------------|---------------|----------------|
| Brand engagement earning | YES (90/5/5) | `brand:{clientId}` | `user` (90%) + `DAILY_POT` (5%) + `WEEKLY_POT` (5%) |
| P2P token transfer | NO (100%) | `user:{senderId}` | `user:{recipientId}` |
| Gift send → claim | NO (100%) | `user:{senderId}` → `GIFT_ESCROW` → `user:{recipientId}` |
| Gift send → expire | NO (100% refund) | `GIFT_ESCROW` → `user:{senderId}` |
| Spray contribute → payout | NO (100%) | `user:{contributorId}` → `SPRAY_ESCROW` → `user:{recipientId}` |
| Stokvel contribution | NO (100%) | `user:{memberId}` → `group:{communityId}` |
| Stokvel payout | NO (100%) | `group:{communityId}` → `user:{memberId}` |

### 33.5 `getOrCreateGroupAccount` Reuse for Communities

The existing `getOrCreateGroupAccount(groupId)` function in `ledger/groupAccounts.ts` is reused as-is for communities. The function creates a ledger account with ID `group:{id}` — it is ID-agnostic and works regardless of whether the ID comes from the `groups` or `communities` Firestore collection.

**Required comment in `communities.ts`:**
```typescript
// NOTE: We reuse getOrCreateGroupAccount() from the ledger for communities.
// The ledger function creates account ID "group:{communityId}" — the ledger
// doesn't care about the Firestore collection name. This is intentional to
// avoid duplicating ledger infrastructure.
const { accountId } = await getOrCreateGroupAccount(communityId);
```

### 33.6 Stokvel Payout Sub-Account Handling

**Decision: Stokvel payouts credit the member's main wallet only (not sub-accounts).**

**Rationale:**
- Stokvel payouts are community-to-member transfers, not brand earnings
- Sub-accounts are specific to brand partnerships (earn sub-accounts)
- Members should have full flexibility over stokvel payout funds
- The existing `processGroupPayout()` in `groupAccounts.ts` already credits main wallet — no change needed

**No code change required.** Document this decision for future reference.

### 33.7 Account Deletion Atomicity with Gift/Spray Refunds

**Problem:** Account deletion must atomically handle pending gifts/sprays to prevent race conditions with the `expireGifts` and `closeExpiredSprays` scheduled jobs.

**Solution:** The account deletion Cloud Function uses Firestore transactions with status checks:

```typescript
// In account deletion function (new: deleteUserAccount in conversations.ts or a dedicated accountDeletion.ts)

export const deleteUserAccount = functions.https.onCall(async (data, context) => {
  requireAuth(context);
  const userId = context.auth!.uid;

  await db.runTransaction(async (transaction) => {
    // STEP 1: Handle pending/opened gifts (user as sender)
    const pendingGifts = await transaction.get(
      db.collection('gifts')
        .where('senderId', '==', userId)
        .where('status', 'in', ['pending', 'opened'])
    );
    for (const giftDoc of pendingGifts.docs) {
      const gift = giftDoc.data();
      // Mark as expired FIRST (prevents race with expireGifts scheduled job)
      transaction.update(giftDoc.ref, { status: 'expired', deletedAt: FieldValue.serverTimestamp() });
      // Refund sender — uses giftId-based idempotency key (safe for concurrent calls)
      await processGiftRefund(userId, gift.amount, giftDoc.id);
    }

    // STEP 2: Handle active sprays (user as recipient)
    const recipientSprays = await transaction.get(
      db.collection('tokenSprays')
        .where('recipientId', '==', userId)
        .where('status', '==', 'active')
    );
    for (const sprayDoc of recipientSprays.docs) {
      const spray = sprayDoc.data();
      // Close spray and credit recipient before account deletion
      transaction.update(sprayDoc.ref, { status: 'closed', closedAt: FieldValue.serverTimestamp() });
      await processSprayPayout(userId, spray.currentTotal, sprayDoc.id);
    }

    // STEP 3: Handle active sprays (user as contributor)
    // Contributions already in SPRAY_ESCROW — no refund needed.
    // The spray continues without this contributor.

    // STEP 4: Delete sub-accounts
    // deleteAllSubAccounts(userId) already exists in wallet.ts

    // STEP 5: Anonymize messages
    // Set senderName to "Deleted User" in all conversation/community messages

    // STEP 6: Remove from communities
    // For each community in user's communityIds:
    //   Remove from memberIds, decrement memberCount
    //   If owner: transfer ownership to first admin, or close community if no admins

    // STEP 7: Soft-delete user doc
    transaction.update(db.collection('users').doc(userId), {
      status: 'deleted',
      deletedAt: FieldValue.serverTimestamp(),
      displayName: 'Deleted User',
      email: null,
      phone: null,
      // Schedule permanent purge after 30 days
    });
  });

  // STEP 8: Delete Firebase Auth account
  await admin.auth().deleteUser(userId);

  return { success: true };
});
```

**Race condition prevention:**
- `expireGifts` scheduled job checks `status in ['pending', 'opened']` AND `expiresAt < now` — if account deletion already set `status = 'expired'`, the scheduled job skips it
- `closeExpiredSprays` checks `status == 'active'` AND `expiresAt < now` — if account deletion already set `status = 'closed'`, the scheduled job skips it
- Both the scheduled jobs and account deletion use the same `giftId`/`sprayId`-based idempotency keys for ledger operations — duplicate attempts are safely deduplicated

### 33.8 Required Changes to `functions/src/ledger/accounts.ts`

Update `initializeSystemAccounts()` to create the two new system accounts:

```typescript
// Add to the systemAccounts array in initializeSystemAccounts():
{ id: SystemAccounts.GIFT_ESCROW, type: 'system', name: 'Gift Escrow', description: 'Holds tokens between gift send and claim/expiry' },
{ id: SystemAccounts.SPRAY_ESCROW, type: 'system', name: 'Token Spray Escrow', description: 'Holds tokens between spray contributions and payout' },
```

### 33.9 Files to Modify — Ledger-Specific

| File | Change | Priority |
|------|--------|----------|
| `functions/src/ledger/types.ts` | Add GIFT_ESCROW, SPRAY_ESCROW to SystemAccounts | CRITICAL |
| `functions/src/ledger/types.ts` | Add 6 new JournalType entries (gift_*, spray_*, conversation_transfer) | CRITICAL |
| `functions/src/ledger/types.ts` | Add "gift", "token_spray" to referenceType union | CRITICAL |
| `functions/src/ledger/types.ts` | Add 6 IdempotencyKey helpers (giftDebit, giftCredit, giftRefund, sprayContribution, sprayContributionN, sprayPayout) | HIGH |
| `functions/src/ledger/index.ts` | Add optional `overrideIdempotencyKey` param to `processP2PTransfer()` | HIGH |
| `functions/src/ledger/accounts.ts` | Add GIFT_ESCROW + SPRAY_ESCROW to `initializeSystemAccounts()` | CRITICAL |
| `functions/src/ledger/giftAccounts.ts` | NEW FILE: 5 gift/spray ledger functions with `validateMainWalletBalance` checks. All functions accept optional `transaction` param to participate in caller's transaction scope (prevents nested transaction issues — RC-16). | CRITICAL |

---

## 34. Admin Portal Integration Specification

**Context:** The admin portal (`lib/presentation/admin/`) is architecturally isolated from the consumer app (separate entry point, router, BLoCs). However, the new chat/communities/gifts/sprays features require admin oversight for moderation, financial auditing, and safety.

**Key finding:** The existing admin portal has ZERO group/community management screens. Group data only surfaces in the Ledger Recon Screen (`groupBalances` line item) and Accounts Overview (via `group:` account type). Nothing in the admin portal will break when groups are deprecated, but new admin capabilities are needed.

### 34.1 Minimum Viable Admin — In-Scope for Phase 2

The following admin features are promoted from "deferred" (Section 2.6) to **in-scope for Phase 2** because they represent minimum safety tooling required at launch:

| Feature | Priority | Rationale |
|---------|----------|-----------|
| Community suspension/reactivation Cloud Functions | CRITICAL | State machine (Section 28.10) defines these transitions but no CF implements them |
| Report submission Cloud Function | CRITICAL | Current plan allows direct client writes to `/reports` — skips validation/rate limiting |
| Admin report listing + actioning Cloud Functions | CRITICAL | Without these, `/reports` is a write-only dead letter box |
| Admin permissions in `adminAuth.ts` | CRITICAL | RBAC system currently has zero community/report/gift/spray permissions |
| Admin community list + details Cloud Functions | HIGH | Admins need visibility into community activity for moderation |

### 34.2 Admin Cloud Functions (in `functions/src/adminAccounts.ts`)

Per CLAUDE.md: "Do NOT create new top-level TypeScript files for admin functions — extend `adminAccounts.ts`."

| Function | Permission | Parameters | Description |
|----------|-----------|------------|-------------|
| `adminListCommunities` | `communities:list` | `{page?, limit?, status?, type?, search?}` | Paginated list of all communities with search/filter by name, type, status |
| `adminGetCommunityDetails` | `communities:get` | `{communityId}` | Full community doc + member count + financial summary (balance, total contributed, pending transactions) |
| `adminSuspendCommunity` | `communities:suspend` | `{communityId, reason}` | Sets `status: 'suspended'`, records reason, writes audit log. Blocks all messaging + financial ops. |
| `adminReactivateCommunity` | `communities:reactivate` | `{communityId}` | Sets `status: 'active'`, writes audit log. Unblocks all operations. |
| `adminCloseCommunity` | `communities:close` | `{communityId, reason}` | Force-close: freeze ledger account, reject pending transactions, close active sprays, cancel pending gifts, set status='closed', write audit log |
| `adminRemoveCommunityMember` | `communities:removeMember` | `{communityId, memberId, reason}` | Removes member without being a community member. Handles pending approvals by removed member. |
| `adminListReports` | `reports:list` | `{page?, limit?, status?, type?}` | Paginated list of reports with filters |
| `adminActionReport` | `reports:action` | `{reportId, action, details?}` | Transitions report status. Actions: 'dismiss', 'warn_user', 'suspend_community', 'delete_message', 'ban_user' |
| `adminListGifts` | `gifts:list` | `{page?, limit?, status?, senderId?, recipientId?}` | Gift oversight for financial auditing |
| `adminCancelGift` | `gifts:cancel` | `{giftId, reason}` | Force-expire pending gift, refund sender from GIFT_ESCROW |
| `adminCloseSpray` | `sprays:close` | `{sprayId, reason}` | Force-close active spray, trigger close flow |
| `adminGetCommunityTransactions` | `communities:getTransactions` | `{communityId, page?, limit?}` | View community financial transactions for auditing |
| `submitReport` | (user auth) | `{type, targetId, reason, additionalInfo?}` | Validated report creation. Rate limited (max 5 reports/hour per user). Deduplicates same reporter+target within 24h. Placed in `communities.ts` (user-facing, not admin). |

### 34.3 Admin Permission Additions to `adminAuth.ts`

```typescript
// Add to AdminPermission type union:
| "communities:list"
| "communities:get"
| "communities:suspend"
| "communities:reactivate"
| "communities:close"
| "communities:removeMember"
| "communities:getTransactions"
| "reports:list"
| "reports:action"
| "gifts:list"
| "gifts:cancel"
| "sprays:list"
| "sprays:close"

// Add to role permission arrays:
// financeAdminPerms: communities:list, communities:get, communities:getTransactions, gifts:list, sprays:list
// platformAdminPerms: communities:list, communities:get, communities:suspend, communities:reactivate,
//                     communities:close, communities:removeMember, reports:list, reports:action
// auditorPerms: communities:list, communities:get, communities:getTransactions, reports:list, gifts:list, sprays:list
```

### 34.4 Admin Portal Screen (Deferred but Specified)

A single **Community Management Screen** at route `/communities` with:
- Tabbed layout: Communities | Reports | Gifts & Sprays
- Communities tab: searchable/filterable list, click for detail modal with suspend/reactivate/close actions
- Reports tab: pending reports queue with action buttons (dismiss, warn, suspend, ban)
- Gifts & Sprays tab: overview of GIFT_ESCROW + SPRAY_ESCROW balances, active gifts/sprays list

**Files:**
- `lib/presentation/admin/screens/community_management_screen.dart`
- Route: `/communities` in `admin_router.dart`
- Sidebar entry: "Community Management" section after "Earn Management"
- Role access: `superAdmin`, `platformAdmin`, `financeAdmin` (view only), `auditor` (view only)

### 34.5 Ledger Recon Screen Updates

| Current (line) | Change | Priority |
|----------------|--------|----------|
| Line 369: "Groups" label | Change to "Communities" | MEDIUM |
| Line 1028: `case 'group': return 'Group'` | Change to `return 'Community'` | MEDIUM |
| Lines 1064-1071: journal type labels | "Group Contrib" → "Community Contrib", etc. | MEDIUM |
| Balance breakdown | Add separate rows for `GIFT_ESCROW` and `SPRAY_ESCROW` system accounts | HIGH |

### 34.6 Files to Modify — Admin-Specific

| File | Change | Priority |
|------|--------|----------|
| `functions/src/adminAccounts.ts` | Add 12 admin Cloud Functions (Section 34.2) | CRITICAL |
| `functions/src/adminAuth.ts` | Add 13 AdminPermission entries + update role permission arrays | CRITICAL |
| `functions/src/communities.ts` | Add `submitReport` user-facing Cloud Function | CRITICAL |
| `lib/presentation/admin/router/admin_router.dart` | Add `/communities` route | HIGH |
| `lib/presentation/admin/shell/admin_shell.dart` | Add sidebar entry + role access for communities | HIGH |
| `lib/presentation/admin/screens/ledger_recon_screen.dart` | Update "Groups" → "Communities" labels | MEDIUM |

---

## 35. Sender Key Distribution Protocol — Operational Specification

**Context:** Section 12.5 specifies the Sender Key cryptographic protocol but leaves operational mechanics underspecified. This section fills those gaps.

### 35.1 Key Distribution Message Schema

Key distribution messages are stored in a **dedicated subcollection** on each community, NOT in the regular messages subcollection:

```javascript
/communities/{communityId}/keyDistribution/{distributionId}
{
  id: string,
  fromUserId: string,              // Who is distributing their Sender Key
  toUserId: string,                // Who should receive it
  encryptedSenderKey: string,      // Sender Key encrypted with P2P Signal session (Base64)
  e2ee: {                          // P2P Signal protocol metadata for decryption
    protocol: "signal",
    messageNumber: number,
    dhPublicKey: string,
  },
  x3dhHeader: {} | null,           // Present if this required a new P2P session
  chainId: number,                 // Which Sender Key chain version this is
  createdAt: Timestamp,
  consumed: boolean,               // True once recipient has processed it
}
```

**Security Rules:**
```javascript
match /communities/{commId}/keyDistribution/{distId} {
  allow read: if isAuthenticated() &&
    resource.data.toUserId == request.auth.uid;
  allow write: if false;  // Writes via Cloud Functions only
}
```

### 35.2 Trigger Mechanism — New Member Joins

When `acceptCommunityInvitation` succeeds:

1. **Server-side trigger:** `onCommunityMemberJoined` (Firestore trigger on `communities/{id}/members/{userId}` writes where `status` transitions from `invited` to `active`).

2. **Server writes a `keyDistributionRequest` doc:**
```javascript
/communities/{communityId}/keyDistributionRequests/{requestId}
{
  type: "new_member",
  newMemberId: string,
  existingMemberIds: [string],     // All active members at time of join
  status: "pending",
  createdAt: Timestamp,
}
```

3. **Each existing member's client** has a Firestore snapshot listener on `keyDistributionRequests` filtered by `existingMemberIds array-contains currentUserId`. When a new request arrives:
   - Generate encrypted Sender Key for the new member
   - Write to `keyDistribution` subcollection via `distributeSenderKey` Cloud Function
   - If no P2P Signal session exists with new member → establish via X3DH first (fetches key bundle)

4. **New member's client** has a snapshot listener on `keyDistribution` filtered by `toUserId == currentUserId`. When distribution messages arrive:
   - Decrypt each Sender Key using P2P Signal session
   - Store in local Sender Key store (keyed by `fromUserId + chainId`)
   - Mark distribution message as `consumed: true` via Cloud Function

### 35.3 Trigger Mechanism — Member Leaves/Removed

When `removeCommunityMember`, `leaveCommunity`, or account deletion removes a member:

1. **Server-side trigger:** `onCommunityMemberRemoved` (Firestore trigger on member doc deletion or status change).

2. **Server writes a `keyDistributionRequest` doc** with `type: "rekey"` listing all remaining members.

3. **Each remaining member's client** generates a NEW Sender Key and distributes to all other remaining members (via the same mechanism as 35.2 step 3).

4. **Forward secrecy:** The departed member's old Sender Key material cannot decrypt messages encrypted with new Sender Keys.

### 35.4 Cold-Start Problem — Offline Members

**Problem:** If existing members are offline when a new member joins, they cannot distribute their Sender Keys.

**Solution — Lazy Distribution:**
- When an offline member comes back online, their client checks for pending `keyDistributionRequests`
- For any unprocessed requests, the client generates and distributes Sender Keys
- Until distribution completes, the new member sees "[Waiting for encryption key from {senderName}...]" (Section 32.9.4)
- This is an acceptable UX trade-off for strong forward secrecy

### 35.5 Batching — Large Communities

For communities with 50+ members, Sender Key distribution to a new member requires N-1 X3DH handshakes in the worst case.

**Mitigation:**
- Distribute in batches of 10, with 500ms delay between batches
- Show progress indicator: "Setting up encryption (15/49 members)..."
- If client goes offline mid-distribution, resume on next launch (check consumed flags)
- Maximum community size for E2EE: 100 members (enforced by `settings.maxMembers`)

### 35.6 New Cloud Functions for Key Distribution

| Function | File | Parameters | Description |
|----------|------|-----------|-------------|
| `distributeSenderKey` | `conversations.ts` (E2EE section) | `{communityId, toUserId, encryptedSenderKey, e2ee, x3dhHeader?, chainId}` | Writes to `keyDistribution` subcollection. Validates caller is community member. |
| `markKeyDistributionConsumed` | `conversations.ts` | `{communityId, distributionId}` | Sets `consumed: true`. Validates caller is the `toUserId`. |

### 35.7 New Firestore Indexes

```yaml
# Key distribution
communities/{id}/keyDistribution:
  - toUserId + consumed + createdAt (desc)

communities/{id}/keyDistributionRequests:
  - existingMemberIds (array-contains) + status + createdAt (desc)
```

---

## 36. Cross-BLoC Communication & Error Handling

### 36.1 Wallet Balance Refresh After Financial Operations

**Problem (ERR-1):** After token operations (send tokens, gift, spray contribute), the WalletBloc's displayed balance is stale until manually refreshed. Users may attempt a second operation based on the displayed (incorrect) balance.

**Solution — Event Bus Pattern:**

```dart
// lib/core/services/app_event_bus.dart
@singleton
class AppEventBus {
  final _controller = StreamController<AppEvent>.broadcast();
  Stream<AppEvent> get stream => _controller.stream;
  void fire(AppEvent event) => _controller.add(event);
  void dispose() => _controller.close();
}

abstract class AppEvent {}
class WalletBalanceChanged extends AppEvent {}
class UnreadCountChanged extends AppEvent {
  final int conversationUnread;
  final int communityUnread;
  UnreadCountChanged({required this.conversationUnread, required this.communityUnread});
}
```

**Integration:**
- After ANY financial Cloud Function returns success, the calling BLoC fires `WalletBalanceChanged` on the event bus
- `WalletBloc` subscribes to `AppEventBus.stream` and refreshes balance when `WalletBalanceChanged` arrives
- Similarly, `ConversationBloc` and `CommunityBloc` fire `UnreadCountChanged` for the bottom nav badge
- Event bus is `@singleton` in DI — shared across all BLoCs

**Affected BLoCs:**
| BLoC | Fires `WalletBalanceChanged` After |
|------|-------------------------------------|
| ConversationBloc | `sendTokens`, `acceptTokenRequest` |
| CommunityBloc | `contribute`, `withdraw`, `triggerPayout` |
| GiftBloc | `sendGift`, `claimGift` |
| TokenSprayBloc | `contribute`, `claimSpray` |

### 36.2 BLoC Error Reset Pattern

**Problem (ERR-2):** BLoC `isSending`/`isClaiming`/`isContributing` flags are not reset on error, leaving the UI in a permanent loading state.

**Standard pattern for ALL financial BLoC handlers:**

```dart
// CORRECT: Always reset flags on both success and error
on<SendGift>((event, emit) async {
  emit(state.copyWith(isSending: true, errorMessage: null));
  final result = await _giftRepository.sendGift(...);
  result.fold(
    (failure) => emit(state.copyWith(
      isSending: false,           // MUST reset on error
      errorMessage: failure.message,
    )),
    (gift) {
      emit(state.copyWith(isSending: false, errorMessage: null));
      _eventBus.fire(WalletBalanceChanged());  // Trigger wallet refresh
    },
  );
});
```

**This pattern applies to:** `sendTextMessage`, `sendMediaMessage`, `sendTokens`, `requestTokens`, `acceptTokenRequest`, `contribute`, `withdraw`, `sendGift`, `claimGift`, `contributeToSpray`, `claimSpray`.

### 36.3 Cloud Function Error Code Mapping

Every Cloud Function should return standardized error codes that the Flutter client maps to user-facing messages.

**Standard Error Codes:**

| gRPC Code | When Thrown | User-Facing Message |
|-----------|------------|---------------------|
| `unauthenticated` | Missing/expired auth token | "Please log in again" |
| `permission-denied` | Not a member, blocked, wrong role | "You don't have permission to do this" |
| `not-found` | Entity doesn't exist | "This [item] was not found" |
| `failed-precondition` | Wrong state (expired, closed, already actioned) | Context-specific: "This gift has expired", "This spray is no longer active" |
| `invalid-argument` | Bad input (amount < min, missing fields) | Context-specific: "Minimum amount is 10 tokens" |
| `resource-exhausted` | Rate limited (reports: 5/hour) | "Too many attempts. Please try again later." |
| `already-exists` | Duplicate (member already invited) | "This person is already a member" |
| `aborted` | Transaction conflict (retry) | Auto-retry 3x, then "Something went wrong. Please try again." |

**Client-side error handler (in each repository impl):**
```dart
Either<Failure, T> _handleCloudFunctionError(FirebaseFunctionsException e) {
  switch (e.code) {
    case 'unauthenticated': return Left(AuthFailure(message: 'Please log in again'));
    case 'permission-denied': return Left(PermissionFailure(message: e.message ?? 'Permission denied'));
    case 'not-found': return Left(NotFoundFailure(message: e.message ?? 'Not found'));
    case 'failed-precondition': return Left(PreconditionFailure(message: e.message ?? 'Action not available'));
    default: return Left(ServerFailure(message: e.message ?? 'Something went wrong'));
  }
}
```

---

## 37. Account Deletion — Comprehensive Fix

**Context:** The account deletion pseudocode in Section 33.7 has several gaps identified by the end-to-end flow and edge case reviews. This section provides the corrected, complete specification.

### 37.1 Firestore Transaction Limit

**Problem:** Message anonymization (setting senderName to "Deleted User") can affect 500+ message docs, exceeding Firestore's 500-doc transaction limit.

**Solution — Two-Phase Deletion:**

**Phase 1 (Atomic Transaction):** Handle financial operations + membership removal (limited to ~100 docs max):
- Gift refunds (sender + recipient)
- Spray closure/payout
- Token request declining
- Community membership removal
- User doc soft-delete
- E2EE key cleanup

**Phase 2 (Background Job):** Message anonymization as a background Cloud Function:
- `anonymizeDeletedUserMessages` triggered by user doc `status` changing to `deleted`
- Uses batched writes (500 per batch) across all conversations/communities
- Idempotent: checks `senderName !== 'Deleted User'` before updating
- Rate-limited: 1 batch per second to stay within Firestore limits

### 37.2 Gift Recipient Deletion

**Problem:** Section 33.7 only handles gifts where the deleted user is the SENDER. Gifts where the deleted user is the RECIPIENT are not addressed.

**Fix — Add to Phase 1 transaction:**
```typescript
// STEP 2b: Handle gifts where user is RECIPIENT
const recipientGifts = await transaction.get(
  db.collection('gifts')
    .where('recipientId', '==', userId)
    .where('status', 'in', ['pending', 'opened'])
);
for (const giftDoc of recipientGifts.docs) {
  const gift = giftDoc.data();
  // Expire gift → refund SENDER (not the deleted user)
  transaction.update(giftDoc.ref, { status: 'expired', deletedAt: serverTimestamp() });
  // Refund from GIFT_ESCROW → user:{senderId}
  await processGiftRefund(gift.senderId, gift.amount, gift.id, transaction);
}
```

### 37.3 Spray Payout to Deleted User — Balance Disposal

**Problem:** Spray payout credits the recipient BEFORE account deletion, but those tokens are effectively lost when the account is soft-deleted.

**Fix:** Do NOT payout active sprays to the deleted user. Instead:
```typescript
// STEP 3: Handle sprays where user is RECIPIENT
const recipientSprays = await transaction.get(
  db.collection('tokenSprays')
    .where('recipientId', '==', userId)
    .where('status', '==', 'active')
);
for (const sprayDoc of recipientSprays.docs) {
  const spray = sprayDoc.data();
  // Close spray but REFUND all contributors from SPRAY_ESCROW
  transaction.update(sprayDoc.ref, {
    status: 'closed',
    autoExpired: true,
    closedAt: serverTimestamp(),
    recipientDeleted: true,
  });
  // Refund each contributor proportionally
  for (const [contributorId, contribution] of Object.entries(spray.contributions)) {
    await processSprayRefund(contributorId, contribution.amount, spray.id, transaction);
  }
}
```

### 37.4 Remaining Wallet Balance

**Problem:** After gift refunds and spray handling, the user may have a positive token balance that is effectively abandoned.

**Fix:**
```typescript
// STEP 7 (before soft-delete): Transfer remaining balance to CBOOK_BUS (platform revenue)
const userBalance = await getUserBalance(userId, transaction);
if (userBalance > 0) {
  await processAccountDeletionBalanceTransfer(userId, userBalance, transaction);
  // Journal: user:{userId} → CBOOK_BUS, type: 'account_closure'
}
```

Add to `types.ts`: new `JournalType` entry `account_closure` and `referenceType` entry `"account_deletion"`.

### 37.5 Token Request Cleanup

**Problem (RC-8):** Pending token requests where the deleted user is the recipient remain in limbo forever.

**Fix — Add to Phase 1:**
```typescript
// STEP 2c: Decline all pending token requests where user is recipient
// Query all conversations where user is participant
for (const convId of user.conversationIds || []) {
  const pendingRequests = await transaction.get(
    db.collection('conversations').doc(convId).collection('messages')
      .where('type', '==', 'tokenRequest')
      .where('recipientId', '==', userId)
      .where('status', '==', 'sent')
  );
  for (const reqDoc of pendingRequests.docs) {
    transaction.update(reqDoc.ref, {
      status: 'declined',
      actionedAt: serverTimestamp(),
    });
  }
}
```

### 37.6 E2EE Key Cleanup

**Problem:** User's key bundle at `/users/{userId}/keys/bundle` is left orphaned. Other users attempting X3DH will fetch stale keys.

**Fix — Add to Phase 1:**
```typescript
// STEP 6b: Clean up E2EE keys
// Delete key bundle (prevents stale X3DH attempts)
transaction.delete(db.collection('users').doc(userId).collection('keys').doc('bundle'));
// Delete backup metadata (if exists)
transaction.delete(db.collection('users').doc(userId).collection('keys').doc('backup'));
// Note: Google Drive backup file is NOT cleaned up (user's responsibility)
```

### 37.7 Conversation Handling

**Problem:** P2P conversations where the deleted user is a participant are not addressed.

**Fix:** Leave conversations in place but update the participant info:
```typescript
// STEP 6c: Update conversation participant info
for (const convId of user.conversationIds || []) {
  transaction.update(db.collection('conversations').doc(convId), {
    [`participants.${userId}.displayName`]: 'Deleted User',
    [`participants.${userId}.avatarUrl`]: null,
  });
}
// Conversations remain visible to the other participant with "Deleted User" as the contact name.
// The other participant can still read old messages (if they have the decryption keys).
// They cannot send new messages (Cloud Functions check if participant is active).
```

### 37.8 Sender Key Re-key on Deletion

Account deletion triggers the same re-key protocol as member removal (Section 35.3):
- For each community the deleted user was a member of, the `onCommunityMemberRemoved` trigger fires
- All remaining members generate new Sender Keys
- The deleted user's old keys cannot decrypt future messages

### 37.9 Permanent Purge Scheduling

**Problem:** "Schedule permanent purge after 30 days" has no implementation.

**Solution:** Use a scheduled Cloud Function:

```typescript
// In index.ts scheduled jobs:
exports.purgeDeletedAccounts = functions.pubsub
  .schedule('every 24 hours')
  .onRun(async () => {
    const cutoff = Timestamp.fromDate(subtractDays(new Date(), 30));
    const deletedUsers = await db.collection('users')
      .where('status', '==', 'deleted')
      .where('deletedAt', '<=', cutoff)
      .limit(100)  // Process in batches
      .get();

    for (const userDoc of deletedUsers.docs) {
      // Permanently delete: user doc, all subcollections, Cloud Storage files
      await permanentlyPurgeUser(userDoc.id);
    }
  });
```

---

## 38. Partial Media Upload Cleanup

**Problem (ERR-3):** The signed URL upload flow (Section 32.1) can leave orphaned encrypted blobs in Cloud Storage if the upload succeeds but the subsequent message creation fails, or if the upload is interrupted.

### 38.1 Cleanup Scheduled Job

```typescript
// functions/src/mediaCleanup.ts (~100 lines)
exports.cleanupOrphanedMedia = functions.pubsub
  .schedule('every 24 hours')
  .onRun(async () => {
    // List all files in conversations/ and communities/ storage paths
    // For each .enc file older than 24 hours:
    //   Check if a message doc references this file URL
    //   If no message references it → delete the orphaned file
    // Rate limit: 100 files per run to stay within function timeout
  });
```

### 38.2 Client-Side Retry with Resumable Uploads

For images > 1MB, use Cloud Storage resumable uploads:
- `generateSignedUploadUrl` Cloud Function returns a resumable upload URI
- Client uploads in 256KB chunks
- On interruption: resume from last successful chunk on next attempt
- After 15 minutes, signed URL expires → client must request a new one

---

## 39. Updated File Inventory (v3.4)

### New Flutter Files (68 total, +5 from v3.3)

**Domain (19):** Same as v3.3
**Data (13):** Same as v3.3
**BLoC (15):** Same as v3.3
**Screens (14):** Same as v3.3
**Widgets (12):** Same as v3.3
**Services (4, +1):** chat_analytics_service, share_service, deep_link_service, **app_event_bus**
**Admin (1, +1):** **community_management_screen.dart**

### New Cloud Function Files (9 total, +1 from v3.3)

| File | Lines | Phase |
|------|-------|-------|
| `functions/src/conversations.ts` | ~700 (+100: pin/mute/archive/block/unblock/delete CFs, key distribution CFs) | 1 |
| `functions/src/communities.ts` | ~1900 (+100: declineInvitation, blockMember, submitReport CFs) | 1 |
| `functions/src/helpers/communityHelpers.ts` | ~200 (+50: sendSystemMessage helper) | 1 |
| `functions/src/messagingNotifications.ts` | ~200 | 2 |
| `functions/src/gifts.ts` | ~500 | 3 |
| `functions/src/tokenSprays.ts` | ~600 | 3 |
| `functions/src/giftNotifications.ts` | ~150 | 3 |
| `functions/src/sprayNotifications.ts` | ~150 | 3 |
| `functions/src/mediaCleanup.ts` | ~100 (NEW) | 4 |

### Files to Modify (15 total, +3 from v3.3)

| File | Change | Priority |
|------|--------|----------|
| `lib/presentation/router/app_router.dart` | Replace Chat tab routes, remove `/groups`, add gift/spray/QR routes | CRITICAL |
| `lib/app.dart` | Replace ChatBloc with ConversationBloc + CommunityBloc + GiftBloc | CRITICAL |
| `lib/presentation/widgets/common/bottom_nav_bar.dart` | Unified unread badge via AppEventBus | CRITICAL |
| `functions/src/index.ts` | Add exports for all new Cloud Function files + scheduled jobs | CRITICAL |
| `firestore.rules` | Add rules for conversations, communities, gifts, tokenSprays, keyDistribution, reports | CRITICAL |
| `functions/src/ledger/types.ts` | SystemAccounts, JournalType, referenceType, IdempotencyKey additions | CRITICAL |
| `functions/src/ledger/index.ts` | Add `overrideIdempotencyKey` param to `processP2PTransfer()` | HIGH |
| `functions/src/ledger/accounts.ts` | Add GIFT_ESCROW + SPRAY_ESCROW to `initializeSystemAccounts()` | CRITICAL |
| `functions/src/ledger/giftAccounts.ts` | NEW FILE: gift/spray ledger functions (accept transaction param) | CRITICAL |
| `functions/src/adminAccounts.ts` | Add 12 admin Cloud Functions for community/report/gift/spray management | CRITICAL |
| `functions/src/adminAuth.ts` | Add 13 AdminPermission entries + update role permission arrays | CRITICAL |
| `lib/presentation/admin/router/admin_router.dart` | Add `/communities` route | HIGH |
| `lib/presentation/admin/shell/admin_shell.dart` | Add sidebar entry + routeRoles for communities | HIGH |
| `lib/presentation/admin/screens/ledger_recon_screen.dart` | Update "Groups" → "Communities" labels + add escrow balance rows | MEDIUM |
| `lib/presentation/blocs/auth/auth_bloc.dart` | Add E2EE key generation event on registration success | HIGH |

### New Firestore Collections/Subcollections (v3.4 additions)

| Collection | Purpose |
|------------|---------|
| `/communities/{id}/keyDistribution/{id}` | Encrypted Sender Key distribution messages |
| `/communities/{id}/keyDistributionRequests/{id}` | Trigger mechanism for Sender Key distribution |
| `/reports/{id}` | User-submitted reports (validated via CF, not direct writes) |
| `/idempotencyKeys/{id}` | Idempotency tracking for financial operations |

---

## 40. Updated Verification Checklist (v3.4 Additions)

### State Machine Completeness
- [ ] Message status: sending → sent/failed, failed → sending (retry), sent → paid/declined (tokenRequest only)
- [ ] CommunityMember: invited → active/[deleted], active → blocked/[deleted], blocked → active/[deleted]
- [ ] CommunityTransaction: pending → completed (fast-path) OR pending → approved → completed, pending → rejected/expired
- [ ] Spray: ONLY 3 states (active, closed, claimed) — `expired` REMOVED from SprayStatus enum
- [ ] Gift: `expireGifts` queries `status in ['pending', 'opened']` (not just 'pending')

### Transaction Atomicity
- [ ] `sendGift` uses `db.runTransaction()` wrapping idempotency check + ledger debit + gift/message creation
- [ ] `contributeToSpray` passes `tx` transaction object to `processSprayContributionDebit()` — no nested transactions
- [ ] All ledger functions in `giftAccounts.ts` accept optional `transaction` parameter
- [ ] `openGift` uses Firestore transaction (prevents concurrent double-open — RC-13)

### Admin Portal
- [ ] 12 admin Cloud Functions in `adminAccounts.ts` compile and pass Jest tests
- [ ] 13 AdminPermission entries added to `adminAuth.ts` with correct role assignments
- [ ] `submitReport` CF validates, rate-limits, and deduplicates reports
- [ ] Community Management Screen loads and displays community list

### Sender Key Distribution
- [ ] `distributeSenderKey` CF writes to `keyDistribution` subcollection
- [ ] `markKeyDistributionConsumed` CF sets consumed=true
- [ ] Snapshot listener on `keyDistributionRequests` fires for existing members when new member joins
- [ ] Snapshot listener on `keyDistribution` fires for new member when Sender Keys arrive
- [ ] Re-key triggers on member removal (leaveCommunity, removeMember, account deletion)
- [ ] Offline members lazy-distribute on next app launch

### Cross-BLoC Communication
- [ ] `AppEventBus` is `@singleton` in DI
- [ ] All financial BLoC handlers fire `WalletBalanceChanged` after success
- [ ] WalletBloc subscribes to `AppEventBus` and refreshes on `WalletBalanceChanged`
- [ ] All BLoC handlers reset `isSending`/`isClaiming`/`isContributing` on BOTH success and error

### Account Deletion
- [ ] Two-phase deletion: atomic transaction (financial) + background job (message anonymization)
- [ ] Gift recipient deletion: refunds sender from GIFT_ESCROW
- [ ] Spray recipient deletion: refunds all contributors (NOT payout to deleted user)
- [ ] Token request cleanup: declines all pending requests where deleted user is recipient
- [ ] E2EE key bundle and backup metadata deleted
- [ ] Conversation participant info updated to "Deleted User"
- [ ] Remaining wallet balance transferred to CBOOK_BUS
- [ ] `purgeDeletedAccounts` scheduled job cleans up after 30 days
- [ ] Sender Key re-key triggers for all communities the user was in

### Error Handling
- [ ] Every Cloud Function returns standardized gRPC error codes
- [ ] Flutter repository impls map error codes to typed `Failure` subclasses
- [ ] BLoC UI shows context-specific error messages (not generic "Something went wrong")
- [ ] Rate limiting on `submitReport` (5/hour per user) works correctly

### Media Cleanup
- [ ] `cleanupOrphanedMedia` scheduled job runs daily
- [ ] Orphaned .enc files older than 24h with no message reference are deleted
- [ ] Resumable upload support for images > 1MB
