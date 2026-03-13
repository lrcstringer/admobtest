import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/security/audit_logger.dart';
import 'package:imalichat/core/security/device_capability_service.dart';
import 'package:imalichat/core/security/pin_manager.dart';
import 'package:imalichat/core/security/session_lock_service.dart';

// =============================================================================
// IN-MEMORY SECURE STORAGE
// =============================================================================

class InMemorySecureStorage extends Mock implements FlutterSecureStorage {
  final Map<String, String> _store = {};

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) {
      _store[key] = value;
    }
  }

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store.remove(key);

  @override
  Future<Map<String, String>> readAll({
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      Map.unmodifiable(_store);

  /// Expose the store for test assertions.
  Map<String, String> get store => _store;

  /// Clear all stored data.
  void clear() => _store.clear();
}

// =============================================================================
// MOCK CLASSES
// =============================================================================

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class MockDeviceCapabilityService extends Mock
    implements DeviceCapabilityService {}

class MockAuditLogger extends Mock implements AuditLogger {}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late InMemorySecureStorage secureStorage;
  late MockLocalAuthentication mockLocalAuth;
  late MockDeviceCapabilityService mockCapabilityService;
  late MockAuditLogger mockAuditLogger;
  late PinManager pinManager;
  late SessionLockService sessionLockService;

  setUpAll(() {
    registerFallbackValue(AuthAction.login);
});

  setUp(() {
    secureStorage = InMemorySecureStorage();
    mockLocalAuth = MockLocalAuthentication();
    mockCapabilityService = MockDeviceCapabilityService();
    mockAuditLogger = MockAuditLogger();

    // REAL PinManager with in-memory storage
    pinManager = PinManager(secureStorage);

    // REAL SessionLockService with real PinManager, mocked auth + capability
    sessionLockService = SessionLockService(
      mockCapabilityService,
      mockLocalAuth,
      pinManager,
      mockAuditLogger,
    );

    // Default stubs for AuditLogger (fire-and-forget calls)
    when(() => mockAuditLogger.logAuthEvent(
          userId: any(named: 'userId'),
          action: any(named: 'action'),
          success: any(named: 'success'),
          errorMessage: any(named: 'errorMessage'),
        )).thenAnswer((_) async {});
  });

  group('Session Security Integration Tests', () {
    // =========================================================================
    // 1. PIN lifecycle: setPin -> verifyPin (success) -> changePin ->
    //    verify new works, old doesn't
    // =========================================================================
    test(
        '1. PIN lifecycle: setPin -> verifyPin -> changePin -> new works, old does not',
        () async {
      // Set a PIN
      final setResult = await pinManager.setPin('5739');
      expect(setResult, true, reason: 'setPin should succeed for a strong PIN');

      // Verify the PIN
      final verifyResult = await pinManager.verifyPin('5739');
      expect(verifyResult, PinVerifyResult.success);

      // Change PIN
      final changeResult = await pinManager.changePin('5739', '8462');
      expect(changeResult, true, reason: 'changePin should succeed');

      // Old PIN should fail
      final oldPinResult = await pinManager.verifyPin('5739');
      expect(oldPinResult, PinVerifyResult.incorrect);

      // New PIN should work
      final newPinResult = await pinManager.verifyPin('8462');
      expect(newPinResult, PinVerifyResult.success);
    });

    // =========================================================================
    // 2. PIN lockout flow: setPin -> verifyPin wrong 5 times -> lockedOut ->
    //    session lock returns requiresFullReauth
    // =========================================================================
    test(
        '2. PIN lockout flow: 5 wrong attempts -> lockedOut -> attemptUnlock returns requiresFullReauth',
        () async {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.inAppPin);

      // Set a PIN
      await pinManager.setPin('5739');

      // Fail 5 times (maxFailedAttempts = 5)
      for (int i = 0; i < PinManager.maxFailedAttempts; i++) {
        await pinManager.verifyPin('0000');
      }

      // Verify locked out
      final lockedResult = await pinManager.verifyPin('5739');
      expect(lockedResult, PinVerifyResult.lockedOut);

      // SessionLockService should propagate lockout as requiresFullReauth
      sessionLockService.forceLock();
      final unlockResult = await sessionLockService.attemptUnlock(pin: '5739');
      expect(unlockResult, UnlockResult.requiresFullReauth);
    });

    // =========================================================================
    // 3. Session lock + biometric unlock: forceLock -> attemptUnlock
    //    (biometric tier, success) -> isLocked=false
    // =========================================================================
    test(
        '3. Session lock + biometric unlock: forceLock -> biometric unlock -> isLocked=false',
        () async {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.biometric);
      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            biometricOnly: any(named: 'biometricOnly'),
            persistAcrossBackgrounding:
                any(named: 'persistAcrossBackgrounding'),
          )).thenAnswer((_) async => true);

      sessionLockService.setUserId('user123');
      sessionLockService.forceLock();
      expect(sessionLockService.isLocked, true);

      final result = await sessionLockService.attemptUnlock();
      expect(result, UnlockResult.success);
      expect(sessionLockService.isLocked, false);
    });

    // =========================================================================
    // 4. Session lock + PIN unlock: forceLock -> attemptUnlock (inAppPin,
    //    correct PIN) -> isLocked=false
    // =========================================================================
    test(
        '4. Session lock + PIN unlock: forceLock -> correct PIN -> isLocked=false',
        () async {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.inAppPin);

      // Set up a PIN first
      await pinManager.setPin('5739');

      sessionLockService.setUserId('user123');
      sessionLockService.forceLock();
      expect(sessionLockService.isLocked, true);

      final result = await sessionLockService.attemptUnlock(pin: '5739');
      expect(result, UnlockResult.success);
      expect(sessionLockService.isLocked, false);
    });

    // =========================================================================
    // 5. Session lock + wrong PIN: forceLock -> attemptUnlock (inAppPin,
    //    wrong PIN) -> failed
    // =========================================================================
    test(
        '5. Session lock + wrong PIN: forceLock -> wrong PIN -> UnlockResult.failed',
        () async {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.inAppPin);

      await pinManager.setPin('5739');

      sessionLockService.setUserId('user123');
      sessionLockService.forceLock();
      expect(sessionLockService.isLocked, true);

      final result = await sessionLockService.attemptUnlock(pin: '0000');
      expect(result, UnlockResult.failed);
      expect(sessionLockService.isLocked, true,
          reason: 'Session should remain locked after wrong PIN');
    });

    // =========================================================================
    // 6. Lock suppression: suppressLock -> onAppPaused -> onAppResumed ->
    //    noLockNeeded -> unsuppressLock
    // =========================================================================
    test(
        '6. Lock suppression: suppress -> pause -> resume -> noLockNeeded -> unsuppress',
        () async {
      sessionLockService.suppressLock();

      // Simulate going to background
      sessionLockService.onAppPaused();

      // Simulate resuming — should not lock because suppressed
      final result = sessionLockService.onAppResumed();
      expect(result, SessionLockResult.noLockNeeded);
      expect(sessionLockService.isLocked, false);

      // Unsuppress
      sessionLockService.unsuppressLock();

      // Now a real pause/resume cycle WOULD lock if enough time passed.
      // Verify we're back to normal state (no background timestamp lingers).
      final resultAfterUnsuppress = sessionLockService.onAppResumed();
      expect(resultAfterUnsuppress, SessionLockResult.noLockNeeded,
          reason:
              'unsuppressLock clears background timestamp, so no lock needed');
    });

    // =========================================================================
    // 7. Force lock overrides everything: markUnlocked -> forceLock ->
    //    isLocked=true
    // =========================================================================
    test(
        '7. Force lock overrides everything: markUnlocked -> forceLock -> isLocked=true',
        () {
      // Start unlocked
      sessionLockService.markUnlocked();
      expect(sessionLockService.isLocked, false);

      // Force lock should override
      sessionLockService.forceLock();
      expect(sessionLockService.isLocked, true);
    });

    // =========================================================================
    // 8. Multiple unlock attempts: forceLock -> failed attempt -> successful
    //    attempt -> unlocked
    // =========================================================================
    test(
        '8. Multiple unlock attempts: forceLock -> failed -> successful -> unlocked',
        () async {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.inAppPin);

      await pinManager.setPin('5739');

      sessionLockService.setUserId('user123');
      sessionLockService.forceLock();

      // First attempt: wrong PIN
      final failResult =
          await sessionLockService.attemptUnlock(pin: '0000');
      expect(failResult, UnlockResult.failed);
      expect(sessionLockService.isLocked, true);

      // Second attempt: correct PIN
      final successResult =
          await sessionLockService.attemptUnlock(pin: '5739');
      expect(successResult, UnlockResult.success);
      expect(sessionLockService.isLocked, false);
    });

    // =========================================================================
    // 9. Discard timestamp: onAppPaused -> discardBackgroundTimestamp ->
    //    onAppResumed -> noLockNeeded
    // =========================================================================
    test(
        '9. Discard timestamp: pause -> discardBackgroundTimestamp -> resume -> noLockNeeded',
        () {
      // Simulate going to background
      sessionLockService.onAppPaused();

      // Discard the timestamp (e.g., during OTP flow)
      sessionLockService.discardBackgroundTimestamp();

      // Resume — should not lock because timestamp was discarded
      final result = sessionLockService.onAppResumed();
      expect(result, SessionLockResult.noLockNeeded);
      expect(sessionLockService.isLocked, false);
    });

    // =========================================================================
    // 10. OTP-only tier: forceLock -> attemptUnlock (otpOnly tier) ->
    //     requiresFullReauth
    // =========================================================================
    test(
        '10. OTP-only tier: forceLock -> attemptUnlock -> requiresFullReauth',
        () async {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.otpOnly);

      sessionLockService.setUserId('user123');
      sessionLockService.forceLock();
      expect(sessionLockService.isLocked, true);

      // Attempt unlock on a Tier 4 (otpOnly) device — must require full reauth
      final result = await sessionLockService.attemptUnlock();
      expect(result, UnlockResult.requiresFullReauth);
      // Session remains locked; only full OTP reauth can resolve this
      expect(sessionLockService.isLocked, true);
    });
  });
}
