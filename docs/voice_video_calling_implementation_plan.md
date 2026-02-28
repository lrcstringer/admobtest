# Voice & Video Calling Implementation Plan

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
15. [Perfect Negotiation Pattern](#15-perfect-negotiation-pattern)
16. [Voice-to-Video Upgrade](#16-voice-to-video-upgrade)
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
  'iceCandidatePoolSize': 1,         // Prefetch 1 candidate for faster setup
  'sdpSemantics': 'unified-plan',    // Modern standard (plan-b is deprecated)
};
```

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

// For Cloudflare TURN:
export const getTurnCredentials = onCall(
  { labels: { area: 'social' } },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError('unauthenticated', 'Auth required');
    }

    const response = await fetch(
      'https://rtc.live.cloudflare.com/v1/turn/keys/<KEY_ID>/credentials/generate',
      {
        method: 'POST',
        headers: {
          'Authorization': 'Bearer <API_TOKEN>',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ ttl: 86400 }), // 24-hour TTL
      },
    );

    const turnCreds = await response.json();
    return {
      iceServers: [
        { urls: 'stun:stun.l.google.com:19302' },
        { urls: 'stun:stun1.l.google.com:19302' },
        ...turnCreds.iceServers,
      ],
      ttl: 86400,
    };
  },
);
```

---

## 3. Firestore Data Model

### Collection: `calls/{callId}`

```
calls/{callId}
  ├── callId: string                // Auto-generated document ID
  ├── conversationId: string        // Parent conversation (p2p_user1_user2)
  ├── callerId: string              // UID of initiator
  ├── calleeId: string              // UID of recipient
  ├── callType: string              // 'voice' | 'video'
  ├── status: string                // 'ringing' | 'active' | 'ended' | 'missed' | 'declined' | 'cancelled' | 'failed'
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
  ├── callerHeartbeat: Timestamp    // Updated every 5s during active call
  ├── calleeHeartbeat: Timestamp    // Updated every 5s during active call
  ├── iceRestartCount: int          // Track ICE restart attempts
  │
  ├── createdAt: Timestamp
  ├── answeredAt: Timestamp | null
  ├── endedAt: Timestamp | null
  ├── endReason: string | null      // 'normal' | 'missed' | 'declined' | 'cancelled' | 'error' | 'peer_offline'
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

### No Changes to Existing `conversations` Collection

Call history is recorded as system messages in the existing chat (like WhatsApp's
"Voice call, 2:34" bubbles), using the existing `MessageType.system` +
`systemEventType: 'call_ended'` fields. No new fields on the conversation document.

---

## 4. Cloud Functions (Backend)

### File: `functions/src/calls.ts`

```typescript
import { onCall, HttpsError } from 'firebase-functions/v2/https';
import * as admin from 'firebase-admin';

const db = admin.firestore();

function requireAuth(request: { auth?: { uid: string } }): string {
  if (!request.auth) {
    throw new HttpsError('unauthenticated', 'User must be authenticated');
  }
  return request.auth.uid;
}

// ─── initiateCall ──────────────────────────────────────────────────────

export const initiateCall = onCall(
  { labels: { area: 'social' } },
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

    // Verify conversation exists and user is participant
    const convDoc = await db.collection('conversations').doc(conversationId).get();
    if (!convDoc.exists) {
      throw new HttpsError('not-found', 'Conversation not found');
    }
    const conv = convDoc.data()!;
    if (!conv.participantIds?.includes(userId)) {
      throw new HttpsError('permission-denied', 'Not a participant');
    }

    // Prevent duplicate active calls
    const activeCalls = await db
      .collection('calls')
      .where('conversationId', '==', conversationId)
      .where('status', 'in', ['ringing', 'active'])
      .limit(1)
      .get();
    if (!activeCalls.empty) {
      throw new HttpsError('already-exists', 'Call already in progress');
    }

    const callRef = db.collection('calls').doc();
    const now = admin.firestore.FieldValue.serverTimestamp();

    await callRef.set({
      callId: callRef.id,
      conversationId,
      callerId: userId,
      calleeId: recipientId,
      callType,
      status: 'ringing',
      offer: null,
      answer: null,
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

    // ── Send push notification to recipient ──

    // Android: FCM high-priority data message
    const recipientDoc = await db.collection('users').doc(recipientId).get();
    const fcmToken = recipientDoc.data()?.fcmToken;
    const callerName =
      conv.participants?.[userId]?.displayName || 'Someone';
    const callerAvatar =
      conv.participants?.[userId]?.avatarUrl || '';

    if (fcmToken) {
      await admin.messaging().send({
        token: fcmToken,
        // Data-only message (no 'notification' field) — triggers onBackgroundMessage
        data: {
          type: 'incoming_call',
          callId: callRef.id,
          callType,
          conversationId,
          callerName,
          callerId: userId,
          callerAvatar,
        },
        android: {
          priority: 'high',  // Wake the device from Doze
          ttl: 30_000,       // 30s — matches ring timeout
        },
        apns: {
          headers: { 'apns-priority': '10' }, // Immediate delivery
          payload: {
            aps: {
              contentAvailable: true,
              sound: 'ringtone.caf',
            },
          },
        },
      });
    }

    // iOS: VoIP push via APNs (handled by AppDelegate PushKit integration)
    // The VoIP token is stored separately; see section 11 for iOS-specific flow.
    const voipToken = recipientDoc.data()?.voipToken;
    if (voipToken) {
      // APNs VoIP push — see section 11 for the @parse/node-apn implementation
      // This is the ONLY reliable way to wake a killed iOS app for calls
      await sendVoipPush(voipToken, {
        callId: callRef.id,
        callerName,
        handle: callerName,
        type: callType === 'video' ? 1 : 0,
      });
    }

    return { success: true, callId: callRef.id };
  },
);

// ─── endCall ───────────────────────────────────────────────────────────

export const endCall = onCall(
  { labels: { area: 'social' } },
  async (request) => {
    const userId = requireAuth(request);
    const { callId, reason } = request.data as {
      callId: string;
      reason?: string;
    };

    const callRef = db.collection('calls').doc(callId);
    const callDoc = await callRef.get();
    if (!callDoc.exists) {
      throw new HttpsError('not-found', 'Call not found');
    }

    const call = callDoc.data()!;
    if (call.callerId !== userId && call.calleeId !== userId) {
      throw new HttpsError('permission-denied', 'Not a participant');
    }

    // Calculate duration
    let durationSeconds: number | null = null;
    if (call.answeredAt) {
      const answeredMs = call.answeredAt.toDate().getTime();
      durationSeconds = Math.round((Date.now() - answeredMs) / 1000);
    }

    const endReason = reason || 'normal';
    const now = admin.firestore.FieldValue.serverTimestamp();

    await callRef.update({
      status: 'ended',
      endedAt: now,
      endReason,
      durationSeconds,
      // Set TTL for auto-cleanup (1 hour after end)
      expireAt: admin.firestore.Timestamp.fromDate(
        new Date(Date.now() + 3600_000),
      ),
    });

    // Write system message to conversation chat history
    const callLabel =
      call.callType === 'video' ? 'Video call' : 'Voice call';
    const durationText = durationSeconds
      ? _formatDuration(durationSeconds)
      : null;
    const systemText =
      endReason === 'missed'
        ? `Missed ${callLabel.toLowerCase()}`
        : endReason === 'declined'
          ? `${callLabel} declined`
          : endReason === 'cancelled'
            ? `Cancelled ${callLabel.toLowerCase()}`
            : `${callLabel}${durationText ? ', ' + durationText : ''}`;

    const msgRef = db
      .collection('conversations')
      .doc(call.conversationId)
      .collection('messages')
      .doc();

    await msgRef.set({
      id: msgRef.id,
      senderId: userId,
      senderName: '',
      senderAvatarUrl: null,
      type: 'system',
      status: 'sent',
      textContent: null,
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
        callId: callRef.id,
        callType: call.callType,
        callerId: call.callerId,
        calleeId: call.calleeId,
        durationSeconds,
        endReason,
      },
      createdAt: now,
      expiresAt: null,
      actionedAt: null,
      deletedAt: null,
      deletedFor: [],
      deletedForEveryone: false,
    });

    return { success: true };
  },
);

function _formatDuration(seconds: number): string {
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  return `${m}:${s.toString().padStart(2, '0')}`;
}

// ─── cleanupCallSignaling ──────────────────────────────────────────────
// Firestore trigger: when a call status changes to 'ended', 'missed',
// 'declined', 'cancelled', or 'failed', delete the ICE candidate
// subcollections. The parent document is cleaned up by Firestore TTL.

// NOTE: Use onDocumentUpdated from firebase-functions/v2/firestore
// export const cleanupCallSignaling = onDocumentUpdated(
//   'calls/{callId}',
//   async (event) => {
//     const after = event.data?.after.data();
//     const before = event.data?.before.data();
//     if (!after || !before) return;
//
//     const terminalStatuses = ['ended', 'missed', 'declined', 'cancelled', 'failed'];
//     if (terminalStatuses.includes(after.status) && !terminalStatuses.includes(before.status)) {
//       const callRef = event.data!.after.ref;
//       const batch = admin.firestore().batch();
//
//       const callerCands = await callRef.collection('callerCandidates').get();
//       callerCands.docs.forEach(doc => batch.delete(doc.ref));
//
//       const calleeCands = await callRef.collection('calleeCandidates').get();
//       calleeCands.docs.forEach(doc => batch.delete(doc.ref));
//
//       await batch.commit();
//     }
//   },
// );
```

**Export from `functions/src/index.ts`:**
```typescript
export { initiateCall, endCall, getTurnCredentials } from './calls';
```

---

## 5. Signaling Flow

### Sequence Diagram

```
Caller                     Firestore                    Receiver
  │                           │                            │
  │── initiateCall() ────────►│                            │
  │   (Cloud Function)        │── FCM data msg ───────────►│
  │                           │   type: 'incoming_call'    │
  │                           │                            │
  │   create PeerConnection   │                    show native call UI
  │   getUserMedia(audio)     │                    (flutter_callkit_incoming)
  │   createOffer()           │                            │
  │   setLocalDescription()   │                            │
  │                           │                            │
  │── write offer to doc ────►│                            │
  │                           │◄── listen call doc ────────│
  │                           │    (sees offer)            │
  │                           │                            │
  │── write ICE candidates ──►│          user taps Accept  │
  │   (callerCandidates/)     │                            │
  │                           │    create PeerConnection   │
  │                           │    getUserMedia(audio)     │
  │                           │    setRemoteDescription()  │
  │                           │    add buffered candidates │
  │                           │    createAnswer()          │
  │                           │    setLocalDescription()   │
  │                           │                            │
  │                           │◄── write answer to doc ────│
  │◄── listen call doc ───────│                            │
  │    (sees answer)          │                            │
  │    setRemoteDescription() │◄── write ICE candidates ──│
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
  │   (Cloud Function)        │── status: 'ended' ────────►│
  │                           │── system message to chat   │
  │                           │── cleanup subcollections   │
```

**Total Firestore operations per call:** ~30-50 documents (signaling only).
Once P2P connects, only heartbeat writes continue (~12/min per peer).

---

## 6. Platform Configuration

### Android

**`android/app/src/main/AndroidManifest.xml`** — add these permissions:

```xml
<!-- WebRTC -->
<uses-feature android:name="android.hardware.camera" />
<uses-feature android:name="android.hardware.camera.autofocus" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />

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

<!-- Battery optimization exemption (VoIP apps are allowed per Google Play policy) -->
<uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />
```

**Activity attributes** (in `<activity android:name=".MainActivity" ...>`):
```xml
android:showWhenLocked="true"
android:turnScreenOn="true"
```

**`android/app/proguard-rules.pro`** — add:
```
-keep class com.cloudwebrtc.webrtc.** { *; }
-keep class org.webrtc.** { *; }
-keep class com.hiennv.flutter_callkit_incoming.** { *; }
```

### iOS

**`ios/Runner/Info.plist`** — add:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>voip</string>
    <string>remote-notification</string>
    <string>processing</string>
</array>
<key>NSCameraUsageDescription</key>
<string>iMaliChat needs camera access for video calls</string>
<key>NSMicrophoneUsageDescription</key>
<string>iMaliChat needs microphone access for voice and video calls</string>
```

**Xcode Capabilities:**
1. Background Modes → Voice over IP, Remote notifications
2. Push Notifications (for PushKit VoIP push)

**`ios/Podfile`** — add post-install hook:
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
    end
  end
end
```

### iOS PushKit Integration (AppDelegate.swift)

PushKit is **mandatory for reliable incoming calls on iOS**. Regular FCM/APNs
cannot wake a killed app. PushKit can, but Apple requires you to report
a CallKit call in the **same run loop** as the push handler — failure to do so
causes iOS to terminate the app and stop delivering VoIP pushes.

```swift
// AppDelegate.swift
import PushKit
import flutter_callkit_incoming

func registerVoIPPush() {
    let voipRegistry = PKPushRegistry(queue: DispatchQueue.main)
    voipRegistry.delegate = self
    voipRegistry.desiredPushTypes = [.voIP]
}

func pushRegistry(_ registry: PKPushRegistry,
                  didUpdate credentials: PKPushCredentials,
                  for type: PKPushType) {
    let deviceToken = credentials.token
        .map { String(format: "%02x", $0) }
        .joined()
    // Send to Firestore: users/{uid}/voipToken
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

    // MUST report call to CallKit in the SAME run loop — no async delay
    let params: [String: Any] = [
        "id": id,
        "nameCaller": callerName,
        "handle": callerName,
        "type": callType,
    ]
    SwiftFlutterCallkitIncomingPlugin.sharedInstance?
        .showCallkitIncoming(params, fromPushKit: true)

    completion()
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
│   │   └── call_status.dart                 # ringing, active, ended, missed, ...
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
    required String callType,       // 'voice' | 'video'
    required CallStatus status,
    Map<String, String>? offer,     // {type, sdp}
    Map<String, String>? answer,    // {type, sdp}
    DateTime? createdAt,
    DateTime? answeredAt,
    DateTime? endedAt,
    String? endReason,
    int? durationSeconds,
  }) = _CallSession;
}
```

### Domain Enum

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
}
```

---

## 8. WebRTC Service

Core wrapper around `flutter_webrtc`. Handles peer connection lifecycle,
media streams, track management, and audio routing.

```dart
// lib/core/services/webrtc_service.dart
@lazySingleton
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

  // Stream controllers for UI
  final _remoteStreamController = StreamController<MediaStream?>.broadcast();
  final _localStreamController = StreamController<MediaStream?>.broadcast();
  final _connectionStateController = StreamController<RTCPeerConnectionState>.broadcast();
  final _iceConnectionStateController = StreamController<RTCIceConnectionState>.broadcast();

  Stream<MediaStream?> get onRemoteStream => _remoteStreamController.stream;
  Stream<MediaStream?> get onLocalStream => _localStreamController.stream;
  Stream<RTCPeerConnectionState> get onConnectionState => _connectionStateController.stream;
  Stream<RTCIceConnectionState> get onIceConnectionState => _iceConnectionStateController.stream;

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
      if (candidate.candidate != null) {
        onIceCandidate(candidate);
      }
    };

    _peerConnection!.onTrack = (event) {
      if (event.streams.isNotEmpty) {
        _remoteStream = event.streams.first;
        _remoteStreamController.add(_remoteStream);
      }
    };

    _peerConnection!.onConnectionState = (state) {
      _connectionStateController.add(state);
    };

    _peerConnection!.onIceConnectionState = (state) {
      _iceConnectionStateController.add(state);
    };

    // ── Acquire local media ──
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': {
        'echoCancellation': true,
        'noiseSuppression': true,
        'autoGainControl': true,
      },
      'video': isVideo
          ? {
              'mandatory': {
                'minWidth': '480',
                'minHeight': '640',
                'minFrameRate': '24',
              },
              'facingMode': 'user',
              'optional': [],
            }
          : false,
    });
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

  // ── SDP Operations ──

  Future<RTCSessionDescription> createOffer({bool iceRestart = false}) async {
    final offer = await _peerConnection!.createOffer(
      iceRestart ? {'iceRestart': true} : {},
    );
    await _peerConnection!.setLocalDescription(offer);
    return offer;
  }

  Future<RTCSessionDescription> createAnswer() async {
    final answer = await _peerConnection!.createAnswer({});
    await _peerConnection!.setLocalDescription(answer);
    return answer;
  }

  Future<void> setRemoteDescription(RTCSessionDescription desc) async {
    await _peerConnection!.setRemoteDescription(desc);
  }

  Future<void> addIceCandidate(RTCIceCandidate candidate) async {
    await _peerConnection!.addIceCandidate(candidate);
  }

  // ── Media Controls ──

  void toggleMute() {
    if (_localStream == null) return;
    final audioTrack = _localStream!.getAudioTracks().first;
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

  void switchCamera() {
    if (_localStream == null) return;
    final videoTracks = _localStream!.getVideoTracks();
    if (videoTracks.isEmpty) return;
    Helper.switchCamera(videoTracks.first);
    _isFrontCamera = !_isFrontCamera;
  }

  Future<void> toggleSpeaker() async {
    _isSpeakerOn = !_isSpeakerOn;
    await Helper.setSpeakerphoneOn(_isSpeakerOn);
  }

  /// Upgrade voice call to video by replacing the reserved transceiver's track.
  /// No SDP renegotiation needed (warm-up with replaceTrack pattern).
  Future<void> upgradeToVideo() async {
    final mediaStream = await navigator.mediaDevices.getUserMedia({
      'video': {
        'mandatory': {'minWidth': '480', 'minHeight': '640', 'minFrameRate': '24'},
        'facingMode': 'user',
      },
    });
    final videoTrack = mediaStream.getVideoTracks().first;

    if (_videoTransceiver != null) {
      await _videoTransceiver!.sender.replaceTrack(videoTrack);
      await _videoTransceiver!.setDirection(TransceiverDirection.SendRecv);
    }

    // Add video track to local stream for preview
    _localStream?.addTrack(videoTrack);
    _localStreamController.add(_localStream);
    _isVideoEnabled = true;
  }

  // ── Cleanup ──

  Future<void> dispose() async {
    // 1. Stop all local tracks
    _localStream?.getTracks().forEach((track) async {
      await track.stop();
    });

    // 2. Dispose local stream
    await _localStream?.dispose();
    _localStream = null;
    _localStreamController.add(null);

    // 3. Close peer connection
    await _peerConnection?.close();
    _peerConnection = null;

    // 4. Clear state
    _senders.clear();
    _videoTransceiver = null;
    _remoteStream = null;
    _remoteStreamController.add(null);
    _isFrontCamera = true;
    _isAudioEnabled = true;
    _isVideoEnabled = true;
    _isSpeakerOn = false;
  }

  /// Dispose all stream controllers (call on service teardown).
  void disposeControllers() {
    _remoteStreamController.close();
    _localStreamController.close();
    _connectionStateController.close();
    _iceConnectionStateController.close();
  }
}
```

---

## 9. Call Signaling Service

Reads/writes SDP and ICE candidates via Firestore.

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
    await _callDoc(callId).update({
      'offer': {'sdp': offer.sdp, 'type': offer.type},
    });
  }

  Future<void> sendAnswer(String callId, RTCSessionDescription answer) async {
    await _callDoc(callId).update({
      'answer': {'sdp': answer.sdp, 'type': answer.type},
      'status': 'active',
      'answeredAt': FieldValue.serverTimestamp(),
    });
  }

  // ── ICE Candidates ──

  Future<void> sendIceCandidate(
    String callId,
    String senderId,
    RTCIceCandidate candidate,
  ) async {
    final subcollection = senderId == _getCallerId(callId)
        ? 'callerCandidates'
        : 'calleeCandidates';
    await _callDoc(callId).collection(subcollection).add({
      'candidate': candidate.candidate,
      'sdpMid': candidate.sdpMid,
      'sdpMLineIndex': candidate.sdpMLineIndex,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<RTCIceCandidate> watchRemoteIceCandidates(
    String callId,
    bool isCaller,
  ) {
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

  Stream<Map<String, dynamic>> watchCall(String callId) {
    return _callDoc(callId).snapshots().map((snap) => snap.data() ?? {});
  }

  // ── Status Updates ──

  Future<void> updateStatus(String callId, String status) async {
    await _callDoc(callId).update({'status': status});
  }

  // ── Heartbeat ──

  Future<void> sendHeartbeat(String callId, bool isCaller) async {
    final field = isCaller ? 'callerHeartbeat' : 'calleeHeartbeat';
    await _callDoc(callId).update({field: FieldValue.serverTimestamp()});
  }
}
```

---

## 10. Call State Machine (CallBloc)

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
    @Default('voice') String callType,
  }) = _InitiateCall;

  // Incoming
  const factory CallEvent.incomingCall({
    required String callId,
    required String callerName,
    String? callerAvatarUrl,
    required String callType,
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
  const factory CallEvent.upgradeToVideo() = _UpgradeToVideo;

  // Internal (from signaling/WebRTC)
  const factory CallEvent.remoteAnswered(Map<String, String> answer) = _RemoteAnswered;
  const factory CallEvent.connectionStateChanged(String state) = _ConnectionStateChanged;
  const factory CallEvent.callStatusChanged(String status) = _CallStatusChanged;
  const factory CallEvent.callTimerTick() = _CallTimerTick;
}
```

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
    @Default('voice') String callType,
    @Default(true) bool isCaller,
    @Default(true) bool isAudioEnabled,
    @Default(false) bool isVideoEnabled,
    @Default(false) bool isSpeakerOn,
    @Default(true) bool isFrontCamera,
    @Default(Duration.zero) Duration callDuration,
    @Default(ConnectionQuality.excellent) ConnectionQuality connectionQuality,
    String? errorMessage,
  }) = _CallState;
}

enum ConnectionQuality { excellent, good, fair, poor }
```

### State Machine Transitions

```
         initiateCall()
  IDLE ──────────────────► RINGING (outgoing)
   ▲                            │
   │                     remoteAnswered
   │                            ▼
   │                       CONNECTING
   │    endCall()              │
   ├◄────────────────   connectionState: connected
   │                            ▼
   │    endCall()           ACTIVE
   ├◄──────────────── (timer running, heartbeats)
   │                            │
   │                     connectionState: disconnected
   │                            ▼
   │                      RECONNECTING
   │                       │         │
   │              reconnected    3 attempts failed
   │                  ▼              ▼
   │               ACTIVE         FAILED
   │                                │
   │     incomingCall()             │
   ├───────────────► RINGING (incoming)
   │                  │            │
   │           acceptCall()   rejectCall()
   │                  ▼            │
   │             CONNECTING        │
   │                  │            │
   │           connected           │
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

In `main.dart`, register the top-level background handler:

```dart
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final data = message.data;
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
  }
}
```

### Event Listener (in NotificationService or dedicated CallNotificationService)

```dart
void _listenForCallEvents() {
  FlutterCallkitIncoming.onEvent.listen((event) {
    if (event == null) return;

    switch (event.event) {
      case Event.actionCallAccept:
        final callId = event.body['id'] as String;
        final extra = event.body['extra'] as Map<String, dynamic>? ?? {};
        // Dispatch to CallBloc
        getIt<CallBloc>().add(CallEvent.incomingCall(
          callId: callId,
          callerName: event.body['nameCaller'] ?? 'Unknown',
          callerAvatarUrl: event.body['avatar'],
          callType: (event.body['type'] == 1) ? 'video' : 'voice',
          conversationId: extra['conversationId'] ?? '',
          callerId: extra['callerId'] ?? '',
        ));
        getIt<CallBloc>().add(const CallEvent.acceptCall());
        // Navigate to call screen
        _navigateToCallScreen(callId);
        break;

      case Event.actionCallDecline:
        final callId = event.body['id'] as String;
        getIt<CallBloc>().add(const CallEvent.rejectCall());
        break;

      case Event.actionCallTimeout:
        // Callee didn't answer — show missed call
        break;

      case Event.actionCallCallback:
        // User tapped "Call back" on missed call notification
        break;

      default:
        break;
    }
  });
}
```

### On App Launch (Terminated State)

When the user accepts a call while the app is killed, the app launches fresh.
Check for active calls on startup:

```dart
Future<void> _checkForActiveCallOnLaunch() async {
  final activeCalls = await FlutterCallkitIncoming.activeCalls();
  if (activeCalls is List && activeCalls.isNotEmpty) {
    final callData = activeCalls.first as Map<String, dynamic>;
    // The call was accepted from the native UI — navigate to call screen
    final callId = callData['id'] as String;
    final extra = callData['extra'] as Map<String, dynamic>? ?? {};
    // Initialize CallBloc and navigate
  }
}
```

---

## 12. Call Screens (UI)

### Voice Call Screen Layout

```
┌──────────────────────────────────────┐
│               (back)                 │  Minimal AppBar
├──────────────────────────────────────┤
│                                      │
│                                      │
│           ┌──────────┐               │
│           │          │               │
│           │  Avatar  │               │
│           │  (80px)  │               │
│           └──────────┘               │
│                                      │
│          "Lance"                     │  Remote user name
│                                      │
│          "02:34"                     │  Call duration timer
│          OR "Ringing..."             │  Status text
│                                      │
│       ┌──┐  (connection indicator)   │  Signal bars when quality < excellent
│                                      │
│                                      │
│                                      │
│  ┌────────┐  ┌────────┐  ┌────────┐ │
│  │  Mute  │  │Speaker │  │ Video  │ │  Toggle buttons (circular, 56px)
│  │  🎙️/🔇 │  │  🔊/🔈 │  │  📹/⬛ │ │  Grey when off, primary when on
│  └────────┘  └────────┘  └────────┘ │
│                                      │
│          ┌──────────┐                │
│          │   End    │                │  Red circular button (64px)
│          │    📞    │                │
│          └──────────┘                │
│                                      │
└──────────────────────────────────────┘
```

### Video Call Screen Layout

```
┌──────────────────────────────────────┐
│         Remote video (full)          │
│                                      │
│                                      │
│                                      │
│                                      │
│                              ┌─────┐ │
│                              │Local│ │  Draggable PiP (120x160)
│                              │prev │ │  Mirror when front camera
│                              └─────┘ │
│                                      │
│         "Lance"  02:34               │  Overlay text (semi-transparent)
│                                      │
│  ┌──────┐┌──────┐┌──────┐┌──────┐  │
│  │ Mute ││Camera││ Flip ││ End  │  │  Bottom control bar
│  │  🎙️  ││  📹  ││  🔄  ││  📞  │  │  Semi-transparent background
│  └──────┘└──────┘└──────┘└──────┘  │
└──────────────────────────────────────┘
```

### RTCVideoRenderer Usage

```dart
// Initialize renderers in initState
final _localRenderer = RTCVideoRenderer();
final _remoteRenderer = RTCVideoRenderer();

@override
void initState() {
  super.initState();
  _localRenderer.initialize();
  _remoteRenderer.initialize();
}

// In build:
// Remote video (full screen)
RTCVideoView(
  _remoteRenderer,
  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
  // Do NOT mirror remote video
)

// Local video (PiP)
RTCVideoView(
  _localRenderer,
  mirror: isFrontCamera, // Mirror only for front camera
  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
)

// Cleanup in dispose
@override
void dispose() {
  _localRenderer.srcObject = null;
  _remoteRenderer.srcObject = null;
  _localRenderer.dispose();
  _remoteRenderer.dispose();
  super.dispose();
}
```

---

## 13. Quality Monitoring & Adaptive Bitrate

Poll `getStats()` every 2 seconds during active calls.

### Key Metrics and Thresholds

| Metric | Excellent | Good | Fair | Poor |
|--------|-----------|------|------|------|
| RTT | < 80ms | < 150ms | < 300ms | > 300ms |
| Packet Loss | < 0.5% | < 1% | < 5% | > 5% |
| Jitter | < 30ms | < 50ms | < 100ms | > 100ms |
| Audio Bitrate | > 40 kbps | > 30 kbps | > 20 kbps | < 20 kbps |
| Video Bitrate (480p) | > 500 kbps | > 350 kbps | > 200 kbps | < 200 kbps |

### Adaptive Video Encoding

When quality degrades, adjust the sender's encoding parameters dynamically:

| Quality | Max Bitrate | Max Framerate | Effective Resolution |
|---------|-------------|---------------|---------------------|
| Excellent | 1.5 Mbps | 30 fps | 720p |
| Good | 800 kbps | 24 fps | 480p |
| Fair | 400 kbps | 15 fps | 360p |
| Poor | 150 kbps | 10 fps | 240p |

```dart
// Adjust via RTCRtpSender.setParameters()
final senders = await peerConnection.getSenders();
for (final sender in senders) {
  if (sender.track?.kind == 'video') {
    final params = sender.parameters;
    params.encodings?.first.maxBitrate = targetBitrate;
    params.encodings?.first.maxFramerate = targetFramerate;
    await sender.setParameters(params);
  }
}
```

### UI Indicator

Show signal bars in the call screen. Only show the text label for fair/poor:

```dart
Widget buildConnectionIndicator(ConnectionQuality quality) {
  final (icon, color, label) = switch (quality) {
    ConnectionQuality.excellent => (Icons.signal_cellular_4_bar, Colors.green, ''),
    ConnectionQuality.good => (Icons.signal_cellular_3_bar, Colors.green, ''),
    ConnectionQuality.fair => (Icons.signal_cellular_2_bar, Colors.orange, 'Weak connection'),
    ConnectionQuality.poor => (Icons.signal_cellular_1_bar, Colors.red, 'Poor connection'),
  };
  return Row(children: [
    Icon(icon, color: color, size: 16),
    if (label.isNotEmpty) ...[const SizedBox(width: 4), Text(label, style: TextStyle(color: color, fontSize: 12))],
  ]);
}
```

---

## 14. Reconnection & Error Handling

### ICE Disconnection Recovery

```
ICE connected ──► ICE disconnected ──(3s grace)──► ICE restart attempt 1
                                                         │
                                               success ──┤── failure
                                                  │      │
                                               ACTIVE    ├──► ICE restart attempt 2
                                                         │         │
                                                success ──┤── failure
                                                  │      │
                                               ACTIVE    ├──► ICE restart attempt 3
                                                         │         │
                                                success ──┤── failure
                                                  │      │
                                               ACTIVE    └──► FAILED (end call)
```

**Timing:**
- **3 seconds** grace period after `disconnected` before first restart attempt
- **5 seconds** timeout per restart attempt
- **3 attempts** maximum before giving up
- Total reconnection window: ~18 seconds

### ICE Restart Implementation

```dart
Future<void> _attemptIceRestart() async {
  if (_iceRestartAttempts >= 3) {
    _endCall(reason: 'reconnection_failed');
    return;
  }
  _iceRestartAttempts++;

  // Create new offer with iceRestart flag
  final offer = await _webRtcService.createOffer(iceRestart: true);

  // Send via signaling
  await _signalingService.sendOffer(callId, offer);
  await _signalingService.updateIceRestartCount(callId, _iceRestartAttempts);
}
```

### Heartbeat-Based Crash Detection

During active calls, each peer writes a heartbeat timestamp to Firestore every
5 seconds. Each peer monitors the other's heartbeat. If stale by > 15 seconds
(3 missed beats), the peer is presumed offline.

**Firestore cost:** ~120 writes per peer per 10-minute call. Negligible.

---

## 15. Perfect Negotiation Pattern

Eliminates "glare" (both peers sending offers simultaneously) by assigning
asymmetric roles:

- **Caller = impolite peer**: Ignores colliding offers from the callee.
- **Callee = polite peer**: Rolls back its own offer when a collision occurs.

This is set once at call setup and handles all SDP negotiation including
initial offer/answer, ICE restarts, and voice-to-video upgrades.

```dart
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
        await pc.setLocalDescription(offer);
        await sendDescription(pc.localDescription!);
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

    _isSettingRemoteAnswerPending = description.type == 'answer';
    await pc.setRemoteDescription(description);
    _isSettingRemoteAnswerPending = false;

    if (description.type == 'offer') {
      final answer = await pc.createAnswer({});
      await pc.setLocalDescription(answer);
      await sendDescription(pc.localDescription!);
    }
  }

  Future<void> handleCandidate(RTCIceCandidate candidate) async {
    try {
      await pc.addIceCandidate(candidate);
    } catch (e) {
      if (!_ignoreOffer) rethrow;
    }
  }
}
```

---

## 16. Voice-to-Video Upgrade

Uses the "warm-up with replaceTrack" pattern — **no SDP renegotiation needed**.

During initial voice call setup, a video transceiver is reserved in `RecvOnly`
direction (zero bandwidth cost). When the user taps "upgrade to video":

1. Acquire camera stream via `getUserMedia({video: ...})`
2. Call `videoTransceiver.sender.replaceTrack(videoTrack)` (replaces null with camera)
3. Call `videoTransceiver.setDirection(TransceiverDirection.SendRecv)`
4. The remote peer sees video appear without any new offer/answer exchange

This is the approach recommended by Mozilla's WebRTC team for seamless
mid-call media changes.

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

      // Only authenticated users can create; creator must be the caller
      allow create: if request.auth != null &&
        request.resource.data.callerId == request.auth.uid &&
        request.resource.data.status == 'ringing';

      // Only participants can update
      allow update: if request.auth != null && (
        resource.data.callerId == request.auth.uid ||
        resource.data.calleeId == request.auth.uid
      );

      // Deletion only via Cloud Functions (admin SDK)
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

**Note:** Subcollection rules use `get()` on the parent call document, costing
one extra read per rule evaluation. Given the low frequency of call signaling
(~30-50 operations per call), this cost is negligible.

---

## 18. Router Integration

In `lib/presentation/router/app_router.dart`, add under the conversation routes:

```dart
// Under the /chat/conversation/:conversationId route:
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

**Conversation detail AppBar** — add call buttons (line ~138):

```dart
actions: [
  IconButton(
    icon: const Icon(Icons.call, size: 22),
    onPressed: () => _initiateCall('voice'),
    tooltip: 'Voice call',
  ),
  IconButton(
    icon: const Icon(Icons.videocam, size: 22),
    onPressed: () => _initiateCall('video'),
    tooltip: 'Video call',
  ),
  // Existing search + menu buttons...
],
```

---

## 19. Cleanup & Lifecycle

### Call End Cleanup

1. **Client**: `WebRtcService.dispose()` — stops tracks, disposes stream, closes peer connection
2. **Client**: Cancel all Firestore listeners (call doc, ICE candidates, heartbeat timer)
3. **Client**: `FlutterCallkitIncoming.endCall(callId)` — dismiss native call UI
4. **Cloud Function**: `endCall()` — updates status, calculates duration, writes system message
5. **Cloud Function**: `cleanupCallSignaling` (Firestore trigger) — deletes ICE candidate subcollections
6. **Firestore TTL**: Auto-deletes the call document ~1 hour after `expireAt`

### Disposal Order (Critical)

```
1. Stop all MediaStreamTracks (track.stop())
2. Dispose MediaStream (_localStream.dispose())
3. Close RTCPeerConnection (pc.close())
4. Clear srcObject on renderers (renderer.srcObject = null)
5. Dispose RTCVideoRenderers (renderer.dispose())
```

Incorrect order causes native resource leaks, especially on iOS.

---

## 20. Testing Strategy

### Unit Tests
- CallBloc state machine: test all transitions with `blocTest<CallBloc, CallState>()`
- CallSignalingService: mock Firestore, verify document reads/writes
- Quality monitor: feed mock stats, verify quality assessment

### Integration Tests
- End-to-end call flow with two simulated peers (requires two Firebase Auth sessions)
- ICE restart recovery (simulate network drop via mock)
- Ring timeout (verify missed call after 30s)

### Manual Testing Checklist
1. Voice call: initiate → ring → accept → talk → end → system message in chat
2. Video call: same flow + verify local/remote video renders
3. Missed call: initiate → wait 30s → verify missed status + notification
4. Decline call: initiate → callee declines → verify declined status
5. Caller cancels: initiate → caller hangs up before answer
6. Voice-to-video upgrade: start voice → tap video → camera activates
7. Camera switch: during video → tap flip → switches front/back
8. Mute/unmute: verify audio toggling
9. Speaker toggle: verify audio routing
10. App backgrounded: call continues (wakelock + foreground service)
11. App killed (receiver): FCM wakes app → native call UI → accept → call screen
12. Network switch (WiFi→cellular): verify ICE restart recovers
13. Poor network: verify quality indicator + adaptive bitrate

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

### Phase 1: Core Voice Calling (Week 1-2)

**New files:**
- `lib/core/services/webrtc_service.dart`
- `lib/core/services/call_signaling_service.dart`
- `lib/domain/entities/call_session.dart`
- `lib/domain/enums/call_status.dart`
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
- `ios/Runner/Info.plist` (background modes, usage descriptions)
- `ios/Podfile` (ONLY_ACTIVE_ARCH)
- `lib/presentation/router/app_router.dart` (call route)
- `lib/presentation/screens/messaging/conversation_detail_screen.dart` (call buttons)
- `lib/core/di/register_module.dart` (register WebRtcService, CallSignalingService)
- `functions/src/index.ts` (export call functions)

**Deliverables:**
- Voice call: initiate, ring, accept, talk, end
- Call buttons in conversation AppBar
- System message in chat after call ends
- Firestore security rules for calls collection
- TURN credentials via Cloud Function

### Phase 2: Incoming Call UI + Notifications (Week 2-3)

**New/modified files:**
- `lib/core/services/notification_service.dart` (add incoming_call handler)
- `ios/Runner/AppDelegate.swift` (PushKit integration)
- `main.dart` (background handler, startup check)

**Deliverables:**
- Native incoming call UI (Android full-screen notification, iOS CallKit)
- Call from killed app state (PushKit on iOS, FCM high-priority on Android)
- Missed call notification with callback
- Permission requests (notification, full-screen intent, battery optimization)

### Phase 3: Video Calling (Week 3-4)

**New files:**
- `lib/presentation/screens/messaging/video_call_screen.dart`

**Deliverables:**
- Video call screen with local PiP + remote full screen
- Camera switch (front/back)
- Video toggle (on/off)
- Voice-to-video upgrade mid-call

### Phase 4: Quality & Resilience (Week 4)

**New files:**
- `lib/core/services/call_quality_monitor.dart`

**Deliverables:**
- Connection quality monitoring (RTT, packet loss, jitter)
- Adaptive bitrate (degrade video quality on poor network)
- Quality indicator in call UI
- ICE restart reconnection (3 attempts)
- Heartbeat-based crash detection
- Wakelock during calls (screen stays on)

### Phase 5: Polish & Edge Cases (Week 5)

**Deliverables:**
- Call while app is backgrounded (foreground service on Android)
- Do Not Disturb integration
- Call audio routing (earpiece vs speaker vs Bluetooth)
- Cleanup: Firestore TTL policy, Cloud Function trigger for subcollection deletion
- Call history rendered as system messages in chat
- Comprehensive testing across devices
