import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/security/audit_logger.dart';
import 'package:imalichat/core/security/device_capability_service.dart';
import 'package:imalichat/core/security/pin_manager.dart';
import 'package:imalichat/core/security/session_lock_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------
class MockDeviceCapabilityService extends Mock
    implements DeviceCapabilityService {}

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class MockPinManager extends Mock implements PinManager {}

class MockAuditLogger extends Mock implements AuditLogger {}

void main() {
  late MockDeviceCapabilityService mockCapabilityService;
  late MockLocalAuthentication mockLocalAuth;
  late MockPinManager mockPinManager;
  late MockAuditLogger mockAuditLogger;
  late SessionLockService service;

  setUpAll(() {
    registerFallbackValue(AuthAction.login);
    registerFallbackValue(const AuthenticationOptions());
  });

  setUp(() {
    mockCapabilityService = MockDeviceCapabilityService();
    mockLocalAuth = MockLocalAuthentication();
    mockPinManager = MockPinManager();
    mockAuditLogger = MockAuditLogger();

    // Stub the audit logger so internal _logUnlockEvent calls don't blow up.
    when(() => mockAuditLogger.logAuthEvent(
          userId: any(named: 'userId'),
          action: any(named: 'action'),
          success: any(named: 'success'),
          errorMessage: any(named: 'errorMessage'),
        )).thenAnswer((_) async {});

    service = SessionLockService(
      mockCapabilityService,
      mockLocalAuth,
      mockPinManager,
      mockAuditLogger,
    );

    // Set a user ID so audit logging has a non-null userId.
    service.setUserId('test-user-123');
  });

  // -------------------------------------------------------------------------
  // isLocked
  // -------------------------------------------------------------------------
  group('isLocked', () {
    test('is false initially', () {
      expect(service.isLocked, isFalse);
    });

    test('is true after forceLock()', () {
      service.forceLock();
      expect(service.isLocked, isTrue);
    });

    test('is false after markUnlocked()', () {
      service.forceLock();
      expect(service.isLocked, isTrue);

      service.markUnlocked();
      expect(service.isLocked, isFalse);
    });
  });

  // -------------------------------------------------------------------------
  // onAppResumed — no timestamp / suppressed / immediate resume
  // -------------------------------------------------------------------------
  group('onAppResumed', () {
    test('returns noLockNeeded when no onAppPaused was called', () {
      final result = service.onAppResumed();
      expect(result, equals(SessionLockResult.noLockNeeded));
    });

    test('returns noLockNeeded when lock is suppressed', () {
      service.suppressLock();
      service.onAppPaused(); // should be ignored
      final result = service.onAppResumed();
      expect(result, equals(SessionLockResult.noLockNeeded));
    });

    test('returns noLockNeeded immediately after onAppPaused (< 30s)', () {
      service.onAppPaused();
      // Resume immediately — elapsed ~0ms, well under 30s.
      final result = service.onAppResumed();
      expect(result, equals(SessionLockResult.noLockNeeded));
    });

    test('clears _backgroundTimestamp after evaluation', () {
      service.onAppPaused();
      service.onAppResumed(); // consumes the timestamp

      // Second call with no new onAppPaused should return noLockNeeded.
      final result = service.onAppResumed();
      expect(result, equals(SessionLockResult.noLockNeeded));
    });
  });

  // -------------------------------------------------------------------------
  // suppressLock / unsuppressLock
  // -------------------------------------------------------------------------
  group('suppressLock / unsuppressLock', () {
    test('suppressLock prevents onAppPaused from recording timestamp', () {
      service.suppressLock();
      service.onAppPaused();

      // Even after unsuppressing, the timestamp was never set so no lock.
      service.unsuppressLock();
      final result = service.onAppResumed();
      expect(result, equals(SessionLockResult.noLockNeeded));
    });

    test('unsuppressLock clears background timestamp and re-enables', () {
      // Record a timestamp while not suppressed.
      service.onAppPaused();

      // Suppress, then unsuppress — should clear the timestamp.
      service.suppressLock();
      service.unsuppressLock();

      final result = service.onAppResumed();
      expect(result, equals(SessionLockResult.noLockNeeded));
    });

    test('onAppResumed returns noLockNeeded while suppressed even with prior'
        ' onAppPaused', () {
      // Record timestamp before suppression.
      service.onAppPaused();
      service.suppressLock();

      // Even though timestamp exists, suppress flag causes noLockNeeded.
      final result = service.onAppResumed();
      expect(result, equals(SessionLockResult.noLockNeeded));
    });
  });

  // -------------------------------------------------------------------------
  // discardBackgroundTimestamp
  // -------------------------------------------------------------------------
  group('discardBackgroundTimestamp', () {
    test('after discard, onAppResumed returns noLockNeeded', () {
      service.onAppPaused();
      service.discardBackgroundTimestamp();

      final result = service.onAppResumed();
      expect(result, equals(SessionLockResult.noLockNeeded));
    });
  });

  // -------------------------------------------------------------------------
  // forceLock
  // -------------------------------------------------------------------------
  group('forceLock', () {
    test('sets isLocked to true', () {
      service.forceLock();
      expect(service.isLocked, isTrue);
    });

    test('isLocked stays true until markUnlocked', () {
      service.forceLock();
      expect(service.isLocked, isTrue);

      // Calling onAppResumed does not clear the lock.
      service.onAppResumed();
      expect(service.isLocked, isTrue);

      service.markUnlocked();
      expect(service.isLocked, isFalse);
    });
  });

  // -------------------------------------------------------------------------
  // markUnlocked
  // -------------------------------------------------------------------------
  group('markUnlocked', () {
    test('sets isLocked to false', () {
      service.forceLock();
      service.markUnlocked();
      expect(service.isLocked, isFalse);
    });

    test('clears background timestamp', () {
      service.onAppPaused();
      service.markUnlocked();

      // Background timestamp was cleared, so onAppResumed returns noLockNeeded.
      final result = service.onAppResumed();
      expect(result, equals(SessionLockResult.noLockNeeded));
    });
  });

  // -------------------------------------------------------------------------
  // attemptUnlock — Tier 1 (biometric)
  // -------------------------------------------------------------------------
  group('attemptUnlock — biometric tier', () {
    setUp(() {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.biometric);
    });

    test('biometric success returns UnlockResult.success and clears lock',
        () async {
      service.forceLock();

      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(named: 'options'),
          )).thenAnswer((_) async => true);

      final result = await service.attemptUnlock();

      expect(result, equals(UnlockResult.success));
      expect(service.isLocked, isFalse);

      // Verify biometricOnly: true was used.
      verify(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: true,
            ),
          )).called(1);
    });

    test('biometric failure falls back to device credential — success',
        () async {
      service.forceLock();

      var callCount = 0;
      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(named: 'options'),
          )).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) return false; // biometric fails
        return true; // device credential succeeds
      });

      final result = await service.attemptUnlock();

      expect(result, equals(UnlockResult.success));
      expect(service.isLocked, isFalse);

      // authenticate was called twice: biometricOnly:true then false.
      verify(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(named: 'options'),
          )).called(2);
    });

    test('biometric failure falls back to device credential — cancelled',
        () async {
      service.forceLock();

      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(named: 'options'),
          )).thenAnswer((_) async => false);

      final result = await service.attemptUnlock();

      expect(result, equals(UnlockResult.cancelled));
      // Lock should remain.
      expect(service.isLocked, isTrue);
    });

    test('biometric exception falls back to device credential', () async {
      service.forceLock();

      var callCount = 0;
      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(named: 'options'),
          )).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) throw Exception('Biometric sensor error');
        return true; // device credential succeeds
      });

      final result = await service.attemptUnlock();

      expect(result, equals(UnlockResult.success));
      expect(service.isLocked, isFalse);
    });
  });

  // -------------------------------------------------------------------------
  // attemptUnlock — Tier 2 (deviceCredential)
  // -------------------------------------------------------------------------
  group('attemptUnlock — deviceCredential tier', () {
    setUp(() {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.deviceCredential);
    });

    test('device credential success returns success and clears lock',
        () async {
      service.forceLock();

      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(named: 'options'),
          )).thenAnswer((_) async => true);

      final result = await service.attemptUnlock();

      expect(result, equals(UnlockResult.success));
      expect(service.isLocked, isFalse);

      // Verify biometricOnly: false was used.
      verify(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: false,
            ),
          )).called(1);
    });

    test('device credential failure returns cancelled', () async {
      service.forceLock();

      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(named: 'options'),
          )).thenAnswer((_) async => false);

      final result = await service.attemptUnlock();

      expect(result, equals(UnlockResult.cancelled));
      expect(service.isLocked, isTrue);
    });

    test('device credential exception returns failed', () async {
      service.forceLock();

      when(() => mockLocalAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(named: 'options'),
          )).thenThrow(Exception('Platform error'));

      final result = await service.attemptUnlock();

      expect(result, equals(UnlockResult.failed));
      expect(service.isLocked, isTrue);
    });
  });

  // -------------------------------------------------------------------------
  // attemptUnlock — Tier 3 (inAppPin)
  // -------------------------------------------------------------------------
  group('attemptUnlock — inAppPin tier', () {
    setUp(() {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.inAppPin);
    });

    test('correct PIN returns success and clears lock', () async {
      service.forceLock();

      when(() => mockPinManager.verifyPin('1397'))
          .thenAnswer((_) async => PinVerifyResult.success);

      final result = await service.attemptUnlock(pin: '1397');

      expect(result, equals(UnlockResult.success));
      expect(service.isLocked, isFalse);
    });

    test('wrong PIN returns failed', () async {
      service.forceLock();

      when(() => mockPinManager.verifyPin('0000'))
          .thenAnswer((_) async => PinVerifyResult.incorrect);

      final result = await service.attemptUnlock(pin: '0000');

      expect(result, equals(UnlockResult.failed));
      expect(service.isLocked, isTrue);
    });

    test('PIN lockout returns requiresFullReauth', () async {
      service.forceLock();

      when(() => mockPinManager.verifyPin('0000'))
          .thenAnswer((_) async => PinVerifyResult.lockedOut);

      final result = await service.attemptUnlock(pin: '0000');

      expect(result, equals(UnlockResult.requiresFullReauth));
      expect(service.isLocked, isTrue);
    });

    test('no PIN set returns requiresFullReauth', () async {
      service.forceLock();

      when(() => mockPinManager.verifyPin('1397'))
          .thenAnswer((_) async => PinVerifyResult.noPinSet);

      final result = await service.attemptUnlock(pin: '1397');

      expect(result, equals(UnlockResult.requiresFullReauth));
    });

    test('null pin returns failed without calling pinManager', () async {
      service.forceLock();

      final result = await service.attemptUnlock(); // pin: null

      expect(result, equals(UnlockResult.failed));
      verifyNever(() => mockPinManager.verifyPin(any()));
    });
  });

  // -------------------------------------------------------------------------
  // attemptUnlock — Tier 4 (otpOnly)
  // -------------------------------------------------------------------------
  group('attemptUnlock — otpOnly tier', () {
    test('always returns requiresFullReauth', () async {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.otpOnly);

      final result = await service.attemptUnlock();

      expect(result, equals(UnlockResult.requiresFullReauth));
    });
  });

  // -------------------------------------------------------------------------
  // getRemainingPinAttempts
  // -------------------------------------------------------------------------
  group('getRemainingPinAttempts', () {
    test('delegates to PinManager.getRemainingAttempts()', () async {
      when(() => mockPinManager.getRemainingAttempts())
          .thenAnswer((_) async => 3);

      final remaining = await service.getRemainingPinAttempts();

      expect(remaining, equals(3));
      verify(() => mockPinManager.getRemainingAttempts()).called(1);
    });
  });

  // -------------------------------------------------------------------------
  // getCapabilityTier
  // -------------------------------------------------------------------------
  group('getCapabilityTier', () {
    test('delegates to DeviceCapabilityService.detectCapabilityTier()',
        () async {
      when(() => mockCapabilityService.detectCapabilityTier())
          .thenAnswer((_) async => AuthCapabilityTier.biometric);

      final tier = await service.getCapabilityTier();

      expect(tier, equals(AuthCapabilityTier.biometric));
      verify(() => mockCapabilityService.detectCapabilityTier()).called(1);
    });
  });
}
