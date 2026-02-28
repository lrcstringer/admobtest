# Voice & Video Calling Implementation Plan (Revised)

## Table of Contents

1. [Overview](#1-overview)
2. [Technology Stack](#2-technology-stack)
3. [Firestore Data Model](#3-firestore-data-model)
4. [Cloud Functions (Backend)](#4-cloud-functions-backend)
5. [Signaling Flow](#5-signaling-flow)
6. [Platform Configuration](#6-platform-configuration)
7. [Flutter Architecture (Clean Architecture)](#7-flutter-architecture-clean-architecture)
8. [WebRTC Service](#8-webrtc-service)
9. [Call Signaling Service](#9-call-signaling-service)
10. [Call State Machine (CallBloc)](#10-call-state-machine-callbloc)
11. [Incoming Call Handling](#11-incoming-call-handling)
12. [Call Screens (UI)](#12-call-screens-ui)
13. [Quality Monitoring & Adaptive Bitrate](#13-quality-monitoring--adaptive-bitrate)
14. [Reconnection & Error Handling](#14-reconnection--error-handling)
15. [Voice-to-Video Upgrade](#15-voice-to-video-upgrade)
16. [System Message Rendering](#16-system-message-rendering)
17. [Firestore Security Rules](#17-firestore-security-rules)
18. [Router Integration](#18-router-integration)
19. [Cleanup & Lifecycle](#19-cleanup--lifecycle)
20. [Testing Strategy](#20-testing-strategy)
21. [Future: Group Calls](#21-future-group-calls)
22. [Implementation Phases](#22-implementation-phases)

---

## 1. Overview

Add 1:1 voice and video calling to iMaliChat using WebRTC for peer-to-peer media
transport and Firestore as the signaling channel. No additional servers are needed
beyond a TURN relay for NAT traversal fallback.

### Key Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Media transport | WebRTC (P2P) | Direct peer-to-peer, lowest latency, free bandwidth |
| Signaling channel | Firestore | Already in the stack, real-time listeners, no new server |
| Stream encryption | DTLS-SRTP | Built into WebRTC, mandatory, zero config, hardware-accelerated |
| Native call UI | `flutter_callkit_incoming` | CallKit (iOS) + full-screen notification (Android), actively maintained |
| TURN provider | Cloudflare TURN | 1 TB/month free tier, $0.05/GB after, global edge |
| Audio codec | Opus | WebRTC default, 24-32 kbps, built-in DTX + FEC |
| Video codec | H.264 preferred, VP8 fallback | Hardware acceleration on both iOS and Android |
| Negotiation | Perfect Negotiation (single path) | All SDP exchange goes through one handler — no glare |
| Group calls (future) | LiveKit SFU | Official Flutter SDK, can self-host or use cloud |

### Bandwidth Profile

| Call Type | Bitrate | Per Minute | Notes |
|-----------|---------|------------|-------|
| Voice | 24-32 kbps | ~0.2 MB | With DTX, drops to ~1-2 kbps during silence |
| Video 480p | ~500 kbps | ~3.75 MB | Good quality on 3G/4G |
| Video 720p | ~1.5 Mbps | ~11.25 MB | Requires good 4G/WiFi |

---

## 2. Technology Stack

### Flutter Packages

```yaml
# pubspec.yaml additions
flutter_webrtc: ^1.3.1            # WebRTC engine (latest: 2026-02-25)
flutter_callkit_incoming: ^3.0.0   # Native call UI (CallKit iOS, notification Android)
wakelock_plus: ^1.2.0              # Keep screen on during calls
```

### STUN/TURN Configuration

```dart
// Production ICE server configuration
final iceServers = {
  'iceServers': [
    // Free Google STUN servers (NAT discovery)
    {'urls': 'stun:stun.l.google.com:19302'},
    {'urls': 'stun:stun1.l.google.com:19302'},
    // Cloudflare TURN (relay fallback — 1 TB/month free)
    // Credentials fetched via Cloud Function (short-lived, HMAC-signed)
    {
      'urls': [
        'turn:turn.cloudflare.com:3478?transport=udp',
        'turn:turn.cloudflare.com:3478?transport=tcp',
        'turns:turn.cloudflare.com:5349?transport=tcp',
      ],
      'username': '<short-lived-username>',  // from getTurnCredentials()
      'credential': '<short-lived-credential>',
    },
  ],
  'iceTransportPolicy': 'all',       // P2P first, TURN fallback
  'bundlePolicy': 'max-bundle',      // Multiplex audio+video on one transport
  'rtcpMuxPolicy': 'require',        // RTP+RTCP on same port
  'sdpSemantics': 'unified-plan',    // Modern standard (plan-b is deprecated)
};
```

> **Note:** `iceCandidatePoolSize` is intentionally omitted (defaults to 0). Pre-allocation
> can cause issues on iOS and provides negligible benefit for mobile-to-mobile calls.

**NAT traversal statistics (why TURN is required):**
- Residential broadband: ~85-90% P2P success (STUN only)
- Mobile cellular (CGNAT): ~60-70% P2P success
- Corporate/enterprise: ~50-60% P2P success
- **Overall: ~20-25% of calls require TURN relay**

### Cloud Function for TURN Credentials

Short-lived TURN credentials prevent credential theft. The shared secret stays
server-side; clients receive time-limited username/password pairs.

```typescript
// functions/src/calls.ts
import { onCall, HttpsError } from 'firebase-functions/v2/https';

// Cloudflare TURN credential endpoint.
// API key and token stored in Secret Manager, not hardcoded.
export const getTurnCredentials = onCall(
  { region: 'africa-south1', labels: { app: 'imalichat' } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError('unauthenticated', 'Auth required');
    }

    const keyId = process.env.CLOUDFLARE_TURN_KEY_ID;
    const apiToken = process.env.CLOUDFLARE_TURN_API_TOKEN;
    if (!keyId || !apiToken) {
      throw new HttpsError('internal', 'TURN not configured');
    }

    const response = await fetch(
      `https://rtc.live.cloudflare.com/v1/turn/keys/${keyId}/credentials/generate`,
      {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${apiToken}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ ttl: 7200 }), // 2-hour TTL (not 24h — limits abuse window)
      },
    );

    if (!response.ok) {
      throw new HttpsError('internal', 'Failed to generate TURN credentials');
    }

    const turnCreds = await response.json();
    return {
      iceServers: [
        { urls: 'stun:stun.l.google.com:19302' },
        { urls: 'stun:stun1.l.google.com:19302' },
        ...turnCreds.iceServers,
      ],
      ttl: 7200,
    };
  },
);
```

**Prerequisites:** Before Phase 1, create a Cloudflare TURN application at
`dash.cloudflare.com → Calls → TURN`. Store the Key ID and API Token in
Firebase Functions environment config or Secret Manager.

---

## 3. Firestore Data Model

### Collection: `calls/{callId}`

```
calls/{callId}
  ├── callId: string                // Auto-generated document ID
  ├── conversationId: string        // Parent conversation (p2p_user1_user2)
  ├── callerId: string              // UID of initiator
  ├── calleeId: string              // UID of recipient
  ├── callerName: string            // Denormalized for native UI when app is killed
  ├── callerAvatarUrl: string       // Denormalized for native UI
  ├── callType: string              // 'voice' | 'video'
  ├── status: string                // 'ringing' | 'active' | 'ended' | 'missed' | 'declined' | 'cancelled' | 'failed' | 'busy'
  │
  ├── offer: {                      // SDP offer (set by caller)
  │     type: 'offer',
  │     sdp: string
  │   } | null
  ├── answer: {                     // SDP answer (set by callee)
  │     type: 'answer',
  │     sdp: string
  │   } | null
  │
  ├── videoUpgradeRequest: string | null   // 'pending' | 'accepted' | 'declined' — for mid-call upgrade
  ├── videoUpgradeRequesterId: string | null
  │
  ├── callerHeartbeat: Timestamp    // Updated every 5s during active call
  ├── calleeHeartbeat: Timestamp    // Updated every 5s during active call
  ├── iceRestartCount: int          // Track ICE restart attempts
  │
  ├── createdAt: Timestamp
  ├── answeredAt: Timestamp | null
  ├── endedAt: Timestamp | null
  ├── endReason: string | null      // 'normal' | 'missed' | 'declined' | 'cancelled' | 'error' | 'peer_offline' | 'busy' | 'reconnection_failed'
  ├── durationSeconds: int | null
  ├── expireAt: Timestamp           // Firestore TTL — auto-delete after expiry
  │
  ├── callerCandidates/             // Subcollection: caller's ICE candidates
  │     {candidateId}
  │       ├── candidate: string
  │       ├── sdpMid: string
  │       ├── sdpMLineIndex: int
  │       └── createdAt: Timestamp
  │
  └── calleeCandidates/             // Subcollection: callee's ICE candidates
        {candidateId}
          ├── candidate: string
          ├── sdpMid: string
          ├── sdpMLineIndex: int
          └── createdAt: Timestamp
```

**Why subcollections for ICE candidates (not arrays):**
- Each peer writes only to their own subcollection (no write conflicts)
- `onSnapshot` with `docChanges(type: 'added')` maps directly to `pc.addIceCandidate()`
- Candidates trickle in one-by-one (10-30 per peer); subcollection handles this naturally
- No document size accumulation risk

**Firestore TTL setup (required before Phase 1):**
In the Firebase Console → Firestore → TTL Policies, create a policy on the `calls`
collection with the `expireAt` field. Documents are auto-deleted ~24h after expiry.

### No Changes to Existing `conversations` Collection

Call history is recorded as system messages in the existing chat (like WhatsApp's
"Voice call, 2:34" bubbles), using the existing `MessageType.system` +
`systemEventType: 'call_ended'` fields. No new fields on the conversation document.

---

## 4. Cloud Functions (Backend)

### File: `functions/src/calls.ts`

```typescript
import { onCall, HttpsError } from 'firebase-functions/v2/https';
import { onDocumentUpdated } from 'firebase-functions/v2/firestore';
import * as admin from 'firebase-admin';
import * as apn from 'apn';

const db = admin.firestore();

function requireAuth(request: { auth?: { uid: string } }): string {
  if (!request.auth) {
    throw new HttpsError('unauthenticated', 'User must be authenticated');
  }
  return request.auth.uid;
}

const TERMINAL_STATUSES = ['ended', 'missed', 'declined', 'cancelled', 'failed', 'busy'];
const RING_TIMEOUT_MS = 30_000; // 30 seconds

// ─── initiateCall ──────────────────────────────────────────────────────
//
// Creates a call document and sends push notifications.
// Uses a transaction to prevent duplicate active calls on the same conversation.

export const initiateCall = onCall(
  { region: 'africa-south1', labels: { app: 'imalichat' } },
  async (request) => {
    const userId = requireAuth(request);
    const { conversationId, recipientId, callType } = request.data as {
      conversationId: string;
      recipientId: string;
      callType: 'voice' | 'video';
    };

    if (!conversationId || !recipientId || !callType) {
      throw new HttpsError('invalid-argument', 'Missing required fields');
    }
    if (callType !== 'voice' && callType !== 'video') {
      throw new HttpsError('invalid-argument', 'callType must be voice or video');
    }

    // Use a transaction to atomically check for active calls + create the new one
    const callRef = db.collection('calls').doc();
    const convRef = db.collection('conversations').doc(conversationId);

    await db.runTransaction(async (tx) => {
      // Verify conversation exists and user is participant
      const convDoc = await tx.get(convRef);
      if (!convDoc.exists) {
        throw new HttpsError('not-found', 'Conversation not found');
      }
      const conv = convDoc.data()!;
      if (!conv.participantIds?.includes(userId)) {
        throw new HttpsError('permission-denied', 'Not a participant');
      }
      if (!conv.participantIds?.includes(recipientId)) {
        throw new HttpsError('invalid-argument', 'Recipient not in conversation');
      }

      // Prevent duplicate active calls on this conversation
      const activeCalls = await tx.get(
        db.collection('calls')
          .where('conversationId', '==', conversationId)
          .where('status', 'in', ['ringing', 'active'])
          .limit(1),
      );
      if (!activeCalls.empty) {
        throw new HttpsError('already-exists', 'Call already in progress');
      }

      const callerName = conv.participants?.[userId]?.displayName || 'Someone';
      const callerAvatar = conv.participants?.[userId]?.avatarUrl || '';
      const now = admin.firestore.FieldValue.serverTimestamp();

      tx.set(callRef, {
        callId: callRef.id,
        conversationId,
        callerId: userId,
        calleeId: recipientId,
        callerName,
        callerAvatarUrl: callerAvatar,
        callType,
        status: 'ringing',
        offer: null,
        answer: null,
        videoUpgradeRequest: null,
        videoUpgradeRequesterId: null,
        callerHeartbeat: now,
        calleeHeartbeat: null,
        iceRestartCount: 0,
        createdAt: now,
        answeredAt: null,
        endedAt: null,
        endReason: null,
        durationSeconds: null,
        // TTL: auto-delete after 1 hour (covers missed calls, cleanup failures)
        expireAt: admin.firestore.Timestamp.fromDate(
          new Date(Date.now() + 3600_000),
        ),
      });
    });

    // ── Send push notifications (outside transaction — fire and forget) ──

    const recipientDoc = await db.collection('users').doc(recipientId).get();
    const recipientData = recipientDoc.data();
    const callDoc = await callRef.get();
    const callData = callDoc.data()!;

    // Check if recipient has an active call (busy detection)
    const recipientActiveCalls = await db.collection('calls')
      .where('status', 'in', ['ringing', 'active'])
      .where('calleeId', '==', recipientId)
      .limit(2)
      .get();
    // If they have another active call (not ours), they're busy
    const busyCalls = recipientActiveCalls.docs.filter(d => d.id !== callRef.id);
    // We still send the notification — the recipient's app handles the busy state

    const fcmToken = recipientData?.fcmToken;
    if (fcmToken) {
      try {
        await admin.messaging().send({
          token: fcmToken,
          // Data-only message (no 'notification' field) — triggers onBackgroundMessage
          data: {
            type: 'incoming_call',
            callId: callRef.id,
            callType,
            conversationId,
            callerName: callData.callerName,
            callerId: userId,
            callerAvatar: callData.callerAvatarUrl,
          },
          android: {
            priority: 'high',  // Wake the device from Doze
            ttl: RING_TIMEOUT_MS,
          },
          apns: {
            headers: { 'apns-priority': '10' },
            payload: {
              aps: {
                contentAvailable: true,
                sound: 'ringtone.caf',
              },
            },
          },
        });
      } catch (e) {
        console.error('FCM send failed:', e);
      }
    }

    // iOS: VoIP push via APNs (only way to wake a killed iOS app for calls)
    const voipToken = recipientData?.voipToken;
    if (voipToken) {
      try {
        await sendVoipPush(voipToken, {
          callId: callRef.id,
          callerName: callData.callerName,
          handle: callData.callerName,
          type: callType === 'video' ? 1 : 0,
          conversationId,
          callerId: userId,
        });
      } catch (e) {
        console.error('VoIP push send failed:', e);
      }
    }

    // Schedule ring timeout: if still ringing after 30s, mark as missed.
    // This is handled by the client (caller's timer) AND a Firestore onUpdate
    // trigger as a server-side safety net (see cleanupStaleCalls below).

    return { success: true, callId: callRef.id };
  },
);

// ─── answerCall ─────────────────────────────────────────────────────────
//
// Server-validated call answer. Prevents answering ended/cancelled calls.

export const answerCall = onCall(
  { region: 'africa-south1', labels: { app: 'imalichat' } },
  async (request) => {
    const userId = requireAuth(request);
    const { callId } = request.data as { callId: string };

    const callRef = db.collection('calls').doc(callId);

    await db.runTransaction(async (tx) => {
      const callDoc = await tx.get(callRef);
      if (!callDoc.exists) {
        throw new HttpsError('not-found', 'Call not found');
      }
      const call = callDoc.data()!;

      if (call.calleeId !== userId) {
        throw new HttpsError('permission-denied', 'Only the callee can answer');
      }
      if (call.status !== 'ringing') {
        throw new HttpsError(
          'failed-precondition',
          `Cannot answer call in '${call.status}' state`,
        );
      }

      tx.update(callRef, {
        status: 'active',
        answeredAt: admin.firestore.FieldValue.serverTimestamp(),
        calleeHeartbeat: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    return { success: true };
  },
);

// ─── endCall ───────────────────────────────────────────────────────────
//
// Idempotent: safe to call from both peers. Only the first call writes
// the system message and sets the end fields.

export const endCall = onCall(
  { region: 'africa-south1', labels: { app: 'imalichat' } },
  async (request) => {
    const userId = requireAuth(request);
    const { callId, reason } = request.data as {
      callId: string;
      reason?: string;
    };

    const callRef = db.collection('calls').doc(callId);

    const result = await db.runTransaction(async (tx) => {
      const callDoc = await tx.get(callRef);
      if (!callDoc.exists) {
        throw new HttpsError('not-found', 'Call not found');
      }

      const call = callDoc.data()!;
      if (call.callerId !== userId && call.calleeId !== userId) {
        throw new HttpsError('permission-denied', 'Not a participant');
      }

      // Idempotent: if already in terminal state, return success without changes
      if (TERMINAL_STATUSES.includes(call.status)) {
        return { alreadyEnded: true, callData: call };
      }

      // Calculate duration
      let durationSeconds: number | null = null;
      if (call.answeredAt) {
        const answeredMs = call.answeredAt.toDate().getTime();
        durationSeconds = Math.round((Date.now() - answeredMs) / 1000);
      }

      // Determine status based on reason and call state
      const endReason = reason || 'normal';
      let status = 'ended';
      if (endReason === 'missed') status = 'missed';
      else if (endReason === 'declined') status = 'declined';
      else if (endReason === 'cancelled') status = 'cancelled';
      else if (endReason === 'busy') status = 'busy';
      else if (endReason === 'error' || endReason === 'reconnection_failed') status = 'failed';

      tx.update(callRef, {
        status,
        endedAt: admin.firestore.FieldValue.serverTimestamp(),
        endReason,
        durationSeconds,
        // Refresh TTL for cleanup
        expireAt: admin.firestore.Timestamp.fromDate(
          new Date(Date.now() + 3600_000),
        ),
      });

      return { alreadyEnded: false, callData: call, durationSeconds, endReason, status };
    });

    // Only write system message if this was the first endCall (not idempotent duplicate)
    if (!result.alreadyEnded) {
      const call = result.callData;
      const { durationSeconds, endReason, status } = result;

      const callLabel = call.callType === 'video' ? 'Video call' : 'Voice call';
      const durationText = durationSeconds ? formatDuration(durationSeconds) : null;
      const systemText =
        status === 'missed'
          ? `Missed ${callLabel.toLowerCase()}`
          : status === 'declined'
            ? `${callLabel} declined`
            : status === 'cancelled'
              ? `Cancelled ${callLabel.toLowerCase()}`
              : status === 'busy'
                ? `${callLabel} — busy`
                : `${callLabel}${durationText ? ', ' + durationText : ''}`;

      const msgRef = db
        .collection('conversations')
        .doc(call.conversationId)
        .collection('messages')
        .doc();

      await msgRef.set({
        id: msgRef.id,
        senderId: userId,
        senderName: call.callerName || '',
        senderAvatarUrl: null,
        type: 'system',
        status: 'sent',
        textContent: systemText,
        ciphertext: null,
        e2ee: null,
        x3dhHeader: null,
        media: null,
        tokenAmount: null,
        recipientId: null,
        ledgerJournalId: null,
        reactions: {},
        replyTo: null,
        readBy: {},
        forwardedFrom: null,
        communityId: null,
        systemEventType: 'call_ended',
        systemEventData: {
          callId,
          callType: call.callType,
          callerId: call.callerId,
          calleeId: call.calleeId,
          durationSeconds,
          endReason,
        },
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        expiresAt: null,
        actionedAt: null,
        deletedAt: null,
        deletedFor: [],
        deletedForEveryone: false,
      });
    }

    return { success: true };
  },
);

function formatDuration(seconds: number): string {
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  return `${m}:${s.toString().padStart(2, '0')}`;
}

// ─── sendVoipPush ──────────────────────────────────────────────────────
//
// Sends an APNs VoIP push to wake killed iOS apps.
// Requires a .p8 auth key from Apple Developer portal.
// Store the key file path and key ID in environment config.

let apnProvider: apn.Provider | null = null;

function getApnProvider(): apn.Provider {
  if (apnProvider) return apnProvider;

  apnProvider = new apn.Provider({
    token: {
      key: process.env.APN_KEY_PATH || './certs/AuthKey.p8',
      keyId: process.env.APN_KEY_ID || '',
      teamId: process.env.APN_TEAM_ID || '',
    },
    production: true,
  });
  return apnProvider;
}

async function sendVoipPush(
  voipToken: string,
  payload: Record<string, unknown>,
): Promise<void> {
  const provider = getApnProvider();
  const notification = new apn.Notification();
  notification.topic = 'com.imalichat.app.voip'; // Bundle ID + .voip suffix
  notification.pushType = 'voip';
  notification.priority = 10;
  notification.expiry = Math.floor(Date.now() / 1000) + 30; // 30s expiry
  notification.payload = payload;

  const result = await provider.send(notification, voipToken);
  if (result.failed.length > 0) {
    console.error('VoIP push failed:', result.failed[0].response);
  }
}

// ─── cleanupCallSignaling ──────────────────────────────────────────────
//
// Firestore trigger: when a call transitions to a terminal status, delete
// the ICE candidate subcollections. Also handles ring timeout as a
// server-side safety net: if status is still 'ringing' and createdAt is
// > 30s ago, transition to 'missed'.

export const onCallUpdated = onDocumentUpdated(
  {
    document: 'calls/{callId}',
    region: 'africa-south1',
    labels: { app: 'imalichat' },
  },
  async (event) => {
    const after = event.data?.after.data();
    const before = event.data?.before.data();
    if (!after || !before) return;

    // ── Terminal status reached: clean up ICE subcollections ──
    if (TERMINAL_STATUSES.includes(after.status) && !TERMINAL_STATUSES.includes(before.status)) {
      const callRef = event.data!.after.ref;
      const batch = db.batch();

      const callerCands = await callRef.collection('callerCandidates').get();
      callerCands.docs.forEach(doc => batch.delete(doc.ref));

      const calleeCands = await callRef.collection('calleeCandidates').get();
      calleeCands.docs.forEach(doc => batch.delete(doc.ref));

      if (callerCands.size > 0 || calleeCands.size > 0) {
        await batch.commit();
      }
    }
  },
);

// ─── cleanupStaleCalls (Scheduled) ─────────────────────────────────────
//
// Runs every minute. Catches calls stuck in 'ringing' > 30s (caller crashed)
// or 'active' with stale heartbeats > 30s (both peers crashed).

import { onSchedule } from 'firebase-functions/v2/scheduler';

export const cleanupStaleCalls = onSchedule(
  {
    schedule: 'every 1 minutes',
    region: 'africa-south1',
    labels: { app: 'imalichat' },
  },
  async () => {
    const now = Date.now();
    const thirtySecondsAgo = admin.firestore.Timestamp.fromDate(
      new Date(now - RING_TIMEOUT_MS),
    );

    // Stale ringing calls → missed
    const staleRinging = await db.collection('calls')
      .where('status', '==', 'ringing')
      .where('createdAt', '<', thirtySecondsAgo)
      .limit(50)
      .get();

    for (const doc of staleRinging.docs) {
      const data = doc.data();
      let durationSeconds: number | null = null;
      await doc.ref.update({
        status: 'missed',
        endedAt: admin.firestore.FieldValue.serverTimestamp(),
        endReason: 'missed',
        durationSeconds: null,
        expireAt: admin.firestore.Timestamp.fromDate(new Date(now + 3600_000)),
      });

      // Write missed call system message
      const msgRef = db
        .collection('conversations')
        .doc(data.conversationId)
        .collection('messages')
        .doc();
      const callLabel = data.callType === 'video' ? 'video call' : 'voice call';
      await msgRef.set({
        id: msgRef.id,
        senderId: data.callerId,
        senderName: data.callerName || '',
        senderAvatarUrl: null,
        type: 'system',
        status: 'sent',
        textContent: `Missed ${callLabel}`,
        ciphertext: null,
        e2ee: null,
        x3dhHeader: null,
        media: null,
        tokenAmount: null,
        recipientId: null,
        ledgerJournalId: null,
        reactions: {},
        replyTo: null,
        readBy: {},
        forwardedFrom: null,
        communityId: null,
        systemEventType: 'call_ended',
        systemEventData: {
          callId: doc.id,
          callType: data.callType,
          callerId: data.callerId,
          calleeId: data.calleeId,
          durationSeconds: null,
          endReason: 'missed',
        },
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        expiresAt: null,
        actionedAt: null,
        deletedAt: null,
        deletedFor: [],
        deletedForEveryone: false,
      });
    }

    // Stale active calls (both heartbeats > 30s old) → ended
    const thirtySecTimestamp = admin.firestore.Timestamp.fromDate(
      new Date(now - 30_000),
    );
    const staleActive = await db.collection('calls')
      .where('status', '==', 'active')
      .where('callerHeartbeat', '<', thirtySecTimestamp)
      .limit(50)
      .get();

    for (const doc of staleActive.docs) {
      const data = doc.data();
      // Only end if BOTH heartbeats are stale
      if (data.calleeHeartbeat && data.calleeHeartbeat.toDate().getTime() > now - 30_000) {
        continue; // Callee is still alive
      }
      let durationSeconds: number | null = null;
      if (data.answeredAt) {
        durationSeconds = Math.round((now - data.answeredAt.toDate().getTime()) / 1000);
      }
      await doc.ref.update({
        status: 'ended',
        endedAt: admin.firestore.FieldValue.serverTimestamp(),
        endReason: 'peer_offline',
        durationSeconds,
        expireAt: admin.firestore.Timestamp.fromDate(new Date(now + 3600_000)),
      });
    }
  },
);
```

**Export from `functions/src/index.ts`:**
```typescript
export {
  initiateCall,
  answerCall,
  endCall,
  getTurnCredentials,
  onCallUpdated,
  cleanupStaleCalls,
} from './calls';
```

---

## 5. Signaling Flow

### Sequence Diagram

```
Caller                     Firestore                    Receiver
  │                           │                            │
  │── initiateCall() ────────►│                            │
  │   (Cloud Function)        │── FCM data msg ───────────►│
  │   (transaction: check     │   type: 'incoming_call'    │
  │    no active + create)    │── VoIP push (iOS) ────────►│
  │                           │                            │
  │   create PeerConnection   │                    show native call UI
  │   getUserMedia(audio)     │                    (flutter_callkit_incoming)
  │   Perfect Negotiation:    │                            │
  │     onRenegotiationNeeded │                            │
  │     → createOffer()       │                            │
  │     → setLocalDescription │                            │
  │                           │                            │
  │── write offer to doc ────►│                            │
  │                           │◄── listen call doc ────────│
  │                           │    (sees offer)            │
  │── write ICE candidates ──►│                            │
  │   (callerCandidates/)     │          user taps Accept  │
  │                           │                            │
  │                           │    answerCall() CF ────────│
  │                           │    (validates ringing→active)
  │                           │                            │
  │                           │    create PeerConnection   │
  │                           │    getUserMedia(audio)     │
  │                           │    setRemoteDescription()  │
  │                           │    buffer remote candidates│
  │                           │    Perfect Negotiation:    │
  │                           │      createAnswer()        │
  │                           │      setLocalDescription() │
  │                           │                            │
  │                           │◄── write answer to doc ────│
  │◄── listen call doc ───────│                            │
  │    (sees answer)          │                            │
  │    handleDescription()    │◄── write ICE candidates ──│
  │                           │    (calleeCandidates/)     │
  │◄── listen ICE candidates──│──► listen ICE candidates──►│
  │    addIceCandidate()      │    addIceCandidate()       │
  │                           │                            │
  │═══════════ P2P media stream (UDP, SRTP encrypted) ════│
  │           Firestore is no longer in the loop           │
  │                                                        │
  │         Heartbeat writes every 5s (crash detection)    │
  │                                                        │
  │── endCall() ─────────────►│                            │
  │   (CF: idempotent,        │── status: 'ended' ────────►│
  │    first-writer-wins)     │── system message to chat   │
  │                           │── trigger: cleanup ICE     │
```

**Total Firestore operations per call:** ~30-50 documents (signaling only).
Once P2P connects, only heartbeat writes continue (~12/min per peer).

---

## 6. Platform Configuration

### Android

**`android/app/src/main/AndroidManifest.xml`** — add these permissions ABOVE the `<application>` tag
(CAMERA and RECORD_AUDIO already exist):

```xml
<!-- WebRTC audio settings -->
<uses-feature android:name="android.hardware.camera" />
<uses-feature android:name="android.hardware.camera.autofocus" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />

<!-- Bluetooth audio routing (pre-Android 12) -->
<uses-permission android:name="android.permission.BLUETOOTH"
    android:maxSdkVersion="30" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN"
    android:maxSdkVersion="30" />
<!-- Bluetooth audio routing (Android 12+) -->
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />

<!-- Call notifications -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.VIBRATE" />

<!-- Foreground service for active call -->
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_PHONE_CALL" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.MANAGE_OWN_CALLS" />
```

**Activity attributes** — add to `<activity android:name=".MainActivity" ...>`:

> **Note:** `showWhenLocked` and `turnScreenOn` are deprecated since API 27 but still
> functional. For API 27+ these are also set programmatically by `flutter_callkit_incoming`.
> Including both ensures backward compatibility.

```xml
android:showWhenLocked="true"
android:turnScreenOn="true"
```

**`android/app/proguard-rules.pro`** — append:
```
# WebRTC
-keep class com.cloudwebrtc.webrtc.** { *; }
-keep class org.webrtc.** { *; }

# flutter_callkit_incoming
-keep class com.hiennv.flutter_callkit_incoming.** { *; }
```

### iOS

**`ios/Runner/Info.plist`** — modifications:

Add `voip` to existing `UIBackgroundModes` (do NOT add `processing` — it's not needed):
```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
    <string>voip</string>
</array>
```

Update camera and microphone descriptions to include calls:
```xml
<key>NSCameraUsageDescription</key>
<string>iMali needs camera access for profile photos and video calls.</string>
<key>NSMicrophoneUsageDescription</key>
<string>iMali needs microphone access for voice messages, voice calls, and video calls.</string>
```

**Xcode Capabilities** (manual step):
1. Background Modes → Voice over IP, Remote notifications (fetch already enabled)
2. Push Notifications (for PushKit VoIP push)

### iOS PushKit Integration (AppDelegate.swift)

PushKit is **mandatory for reliable incoming calls on iOS**. Regular FCM/APNs
cannot wake a killed app. PushKit can, but Apple requires you to report
a CallKit call in the **same run loop** as the push handler — failure to do so
causes iOS to terminate the app and stop delivering VoIP pushes permanently.

Extend the existing `AppDelegate.swift` (add PushKit import, protocol conformance,
and call `registerVoIPPush()` from `didFinishLaunchingWithOptions`):

```swift
// AppDelegate.swift — REVISED (additions marked with // NEW)
import Flutter
import UIKit
import PushKit                          // NEW
import flutter_callkit_incoming         // NEW

@main
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate {  // NEW: add PKPushRegistryDelegate
  private let keystoreChannel = KeystoreChannel()
  private var secureField: UITextField?
  private var voipRegistry: PKPushRegistry?  // NEW

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if let controller = window?.rootViewController as? FlutterViewController {
      keystoreChannel.register(with: controller.binaryMessenger)

      // Screenshot prevention method channel (existing)
      let screenshotChannel = FlutterMethodChannel(
        name: "com.imalichat.app/screenshot",
        binaryMessenger: controller.binaryMessenger
      )
      screenshotChannel.setMethodCallHandler { [weak self] call, result in
        switch call.method {
        case "enableSecure":
          self?.enableScreenshotPrevention()
          result(nil)
        case "disableSecure":
          self?.disableScreenshotPrevention()
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }

    enableScreenshotPrevention()

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(userDidTakeScreenshot),
      name: UIApplication.userDidTakeScreenshotNotification,
      object: nil
    )

    // NEW: Register for VoIP pushes
    registerVoIPPush()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // NEW ─── VoIP Push Registration ──────────────────────────────────────

  private func registerVoIPPush() {
    voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
    voipRegistry?.delegate = self
    voipRegistry?.desiredPushTypes = [.voIP]
  }

  func pushRegistry(_ registry: PKPushRegistry,
                    didUpdate credentials: PKPushCredentials,
                    for type: PKPushType) {
    // Convert token to hex string and store for later retrieval by Flutter
    let deviceToken = credentials.token
        .map { String(format: "%02x", $0) }
        .joined()
    // flutter_callkit_incoming stores this and makes it available via Dart API
    SwiftFlutterCallkitIncomingPlugin.sharedInstance?
        .setDevicePushTokenVoIP(deviceToken)
  }

  func pushRegistry(_ registry: PKPushRegistry,
                    didReceiveIncomingPushWith payload: PKPushPayload,
                    for type: PKPushType,
                    completion: @escaping () -> Void) {
    guard type == .voIP else { completion(); return }

    let data = payload.dictionaryPayload
    let id = data["callId"] as? String ?? UUID().uuidString
    let callerName = data["callerName"] as? String ?? "Unknown"
    let callType = data["type"] as? Int ?? 0 // 0=audio, 1=video

    // CRITICAL: MUST report call to CallKit in the SAME run loop.
    // Any async delay here causes iOS to kill the app permanently.
    let params: [String: Any] = [
        "id": id,
        "nameCaller": callerName,
        "handle": callerName,
        "type": callType,
        "extra": [
            "conversationId": data["conversationId"] as? String ?? "",
            "callerId": data["callerId"] as? String ?? "",
        ],
    ]
    SwiftFlutterCallkitIncomingPlugin.sharedInstance?
        .showCallkitIncoming(params, fromPushKit: true)

    completion()
  }

  func pushRegistry(_ registry: PKPushRegistry,
                    didInvalidatePushTokenFor type: PKPushType) {
    // Token invalidated — clear from Firestore on next app launch
    SwiftFlutterCallkitIncomingPlugin.sharedInstance?
        .setDevicePushTokenVoIP("")
  }

  // Existing methods unchanged...
  private func enableScreenshotPrevention() { /* ... existing ... */ }
  private func disableScreenshotPrevention() { /* ... existing ... */ }
  @objc private func userDidTakeScreenshot() { /* ... existing ... */ }
}
```

**VoIP token storage on Firestore** — done from Flutter:
```dart
// In notification_service.dart or a dedicated call_notification_service.dart
Future<void> registerVoipToken() async {
  final token = await FlutterCallkitIncoming.getDevicePushTokenVoIP();
  if (token != null && token.isNotEmpty) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'voipToken': token,
      });
    }
  }
}
```

---

## 7. Flutter Architecture (Clean Architecture)

### New Files

```
lib/
├── core/
│   └── services/
│       ├── webrtc_service.dart              # WebRTC peer connection wrapper
│       ├── call_signaling_service.dart       # Firestore signaling (offer/answer/ICE)
│       └── call_quality_monitor.dart         # getStats polling + quality assessment
│
├── domain/
│   ├── entities/
│   │   └── call_session.dart                # Freezed entity
│   ├── enums/
│   │   ├── call_status.dart                 # ringing, active, ended, missed, ...
│   │   └── connection_quality.dart          # excellent, good, fair, poor
│   └── repositories/
│       └── call_repository.dart             # Abstract interface
│
├── data/
│   ├── datasources/remote/
│   │   └── call_remote_datasource.dart      # Cloud Function calls + Firestore
│   ├── models/
│   │   └── call_session_model.dart          # JSON serialization for Firestore
│   └── repositories/
│       └── call_repository_impl.dart        # @Injectable implementation
│
└── presentation/
    ├── blocs/call/
    │   ├── call_bloc.dart                   # @Injectable state machine
    │   ├── call_event.dart                  # Freezed events
    │   └── call_state.dart                  # Freezed state
    ├── screens/messaging/
    │   ├── voice_call_screen.dart           # Avatar + timer + controls
    │   └── video_call_screen.dart           # Local PiP + remote full + controls
    └── widgets/messaging/
        └── call_system_message.dart         # "Voice call, 2:34" bubble
```

**After creating these files, run:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Domain Entity

```dart
// lib/domain/entities/call_session.dart
@freezed
class CallSession with _$CallSession {
  const factory CallSession({
    required String callId,
    required String conversationId,
    required String callerId,
    required String calleeId,
    required String callerName,
    String? callerAvatarUrl,
    required CallType callType,
    required CallStatus status,
    Map<String, String>? offer,     // {type, sdp}
    Map<String, String>? answer,    // {type, sdp}
    String? videoUpgradeRequest,    // 'pending' | 'accepted' | 'declined'
    String? videoUpgradeRequesterId,
    DateTime? createdAt,
    DateTime? answeredAt,
    DateTime? endedAt,
    String? endReason,
    int? durationSeconds,
  }) = _CallSession;
}
```

### Domain Enums

```dart
// lib/domain/enums/call_status.dart
enum CallStatus {
  idle,           // No active call
  ringing,        // Outgoing: waiting for answer; Incoming: ringing
  connecting,     // ICE negotiation in progress
  active,         // Media flowing
  reconnecting,   // ICE disconnected, attempting restart
  ended,          // Call ended normally
  missed,         // Ring timeout
  declined,       // Callee rejected
  cancelled,      // Caller hung up before answer
  failed,         // Connection could not be established
  busy,           // Callee already on another call
}

// lib/domain/enums/call_type.dart
enum CallType { voice, video }

// lib/domain/enums/connection_quality.dart
enum ConnectionQuality { excellent, good, fair, poor }
```

### Data Model

```dart
// lib/data/models/call_session_model.dart
@JsonSerializable()
class CallSessionModel {
  final String callId;
  final String conversationId;
  final String callerId;
  final String calleeId;
  final String callerName;
  final String? callerAvatarUrl;
  final String callType;
  final String status;
  final Map<String, dynamic>? offer;
  final Map<String, dynamic>? answer;
  final String? videoUpgradeRequest;
  final String? videoUpgradeRequesterId;
  @JsonKey(fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
  final DateTime? createdAt;
  @JsonKey(fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
  final DateTime? answeredAt;
  @JsonKey(fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
  final DateTime? endedAt;
  final String? endReason;
  final int? durationSeconds;

  const CallSessionModel({
    required this.callId,
    required this.conversationId,
    required this.callerId,
    required this.calleeId,
    required this.callerName,
    this.callerAvatarUrl,
    required this.callType,
    required this.status,
    this.offer,
    this.answer,
    this.videoUpgradeRequest,
    this.videoUpgradeRequesterId,
    this.createdAt,
    this.answeredAt,
    this.endedAt,
    this.endReason,
    this.durationSeconds,
  });

  factory CallSessionModel.fromJson(Map<String, dynamic> json) =>
      _$CallSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CallSessionModelToJson(this);

  CallSession toEntity() => CallSession(
        callId: callId,
        conversationId: conversationId,
        callerId: callerId,
        calleeId: calleeId,
        callerName: callerName,
        callerAvatarUrl: callerAvatarUrl,
        callType: callType == 'video' ? CallType.video : CallType.voice,
        status: CallStatus.values.firstWhere(
          (s) => s.name == status,
          orElse: () => CallStatus.idle,
        ),
        offer: offer?.map((k, v) => MapEntry(k, v.toString())),
        answer: answer?.map((k, v) => MapEntry(k, v.toString())),
        videoUpgradeRequest: videoUpgradeRequest,
        videoUpgradeRequesterId: videoUpgradeRequesterId,
        createdAt: createdAt,
        answeredAt: answeredAt,
        endedAt: endedAt,
        endReason: endReason,
        durationSeconds: durationSeconds,
      );

  static DateTime? _timestampToDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static dynamic _dateTimeToTimestamp(DateTime? value) {
    if (value == null) return null;
    return Timestamp.fromDate(value);
  }
}
```

### Repository Interface

```dart
// lib/domain/repositories/call_repository.dart
abstract class CallRepository {
  Future<String> initiateCall({
    required String conversationId,
    required String recipientId,
    required CallType callType,
  });
  Future<void> answerCall(String callId);
  Future<void> endCall(String callId, {String? reason});
  Future<Map<String, dynamic>> getTurnCredentials();
  Stream<CallSession> watchCall(String callId);
  Stream<RTCIceCandidate> watchRemoteIceCandidates(String callId, {required bool isCaller});
  Future<void> sendOffer(String callId, RTCSessionDescription offer);
  Future<void> sendAnswer(String callId, RTCSessionDescription answer);
  Future<void> sendIceCandidate(String callId, RTCIceCandidate candidate, {required bool isCaller});
  Future<void> sendHeartbeat(String callId, {required bool isCaller});
  Future<void> requestVideoUpgrade(String callId, String requesterId);
  Future<void> respondVideoUpgrade(String callId, bool accepted);
}
```

---

## 8. WebRTC Service

Core wrapper around `flutter_webrtc`. **Not a singleton** — a new instance is
created per call and disposed when the call ends. This avoids the stale-controller
problem where a `@lazySingleton`'s closed StreamControllers cannot be reopened.

```dart
// lib/core/services/webrtc_service.dart

/// Per-call WebRTC wrapper. Create via WebRtcServiceFactory, dispose after call ends.
/// NOT a singleton — each call gets a fresh instance.
class WebRtcService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  RTCRtpTransceiver? _videoTransceiver;
  final List<RTCRtpSender> _senders = [];

  bool _isFrontCamera = true;
  bool _isAudioEnabled = true;
  bool _isVideoEnabled = true;
  bool _isSpeakerOn = false;
  bool _isDisposed = false;

  // Stream controllers — fresh per instance, safe to close once
  final _remoteStreamController = StreamController<MediaStream?>.broadcast();
  final _localStreamController = StreamController<MediaStream?>.broadcast();
  final _connectionStateController = StreamController<RTCPeerConnectionState>.broadcast();
  final _iceConnectionStateController = StreamController<RTCIceConnectionState>.broadcast();
  final _iceGatheringStateController = StreamController<RTCIceGatheringState>.broadcast();

  Stream<MediaStream?> get onRemoteStream => _remoteStreamController.stream;
  Stream<MediaStream?> get onLocalStream => _localStreamController.stream;
  Stream<RTCPeerConnectionState> get onConnectionState => _connectionStateController.stream;
  Stream<RTCIceConnectionState> get onIceConnectionState => _iceConnectionStateController.stream;
  Stream<RTCIceGatheringState> get onIceGatheringState => _iceGatheringStateController.stream;

  RTCPeerConnection? get peerConnection => _peerConnection;
  MediaStream? get localStream => _localStream;
  bool get isFrontCamera => _isFrontCamera;
  bool get isAudioEnabled => _isAudioEnabled;
  bool get isVideoEnabled => _isVideoEnabled;
  bool get isSpeakerOn => _isSpeakerOn;

  /// Initialize peer connection and acquire local media.
  ///
  /// [isVideo]: true for video call, false for voice-only.
  /// [iceServers]: ICE server config from getTurnCredentials().
  /// [onIceCandidate]: callback for each local ICE candidate (send to signaling).
  Future<void> initialize({
    required bool isVideo,
    required Map<String, dynamic> iceServers,
    required void Function(RTCIceCandidate) onIceCandidate,
  }) async {
    // Safety: dispose previous state if initialize() called twice
    if (_peerConnection != null) {
      await dispose();
    }

    // ── Platform audio configuration ──
    if (Platform.isAndroid) {
      await Helper.setAndroidAudioConfiguration(
        const AndroidAudioConfiguration(
          audioMode: AndroidAudioMode.inCommunication,
          audioFocusMode: AndroidAudioFocusMode.gain,
          audioStreamType: AndroidAudioStreamType.voiceCall,
        ),
      );
    } else if (Platform.isIOS) {
      await Helper.setAppleAudioConfiguration(
        const AppleAudioConfiguration(
          appleAudioCategory: AppleAudioCategory.playAndRecord,
          appleAudioCategoryOptions: {
            AppleAudioCategoryOption.allowBluetooth,
            AppleAudioCategoryOption.allowBluetoothA2DP,
            AppleAudioCategoryOption.defaultToSpeaker,
          },
          appleAudioMode: AppleAudioMode.voiceChat,
        ),
      );
    }

    // ── Create peer connection ──
    _peerConnection = await createPeerConnection(
      iceServers,
      {
        'optional': [
          {'DtlsSrtpKeyAgreement': true},
        ],
      },
    );

    // ── Register event handlers ──
    _peerConnection!.onIceCandidate = (candidate) {
      if (candidate.candidate != null && !_isDisposed) {
        onIceCandidate(candidate);
      }
    };

    _peerConnection!.onTrack = (event) {
      if (event.streams.isNotEmpty && !_isDisposed) {
        _remoteStream = event.streams.first;
        _remoteStreamController.add(_remoteStream);
      }
    };

    _peerConnection!.onConnectionState = (state) {
      if (!_isDisposed) _connectionStateController.add(state);
    };

    _peerConnection!.onIceConnectionState = (state) {
      if (!_isDisposed) _iceConnectionStateController.add(state);
    };

    _peerConnection!.onIceGatheringState = (state) {
      if (!_isDisposed) _iceGatheringStateController.add(state);
    };

    // ── Acquire local media ──
    try {
      _localStream = await navigator.mediaDevices.getUserMedia({
        'audio': {
          'echoCancellation': true,
          'noiseSuppression': true,
          'autoGainControl': true,
        },
        'video': isVideo
            ? {
                'mandatory': {
                  'minWidth': 480,
                  'minHeight': 640,
                  'minFrameRate': 24,
                },
                'facingMode': 'user',
                'optional': [],
              }
            : false,
      });
    } catch (e) {
      await dispose();
      rethrow; // Permission denied or hardware failure
    }
    _localStreamController.add(_localStream);

    // ── Add tracks to peer connection ──
    for (final track in _localStream!.getTracks()) {
      final sender = await _peerConnection!.addTrack(track, _localStream!);
      _senders.add(sender);
    }

    // ── Reserve video transceiver for voice calls (enables upgrade without renegotiation) ──
    if (!isVideo) {
      _videoTransceiver = await _peerConnection!.addTransceiver(
        kind: RTCRtpMediaType.RTCRtpMediaTypeVideo,
        init: RTCRtpTransceiverInit(direction: TransceiverDirection.RecvOnly),
      );
    }
  }

  // ── Media Controls ──

  void toggleMute() {
    if (_localStream == null) return;
    final audioTracks = _localStream!.getAudioTracks();
    if (audioTracks.isEmpty) return; // Defensive: no crash on empty list
    final audioTrack = audioTracks.first;
    audioTrack.enabled = !audioTrack.enabled;
    _isAudioEnabled = audioTrack.enabled;
  }

  void toggleVideo() {
    if (_localStream == null) return;
    final videoTracks = _localStream!.getVideoTracks();
    if (videoTracks.isEmpty) return;
    videoTracks.first.enabled = !videoTracks.first.enabled;
    _isVideoEnabled = videoTracks.first.enabled;
  }

  Future<void> switchCamera() async {
    if (_localStream == null) return;
    final videoTracks = _localStream!.getVideoTracks();
    if (videoTracks.isEmpty) return;
    await Helper.switchCamera(videoTracks.first);
    _isFrontCamera = !_isFrontCamera;
  }

  Future<void> toggleSpeaker() async {
    _isSpeakerOn = !_isSpeakerOn;
    await Helper.setSpeakerphoneOn(_isSpeakerOn);
  }

  /// Upgrade voice call to video by replacing the reserved transceiver's track.
  ///
  /// The replaceTrack part does NOT trigger renegotiation. However, changing
  /// transceiver direction from RecvOnly to SendRecv WILL fire
  /// onRenegotiationNeeded, which is handled by the PerfectNegotiationHandler.
  Future<void> upgradeToVideo() async {
    final mediaStream = await navigator.mediaDevices.getUserMedia({
      'video': {
        'mandatory': {'minWidth': 480, 'minHeight': 640, 'minFrameRate': 24},
        'facingMode': 'user',
      },
    });
    final videoTrack = mediaStream.getVideoTracks().first;

    if (_videoTransceiver != null) {
      await _videoTransceiver!.sender.replaceTrack(videoTrack);
      await _videoTransceiver!.setDirection(TransceiverDirection.SendRecv);
      // Note: setDirection fires onRenegotiationNeeded → Perfect Negotiation
      // handles the new offer/answer exchange automatically.
    }

    // Add video track to local stream for preview
    _localStream?.addTrack(videoTrack);
    _localStreamController.add(_localStream);
    _isVideoEnabled = true;

    // Dispose the temporary MediaStream container (track is now on _localStream)
    // Do NOT dispose the track itself — it's in use.
    // mediaStream.dispose() would stop the track, so we just let the container be GC'd.
  }

  // ── Cleanup ──

  Future<void> dispose() async {
    if (_isDisposed) return;
    _isDisposed = true;

    // 1. Stop all local tracks (use for loop, NOT forEach with async)
    for (final track in _localStream?.getTracks() ?? <MediaStreamTrack>[]) {
      await track.stop();
    }

    // 2. Dispose local stream
    await _localStream?.dispose();
    _localStream = null;
    if (!_localStreamController.isClosed) {
      _localStreamController.add(null);
    }

    // 3. Close peer connection
    await _peerConnection?.close();
    _peerConnection = null;

    // 4. Clear state
    _senders.clear();
    _videoTransceiver = null;
    _remoteStream = null;
    if (!_remoteStreamController.isClosed) {
      _remoteStreamController.add(null);
    }

    // 5. Close all stream controllers (safe: each instance is single-use)
    _remoteStreamController.close();
    _localStreamController.close();
    _connectionStateController.close();
    _iceConnectionStateController.close();
    _iceGatheringStateController.close();
  }
}

/// Factory registered with GetIt. Creates fresh WebRtcService per call.
@lazySingleton
class WebRtcServiceFactory {
  WebRtcService create() => WebRtcService();
}
```

---

## 9. Call Signaling Service

Reads/writes SDP and ICE candidates via Firestore. Stateless — safe as a singleton.

```dart
// lib/core/services/call_signaling_service.dart
@lazySingleton
class CallSignalingService {
  final FirebaseFirestore _firestore;

  CallSignalingService(this._firestore);

  DocumentReference _callDoc(String callId) =>
      _firestore.collection('calls').doc(callId);

  // ── SDP ──

  Future<void> sendOffer(String callId, RTCSessionDescription offer) async {
    try {
      await _callDoc(callId).update({
        'offer': {'sdp': offer.sdp, 'type': offer.type},
      });
    } catch (e) {
      debugPrint('CallSignaling: sendOffer failed: $e');
      rethrow;
    }
  }

  Future<void> sendAnswer(String callId, RTCSessionDescription answer) async {
    try {
      await _callDoc(callId).update({
        'answer': {'sdp': answer.sdp, 'type': answer.type},
      });
    } catch (e) {
      debugPrint('CallSignaling: sendAnswer failed: $e');
      rethrow;
    }
  }

  // ── ICE Candidates ──

  /// [isCaller]: determines which subcollection to write to.
  /// Replaces the broken _getCallerId() approach — caller/callee role is
  /// known at call setup time and passed explicitly.
  Future<void> sendIceCandidate(
    String callId,
    RTCIceCandidate candidate, {
    required bool isCaller,
  }) async {
    final subcollection = isCaller ? 'callerCandidates' : 'calleeCandidates';
    try {
      await _callDoc(callId).collection(subcollection).add({
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('CallSignaling: sendIceCandidate failed: $e');
      // Don't rethrow — losing one candidate is recoverable
    }
  }

  Stream<RTCIceCandidate> watchRemoteIceCandidates(
    String callId, {
    required bool isCaller,
  }) {
    final subcollection = isCaller ? 'calleeCandidates' : 'callerCandidates';
    return _callDoc(callId)
        .collection(subcollection)
        .snapshots()
        .expand((snap) => snap.docChanges
            .where((change) => change.type == DocumentChangeType.added)
            .map((change) {
              final data = change.doc.data()!;
              return RTCIceCandidate(
                data['candidate'] as String,
                data['sdpMid'] as String,
                data['sdpMLineIndex'] as int,
              );
            }));
  }

  // ── Call Document Watching ──

  /// Returns typed CallSession entities via CallSessionModel.
  Stream<CallSession> watchCall(String callId) {
    return _callDoc(callId).snapshots().map((snap) {
      final data = snap.data() as Map<String, dynamic>?;
      if (data == null) {
        return CallSession(
          callId: callId,
          conversationId: '',
          callerId: '',
          calleeId: '',
          callerName: '',
          callType: CallType.voice,
          status: CallStatus.ended,
        );
      }
      return CallSessionModel.fromJson(data).toEntity();
    });
  }

  // ── Heartbeat ──

  Future<void> sendHeartbeat(String callId, {required bool isCaller}) async {
    final field = isCaller ? 'callerHeartbeat' : 'calleeHeartbeat';
    try {
      await _callDoc(callId).update({field: FieldValue.serverTimestamp()});
    } catch (e) {
      debugPrint('CallSignaling: heartbeat failed: $e');
    }
  }

  // ── ICE Restart Count ──

  Future<void> updateIceRestartCount(String callId, int count) async {
    try {
      await _callDoc(callId).update({'iceRestartCount': count});
    } catch (e) {
      debugPrint('CallSignaling: updateIceRestartCount failed: $e');
    }
  }

  // ── Video Upgrade ──

  Future<void> requestVideoUpgrade(String callId, String requesterId) async {
    await _callDoc(callId).update({
      'videoUpgradeRequest': 'pending',
      'videoUpgradeRequesterId': requesterId,
    });
  }

  Future<void> respondVideoUpgrade(String callId, bool accepted) async {
    await _callDoc(callId).update({
      'videoUpgradeRequest': accepted ? 'accepted' : 'declined',
    });
  }
}
```

---

## 10. Call State Machine (CallBloc)

### Events

```dart
// lib/presentation/blocs/call/call_event.dart
@freezed
class CallEvent with _$CallEvent {
  // Outgoing
  const factory CallEvent.initiateCall({
    required String conversationId,
    required String recipientId,
    required String recipientName,
    String? recipientAvatarUrl,
    @Default(CallType.voice) CallType callType,
  }) = _InitiateCall;

  // Incoming
  const factory CallEvent.incomingCall({
    required String callId,
    required String callerName,
    String? callerAvatarUrl,
    required CallType callType,
    required String conversationId,
    required String callerId,
  }) = _IncomingCall;

  // User actions
  const factory CallEvent.acceptCall() = _AcceptCall;
  const factory CallEvent.rejectCall() = _RejectCall;
  const factory CallEvent.endCall() = _EndCall;
  const factory CallEvent.toggleMute() = _ToggleMute;
  const factory CallEvent.toggleSpeaker() = _ToggleSpeaker;
  const factory CallEvent.toggleVideo() = _ToggleVideo;
  const factory CallEvent.switchCamera() = _SwitchCamera;
  const factory CallEvent.requestVideoUpgrade() = _RequestVideoUpgrade;
  const factory CallEvent.respondVideoUpgrade({required bool accepted}) = _RespondVideoUpgrade;

  // Internal (from signaling/WebRTC callbacks)
  const factory CallEvent.callDocUpdated(CallSession session) = _CallDocUpdated;
  const factory CallEvent.iceConnectionStateChanged(RTCIceConnectionState state) = _IceConnectionStateChanged;
  const factory CallEvent.callTimerTick() = _CallTimerTick;
  const factory CallEvent.qualityChanged(ConnectionQuality quality) = _QualityChanged;
}
```

### State

```dart
// lib/presentation/blocs/call/call_state.dart
@freezed
class CallState with _$CallState {
  const factory CallState({
    @Default(CallStatus.idle) CallStatus status,
    String? callId,
    String? conversationId,
    String? remoteUserId,
    String? remoteUserName,
    String? remoteUserAvatarUrl,
    @Default(CallType.voice) CallType callType,
    @Default(true) bool isCaller,
    @Default(true) bool isAudioEnabled,
    @Default(false) bool isVideoEnabled,
    @Default(false) bool isSpeakerOn,
    @Default(true) bool isFrontCamera,
    @Default(Duration.zero) Duration callDuration,
    @Default(ConnectionQuality.excellent) ConnectionQuality connectionQuality,
    // Video upgrade
    @Default(false) bool videoUpgradeRequested,    // Remote peer requested upgrade
    String? videoUpgradeRequesterId,
    String? errorMessage,
  }) = _CallState;
}
```

### BLoC Implementation

```dart
// lib/presentation/blocs/call/call_bloc.dart
@injectable
class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository _callRepository;
  final WebRtcServiceFactory _webRtcServiceFactory;
  final CallSignalingService _signalingService;
  final CallQualityMonitor _qualityMonitor;

  WebRtcService? _webRtcService;
  PerfectNegotiationHandler? _negotiationHandler;
  StreamSubscription? _callDocSub;
  StreamSubscription? _iceCandidateSub;
  StreamSubscription? _iceStateSub;
  StreamSubscription? _qualitySub;
  Timer? _callTimer;
  Timer? _heartbeatTimer;
  Timer? _ringTimer;
  int _iceRestartAttempts = 0;
  Timer? _iceGracePeriodTimer;

  CallBloc(
    this._callRepository,
    this._webRtcServiceFactory,
    this._signalingService,
    this._qualityMonitor,
  ) : super(const CallState()) {
    on<_InitiateCall>(_onInitiateCall);
    on<_IncomingCall>(_onIncomingCall);
    on<_AcceptCall>(_onAcceptCall);
    on<_RejectCall>(_onRejectCall);
    on<_EndCall>(_onEndCall);
    on<_ToggleMute>(_onToggleMute);
    on<_ToggleSpeaker>(_onToggleSpeaker);
    on<_ToggleVideo>(_onToggleVideo);
    on<_SwitchCamera>(_onSwitchCamera);
    on<_RequestVideoUpgrade>(_onRequestVideoUpgrade);
    on<_RespondVideoUpgrade>(_onRespondVideoUpgrade);
    on<_CallDocUpdated>(_onCallDocUpdated);
    on<_IceConnectionStateChanged>(_onIceConnectionStateChanged);
    on<_CallTimerTick>(_onCallTimerTick);
    on<_QualityChanged>(_onQualityChanged);
  }

  // ── Outgoing Call ──

  Future<void> _onInitiateCall(
    _InitiateCall event,
    Emitter<CallState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: CallStatus.ringing,
        conversationId: event.conversationId,
        remoteUserId: event.recipientId,
        remoteUserName: event.recipientName,
        remoteUserAvatarUrl: event.recipientAvatarUrl,
        callType: event.callType,
        isCaller: true,
        isSpeakerOn: event.callType == CallType.video,
      ));

      // Create call via Cloud Function (transactional)
      final callId = await _callRepository.initiateCall(
        conversationId: event.conversationId,
        recipientId: event.recipientId,
        callType: event.callType,
      );
      emit(state.copyWith(callId: callId));

      // Get TURN credentials
      final iceConfig = await _callRepository.getTurnCredentials();

      // Create WebRTC service (fresh instance)
      _webRtcService = _webRtcServiceFactory.create();

      // Initialize WebRTC
      await _webRtcService!.initialize(
        isVideo: event.callType == CallType.video,
        iceServers: iceConfig,
        onIceCandidate: (candidate) {
          _signalingService.sendIceCandidate(callId, candidate, isCaller: true);
        },
      );

      // Set up Perfect Negotiation (caller = impolite)
      _negotiationHandler = PerfectNegotiationHandler(
        pc: _webRtcService!.peerConnection!,
        polite: false, // Caller is impolite
        sendDescription: (desc) async {
          if (desc.type == 'offer') {
            await _signalingService.sendOffer(callId, desc);
          } else {
            await _signalingService.sendAnswer(callId, desc);
          }
        },
      );

      // Listen for call document changes (answer, status changes)
      _callDocSub = _signalingService.watchCall(callId).listen(
        (session) => add(CallEvent.callDocUpdated(session)),
      );

      // Listen for remote ICE candidates
      _iceCandidateSub = _signalingService
          .watchRemoteIceCandidates(callId, isCaller: true)
          .listen((candidate) {
        _negotiationHandler?.handleCandidate(candidate);
      });

      // Listen for ICE connection state
      _iceStateSub = _webRtcService!.onIceConnectionState.listen(
        (iceState) => add(CallEvent.iceConnectionStateChanged(iceState)),
      );

      // Ring timeout: 30 seconds
      _ringTimer = Timer(const Duration(seconds: 30), () {
        if (state.status == CallStatus.ringing) {
          add(const CallEvent.endCall());
        }
      });
    } catch (e) {
      emit(state.copyWith(
        status: CallStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  // ── Incoming Call ──

  Future<void> _onIncomingCall(
    _IncomingCall event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWith(
      status: CallStatus.ringing,
      callId: event.callId,
      conversationId: event.conversationId,
      remoteUserId: event.callerId,
      remoteUserName: event.callerName,
      remoteUserAvatarUrl: event.callerAvatarUrl,
      callType: event.callType,
      isCaller: false,
      isSpeakerOn: event.callType == CallType.video,
    ));

    // Listen for call document changes
    _callDocSub = _signalingService.watchCall(event.callId).listen(
      (session) => add(CallEvent.callDocUpdated(session)),
    );
  }

  // ── Accept Incoming Call ──

  Future<void> _onAcceptCall(
    _AcceptCall event,
    Emitter<CallState> emit,
  ) async {
    if (state.callId == null) return;
    final callId = state.callId!;

    try {
      emit(state.copyWith(status: CallStatus.connecting));

      // Validate answer via Cloud Function
      await _callRepository.answerCall(callId);

      // Get TURN credentials
      final iceConfig = await _callRepository.getTurnCredentials();

      // Create WebRTC service
      _webRtcService = _webRtcServiceFactory.create();

      await _webRtcService!.initialize(
        isVideo: state.callType == CallType.video,
        iceServers: iceConfig,
        onIceCandidate: (candidate) {
          _signalingService.sendIceCandidate(callId, candidate, isCaller: false);
        },
      );

      // Set up Perfect Negotiation (callee = polite)
      _negotiationHandler = PerfectNegotiationHandler(
        pc: _webRtcService!.peerConnection!,
        polite: true, // Callee is polite
        sendDescription: (desc) async {
          if (desc.type == 'offer') {
            await _signalingService.sendOffer(callId, desc);
          } else {
            await _signalingService.sendAnswer(callId, desc);
          }
        },
      );

      // Listen for remote ICE candidates
      _iceCandidateSub = _signalingService
          .watchRemoteIceCandidates(callId, isCaller: false)
          .listen((candidate) {
        _negotiationHandler?.handleCandidate(candidate);
      });

      // Listen for ICE connection state
      _iceStateSub = _webRtcService!.onIceConnectionState.listen(
        (iceState) => add(CallEvent.iceConnectionStateChanged(iceState)),
      );

      // Apply the buffered offer from the call document
      // (The call document already has the offer from the caller)
      // The watcher fires _onCallDocUpdated which handles the offer via
      // _negotiationHandler.handleDescription()
    } catch (e) {
      emit(state.copyWith(
        status: CallStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  // ── Call Document Updates ──

  Future<void> _onCallDocUpdated(
    _CallDocUpdated event,
    Emitter<CallState> emit,
  ) async {
    final session = event.session;

    // Handle remote SDP offer (callee receives this)
    if (session.offer != null && !state.isCaller && _negotiationHandler != null) {
      final sdp = RTCSessionDescription(
        session.offer!['sdp'],
        session.offer!['type'],
      );
      await _negotiationHandler!.handleDescription(sdp);
    }

    // Handle remote SDP answer (caller receives this)
    if (session.answer != null && state.isCaller && _negotiationHandler != null) {
      final sdp = RTCSessionDescription(
        session.answer!['sdp'],
        session.answer!['type'],
      );
      await _negotiationHandler!.handleDescription(sdp);
    }

    // Handle status changes from remote peer
    if (session.status == CallStatus.ended ||
        session.status == CallStatus.declined ||
        session.status == CallStatus.cancelled ||
        session.status == CallStatus.missed) {
      await _cleanup();
      emit(state.copyWith(status: session.status));
      return;
    }

    // Handle video upgrade request
    if (session.videoUpgradeRequest == 'pending' &&
        session.videoUpgradeRequesterId != null &&
        session.videoUpgradeRequesterId != state.remoteUserId) {
      // This shouldn't happen (requester is us), ignore
    } else if (session.videoUpgradeRequest == 'pending' &&
        session.videoUpgradeRequesterId == state.remoteUserId) {
      emit(state.copyWith(
        videoUpgradeRequested: true,
        videoUpgradeRequesterId: session.videoUpgradeRequesterId,
      ));
    } else if (session.videoUpgradeRequest == 'accepted') {
      // Remote accepted our upgrade request — enable video
      await _webRtcService?.upgradeToVideo();
      emit(state.copyWith(
        callType: CallType.video,
        isVideoEnabled: true,
        videoUpgradeRequested: false,
        videoUpgradeRequesterId: null,
      ));
    } else if (session.videoUpgradeRequest == 'declined') {
      emit(state.copyWith(
        videoUpgradeRequested: false,
        videoUpgradeRequesterId: null,
      ));
    }
  }

  // ── ICE Connection State ──

  Future<void> _onIceConnectionStateChanged(
    _IceConnectionStateChanged event,
    Emitter<CallState> emit,
  ) async {
    switch (event.state) {
      case RTCIceConnectionState.RTCIceConnectionStateConnected:
      case RTCIceConnectionState.RTCIceConnectionStateCompleted:
        _iceGracePeriodTimer?.cancel();
        _iceRestartAttempts = 0; // Reset on successful connection
        if (state.status == CallStatus.connecting || state.status == CallStatus.reconnecting) {
          emit(state.copyWith(status: CallStatus.active));
          _startCallTimer();
          _startHeartbeat();
          _startQualityMonitor();
        }
        break;

      case RTCIceConnectionState.RTCIceConnectionStateDisconnected:
        // Grace period before attempting restart
        _iceGracePeriodTimer?.cancel();
        _iceGracePeriodTimer = Timer(const Duration(seconds: 3), () {
          if (state.status == CallStatus.active) {
            emit(state.copyWith(status: CallStatus.reconnecting));
            _attemptIceRestart();
          }
        });
        break;

      case RTCIceConnectionState.RTCIceConnectionStateFailed:
        emit(state.copyWith(status: CallStatus.reconnecting));
        _attemptIceRestart();
        break;

      default:
        break;
    }
  }

  // ── ICE Restart (through Perfect Negotiation) ──

  Future<void> _attemptIceRestart() async {
    if (_iceRestartAttempts >= 3) {
      // Give up after 3 attempts
      add(const CallEvent.endCall());
      return;
    }
    _iceRestartAttempts++;

    if (state.callId != null) {
      await _signalingService.updateIceRestartCount(
          state.callId!, _iceRestartAttempts);
    }

    // Trigger ICE restart via the peer connection.
    // This fires onRenegotiationNeeded → PerfectNegotiationHandler creates
    // a new offer with iceRestart flag automatically.
    // IMPORTANT: We do NOT manually call createOffer here — that would
    // bypass Perfect Negotiation and cause glare.
    try {
      await _webRtcService?.peerConnection?.restartIce();
    } catch (e) {
      debugPrint('ICE restart failed: $e');
    }
  }

  // ── User Actions ──

  void _onToggleMute(_ToggleMute event, Emitter<CallState> emit) {
    _webRtcService?.toggleMute();
    emit(state.copyWith(isAudioEnabled: _webRtcService?.isAudioEnabled ?? true));
  }

  Future<void> _onToggleSpeaker(_ToggleSpeaker event, Emitter<CallState> emit) async {
    await _webRtcService?.toggleSpeaker();
    emit(state.copyWith(isSpeakerOn: _webRtcService?.isSpeakerOn ?? false));
  }

  void _onToggleVideo(_ToggleVideo event, Emitter<CallState> emit) {
    _webRtcService?.toggleVideo();
    emit(state.copyWith(isVideoEnabled: _webRtcService?.isVideoEnabled ?? false));
  }

  Future<void> _onSwitchCamera(_SwitchCamera event, Emitter<CallState> emit) async {
    await _webRtcService?.switchCamera();
    emit(state.copyWith(isFrontCamera: _webRtcService?.isFrontCamera ?? true));
  }

  Future<void> _onRequestVideoUpgrade(
    _RequestVideoUpgrade event,
    Emitter<CallState> emit,
  ) async {
    if (state.callId == null) return;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    await _callRepository.requestVideoUpgrade(state.callId!, uid);
  }

  Future<void> _onRespondVideoUpgrade(
    _RespondVideoUpgrade event,
    Emitter<CallState> emit,
  ) async {
    if (state.callId == null) return;
    await _callRepository.respondVideoUpgrade(state.callId!, event.accepted);
    if (event.accepted) {
      await _webRtcService?.upgradeToVideo();
      emit(state.copyWith(
        callType: CallType.video,
        isVideoEnabled: true,
        videoUpgradeRequested: false,
      ));
    } else {
      emit(state.copyWith(videoUpgradeRequested: false));
    }
  }

  Future<void> _onRejectCall(_RejectCall event, Emitter<CallState> emit) async {
    if (state.callId == null) return;
    try {
      await _callRepository.endCall(state.callId!, reason: 'declined');
      await FlutterCallkitIncoming.endCall(state.callId!);
    } catch (_) {}
    await _cleanup();
    emit(state.copyWith(status: CallStatus.declined));
  }

  Future<void> _onEndCall(_EndCall event, Emitter<CallState> emit) async {
    if (state.callId == null) return;

    final reason = state.status == CallStatus.ringing && state.isCaller
        ? 'cancelled'
        : state.status == CallStatus.reconnecting
            ? 'reconnection_failed'
            : 'normal';

    try {
      await _callRepository.endCall(state.callId!, reason: reason);
      await FlutterCallkitIncoming.endCall(state.callId!);
    } catch (_) {}
    await _cleanup();
    emit(state.copyWith(status: CallStatus.ended));
  }

  // ── Timer & Heartbeat ──

  void _onCallTimerTick(_CallTimerTick event, Emitter<CallState> emit) {
    emit(state.copyWith(
      callDuration: state.callDuration + const Duration(seconds: 1),
    ));
  }

  void _onQualityChanged(_QualityChanged event, Emitter<CallState> emit) {
    emit(state.copyWith(connectionQuality: event.quality));
  }

  void _startCallTimer() {
    _callTimer?.cancel();
    _callTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const CallEvent.callTimerTick());
    });
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (state.callId != null) {
        _signalingService.sendHeartbeat(
          state.callId!,
          isCaller: state.isCaller,
        );
      }
    });
  }

  void _startQualityMonitor() {
    _qualitySub = _qualityMonitor
        .startMonitoring(_webRtcService?.peerConnection)
        .listen((quality) {
      add(CallEvent.qualityChanged(quality));
    });
  }

  // ── Cleanup ──

  Future<void> _cleanup() async {
    _callTimer?.cancel();
    _heartbeatTimer?.cancel();
    _ringTimer?.cancel();
    _iceGracePeriodTimer?.cancel();
    _callDocSub?.cancel();
    _iceCandidateSub?.cancel();
    _iceStateSub?.cancel();
    _qualitySub?.cancel();
    _qualityMonitor.stop();
    await _webRtcService?.dispose();
    _webRtcService = null;
    _negotiationHandler = null;
  }

  @override
  Future<void> close() async {
    await _cleanup();
    return super.close();
  }
}
```

### State Machine Transitions

```
         initiateCall()
  IDLE ──────────────────► RINGING (outgoing, ring timer starts)
   ▲                            │
   │                     callDocUpdated (answer received)
   │                            ▼
   │                       CONNECTING
   │    endCall()              │
   ├◄────────────────   iceState: connected
   │                            ▼
   │    endCall()           ACTIVE
   ├◄──────────────── (timer running, heartbeats, quality monitor)
   │                            │
   │                     iceState: disconnected (3s grace)
   │                            ▼
   │                      RECONNECTING
   │                       │         │
   │              iceState:     3 attempts failed
   │              connected     → endCall()
   │                  ▼              ▼
   │               ACTIVE         FAILED / ENDED
   │                                │
   │     incomingCall()             │
   ├───────────────► RINGING (incoming)
   │                  │            │
   │           acceptCall()   rejectCall()
   │                  ▼            │
   │             CONNECTING        │
   │                  │            │
   │           iceState:connected  │
   │                  ▼            │
   │               ACTIVE          │
   │                  │            │
   │             endCall()         │
   └◄─────────────────┴───────────┘
                    ENDED
```

---

## 11. Incoming Call Handling

### Android (FCM Background Handler)

**Extend the existing handler** in `main.dart` (do NOT create a duplicate):

```dart
// main.dart — MODIFY the existing _firebaseMessagingBackgroundHandler

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final data = message.data;

  // ── NEW: Handle incoming call notifications ──
  if (data['type'] == 'incoming_call') {
    final params = CallKitParams(
      id: data['callId'] ?? const Uuid().v4(),
      nameCaller: data['callerName'] ?? 'Unknown',
      appName: 'iMaliChat',
      avatar: data['callerAvatar'] ?? '',
      handle: data['callerName'] ?? '',
      type: data['callType'] == 'video' ? 1 : 0,
      textAccept: 'Accept',
      textDecline: 'Decline',
      duration: 30000, // 30s ring timeout
      missedCallNotification: const NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: true,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0C1124',
        actionColor: '#FF328C',
      ),
      ios: const IOSParams(
        iconName: 'AppIcon',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: false,
        supportsHolding: false,
        supportsGrouping: false,
        supportsUngrouping: false,
      ),
      extra: {
        'conversationId': data['conversationId'] ?? '',
        'callerId': data['callerId'] ?? '',
      },
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
    return; // Don't process call notifications as regular messages
  }

  // Background challenges are handled when the app opens via
  // getInitialMessage / onMessageOpenedApp in app.dart
}
```

### Event Listener (in NotificationService)

Add to the existing `notification_service.dart`:

```dart
/// Listen for call events from flutter_callkit_incoming.
/// Call this once during app initialization (after DI is configured).
void listenForCallEvents(GoRouter router) {
  FlutterCallkitIncoming.onEvent.listen((event) {
    if (event == null) return;

    switch (event.event) {
      case Event.actionCallAccept:
        _handleCallAccepted(event, router);
        break;

      case Event.actionCallDecline:
        _handleCallDeclined(event);
        break;

      case Event.actionCallTimeout:
        _handleCallTimeout(event);
        break;

      case Event.actionCallCallback:
        _handleCallCallback(event, router);
        break;

      case Event.actionCallEnded:
        // User ended call from native UI (e.g. Control Center on iOS)
        final callBloc = getIt<CallBloc>();
        callBloc.add(const CallEvent.endCall());
        break;

      default:
        break;
    }
  });
}

void _handleCallAccepted(CallEvent event, GoRouter router) {
  final callId = event.body['id'] as String;
  final extra = event.body['extra'] as Map<String, dynamic>? ?? {};
  final callType = (event.body['type'] == 1) ? CallType.video : CallType.voice;

  // Ensure DI is ready before accessing BLoC
  if (!getIt.isRegistered<CallBloc>()) {
    debugPrint('CallBloc not registered yet — deferring call accept');
    return;
  }

  final callBloc = getIt<CallBloc>();

  // Dispatch incoming call event + accept
  callBloc.add(CallEvent.incomingCall(
    callId: callId,
    callerName: event.body['nameCaller'] ?? 'Unknown',
    callerAvatarUrl: event.body['avatar'],
    callType: callType,
    conversationId: extra['conversationId'] ?? '',
    callerId: extra['callerId'] ?? '',
  ));
  callBloc.add(const CallEvent.acceptCall());

  // Navigate to call screen via GoRouter
  final conversationId = extra['conversationId'] ?? '';
  router.go('/chat/conversation/$conversationId/call/$callId',
    extra: {'callType': callType.name},
  );
}

void _handleCallDeclined(CallEvent event) {
  final callId = event.body['id'] as String;
  if (!getIt.isRegistered<CallBloc>()) return;
  final callBloc = getIt<CallBloc>();
  callBloc.add(CallEvent.incomingCall(
    callId: callId,
    callerName: event.body['nameCaller'] ?? 'Unknown',
    callType: CallType.voice, // Type doesn't matter for decline
    conversationId: '',
    callerId: '',
  ));
  callBloc.add(const CallEvent.rejectCall());
}

void _handleCallTimeout(CallEvent event) {
  final callId = event.body['id'] as String;
  // The server-side cleanupStaleCalls handles the status transition.
  // If the app is alive, also end locally.
  if (getIt.isRegistered<CallBloc>()) {
    final callBloc = getIt<CallBloc>();
    if (callBloc.state.callId == callId) {
      callBloc.add(const CallEvent.endCall());
    }
  }
}

void _handleCallCallback(CallEvent event, GoRouter router) {
  final extra = event.body['extra'] as Map<String, dynamic>? ?? {};
  final conversationId = extra['conversationId'] ?? '';
  if (conversationId.isNotEmpty) {
    router.go('/chat/conversation/$conversationId');
  }
}
```

### On App Launch (Terminated State)

When the user accepts a call while the app is killed, the app launches fresh.
Check for active calls on startup in `app.dart` or `main.dart`:

```dart
/// Call this after DI is configured and the GoRouter is available.
Future<void> checkForActiveCallOnLaunch(GoRouter router) async {
  final activeCalls = await FlutterCallkitIncoming.activeCalls();
  if (activeCalls is! List || activeCalls.isEmpty) return;

  final callData = activeCalls.first as Map<String, dynamic>;
  final callId = callData['id'] as String?;
  if (callId == null) return;

  final extra = callData['extra'] as Map<String, dynamic>? ?? {};
  final conversationId = extra['conversationId'] ?? '';
  final callType = (callData['type'] == 1) ? CallType.video : CallType.voice;

  final callBloc = getIt<CallBloc>();
  callBloc.add(CallEvent.incomingCall(
    callId: callId,
    callerName: callData['nameCaller'] ?? 'Unknown',
    callerAvatarUrl: callData['avatar'],
    callType: callType,
    conversationId: conversationId,
    callerId: extra['callerId'] ?? '',
  ));
  callBloc.add(const CallEvent.acceptCall());

  // Navigate to call screen
  router.go('/chat/conversation/$conversationId/call/$callId',
    extra: {'callType': callType.name},
  );
}
```

---

## 12. Call Screens (UI)

### Screen Orientation

The app locks to portrait in `main.dart`. Video calls should temporarily allow landscape:

```dart
// In VideoCallScreen.initState():
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
]);

// In VideoCallScreen.dispose():
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
]);
```

### Back Button Prevention

Both call screens must prevent accidental back navigation:

```dart
PopScope(
  canPop: false,
  onPopInvokedWithResult: (didPop, _) {
    if (!didPop) {
      // Show confirmation dialog or ignore
      _showEndCallConfirmation();
    }
  },
  child: Scaffold(...),
)
```

### Voice Call Screen Layout

```
┌──────────────────────────────────────┐
│               (back)                 │  Minimal AppBar
├──────────────────────────────────────┤
│                                      │
│           ┌──────────┐               │
│           │  Avatar  │               │
│           │  (80px)  │               │
│           └──────────┘               │
│                                      │
│          "Lance"                     │  Remote user name
│          "02:34"                     │  Call duration timer
│          OR "Ringing..."             │  Status text
│       ┌──┐  (connection indicator)   │
│                                      │
│  ┌────────┐  ┌────────┐  ┌────────┐ │
│  │  Mute  │  │Speaker │  │ Video  │ │  Toggle buttons (56px)
│  └────────┘  └────────┘  └────────┘ │
│          ┌──────────┐                │
│          │   End    │                │  Red circular button (64px)
│          └──────────┘                │
└──────────────────────────────────────┘
```

### Video Call Screen Layout

```
┌──────────────────────────────────────┐
│         Remote video (full)          │
│                                      │
│                              ┌─────┐ │
│                              │Local│ │  Draggable PiP (120x160)
│                              │prev │ │  Mirror when front camera
│                              └─────┘ │
│                                      │
│         "Lance"  02:34               │  Overlay text
│                                      │
│  ┌──────┐┌──────┐┌──────┐┌──────┐  │
│  │ Mute ││Camera││ Flip ││ End  │  │  Bottom control bar
│  └──────┘└──────┘└──────┘└──────┘  │
└──────────────────────────────────────┘
```

### RTCVideoRenderer Usage (Correct Async Initialization)

```dart
class _VideoCallScreenState extends State<VideoCallScreen> {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  bool _renderersReady = false;

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    if (mounted) {
      setState(() => _renderersReady = true);
    }

    // Subscribe to WebRTC streams
    final webRtcService = /* get from BLoC or provider */;
    webRtcService.onLocalStream.listen((stream) {
      if (mounted) _localRenderer.srcObject = stream;
    });
    webRtcService.onRemoteStream.listen((stream) {
      if (mounted) _remoteRenderer.srcObject = stream;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_renderersReady) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) { /* ... */ },
      child: Scaffold(
        body: Stack(
          children: [
            // Remote video (full screen)
            RTCVideoView(
              _remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              // Do NOT mirror remote video
            ),
            // Local video (PiP) — draggable
            Positioned(
              right: 16,
              top: MediaQuery.of(context).padding.top + 16,
              child: SizedBox(
                width: 120,
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: RTCVideoView(
                    _localRenderer,
                    mirror: _isFrontCamera, // Mirror only for front camera
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ),
            ),
            // Controls overlay...
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Correct disposal order:
    // 1. Clear srcObject BEFORE disposing renderers
    _localRenderer.srcObject = null;
    _remoteRenderer.srcObject = null;
    // 2. Dispose renderers
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    // 3. Re-lock orientation (video call screen)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
```

**Disposal order (critical — incorrect order causes native crashes on iOS):**
```
1. Stop all MediaStreamTracks      (WebRtcService.dispose())
2. Dispose MediaStream             (WebRtcService.dispose())
3. Close RTCPeerConnection         (WebRtcService.dispose())
4. Clear srcObject on renderers    (Screen.dispose() — BEFORE step 5)
5. Dispose RTCVideoRenderers       (Screen.dispose())
```

Steps 1-3 are handled by `WebRtcService.dispose()` (called from `CallBloc._cleanup()`).
Steps 4-5 are handled by the screen widget's `dispose()`.
The BLoC cleanup runs first (triggered by `endCall`), then the screen disposes.

---

## 13. Quality Monitoring & Adaptive Bitrate

Poll `getStats()` every 3 seconds for voice calls, every 2 seconds for video calls.

### Key Metrics and Thresholds

| Metric | Excellent | Good | Fair | Poor |
|--------|-----------|------|------|------|
| RTT | < 80ms | < 150ms | < 300ms | > 300ms |
| Packet Loss | < 0.5% | < 1% | < 5% | > 5% |
| Jitter | < 30ms | < 50ms | < 100ms | > 100ms |
| Audio Bitrate | > 40 kbps | > 30 kbps | > 20 kbps | < 20 kbps |
| Video Bitrate (480p) | > 500 kbps | > 350 kbps | > 200 kbps | < 200 kbps |

### Call Quality Monitor Implementation

```dart
// lib/core/services/call_quality_monitor.dart
@lazySingleton
class CallQualityMonitor {
  Timer? _timer;
  final _controller = StreamController<ConnectionQuality>.broadcast();
  ConnectionQuality _lastQuality = ConnectionQuality.excellent;

  /// Start monitoring. Returns a stream of quality assessments.
  /// Debounces quality transitions — only emits when quality changes
  /// and stays at the new level for 2 consecutive polls.
  Stream<ConnectionQuality> startMonitoring(RTCPeerConnection? pc) {
    stop();
    if (pc == null) return _controller.stream;

    int consecutiveCount = 0;
    ConnectionQuality pendingQuality = ConnectionQuality.excellent;

    _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      try {
        final stats = await pc.getStats();
        final quality = _assessQuality(stats);

        if (quality == pendingQuality) {
          consecutiveCount++;
        } else {
          pendingQuality = quality;
          consecutiveCount = 1;
        }

        // Only emit after 2 consecutive polls at the same level
        if (consecutiveCount >= 2 && quality != _lastQuality) {
          _lastQuality = quality;
          if (!_controller.isClosed) {
            _controller.add(quality);
          }

          // Adapt video bitrate based on quality
          _adaptBitrate(pc, quality);
        }
      } catch (e) {
        debugPrint('Quality monitor error: $e');
      }
    });

    return _controller.stream;
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _lastQuality = ConnectionQuality.excellent;
  }

  ConnectionQuality _assessQuality(List<StatsReport> stats) {
    double rtt = 0;
    double packetLoss = 0;
    double jitter = 0;

    for (final report in stats) {
      if (report.type == 'candidate-pair' && report.values['state'] == 'succeeded') {
        rtt = (report.values['currentRoundTripTime'] as num?)?.toDouble() ?? 0;
        rtt *= 1000; // Convert to ms
      }
      if (report.type == 'inbound-rtp') {
        packetLoss = (report.values['packetsLost'] as num?)?.toDouble() ?? 0;
        final received = (report.values['packetsReceived'] as num?)?.toDouble() ?? 1;
        packetLoss = (packetLoss / (packetLoss + received)) * 100;
        jitter = ((report.values['jitter'] as num?)?.toDouble() ?? 0) * 1000;
      }
    }

    if (rtt > 300 || packetLoss > 5 || jitter > 100) return ConnectionQuality.poor;
    if (rtt > 150 || packetLoss > 1 || jitter > 50) return ConnectionQuality.fair;
    if (rtt > 80 || packetLoss > 0.5 || jitter > 30) return ConnectionQuality.good;
    return ConnectionQuality.excellent;
  }

  /// Adjust video encoding parameters based on measured quality.
  Future<void> _adaptBitrate(RTCPeerConnection pc, ConnectionQuality quality) async {
    final (maxBitrate, maxFramerate) = switch (quality) {
      ConnectionQuality.excellent => (1500000, 30),  // 1.5 Mbps, 30fps
      ConnectionQuality.good => (800000, 24),         // 800 kbps, 24fps
      ConnectionQuality.fair => (400000, 15),          // 400 kbps, 15fps
      ConnectionQuality.poor => (150000, 10),          // 150 kbps, 10fps
    };

    try {
      final senders = await pc.getSenders();
      for (final sender in senders) {
        if (sender.track?.kind == 'video') {
          final params = sender.parameters;
          if (params.encodings != null && params.encodings!.isNotEmpty) {
            params.encodings!.first.maxBitrate = maxBitrate;
            params.encodings!.first.maxFramerate = maxFramerate;
            await sender.setParameters(params);
          }
        }
      }
    } catch (e) {
      debugPrint('Adaptive bitrate error: $e');
    }
  }
}
```

### UI Indicator

```dart
Widget buildConnectionIndicator(ConnectionQuality quality) {
  final (icon, color, label) = switch (quality) {
    ConnectionQuality.excellent => (Icons.signal_cellular_4_bar, Colors.green, ''),
    ConnectionQuality.good => (Icons.signal_cellular_3_bar, Colors.green, ''),
    ConnectionQuality.fair => (Icons.signal_cellular_2_bar, Colors.orange, 'Weak connection'),
    ConnectionQuality.poor => (Icons.signal_cellular_1_bar, Colors.red, 'Poor connection'),
  };
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: color, size: 16),
      if (label.isNotEmpty) ...[
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: color, fontSize: 12)),
      ],
    ],
  );
}
```

---

## 14. Reconnection & Error Handling

### ICE Disconnection Recovery

```
ICE connected ──► ICE disconnected ──(3s grace)──► restartIce()
                                                      │
                                            success ──┤── timeout (5s)
                                               │      │
                                            ACTIVE    ├──► restartIce() (attempt 2)
                                                      │         │
                                            success ──┤── timeout (5s)
                                               │      │
                                            ACTIVE    ├──► restartIce() (attempt 3)
                                                      │         │
                                            success ──┤── timeout (5s)
                                               │      │
                                            ACTIVE    └──► endCall(reconnection_failed)
```

**Timing:**
- **3 seconds** grace period after `disconnected` before first restart attempt
- **3 attempts** maximum before giving up
- `_iceRestartAttempts` resets to 0 on successful reconnection (`connected` state)
- Total reconnection window: ~18 seconds

### ICE Restart Implementation

ICE restart is triggered via `pc.restartIce()`, which fires `onRenegotiationNeeded`,
which is handled by `PerfectNegotiationHandler`. This ensures the restart offer goes
through the same negotiation path as the initial connection — no glare possible.

**IMPORTANT:** Do NOT manually call `createOffer(iceRestart: true)`. That bypasses
Perfect Negotiation. Always use `pc.restartIce()` and let the handler manage it.

### Heartbeat-Based Crash Detection

During active calls, each peer writes a heartbeat timestamp to Firestore every
5 seconds. Each peer monitors the other's heartbeat via the call document watcher.
If stale by > 15 seconds (3 missed beats), the peer is presumed offline.

**Server-side safety net:** The `cleanupStaleCalls` scheduled function (runs every
minute) catches calls where BOTH peers crashed — no heartbeat for 30+ seconds.

**Firestore cost:** ~120 writes per peer per 10-minute call. Negligible.

---

## 15. Voice-to-Video Upgrade

Uses a **consent-based** upgrade flow with Firestore signaling:

### Flow

```
Peer A (requests upgrade)          Firestore              Peer B (receives request)
  │                                   │                          │
  │── requestVideoUpgrade() ────────►│                          │
  │   videoUpgradeRequest: 'pending'  │── doc update ──────────►│
  │   videoUpgradeRequesterId: A      │                          │
  │                                   │              UI prompt:  │
  │                                   │  "A wants to video call" │
  │                                   │    [Accept] [Decline]    │
  │                                   │                          │
  │                                   │◄── respondVideoUpgrade()─│
  │                                   │    accepted/declined     │
  │◄── doc update ────────────────────│                          │
  │                                   │                          │
  │  if accepted:                     │        if accepted:      │
  │    upgradeToVideo()               │        upgradeToVideo()  │
  │    (replaceTrack + setDirection)  │                          │
  │    (triggers renegotiation via    │                          │
  │     Perfect Negotiation)          │                          │
```

### Technical Details

1. `replaceTrack()` does NOT trigger SDP renegotiation
2. `setDirection(SendRecv)` DOES fire `onRenegotiationNeeded`
3. `PerfectNegotiationHandler` handles the resulting offer/answer automatically
4. Both peers must call `upgradeToVideo()` — one sends video, the other enables receive
5. The `callType` on the Firestore doc is updated to `'video'` after both accept

---

## 16. System Message Rendering

Extend `_buildSystemMessage()` in `message_bubble.dart` to render call events:

```dart
// In lib/presentation/widgets/messaging/message_bubble.dart
// Modify _buildSystemMessage() to add call event handling:

Widget _buildSystemMessage(BuildContext context) {
  final isDisappearingEvent =
      message.systemEventType == 'disappearing_messages_changed';
  final isCallEvent = message.systemEventType == 'call_ended';

  IconData? icon;
  if (isDisappearingEvent) {
    icon = Icons.timer_outlined;
  } else if (isCallEvent) {
    final callData = message.systemEventData ?? {};
    final callType = callData['callType'] as String?;
    final endReason = callData['endReason'] as String?;
    if (endReason == 'missed') {
      icon = Icons.call_missed;
    } else if (callType == 'video') {
      icon = Icons.videocam;
    } else {
      icon = Icons.call;
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.chatSurface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                message.textContent ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
```

The `textContent` field is populated by the Cloud Function with human-readable text
like "Voice call, 2:34" or "Missed video call", so the widget just renders it.
The icon is derived from `systemEventData.callType` and `systemEventData.endReason`.

---

## 17. Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    match /calls/{callId} {
      // Only caller or callee can read
      allow read: if request.auth != null && (
        resource.data.callerId == request.auth.uid ||
        resource.data.calleeId == request.auth.uid
      );

      // Creation only via Cloud Function (admin SDK bypasses rules).
      // If client-side creation is needed, validate caller is participant:
      allow create: if false; // Cloud Function only

      // Participants can update, with field-level restrictions:
      // - Caller can write: offer, callerHeartbeat, iceRestartCount
      // - Callee can write: answer, calleeHeartbeat, videoUpgradeRequest (response)
      // - Either can write: status (but only to terminal states)
      allow update: if request.auth != null && (
        resource.data.callerId == request.auth.uid ||
        resource.data.calleeId == request.auth.uid
      ) && (
        // Caller-specific fields
        (request.auth.uid == resource.data.callerId && (
          request.resource.data.diff(resource.data).affectedKeys()
            .hasOnly(['offer', 'callerHeartbeat', 'iceRestartCount', 'videoUpgradeRequest', 'videoUpgradeRequesterId'])
        ))
        ||
        // Callee-specific fields
        (request.auth.uid == resource.data.calleeId && (
          request.resource.data.diff(resource.data).affectedKeys()
            .hasOnly(['answer', 'calleeHeartbeat', 'videoUpgradeRequest'])
        ))
      );

      // Deletion only via TTL or Cloud Functions
      allow delete: if false;

      // Caller's ICE candidates — only caller can write, both can read
      match /callerCandidates/{candidateId} {
        allow read: if request.auth != null && (
          get(/databases/$(database)/documents/calls/$(callId)).data.callerId == request.auth.uid ||
          get(/databases/$(database)/documents/calls/$(callId)).data.calleeId == request.auth.uid
        );
        allow create: if request.auth != null &&
          get(/databases/$(database)/documents/calls/$(callId)).data.callerId == request.auth.uid;
      }

      // Callee's ICE candidates — only callee can write, both can read
      match /calleeCandidates/{candidateId} {
        allow read: if request.auth != null && (
          get(/databases/$(database)/documents/calls/$(callId)).data.callerId == request.auth.uid ||
          get(/databases/$(database)/documents/calls/$(callId)).data.calleeId == request.auth.uid
        );
        allow create: if request.auth != null &&
          get(/databases/$(database)/documents/calls/$(callId)).data.calleeId == request.auth.uid;
      }
    }
  }
}
```

**Security improvements over original plan:**
1. **Create is `false`** — call creation only via Cloud Function (server-validated)
2. **Field-level update restrictions** — caller can only write caller fields, callee only callee fields
3. **No client-side status transitions** — `answerCall` and `endCall` go through Cloud Functions
4. Subcollection rules use `get()` on parent (1 extra read per eval, ~30-50 per call, negligible)

---

## 18. Router Integration

In `lib/presentation/router/app_router.dart`, add under the conversation routes:

```dart
// Under the /chat/conversation/:conversationId route's `routes: [...]`:
GoRoute(
  path: 'call/:callId',
  name: 'call',
  builder: (context, state) {
    final callId = state.pathParameters['callId'] ?? '';
    final extra = state.extra as Map<String, dynamic>? ?? {};
    final callType = extra['callType'] as String? ?? 'voice';
    return callType == 'video'
        ? VideoCallScreen(callId: callId)
        : VoiceCallScreen(callId: callId);
  },
),
```

**Conversation detail AppBar** — add call buttons. Guard for P2P conversations only
(`ConversationType.p2p`):

```dart
// In conversation_detail_screen.dart AppBar actions:
actions: [
  // Call buttons — only for P2P conversations
  if (conv.type == ConversationType.p2p) ...[
    IconButton(
      icon: const Icon(Icons.call, size: 22),
      onPressed: () => _initiateCall(CallType.voice),
      tooltip: 'Voice call',
    ),
    IconButton(
      icon: const Icon(Icons.videocam, size: 22),
      onPressed: () => _initiateCall(CallType.video),
      tooltip: 'Video call',
    ),
  ],
  // Existing buttons
  IconButton(
    icon: const Icon(Icons.search),
    onPressed: () { /* ... */ },
  ),
  IconButton(
    icon: const Icon(Icons.more_vert),
    onPressed: () { /* ... */ },
  ),
],
```

The `_initiateCall` method dispatches to `CallBloc` and navigates:

```dart
void _initiateCall(CallType callType) {
  final other = conversation.getOtherParticipant(currentUserId);
  final callBloc = getIt<CallBloc>();
  callBloc.add(CallEvent.initiateCall(
    conversationId: conversation.id,
    recipientId: other.userId,
    recipientName: other.displayName,
    recipientAvatarUrl: other.avatarUrl,
    callType: callType,
  ));

  // Navigate after BLoC creates the call (listen for callId)
  callBloc.stream.firstWhere((s) => s.callId != null).then((s) {
    if (mounted) {
      context.go(
        '/chat/conversation/${conversation.id}/call/${s.callId}',
        extra: {'callType': callType.name},
      );
    }
  });
}
```

---

## 19. Cleanup & Lifecycle

### Call End Cleanup (Orchestrated)

1. **User taps End** → `CallBloc.add(EndCall())`
2. **CallBloc._onEndCall():**
   a. Calls `callRepository.endCall()` (Cloud Function — idempotent, first-writer-wins)
   b. Calls `FlutterCallkitIncoming.endCall(callId)` (dismiss native UI)
   c. Calls `_cleanup()`:
      - Cancel all timers (call, heartbeat, ring, ICE grace)
      - Cancel all stream subscriptions (call doc, ICE candidates, ICE state, quality)
      - Stop quality monitor
      - `WebRtcService.dispose()` — stops tracks, disposes stream, closes PC
3. **Screen widget `dispose()`:**
   - Clear `srcObject` on both renderers
   - Dispose both `RTCVideoRenderer`s
   - Re-lock orientation to portrait
4. **Cloud Function `endCall`:**
   - Updates call doc status (idempotent — skips if already terminal)
   - Writes system message to chat (only on first call)
5. **Firestore trigger `onCallUpdated`:**
   - Deletes ICE candidate subcollections
6. **Firestore TTL:**
   - Auto-deletes call document ~1 hour after `expireAt`

### Wakelock

Enable wakelock when call becomes active, disable on cleanup:

```dart
// In CallBloc, when transitioning to active:
WakelockPlus.enable();

// In CallBloc._cleanup():
WakelockPlus.disable();
```

---

## 20. Testing Strategy

### Unit Tests

**CallBloc state machine** — test all transitions with `blocTest<CallBloc, CallState>()`:
```dart
blocTest<CallBloc, CallState>(
  'initiateCall transitions to ringing',
  build: () {
    when(() => callRepository.initiateCall(...)).thenAnswer((_) async => 'call123');
    when(() => callRepository.getTurnCredentials()).thenAnswer((_) async => {...});
    return CallBloc(callRepository, webRtcFactory, signalingService, qualityMonitor);
  },
  act: (bloc) => bloc.add(CallEvent.initiateCall(...)),
  expect: () => [
    isA<CallState>().having((s) => s.status, 'status', CallStatus.ringing),
  ],
);
```

**CallSignalingService** — mock `FirebaseFirestore`, verify document reads/writes:
```dart
test('sendIceCandidate writes to correct subcollection', () async {
  await service.sendIceCandidate(callId, candidate, isCaller: true);
  verify(() => mockCallDoc.collection('callerCandidates').add(any())).called(1);
});
```

**CallQualityMonitor** — feed mock stats, verify quality assessment and adaptive bitrate.

**WebRtcService** — mock `flutter_webrtc` globals (`createPeerConnection`, `navigator.mediaDevices`):
```dart
// Use registerFallbackValue and when() from mocktail to mock WebRTC
registerFallbackValue(FakeRTCIceCandidate());
when(() => mockPc.addIceCandidate(any())).thenAnswer((_) async {});
```

### Cloud Function Tests

Add to `functions/src/__tests__/calls.test.ts`:
```typescript
describe('initiateCall', () => {
  it('creates call document with correct fields', ...);
  it('prevents duplicate active calls (transaction)', ...);
  it('rejects non-participant', ...);
  it('sends FCM notification', ...);
});

describe('endCall', () => {
  it('is idempotent — second call is no-op', ...);
  it('writes system message only once', ...);
  it('calculates duration correctly', ...);
});

describe('answerCall', () => {
  it('validates callee identity', ...);
  it('rejects answering ended call', ...);
});

describe('cleanupStaleCalls', () => {
  it('marks ringing calls as missed after 30s', ...);
  it('ends active calls with stale heartbeats', ...);
});
```

### Widget Tests

```dart
testWidgets('VoiceCallScreen shows timer when active', (tester) async {
  // Provide mocked CallBloc with active state
  await tester.pumpWidget(
    BlocProvider.value(
      value: mockCallBloc,
      child: const MaterialApp(home: VoiceCallScreen(callId: 'test')),
    ),
  );
  expect(find.text('00:00'), findsOneWidget);
});
```

### Integration / Manual Testing Checklist

1. Voice call: initiate → ring → accept → talk → end → system message in chat
2. Video call: same flow + verify local/remote video renders correctly
3. Missed call: initiate → wait 30s → verify missed status + notification
4. Decline call: initiate → callee declines → verify declined status
5. Caller cancels: initiate → caller hangs up before answer
6. Voice-to-video upgrade: start voice → request upgrade → remote accepts → cameras activate
7. Voice-to-video decline: start voice → request upgrade → remote declines → stays voice
8. Camera switch: during video → tap flip → switches front/back
9. Mute/unmute: verify audio toggling
10. Speaker toggle: verify audio routing change
11. App backgrounded: call continues (wakelock + foreground service)
12. App killed (receiver): FCM/VoIP push → native call UI → accept → call screen
13. Network switch (WiFi → cellular): verify ICE restart recovers
14. Poor network: verify quality indicator + adaptive bitrate
15. Both peers end simultaneously: verify only one system message appears
16. Back button during call: verify prevention (PopScope)
17. Busy detection: call user already on a call → verify behavior
18. Permission denied: deny microphone → verify error handling

---

## 21. Future: Group Calls

**P2P mesh breaks at 3-4 participants** (N×(N-1)/2 connections, N-1 uploads per user).

**Recommended architecture:**

| Scenario | Transport | Cost |
|----------|-----------|------|
| 1:1 calls | P2P via flutter_webrtc + Firestore signaling | Free (no server) |
| 3+ participants | SFU via LiveKit | LiveKit Cloud or self-hosted |

**LiveKit** has an official Flutter SDK (`livekit_client`) with iOS, Android, and
Web support. It handles simulcast, quality adaptation, reconnection, and can be
self-hosted or used via LiveKit Cloud.

The P2P 1:1 infrastructure built in this plan coexists cleanly alongside LiveKit
for group calls — they use different code paths and the CallBloc can route to
the appropriate implementation based on participant count.

---

## 22. Implementation Phases

### Prerequisites (Before Phase 1)

- [ ] Create Cloudflare TURN application at `dash.cloudflare.com → Calls → TURN`
- [ ] Store Cloudflare Key ID and API Token in Firebase Functions environment config
- [ ] Enable Firestore TTL policy on `calls` collection with `expireAt` field
- [ ] Obtain Apple `.p8` VoIP push key from Apple Developer portal
- [ ] Store APNs key, key ID, and team ID in Functions environment config

### Phase 1: Core Voice Calling (Week 1-2)

**New files:**
- `lib/core/services/webrtc_service.dart` (per-call instance + factory)
- `lib/core/services/call_signaling_service.dart`
- `lib/domain/entities/call_session.dart`
- `lib/domain/enums/call_status.dart`
- `lib/domain/enums/call_type.dart`
- `lib/domain/enums/connection_quality.dart`
- `lib/domain/repositories/call_repository.dart`
- `lib/data/repositories/call_repository_impl.dart`
- `lib/data/datasources/remote/call_remote_datasource.dart`
- `lib/data/models/call_session_model.dart`
- `lib/presentation/blocs/call/call_bloc.dart`
- `lib/presentation/blocs/call/call_event.dart`
- `lib/presentation/blocs/call/call_state.dart`
- `lib/presentation/screens/messaging/voice_call_screen.dart`
- `functions/src/calls.ts`

**Modified files:**
- `pubspec.yaml` (add flutter_webrtc, flutter_callkit_incoming, wakelock_plus)
- `android/app/src/main/AndroidManifest.xml` (permissions)
- `android/app/proguard-rules.pro` (keep rules)
- `ios/Runner/Info.plist` (voip background mode, updated usage descriptions)
- `lib/presentation/router/app_router.dart` (call route)
- `lib/presentation/screens/messaging/conversation_detail_screen.dart` (call buttons, P2P guard)
- `lib/core/di/register_module.dart` (register WebRtcServiceFactory, CallSignalingService)
- `functions/src/index.ts` (export call functions)

**Run after:** `dart run build_runner build --delete-conflicting-outputs`

**Deliverables:**
- Voice call: initiate, ring, accept, talk, end (via Perfect Negotiation)
- Call buttons in conversation AppBar (P2P only)
- System message in chat after call ends
- Firestore security rules for calls collection
- TURN credentials via Cloud Function
- Server-side ring timeout + stale call cleanup
- Idempotent endCall (safe for both peers to call)

### Phase 2: Incoming Call UI + Notifications (Week 2-3)

**Modified files:**
- `lib/core/services/notification_service.dart` (add call event handlers)
- `lib/main.dart` (extend background handler for incoming_call, add launch check)
- `ios/Runner/AppDelegate.swift` (PushKit integration, VoIP token registration)

**New files:**
- `functions/src/__tests__/calls.test.ts`

**Deliverables:**
- Native incoming call UI (Android full-screen notification, iOS CallKit)
- Call from killed app state (PushKit on iOS, FCM high-priority on Android)
- VoIP token registration (iOS → Firestore)
- Missed call notification with callback button
- `answerCall` Cloud Function (server-validated)
- Cloud Function tests
- Permission requests (microphone, camera, notification, full-screen intent)

### Phase 3: Video Calling (Week 3-4)

**New files:**
- `lib/presentation/screens/messaging/video_call_screen.dart`

**Modified files:**
- `lib/presentation/widgets/messaging/message_bubble.dart` (call system message rendering)

**Deliverables:**
- Video call screen with local PiP + remote full screen
- Camera switch (front/back)
- Video toggle (on/off)
- Screen orientation unlock for video calls
- PopScope back-button prevention
- Correct renderer initialization (async) and disposal order
- Call system message rendering (icon + text)

### Phase 4: Quality, Resilience & Upgrade (Week 4)

**New files:**
- `lib/core/services/call_quality_monitor.dart`

**Deliverables:**
- Connection quality monitoring (RTT, packet loss, jitter) with debounce
- Adaptive bitrate (degrade video quality on poor network)
- Quality indicator in call UI (signal bars)
- ICE restart reconnection via `restartIce()` (3 attempts, reset on success)
- Heartbeat-based crash detection (server-side safety net)
- Voice-to-video upgrade with remote consent (Firestore signaling)
- Wakelock during calls (screen stays on)

### Phase 5: Polish & Edge Cases (Week 5)

**Deliverables:**
- Call while app is backgrounded (foreground service on Android)
- Busy detection (callee already on another call)
- Call audio routing (earpiece vs speaker vs Bluetooth)
- Permission denial handling (graceful error)
- Duplicate endCall safety (idempotent — tested)
- Comprehensive testing across devices (checklist above)
- Widget tests for call screens
- Integration test: full call flow with mocked WebRTC

---

## Appendix: Perfect Negotiation Pattern

All SDP negotiation goes through this single handler. No manual `createOffer()`
or `createAnswer()` calls elsewhere in the codebase.

```dart
/// Implements the W3C Perfect Negotiation pattern.
/// Eliminates SDP glare by assigning asymmetric roles:
/// - Caller = impolite peer (ignores colliding offers)
/// - Callee = polite peer (rolls back its own offer on collision)
class PerfectNegotiationHandler {
  final RTCPeerConnection pc;
  final bool polite; // true for callee, false for caller
  final Future<void> Function(RTCSessionDescription) sendDescription;

  bool _makingOffer = false;
  bool _ignoreOffer = false;
  bool _isSettingRemoteAnswerPending = false;

  PerfectNegotiationHandler({
    required this.pc,
    required this.polite,
    required this.sendDescription,
  }) {
    pc.onRenegotiationNeeded = () async {
      try {
        _makingOffer = true;
        final offer = await pc.createOffer({});
        // Check if signaling state changed during async gap
        if (pc.signalingState != RTCSignalingState.RTCSignalingStateStable) {
          return; // Another negotiation started — bail
        }
        await pc.setLocalDescription(offer);
        final localDesc = pc.localDescription;
        if (localDesc != null) {
          await sendDescription(localDesc);
        }
      } catch (e) {
        debugPrint('PerfectNegotiation: offer error: $e');
      } finally {
        _makingOffer = false;
      }
    };
  }

  Future<void> handleDescription(RTCSessionDescription description) async {
    final readyForOffer = !_makingOffer &&
        (pc.signalingState == RTCSignalingState.RTCSignalingStateStable ||
            _isSettingRemoteAnswerPending);
    final offerCollision = description.type == 'offer' && !readyForOffer;

    _ignoreOffer = !polite && offerCollision;
    if (_ignoreOffer) return;

    // Polite peer: if we have a pending offer and receive one, rollback first
    if (polite && offerCollision) {
      try {
        await pc.setLocalDescription(
          RTCSessionDescription(null, 'rollback'),
        );
      } catch (e) {
        // Implicit rollback may work on some implementations — continue
        debugPrint('PerfectNegotiation: explicit rollback failed (may be implicit): $e');
      }
    }

    _isSettingRemoteAnswerPending = description.type == 'answer';
    await pc.setRemoteDescription(description);
    _isSettingRemoteAnswerPending = false;

    if (description.type == 'offer') {
      final answer = await pc.createAnswer({});
      await pc.setLocalDescription(answer);
      final localDesc = pc.localDescription;
      if (localDesc != null) {
        await sendDescription(localDesc);
      }
    }
  }

  Future<void> handleCandidate(RTCIceCandidate candidate) async {
    try {
      await pc.addIceCandidate(candidate);
    } catch (e) {
      if (!_ignoreOffer) rethrow;
      // Suppress candidate errors for ignored offers
    }
  }
}
```

**Key differences from original plan:**
1. Added explicit rollback for the polite peer (not relying on implicit rollback)
2. Added signaling state check after async `createOffer()` gap
3. Null-safe `localDescription` access (no force-unwrap)
4. This is the ONLY place offers and answers are created — no manual calls elsewhere
