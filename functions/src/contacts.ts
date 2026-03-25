/**
 * Contacts Cloud Functions
 *
 * User search, contact requests (send/accept/decline/remove),
 * phone-contact matching, social discovery ("People You May Know"),
 * pending invite tracking, and auto-contact creation helper.
 *
 * Extracted from conversations.ts to keep that file focused on
 * messaging / conversation management only.
 *
 * Collections:
 *   contacts/{contactId}
 *   pendingInvites/{inviteId}
 *   communityMembers/{docId}   (read-only, used by getPeopleYouMayKnow)
 */

import { onCall, HttpsError } from "firebase-functions/v2/https";
import { logger } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

// ============================================================================
// HELPERS
// ============================================================================

function requireAuth(request: { auth?: { uid: string } }): string {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }
  return request.auth.uid;
}

// ============================================================================
// USER SEARCH
// ============================================================================

/**
 * Search for users by display name (case-insensitive prefix match).
 * Requires `displayNameLower` field on user documents.
 * Returns only public profile fields (no phone, FCM token, etc.).
 * Used by the contact picker when starting a new conversation.
 */
export const searchUsers = onCall({ labels: { area: "social" } }, async (request) => {
  const userId = requireAuth(request);

  const { query, accountTypeId } = request.data;

  if (!query || typeof query !== "string" || query.length < 2 || query.length > 50) {
    throw new HttpsError(
      "invalid-argument",
      "query must be a string between 2 and 50 characters"
    );
  }

  if (accountTypeId !== undefined && (typeof accountTypeId !== "string" || accountTypeId.length === 0)) {
    throw new HttpsError(
      "invalid-argument",
      "accountTypeId must be a non-empty string if provided"
    );
  }

  const queryLower = query.toLowerCase();
  const limit = 20;

  // Search by displayNameLower prefix (case-insensitive)
  // Optionally filter by activeAccountTypeIds if accountTypeId is provided
  let userQuery = db
    .collection("users")
    .where("displayNameLower", ">=", queryLower)
    .where("displayNameLower", "<=", queryLower + "\uf8ff");

  if (accountTypeId) {
    userQuery = userQuery.where("activeAccountTypeIds", "array-contains", accountTypeId);
  }

  const nameResults = await userQuery.limit(limit).get();

  // Get caller's blocked list for filtering
  const callerDoc = await db.collection("users").doc(userId).get();
  const callerBlockedIds: string[] = callerDoc.data()?.chat?.blockedUserIds || [];

  // Exclude calling user, blocked users, and users who restrict discoverability
  const users: Array<Record<string, unknown>> = [];

  for (const doc of nameResults.docs) {
    if (doc.id === userId) continue;

    const d = doc.data();

    // Skip deleted or inactive accounts
    if (d.isDeleted === true || d.isActive === false) continue;

    // Skip users the caller has blocked
    if (callerBlockedIds.includes(doc.id)) continue;

    // Skip users who have blocked the caller
    const targetBlockedIds: string[] = d.chat?.blockedUserIds || [];
    if (targetBlockedIds.includes(userId)) continue;

    // Respect discoverability privacy setting
    const discoverability = d.privacy?.discoverability || "everyone";
    if (discoverability === "nobody") continue;
    if (discoverability === "contactsOnly") {
      // Check if caller is in this user's contacts
      const contactSnap = await db
        .collection("contacts")
        .where("userId", "==", doc.id)
        .where("contactUserId", "==", userId)
        .where("status", "==", "accepted")
        .limit(1)
        .get();
      if (contactSnap.empty) continue;
    }

    users.push({
      userId: doc.id,
      displayName: d.displayName || "Unknown",
      username: d.username || null,
      avatarUrl: d.avatarUrl || null,
      avatarColor: d.avatarColor || null,
      phoneNumber:
        d.privacy?.phoneNumberVisibility === "everyone"
          ? (d.phoneNumber || null)
          : null,
    });

    if (users.length >= limit) break;
  }

  return { success: true, users };
});

// ============================================================================
// CONTACT REQUESTS
// ============================================================================

/**
 * Send a contact request to another user.
 * Creates paired contact documents: sender gets "accepted", recipient gets "pending".
 * If recipient already sent a request to sender, auto-accept both (mutual).
 */
export const sendContactRequest = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    await requireAppCheck(request, "sendContactRequest");

    const { contactUserId, source } = request.data;
    const isPhoneImport = source === "phone_import";

    if (!contactUserId || typeof contactUserId !== "string") {
      throw new HttpsError("invalid-argument", "contactUserId is required");
    }

    if (userId === contactUserId) {
      throw new HttpsError("invalid-argument", "Cannot add yourself as a contact");
    }

    // Check if target user exists
    const targetDoc = await db.collection("users").doc(contactUserId).get();
    if (!targetDoc.exists) {
      throw new HttpsError("not-found", "User not found");
    }
    const targetData = targetDoc.data()!;

    // Check blocked lists
    const callerDoc = await db.collection("users").doc(userId).get();
    const callerData = callerDoc.data()!;
    const callerBlockedIds: string[] = callerData.chat?.blockedUserIds || [];
    const targetBlockedIds: string[] = targetData.chat?.blockedUserIds || [];

    if (callerBlockedIds.includes(contactUserId)) {
      throw new HttpsError("failed-precondition", "You have blocked this user");
    }
    if (targetBlockedIds.includes(userId)) {
      throw new HttpsError("failed-precondition", "This user is not available");
    }

    // Respect discoverability privacy
    const discoverability = targetData.privacy?.discoverability || "everyone";
    if (discoverability === "nobody") {
      throw new HttpsError("failed-precondition", "This user is not accepting contact requests");
    }
    if (discoverability === "contactsOnly") {
      // Check if caller is already in target's contacts
      const existingContact = await db
        .collection("contacts")
        .where("userId", "==", contactUserId)
        .where("contactUserId", "==", userId)
        .where("status", "==", "accepted")
        .limit(1)
        .get();
      if (existingContact.empty) {
        throw new HttpsError("failed-precondition", "This user only accepts requests from existing contacts");
      }
    }

    // Check for existing relationship (either direction)
    const existingSenderDoc = await db
      .collection("contacts")
      .where("userId", "==", userId)
      .where("contactUserId", "==", contactUserId)
      .limit(1)
      .get();

    if (!existingSenderDoc.empty) {
      const existingStatus = existingSenderDoc.docs[0].data().status;
      if (existingStatus === "accepted" || existingStatus === "pending") {
        throw new HttpsError("already-exists", "Contact request already exists");
      }
    }

    // Check if recipient already sent a request to the caller (auto-mutual)
    const reverseDoc = await db
      .collection("contacts")
      .where("userId", "==", contactUserId)
      .where("contactUserId", "==", userId)
      .limit(1)
      .get();

    const now = admin.firestore.FieldValue.serverTimestamp();
    const batch = db.batch();

    if (!reverseDoc.empty && reverseDoc.docs[0].data().status === "pending") {
      // Auto-accept both sides (mutual)
      const reverseRef = reverseDoc.docs[0].ref;
      batch.update(reverseRef, { status: "accepted" });

      // Create sender's doc as accepted
      const senderRef = db.collection("contacts").doc();
      batch.set(senderRef, {
        userId,
        contactUserId,
        displayName: targetData.displayName || "User",
        username: targetData.username || null,
        avatarUrl: targetData.avatarUrl || null,
        avatarColor: targetData.avatarColor || null,
        phoneNumber: targetData.phoneNumber || null,
        status: "accepted",
        isFavorite: false,
        nickname: null,
        notes: null,
        initiatedBy: userId,
        createdAt: now,
        lastInteractionAt: null,
      });

      await batch.commit();

      // Notify both users
      try {
        const callerFcm = callerData.fcmToken;
        const targetFcm = targetData.fcmToken;
        if (targetFcm) {
          await admin.messaging().send({
            token: targetFcm,
            notification: {
              title: "Contact Accepted",
              body: `${callerData.displayName || "Someone"} is now your contact`,
            },
            data: { type: "contact_accepted", contactUserId: userId },
          });
        }
        if (callerFcm) {
          await admin.messaging().send({
            token: callerFcm,
            notification: {
              title: "Contact Accepted",
              body: `${targetData.displayName || "Someone"} is now your contact`,
            },
            data: { type: "contact_accepted", contactUserId },
          });
        }
      } catch (fcmErr) {
        logger.warn("FCM notification failed for auto-mutual contact:", fcmErr);
      }

      return { success: true, status: "accepted", autoMutual: true };
    }

    // Normal flow: create paired documents
    // Sender's doc: always accepted (they chose to add)
    // Recipient's doc: accepted if phone_import, pending otherwise
    const recipientStatus = isPhoneImport ? "accepted" : "pending";

    const senderRef = db.collection("contacts").doc();
    batch.set(senderRef, {
      userId,
      contactUserId,
      displayName: targetData.displayName || "User",
      username: targetData.username || null,
      avatarUrl: targetData.avatarUrl || null,
      avatarColor: targetData.avatarColor || null,
      phoneNumber: targetData.phoneNumber || null,
      status: "accepted",
      isFavorite: false,
      nickname: null,
      notes: null,
      initiatedBy: userId,
      createdAt: now,
      lastInteractionAt: null,
    });

    const recipientRef = db.collection("contacts").doc();
    batch.set(recipientRef, {
      userId: contactUserId,
      contactUserId: userId,
      displayName: callerData.displayName || "User",
      username: callerData.username || null,
      avatarUrl: callerData.avatarUrl || null,
      avatarColor: callerData.avatarColor || null,
      phoneNumber: callerData.phoneNumber || null,
      status: recipientStatus,
      isFavorite: false,
      nickname: null,
      notes: null,
      initiatedBy: userId,
      createdAt: now,
      lastInteractionAt: null,
    });

    await batch.commit();

    // Send FCM notification to recipient
    try {
      const targetFcm = targetData.fcmToken;
      if (targetFcm) {
        const notifTitle = isPhoneImport ? "New Contact" : "New Contact Request";
        const notifBody = isPhoneImport
          ? `${callerData.displayName || "Someone"} added you as a contact`
          : `${callerData.displayName || "Someone"} wants to add you as a contact`;
        const notifType = isPhoneImport ? "contact_accepted" : "contact_request";

        await admin.messaging().send({
          token: targetFcm,
          notification: {
            title: notifTitle,
            body: notifBody,
          },
          data: { type: notifType, contactUserId: userId },
        });
      }
    } catch (fcmErr) {
      logger.warn("FCM notification failed for contact request:", fcmErr);
    }

    return { success: true, status: recipientStatus };
  }
);

/**
 * Accept an incoming contact request.
 * Updates the recipient's contact doc to "accepted" and
 * ensures the sender's mirror doc is also "accepted".
 */
export const acceptContactRequest = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    await requireAppCheck(request, "acceptContactRequest");

    const { contactId } = request.data;

    if (!contactId || typeof contactId !== "string") {
      throw new HttpsError("invalid-argument", "contactId is required");
    }

    const contactDoc = await db.collection("contacts").doc(contactId).get();
    if (!contactDoc.exists) {
      throw new HttpsError("not-found", "Contact request not found");
    }

    const contactData = contactDoc.data()!;

    // Verify this is the recipient's pending doc
    if (contactData.userId !== userId) {
      throw new HttpsError("permission-denied", "Not authorized");
    }
    if (contactData.status !== "pending") {
      throw new HttpsError("failed-precondition", "Contact request is not pending");
    }

    const senderId = contactData.contactUserId;

    // Update recipient's doc to accepted
    const batch = db.batch();
    batch.update(contactDoc.ref, { status: "accepted" });

    // Also update the sender's mirror doc if it exists
    const senderContactSnap = await db
      .collection("contacts")
      .where("userId", "==", senderId)
      .where("contactUserId", "==", userId)
      .limit(1)
      .get();

    if (!senderContactSnap.empty) {
      batch.update(senderContactSnap.docs[0].ref, { status: "accepted" });
    }

    await batch.commit();

    // Notify the original sender
    try {
      const senderDoc = await db.collection("users").doc(senderId).get();
      const senderFcm = senderDoc.data()?.fcmToken;
      const recipientName = (await db.collection("users").doc(userId).get()).data()?.displayName || "Someone";
      if (senderFcm) {
        await admin.messaging().send({
          token: senderFcm,
          notification: {
            title: "Contact Accepted",
            body: `${recipientName} accepted your contact request`,
          },
          data: { type: "contact_accepted", contactUserId: userId },
        });
      }
    } catch (fcmErr) {
      logger.warn("FCM notification failed for contact acceptance:", fcmErr);
    }

    return { success: true };
  }
);

/**
 * Decline an incoming contact request.
 * Deletes both paired contact documents.
 */
export const declineContactRequest = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    await requireAppCheck(request, "declineContactRequest");

    const { contactId } = request.data;

    if (!contactId || typeof contactId !== "string") {
      throw new HttpsError("invalid-argument", "contactId is required");
    }

    const contactDoc = await db.collection("contacts").doc(contactId).get();
    if (!contactDoc.exists) {
      throw new HttpsError("not-found", "Contact request not found");
    }

    const contactData = contactDoc.data()!;

    // Verify this is the recipient's pending doc
    if (contactData.userId !== userId) {
      throw new HttpsError("permission-denied", "Not authorized");
    }
    if (contactData.status !== "pending") {
      throw new HttpsError("failed-precondition", "Contact request is not pending");
    }

    const senderId = contactData.contactUserId;

    // Delete both documents
    const batch = db.batch();
    batch.delete(contactDoc.ref);

    // Also delete the sender's mirror doc
    const senderContactSnap = await db
      .collection("contacts")
      .where("userId", "==", senderId)
      .where("contactUserId", "==", userId)
      .limit(1)
      .get();

    if (!senderContactSnap.empty) {
      batch.delete(senderContactSnap.docs[0].ref);
    }

    await batch.commit();

    return { success: true };
  }
);

/**
 * Remove a contact (unilateral).
 * Deletes only the caller's contact document.
 * Does NOT delete the other user's document.
 */
export const removeContact = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    await requireAppCheck(request, "removeContact");

    const { contactId } = request.data;

    if (!contactId || typeof contactId !== "string") {
      throw new HttpsError("invalid-argument", "contactId is required");
    }

    const contactDoc = await db.collection("contacts").doc(contactId).get();
    if (!contactDoc.exists) {
      throw new HttpsError("not-found", "Contact not found");
    }

    const contactData = contactDoc.data()!;

    // Verify ownership
    if (contactData.userId !== userId) {
      throw new HttpsError("permission-denied", "Not authorized");
    }

    await contactDoc.ref.delete();

    return { success: true };
  }
);

// ============================================================================
// PHONE CONTACT MATCHING
// ============================================================================

/**
 * Match a list of phone numbers against registered iMaliChat users.
 * Returns matching user profiles (public fields only), respecting
 * privacy settings and block lists.
 */
export const matchPhoneContacts = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    await requireAppCheck(request, "matchPhoneContacts");

    const { phoneNumbers } = request.data;

    if (!Array.isArray(phoneNumbers) || phoneNumbers.length === 0) {
      throw new HttpsError("invalid-argument", "phoneNumbers must be a non-empty array");
    }

    if (phoneNumbers.length > 500) {
      throw new HttpsError("invalid-argument", "Maximum 500 phone numbers per request");
    }

    // Get caller's blocked list
    const callerDoc = await db.collection("users").doc(userId).get();
    const callerBlockedIds: string[] = callerDoc.data()?.chat?.blockedUserIds || [];

    // Get caller's existing contacts with their status
    const existingContactsSnap = await db
      .collection("contacts")
      .where("userId", "==", userId)
      .get();
    const contactStatusMap = new Map<string, string>();
    for (const d of existingContactsSnap.docs) {
      const data = d.data();
      contactStatusMap.set(data.contactUserId as string, data.status as string);
    }

    const matchedUsers: Array<{
      userId: string;
      displayName: string;
      username: string | null;
      avatarUrl: string | null;
      avatarColor: string | null;
      phoneNumber: string;
      isExistingContact: boolean;
      contactStatus: string | null;
    }> = [];

    // Query users by phone number in batches of 30 (Firestore whereIn limit)
    const batchSize = 30;
    for (let i = 0; i < phoneNumbers.length; i += batchSize) {
      const batch = phoneNumbers.slice(i, i + batchSize);

      const snap = await db
        .collection("users")
        .where("phoneNumber", "in", batch)
        .get();

      for (const doc of snap.docs) {
        const uid = doc.id;

        // Skip self
        if (uid === userId) continue;

        // Skip users blocked by caller or who blocked caller
        if (callerBlockedIds.includes(uid)) continue;
        const userBlockedIds: string[] = doc.data().chat?.blockedUserIds || [];
        if (userBlockedIds.includes(userId)) continue;

        // Skip users with discoverability "nobody"
        const discoverability = doc.data().privacy?.discoverability || "everyone";
        if (discoverability === "nobody") continue;

        const userData = doc.data();
        const status = contactStatusMap.get(uid) || null;
        matchedUsers.push({
          userId: uid,
          displayName: userData.displayName || "User",
          username: userData.username || null,
          avatarUrl: userData.avatarUrl || null,
          avatarColor: userData.avatarColor || null,
          phoneNumber: userData.phoneNumber || "",
          isExistingContact: status === "accepted",
          contactStatus: status,
        });
      }
    }

    logger.info(`matchPhoneContacts: matched ${matchedUsers.length} users from ${phoneNumbers.length} numbers for user ${userId}`);

    return { success: true, matches: matchedUsers };
  }
);

// ============================================================================
// PEOPLE YOU MAY KNOW
// ============================================================================

/**
 * Get suggested contacts the user may know.
 * Sources:
 *   1. Friends of friends (contacts of your contacts)
 *   2. Members of shared communities
 * Returns ranked list with reasons, respects privacy and blocks.
 */
export const getPeopleYouMayKnow = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    await requireAppCheck(request, "getPeopleYouMayKnow");

    const userDoc = await db.collection("users").doc(userId).get();
    const userData = userDoc.data()!;
    const callerBlockedIds: string[] = userData.chat?.blockedUserIds || [];

    // Get caller's existing contact user IDs
    const contactsSnap = await db
      .collection("contacts")
      .where("userId", "==", userId)
      .get();
    const existingContactIds = new Set(
      contactsSnap.docs.map((d) => d.data().contactUserId as string)
    );
    existingContactIds.add(userId); // exclude self

    const suggestions: Map<string, {
      userId: string;
      displayName: string;
      username: string | null;
      avatarUrl: string | null;
      avatarColor: string | null;
      reason: string;
      source: string;
      score: number;
    }> = new Map();

    // Helper to check if a user should be excluded
    const shouldExclude = (uid: string): boolean => {
      return existingContactIds.has(uid) || callerBlockedIds.includes(uid);
    };

    // 1. Friends of friends — contacts of your contacts
    const myContactUserIds = contactsSnap.docs
      .filter((d) => d.data().status === "accepted")
      .map((d) => d.data().contactUserId as string)
      .slice(0, 20);

    for (const friendId of myContactUserIds) {
      const friendContactsSnap = await db
        .collection("contacts")
        .where("userId", "==", friendId)
        .where("status", "==", "accepted")
        .limit(20)
        .get();

      for (const fDoc of friendContactsSnap.docs) {
        const fData = fDoc.data();
        const suggestedId = fData.contactUserId as string;

        if (shouldExclude(suggestedId)) continue;
        if (suggestions.has(suggestedId)) {
          const existing = suggestions.get(suggestedId)!;
          existing.score += 1;
          const count = existing.score;
          existing.reason = `${count} mutual friends`;
          continue;
        }

        const suggestedDoc = await db.collection("users").doc(suggestedId).get();
        if (!suggestedDoc.exists) continue;
        const sData = suggestedDoc.data()!;

        const disc = sData.privacy?.discoverability || "everyone";
        if (disc === "nobody") continue;

        const sBlockedIds: string[] = sData.chat?.blockedUserIds || [];
        if (sBlockedIds.includes(userId)) continue;

        suggestions.set(suggestedId, {
          userId: suggestedId,
          displayName: sData.displayName || "User",
          username: sData.username || null,
          avatarUrl: sData.avatarUrl || null,
          avatarColor: sData.avatarColor || null,
          reason: "1 mutual friend",
          source: "mutualFriend",
          score: 1,
        });
      }

      if (suggestions.size >= 20) break;
    }

    // 2. Community members
    if (suggestions.size < 20) {
      const commSnap = await db
        .collection("communityMembers")
        .where("userId", "==", userId)
        .where("status", "==", "active")
        .limit(5)
        .get();

      for (const mem of commSnap.docs) {
        const communityId = mem.data().communityId as string;

        const commDoc = await db.collection("communities").doc(communityId).get();
        const commName = commDoc.data()?.name || "a community";

        const membersSnap = await db
          .collection("communityMembers")
          .where("communityId", "==", communityId)
          .where("status", "==", "active")
          .limit(20)
          .get();

        for (const mDoc of membersSnap.docs) {
          const memberId = mDoc.data().userId as string;
          if (shouldExclude(memberId)) continue;
          if (suggestions.has(memberId)) continue;

          const memberDoc = await db.collection("users").doc(memberId).get();
          if (!memberDoc.exists) continue;
          const mData = memberDoc.data()!;

          const disc = mData.privacy?.discoverability || "everyone";
          if (disc === "nobody") continue;

          const mBlockedIds: string[] = mData.chat?.blockedUserIds || [];
          if (mBlockedIds.includes(userId)) continue;

          suggestions.set(memberId, {
            userId: memberId,
            displayName: mData.displayName || "User",
            username: mData.username || null,
            avatarUrl: mData.avatarUrl || null,
            avatarColor: mData.avatarColor || null,
            reason: `Member of ${commName}`,
            source: "communityMember",
            score: 0,
          });

          if (suggestions.size >= 20) break;
        }
        if (suggestions.size >= 20) break;
      }
    }

    // Sort by score descending, remove score from output
    const sorted = Array.from(suggestions.values())
      .sort((a, b) => b.score - a.score)
      .slice(0, 20)
      .map((s) => ({
        userId: s.userId,
        displayName: s.displayName,
        username: s.username,
        avatarUrl: s.avatarUrl,
        avatarColor: s.avatarColor,
        reason: s.reason,
        source: s.source,
      }));

    logger.info(`getPeopleYouMayKnow: ${sorted.length} suggestions for user ${userId}`);

    return { success: true, suggestions: sorted };
  }
);

// ============================================================================
// PENDING INVITES (phone-based invite tracking)
// ============================================================================

/**
 * Record a pending invite when a user shares an invite link for a specific
 * phone contact. This enables auto-contact creation when the invitee registers.
 *
 * Collection: pendingInvites/{docId}
 *   inviterUserId, invitedPhoneNumber, referralCode?, status, createdAt, claimedAt?, claimedByUserId?
 */
export const recordPendingInvite = onCall(
  { labels: { area: "social" } },
  async (request) => {
    const userId = requireAuth(request);
    await requireAppCheck(request, "recordPendingInvite");

    const { phoneNumber, referralCode } = request.data;

    if (!phoneNumber || typeof phoneNumber !== "string") {
      throw new HttpsError("invalid-argument", "phoneNumber is required");
    }

    // Normalize phone number (strip spaces/dashes, ensure + prefix)
    let normalized = phoneNumber.replace(/[\s\-()]/g, "");
    if (normalized.startsWith("0") && normalized.length === 10) {
      normalized = "+27" + normalized.substring(1);
    }
    if (!normalized.startsWith("+")) {
      normalized = "+" + normalized;
    }

    // Prevent duplicate pending invites from same inviter for same phone
    const existing = await db
      .collection("pendingInvites")
      .where("inviterUserId", "==", userId)
      .where("invitedPhoneNumber", "==", normalized)
      .where("status", "==", "pending")
      .limit(1)
      .get();

    if (!existing.empty) {
      logger.info(`Duplicate pending invite skipped: ${userId} → ${normalized}`);
      return { success: true, alreadyExists: true };
    }

    await db.collection("pendingInvites").add({
      inviterUserId: userId,
      invitedPhoneNumber: normalized,
      referralCode: referralCode || null,
      status: "pending",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      claimedAt: null,
      claimedByUserId: null,
    });

    logger.info(`Recorded pending invite: ${userId} → ${normalized}`);
    return { success: true };
  }
);

// ============================================================================
// AUTO-CREATE CONTACTS HELPER
// ============================================================================

/**
 * Auto-create paired contact documents for two users.
 * Used by referral signup flow and phone-based invite tracking.
 * Checks for existing relationship to avoid duplicates.
 */
export async function autoCreateContacts(
  userIdA: string,
  userIdB: string,
  initiatedBy: string = "system_referral"
): Promise<boolean> {
  // Check for existing relationship
  const existingSnap = await db
    .collection("contacts")
    .where("userId", "==", userIdA)
    .where("contactUserId", "==", userIdB)
    .limit(1)
    .get();

  if (!existingSnap.empty) {
    logger.info(`autoCreateContacts: relationship already exists between ${userIdA} and ${userIdB}`);
    return false;
  }

  // Fetch both user profiles
  const [userADoc, userBDoc] = await Promise.all([
    db.collection("users").doc(userIdA).get(),
    db.collection("users").doc(userIdB).get(),
  ]);

  const userAData = userADoc.exists ? userADoc.data()! : {};
  const userBData = userBDoc.exists ? userBDoc.data()! : {};

  const now = admin.firestore.FieldValue.serverTimestamp();
  const batch = db.batch();

  // A → B contact doc
  const refAB = db.collection("contacts").doc();
  batch.set(refAB, {
    userId: userIdA,
    contactUserId: userIdB,
    displayName: userBData.displayName || "User",
    username: userBData.username || null,
    avatarUrl: userBData.avatarUrl || null,
    avatarColor: userBData.avatarColor || null,
    phoneNumber: userBData.phoneNumber || null,
    status: "accepted",
    isFavorite: false,
    nickname: null,
    notes: null,
    initiatedBy,
    createdAt: now,
    lastInteractionAt: null,
  });

  // B → A contact doc
  const refBA = db.collection("contacts").doc();
  batch.set(refBA, {
    userId: userIdB,
    contactUserId: userIdA,
    displayName: userAData.displayName || "User",
    username: userAData.username || null,
    avatarUrl: userAData.avatarUrl || null,
    avatarColor: userAData.avatarColor || null,
    phoneNumber: userAData.phoneNumber || null,
    status: "accepted",
    isFavorite: false,
    nickname: null,
    notes: null,
    initiatedBy,
    createdAt: now,
    lastInteractionAt: null,
  });

  await batch.commit();
  logger.info(`autoCreateContacts: created mutual contact between ${userIdA} and ${userIdB}`);
  return true;
}
