# Enhanced Authentication — Operational Wiring Plan

## Status Summary

All screens, services, Cloud Functions, entities, repositories, platform channels, and DI registrations have been **created**. However, several critical **wiring gaps** prevent the system from functioning end-to-end. This document details every fix required to make the Enhanced Authentication fully operational.

---

## Part 1: Code Wiring Fixes

### FIX 1 — FCM Initialization in `main.dart` [CRITICAL]

**File:** `lib/main.dart`

**Problem:** Firebase Cloud Messaging is never initialized. No permission request, no foreground listener, no background handler. Without this, push-based login challenges are never received, and FCM tokens may be unavailable for device registration.

**Current state (lines 29–35):**
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
await configureDependencies();
```

**Required changes:**

1. Import `firebase_messaging`, `get_it`, and `fcm_challenge_handler.dart`
2. After `configureDependencies()`, add:
   ```dart
   // Request FCM permission (iOS requires explicit request)
   final messaging = GetIt.instance<FirebaseMessaging>();
   await messaging.requestPermission(
     alert: true,
     badge: true,
     sound: true,
   );

   // Start listening for auth challenge push notifications
   final challengeHandler = GetIt.instance<FcmChallengeHandler>();
   challengeHandler.startListening();
   ```
3. Register a top-level background message handler **before** `runApp`:
   ```dart
   // Top-level function (must be outside any class)
   @pragma('vm:entry-point')
   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
     // Background challenges are handled when the app opens via initial/onMessageOpenedApp
   }
   ```
   Then in `main()`:
   ```dart
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
   ```

**Why:** Without FCM initialization, the device never receives push notifications. The `FcmChallengeHandler.startListening()` call activates the foreground FCM stream that routes `auth_challenge` messages to the `challengeStream`.

---

### FIX 2 — Challenge Stream Navigation in `app.dart` [CRITICAL]

**File:** `lib/app.dart`

**Problem:** When an FCM push arrives with `type: auth_challenge`, `FcmChallengeHandler` pushes data to `challengeStream`. But nothing listens to that stream. The `ChallengeApprovalScreen` is never shown.

**Required changes:**

1. Import `dart:async`, `fcm_challenge_handler.dart`, and `get_it`
2. Add field: `late final FcmChallengeHandler _challengeHandler;`
3. Add field: `StreamSubscription<Map<String, dynamic>>? _challengeSubscription;`
4. In `initState()`, after existing init code, add:
   ```dart
   _challengeHandler = GetIt.instance<FcmChallengeHandler>();
   ```
5. After the router is initialized, subscribe to challenges:
   ```dart
   _challengeSubscription = _challengeHandler.challengeStream.listen((data) {
     final challengeId = data['challengeId'] as String?;
     final nonce = data['nonce'] as String?;
     if (challengeId != null && nonce != null) {
       _appRouter.router.push('/auth/challenge-approval', extra: {
         'challengeId': challengeId,
         'nonce': nonce,
       });
     }
   });
   ```
6. Also handle `onMessageOpenedApp` (user tapped notification while app was backgrounded):
   ```dart
   FirebaseMessaging.onMessageOpenedApp.listen((message) {
     final data = message.data;
     if (data['type'] == 'auth_challenge') {
       _appRouter.router.push('/auth/challenge-approval', extra: {
         'challengeId': data['challengeId'],
         'nonce': data['nonce'],
       });
     }
   });
   ```
7. Also check `getInitialMessage()` for cold-start from terminated state:
   ```dart
   FirebaseMessaging.instance.getInitialMessage().then((message) {
     if (message != null && message.data['type'] == 'auth_challenge') {
       _appRouter.router.push('/auth/challenge-approval', extra: {
         'challengeId': message.data['challengeId'],
         'nonce': message.data['nonce'],
       });
     }
   });
   ```
8. In `dispose()`, cancel: `_challengeSubscription?.cancel();`

**Why:** This is the glue between FCM push delivery and the approval screen UI. Without it, challenge pushes arrive but are silently dropped.

---

### FIX 3 — Add `signInWithCustomToken` to Auth Repository [CRITICAL]

**File:** `lib/domain/repositories/auth_repository.dart`

**Problem:** The push login flow produces a Firebase custom token, but there is no method to exchange it for a Firebase Auth session. The `AuthRepository` interface has no `signInWithCustomToken` method.

**Required changes to the interface:**
```dart
/// Sign in with a Firebase custom token (used by push-based login).
Future<Either<Failure, User>> signInWithCustomToken(String token);
```

**File:** `lib/data/repositories/auth_repository_impl.dart`

**Required implementation:**
```dart
@override
Future<Either<Failure, User>> signInWithCustomToken(String token) async {
  try {
    final credential = await _firebaseAuth.signInWithCustomToken(token);
    final firebaseUser = credential.user;
    if (firebaseUser == null) {
      return const Left(Failure.auth(message: 'Sign-in returned no user'));
    }

    // Fetch or create user profile from Firestore
    final userResult = await _authRemoteDataSource.getOrCreateUser(
      uid: firebaseUser.uid,
      phoneNumber: firebaseUser.phoneNumber,
    );

    return userResult.fold(
      (failure) => Left(failure),
      (user) => Right(user),
    );
  } catch (e) {
    return Left(_mapAuthException(e));
  }
}
```

**Why:** Both `push_login_screen.dart` and the new BLoC event (FIX 4) need this to convert the custom token into an actual authenticated session.

---

### FIX 4 — Add `authenticateWithPushToken` Event to AuthBloc [CRITICAL]

**File:** `lib/presentation/blocs/auth/auth_event.dart`

**Add new event:**
```dart
/// Authenticate using a custom token from push-based login approval.
const factory AuthEvent.authenticateWithPushToken({
  required String customToken,
}) = _AuthenticateWithPushToken;
```

**File:** `lib/presentation/blocs/auth/auth_bloc.dart`

**Register handler in constructor:**
```dart
on<_AuthenticateWithPushToken>(_onAuthenticateWithPushToken);
```

**Add handler method:**
```dart
Future<void> _onAuthenticateWithPushToken(
  _AuthenticateWithPushToken event,
  Emitter<AuthState> emit,
) async {
  emit(state.copyWith(status: AuthStatus.loading, isLoading: true));

  final result = await _authRepository.signInWithCustomToken(event.customToken);

  result.fold(
    (failure) {
      emit(state.copyWith(
        status: AuthStatus.error,
        isLoading: false,
        errorMessage: failure.displayMessage,
      ));
    },
    (user) {
      if (user.needsOnboarding) {
        emit(state.copyWith(
          status: AuthStatus.onboardingRequired,
          user: user,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
        ));
      }

      // Trigger non-blocking device binding
      add(const AuthEvent.bindDevice());
    },
  );
}
```

**Why:** The push login screen needs to call this event after receiving the custom token, so the AuthBloc transitions to `authenticated` and the router redirects to `/home`.

**Post-change:** Run `dart run build_runner build --delete-conflicting-outputs` to regenerate freezed files.

---

### FIX 5 — Push Login Screen Token Exchange [CRITICAL]

**File:** `lib/presentation/screens/auth/push_login_screen.dart`

**Problem (line 71–74):** When Firestore status becomes `approved`, the screen navigates directly to `/home` without exchanging the custom token. The user lands on home unauthenticated.

**Required changes:**

1. Change `watchChallengeStatus()` to also return the `customToken` field. Modify `FcmChallengeHandler.watchChallengeStatus()` to return a record instead of just a string:

   **File:** `lib/core/services/fcm_challenge_handler.dart`

   Change `watchChallengeStatus` (lines 98–108) from:
   ```dart
   Stream<String> watchChallengeStatus(String challengeId) {
     return _firestore
         .collection('authChallenges')
         .doc(challengeId)
         .snapshots()
         .map((snapshot) {
       if (!snapshot.exists) return 'expired';
       final data = snapshot.data()!;
       return data['status'] as String? ?? 'pending';
     });
   }
   ```
   To:
   ```dart
   Stream<({String status, String? customToken})> watchChallengeStatus(String challengeId) {
     return _firestore
         .collection('authChallenges')
         .doc(challengeId)
         .snapshots()
         .map((snapshot) {
       if (!snapshot.exists) return (status: 'expired', customToken: null);
       final data = snapshot.data()!;
       return (
         status: data['status'] as String? ?? 'pending',
         customToken: data['customToken'] as String?,
       );
     });
   }
   ```

2. Update `push_login_screen.dart` to use the new return type:

   Change field type:
   ```dart
   StreamSubscription<({String status, String? customToken})>? _statusSubscription;
   ```

   Change `_watchChallengeStatus()` (lines 63–79):
   ```dart
   void _watchChallengeStatus() {
     _statusSubscription = _challengeHandler
         .watchChallengeStatus(widget.challengeId)
         .listen((result) {
       if (!mounted) return;

       setState(() => _status = result.status);

       if (result.status == 'approved' && result.customToken != null) {
         _countdownTimer?.cancel();
         // Exchange the custom token for a Firebase Auth session
         context.read<AuthBloc>().add(
               AuthEvent.authenticateWithPushToken(
                 customToken: result.customToken!,
               ),
             );
         // Navigation will happen via router redirect once AuthBloc emits authenticated
       } else if (result.status == 'denied') {
         _countdownTimer?.cancel();
       }
     });
   }
   ```

3. Remove the direct `context.go('/home')` call. Add a `BlocListener` to handle the transition:
   ```dart
   // In build(), wrap the Scaffold with:
   BlocListener<AuthBloc, AuthState>(
     listener: (context, state) {
       if (state.status == AuthStatus.authenticated) {
         context.go('/home');
       } else if (state.status == AuthStatus.onboardingRequired) {
         context.go('/onboarding/terms');
       } else if (state.status == AuthStatus.error) {
         setState(() => _status = 'error');
       }
     },
     child: Scaffold(/* existing build */),
   )
   ```

4. Add `flutter_bloc` import.

**Why:** The custom token must be exchanged for a real Firebase Auth session before the user can access protected screens.

---

### FIX 6 — Session Lock Screen BLoC Integration [HIGH]

**File:** `lib/presentation/screens/auth/session_lock_screen.dart`

**Problem (lines 71–72, 98–99):** After successful unlock, the screen calls `_sessionLockService.markUnlocked()` and `context.go('/home')` directly. But the AuthBloc state remains `AuthStatus.sessionLocked`, causing stale redirect behavior.

**Required changes:**

1. Add `flutter_bloc` import and `AuthBloc` import
2. After successful unlock, dispatch the BLoC event instead of navigating directly:

   Replace (in `_attemptBiometricUnlock`, line 71–72):
   ```dart
   case UnlockResult.success:
     _sessionLockService.markUnlocked();
     context.go('/home');
   ```
   With:
   ```dart
   case UnlockResult.success:
     _sessionLockService.markUnlocked();
     context.read<AuthBloc>().add(const AuthEvent.unlockSession());
     // Router redirect will handle navigation to /home
   ```

3. Apply the same pattern to `_attemptPinUnlock` (line 98–99)

4. For the "Sign Out" button (line 124–126), dispatch `AuthEvent.signOut()`:
   ```dart
   void _signOut() {
     context.read<AuthBloc>().add(const AuthEvent.signOut());
   }
   ```

**Why:** The router redirect logic at `app_router.dart:617` checks `authState.status == AuthStatus.sessionLocked`. If the BLoC isn't updated, the router remains confused about auth state.

---

### FIX 7 — iOS Face ID Permission [HIGH]

**File:** `ios/Runner/Info.plist`

**Problem:** The `NSFaceIDUsageDescription` key is missing. On iOS devices with Face ID, the `local_auth` plugin will crash or fail silently without this.

**Required change:** Add to the `<dict>` section:
```xml
<key>NSFaceIDUsageDescription</key>
<string>iMali uses Face ID to securely unlock your session and verify your identity.</string>
```

**Why:** iOS requires a usage description for Face ID access. Without it, `local_auth.authenticate()` will throw a runtime error on Face ID devices (iPhone X and later).

---

### FIX 8 — Step-Up Auth Integration in High-Risk Screens [MEDIUM]

**Problem:** `StepUpAuthService` exists and works, but no screen calls it. High-risk operations (cashout, large transfers, profile changes) proceed without identity verification.

**Files to modify:**

#### A. `lib/presentation/screens/wallet/cashout_screen.dart`
Before executing a cashout, add step-up check:
```dart
final stepUpService = GetIt.instance<StepUpAuthService>();
final required = stepUpService.evaluateRequired(
  actionType: 'cashout',
  amount: cashoutAmount,
);

switch (required) {
  case StepUpResult.notRequired:
    _executeCashout(); // proceed normally
  case StepUpResult.biometricVerified:
    final result = await stepUpService.performBiometricStepUp();
    if (result == StepUpResult.biometricVerified) {
      _executeCashout();
    }
  case StepUpResult.otpRequired:
    final verified = await context.push<bool>('/auth/step-up-otp', extra: {
      'phoneNumber': user.phoneNumber,
      'reason': 'Verify your identity to complete this cashout.',
    });
    if (verified == true) {
      _executeCashout();
    }
  default:
    break;
}
```

#### B. `lib/presentation/screens/wallet/wallet_send_screen.dart`
Same pattern as above with `actionType: 'large_transfer'` and the transfer amount.

#### C. `lib/presentation/screens/profile/edit_profile_screen.dart`
Before saving profile changes:
```dart
final required = stepUpService.evaluateRequired(actionType: 'profile_change');
// Handle biometric step-up
```

#### D. `lib/presentation/screens/settings/security_settings_screen.dart`
Before changing security settings:
```dart
final required = stepUpService.evaluateRequired(actionType: 'security_settings');
// Handle biometric step-up
```

**Why:** The step-up auth service has the decision matrix implemented but is never invoked from any UI. Without this, a stolen unlocked phone can execute high-value transactions without re-verification.

---

### FIX 9 — SIM Change Detection on App Resume [LOW]

**File:** `lib/app.dart`

**Problem:** `SimChangeDetector` exists but is never called. SIM changes are never detected.

**Required changes:**

1. Import `sim_change_detector.dart`
2. Add field: `late final SimChangeDetector _simChangeDetector;`
3. In `initState()`: `_simChangeDetector = GetIt.instance<SimChangeDetector>();`
4. In `_handleAppResumed()`, after the session lock check:
   ```dart
   // Check for SIM changes (non-blocking)
   _simChangeDetector.checkForSimChange();
   ```
5. Set the user ID when auth state changes:
   ```dart
   // In initState, listen to auth state for setting user IDs on services
   _authBloc.stream.listen((state) {
     final userId = state.user?.id;
     _sessionLockService.setUserId(userId);
     _simChangeDetector.setUserId(userId);
   });
   ```

**Why:** SIM change detection is a key risk signal. Without calling it, the `SimChangeDetector` service and the `createRiskEvent` Cloud Function are dead code.

---

### FIX 10 — Set User IDs on Security Services [LOW]

**File:** `lib/app.dart`

**Problem:** `SessionLockService`, `SimChangeDetector`, and `StepUpAuthService` all have `setUserId()` methods for audit logging, but they're never called. All audit log entries from these services will have `null` userIds and be silently skipped.

**Required changes:**

In `initState()`, after BLoC initialization, add a listener that propagates the user ID:
```dart
_authBloc.stream.listen((state) {
  final userId = state.user?.id;
  _sessionLockService.setUserId(userId);
  _simChangeDetector.setUserId(userId);
  // StepUpAuthService userId is set by the calling screen
});
```

**Why:** Without user IDs, all audit logging from session lock, SIM detection, and step-up auth is silently no-oped (each `_logEvent` method returns early if `_currentUserId == null`).

---

## Part 2: Deployment & Infrastructure

### DEPLOY 1 — Cloud Functions [CRITICAL]

All 11 auth-related Cloud Functions exist in `functions/src/auth.ts` but must be deployed to Firebase.

**Command:**
```bash
cd functions && npm run build && cd .. && firebase deploy --only functions
```

**Functions to verify are live after deploy:**
- `sendOtp`
- `verifyOtp`
- `registerDevice`
- `revokeDevice`
- `updateDeviceFcmToken`
- `loginRequest`
- `approveLogin`
- `denyLogin`
- `createRiskEvent`
- `resolveRiskEvent`
- `notifyNewDeviceLogin`

**Verification:** After deploy, test with:
```bash
firebase functions:log --only sendOtp
```

---

### DEPLOY 2 — Firestore Rules [CRITICAL]

The `firestore.rules` file contains server-only rules for `devices`, `authChallenges`, and `riskEvents` collections. These must be deployed.

**Command:**
```bash
firebase deploy --only firestore:rules
```

**Rules to verify:**
- `devices/{deviceId}` — read allowed for owner, write denied (server-only)
- `authChallenges/{challengeId}` — read allowed for owner, write denied
- `riskEvents/{eventId}` — read allowed for owner, write denied

---

### DEPLOY 3 — Firestore Composite Indexes [HIGH]

The Cloud Functions query Firestore with compound filters. Without indexes, these queries will fail at runtime with `FAILED_PRECONDITION` errors.

**Required indexes (create in Firebase Console → Firestore → Indexes, or via `firestore.indexes.json`):**

| Collection | Fields | Order |
|---|---|---|
| `authChallenges` | `userId` ASC, `status` ASC, `expiresAt` DESC | Composite |
| `devices` | `userId` ASC, `trusted` ASC, `revoked` ASC | Composite |
| `riskEvents` | `userId` ASC, `requiresAction` ASC, `createdAt` DESC | Composite |
| `verification_codes` | `phoneNumber` ASC, `expiresAt` DESC | Composite |

**Alternative:** Create `firestore.indexes.json`:
```json
{
  "indexes": [
    {
      "collectionGroup": "authChallenges",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "expiresAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "devices",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "trusted", "order": "ASCENDING" },
        { "fieldPath": "revoked", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "riskEvents",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "requiresAction", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "verification_codes",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "phoneNumber", "order": "ASCENDING" },
        { "fieldPath": "expiresAt", "order": "DESCENDING" }
      ]
    }
  ]
}
```
Then deploy: `firebase deploy --only firestore:indexes`

---

### DEPLOY 4 — iOS Info.plist Face ID Permission [HIGH]

**File:** `ios/Runner/Info.plist`

Add:
```xml
<key>NSFaceIDUsageDescription</key>
<string>iMali uses Face ID to securely unlock your session and verify your identity.</string>
```

Without this, `local_auth` will crash on any iOS device with Face ID.

---

### DEPLOY 5 — Build Runner Regeneration [REQUIRED]

After FIX 4 (new AuthEvent + AuthBloc handler), run:
```bash
dart run build_runner build --delete-conflicting-outputs
```

This regenerates:
- `auth_bloc.freezed.dart` (new event class)
- `injection.config.dart` (if any DI signatures changed)

---

### DEPLOY 6 — Dart Analyze [REQUIRED]

After all code changes:
```bash
dart analyze lib
```

Fix any errors or warnings before building.

---

## Part 3: Implementation Priority Order

| Priority | Fix | Severity | Reason |
|----------|-----|----------|--------|
| 1 | FIX 3 — `signInWithCustomToken` in auth repo | CRITICAL | Push login cannot complete without this |
| 2 | FIX 4 — `authenticateWithPushToken` BLoC event | CRITICAL | Push login has no way to update auth state |
| 3 | FIX 5 — Push login screen token exchange | CRITICAL | Connects approval to actual authentication |
| 4 | FIX 1 — FCM initialization in `main.dart` | CRITICAL | Push notifications don't work without this |
| 5 | FIX 2 — Challenge stream navigation in `app.dart` | CRITICAL | Approval screen never shown without this |
| 6 | DEPLOY 5 — Build runner | REQUIRED | Regenerate freezed code for new events |
| 7 | FIX 6 — Session lock BLoC dispatch | HIGH | Unlock doesn't restore auth state |
| 8 | FIX 7 — iOS Face ID plist | HIGH | iOS crash on Face ID devices |
| 9 | DEPLOY 1 — Cloud Functions | CRITICAL | All server calls fail without deploy |
| 10 | DEPLOY 2 — Firestore rules | CRITICAL | Security rules not enforced |
| 11 | DEPLOY 3 — Firestore indexes | HIGH | Compound queries fail at runtime |
| 12 | FIX 8 — Step-up auth in screens | MEDIUM | High-risk ops unprotected |
| 13 | FIX 9 — SIM change on resume | LOW | Risk detection inactive |
| 14 | FIX 10 — Set user IDs on services | LOW | Audit logging silently no-ops |
| 15 | DEPLOY 6 — Dart analyze | REQUIRED | Final verification |

---

## Part 4: Verification Checklist

After all fixes and deployments, verify each flow end-to-end:

### OTP Login Flow
- [ ] Enter phone number on `phone_input_screen`
- [ ] OTP sent via Cloud Function `sendOtp`
- [ ] Enter OTP on `otp_verification_screen`
- [ ] Cloud Function `verifyOtp` returns custom token
- [ ] Firebase Auth session created
- [ ] Device binding triggered (non-blocking)
- [ ] Device registered via Cloud Function `registerDevice`
- [ ] New users redirected to onboarding; existing users to home

### Push Login Flow
- [ ] Enter phone on `phone_input_screen`
- [ ] `loginRequest` Cloud Function called
- [ ] `hasTrustedDevice: true` returned for returning user
- [ ] Navigate to `push_login_screen` with countdown
- [ ] FCM push received on trusted device
- [ ] `challenge_approval_screen` opens with nonce
- [ ] "Approve" signs nonce with device private key
- [ ] `approveLogin` Cloud Function verifies ECDSA signature
- [ ] Custom token written to Firestore challenge doc
- [ ] `push_login_screen` reads custom token from Firestore
- [ ] `authenticateWithPushToken` exchanges token for Firebase session
- [ ] Router redirects to `/home`

### Session Lock Flow
- [ ] App goes to background for 30+ seconds
- [ ] `SessionLockService.onAppResumed()` returns `sessionLockRequired`
- [ ] `AuthBloc` emits `AuthStatus.sessionLocked`
- [ ] Router redirects to `/auth/session-lock`
- [ ] Tier 1/2: Biometric/credential prompt auto-triggers
- [ ] Tier 3: PIN entry with NumericKeyboard
- [ ] Tier 4: "Session expired" redirects to OTP
- [ ] After unlock: `AuthEvent.unlockSession()` dispatched
- [ ] Router redirects back to `/home`
- [ ] App background 5+ minutes: `forceReauth` signs out completely

### PIN Setup (Onboarding)
- [ ] Tier 3 device detected in `onboarding_settings_screen`
- [ ] Routed to `pin_setup_screen`
- [ ] 4-6 digit PIN entered and confirmed
- [ ] Weak PINs rejected (1234, 0000, sequential)
- [ ] PIN hash stored via `PinManager`
- [ ] Navigate to onboarding success

### Step-Up Auth
- [ ] Cashout >= R5,000 requires OTP step-up
- [ ] Cashout >= R1,000 requires biometric step-up
- [ ] Profile changes require biometric step-up
- [ ] `step_up_otp_screen` sends and verifies OTP
- [ ] Returns `true` on success, `false` on cancel

### SIM Change Detection
- [ ] SIM hash stored on first check
- [ ] New SIM detected on subsequent check
- [ ] Audit event logged
- [ ] Risk event created via `createRiskEvent` Cloud Function
- [ ] High-severity risk event triggers step-up on next sensitive action

### Challenge Approval (Trusted Device)
- [ ] FCM push with `type: auth_challenge` received in foreground
- [ ] `challengeStream` emits data
- [ ] `app.dart` listener navigates to `/auth/challenge-approval`
- [ ] Approve: nonce signed, `approveLogin` called, custom token returned
- [ ] Deny: `denyLogin` called, challenge marked denied
- [ ] Expired: countdown reaches 0, buttons disabled

---

## Part 5: Files Changed Summary

| File | Fix # | Change Type |
|------|-------|-------------|
| `lib/main.dart` | 1 | FCM init, background handler, permission request |
| `lib/app.dart` | 2, 9, 10 | Challenge stream listener, SIM check, user ID propagation |
| `lib/domain/repositories/auth_repository.dart` | 3 | Add `signInWithCustomToken` method |
| `lib/data/repositories/auth_repository_impl.dart` | 3 | Implement `signInWithCustomToken` |
| `lib/presentation/blocs/auth/auth_event.dart` | 4 | Add `authenticateWithPushToken` event |
| `lib/presentation/blocs/auth/auth_bloc.dart` | 4 | Add `_onAuthenticateWithPushToken` handler |
| `lib/core/services/fcm_challenge_handler.dart` | 5 | Change `watchChallengeStatus` return type to include `customToken` |
| `lib/presentation/screens/auth/push_login_screen.dart` | 5 | Exchange custom token via BLoC, add BlocListener |
| `lib/presentation/screens/auth/session_lock_screen.dart` | 6 | Dispatch `unlockSession` / `signOut` via BLoC |
| `ios/Runner/Info.plist` | 7 | Add `NSFaceIDUsageDescription` |
| `lib/presentation/screens/wallet/cashout_screen.dart` | 8 | Add step-up check before cashout |
| `lib/presentation/screens/wallet/wallet_send_screen.dart` | 8 | Add step-up check before transfer |
| `lib/presentation/screens/profile/edit_profile_screen.dart` | 8 | Add step-up check before profile save |
| `lib/presentation/screens/settings/security_settings_screen.dart` | 8 | Add step-up check before security changes |
