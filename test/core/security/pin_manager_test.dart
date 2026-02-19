import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/security/pin_manager.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// In-memory FlutterSecureStorage backed by a simple Map.
// Uses the same pattern as e2ee integration tests — REAL PinManager logic,
// fake storage layer.
// ---------------------------------------------------------------------------
class _InMemorySecureStorage extends Mock implements FlutterSecureStorage {
  final Map<String, String> _store = {};

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) _store[key] = value;
  }

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async =>
      _store.remove(key);

  /// Expose the backing store for assertions that need to inspect raw data.
  Map<String, String> get store => _store;
}

void main() {
  late _InMemorySecureStorage storage;
  late PinManager pinManager;

  setUp(() {
    storage = _InMemorySecureStorage();
    pinManager = PinManager(storage);
  });

  // -----------------------------------------------------------------------
  // setPin
  // -----------------------------------------------------------------------
  group('setPin', () {
    test('accepts a valid 4-digit PIN (1397)', () async {
      final result = await pinManager.setPin('1397');
      expect(result, isTrue);
    });

    test('accepts a valid 5-digit PIN (13579)', () async {
      final result = await pinManager.setPin('13579');
      expect(result, isTrue);
    });

    test('accepts a valid 6-digit PIN (135792)', () async {
      final result = await pinManager.setPin('135792');
      expect(result, isTrue);
    });

    test('rejects PIN shorter than 4 digits', () async {
      final result = await pinManager.setPin('123');
      expect(result, isFalse);
    });

    test('rejects PIN longer than 6 digits', () async {
      final result = await pinManager.setPin('1234567');
      expect(result, isFalse);
    });

    test('rejects all-same digits (1111)', () async {
      final result = await pinManager.setPin('1111');
      expect(result, isFalse);
    });

    test('rejects all-same 6 digits (000000)', () async {
      final result = await pinManager.setPin('000000');
      expect(result, isFalse);
    });

    test('rejects sequential ascending (1234)', () async {
      final result = await pinManager.setPin('1234');
      expect(result, isFalse);
    });

    test('rejects sequential descending (4321)', () async {
      final result = await pinManager.setPin('4321');
      expect(result, isFalse);
    });

    test('rejects non-numeric PIN (12ab)', () async {
      final result = await pinManager.setPin('12ab');
      expect(result, isFalse);
    });

    test('stores hash and salt in storage after successful setPin', () async {
      await pinManager.setPin('1397');

      final hash = storage.store['imali_pin_hash'];
      final salt = storage.store['imali_pin_salt'];

      expect(hash, isNotNull);
      expect(hash, isNotEmpty);
      expect(salt, isNotNull);
      expect(salt, isNotEmpty);
      // Hash should be a hex string (SHA-256 HMAC → 64 hex chars)
      expect(hash!.length, equals(64));
    });
  });

  // -----------------------------------------------------------------------
  // verifyPin
  // -----------------------------------------------------------------------
  group('verifyPin', () {
    test('returns success for the correct PIN', () async {
      await pinManager.setPin('1397');
      final result = await pinManager.verifyPin('1397');
      expect(result, equals(PinVerifyResult.success));
    });

    test('returns incorrect for the wrong PIN', () async {
      await pinManager.setPin('1397');
      final result = await pinManager.verifyPin('9999');
      expect(result, equals(PinVerifyResult.incorrect));
    });

    test('returns noPinSet when no PIN has been stored', () async {
      final result = await pinManager.verifyPin('1397');
      expect(result, equals(PinVerifyResult.noPinSet));
    });

    test('resets failed attempts on successful verification', () async {
      await pinManager.setPin('1397');

      // Fail twice
      await pinManager.verifyPin('0000');
      await pinManager.verifyPin('0000');
      expect(await pinManager.getRemainingAttempts(), equals(3));

      // Succeed — attempts should reset
      await pinManager.verifyPin('1397');
      expect(await pinManager.getRemainingAttempts(), equals(5));
    });

    test('increments failed attempts on each wrong verification', () async {
      await pinManager.setPin('1397');

      await pinManager.verifyPin('0000');
      expect(await pinManager.getRemainingAttempts(), equals(4));

      await pinManager.verifyPin('0000');
      expect(await pinManager.getRemainingAttempts(), equals(3));
    });

    test('returns lockedOut after 5 consecutive failures', () async {
      await pinManager.setPin('1397');

      for (int i = 0; i < 4; i++) {
        final r = await pinManager.verifyPin('0000');
        expect(r, equals(PinVerifyResult.incorrect));
      }

      // 5th failure should trigger lockout
      final lockedResult = await pinManager.verifyPin('0000');
      expect(lockedResult, equals(PinVerifyResult.lockedOut));
    });

    test('lockout persists within the 30-minute window', () async {
      await pinManager.setPin('1397');

      // Exhaust all attempts
      for (int i = 0; i < 5; i++) {
        await pinManager.verifyPin('0000');
      }

      // Even the correct PIN should be rejected while locked out
      final result = await pinManager.verifyPin('1397');
      expect(result, equals(PinVerifyResult.lockedOut));
    });
  });

  // -----------------------------------------------------------------------
  // isPinSet
  // -----------------------------------------------------------------------
  group('isPinSet', () {
    test('returns false when no PIN has been set', () async {
      expect(await pinManager.isPinSet(), isFalse);
    });

    test('returns true after setPin succeeds', () async {
      await pinManager.setPin('1397');
      expect(await pinManager.isPinSet(), isTrue);
    });
  });

  // -----------------------------------------------------------------------
  // changePin
  // -----------------------------------------------------------------------
  group('changePin', () {
    test('succeeds with correct old PIN and valid new PIN', () async {
      await pinManager.setPin('1397');

      final result = await pinManager.changePin('1397', '8642');
      expect(result, isTrue);

      // New PIN should work
      final verify = await pinManager.verifyPin('8642');
      expect(verify, equals(PinVerifyResult.success));

      // Old PIN should no longer work
      final verifyOld = await pinManager.verifyPin('1397');
      expect(verifyOld, equals(PinVerifyResult.incorrect));
    });

    test('fails with wrong old PIN', () async {
      await pinManager.setPin('1397');
      final result = await pinManager.changePin('9999', '8642');
      expect(result, isFalse);

      // Original PIN should still work
      final verify = await pinManager.verifyPin('1397');
      expect(verify, equals(PinVerifyResult.success));
    });

    test('fails if the new PIN is weak', () async {
      await pinManager.setPin('1397');
      final result = await pinManager.changePin('1397', '1111');
      expect(result, isFalse);

      // Original PIN should still work (setPin returned false, no overwrite)
      final verify = await pinManager.verifyPin('1397');
      expect(verify, equals(PinVerifyResult.success));
    });
  });

  // -----------------------------------------------------------------------
  // getRemainingAttempts
  // -----------------------------------------------------------------------
  group('getRemainingAttempts', () {
    test('returns maxFailedAttempts (5) initially', () async {
      expect(await pinManager.getRemainingAttempts(), equals(5));
    });

    test('decrements by one on each failed verification', () async {
      await pinManager.setPin('1397');

      await pinManager.verifyPin('0000');
      expect(await pinManager.getRemainingAttempts(), equals(4));

      await pinManager.verifyPin('0000');
      expect(await pinManager.getRemainingAttempts(), equals(3));
    });
  });

  // -----------------------------------------------------------------------
  // clearPin
  // -----------------------------------------------------------------------
  group('clearPin', () {
    test('removes hash, salt, and attempt counters from storage', () async {
      await pinManager.setPin('1397');
      // Generate some failed attempts too
      await pinManager.verifyPin('0000');

      await pinManager.clearPin();

      expect(storage.store['imali_pin_hash'], isNull);
      expect(storage.store['imali_pin_salt'], isNull);
      expect(storage.store['imali_pin_failed_attempts'], isNull);
      expect(storage.store['imali_pin_locked_until'], isNull);
    });

    test('isPinSet returns false after clearPin', () async {
      await pinManager.setPin('1397');
      expect(await pinManager.isPinSet(), isTrue);

      await pinManager.clearPin();
      expect(await pinManager.isPinSet(), isFalse);
    });
  });
}
