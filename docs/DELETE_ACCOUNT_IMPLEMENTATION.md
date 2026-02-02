# Delete Account — Full Implementation Plan

## Problem Statement

The "Delete Account" feature is non-functional. Five issues were identified:

1. **UI** — The delete button in Settings does nothing (`// TODO: Implement delete account`)
2. **BLoC** — No local cleanup (secure storage, keystore, SQLite, SharedPreferences)
3. **Remote** — Only calls `user.delete()` on Firebase Auth; no Firestore cleanup
4. **Server trigger** — `onUserDeleted` only cleans 4 of ~30 collections
5. **Trigger gap** — `user.delete()` (Auth) does NOT delete the Firestore `users/{userId}` document, so the `onUserDeleted` Firestore trigger may never fire

## Solution Architecture

Replace the client-side `user.delete()` approach with a **server-side Cloud Function** that orchestrates all cleanup in the correct order:

```
User taps "Delete" in Settings
  → BLoC dispatches deleteAccount event
    → Client calls deleteUserAccount Cloud Function (authenticated)
      → Cloud Function:
          1. Deletes all Firestore user data across all collections
          2. Deletes the users/{userId} document
          3. Deletes the Firebase Auth account via Admin SDK
          4. Returns success
    → Client receives success:
          1. Clears local secure storage (device binding, biometric cache)
          2. Deletes hardware ECDSA keypair
          3. Clears local SQLite database
          4. Emits unauthenticated state → navigates to Welcome
```

**Why a Cloud Function instead of client-side deletion?**
- Client-side `user.delete()` requires recent authentication (may throw `requires-recent-login`)
- Admin SDK `admin.auth().deleteUser(uid)` has no such restriction
- Server can reliably clean all Firestore collections in a single transaction
- No dependency on Firestore triggers firing correctly
- Function can return success/failure to the client

---

## File Changes

### NEW FILES

#### 1. `functions/src/accountDeletion.ts`

New Cloud Function: `deleteUserAccount`

```typescript
/**
 * Account Deletion Cloud Function
 *
 * Authenticated callable that deletes ALL user data from Firestore,
 * then deletes the Firebase Auth account via Admin SDK.
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { requireAppCheck } from "./security";

const db = admin.firestore();

/**
 * Delete a user's account and all associated data.
 *
 * Must be called by the authenticated user themselves.
 * Performs complete data cleanup across all Firestore collections,
 * then deletes the Firebase Auth account.
 *
 * @returns {{ success: boolean }}
 */
export const deleteUserAccount = functions.https.onCall(
  async (data, context) => {
    // Require authentication — only the user themselves can delete
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated to delete their account."
      );
    }
    requireAppCheck(context, "deleteUserAccount");

    const userId = context.auth.uid;

    console.log(`Account deletion requested by user ${userId}`);

    try {
      // ── Phase 1: Delete user-specific documents (by field query) ──────
      //
      // Collections where user is referenced by a field (not doc ID).
      // Each entry: [collectionName, fieldName]

      const fieldQueryCollections: [string, string][] = [
        // Financial
        ["wallets", "oddienceUserId"],
        ["transactions", "oddienceUserId"],
        ["cashouts", "oddienceUserId"],
        ["earnings", "oddienceUserId"],
        // Earning & engagement
        ["earnThreads", "oddienceUserId"],
        ["engagements", "oddienceUserId"],
        // Gamification
        ["potEntries", "oddienceUserId"],
        ["potWinners", "oddienceUserId"],
        ["leaderboard", "oddienceUserId"],
        // Referrals
        ["referralCodes", "oddienceUserId"],
        ["referralStats", "oddienceUserId"],
        ["referrals", "referrerId"],
        ["referrals", "refereeUserId"],
        // Purchases
        ["purchases", "oddienceUserId"],
        // Contacts
        ["contacts", "userId"],
        // Devices & auth
        ["devices", "userId"],
        ["authChallenges", "userId"],
        ["biometricChallenges", "userId"],
        // Security & fraud
        ["fraudFlags", "userId"],
        ["fraudAlerts", "userId"],
        ["riskEvents", "userId"],
        ["auditLogs", "userId"],
        ["integrityChecks", "userId"],
        ["captchaVerifications", "userId"],
        // Chat — sender side
        ["chatMessages", "senderId"],
        // Payment requests — requester side
        ["paymentRequests", "requesterId"],
      ];

      for (const [collection, field] of fieldQueryCollections) {
        await deleteByFieldQuery(collection, field, userId);
      }

      // ── Phase 2: Delete chat-related data where user is recipient ─────
      //
      // Chat messages where user is recipient: anonymize rather than
      // delete, so the other participant keeps their conversation history.

      await anonymizeChatRecipient(userId);

      // ── Phase 3: Clean up chat threads ────────────────────────────────
      //
      // Remove user from participantIds arrays. If the thread has no
      // remaining participants, delete it entirely.

      await cleanupChatThreads(userId);

      // ── Phase 4: Clean up payment requests where user is payer ────────

      await deleteByFieldQuery("paymentRequests", "payerId", userId);

      // ── Phase 5: Delete documents by ID ───────────────────────────────
      //
      // Some collections use userId as document ID.

      const docIdCollections = [
        "wallets",
        "leaderboard",
        "referralStats",
        "referralCodes",
        "blockedUsers",
      ];

      const docIdBatch = db.batch();
      for (const collection of docIdCollections) {
        docIdBatch.delete(db.collection(collection).doc(userId));
      }
      await docIdBatch.commit();

      // ── Phase 6: Delete rate limit documents ──────────────────────────
      //
      // Rate limit docs have composite IDs: ${identifier}_${action}
      // where identifier may be the userId.

      await deleteRateLimits(userId);

      // ── Phase 7: Delete the user document itself ──────────────────────

      await db.collection("users").doc(userId).delete();

      // ── Phase 8: Delete Firebase Auth account ─────────────────────────

      await admin.auth().deleteUser(userId);

      console.log(
        `Account deletion complete for user ${userId}: ` +
        `all Firestore data and Auth account removed.`
      );

      return { success: true };

    } catch (error) {
      console.error(`Account deletion failed for user ${userId}:`, error);
      throw new functions.https.HttpsError(
        "internal",
        "Account deletion failed. Please try again or contact support."
      );
    }
  }
);

// ── Helper Functions ──────────────────────────────────────────────────────

/**
 * Delete all documents in a collection where field == value.
 * Uses batched writes (max 500 per batch) for efficiency.
 */
async function deleteByFieldQuery(
  collectionName: string,
  field: string,
  value: string
): Promise<void> {
  const query = db.collection(collectionName)
    .where(field, "==", value)
    .limit(500);

  let deleted = 0;

  // Loop to handle collections with >500 matching documents
  while (true) {
    const snapshot = await query.get();
    if (snapshot.empty) break;

    const batch = db.batch();
    snapshot.docs.forEach((doc) => batch.delete(doc.ref));
    await batch.commit();
    deleted += snapshot.size;

    if (snapshot.size < 500) break;
  }

  if (deleted > 0) {
    console.log(
      `  Deleted ${deleted} docs from ${collectionName} (${field}=${value})`
    );
  }
}

/**
 * Anonymize chat messages where the deleted user is the recipient.
 *
 * We don't delete these because the sender still needs their
 * conversation history. Instead, we clear recipient-identifying info.
 */
async function anonymizeChatRecipient(userId: string): Promise<void> {
  const query = db.collection("chatMessages")
    .where("recipientId", "==", userId)
    .limit(500);

  let updated = 0;

  while (true) {
    const snapshot = await query.get();
    if (snapshot.empty) break;

    const batch = db.batch();
    snapshot.docs.forEach((doc) => {
      batch.update(doc.ref, {
        recipientId: "deleted_user",
      });
    });
    await batch.commit();
    updated += snapshot.size;

    if (snapshot.size < 500) break;
  }

  if (updated > 0) {
    console.log(`  Anonymized ${updated} chat messages (recipient)`);
  }
}

/**
 * Remove user from chat thread participant lists.
 * Delete threads that become empty.
 */
async function cleanupChatThreads(userId: string): Promise<void> {
  const threads = await db.collection("chatThreads")
    .where("participantIds", "array-contains", userId)
    .get();

  if (threads.empty) return;

  const batch = db.batch();
  let deleted = 0;
  let updated = 0;

  for (const doc of threads.docs) {
    const data = doc.data();
    const participants: string[] = data.participantIds || [];
    const remaining = participants.filter((id: string) => id !== userId);

    if (remaining.length === 0) {
      batch.delete(doc.ref);
      deleted++;
    } else {
      batch.update(doc.ref, {
        participantIds: remaining,
      });
      updated++;
    }
  }

  await batch.commit();
  console.log(
    `  Chat threads: ${deleted} deleted, ${updated} updated (removed participant)`
  );
}

/**
 * Delete rate limit documents that contain the userId in their
 * composite document ID (format: ${identifier}_${action}).
 */
async function deleteRateLimits(userId: string): Promise<void> {
  // Rate limit doc IDs may use the userId or deviceId as prefix.
  // We query for docs whose ID starts with the userId.
  // Since Firestore doesn't support doc ID prefix queries natively,
  // we use a range query on __name__.
  const rateLimitsRef = db.collection("rateLimits");
  const snapshot = await rateLimitsRef
    .where(admin.firestore.FieldPath.documentId(), ">=", userId)
    .where(
      admin.firestore.FieldPath.documentId(),
      "<",
      userId + "\uf8ff"
    )
    .get();

  if (snapshot.empty) return;

  const batch = db.batch();
  snapshot.docs.forEach((doc) => batch.delete(doc.ref));
  await batch.commit();

  console.log(`  Deleted ${snapshot.size} rate limit docs for user`);
}
```

---

### MODIFIED FILES

#### 2. `functions/src/index.ts`

**Change:** Add export for the new account deletion module.

```
Current (line 24):
  export * from "./biometricAuth";

Add after line 24:
  export * from "./accountDeletion";
```

---

#### 3. `lib/data/datasources/remote/auth_remote_datasource.dart`

**Change:** Replace client-side `user.delete()` with a Cloud Function call.

**Current implementation (lines 163-170):**
```dart
@override
Future<void> deleteAccount() async {
  final user = _firebaseAuth.currentUser;
  if (user == null) {
    throw const AuthException(message: 'No user signed in');
  }
  await user.delete();
}
```

**New implementation:**
```dart
@override
Future<void> deleteAccount() async {
  final user = _firebaseAuth.currentUser;
  if (user == null) {
    throw const AuthException(message: 'No user signed in');
  }

  try {
    final callable = _functions.httpsCallable('deleteUserAccount');
    await callable.call<Map<String, dynamic>>({});
  } on FirebaseFunctionsException catch (e) {
    throw AuthException(
      message: e.message ?? 'Account deletion failed',
    );
  }

  // Sign out locally after server-side deletion completes.
  // The Auth account no longer exists, so this just clears local state.
  await _firebaseAuth.signOut();
}
```

**Note:** The `_functions` field (`FirebaseFunctions`) must be injected. Check if it already exists on `AuthRemoteDataSourceImpl`. If not, add it to the constructor:
```dart
final FirebaseFunctions _functions;
```

---

#### 4. `lib/presentation/blocs/auth/auth_bloc.dart`

**Change:** Add local cleanup to `_onDeleteAccount` (lines 369-388).

**Current:**
```dart
Future<void> _onDeleteAccount(
  _DeleteAccount event,
  Emitter<AuthState> emit,
) async {
  emit(state.copyWith(isLoading: true));

  final result = await _authRepository.deleteAccount();

  result.fold(
    (failure) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      ));
    },
    (_) {
      emit(const AuthState(status: AuthStatus.unauthenticated));
    },
  );
}
```

**New:**
```dart
Future<void> _onDeleteAccount(
  _DeleteAccount event,
  Emitter<AuthState> emit,
) async {
  emit(state.copyWith(isLoading: true));

  // Capture userId before deletion (needed for keystore cleanup)
  final userId = state.user?.id;

  final result = await _authRepository.deleteAccount();

  result.fold(
    (failure) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.displayMessage,
      ));
    },
    (_) async {
      // Clear all local data
      await _deviceBindingService.clearBinding();
      await _biometricLoginService.clearCachedDisplayName();
      await _biometricLoginService.clearLastAuthTime();

      // Clear local SQLite database (cached wallets, transactions, chats, etc.)
      await _appDatabase.clearAllData();

      // Delete hardware-backed keypair
      if (userId != null) {
        await _deviceBindingService.deleteKeypair(userId);
      }

      emit(const AuthState(status: AuthStatus.unauthenticated));
    },
  );
}
```

**Additional dependencies needed in AuthBloc:**
- `BiometricLoginService.clearLastAuthTime()` — new method (see below)
- `DeviceBindingService.deleteKeypair(userId)` — new method (see below)
- `AppDatabase` — injected via DI (`@lazySingleton` on `AppDatabase`); calls `clearAllData()` to wipe local SQLite cache

---

#### 5. `lib/core/security/device_binding_service.dart`

**Change:** Add `deleteKeypair()` method after `clearBinding()` (after line 196).

```dart
/// Delete the hardware-backed ECDSA keypair for a given user.
/// Called during account deletion to remove cryptographic material.
Future<void> deleteKeypair(String userId) async {
  try {
    final alias = KeystoreService.keyAlias(userId);
    await _keystoreService.deleteKey(alias);
  } catch (e) {
    debugPrint('Failed to delete keypair for $userId: $e');
  }
}
```

---

#### 6. `lib/core/services/biometric_login_service.dart`

**Change:** Add `clearLastAuthTime()` method after `clearCachedDisplayName()` (after line 117).

```dart
/// Clear the cached last auth time (e.g., on account deletion).
Future<void> clearLastAuthTime() async {
  try {
    await _secureStorage.delete(key: _lastAuthTimeKey);
  } catch (e) {
    debugPrint('BiometricLogin: Failed to clear last auth time: $e');
  }
}
```

---

#### 7. `lib/presentation/screens/settings/settings_screen.dart`

**Change:** Wire up the delete button to dispatch the BLoC event (lines 167-171).

**Current:**
```dart
TextButton(
  onPressed: () {
    Navigator.pop(context);
    // TODO: Implement delete account
  },
  style: TextButton.styleFrom(foregroundColor: AppColors.error),
  child: const Text('Delete'),
),
```

**New:** Replace `_showDeleteAccountDialog` entirely to support loading state and error feedback. The screen needs to become `StatefulWidget` or use a BlocListener. Since it's currently `StatelessWidget`, the simplest approach is:

```dart
void _showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          // Account deleted — dialog and screen will be popped by router redirect
          Navigator.of(dialogContext, rootNavigator: true).pop();
        } else if (state.errorMessage != null && !state.isLoading) {
          // Deletion failed — close dialog and show error
          Navigator.of(dialogContext).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isDeleting = state.isLoading;

        return AlertDialog(
          title: const Text('Delete Account'),
          content: isDeleting
              ? const Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text('Deleting your account...'),
                    ),
                  ],
                )
              : const Text(
                  'Are you sure you want to delete your account? '
                  'This action cannot be undone. All your data including '
                  'tokens, transaction history, and referrals will be '
                  'permanently deleted.',
                ),
          actions: isDeleting
              ? [] // No buttons while deleting
              : [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(const AuthEvent.deleteAccount());
                    },
                    style:
                        TextButton.styleFrom(foregroundColor: AppColors.error),
                    child: const Text('Delete'),
                  ),
                ],
        );
      },
    ),
  );
}
```

---

#### 8. `functions/src/triggers.ts` — `onUserDeleted`

**Change:** Keep the existing trigger as a **safety net** but add a log noting it's a fallback. The primary cleanup is now handled by `deleteUserAccount`. No collections need to be added here since the Cloud Function handles everything before the document is deleted.

**Current (lines 190-224):** Leave as-is. The trigger may still fire if a Firestore document is deleted manually (e.g., via Firebase Console), and having it clean up 4 collections is better than nothing.

Optionally add a comment:
```typescript
/**
 * Clean up user data on account deletion.
 *
 * NOTE: This is a safety-net trigger. The primary cleanup is handled by
 * the deleteUserAccount callable function, which deletes all user data
 * across all collections before deleting this document.
 * This trigger catches manual deletions via Firebase Console.
 */
```

---

## Collection Cleanup Matrix

| Collection | Cleanup strategy | Phase |
|---|---|---|
| **wallets** | Delete by `oddienceUserId` query + doc ID | 1, 5 |
| **transactions** | Delete by `oddienceUserId` query | 1 |
| **cashouts** | Delete by `oddienceUserId` query | 1 |
| **earnings** | Delete by `oddienceUserId` query | 1 |
| **earnThreads** | Delete by `oddienceUserId` query | 1 |
| **engagements** | Delete by `oddienceUserId` query | 1 |
| **potEntries** | Delete by `oddienceUserId` query | 1 |
| **potWinners** | Delete by `oddienceUserId` query | 1 |
| **leaderboard** | Delete by `oddienceUserId` query + doc ID | 1, 5 |
| **referralCodes** | Delete by `oddienceUserId` query + doc ID | 1, 5 |
| **referralStats** | Delete by `oddienceUserId` query + doc ID | 1, 5 |
| **referrals** | Delete by `referrerId` AND `refereeUserId` | 1 |
| **purchases** | Delete by `oddienceUserId` query | 1 |
| **contacts** | Delete by `userId` query | 1 |
| **devices** | Delete by `userId` query | 1 |
| **authChallenges** | Delete by `userId` query | 1 |
| **biometricChallenges** | Delete by `userId` query | 1 |
| **fraudFlags** | Delete by `userId` query | 1 |
| **fraudAlerts** | Delete by `userId` query | 1 |
| **riskEvents** | Delete by `userId` query | 1 |
| **auditLogs** | Delete by `userId` query | 1 |
| **integrityChecks** | Delete by `userId` query | 1 |
| **captchaVerifications** | Delete by `userId` query | 1 |
| **chatMessages** (sender) | Delete by `senderId` query | 1 |
| **chatMessages** (recipient) | Anonymize `recipientId` → `"deleted_user"` | 2 |
| **chatThreads** | Remove from `participantIds`; delete if empty | 3 |
| **paymentRequests** | Delete by `requesterId` + `payerId` | 1, 4 |
| **blockedUsers** | Delete doc by userId | 5 |
| **rateLimits** | Delete by doc ID prefix match | 6 |
| **users/{userId}** | Delete the user document | 7 |
| **Firebase Auth** | `admin.auth().deleteUser(uid)` | 8 |

**Local cleanup (client-side):**

| Data store | What's cleared | Method |
|---|---|---|
| FlutterSecureStorage | Device binding keys | `DeviceBindingService.clearBinding()` |
| FlutterSecureStorage | Biometric display name | `BiometricLoginService.clearCachedDisplayName()` |
| FlutterSecureStorage | Last auth time | `BiometricLoginService.clearLastAuthTime()` |
| Local SQLite (Drift) | All cached data (wallets, transactions, earn threads, chat threads, chat messages, contacts, pending changes, sync metadata) | `AppDatabase.clearAllData()` |
| Android Keystore / iOS Secure Enclave | ECDSA P-256 keypair | `DeviceBindingService.deleteKeypair(userId)` |

**Not cleared (intentionally):**

| Data store | Reason |
|---|---|
| SharedPreferences | Non-PII app preferences; reset on reinstall |
| `verification_codes` | Keyed by phone number (not userId); auto-expire with short TTL |

---

## Edge Cases

### 1. `requires-recent-login` error
**Not applicable.** We use Admin SDK `admin.auth().deleteUser(uid)` which does not require recent authentication. The client only needs a valid auth token to call the Cloud Function.

### 2. Network failure during deletion
The Cloud Function is atomic from the client's perspective — it either succeeds fully or returns an error. If it fails partway through (e.g., Firestore timeout), the user can retry. Partial deletion of some collections is acceptable since it only reduces data, never creates inconsistency.

### 3. User has pending cashouts
The function deletes pending cashout records. Consider adding a pre-check in the Cloud Function that rejects deletion if there are pending cashouts with `status == "processing"`. This prevents financial disputes.

Optional guard (add to the Cloud Function before Phase 1):
```typescript
const pendingCashouts = await db.collection("cashouts")
  .where("oddienceUserId", "==", userId)
  .where("status", "==", "processing")
  .limit(1)
  .get();

if (!pendingCashouts.empty) {
  throw new functions.https.HttpsError(
    "failed-precondition",
    "Cannot delete account while cashouts are being processed."
  );
}
```

### 4. User is in an active pot draw
Similar to cashouts — if the user has active pot entries for the current day/week, the draw logic should handle missing users gracefully (it already queries by userId, so deleted entries won't appear).

### 5. Cloud Function timeout
The default Cloud Functions timeout is 60 seconds. For users with extensive data (thousands of chat messages), this may not be enough. Set the function timeout to 540 seconds (maximum for gen1):

```typescript
export const deleteUserAccount = functions
  .runWith({ timeoutSeconds: 540, memory: "512MB" })
  .https.onCall(async (data, context) => { ... });
```

### 6. Firestore batch limit (500 operations)
The `deleteByFieldQuery` helper already handles this with a loop that processes 500 documents at a time.

---

## Implementation Order

1. Create `functions/src/accountDeletion.ts`
2. Export from `functions/src/index.ts`
3. Compile and deploy: `cd functions && npx tsc && firebase deploy --only functions:deleteUserAccount`
4. Add `clearLastAuthTime()` to `BiometricLoginService`
5. Add `deleteKeypair()` to `DeviceBindingService`
6. Update `auth_remote_datasource.dart` — replace `user.delete()` with Cloud Function call
7. Update `auth_bloc.dart` — add local cleanup to `_onDeleteAccount`
8. Update `settings_screen.dart` — wire up delete button
9. Run `flutter pub run build_runner build` (if any freezed changes)
10. Run `flutter analyze lib/`

---

## Verification

1. `npx tsc` in functions/ — no TypeScript errors
2. `firebase deploy --only functions` — deploys `deleteUserAccount`
3. `flutter analyze lib/` — 0 issues
4. **Test: Delete account** — tap Delete in Settings → confirmation dialog → "Delete" → loading spinner → redirected to Welcome screen
5. **Test: Check Firestore** — verify user document and all related documents are gone
6. **Test: Check Firebase Auth** — verify Auth account is deleted (Firebase Console > Authentication)
7. **Test: Check local storage** — verify secure storage keys are cleared, keypair is deleted
8. **Test: Retry biometric** — after deletion, reopening app should show standard welcome (no "Welcome back")
9. **Test: Network failure** — disable network, tap Delete → should show error, data intact
10. **Test: Cancel** — tap Cancel in dialog → nothing happens, account intact
