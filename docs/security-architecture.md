# iMali Security Architecture & Authentication Flow Documentation

**Version:** 1.0
**Last Updated:** February 2026
**Platform:** Flutter (Android/iOS) + Firebase Cloud Functions

---

## Table of Contents

1. [Overview & Design Philosophy](#1-overview--design-philosophy)
2. [Technology Stack](#2-technology-stack)
3. [Cryptographic Foundations](#3-cryptographic-foundations)
4. [Authentication System](#4-authentication-system)
5. [Login Scenarios — Complete Flows](#5-login-scenarios--complete-flows)
6. [Device Trust & Binding](#6-device-trust--binding)
7. [Session Management](#7-session-management)
8. [Firestore Security Rules](#8-firestore-security-rules)
9. [Rate Limiting](#9-rate-limiting)
10. [Fraud Detection](#10-fraud-detection)
11. [Device Integrity Verification](#11-device-integrity-verification)
12. [Input Validation & Sanitisation](#12-input-validation--sanitisation)
13. [Audit Logging](#13-audit-logging)
14. [SIM Change Detection](#14-sim-change-detection)
15. [Complete Security Layer Diagram](#15-complete-security-layer-diagram)

---

## 1. Overview & Design Philosophy

iMali is a South African fintech application that allows users to earn tokens, transfer value, and cash out to real money. Because real monetary value is at stake, the security architecture is designed with a **defence-in-depth** strategy: multiple independent layers of protection so that no single point of failure compromises the system.

### Core Security Principles

```
┌─────────────────────────────────────────────────────┐
│                 DEFENCE IN DEPTH                     │
│                                                      │
│  ┌─────────────────────────────────────────────┐    │
│  │  Layer 1: Device Integrity                   │    │
│  │  (Play Integrity, App Check, root detection) │    │
│  │  ┌─────────────────────────────────────┐     │    │
│  │  │  Layer 2: Authentication            │     │    │
│  │  │  (OTP, Biometric, Push Login)       │     │    │
│  │  │  ┌─────────────────────────────┐    │     │    │
│  │  │  │  Layer 3: Authorisation     │    │     │    │
│  │  │  │  (Firestore rules, RBAC)    │    │     │    │
│  │  │  │  ┌─────────────────────┐    │    │     │    │
│  │  │  │  │  Layer 4: Fraud     │    │    │     │    │
│  │  │  │  │  Detection & Limits │    │    │     │    │
│  │  │  │  │  ┌─────────────┐    │    │    │     │    │
│  │  │  │  │  │ Layer 5:    │    │    │    │     │    │
│  │  │  │  │  │ Audit Trail │    │    │    │     │    │
│  │  │  │  │  └─────────────┘    │    │    │     │    │
│  │  │  │  └─────────────────────┘    │    │     │    │
│  │  │  └─────────────────────────────┘    │     │    │
│  │  └─────────────────────────────────────┘     │    │
│  └─────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────┘
```

**Key design decisions:**
- **Server-authoritative:** All financial operations (earning, transferring, cashing out) happen exclusively through Cloud Functions. The client cannot modify balances, transactions, or wallet data directly.
- **Hardware-backed cryptography:** Device identity is proven through ECDSA signatures using keys stored in the phone's hardware security module (Android Keystore / iOS Secure Enclave), which cannot be extracted even if the phone is rooted.
- **Single-device trust policy:** Only one device at a time is trusted per user. Registering a new device automatically revokes the old one.
- **Graceful degradation:** Security features (device binding, biometrics, Play Integrity) degrade gracefully — failure never blocks the user entirely but may require stepping up to a stronger auth method.

---

## 2. Technology Stack

### What Each Technology Does

| Technology | Role | Where Used |
|-----------|------|------------|
| **Firebase Auth** | Identity provider — issues authentication tokens that prove "this request comes from user X" | All authenticated operations |
| **Firebase Cloud Functions** | Server-side code that runs in Google's cloud — the only code trusted to modify financial data | OTP, device registration, transfers, cashouts |
| **Firestore** | Cloud database with built-in security rules — stores user profiles, wallets, transactions | All persistent data |
| **Firebase Cloud Messaging (FCM)** | Push notification system — sends messages to specific devices | Push-based login, security alerts |
| **Firebase App Check** | Verifies the request comes from a genuine iMali app (not a script or modified app) | All Cloud Function calls |
| **Google Play Integrity API** | Verifies the Android device hasn't been tampered with (not rooted, genuine OS, licensed app) | High-value operations (cashout, transfers) |
| **Android Keystore / iOS Secure Enclave** | Hardware security module built into the phone's processor — stores cryptographic keys that can never be extracted | Device binding, challenge signing |
| **MyMobileAPI** | South African SMS gateway service — delivers OTP codes via SMS | Phone verification |
| **FlutterSecureStorage** | Encrypted key-value storage on the device — uses Keystore/Keychain under the hood | Caching device IDs, PINs, timestamps |
| **local_auth** | Flutter plugin for biometric/device credential authentication — fingerprint, face, PIN, pattern | Biometric login, session unlock |

---

## 3. Cryptographic Foundations

### 3.1 ECDSA P-256 (Elliptic Curve Digital Signature Algorithm)

iMali uses ECDSA P-256 for **proving device identity**. Here's how it works in simple terms:

```
KEYPAIR GENERATION (happens once per device, stored in hardware)
═══════════════════════════════════════════════════════════════

  ┌──────────────────────┐         ┌──────────────────────┐
  │   PRIVATE KEY        │         │   PUBLIC KEY          │
  │   (stays on device,  │────────>│   (sent to server,    │
  │    never leaves the  │ derived │    stored in Firestore │
  │    hardware module)  │  from   │    devices collection) │
  └──────────────────────┘         └──────────────────────┘


SIGNING (proves device identity)
════════════════════════════════

  Server says: "Sign this random number: abc123"

  ┌──────────┐     ┌──────────────┐     ┌──────────────┐
  │  Nonce   │────>│ Private Key  │────>│  Signature   │
  │ "abc123" │     │ (in hardware)│     │ "xYz789..."  │
  └──────────┘     └──────────────┘     └──────────────┘
       │                                       │
       │           Server verifies:            │
       v                                       v
  ┌──────────┐     ┌──────────────┐     ┌──────────────┐
  │  Nonce   │────>│ Public Key   │────>│  Match? YES  │
  │ "abc123" │     │ (on server)  │     │  = Authentic │
  └──────────┘     └──────────────┘     └──────────────┘
```

**Why this is secure:**
- The private key **physically cannot leave** the hardware security module
- Even if the phone is rooted or the app is decompiled, the key cannot be extracted
- Each signing requires the user to authenticate with biometrics/PIN first (hardware-enforced)
- The server generates a fresh random nonce each time, preventing replay attacks

### 3.2 OTP Hashing (SHA-256 with Salt)

OTP codes are never stored in plain text on the server:

```
OTP STORAGE
═══════════

  ┌──────────┐     ┌────────────────┐     ┌──────────────────┐
  │ OTP Code │     │ Random Salt    │     │ SHA-256 Hash     │
  │  "4829"  │──+──│ "a3f8b2c1..." │────>│ "7d2f1a8b..."    │
  └──────────┘  │  └────────────────┘     └──────────────────┘
                │                               │
                │  Stored in Firestore:         │
                │  { hashedCode: "7d2f1a8b...", │
                │    salt: "a3f8b2c1...",        │
                │    attempts: 0,                │
                │    expiresAt: <5 min> }        │
                └───────────────────────────────┘


OTP VERIFICATION
════════════════

  User enters "4829" → hash("4829" + stored_salt) → compare with stored hash
  Matches? → Issue Firebase custom token
  Doesn't match? → Increment attempts (max 5, then locked)
```

### 3.3 PIN Hashing (HMAC-SHA256)

In-app PINs (for devices without biometrics) use HMAC-SHA256:

```
PIN STORAGE
═══════════

  ┌──────┐     ┌────────────────┐     ┌───────────────────┐
  │ PIN  │     │ Random Salt    │     │ HMAC-SHA256       │
  │"1234"│──+──│ (32 bytes)     │────>│ Hash + Salt       │
  └──────┘     └────────────────┘     │ stored in         │
                                      │ FlutterSecureStore│
                                      └───────────────────┘

  Verification uses constant-time comparison
  (prevents timing attacks that could guess the PIN digit-by-digit)
```

---

## 4. Authentication System

### 4.1 Authentication Methods Overview

iMali supports three authentication methods, with automatic selection based on the user's situation:

```
┌─────────────────────────────────────────────────────────────┐
│                   AUTHENTICATION METHODS                      │
├─────────────────────┬──────────────────┬────────────────────┤
│                     │                  │                    │
│   1. OTP LOGIN      │  2. BIOMETRIC    │  3. PUSH LOGIN    │
│   (Primary)         │  (Returning)     │  (Multi-device)   │
│                     │                  │                    │
│   Phone + SMS code  │  Fingerprint/    │  Approve on       │
│   Works for ALL     │  Face/PIN on     │  existing trusted │
│   users, any device │  same device     │  device           │
│                     │                  │                    │
│   When: New users,  │  When: Same      │  When: New device │
│   new devices,      │  device, signed  │  but user has a   │
│   fallback          │  out <7 days ago │  trusted device    │
│                     │                  │  elsewhere         │
└─────────────────────┴──────────────────┴────────────────────┘
```

### 4.2 Device Capability Tiers

Not all devices support the same security features. iMali detects what the device supports and adapts:

```
TIER DETECTION FLOW
════════════════════

  Start
    │
    v
  ┌─────────────────────────────┐
  │ Does device have biometrics │──YES──> TIER 1: BIOMETRIC
  │ (fingerprint/face)?         │         (best security)
  └──────────┬──────────────────┘
             │ NO
             v
  ┌─────────────────────────────┐
  │ Does device have OS-level   │──YES──> TIER 2: DEVICE CREDENTIAL
  │ PIN/pattern/password?       │         (good security)
  └──────────┬──────────────────┘
             │ NO
             v
  ┌─────────────────────────────┐
  │ Can device write to secure  │──YES──> TIER 3: IN-APP PIN
  │ storage? (not rooted)       │         (acceptable security)
  └──────────┬──────────────────┘
             │ NO
             v
           TIER 4: OTP ONLY
           (basic security, likely rooted device)
```

**What each tier means for the user:**

| Tier | Session Unlock Method | Biometric Login | Session Lock |
|------|----------------------|-----------------|--------------|
| 1 (Biometric) | Fingerprint/Face | Available | After 30s background |
| 2 (Device Credential) | Phone PIN/pattern | Available | After 30s background |
| 3 (In-App PIN) | 4-6 digit PIN in app | Not available | After 30s background |
| 4 (OTP Only) | Must re-enter OTP | Not available | After 30s background |

### 4.3 Firebase Custom Token Authentication

iMali does **not** use Firebase Phone Auth (which requires Google's own phone verification). Instead, it implements a custom OTP system:

```
WHY CUSTOM OTP INSTEAD OF FIREBASE PHONE AUTH?
═══════════════════════════════════════════════

  Firebase Phone Auth:
  - Google sends the SMS (limited control over delivery)
  - Limited to Firebase's pricing
  - Can't use local SMS providers

  iMali Custom OTP:
  - Uses MyMobileAPI (South African SMS provider)
  - Full control over message content and delivery
  - Server generates OTP → sends via MyMobileAPI → verifies on return
  - Issues Firebase "Custom Token" after successful verification
  - User is then authenticated in Firebase as normal


CUSTOM TOKEN FLOW
═════════════════

  ┌──────────┐    ┌────────────────┐    ┌──────────────────┐
  │  Client  │───>│ Cloud Function │───>│ Firebase Admin    │
  │ verifies │    │ verifyOtp()    │    │ createCustomToken │
  │   OTP    │    │ checks code    │    │ (userId)          │
  └──────────┘    └────────────────┘    └────────┬─────────┘
                                                  │
                                                  v
  ┌──────────┐    ┌────────────────┐    ┌──────────────────┐
  │  Client  │<───│  customToken   │<───│ Returns token     │
  │ signs in │    │  returned to   │    │ to cloud function │
  │ Firebase │    │  client        │    │                    │
  └──────────┘    └────────────────┘    └──────────────────┘
       │
       v
  signInWithCustomToken(token)
  → Firebase issues ID token + refresh token
  → Client is now authenticated for all Firestore reads
```

---

## 5. Login Scenarios — Complete Flows

### Scenario 1: Brand New User (First Time Ever)

This user has never used iMali before. They have no account, no device binding, nothing.

```
SCENARIO 1: BRAND NEW USER
════════════════════════════

  ┌──────────┐     ┌──────────────┐     ┌─────────────────┐
  │  App     │────>│   Splash     │────>│   Welcome       │
  │  Launch  │     │   Screen     │     │   Screen        │
  └──────────┘     └──────────────┘     └────────┬────────┘
                                                  │
                          No local device binding │
                          No biometric available  │
                          Shows "Get Started"     │
                                                  │
                                                  v
  ┌────────────────────────────────────────────────────────┐
  │  User taps "Get Started"                                │
  │  → Age Consent Screen (must confirm 18+)               │
  │  → Terms of Service Screen                              │
  │  → Privacy Policy Screen                                │
  │  → Phone Input Screen                                   │
  └────────────────────────────┬───────────────────────────┘
                               │
                               v
  ┌────────────────────────────────────────────────────────┐
  │  PHONE INPUT SCREEN                                     │
  │                                                         │
  │  1. User selects country code (+27 default)            │
  │  2. User enters phone number                           │
  │  3. App calls loginRequest(phoneNumber)                │
  │                                                         │
  │  Server response:                                       │
  │  { challengeId: null, hasTrustedDevice: false }        │
  │  (New user = no user record = no trusted device)       │
  │                                                         │
  │  4. App falls back to OTP path                         │
  │  5. App calls sendOtp(phoneNumber)                     │
  └────────────────────────────┬───────────────────────────┘
                               │
                               v
  ┌────────────────────────────────────────────────────────┐
  │  OTP SENT (Server Side)                                 │
  │                                                         │
  │  1. Validate phone format (SA: ^(\+27|0)[6-8]\d{8}$)  │
  │  2. Normalise to E.164: "0812345678" → "+27812345678"  │
  │  3. Check rate limit (max 5 OTPs per hour)             │
  │  4. Check resend cooldown (60 seconds minimum)         │
  │  5. Generate 4-digit code (1000-9999)                  │
  │  6. Generate random 16-byte salt                       │
  │  7. Hash: SHA-256(code + salt)                         │
  │  8. Store in verification_codes/{phone}:               │
  │     { hashedCode, salt, attempts: 0,                   │
  │       createdAt, expiresAt: now + 5min }               │
  │  9. Send SMS via MyMobileAPI                           │
  └────────────────────────────┬───────────────────────────┘
                               │
                               v
  ┌────────────────────────────────────────────────────────┐
  │  OTP VERIFICATION SCREEN                                │
  │                                                         │
  │  1. User enters 4-digit code                           │
  │  2. App calls verifyOtp(phoneNumber, code)             │
  │                                                         │
  │  Server:                                                │
  │  1. Check rate limit (max 10 verifications per 5 min)  │
  │  2. Retrieve verification_codes/{phone}                │
  │  3. Check status ≠ verified/locked                     │
  │  4. Check expiry (5 min)                               │
  │  5. Check attempts < 5                                 │
  │  6. Hash(input + salt) == storedHash?                  │
  │                                                         │
  │  If code matches:                                       │
  │  7. Create Firebase Auth user: "phone_27812345678"     │
  │  8. createCustomToken(userId)                          │
  │  9. Delete verification doc                            │
  │  10. Return { customToken, userId, isNewUser: true }   │
  └────────────────────────────┬───────────────────────────┘
                               │
                               v
  ┌────────────────────────────────────────────────────────┐
  │  CLIENT AFTER OTP SUCCESS                               │
  │                                                         │
  │  1. signInWithCustomToken(token) → Firebase session    │
  │  2. AuthBloc emits: onboardingRequired                 │
  │     (new user → needsOnboarding = true)                │
  │  3. recordSuccessfulAuth() → saves timestamp to        │
  │     secure storage (starts 7-day inactivity timer)     │
  │  4. AuthEvent.bindDevice() dispatched (non-blocking):  │
  │     a. Generate ECDSA P-256 keypair in hardware        │
  │     b. Collect device metadata (model, OS, etc.)       │
  │     c. Get FCM token                                   │
  │     d. Call registerDevice() cloud function             │
  │     e. Server stores: publicKey, FCM token, metadata   │
  │     f. Cache deviceId + userId in secure storage       │
  │  5. Router redirects to onboarding flow:               │
  │     Name → Birthday → Gender → Extra Info →            │
  │     Profile Picture → Permissions → Success            │
  └────────────────────────────────────────────────────────┘
```

### Scenario 2: Returning User — Signed Out, Same Device (Biometric Login)

This user previously logged in on this device, signed out, and is coming back within 7 days.

```
SCENARIO 2: RETURNING USER — BIOMETRIC LOGIN
═════════════════════════════════════════════

  ┌──────────┐     ┌──────────────┐     ┌─────────────────────┐
  │  App     │────>│   Splash     │────>│   Welcome Screen    │
  │  Launch  │     │   Screen     │     │   (initState runs)  │
  └──────────┘     └──────────────┘     └─────────┬───────────┘
                                                   │
                                                   v
  ┌────────────────────────────────────────────────────────────┐
  │  BIOMETRIC CHECK (in initState)                             │
  │                                                             │
  │  BiometricLoginService.canUseBiometricLogin() checks:      │
  │                                                             │
  │  ┌─ 1. getStoredDeviceId() → reads secure storage          │
  │  │     Result: "abc123" (exists from previous login)       │
  │  │                                                          │
  │  ├─ 2. getStoredUserId() → reads secure storage            │
  │  │     Result: "phone_27812345678" (exists)                │
  │  │                                                          │
  │  ├─ 3. _isInactivityThresholdExceeded()                    │
  │  │     Reads _lastAuthTimeKey from secure storage          │
  │  │     Last auth: 2 days ago → 2 < 7 → NOT exceeded       │
  │  │                                                          │
  │  └─ 4. detectCapabilityTier()                              │
  │        Device has fingerprint → Tier 1 (biometric)         │
  │                                                             │
  │  Result: canUseBiometric = TRUE                            │
  │  Also loads: getStoredDisplayName() → "Sipho"              │
  └────────────────────────────────┬───────────────────────────┘
                                   │
                                   v
  ┌────────────────────────────────────────────────────────────┐
  │  WELCOME SCREEN — RETURNING USER MODE                       │
  │                                                             │
  │  ┌─────────────────────────────────────────┐               │
  │  │                                         │               │
  │  │   "Welcome back, Sipho"                 │               │
  │  │                                         │               │
  │  │   [ Fingerprint Icon ]                  │               │
  │  │                                         │               │
  │  │   [ Sign In with Biometrics ]           │               │
  │  │                                         │               │
  │  │   "Use OTP instead"                     │               │
  │  │                                         │               │
  │  └─────────────────────────────────────────┘               │
  └────────────────────────────────┬───────────────────────────┘
                                   │
                          User taps "Sign In"
                                   │
                                   v
  ┌────────────────────────────────────────────────────────────┐
  │  BIOMETRIC LOGIN FLOW                                       │
  │                                                             │
  │  Step 1: LOCAL AUTHENTICATION                              │
  │  ─────────────────────────                                  │
  │  OS shows fingerprint/face/PIN prompt                      │
  │  "Sign in to iMali"                                        │
  │  biometricOnly: false (allows device PIN fallback)         │
  │                                                             │
  │  User authenticates with fingerprint → success             │
  │                                                             │
  │  Step 2: REQUEST CHALLENGE FROM SERVER                     │
  │  ────────────────────────────────────                       │
  │  Client calls: requestBiometricChallenge(deviceId)         │
  │                                                             │
  │  Server:                                                    │
  │  1. Check App Check token                                  │
  │  2. Rate limit: max 5 per device per 5 minutes             │
  │  3. Verify device exists in Firestore                      │
  │  4. Verify device.trusted = true AND .revoked = false      │
  │  5. Verify device.userId exists                            │
  │  6. Generate 32-byte random nonce (base64)                 │
  │  7. Store in biometricChallenges/{id}:                     │
  │     { deviceId, userId, nonce, status: "pending",          │
  │       expiresAt: now + 60 seconds }                        │
  │  8. Return { challengeId, nonce }                          │
  │                                                             │
  │  Step 3: SIGN NONCE WITH HARDWARE KEY                      │
  │  ───────────────────────────────────                        │
  │  Client signs nonce using KeystoreService.sign()           │
  │  → Platform channel → Android Keystore / iOS Secure Enclave│
  │  → ECDSA P-256 signature (base64-encoded)                  │
  │                                                             │
  │  Step 4: VERIFY SIGNATURE ON SERVER                        │
  │  ─────────────────────────────────                          │
  │  Client calls: verifyBiometricChallenge(                   │
  │    challengeId, signedNonce, deviceId                      │
  │  )                                                          │
  │                                                             │
  │  Server:                                                    │
  │  1. Check App Check token                                  │
  │  2. Rate limit: max 5 per device per 5 minutes             │
  │  3. Get challenge doc from biometricChallenges              │
  │  4. Verify challenge.deviceId matches                      │
  │  5. Verify status == "pending"                             │
  │  6. Verify not expired (60 second window)                  │
  │  7. Re-verify device is still trusted + not revoked        │
  │  8. Verify device.userId == challenge.userId               │
  │  9. ECDSA verify: signature against stored publicKeyPem    │
  │     crypto.createVerify("SHA256")                          │
  │     verifier.update(challenge.nonce)                       │
  │     verifier.verify(publicKeyPem, signatureBuffer)         │
  │  10. If valid: createCustomToken(userId)                   │
  │  11. Mark challenge "completed"                            │
  │  12. Update device.lastUsedAt                              │
  │  13. Return { customToken, userId }                        │
  └────────────────────────────────┬───────────────────────────┘
                                   │
                                   v
  ┌────────────────────────────────────────────────────────────┐
  │  CLIENT COMPLETES LOGIN                                     │
  │                                                             │
  │  1. signInWithCustomToken(customToken)                     │
  │  2. AuthBloc emits authenticated                           │
  │  3. recordSuccessfulAuth() → resets 7-day timer            │
  │  4. bindDevice() → re-registers device (updates keys/FCM) │
  │  5. Router redirects to Home Screen                        │
  └────────────────────────────────────────────────────────────┘
```

### Scenario 3: Returning User — Signed Out, Same Device, Inactivity Exceeded

This user signed out more than 7 days ago. Biometric login is disabled for safety.

```
SCENARIO 3: INACTIVITY THRESHOLD EXCEEDED (>7 DAYS)
════════════════════════════════════════════════════

  ┌──────────┐     ┌──────────────┐     ┌─────────────────────┐
  │  App     │────>│   Splash     │────>│   Welcome Screen    │
  │  Launch  │     │   Screen     │     │   (initState runs)  │
  └──────────┘     └──────────────┘     └─────────┬───────────┘
                                                   │
                                                   v
  ┌────────────────────────────────────────────────────────────┐
  │  BIOMETRIC CHECK                                            │
  │                                                             │
  │  canUseBiometricLogin():                                   │
  │  ├─ getStoredDeviceId()  → "abc123" ✓ exists              │
  │  ├─ getStoredUserId()    → "phone_27..." ✓ exists         │
  │  ├─ _isInactivityThresholdExceeded()                       │
  │  │   Last auth: 10 days ago → 10 > 7 → EXCEEDED           │
  │  │                                                          │
  │  └─ Result: canUseBiometric = FALSE                        │
  │                                                             │
  │  Welcome screen shows STANDARD welcome (not returning user)│
  │  User must use "Log In" → Phone Input → OTP flow          │
  │                                                             │
  │  After successful OTP:                                      │
  │  - recordSuccessfulAuth() resets the 7-day timer           │
  │  - Next time, biometric will be available again            │
  └────────────────────────────────────────────────────────────┘

  WHY THIS EXISTS:
  ═══════════════
  If a user gives their old phone to someone else without
  signing out, the new phone owner could otherwise use
  biometric login indefinitely. The 7-day timeout forces
  an OTP step-up, which requires access to the original
  phone number (SIM card), not just the device.
```

### Scenario 4: Returning User — Never Signed Out (App Reopened)

This user closes and reopens the app. They never signed out. Firebase session is still valid.

```
SCENARIO 4: NEVER SIGNED OUT — FIREBASE SESSION VALID
══════════════════════════════════════════════════════

  ┌──────────┐     ┌──────────────────────────────────────┐
  │  App     │────>│  Splash Screen                        │
  │  Launch  │     │                                       │
  └──────────┘     │  1. AuthBloc.checkAuthStatus()        │
                   │  2. _authRepository.getCurrentUser()   │
                   │  3. Firebase: currentUser exists       │
                   │  4. Fetch profile from Firestore      │
                   │  5. user.hasCompletedOnboarding = true │
                   │                                       │
                   │  AuthBloc emits:                       │
                   │  status: authenticated                 │
                   │  user: { ... }                         │
                   │                                       │
                   │  Router redirect:                      │
                   │  status == authenticated → /home       │
                   └───────────────────────┬───────────────┘
                                           │
                                           v
                              ┌──────────────────┐
                              │   Home Screen    │
                              │   (immediate)    │
                              └──────────────────┘

  Total time: ~2 seconds (splash animation + Firebase check)
  No OTP, no biometric prompt, no user interaction needed.
```

### Scenario 5: New Phone — Returning User With Push Login

This user got a new phone and is logging in. Their old phone has a trusted device binding.

```
SCENARIO 5: NEW PHONE — PUSH LOGIN FLOW
════════════════════════════════════════

  NEW PHONE                                    OLD PHONE
  ═════════                                    ═════════

  ┌──────────────────┐
  │  Welcome Screen  │
  │  No local binding│
  │  Shows standard  │
  │  "Log In" button │
  └────────┬─────────┘
           │
           v
  ┌──────────────────┐
  │  Phone Input     │
  │  User enters     │
  │  +27 812 345 678 │
  │  Taps "Continue" │
  └────────┬─────────┘
           │
           v
  ┌────────────────────────────────────┐
  │  loginRequest(phoneNumber) called   │
  │                                     │
  │  Server:                            │
  │  1. Find user "phone_27812345678"  │
  │  2. Find trusted devices           │───────────────┐
  │  3. Device found with valid FCM    │               │
  │  4. Generate nonce (32 bytes hex)  │               │
  │  5. Store in authChallenges/{id}   │               │
  │  6. Send FCM push to old phone     │               │
  │  7. Return { challengeId: "xyz",   │               v
  │     hasTrustedDevice: true }       │    ┌─────────────────────┐
  └────────┬───────────────────────────┘    │  FCM DATA MESSAGE   │
           │                                │  arrives on old     │
           v                                │  phone:             │
  ┌──────────────────┐                      │                     │
  │  Push Login      │                      │  type: auth_challenge
  │  Screen          │                      │  challengeId: "xyz" │
  │                  │                      │  nonce: "a3f8..."   │
  │  "Waiting for    │                      │                     │
  │   approval on    │                      └─────────┬───────────┘
  │   your other     │                                │
  │   device..."     │                                v
  │                  │                      ┌─────────────────────┐
  │  ┌────────────┐  │                      │  Challenge Approval │
  │  │ 2:47       │  │                      │  Screen appears     │
  │  │ remaining  │  │                      │                     │
  │  └────────────┘  │                      │  "Login request     │
  │                  │                      │   from a new device"│
  │  Polls every 3s: │                      │                     │
  │  checkChallenge  │                      │  [Approve] [Deny]   │
  │  Status()        │                      └─────────┬───────────┘
  │                  │                                │
  │                  │                       User taps "Approve"
  │                  │                                │
  │                  │                                v
  │                  │                      ┌─────────────────────┐
  │                  │                      │  Old phone:         │
  │                  │                      │  1. Sign nonce with │
  │                  │                      │     hardware key    │
  │                  │                      │  2. Call approveLogin│
  │                  │                      │     (challengeId,   │
  │                  │                      │      signedNonce,   │
  │                  │                      │      deviceId)      │
  │                  │                      │                     │
  │                  │                      │  Server:            │
  │                  │                      │  1. Verify ECDSA sig│
  │                  │                      │  2. Generate custom │
  │                  │                      │     token           │
  │                  │                      │  3. Store in        │
  │                  │                      │     challenge doc   │
  │                  │                      │  4. Status→approved │
  │                  │                      └─────────────────────┘
  │                  │
  │  Poll returns:   │
  │  status: approved│
  │  customToken: ...│
  │                  │
  └────────┬─────────┘
           │
           v
  ┌──────────────────────────────────────────┐
  │  NEW PHONE COMPLETES LOGIN                │
  │                                           │
  │  1. signInWithCustomToken(customToken)    │
  │  2. AuthBloc → authenticated              │
  │  3. recordSuccessfulAuth()                │
  │  4. bindDevice():                         │
  │     a. Generate new ECDSA keypair         │
  │     b. Call registerDevice()              │
  │     c. Server: NEW device registered      │──────┐
  │     d. Server: OLD device REVOKED         │      │
  │        (all other devices for this user   │      │
  │         are marked revoked: true)         │      │
  │  5. Notify old device of new login        │      │
  │  6. Router → Home Screen                  │      │
  └──────────────────────────────────────────┘      │
                                                     │
                                                     v
                                          ┌─────────────────────┐
                                          │  OLD PHONE IMPACT   │
                                          │                     │
                                          │  Device record now: │
                                          │  trusted: false     │
                                          │  revoked: true      │
                                          │                     │
                                          │  If someone opens   │
                                          │  iMali on old phone:│
                                          │  - Biometric login  │
                                          │    attempts will    │
                                          │    FAIL at server   │
                                          │    ("device not     │
                                          │     trusted")       │
                                          │  - Must use OTP     │
                                          │    (requires SIM)   │
                                          └─────────────────────┘
```

### Scenario 6: New Phone — Push Login Fails (Stale FCM Token)

The user got a new phone, but their old phone was factory-reset or lost. The FCM token is stale.

```
SCENARIO 6: STALE FCM TOKEN — AUTOMATIC FALLBACK TO OTP
════════════════════════════════════════════════════════

  ┌──────────────────┐
  │  Phone Input     │
  │  User enters     │
  │  their number    │
  └────────┬─────────┘
           │
           v
  ┌────────────────────────────────────────────────────────┐
  │  loginRequest(phoneNumber) — SERVER                     │
  │                                                         │
  │  1. Find user → exists                                 │
  │  2. Find trusted devices → 1 device found              │
  │  3. Create challenge, send FCM push                    │
  │  4. FCM result:                                        │
  │     response.success = false                           │
  │     error.code = "messaging/registration-token-not-    │
  │                    registered"                         │
  │                                                         │
  │  ALL tokens stale → cleanup:                           │
  │  5. Revoke all stale devices:                          │
  │     { trusted: false, revoked: true,                   │
  │       revokeReason: "stale_fcm_token" }                │
  │  6. Delete the challenge document                      │
  │  7. Return { challengeId: null,                        │
  │              hasTrustedDevice: false }                  │
  └────────────────────────────┬───────────────────────────┘
                               │
                               v
  ┌────────────────────────────────────────────────────────┐
  │  CLIENT — AUTOMATIC OTP FALLBACK                        │
  │                                                         │
  │  hasTrustedDevice = false                              │
  │  → App immediately sends OTP                           │
  │  → User receives SMS, enters code                      │
  │  → Normal OTP verification flow                        │
  │  → Device binding on new phone                         │
  │                                                         │
  │  Total friction: 3 taps + enter OTP                    │
  │  (same as a completely new user)                       │
  └────────────────────────────────────────────────────────┘
```

### Scenario 7: Biometric Login Fails — Fallback to OTP

User tries biometric login but signature verification fails (or they cancel the prompt).

```
SCENARIO 7: BIOMETRIC FAILS — GRACEFUL FALLBACK
════════════════════════════════════════════════

  ┌─────────────────────────────────────────┐
  │  Welcome Screen (returning user mode)    │
  │                                          │
  │  User taps "Sign In with Biometrics"    │
  └──────────────────┬──────────────────────┘
                     │
            ┌────────┴────────┐
            │                 │
     Biometric OK        Biometric Fails
     (or PIN OK)         (cancelled/error)
            │                 │
            v                 v
  ┌──────────────┐   ┌──────────────────────┐
  │  Challenge-  │   │  Error shown:        │
  │  response    │   │  "Authentication     │
  │  continues   │   │   cancelled"         │
  │  (see        │   │                      │
  │  Scenario 2) │   │  User can tap:       │
  │              │   │  "Use OTP instead"   │
  └──────────────┘   └──────────┬───────────┘
                                │
                                v
                     ┌──────────────────────┐
                     │  Phone Input Screen  │
                     │  → OTP flow          │
                     │  (Scenario 1 path)   │
                     └──────────────────────┘

  If challenge-response itself fails (server-side):
  ┌────────────────────────────────────────────────┐
  │  verifyBiometricChallenge returns error:        │
  │  - "Device not trusted" (revoked by new phone) │
  │  - "Challenge expired" (took > 60 seconds)     │
  │  - "Invalid signature" (key mismatch)          │
  │                                                 │
  │  App shows error + "Use OTP instead" link      │
  │  User falls back to OTP                        │
  └────────────────────────────────────────────────┘
```

### Scenario 8: App Reinstalled on Same Device

User uninstalls and reinstalls iMali. Secure storage is wiped, but the hardware keypair may persist.

```
SCENARIO 8: APP REINSTALLED
════════════════════════════

  ┌────────────────────────────────────────────────────────┐
  │  What's lost on reinstall:                              │
  │  ✗ FlutterSecureStorage (deviceId, userId, timestamps) │
  │  ✗ Cached display name                                 │
  │  ✗ Last auth timestamp                                 │
  │  ✗ Firebase auth session                               │
  │                                                         │
  │  What might persist:                                    │
  │  ✓ Android Keystore keys (survive reinstall)           │
  │  ✗ iOS Keychain keys (depends on entitlements)         │
  │  ✓ Server-side device record (Firestore)               │
  └────────────────────────────────────────────────────────┘

  Flow:
  1. App launches → Splash → no Firebase user
  2. Welcome Screen → canUseBiometricLogin() = false
     (no local deviceId/userId in secure storage)
  3. User must use OTP to log in
  4. After OTP: new device binding created
     (old device record revoked if different ID)
  5. Next login: biometric available again
```

### Scenario 9: Multi-Device Push Login (Existing Trusted Device Approves)

```
SCENARIO 9: PUSH LOGIN — APPROVAL ON EXISTING DEVICE
═════════════════════════════════════════════════════

  The difference from Scenario 5: the user is already
  signed in on the old phone when the push arrives.

  OLD PHONE (signed in, app open or backgrounded)
  ═══════════════════════════════════════════════

  ┌────────────────────────────────────────────┐
  │  FCM data message received                  │
  │  type: "auth_challenge"                     │
  │                                             │
  │  FcmChallengeHandler processes:             │
  │  1. Parse challengeId and nonce from data   │
  │  2. Emit to challenge stream                │
  │  3. App navigates to Challenge Approval     │
  │     Screen (via stream listener)            │
  └──────────────────┬─────────────────────────┘
                     │
                     v
  ┌────────────────────────────────────────────┐
  │  CHALLENGE APPROVAL SCREEN                  │
  │                                             │
  │  Shows: "Someone is trying to log in to    │
  │          your iMali account from a new      │
  │          device."                           │
  │                                             │
  │  [ Approve Login ]    [ Deny ]             │
  │                                             │
  │  If Approve:                                │
  │  1. Get deviceId from secure storage       │
  │  2. Get userId from secure storage         │
  │  3. Sign nonce with hardware key:          │
  │     KeystoreService.sign(alias, nonce)     │
  │  4. Call approveLogin(challengeId,         │
  │     signedNonce, deviceId)                 │
  │  5. Server verifies ECDSA signature        │
  │  6. Server issues customToken              │
  │  7. Challenge status → "approved"          │
  │                                             │
  │  If Deny:                                   │
  │  1. Call denyLogin(challengeId)            │
  │  2. Challenge status → "denied"            │
  │  3. New phone sees "Login denied" message  │
  └────────────────────────────────────────────┘
```

---

## 6. Device Trust & Binding

### 6.1 Device Binding Lifecycle

```
DEVICE BINDING LIFECYCLE
════════════════════════

  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
  │ UNBOUND  │───>│ BINDING  │───>│ TRUSTED  │───>│ REVOKED  │
  │          │    │          │    │          │    │          │
  │ No key,  │    │ Keypair  │    │ Active,  │    │ Cannot   │
  │ no record│    │ generated│    │ can sign │    │ sign or  │
  │          │    │ being    │    │ challenges│   │ approve  │
  │          │    │ registered│   │          │    │          │
  └──────────┘    └──────────┘    └──────────┘    └──────────┘
       │                               │                │
       │                               │                │
       │     Triggers:                 │   Triggers:    │
       │     ─ After OTP               │   ─ New device │
       │       verification            │     registered │
       │     ─ After push              │   ─ Stale FCM  │
       │       login                   │   ─ Manual     │
       │     ─ After biometric         │     revoke     │
       │       login                   │   ─ Force      │
       │                               │     re-auth    │
       │                               │   ─ Account    │
       │                               │     deletion   │
       └───────────────────────────────┘                │
              Can re-bind after                         │
              successful OTP                            │
              ◄─────────────────────────────────────────┘
```

### 6.2 What Gets Stored Where

```
CLIENT DEVICE (Secure Storage)          SERVER (Firestore devices/{id})
═══════════════════════════════          ═══════════════════════════════

imali_bound_device_id: "abc123"         userId: "phone_27812345678"
imali_device_trusted: "true"            publicKeyPem: "-----BEGIN..."
imali_bound_user_id: "phone_27..."      fcmToken: "dJ3xK..."
imali_cached_display_name: "Sipho"      platform: "android"
imali_last_auth_time: "2026-01-30..."   deviceModel: "SM-A536B"
                                        osVersion: "Android 14 (SDK 34)"
                                        manufacturer: "Samsung"
HARDWARE KEYSTORE                       hardwareBacked: true
══════════════════                      strongBox: true
                                        trusted: true
Private key: imali_device_key_phone_... revoked: false
(ECDSA P-256, cannot be extracted)      registeredAt: <timestamp>
                                        lastUsedAt: <timestamp>
```

### 6.3 Single-Device Trust Policy

```
SINGLE DEVICE POLICY
═════════════════════

  When registerDevice() is called for User X:

  ┌─────────────────────────────────────────────┐
  │  1. Check: existing device for same user +  │
  │     same platform + not revoked?            │
  │                                              │
  │     YES → Update existing device record     │
  │           (new keypair, new FCM token)       │
  │                                              │
  │     NO  → Create new device document        │
  │                                              │
  │  2. Find ALL non-revoked devices for user   │
  │  3. Revoke every device EXCEPT the current  │
  │     one (batch update: revoked = true)      │
  │                                              │
  │  Result: Only ONE trusted device at a time  │
  └─────────────────────────────────────────────┘

  Why?
  ─────
  • Simpler security model — no need to manage
    which device is "primary" for financial ops
  • If old phone is compromised, new login on a
    new phone automatically revokes the old one
  • Push login still works DURING the login process
    (challenge is created before revocation happens)
```

---

## 7. Session Management

### 7.1 Session Lock Timeline

```
SESSION LOCK TIMELINE
═════════════════════

  App goes to background
  │
  │  0 - 30 seconds
  │  ─────────────────
  │  No lock. App resumes instantly.
  │
  │  30 seconds - 5 minutes
  │  ────────────────────────
  │  TIER-APPROPRIATE LOCK:
  │  ┌────────────────────────────────────┐
  │  │ Tier 1: Fingerprint/Face prompt   │
  │  │ Tier 2: Device PIN/pattern prompt │
  │  │ Tier 3: In-app PIN prompt         │
  │  │ Tier 4: Full OTP re-auth          │
  │  └────────────────────────────────────┘
  │
  │  5+ minutes
  │  ──────────
  │  FULL RE-AUTHENTICATION (OTP)
  │  Regardless of device tier.
  │
  v
```

### 7.2 Session State Machine

```
                    ┌──────────────┐
                    │              │
         ┌────────>│ AUTHENTICATED│<────────┐
         │         │              │         │
         │         └──────┬───────┘         │
         │                │                 │
    Unlock OK        App background         │
    (biometric/      > 30 seconds           │
     PIN/cred)            │                 │
         │                v                 │
         │         ┌──────────────┐    OTP success
         │         │              │    (re-auth)
         └─────────│SESSION LOCKED│         │
                   │              │─────────┘
                   └──────┬───────┘
                          │
                     App background
                     > 5 minutes
                     OR Tier 4
                     OR PIN lockout
                          │
                          v
                   ┌──────────────┐
                   │              │
                   │UNAUTHENTICATED│
                   │ (force OTP)  │
                   │              │
                   └──────────────┘
```

### 7.3 In-App PIN Security (Tier 3)

For devices without biometrics or device credentials:

```
PIN SECURITY MEASURES
═════════════════════

  Storage: HMAC-SHA256 hash + random salt in FlutterSecureStorage

  Weak PIN detection (rejected during setup):
  ┌──────────────────────────────────────┐
  │ ✗ Sequential: 1234, 4321, 2345      │
  │ ✗ Repeated: 1111, 0000, 5555        │
  │ ✗ Common: 1234, 0000, 1111          │
  │ ✗ Too short: less than 4 digits     │
  │ ✗ Too long: more than 6 digits      │
  └──────────────────────────────────────┘

  Lockout policy:
  ┌──────────────────────────────────────┐
  │ 5 failed attempts → 30-minute lockout│
  │ After lockout: must use OTP          │
  │                                      │
  │ Constant-time comparison used:       │
  │ (prevents timing attacks that could  │
  │  guess digits one at a time)         │
  └──────────────────────────────────────┘
```

---

## 8. Firestore Security Rules

### 8.1 Architecture: Server-Authoritative Model

```
WHO CAN WRITE WHAT?
════════════════════

  ┌──────────────────────────────────────────────────────────┐
  │                                                          │
  │   CLIENT (Flutter App)              SERVER (Cloud Fns)   │
  │   ═══════════════════              ══════════════════    │
  │                                                          │
  │   CAN READ:                        CAN READ + WRITE:    │
  │   ─ Own user profile               ─ Everything          │
  │   ─ Own wallet (read-only)         (via Admin SDK,       │
  │   ─ Own transactions               bypasses rules)       │
  │   ─ Own earnings                                         │
  │   ─ Own cashouts                                         │
  │   ─ Own devices                                          │
  │   ─ Own risk events                                      │
  │   ─ Own auth challenges                                  │
  │   ─ Chat threads (participant)                           │
  │                                                          │
  │   CAN WRITE:                       EXCLUSIVE WRITE:      │
  │   ─ Own user profile               ─ Wallets             │
  │     (display name only,            ─ Transactions        │
  │      phone is immutable)           ─ Earnings            │
  │   ─ Chat messages (as sender)      ─ Cashouts            │
  │   ─ Referral codes (own)           ─ Devices             │
  │                                    ─ Challenges          │
  │   CANNOT WRITE:                    ─ Fraud alerts        │
  │   ─ Wallets ✗                      ─ Blocked users       │
  │   ─ Transactions ✗                 ─ Rate limits         │
  │   ─ Earnings ✗                     ─ Risk events         │
  │   ─ Devices ✗                      ─ Verification codes  │
  │   ─ Anything financial ✗                                 │
  │                                                          │
  └──────────────────────────────────────────────────────────┘
```

### 8.2 Critical Rule: Phone Number Immutability

```dart
// Users can update their profile BUT:
allow update: if isOwner(userId)
  && isAppChecked()
  && isValidString(request.resource.data.displayName, 2, 50)
  // THIS LINE prevents changing the phone number:
  && request.resource.data.phoneNumber == resource.data.phoneNumber;
```

This prevents an attacker who gains temporary access from changing the phone number to receive OTPs on a different number.

### 8.3 Complete Zero-Write Collections

These collections have `allow read, write: if false` — **only** the Firebase Admin SDK (used by Cloud Functions) can access them:

```
ADMIN-ONLY COLLECTIONS
══════════════════════

  ┌─────────────────────┐
  │ verification_codes   │  OTP hashes — if readable, attacker
  │                     │  could brute-force the 4-digit code
  ├─────────────────────┤
  │ biometricChallenges │  Nonces — if readable, attacker could
  │                     │  sign them without going through server
  ├─────────────────────┤
  │ blockedUsers        │  If writable, attacker could unblock
  │                     │  themselves
  ├─────────────────────┤
  │ fraudAlerts         │  If writable, attacker could delete
  │                     │  their fraud alerts
  ├─────────────────────┤
  │ rateLimits          │  If writable, attacker could reset
  │                     │  their rate limit counters
  ├─────────────────────┤
  │ platformStats       │  Internal analytics — no user access
  └─────────────────────┘
```

---

## 9. Rate Limiting

### 9.1 Dual-Layer Rate Limiting

Rate limiting happens on **both** client and server:

```
CLIENT-SIDE (Dart)                     SERVER-SIDE (Cloud Functions)
══════════════════                     ═════════════════════════════

In-memory tracking                     Firestore-backed tracking
(fast, but resets on restart)          (persistent, authoritative)

┌────────────────────────┐             ┌────────────────────────────┐
│ Action        │ Limit  │             │ Action          │ Limit    │
├────────────────────────┤             ├────────────────────────────┤
│ earn_ad       │ 50/hr  │             │ earn            │ 100/hr   │
│ earn_survey   │ 20/hr  │             │ transfer        │ 20/10min │
│ transfer      │ 20/hr  │             │ cashout         │ 5/hr     │
│ cashout       │  3/hr  │             │ purchase        │ 20/10min │
│ login         │  5/15m │             │ referral        │ 10/hr    │
│ chat_send     │ 30/min │             │ otp_send        │ 5/hr     │
│ profile_edit  │ 10/hr  │             │ otp_verify      │ 10/5min  │
└────────────────────────┘             │ device_register │ 5/day    │
                                       │ login_request   │ 10/hr    │
                                       │ challenge_approve│ 10/10min│
                                       │ biometric_chall │ 5/5min   │
                                       │ biometric_verify│ 5/5min   │
                                       └────────────────────────────┘
```

### 9.2 How Server Rate Limiting Works

```
RATE LIMIT CHECK — SERVER
═════════════════════════

  Input: userId="phone_27...", action="otp_send"
  Config: { maxAttempts: 5, windowMinutes: 60 }

  ┌──────────────────────────────────────────────┐
  │  1. Read rateLimits/phone_27..._otp_send     │
  │                                               │
  │  2. Filter attempts within window:            │
  │     [ "10:00", "10:15", "10:30" ]             │
  │     (3 attempts in last 60 minutes)           │
  │                                               │
  │  3. attempts.length (3) < maxAttempts (5)?    │
  │     YES → allowed: true                       │
  │     Record new attempt timestamp              │
  │                                               │
  │  If 5 or more:                                │
  │     NO → allowed: false                       │
  │     "Rate limit exceeded. Try again in 60     │
  │      minutes."                                │
  └──────────────────────────────────────────────┘

  Cleanup: Daily at 3 AM (Africa/Johannesburg),
  records older than 24 hours are batch-deleted.
```

---

## 10. Fraud Detection

### 10.1 Multi-Layer Fraud Detection Architecture

```
FRAUD DETECTION LAYERS
══════════════════════

  ┌────────────────────────────────────────────────────────┐
  │  Layer 1: CLIENT-SIDE PRE-CHECKS (Dart)                │
  │  ──────────────────────────────────                     │
  │  FraudDetector checks:                                  │
  │  • Daily earning limits (100k tokens / R1,000)         │
  │  • Single transfer limits (50k tokens)                 │
  │  • Daily transfer count (max 10)                       │
  │  • Daily cashout count (max 3)                         │
  │  • Earning velocity (< 30s between earns = suspicious) │
  │  • Circular transfers (A→B→A within 1 hour)            │
  │  • Recipient flooding (> 5 new recipients/day)         │
  │  • Survey quality (straight-lining, gibberish)         │
  │                                                         │
  │  If suspicious: blocks action BEFORE server call       │
  └───────────────────────────┬────────────────────────────┘
                              │ Passes pre-check
                              v
  ┌────────────────────────────────────────────────────────┐
  │  Layer 2: SERVER-SIDE FRAUD ANALYSIS (Cloud Functions)  │
  │  ─────────────────────────────────────────────────      │
  │  Independent checks (client can't bypass):              │
  │                                                         │
  │  checkEarningFraud():                                   │
  │  • Daily total > 100k tokens?                          │
  │  • Earning velocity (10 earns < 30s avg = suspicious)  │
  │  • Same source > 30 times today?                       │
  │                                                         │
  │  checkTransferFraud():                                  │
  │  • Single transfer > 100k tokens?                      │
  │  • Daily transfers > 50?                               │
  │  • Circular pattern? (B→A within 1 hour of A→B)        │
  │  • More than 10 unique recipients today?               │
  │                                                         │
  │  checkCashoutFraud():                                   │
  │  • Account < 7 days old AND cashout > 10k tokens?      │
  │  • Daily cashouts >= 5?                                │
  │  • Large transfer received < 30 min before cashout?    │
  └───────────────────────────┬────────────────────────────┘
                              │ Flags raised
                              v
  ┌────────────────────────────────────────────────────────┐
  │  Layer 3: ALERT SYSTEM & AUTO-BLOCKING                  │
  │  ─────────────────────────────────────                  │
  │                                                         │
  │  Each fraud flag → stored in fraudAlerts collection    │
  │                                                         │
  │  3+ alerts in 24 hours → AUTOMATIC ACCOUNT BLOCK       │
  │  ┌──────────────────────────────────────────────┐      │
  │  │  blockedUsers/{userId} created:               │      │
  │  │  { reason: "Multiple fraud alerts triggered", │      │
  │  │    alertCount: 3,                              │      │
  │  │    reviewed: false }                           │      │
  │  └──────────────────────────────────────────────┘      │
  │                                                         │
  │  Blocked user check (isUserBlocked):                   │
  │  • Every financial operation checks this FIRST         │
  │  • Returns true unless manually reviewed AND cleared   │
  │  • Admin can clear via console                         │
  └────────────────────────────────────────────────────────┘
```

### 10.2 Survey Quality Validation

```
SURVEY FRAUD DETECTION
═══════════════════════

  ┌──────────────────────────────────────────────────┐
  │  Check                  │  Threshold             │
  ├──────────────────────────────────────────────────┤
  │  Time per question      │  < 3 seconds = invalid │
  │  Straight-lining        │  Same answer for ALL   │
  │  (same answer every Q)  │  questions = rejected  │
  │  Response time variance │  Zero variance = bot   │
  │  Gibberish detection    │  Shannon entropy check │
  │  Keyboard mashing       │  Pattern recognition   │
  │  (asdf, qwer, etc.)    │  (repeated sequences)  │
  └──────────────────────────────────────────────────┘
```

---

## 11. Device Integrity Verification

### 11.1 Google Play Integrity API

This verifies that the device and app are genuine:

```
PLAY INTEGRITY VERIFICATION FLOW
═════════════════════════════════

  ┌──────────┐                    ┌──────────────┐
  │  Client  │                    │  Google Play  │
  │  App     │                    │  Servers      │
  └────┬─────┘                    └──────┬───────┘
       │                                 │
       │  1. Generate nonce              │
       │  2. Request integrity token ────>│
       │                                 │  Checks:
       │                                 │  • Is device genuine?
       │                                 │  • Is OS unmodified?
       │                                 │  • Is app from Play Store?
       │  3. Receive token <─────────────│
       │                                 │
       │                    ┌──────────────────┐
       │  4. Send token ───>│  Cloud Function  │
       │     with request   │  (iMali server)  │
       │                    └────────┬─────────┘
       │                             │
       │                    5. Decode token with
       │                       Google API
       │                             │
       │                    6. Evaluate verdict
       │                             │
       │              ┌──────────────┴──────────────┐
       │              │                             │
       │         HIGHEST TIER                  HIGH TIER
       │         (cashout, transfers)          (earning, purchases)
       │              │                             │
       │    ┌─────────┴─────────┐         ┌────────┴────────┐
       │    │MEETS_DEVICE_      │         │MEETS_BASIC_     │
       │    │INTEGRITY required │         │INTEGRITY: warn  │
       │    │                   │         │but allow        │
       │    │UNLICENSED app:    │         │                 │
       │    │blocked            │         │UNLICENSED: warn │
       │    └───────────────────┘         └─────────────────┘
       │
       │  7. Result ────────────────────> logged to
       │                                 integrityChecks
       │                                 collection
```

### 11.2 Firebase App Check

```
APP CHECK — EVERY CLOUD FUNCTION CALL
═══════════════════════════════════════

  ┌──────────────────────────────────────────────┐
  │  Client makes Cloud Function call             │
  │  → Firebase SDK automatically attaches        │
  │    App Check token                            │
  │                                                │
  │  Server checks context.app:                   │
  │                                                │
  │  ┌─ Monitoring mode (current):                │
  │  │  Missing token → log warning               │
  │  │  Request continues                         │
  │  │                                             │
  │  └─ Enforcement mode (future):                │
  │     Missing token → reject with               │
  │     "unauthenticated" error                   │
  │     "App verification failed.                 │
  │      Please update the app."                  │
  └──────────────────────────────────────────────┘

  Purpose: Prevents someone from calling Cloud Functions
  directly (e.g., with curl or a script) without having
  a genuine iMali app installed.
```

---

## 12. Input Validation & Sanitisation

### 12.1 Validation Rules

```
INPUT VALIDATION — CLIENT + SERVER
═══════════════════════════════════

  ┌─────────────────┬───────────────────────────────────────┐
  │ Field           │ Validation                             │
  ├─────────────────┼───────────────────────────────────────┤
  │ Phone (SA)      │ ^(\+27|0)[6-8][0-9]{8}$              │
  │ Email           │ RFC 5322 pattern                       │
  │ Display name    │ ^[a-zA-Z\s]{2,50}$                   │
  │ Referral code   │ ^[A-Z0-9]{6,10}$                     │
  │ PIN             │ ^[0-9]{4,6}$                          │
  │ Token amount    │ Integer, min 1, max 10,000,000        │
  │ Chat message    │ Max 1000 characters                   │
  │ OTP code        │ ^\d{4}$ (exactly 4 digits)            │
  │ Public key      │ Must start with -----BEGIN PUBLIC KEY  │
  └─────────────────┴───────────────────────────────────────┘
```

### 12.2 Injection Prevention

```
SANITISATION — SERVER SIDE
══════════════════════════

  sanitizeString() removes:
  ┌──────────────────────────────────────────────┐
  │ • <script tags                               │
  │ • javascript: URI schemes                    │
  │ • on<event> handlers (onclick, onerror, etc.)│
  │ • Control characters (0x00-0x1F, 0x7F)       │
  └──────────────────────────────────────────────┘

  SQL injection detection (client):
  ┌──────────────────────────────────────────────┐
  │ Patterns flagged:                            │
  │ • SELECT ... FROM                            │
  │ • INSERT INTO                                │
  │ • DELETE FROM                                │
  │ • DROP TABLE                                 │
  │ • UNION SELECT                               │
  │ • ' OR '1'='1                                │
  │ • -- (comment injection)                     │
  │ • ; (statement terminator)                   │
  └──────────────────────────────────────────────┘

  Note: Firestore is a NoSQL database and not vulnerable
  to SQL injection. These checks are defence-in-depth
  against data corruption and XSS in any web-based admin
  tools that might display user-provided data.
```

---

## 13. Audit Logging

### 13.1 What Gets Logged

```
AUDIT LOG CATEGORIES
════════════════════

  ┌──────────────────────────────────────────────────────┐
  │  AUTHENTICATION EVENTS                                │
  │  ─ Login success/failure (OTP, biometric, push)      │
  │  ─ Logout                                            │
  │  ─ OTP sent/verified                                 │
  │  ─ Device bound/unbound                              │
  │  ─ Session lock/unlock (biometric, PIN, credential)  │
  │  ─ Force re-authentication                           │
  ├──────────────────────────────────────────────────────┤
  │  FINANCIAL EVENTS                                     │
  │  ─ Earning recorded                                  │
  │  ─ Transfer sent/received                            │
  │  ─ Cashout requested/processed                       │
  │  ─ Purchase made                                     │
  │  ─ Pot entry/win                                     │
  ├──────────────────────────────────────────────────────┤
  │  SECURITY EVENTS                                      │
  │  ─ SIM change detected                               │
  │  ─ Fraud alert triggered                             │
  │  ─ Rate limit hit                                    │
  │  ─ Device integrity check result                     │
  │  ─ Risk event created/resolved                       │
  ├──────────────────────────────────────────────────────┤
  │  DATA ACCESS EVENTS                                   │
  │  ─ Profile viewed/updated                            │
  │  ─ Wallet balance checked                            │
  │  ─ Transaction history viewed                        │
  └──────────────────────────────────────────────────────┘
```

### 13.2 Audit Log Entry Structure

```
AUDIT LOG ENTRY — STORED IN FIRESTORE auditLogs COLLECTION
═══════════════════════════════════════════════════════════

  {
    id: "auto-generated",
    userId: "phone_27812345678",
    eventType: "authentication",
    action: "deviceBound",
    success: true,
    riskLevel: "low",          // low | medium | high | critical
    deviceInfo: {
      platform: "android",
      model: "SM-A536B",
      osVersion: "Android 14",
      fingerprint: "sha256:a3f8..."
    },
    metadata: {
      deviceId: "abc123",
      hardwareBacked: true
    },
    timestamp: "2026-01-30T14:23:45.000Z",
    serverTimestamp: <Firestore server timestamp>
  }
```

---

## 14. SIM Change Detection

```
SIM CHANGE DETECTION FLOW
══════════════════════════

  On app launch (after authentication):

  ┌──────────────────────────────────────────────┐
  │  1. KeystoreService.getSimInfo()              │
  │     → { operatorName: "Vodacom",             │
  │         simCountryIso: "za",                  │
  │         networkCountryIso: "za" }             │
  │                                               │
  │  2. Generate fingerprint:                     │
  │     "Vodacom|za|za"                           │
  │                                               │
  │  3. Hash: SHA-256(fingerprint)                │
  │     → "7d2f1a8b..."                           │
  │                                               │
  │  4. Compare with stored hash from last check  │
  └──────────────────┬───────────────────────────┘
                     │
          ┌──────────┴──────────┐
          │                     │
     MATCH (same SIM)     MISMATCH (SIM changed!)
          │                     │
          v                     v
    No action             ┌─────────────────────────┐
                          │  1. Create risk event    │
                          │     (HIGH severity)      │
                          │  2. Log to audit trail   │
                          │  3. Push notification:   │
                          │     "SIM card change     │
                          │      detected"           │
                          │  4. May trigger step-up  │
                          │     auth for next action │
                          └─────────────────────────┘

  Note: Uses operator name (no special permissions needed).
  Does NOT read phone number or IMSI (would require
  READ_PHONE_STATE permission).
```

---

## 15. Complete Security Layer Diagram

```
═══════════════════════════════════════════════════════════════════
                    COMPLETE SECURITY ARCHITECTURE
═══════════════════════════════════════════════════════════════════

  USER'S PHONE                          GOOGLE CLOUD
  ════════════                          ════════════

  ┌─────────────────────────────┐      ┌────────────────────────┐
  │  iMali Flutter App          │      │  Firebase Project       │
  │                             │      │                        │
  │  ┌───────────────────────┐  │      │  ┌──────────────────┐  │
  │  │  Presentation Layer   │  │      │  │  Cloud Functions  │  │
  │  │  ─ Auth BLoC          │  │      │  │                  │  │
  │  │  ─ GoRouter guards    │  │      │  │  sendOtp         │  │
  │  │  ─ UI auth screens    │  │      │  │  verifyOtp       │  │
  │  └──────────┬────────────┘  │      │  │  registerDevice  │  │
  │             │               │      │  │  loginRequest    │  │
  │  ┌──────────v────────────┐  │      │  │  approveLogin    │  │
  │  │  Security Layer       │  │      │  │  checkChallenge  │  │
  │  │  ─ BiometricLogin     │  │ API  │  │  requestBioChall │  │
  │  │  ─ DeviceBinding      │<─┼─────>│  │  verifyBioChall  │  │
  │  │  ─ SessionLock        │  │calls │  │  revokeDevice    │  │
  │  │  ─ FraudDetector      │  │      │  │  + security      │  │
  │  │  ─ RateLimiter        │  │      │  │    middleware     │  │
  │  │  ─ InputValidator     │  │      │  └──────────────────┘  │
  │  │  ─ AuditLogger        │  │      │                        │
  │  │  ─ SimChangeDetector  │  │      │  ┌──────────────────┐  │
  │  │  ─ PlayIntegrity      │  │      │  │  Firestore DB    │  │
  │  │  ─ CaptchaService     │  │      │  │                  │  │
  │  │  ─ StepUpAuth         │  │      │  │  users/          │  │
  │  │  ─ TransactionVerifier│  │      │  │  wallets/        │  │
  │  └──────────┬────────────┘  │      │  │  transactions/   │  │
  │             │               │      │  │  devices/        │  │
  │  ┌──────────v────────────┐  │      │  │  authChallenges/ │  │
  │  │  Hardware Layer       │  │      │  │  biometricChall/ │  │
  │  │                       │  │      │  │  verification_/  │  │
  │  │  ┌─────────────────┐  │  │      │  │  rateLimits/     │  │
  │  │  │Android Keystore │  │  │      │  │  fraudAlerts/    │  │
  │  │  │/ iOS Secure     │  │  │      │  │  blockedUsers/   │  │
  │  │  │  Enclave        │  │  │      │  │  riskEvents/     │  │
  │  │  │                 │  │  │      │  │  auditLogs/      │  │
  │  │  │ ECDSA P-256     │  │  │      │  │  integrityChecks/│  │
  │  │  │ private key     │  │  │      │  └──────────────────┘  │
  │  │  │ (never leaves)  │  │  │      │                        │
  │  │  └─────────────────┘  │  │      │  ┌──────────────────┐  │
  │  │                       │  │      │  │  Firebase Auth   │  │
  │  │  ┌─────────────────┐  │  │      │  │  (Custom Tokens) │  │
  │  │  │FlutterSecure    │  │  │      │  └──────────────────┘  │
  │  │  │Storage          │  │  │      │                        │
  │  │  │                 │  │  │      │  ┌──────────────────┐  │
  │  │  │ deviceId, userId│  │  │      │  │  Firebase Cloud  │  │
  │  │  │ PIN hash + salt │  │  │      │  │  Messaging (FCM) │  │
  │  │  │ auth timestamp  │  │  │      │  └──────────────────┘  │
  │  │  │ display name    │  │  │      │                        │
  │  │  └─────────────────┘  │  │      │  ┌──────────────────┐  │
  │  └───────────────────────┘  │      │  │  App Check       │  │
  │                             │      │  │  Play Integrity   │  │
  └─────────────────────────────┘      │  └──────────────────┘  │
                                       └────────────────────────┘

  ┌──────────────────┐
  │  EXTERNAL SERVICES│
  │                  │
  │  MyMobileAPI     │  ← SMS delivery for OTPs
  │  (South Africa)  │
  │                  │
  │  Google Play     │  ← Device integrity verdicts
  │  Integrity API   │
  └──────────────────┘


═══════════════════════════════════════════════════════════════════
                    SECURITY PROPERTIES SUMMARY
═══════════════════════════════════════════════════════════════════

  ✓ No client-side balance manipulation (server-authoritative)
  ✓ Hardware-backed device identity (ECDSA P-256)
  ✓ OTPs never stored in plain text (SHA-256 + salt)
  ✓ PINs hashed with HMAC-SHA256 + constant-time comparison
  ✓ Single-device trust (new device revokes old)
  ✓ 7-day inactivity timeout for biometric login
  ✓ Session locks (30s → tier unlock, 5min → full re-auth)
  ✓ Dual-layer rate limiting (client + server)
  ✓ Dual-layer fraud detection (client + server)
  ✓ Auto-blocking after 3+ fraud alerts in 24 hours
  ✓ SIM change detection without special permissions
  ✓ Play Integrity verification for high-value operations
  ✓ App Check on all Cloud Function calls
  ✓ Server-generated nonces prevent replay attacks
  ✓ Stale FCM token cleanup with automatic OTP fallback
  ✓ Comprehensive audit logging for forensics
  ✓ Input validation + sanitisation on client AND server
  ✓ Firestore rules enforce server-only financial writes
  ✓ Phone number immutability in user profiles
  ✓ reCAPTCHA v3 for high-risk operations
  ✓ Weak PIN detection and lockout policy

═══════════════════════════════════════════════════════════════════
```

---

*Document generated from codebase analysis. All code references are from the iMali source as of February 2026.*
