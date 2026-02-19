# iMaliChat - Chat & Communities Feature
## Complete Implementation Specification

**Version:** 1.0  
**Date:** February 16, 2026  
**Document Size:** Part 1 of 2

---

## Executive Summary

This document provides complete technical specifications for iMaliChat's Chat & Communities feature, including:
- **Messages:** 1-on-1 direct conversations
- **Communities:** Private group chats (Regular + Stokvel types)
- **iMali Gifts:** Token transfers with celebrations
- **Token Spray:** Group celebration gifting

**Key Principles:**
✓ Simple, focused, privacy-first design
✓ All communities private and invite-only
✓ All members see all messages (no channels/subgroups)
✓ Token economy integrated throughout

---

## Table of Contents

### PART 1 (This Document)
1. Feature Overview
2. Firebase Schema (Complete)
3. Flutter Architecture
4. Messages Feature (Direct Chat)
5. Communities Feature (Regular)
6. Communities Feature (Stokvel)

### PART 2 (Companion Document)
7. iMali Gift Integration
8. Token Spray Feature
9. Notifications System
10. Security & Privacy
11. Implementation Phases
12. Code Examples

---

## 1. Feature Overview

### 1.1 Structure

```
Chat Tab (Bottom Navigation)
├─── 💬 Messages (Direct 1-on-1 only)
└─── 👥 Communities (Private groups)
     ├─── Regular Communities (any purpose)
     └─── Stokvel Communities (+ financial tracking)
```

### 1.2 Design Philosophy

**What This IS:**
- Simple messaging for token economy
- Private communities for savings & interests
- Ubuntu-aligned (community-focused)
- Stokvel management tool

**What This Is NOT:**
- Social network with public feeds
- WhatsApp replacement
- Complex enterprise chat system
- Friend graph / social discovery platform

**Scope Boundaries:**
```yaml
Included:
✓ Direct messages (1-on-1)
✓ Private communities (invite-only)
✓ Group chat (all members equal)
✓ Media sharing (images, voice)
✓ iMali Gifts integration
✓ Token Spray celebrations
✓ Stokvel financial tracking

Deliberately Excluded:
✗ Small group chats in Messages tab
✗ Public/discoverable communities
✗ Channels/subgroups within communities
✗ Admin-only announcements
✗ Threaded conversations
✗ Message editing
✗ Read receipts
✗ Typing indicators
✗ Friend lists/suggestions
```

---

## 2. Firebase Schema

### 2.1 Collections Overview

```javascript
Firestore Structure:
/users                    // Extended with chat fields
/conversations            // Direct messages (1-on-1)
  └─ /messages            // Subcollection per conversation
/communities              // All groups (regular + stokvel)
  └─ /messages            // Subcollection per community
/gifts                    // iMali Gift transactions
/tokenSprays              // Group celebration events

Cloud Storage:
/users/{userId}/profile-pictures/
/conversations/{id}/media/
/communities/{id}/media/
```

### 2.2 User Document Schema

```javascript
/users/{userId}
{
  // Existing core fields
  id: string
  displayName: string
  email: string
  phoneNumber: string
  profilePicUrl: string
  profilePicThumbUrl: string
  createdAt: timestamp
  updatedAt: timestamp
  
  // Chat additions
  chat: {
    status: "online" | "offline" | "away"
    lastSeen: timestamp
    blockedUserIds: [string]  // Users blocked by this user
  }
  
  // References (for quick access)
  conversationIds: [string]   // Direct conversations
  communityIds: [string]      // Communities user belongs to
  
  // Notification preferences
  notificationSettings: {
    allMessages: boolean              // Default: true
    mentionsOnly: boolean             // Default: false
    mutedConversationIds: [string]
    mutedCommunityIds: [string]
    quietHoursStart: string | null    // "22:00"
    quietHoursEnd: string | null      // "07:00"
  }
  
  // Stats (for gamification)
  stats: {
    totalMessagesSent: number
    totalGiftsSent: number
    totalGiftsReceived: number
    communitiesCreated: number
    stokvelsJoined: number
  }
}
```

### 2.3 Conversations Collection

```javascript
/conversations/{conversationId}
{
  id: string                    // Auto-generated Firestore ID
  type: "direct"                // Always "direct" for 1-on-1
  
  // Participants (always exactly 2 for direct)
  participantIds: [userId1, userId2]
  
  // Denormalized participant data (for performance)
  participants: {
    [userId1]: {
      displayName: string
      avatarThumbUrl: string | null
      joinedAt: timestamp
    }
    [userId2]: {
      displayName: string
      avatarThumbUrl: string | null
      joinedAt: timestamp
    }
  }
  
  // Last message (for list preview)
  lastMessage: {
    text: string               // Truncated to 100 chars
    senderId: string
    senderName: string
    type: "text" | "image" | "voice" | "gift" | "system"
    timestamp: timestamp
  }
  lastMessageAt: timestamp     // Duplicate for sorting index
  
  // Metadata
  createdAt: timestamp
  createdBy: string            // userId who initiated
  
  // Per-user state (denormalized for performance)
  unreadCount: {
    [userId1]: number
    [userId2]: number
  }
  
  // User-specific settings
  archived: {
    [userId1]: boolean
    [userId2]: boolean
  }
  
  pinned: {
    [userId1]: boolean
    [userId2]: boolean
  }
}
```

**Required Indexes:**
```yaml
conversations:
  - participantIds (array-contains) + lastMessageAt (desc)
  - participantIds (array-contains) + type + lastMessageAt (desc)
```

### 2.4 Messages Subcollection

```javascript
/conversations/{conversationId}/messages/{messageId}
{
  id: string                     // Auto-generated
  conversationId: string         // Denormalized parent ID
  
  // Sender
  senderId: string
  senderName: string             // Display name at send time
  senderAvatarThumbUrl: string | null
  
  // Content
  type: "text" | "image" | "voice" | "gift" | "system"
  text: string | null            // Message text (null if media-only)
  
  // Media (images/voice)
  media: {
    url: string                  // Cloud Storage download URL
    thumbnailUrl: string | null  // For images only
    fileName: string
    fileSize: number             // Bytes
    mimeType: string             // "image/jpeg", "audio/m4a", etc.
    duration: number | null      // Seconds (voice only)
    width: number | null         // Pixels (images only)
    height: number | null        // Pixels (images only)
  } | null
  
  // Gift data (if type = "gift")
  gift: {
    giftId: string               // Reference to /gifts/{giftId}
    amount: number               // Token amount
    message: string              // Personal message
    style: "ndlovukazi" | "celebration" | "love" | "birthday" | "professional"
    status: "pending" | "opened" | "claimed" | "expired"
  } | null
  
  // Reply/thread
  replyTo: {
    messageId: string
    senderName: string
    text: string                 // Truncated preview (50 chars)
    type: string
  } | null
  
  // Reactions
  reactions: {
    "❤️": [userId1, userId2],
    "👍": [userId3],
    "😂": [userId4, userId5, userId6]
    // Max 6 emoji types per message
  }
  
  // Status
  status: "sending" | "sent" | "failed"
  
  // Timestamps
  createdAt: timestamp
  updatedAt: timestamp | null    // Only if edited (future feature)
  
  // Deletion
  deletedFor: [string]           // UserIds who deleted for themselves
  deletedForEveryone: boolean    // Sender deleted for all (within 1 hour)
  deletedAt: timestamp | null
}
```

**Required Indexes:**
```yaml
messages (subcollection):
  - conversationId + createdAt (asc)
  - conversationId + createdAt (desc)
```

### 2.5 Communities Collection

```javascript
/communities/{communityId}
{
  id: string
  type: "regular" | "stokvel"
  
  // Basic info
  name: string                   // Max 50 chars
  description: string | null     // Max 200 chars
  icon: string                   // Emoji or "custom"
  imageUrl: string | null        // Custom uploaded image
  imageThumbUrl: string | null
  
  // Membership
  memberIds: [string]            // All members (2-100)
  memberCount: number            // Denormalized
  adminIds: [string]             // Creator + promoted admins
  createdBy: string              // Creator userId
  
  // Member details (denormalized for UI performance)
  members: {
    [userId]: {
      displayName: string
      avatarThumbUrl: string | null
      role: "admin" | "member"
      joinedAt: timestamp
      lastReadAt: timestamp      // For unread tracking
    }
  }
  
  // Last message
  lastMessage: {
    text: string
    senderId: string
    senderName: string
    type: string
    timestamp: timestamp
  }
  lastMessageAt: timestamp
  
  // Unread counts (map scales better than nested fields)
  unreadCounts: {
    [userId]: number
  }
  
  // Timestamps
  createdAt: timestamp
  updatedAt: timestamp
  
  // Settings
  settings: {
    allowMemberInvites: boolean        // Default: true
    onlyAdminsPost: boolean            // Default: false
    membersCanShareMedia: boolean      // Default: true
    notifyOnMessage: boolean           // Default: true
  }
  
  // Stokvel-specific (null if type = "regular")
  stokvel: {
    // Financial configuration
    contributionAmount: number         // In Rands
    currency: "ZAR"
    frequency: "weekly" | "monthly"
    
    // Payout configuration
    payoutOrder: "rotating" | "random" | "by_contribution"
    payoutSchedule: [userId1, userId2, ...]  // Ordered list
    currentPayoutIndex: number         // Which member receives next
    nextPayoutDate: timestamp
    startDate: timestamp               // First cycle start
    
    // Current cycle tracking
    currentCycle: {
      cycleNumber: number              // Increment each cycle
      startDate: timestamp
      endDate: timestamp
      recipientId: string              // Who receives this cycle
      recipientName: string
      targetAmount: number             // Expected total
      
      // Per-member contribution status
      contributions: {
        [userId]: {
          amount: number               // Expected amount
          status: "paid" | "pending" | "overdue"
          paidAt: timestamp | null
          paidBy: string | null        // Admin who marked paid
          paymentMethod: "manual" | "token" | "bank" | null
          paymentReference: string | null
          notes: string | null
        }
      }
    }
    
    // Historical tracking
    totalCyclesCompleted: number
    totalContributed: number           // All-time in Rands
    completedCycles: [
      {
        cycleNumber: number
        recipientId: string
        recipientName: string
        amount: number
        completedAt: timestamp
      }
    ] // Last 5 cycles only
    
    // Rules
    rules: {
      latePenaltyAmount: number | null
      latePenaltyDays: number | null   // Days after due date
      maxMissedPayments: number        // Before removal
      allowPartialPayments: boolean
    }
  } | null
}
```

**Required Indexes:**
```yaml
communities:
  - memberIds (array-contains) + lastMessageAt (desc)
  - type + memberIds (array-contains) + lastMessageAt (desc)
  - memberIds (array-contains) + type + createdAt (desc)
```

### 2.6 Community Messages Subcollection

```javascript
/communities/{communityId}/messages/{messageId}
{
  // Same base structure as conversation messages, plus:
  
  id: string
  communityId: string            // Denormalized parent
  
  senderId: string
  senderName: string
  senderAvatarThumbUrl: string | null
  
  type: "text" | "image" | "voice" | "gift" | "token_spray" | "system"
  text: string | null
  media: { ... } | null
  
  // Community-specific: Gift to specific member
  gift: {
    giftId: string
    recipientId: string          // Which member receives
    recipientName: string
    amount: number
    message: string
    style: string
    status: string
  } | null
  
  // Community-specific: Token Spray
  tokenSpray: {
    sprayId: string              // Reference to /tokenSprays/{id}
    recipientId: string          // Celebrant
    recipientName: string
    occasion: string             // "new_job", "birthday", etc.
    currentTotal: number         // Live-updating total
    contributorCount: number
    status: "active" | "closed" | "claimed"
    targetAmount: number | null
    expiresAt: timestamp         // Auto-close after 24h
  } | null
  
  replyTo: { ... } | null
  reactions: { ... }
  
  status: string
  createdAt: timestamp
  updatedAt: timestamp | null
  
  deletedFor: [string]
  deletedForEveryone: boolean
  deletedAt: timestamp | null
}
```

### 2.7 Gifts Collection

```javascript
/gifts/{giftId}
{
  id: string
  
  // Transaction participants
  senderId: string
  senderName: string
  recipientId: string
  recipientName: string
  amount: number                 // Tokens
  
  // Context (where gift was sent)
  conversationId: string | null  // If in direct message
  communityId: string | null     // If in community
  messageId: string              // Associated message ID
  
  // Presentation
  message: string                // Personal message (max 100 chars)
  style: "ndlovukazi" | "celebration" | "love" | "birthday" | "professional"
  
  // Status tracking
  status: "pending" | "opened" | "claimed" | "expired"
  
  // Timestamps
  createdAt: timestamp
  openedAt: timestamp | null     // When recipient tapped "open"
  claimedAt: timestamp | null    // When tokens transferred
  expiresAt: timestamp           // 7 days from creation
  
  // Accounting (references to wallet transactions)
  debitTransactionId: string     // Sender's wallet debit
  creditTransactionId: string | null  // Recipient's credit (when claimed)
  
  // Metadata
  notificationSent: boolean
  reminderSent: boolean          // Reminder 2 days before expiry
}
```

### 2.8 Token Sprays Collection

```javascript
/tokenSprays/{sprayId}
{
  id: string
  
  // Community context
  communityId: string
  communityName: string
  messageId: string              // Associated message in community
  
  // Celebration details
  creatorId: string              // Who started spray
  creatorName: string
  recipientId: string            // Celebrant
  recipientName: string
  occasion: "new_job" | "birthday" | "graduation" | "new_baby" | "wedding" | "achievement" | "custom"
  occasionText: string           // Display text
  message: string                // Celebration message (max 200 chars)
  
  // Financial tracking
  targetAmount: number | null    // Optional target
  currentTotal: number           // Sum of all contributions
  
  // Contributors (map for scale)
  contributions: {
    [userId]: {
      amount: number
      contributedAt: timestamp
      displayName: string
      message: string | null     // Optional contributor message
    }
  }
  contributorCount: number       // Denormalized
  
  // Leaderboard (top 5 for display)
  topContributors: [
    {
      userId: string
      displayName: string
      amount: number
      rank: number               // 1-5
    }
  ]
  
  // Status
  status: "active" | "closed" | "claimed" | "expired"
  
  // Timestamps
  createdAt: timestamp
  closedAt: timestamp | null     // Manual or auto-close
  claimedAt: timestamp | null    // When recipient claimed
  expiresAt: timestamp           // Auto-close after 24 hours
  
  // Accounting
  debitTransactionIds: [string]  // All contributor debits
  creditTransactionId: string | null  // Recipient credit
  
  // Notifications
  notificationsSent: {
    created: boolean
    reminders: [timestamp]       // When reminders sent
    closed: boolean
  }
}
```

### 2.9 Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper functions
    function isAuthenticated() {
      return request.auth != null;
    }
    
    function isUser(userId) {
      return request.auth.uid == userId;
    }
    
    function isConversationParticipant(conversation) {
      return request.auth.uid in conversation.participantIds;
    }
    
    function isCommunityMember(community) {
      return request.auth.uid in community.memberIds;
    }
    
    function isCommunityAdmin(community) {
      return request.auth.uid in community.adminIds;
    }
    
    // Users
    match /users/{userId} {
      allow read: if isAuthenticated();
      allow update: if isUser(userId);
    }
    
    // Conversations
    match /conversations/{conversationId} {
      allow read: if isAuthenticated() && 
                     isConversationParticipant(resource.data);
      allow create: if isAuthenticated() && 
                       isConversationParticipant(request.resource.data);
      allow update: if isAuthenticated() && 
                       isConversationParticipant(resource.data);
    }
    
    // Conversation Messages
    match /conversations/{conversationId}/messages/{messageId} {
      allow read: if isAuthenticated() && 
                     isConversationParticipant(
                       get(/databases/$(database)/documents/conversations/$(conversationId)).data
                     );
      allow create: if isAuthenticated() && 
                       request.resource.data.senderId == request.auth.uid;
      allow update: if isAuthenticated() && 
                       resource.data.senderId == request.auth.uid;
      allow delete: if isAuthenticated() && 
                       resource.data.senderId == request.auth.uid;
    }
    
    // Communities
    match /communities/{communityId} {
      allow read: if isAuthenticated() && 
                     isCommunityMember(resource.data);
      allow create: if isAuthenticated() && 
                       request.auth.uid in request.resource.data.adminIds;
      allow update: if isAuthenticated() && 
                       isCommunityAdmin(resource.data);
      allow delete: if isAuthenticated() && 
                       request.auth.uid == resource.data.createdBy;
    }
    
    // Community Messages
    match /communities/{communityId}/messages/{messageId} {
      allow read: if isAuthenticated() && 
                     isCommunityMember(
                       get(/databases/$(database)/documents/communities/$(communityId)).data
                     );
      allow create: if isAuthenticated() && 
                       request.resource.data.senderId == request.auth.uid &&
                       isCommunityMember(
                         get(/databases/$(database)/documents/communities/$(communityId)).data
                       );
      allow update: if isAuthenticated() && 
                       resource.data.senderId == request.auth.uid;
      allow delete: if isAuthenticated() && 
                       (resource.data.senderId == request.auth.uid ||
                        isCommunityAdmin(
                          get(/databases/$(database)/documents/communities/$(communityId)).data
                        ));
    }
    
    // Gifts (read-only for clients)
    match /gifts/{giftId} {
      allow read: if isAuthenticated() && 
                     (resource.data.senderId == request.auth.uid ||
                      resource.data.recipientId == request.auth.uid);
      // Create/update handled by Cloud Functions only
    }
    
    // Token Sprays (read-only for clients)
    match /tokenSprays/{sprayId} {
      allow read: if isAuthenticated() && 
                     isCommunityMember(
                       get(/databases/$(database)/documents/communities/$(resource.data.communityId)).data
                     );
      // Create/update handled by Cloud Functions only
    }
  }
}
```

---

## 3. Flutter Architecture

### 3.1 Clean Architecture Layers

```
Presentation Layer (UI)
    ↓
Domain Layer (Business Logic)
    ↓
Data Layer (Repositories & Data Sources)
```

### 3.2 Folder Structure

```dart
lib/
├── features/
│   └── chat/
│       ├── data/
│       │   ├── models/           // Data models (Firestore ↔ Dart)
│       │   ├── repositories/     // Repository implementations
│       │   └── datasources/      // Firebase/Storage access
│       ├── domain/
│       │   ├── entities/         // Business entities
│       │   ├── repositories/     // Repository interfaces
│       │   └── usecases/         // Business logic
│       └── presentation/
│           ├── providers/        // Riverpod state management
│           ├── screens/          // Full-screen pages
│           └── widgets/          // Reusable components
```

Full detailed structure continued in Part 2 document.

---

## 4. Messages Feature (Direct Chat)

[Content truncated for file size - see Part 2]

---

## 5. Communities Feature (Regular)

[Content truncated for file size - see Part 2]

---

## 6. Communities Feature (Stokvel)

[Content truncated for file size - see Part 2]

---

**END OF PART 1**

See companion document: `chat_communities_spec_part2.md` for:
- iMali Gift Integration
- Token Spray Feature
- Notifications System
- Security & Privacy
- Implementation Phases
- Complete Code Examples

