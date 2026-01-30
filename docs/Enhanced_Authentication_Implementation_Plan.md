# Enhanced Authentication Implementation Plan

**Project**: iMaliChat
**Created**: 2026-01-29
**Status**: Planning
**Source**: Android Fintech Authentication Implementation Guide + Gap Analysis

## Overview

Implement enhanced authentication features for the iMaliChat Flutter fintech app: cryptographic device binding, biometric/tiered session unlock, push-based login, risk-event step-up auth, SIM change detection, and new device re-verification.

**Core Principle**: All new features degrade gracefully to the existing OTP flow if they fail. Enhanced auth never blocks the user.

**Regulatory Alignment**: POPIA (South Africa), PSD2 SCA (EU), NIST SP 800-63B

---

## Progress Tracker

### Phase 1: Foundation — Keystore + Device Infrastructure
| # | Task | Status | Notes |
|---|------|--------|-------|
| 1A | Create `KeystoreChannel.kt` (Android Keystore ECDSA) | Not Started | |
| 1A | Create `KeystoreChannel.swift` (iOS Secure Enclave) | Not Started | |
| 1A | Modify `MainActivity.kt` — register channel | Not Started | |
| 1A | Modify `AppDelegate.swift` — register channel | Not Started | |
| 1A | Create `lib/core/security/keystore_service.dart` | Not Started | |
| 1B | Create `lib/domain/entities/trusted_device.dart` | Not Started | |
| 1B | Create `lib/data/models/device_model.dart` | Not Started | |
| 1C | Create `lib/domain/repositories/device_repository.dart` | Not Started | |
| 1C | Create `lib/data/datasources/remote/device_remote_datasource.dart` | Not Started | |
| 1C | Create `lib/data/repositories/device_repository_impl.dart` | Not Started | |
| 1D | Modify `firestore.rules` — add devices/authChallenges/riskEvents | Not Started | |
| 1D | Modify `functions/src/auth.ts` — add `registerDevice` function | Not Started | |
| 1D | Modify `functions/src/security.ts` — add `device_register` rate limit | Not Started | |
| 1E | Modify `lib/core/di/register_module.dart` — add FlutterSecureStorage | Not Started | |
| 1E | Run `dart run build_runner build` | Not Started | |

### Phase 2: First Login Device Binding
| # | Task | Status | Notes |
|---|------|--------|-------|
| 2A | Create `lib/core/security/device_binding_service.dart` | Not Started | |
| 2B | Modify `lib/data/repositories/auth_repository_impl.dart` — bind after OTP | Not Started | |
| 2C | Modify `lib/core/security/device_fingerprint.dart` — real device ID | Not Started | |
| 2D | Modify `functions/src/auth.ts` — add `requiresDeviceRegistration` to verifyOtp | Not Started | |
| 2E | Modify `auth_state.dart` — add `isDeviceBound`, `deviceId` | Not Started | |
| 2E | Modify `auth_event.dart` — add `bindDevice()` | Not Started | |
| 2E | Modify `auth_bloc.dart` — add device binding handler | Not Started | |

### Phase 3: Tiered Session Lock (parallel with Phase 4)
| # | Task | Status | Notes |
|---|------|--------|-------|
| 3A | Modify `pubspec.yaml` — add `local_auth`, `crypto` | Not Started | |
| 3A | Modify `AndroidManifest.xml` — add `USE_BIOMETRIC` permission | Not Started | |
| 3B | Create `lib/core/security/device_capability_service.dart` | Not Started | |
| 3C | Create `lib/core/security/pin_manager.dart` | Not Started | |
| 3D | Create `lib/core/security/session_lock_service.dart` | Not Started | |
| 3E | Create `lib/presentation/screens/auth/session_lock_screen.dart` | Not Started | |
| 3F | Create `lib/presentation/screens/onboarding/pin_setup_screen.dart` | Not Started | |
| 3H | Modify `app_router.dart` — add `/auth/session-lock` route | Not Started | |
| 3H | Modify `auth_state.dart` — add `AuthStatus.sessionLocked` | Not Started | |
| 3H | Modify `auth_event.dart` — add `lockSession`, `unlockSession` | Not Started | |
| 3H | Modify `auth_bloc.dart` — add session lock handlers | Not Started | |
| 3H | Modify `app.dart` — add `WidgetsBindingObserver` | Not Started | |
| 3H | Modify `audit_logger.dart` — add session lock AuthAction enums | Not Started | |
| 3H | Modify `register_module.dart` — register `LocalAuthentication` | Not Started | |

### Phase 4: Push-Based Login Challenges (parallel with Phase 3)
| # | Task | Status | Notes |
|---|------|--------|-------|
| 4A | Create `lib/domain/entities/auth_challenge.dart` | Not Started | |
| 4A | Create `lib/data/models/auth_challenge_model.dart` | Not Started | |
| 4B | Modify `functions/src/auth.ts` — add `loginRequest` function | Not Started | |
| 4B | Modify `functions/src/auth.ts` — add `approveLogin` function | Not Started | |
| 4C | Create `lib/core/services/fcm_challenge_handler.dart` | Not Started | |
| 4D | Create `lib/presentation/screens/auth/push_login_screen.dart` | Not Started | |
| 4D | Create `lib/presentation/screens/auth/challenge_approval_screen.dart` | Not Started | |
| 4E | Modify `phone_input_screen.dart` — check trusted device first | Not Started | |
| 4E | Modify auth bloc/repository/datasource — push login methods | Not Started | |
| 4E | Modify `app_router.dart` — add push-login routes | Not Started | |

### Phase 5: Risk Events + Step-Up Auth + SIM Detection + New Device
| # | Task | Status | Notes |
|---|------|--------|-------|
| 5A | Create `lib/domain/entities/risk_event.dart` | Not Started | |
| 5B | Create `lib/core/security/sim_change_detector.dart` | Not Started | |
| 5B | Add `getSimInfo()` to `KeystoreChannel.kt` and `.swift` | Not Started | |
| 5C | Create `lib/core/security/step_up_auth_service.dart` | Not Started | |
| 5D | Create `lib/presentation/screens/auth/step_up_otp_screen.dart` | Not Started | |
| 5E | Modify `functions/src/auth.ts` — new device FCM notification | Not Started | |
| 5F | Modify `lib/domain/entities/user.dart` — add new fields | Not Started | |
| 5F | Modify `lib/data/models/user_model.dart` — add new fields | Not Started | |
| 5F | Modify `lib/core/error/failures.dart` — add new failure types | Not Started | |
| 5G | Add `createRiskEvent` Cloud Function | Not Started | |
| 5G | Add `resolveRiskEvent` Cloud Function | Not Started | |

---

## Phase 1: Foundation — Keystore Platform Channel + Device Infrastructure

**Goal**: Cross-platform cryptographic key management and Firestore device schema.

### 1A. Native Platform Channels

**Create** `android/app/src/main/kotlin/com/example/imalichat/KeystoreChannel.kt`
- ECDSA P-256 keypair via Android Keystore (`java.security.KeyPairGenerator`)
- Key alias: `imali_device_key_{userId}`
- Methods: `generateKeyPair(alias)`, `sign(alias, data)`, `deleteKey(alias)`, `hasKey(alias)`
- Hardware-backed when available (StrongBox/TEE)

**Modify** `android/app/src/main/kotlin/com/example/imalichat/MainActivity.kt`
- Register `KeystoreChannel` in `configureFlutterEngine`

**Create** `ios/Runner/KeystoreChannel.swift`
- ECDSA P-256 via Secure Enclave (fallback to Keychain on simulator)
- Same method surface as Android

**Modify** `ios/Runner/AppDelegate.swift`
- Register channel

**Create** `lib/core/security/keystore_service.dart`
- `@lazySingleton` Dart wrapper around `MethodChannel('com.imali.chat/keystore')`
- Returns `Either<Failure, T>` for all operations

### 1B. Device Entity + Model

**Create** `lib/domain/entities/trusted_device.dart`
- Fields: `deviceId`, `userId`, `publicKeyPem`, `platform`, `deviceModel`, `osVersion`, `fcmToken`, `trusted`, `revoked`, `registeredAt`, `lastUsedAt`

**Create** `lib/data/models/device_model.dart`
- Freezed model with `fromJson`/`toJson`/`toEntity()`

### 1C. Device Repository

**Create** `lib/domain/repositories/device_repository.dart`
- `registerDevice()`, `isDeviceTrusted()`, `getUserDevices()`, `revokeDevice()`

**Create** `lib/data/datasources/remote/device_remote_datasource.dart`
- Calls Cloud Functions via `FirebaseFunctions.httpsCallable`

**Create** `lib/data/repositories/device_repository_impl.dart`

### 1D. Firestore Rules + Cloud Function

**Modify** `firestore.rules` — add server-only collections:
```
match /devices/{deviceId} {
  allow read: if isAuthenticated() && resource.data.userId == request.auth.uid;
  allow create, update, delete: if false;
}
match /authChallenges/{challengeId} {
  allow read: if isAuthenticated() && resource.data.userId == request.auth.uid;
  allow create, update, delete: if false;
}
match /riskEvents/{eventId} {
  allow read: if isAuthenticated() && resource.data.userId == request.auth.uid;
  allow create, update, delete: if false;
}
```

**Modify** `functions/src/auth.ts` — add `registerDevice` callable function
**Modify** `functions/src/security.ts` — add `device_register` rate limit (5/day)

### 1E. DI

**Modify** `lib/core/di/register_module.dart` — add `FlutterSecureStorage` singleton
- Run `dart run build_runner build` after all injectable classes added

---

## Phase 2: First Login Device Binding

**Goal**: After OTP verification, auto-generate keypair and register device as trusted.

### 2A. Device Binding Service

**Create** `lib/core/security/device_binding_service.dart`
- `@lazySingleton` orchestrator
- `bindCurrentDevice(userId)`: check/generate key -> get FCM token -> get device fingerprint -> call registerDevice
- `isCurrentDeviceTrusted(userId)`: check secure storage first (fast), then server

### 2B. Integration into OTP Flow

**Modify** `lib/data/repositories/auth_repository_impl.dart`
- After successful `verifyOtp` + `signInWithCustomToken`, call `deviceBindingService.bindCurrentDevice()`
- Failure does NOT block auth (log + continue)

### 2C. Upgrade DeviceFingerprint

**Modify** `lib/core/security/device_fingerprint.dart`
- Replace placeholder `_getDeviceId()` with real `device_info_plus` calls (Android: `androidInfo.id`, iOS: `identifierForVendor`)
- Replace placeholder `_checkIsEmulator()` with real checks

### 2D. Cloud Function Enhancement

**Modify** `functions/src/auth.ts` `verifyOtp`
- After auth, check if user has trusted devices -> return `requiresDeviceRegistration` flag

### 2E. AuthBloc Extension

**Modify** `lib/presentation/blocs/auth/auth_state.dart` — add `isDeviceBound`, `deviceId`
**Modify** `lib/presentation/blocs/auth/auth_event.dart` — add `bindDevice()`
**Modify** `lib/presentation/blocs/auth/auth_bloc.dart` — add handler (non-blocking)

---

## Phase 3: Tiered Session Lock *(can run parallel with Phase 4)*

**Goal**: Require authentication to unlock app when returning from background, adapting to device capabilities. Supports biometric, OS PIN/pattern, in-app PIN, and OTP-only fallback.

### Tiered Approach (for older/budget devices without biometrics)

| Tier | Device Capability | Unlock Method | Detection |
|------|---|---|---|
| **1** | Biometric hardware | Fingerprint / Face | `canCheckBiometrics == true` |
| **2** | No biometrics, screen lock set | OS PIN / Pattern / Password | `isDeviceSupported() == true` |
| **3** | No screen lock configured | In-app 4-6 digit PIN | `isDeviceSupported() == false` |
| **4** | Secure storage broken (rooted) | OTP re-verification only | `FlutterSecureStorage` write fails |

Timeouts (same across all tiers):
- **30 seconds** background -> tier-appropriate session lock
- **5 minutes** background -> full OTP re-auth regardless of tier

### 3A. Packages

**Modify** `pubspec.yaml` — add `local_auth: ^2.3.0`, `crypto: ^3.0.6`
**Modify** `android/app/src/main/AndroidManifest.xml` — add `USE_BIOMETRIC` permission

### 3B. Device Capability Detection

**Create** `lib/core/security/device_capability_service.dart`
- `@lazySingleton` class
- `detectCapabilityTier()` -> returns `AuthCapabilityTier` enum (biometric, deviceCredential, inAppPin, otpOnly)
- Checks `canCheckBiometrics`, `isDeviceSupported()`, secure storage writability
- Caches result after first detection
- Logs tier to AuditLogger for risk profiling

### 3C. In-App PIN Manager

**Create** `lib/core/security/pin_manager.dart`
- `@lazySingleton` class
- `setPin(pin)` — validates strength, stores HMAC-SHA256 hash + salt in `flutter_secure_storage`
- `verifyPin(pin)` — constant-time hash comparison
- `isPinSet()` — check if PIN exists
- `changePin(oldPin, newPin)` — verify old, set new
- PIN never leaves device, never transmitted to server
- Rejects weak PINs: all same digit, `1234`, `4321`, sequential patterns

### 3D. Session Lock Service

**Create** `lib/core/security/session_lock_service.dart`
- `@lazySingleton` class
- `onAppPaused()` — records background timestamp
- `onAppResumed()` -> `SessionLockResult` (noLockNeeded, sessionLockRequired, fullReauthRequired)
- `attemptUnlock({String? pin})` — dispatches to tier-appropriate unlock:
  - Tier 1: biometric prompt -> on fail, falls back to Tier 2
  - Tier 2: OS credential prompt (PIN/pattern/password)
  - Tier 3: validates in-app PIN via PinManager
  - Tier 4: returns `requiresFullReauth`
- 5 failed PIN attempts -> forced OTP re-auth
- All unlock attempts logged via AuditLogger

### 3E. Lock Screen UI

**Create** `lib/presentation/screens/auth/session_lock_screen.dart`
- Adaptive UI based on detected tier:
  - Tier 1/2: "Tap to unlock" -> triggers `local_auth` prompt automatically
  - Tier 3: Shows in-app PIN entry using existing `NumericKeyboard` widget, displays remaining attempts
  - Tier 4: "Session expired" -> navigates to OTP flow
- iMali logo, blurred background overlay
- "Sign Out" option at bottom
- Implemented as full-screen overlay (not route redirect) to prevent data visibility during transition

### 3F. PIN Setup Screen (Onboarding)

**Create** `lib/presentation/screens/onboarding/pin_setup_screen.dart`
- Shown during onboarding ONLY for Tier 3 devices (mandatory)
- "Create a PIN to secure your account"
- 4-6 digit entry with `NumericKeyboard`
- Confirm PIN (enter twice)
- Recommends enabling device screen lock (link to `android.settings.SECURITY_SETTINGS`)

### 3G. Onboarding Integration

During onboarding (after OTP verification), detect capability tier:
- Tier 1/2: brief explanation screen, proceed
- Tier 3: navigate to PIN Setup Screen (cannot skip)
- Tier 4: warn user, log high-risk, proceed with OTP-only mode

### 3H. Router + State

**Modify** `lib/presentation/router/app_router.dart` — add `/auth/session-lock` route + redirect logic
**Modify** `lib/presentation/blocs/auth/auth_state.dart` — add `AuthStatus.sessionLocked`
**Modify** `lib/presentation/blocs/auth/auth_event.dart` — add `lockSession`, `unlockSession`
**Modify** `lib/presentation/blocs/auth/auth_bloc.dart` — add handlers
**Modify** `lib/app.dart` — add `WidgetsBindingObserver` for lifecycle detection
**Modify** `lib/core/security/audit_logger.dart` — add `sessionLock`, `sessionUnlockBiometric`, `sessionUnlockPin`, `pinSetup` to `AuthAction` enum
**Modify** `lib/core/di/register_module.dart` — register `LocalAuthentication`

### Security Assurance

- All tiers maintain two-factor: device possession + knowledge/biometric factor
- In-app PIN has same hash protection as OS PIN (HMAC-SHA256 + salt in hardware-backed storage)
- Brute force protected: 5 failed attempts -> OTP lockout (server rate-limited)
- Tier 4 devices flagged as high-risk in audit log; higher-value operations require step-up OTP
- POPIA compliant: PIN hash stored locally only, all events audited

---

## Phase 4: Push-Based Login Challenges *(can run parallel with Phase 3)*

**Goal**: Returning users on trusted devices approve a push notification instead of OTP.

### 4A. Challenge Entity

**Create** `lib/domain/entities/auth_challenge.dart`
- Fields: `challengeId`, `userId`, `nonce`, `status`, `createdAt`, `expiresAt`

**Create** `lib/data/models/auth_challenge_model.dart`

### 4B. Cloud Functions

**Modify** `functions/src/auth.ts`:
- `loginRequest(phoneNumber)` — find trusted device -> generate nonce -> create challenge doc -> send FCM push -> return `{challengeId, hasTrustedDevice}`
- `approveLogin(challengeId, signedNonce, deviceId)` — verify ECDSA signature -> create custom token -> return `{customToken}`
- Challenge expiry: **3 minutes** (guide's 2 min is too short)

### 4C. FCM Handler

**Create** `lib/core/services/fcm_challenge_handler.dart`
- Listen for `data.type == "auth_challenge"` messages
- Show local notification -> navigate to approval screen

### 4D. UI Screens

**Create** `lib/presentation/screens/auth/push_login_screen.dart`
- "Push notification sent" waiting screen with countdown
- Firestore realtime listener on challenge status
- "Use OTP instead" fallback button

**Create** `lib/presentation/screens/auth/challenge_approval_screen.dart`
- "Approve" -> sign nonce with Keystore -> call approveLogin
- "Deny" -> reject challenge
- Auto-expire countdown

### 4E. Login Flow Integration

**Modify** `lib/presentation/screens/auth/phone_input_screen.dart`
- On submit: first call `loginRequest` -> if `hasTrustedDevice`, show push login screen; else OTP flow

**Modify** auth bloc + repository + datasource for push login events/methods
**Modify** `lib/presentation/router/app_router.dart` — add push-login + challenge-approval routes

---

## Phase 5: Risk Events + Step-Up Auth + SIM Detection + New Device

**Goal**: Detect risk and force re-verification. Handle SIM changes and untrusted devices.

### 5A. Risk Event Entity

**Create** `lib/domain/entities/risk_event.dart`
- Types: `simChange`, `geoChange`, `largeTransaction`, `newDevice`, `suspiciousActivity`

### 5B. SIM Change Detection

**Create** `lib/core/security/sim_change_detector.dart`
- Uses MethodChannel to read SIM operator info (no permission needed for operator name)
- Add `getSimInfo()` to `KeystoreChannel.kt` and `KeystoreChannel.swift`
- Compares hash with stored value in secure storage
- On change -> create risk event via Cloud Function

### 5C. Step-Up Auth Service

**Create** `lib/core/security/step_up_auth_service.dart`
- Decision matrix: low risk -> proceed, medium -> biometric, high -> OTP re-verify
- Called before cashouts, large transfers, profile changes

### 5D. Step-Up OTP Screen

**Create** `lib/presentation/screens/auth/step_up_otp_screen.dart`
- "Verify your identity" — reuses existing OTP Cloud Functions
- On success -> returns result to calling screen

### 5E. New Device Notification

**Modify** `functions/src/auth.ts` `verifyOtp`
- After login from new device, send FCM to all existing trusted devices: "Your account was accessed from a new device"

### 5F. User Model Migration

**Modify** `lib/domain/entities/user.dart` — add `primaryDeviceId?`, `riskLevel?`, `lastLoginAt?`
**Modify** `lib/data/models/user_model.dart` — add corresponding nullable fields
**Modify** `lib/core/error/failures.dart` — add `stepUpRequired`, `deviceNotTrusted`, `simChanged`

### 5G. Cloud Function

**Modify** `functions/src/auth.ts` (or new `functions/src/riskEvents.ts`):
- `createRiskEvent` — creates doc, may trigger notification/suspension
- `resolveRiskEvent` — marks resolved after step-up auth

---

## Issues Addressed Beyond the Original Guide

| Issue | Resolution |
|-------|-----------|
| Guide assumes Firebase Phone Auth | Adapted to use existing MyMobileAPI OTP Cloud Functions |
| Guide allows client writes to devices/challenges | Changed to server-only (Cloud Functions with Admin SDK) |
| No iOS support | Added iOS Secure Enclave alongside Android Keystore |
| No local_auth mentioned | Added as explicit Phase 3 dependency |
| No key rotation | Annual rotation via sign-new-key-with-old-key pattern |
| No key attestation | Deferred — can layer Android Key Attestation later |
| No session timeout | SessionLockService with 30s tiered lock / 5min full re-auth |
| No non-biometric fallback | 4-tier system: biometric -> OS PIN -> in-app PIN -> OTP |
| Budget SA phones (Samsung J, Huawei Y) | Tier 2/3 handles devices without biometric hardware |
| No app integrity | Existing PlayIntegrityService placeholder to be connected |
| Schema conflicts | Nullable field additions — backward compatible |
| No offline handling | Biometric works offline; trust cached in secure storage |
| No device registration rate limit | Added `device_register` limit (5/day) |
| SIM detection vague | Use operator name (no permission needed) not ICCID |
| No account recovery | OTP serves as recovery; new device revokes old keys |
| Challenge expiry too short | Changed from 2 min to 3 min |

---

## Dependency Graph

```
Phase 1: Foundation (Keystore + Device Repo + Firestore)
    |
    v
Phase 2: First Login Device Binding
    |
    +---------------+
    v               v
Phase 3:        Phase 4:
Tiered          Push Login
Session Lock    Challenges
    |               |
    +-------+-------+
            v
Phase 5: Risk Events + Step-Up + SIM + New Device
```

Phases 3 and 4 are **independent** and can be implemented in parallel.

---

## Verification Checklist

- [ ] Platform channel generates ECDSA keypair on Android and iOS
- [ ] Device registered in Firestore after first OTP login
- [ ] Firestore rules deny client writes to devices/authChallenges/riskEvents
- [ ] Tier 1: Biometric prompt appears after 30+ seconds in background
- [ ] Tier 2: OS PIN/pattern prompt works on devices without biometrics
- [ ] Tier 3: In-app PIN setup forced during onboarding when no screen lock
- [ ] Tier 3: In-app PIN unlock works correctly with brute-force lockout (5 attempts)
- [ ] Tier 4: OTP-only mode activates on rooted/compromised devices
- [ ] Session fully locks after 5 minutes in background (all tiers)
- [ ] Push login sends FCM challenge to trusted device
- [ ] Signed nonce verified server-side with stored public key
- [ ] OTP fallback works when no trusted device exists
- [ ] SIM change detected and risk event created
- [ ] Step-up OTP required before large cashouts
- [ ] New device login notifies existing devices
- [ ] All auth events logged via AuditLogger
- [ ] build_runner generates updated injection.config.dart
- [ ] Cloud Functions deploy successfully
- [ ] Existing OTP login flow still works unchanged
