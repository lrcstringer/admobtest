/**
 * Voice & Video Calling Cloud Functions
 *
 * Handles call lifecycle: initiation, answering, ending, TURN credentials,
 * signaling cleanup, and stale call detection.
 *
 * All functions use Firestore transactions for atomicity.
 * endCall is idempotent (first-writer-wins).
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { onDocumentUpdated } from "firebase-functions/v2/firestore";
import { onSchedule } from "firebase-functions/v2/scheduler";
import * as admin from "firebase-admin";

const db = admin.firestore();
const rtdb = admin.database();

function requireAuth(request: { auth?: { uid: string } }): string {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  return request.auth.uid;
}

const TERMINAL_STATUSES = ["ended", "missed", "declined", "cancelled", "failed", "busy"];
const RING_TIMEOUT_MS = 30_000; // 30 seconds
const STALE_HEARTBEAT_MS = 15_000; // 15 seconds — detect dead calls faster

// ─── getTurnCredentials ──────────────────────────────────────────────────

export const getTurnCredentials = onCall(
  { region: "africa-south1", labels: { app: "imalichat" } },
  async (request) => {
    requireAuth(request);

    // STUN servers always included — free and sufficient for most networks
    const stunServers = [
      { urls: "stun:stun.l.google.com:19302" },
      { urls: "stun:stun1.l.google.com:19302" },
    ];

    const keyId = process.env.CLOUDFLARE_TURN_KEY_ID;
    const apiToken = process.env.CLOUDFLARE_TURN_API_TOKEN;

    // Gracefully fall back to STUN-only when TURN is not configured
    if (!keyId || !apiToken) {
      return { iceServers: stunServers, ttl: 0 };
    }

    try {
      const response = await fetch(
        `https://rtc.live.cloudflare.com/v1/turn/keys/${keyId}/credentials/generate`,
        {
          method: "POST",
          headers: {
            "Authorization": `Bearer ${apiToken}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ ttl: 7200 }), // 2-hour TTL
        },
      );

      if (!response.ok) {
        // TURN failed — fall back to STUN-only rather than crashing the call
        return { iceServers: stunServers, ttl: 0 };
      }

      const turnCreds = await response.json() as { iceServers: unknown[] };
      return {
        iceServers: [
          ...stunServers,
          ...turnCreds.iceServers,
        ],
        ttl: 7200,
      };
    } catch {
      // Network error fetching TURN creds — fall back to STUN-only
      return { iceServers: stunServers, ttl: 0 };
    }
  },
);

// ─── initiateCall ────────────────────────────────────────────────────────
//
// Creates a call document and sends push notifications.
// Uses a transaction to prevent duplicate active calls on the same conversation.

export const initiateCall = onCall(
  { region: "africa-south1", labels: { app: "imalichat" } },
  async (request) => {
    const userId = requireAuth(request);
    const { conversationId, recipientId, callType } = request.data as {
      conversationId: string;
      recipientId: string;
      callType: "voice" | "video";
    };

    if (!conversationId || !recipientId || !callType) {
      throw new HttpsError("invalid-argument", "Missing required fields");
    }
    if (callType !== "voice" && callType !== "video") {
      throw new HttpsError("invalid-argument", "callType must be voice or video");
    }

    // Use a transaction to atomically check for active calls + create the new one
    const callRef = db.collection("calls").doc();
    const convRef = db.collection("conversations").doc(conversationId);

    await db.runTransaction(async (tx) => {
      // Verify conversation exists and user is participant
      const convDoc = await tx.get(convRef);
      if (!convDoc.exists) {
        throw new HttpsError("not-found", "Conversation not found");
      }
      const conv = convDoc.data()!;
      if (!conv.participantIds?.includes(userId)) {
        throw new HttpsError("permission-denied", "Not a participant");
      }
      if (!conv.participantIds?.includes(recipientId)) {
        throw new HttpsError("invalid-argument", "Recipient not in conversation");
      }

      // Prevent duplicate active calls on this conversation
      const activeCalls = await tx.get(
        db.collection("calls")
          .where("conversationId", "==", conversationId)
          .where("status", "in", ["ringing", "active"])
          .limit(1),
      );
      if (!activeCalls.empty) {
        throw new HttpsError("already-exists", "Call already in progress");
      }

      const callerName = conv.participants?.[userId]?.displayName || "Someone";
      const callerAvatar = conv.participants?.[userId]?.avatarUrl || "";
      const now = admin.firestore.FieldValue.serverTimestamp();

      tx.set(callRef, {
        callId: callRef.id,
        conversationId,
        callerId: userId,
        calleeId: recipientId,
        callerName,
        callerAvatarUrl: callerAvatar,
        callType,
        status: "ringing",
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
        // TTL: auto-delete after 1 hour
        expireAt: admin.firestore.Timestamp.fromDate(
          new Date(Date.now() + 3600_000),
        ),
      });
    });

    // Pre-create RTDB signaling node with participant UIDs for security rules.
    // The rules require auth.uid to be in participants/ for read/write access.
    try {
      await rtdb.ref(`callSignaling/${callRef.id}`).set({
        createdAt: admin.database.ServerValue.TIMESTAMP,
        participants: {
          [userId]: true,
          [recipientId]: true,
        },
      });
    } catch (e) {
      console.error("RTDB signaling node creation failed:", e);
      // Non-fatal — client writes will create the node on first use
    }

    // ── Send push notifications (outside transaction — fire and forget) ──

    const recipientDoc = await db.collection("users").doc(recipientId).get();
    const recipientData = recipientDoc.data();
    const callDoc = await callRef.get();
    const callData = callDoc.data()!;

    const fcmToken = recipientData?.fcmToken;
    if (fcmToken) {
      try {
        await admin.messaging().send({
          token: fcmToken,
          // Data-only message — triggers onBackgroundMessage
          data: {
            type: "incoming_call",
            callId: callRef.id,
            callType,
            conversationId,
            callerName: callData.callerName,
            callerId: userId,
            callerAvatarUrl: callData.callerAvatarUrl,
          },
          android: {
            priority: "high",
            ttl: RING_TIMEOUT_MS,
          },
          apns: {
            headers: { "apns-priority": "10" },
            payload: {
              aps: {
                contentAvailable: true,
                sound: "ringtone.caf",
              },
            },
          },
        });
      } catch (e) {
        console.error("FCM send failed:", e);
      }
    }

    // Send VoIP push for iOS (if voipToken available)
    const voipToken = recipientData?.voipToken as string | undefined;
    if (voipToken) {
      try {
        await sendVoipPush(voipToken, {
          callId: callRef.id,
          callType,
          conversationId,
          callerName: callData.callerName,
          callerId: userId,
          callerAvatar: callData.callerAvatarUrl || "",
        });
      } catch (e) {
        console.error("VoIP push error:", e);
      }
    }

    return { success: true, callId: callRef.id };
  },
);

// ─── answerCall ──────────────────────────────────────────────────────────
//
// Server-validated call answer. Prevents answering ended/cancelled calls.

export const answerCall = onCall(
  { region: "africa-south1", labels: { app: "imalichat" } },
  async (request) => {
    const userId = requireAuth(request);
    const { callId } = request.data as { callId: string };

    if (!callId) {
      throw new HttpsError("invalid-argument", "callId is required");
    }

    const callRef = db.collection("calls").doc(callId);

    await db.runTransaction(async (tx) => {
      const callDoc = await tx.get(callRef);
      if (!callDoc.exists) {
        throw new HttpsError("not-found", "Call not found");
      }
      const call = callDoc.data()!;

      if (call.calleeId !== userId) {
        throw new HttpsError("permission-denied", "Only the callee can answer");
      }
      if (call.status !== "ringing") {
        throw new HttpsError(
          "failed-precondition",
          `Cannot answer call in '${call.status}' state`,
        );
      }

      tx.update(callRef, {
        status: "active",
        answeredAt: admin.firestore.FieldValue.serverTimestamp(),
        calleeHeartbeat: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    return { success: true };
  },
);

// ─── endCall ─────────────────────────────────────────────────────────────
//
// Idempotent: safe to call from both peers. Only the first call writes
// the system message and sets the end fields.

export const endCall = onCall(
  { region: "africa-south1", labels: { app: "imalichat" } },
  async (request) => {
    const userId = requireAuth(request);
    const { callId, reason } = request.data as {
      callId: string;
      reason?: string;
    };

    if (!callId) {
      throw new HttpsError("invalid-argument", "callId is required");
    }

    const callRef = db.collection("calls").doc(callId);

    const result = await db.runTransaction(async (tx) => {
      const callDoc = await tx.get(callRef);
      if (!callDoc.exists) {
        throw new HttpsError("not-found", "Call not found");
      }

      const call = callDoc.data()!;
      if (call.callerId !== userId && call.calleeId !== userId) {
        throw new HttpsError("permission-denied", "Not a participant");
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
      const endReason = reason || "normal";
      let status = "ended";
      if (endReason === "missed") status = "missed";
      else if (endReason === "declined") status = "declined";
      else if (endReason === "cancelled") status = "cancelled";
      else if (endReason === "busy") status = "busy";
      else if (endReason === "error" || endReason === "reconnection_failed") status = "failed";

      tx.update(callRef, {
        status,
        endedAt: admin.firestore.FieldValue.serverTimestamp(),
        endReason,
        durationSeconds,
        expireAt: admin.firestore.Timestamp.fromDate(
          new Date(Date.now() + 3600_000),
        ),
      });

      return { alreadyEnded: false, callData: call, durationSeconds, endReason, status };
    });

    // Clean up RTDB signaling data (best effort)
    try {
      await rtdb.ref(`callSignaling/${callId}`).remove();
    } catch (e) {
      console.error("RTDB signaling cleanup failed:", e);
    }

    // Notify the OTHER participant via FCM so their CallKit UI dismisses
    // immediately — even if their app has no Firestore listener yet.
    if (!result.alreadyEnded) {
      const call = result.callData;
      const otherUid = call.callerId === userId ? call.calleeId : call.callerId;
      try {
        const otherDoc = await db.collection("users").doc(otherUid).get();
        const otherFcm = otherDoc.data()?.fcmToken as string | undefined;
        if (otherFcm) {
          await admin.messaging().send({
            token: otherFcm,
            data: { type: "call_ended", callId },
            android: { priority: "high" },
            apns: {
              headers: { "apns-priority": "10" },
              payload: { aps: { contentAvailable: true } },
            },
          });
        }
      } catch (e) {
        // Best-effort — Firestore listener and CallKit timeout are fallbacks
        console.error("FCM call_ended send failed:", e);
      }
    }

    // Only write system message if this was the first endCall
    if (!result.alreadyEnded) {
      const call = result.callData;
      const { durationSeconds, endReason, status } = result as {
        alreadyEnded: false;
        callData: FirebaseFirestore.DocumentData;
        durationSeconds: number | null;
        endReason: string;
        status: string;
      };

      const callLabel = call.callType === "video" ? "Video call" : "Voice call";
      const durationText = durationSeconds ? formatDuration(durationSeconds) : null;
      const systemText =
        status === "missed"
          ? `Missed ${callLabel.toLowerCase()}`
          : status === "declined"
            ? `${callLabel} declined`
            : status === "cancelled"
              ? `Cancelled ${callLabel.toLowerCase()}`
              : status === "busy"
                ? `${callLabel} — busy`
                : `${callLabel}${durationText ? ", " + durationText : ""}`;

      const msgRef = db
        .collection("conversations")
        .doc(call.conversationId)
        .collection("messages")
        .doc();

      await msgRef.set({
        id: msgRef.id,
        senderId: userId,
        senderName: call.callerName || "",
        senderAvatarUrl: null,
        type: "system",
        status: "sent",
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
        systemEventType: "call_ended",
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
  return `${m}:${s.toString().padStart(2, "0")}`;
}

/**
 * Send VoIP push notification via APNs for iOS devices.
 * Required for waking killed iOS apps via PushKit/CallKit.
 * Falls back gracefully if APNs is not configured.
 */
async function sendVoipPush(
  voipToken: string,
  payload: Record<string, string>,
): Promise<void> {
  const apnKeyId = process.env.APNS_KEY_ID;
  const apnTeamId = process.env.APNS_TEAM_ID;
  const apnAuthKey = process.env.APNS_AUTH_KEY; // Base64-encoded .p8 key
  const apnTopic = process.env.APNS_VOIP_TOPIC; // e.g. com.example.app.voip

  if (!apnKeyId || !apnTeamId || !apnAuthKey || !apnTopic) {
    return; // APNs VoIP not configured — FCM-only fallback
  }

  // eslint-disable-next-line @typescript-eslint/no-var-requires
  const apn = require("@parse/node-apn");
  const provider = new apn.Provider({
    token: {
      key: Buffer.from(apnAuthKey, "base64").toString("utf-8"),
      keyId: apnKeyId,
      teamId: apnTeamId,
    },
    production: true,
  });

  try {
    const notification = new apn.Notification();
    notification.topic = apnTopic;
    notification.pushType = "voip";
    notification.priority = 10;
    notification.expiry = Math.floor(Date.now() / 1000) + 30; // 30s ring timeout
    notification.payload = payload;

    const result = await provider.send(notification, voipToken);
    if (result.failed && result.failed.length > 0) {
      console.error("VoIP push failed:", JSON.stringify(result.failed));
    }
  } finally {
    provider.shutdown();
  }
}

// ─── onCallUpdated ──────────────────────────────────────────────────────
//
// Firestore trigger: when a call transitions to a terminal status, delete
// the ICE candidate subcollections.

export const onCallUpdated = onDocumentUpdated(
  {
    document: "calls/{callId}",
    region: "africa-south1",
    labels: { app: "imalichat" },
  },
  async (event) => {
    const after = event.data?.after.data();
    const before = event.data?.before.data();
    if (!after || !before) return;

    // Terminal status reached: clean up RTDB signaling data
    // (ICE candidates + SDP now live on RTDB, not Firestore subcollections)
    if (TERMINAL_STATUSES.includes(after.status) && !TERMINAL_STATUSES.includes(before.status)) {
      const callId = event.params!.callId;
      try {
        await rtdb.ref(`callSignaling/${callId}`).remove();
      } catch (e) {
        console.error(`RTDB cleanup for ${callId} failed:`, e);
      }
    }
  },
);

// ─── cleanupStaleCalls (Scheduled) ─────────────────────────────────────
//
// Runs every minute. Catches calls stuck in 'ringing' > 30s (caller crashed)
// or 'active' with stale heartbeats > 30s (both peers crashed).

export const cleanupStaleCalls = onSchedule(
  {
    schedule: "every 1 minutes",
    region: "europe-west1",
    labels: { app: "imalichat" },
  },
  async () => {
    const now = Date.now();
    const thirtySecondsAgo = admin.firestore.Timestamp.fromDate(
      new Date(now - RING_TIMEOUT_MS),
    );

    // Stale ringing calls → missed
    const staleRinging = await db.collection("calls")
      .where("status", "==", "ringing")
      .where("createdAt", "<", thirtySecondsAgo)
      .limit(50)
      .get();

    for (const doc of staleRinging.docs) {
      // Use transaction to avoid racing with endCall: re-read the doc and
      // skip if it already transitioned to a terminal status. This prevents
      // duplicate system messages when both endCall and cleanup fire.
      const wrote = await db.runTransaction(async (tx) => {
        const freshDoc = await tx.get(doc.ref);
        const freshData = freshDoc.data();
        if (!freshData || TERMINAL_STATUSES.includes(freshData.status)) {
          return false; // endCall already handled it
        }
        tx.update(doc.ref, {
          status: "missed",
          endedAt: admin.firestore.FieldValue.serverTimestamp(),
          endReason: "missed",
          durationSeconds: null,
          expireAt: admin.firestore.Timestamp.fromDate(new Date(now + 3600_000)),
        });
        return true;
      });

      if (!wrote) continue; // Skip message + cleanup — endCall handled it

      const data = doc.data();

      // Clean up RTDB signaling data
      try { await rtdb.ref(`callSignaling/${doc.id}`).remove(); } catch { /* best effort */ }

      // Write missed call system message
      const msgRef = db
        .collection("conversations")
        .doc(data.conversationId)
        .collection("messages")
        .doc();
      const callLabel = data.callType === "video" ? "video call" : "voice call";
      await msgRef.set({
        id: msgRef.id,
        senderId: data.callerId,
        senderName: data.callerName || "",
        senderAvatarUrl: null,
        type: "system",
        status: "sent",
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
        systemEventType: "call_ended",
        systemEventData: {
          callId: doc.id,
          callType: data.callType,
          callerId: data.callerId,
          calleeId: data.calleeId,
          durationSeconds: null,
          endReason: "missed",
        },
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        expiresAt: null,
        actionedAt: null,
        deletedAt: null,
        deletedFor: [],
        deletedForEveryone: false,
      });
    }

    // Stale active calls (both heartbeats stale) → ended
    const staleHeartbeatTimestamp = admin.firestore.Timestamp.fromDate(
      new Date(now - STALE_HEARTBEAT_MS),
    );
    const staleActive = await db.collection("calls")
      .where("status", "==", "active")
      .where("callerHeartbeat", "<", staleHeartbeatTimestamp)
      .limit(50)
      .get();

    for (const doc of staleActive.docs) {
      // Use transaction to avoid racing with endCall
      const result = await db.runTransaction(async (tx) => {
        const freshDoc = await tx.get(doc.ref);
        const freshData = freshDoc.data();
        if (!freshData || TERMINAL_STATUSES.includes(freshData.status)) {
          return null; // endCall already handled it
        }
        // Only end if BOTH heartbeats are stale
        if (freshData.calleeHeartbeat &&
            freshData.calleeHeartbeat.toDate().getTime() > now - STALE_HEARTBEAT_MS) {
          return null; // Callee is still alive
        }
        let durationSeconds: number | null = null;
        if (freshData.answeredAt) {
          durationSeconds = Math.round((now - freshData.answeredAt.toDate().getTime()) / 1000);
        }
        tx.update(doc.ref, {
          status: "ended",
          endedAt: admin.firestore.FieldValue.serverTimestamp(),
          endReason: "peer_offline",
          durationSeconds,
          expireAt: admin.firestore.Timestamp.fromDate(new Date(now + 3600_000)),
        });
        return { durationSeconds, data: freshData };
      });

      if (!result) continue; // Skip message + cleanup — endCall handled it or callee alive

      const data = result.data;

      // Clean up RTDB signaling data
      try { await rtdb.ref(`callSignaling/${doc.id}`).remove(); } catch { /* best effort */ }

      // Write system message for stale active call
      const callLabel = data.callType === "video" ? "Video call" : "Voice call";
      const durationText = result.durationSeconds ? formatDuration(result.durationSeconds) : null;
      const msgRef = db
        .collection("conversations")
        .doc(data.conversationId)
        .collection("messages")
        .doc();
      await msgRef.set({
        id: msgRef.id,
        senderId: data.callerId,
        senderName: data.callerName || "",
        senderAvatarUrl: null,
        type: "system",
        status: "sent",
        textContent: `${callLabel}${durationText ? ", " + durationText : ""}`,
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
        systemEventType: "call_ended",
        systemEventData: {
          callId: doc.id,
          callType: data.callType,
          callerId: data.callerId,
          calleeId: data.calleeId,
          durationSeconds: result.durationSeconds,
          endReason: "peer_offline",
        },
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        expiresAt: null,
        actionedAt: null,
        deletedAt: null,
        deletedFor: [],
        deletedForEveryone: false,
      });
    }
  },
);
