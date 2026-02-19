import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/e2ee_types.dart';
import 'package:imalichat/domain/entities/message.dart';

import '../../helpers/e2ee_test_helpers.dart';

void main() {
  // ==================== KeyBundle ====================

  group('KeyBundle', () {
    test('can be created with all fields', () {
      final bundle = E2EETestData.createTestKeyBundle();

      expect(bundle.identityKeyPair, isNotEmpty);
      expect(bundle.signedPreKey, isNotEmpty);
      expect(bundle.signedPreKeySignature, isNotEmpty);
      expect(bundle.oneTimePreKeys, isNotEmpty);
      expect(bundle.registrationId, 12345);
    });

    test('identityKeyPair is non-empty', () {
      final bundle = E2EETestData.createTestKeyBundle(
        identityKeyPair: 'Y3VzdG9tSWRLZXlQYWly',
      );

      expect(bundle.identityKeyPair, 'Y3VzdG9tSWRLZXlQYWly');
      expect(bundle.identityKeyPair, isNotEmpty);
    });

    test('signedPreKey is non-empty', () {
      final bundle = E2EETestData.createTestKeyBundle();

      expect(bundle.signedPreKey, isNotEmpty);
      expect(bundle.signedPreKeySignature, isNotEmpty);
    });

    test('oneTimePreKeys contains expected keys', () {
      final bundle = E2EETestData.createTestKeyBundle();

      expect(bundle.oneTimePreKeys, hasLength(3));
      expect(bundle.oneTimePreKeys[0], contains('b3RrMV'));
    });

    test('registrationId stores correct value', () {
      final bundle = E2EETestData.createTestKeyBundle(registrationId: 99999);

      expect(bundle.registrationId, 99999);
    });

    test('fromJson/toJson roundtrip preserves all fields', () {
      final original = E2EETestData.createTestKeyBundle();
      final json = original.toJson();
      final restored = KeyBundle.fromJson(json);

      expect(restored, original);
      expect(restored.identityKeyPair, original.identityKeyPair);
      expect(restored.signedPreKey, original.signedPreKey);
      expect(restored.signedPreKeySignature, original.signedPreKeySignature);
      expect(restored.oneTimePreKeys, original.oneTimePreKeys);
      expect(restored.registrationId, original.registrationId);
    });

    test('equality compares all fields', () {
      final a = E2EETestData.createTestKeyBundle();
      final b = E2EETestData.createTestKeyBundle();
      final different = E2EETestData.createTestKeyBundle(registrationId: 11111);

      expect(a, equals(b));
      expect(a, isNot(equals(different)));
    });
  });

  // ==================== PublicKeyBundle ====================

  group('PublicKeyBundle', () {
    test('can be created with all fields', () {
      final bundle = E2EETestData.createTestPublicKeyBundle();

      expect(bundle.identityKey, isNotEmpty);
      expect(bundle.signedPreKey, isNotEmpty);
      expect(bundle.signedPreKeySignature, isNotEmpty);
      expect(bundle.oneTimePreKeys, isNotEmpty);
      expect(bundle.registrationId, 67890);
      expect(bundle.userId, E2EETestData.testRecipientId);
    });

    test('contains only public key halves (no private key material)', () {
      final bundle = E2EETestData.createTestPublicKeyBundle();

      // Public bundle fields should be single base64 values (no pipe separator
      // used by private key pairs which encode private|public)
      expect(bundle.identityKey, isNot(contains('|')));
    });

    test('identityKey is present and non-empty', () {
      final bundle = E2EETestData.createTestPublicKeyBundle();

      expect(bundle.identityKey, 'cHVibGljS2V5');
      expect(bundle.identityKey, isNotEmpty);
    });

    test('signedPreKey and signature are both present', () {
      final bundle = E2EETestData.createTestPublicKeyBundle();

      expect(bundle.signedPreKey, isNotEmpty);
      expect(bundle.signedPreKeySignature, isNotEmpty);
    });

    test('oneTimePreKeys list contains available keys', () {
      final bundle = E2EETestData.createTestPublicKeyBundle();

      expect(bundle.oneTimePreKeys, hasLength(1));
      expect(bundle.oneTimePreKeys.first, 'b3RrMVB1Yg==');
    });

    test('userId identifies the bundle owner', () {
      final bundle = E2EETestData.createTestPublicKeyBundle(
        userId: 'custom_user_42',
      );

      expect(bundle.userId, 'custom_user_42');
    });

    test('fromJson/toJson roundtrip preserves all fields', () {
      final original = E2EETestData.createTestPublicKeyBundle();
      final json = original.toJson();
      final restored = PublicKeyBundle.fromJson(json);

      expect(restored, original);
      expect(restored.identityKey, original.identityKey);
      expect(restored.signedPreKey, original.signedPreKey);
      expect(restored.signedPreKeySignature, original.signedPreKeySignature);
      expect(restored.oneTimePreKeys, original.oneTimePreKeys);
      expect(restored.registrationId, original.registrationId);
      expect(restored.userId, original.userId);
    });

    test('equality compares all fields', () {
      final a = E2EETestData.createTestPublicKeyBundle();
      final b = E2EETestData.createTestPublicKeyBundle();
      final different = E2EETestData.createTestPublicKeyBundle(
        userId: 'different_user',
      );

      expect(a, equals(b));
      expect(a, isNot(equals(different)));
    });
  });

  // ==================== BackupMetadata ====================

  group('BackupMetadata', () {
    test('can be created with all fields', () {
      final meta = E2EETestData.createTestBackupMetadata();

      expect(meta.backupExists, isTrue);
      expect(meta.lastBackupAt, isNotNull);
      expect(meta.backupVersion, 1);
      expect(meta.userId, E2EETestData.testUserId);
    });

    test('backupExists flag reflects backup state', () {
      final exists = E2EETestData.createTestBackupMetadata(backupExists: true);
      final noBackup =
          E2EETestData.createTestBackupMetadata(backupExists: false);

      expect(exists.backupExists, isTrue);
      expect(noBackup.backupExists, isFalse);
    });

    test('lastBackupAt is optional and can be null', () {
      final meta = BackupMetadata(
        backupExists: false,
        lastBackupAt: null,
        userId: 'user_1',
      );

      expect(meta.lastBackupAt, isNull);
    });

    test('backupVersion is optional and can be null', () {
      final meta = BackupMetadata(
        backupExists: false,
        backupVersion: null,
        userId: 'user_1',
      );

      expect(meta.backupVersion, isNull);
    });

    test('fromJson/toJson roundtrip preserves all fields', () {
      final original = E2EETestData.createTestBackupMetadata();
      final json = original.toJson();
      final restored = BackupMetadata.fromJson(json);

      expect(restored, original);
      expect(restored.backupExists, original.backupExists);
      expect(restored.lastBackupAt, original.lastBackupAt);
      expect(restored.backupVersion, original.backupVersion);
      expect(restored.userId, original.userId);
    });

    test('equality compares all fields', () {
      final a = E2EETestData.createTestBackupMetadata();
      final b = E2EETestData.createTestBackupMetadata();
      final different =
          E2EETestData.createTestBackupMetadata(userId: 'other_user');

      expect(a, equals(b));
      expect(a, isNot(equals(different)));
    });
  });

  // ==================== E2eeMetadata ====================

  group('E2eeMetadata', () {
    test('protocol is required and set correctly', () {
      final metadata = E2EETestData.createSignalMetadata();

      expect(metadata.protocol, 'signal-v1');
    });

    test('senderKeyChainId is optional', () {
      final withChain = E2EETestData.createSenderKeyMetadata(
        senderKeyChainId: 'chain_abc',
      );
      final without = E2EETestData.createSignalMetadata();

      expect(withChain.senderKeyChainId, 'chain_abc');
      expect(without.senderKeyChainId, isNull);
    });

    test('messageNumber is optional', () {
      final with42 = E2EETestData.createSignalMetadata(messageNumber: 42);
      final withNull = const E2eeMetadata(protocol: 'signal-v1');

      expect(with42.messageNumber, 42);
      expect(withNull.messageNumber, isNull);
    });

    test('dhPublicKey is optional', () {
      final withKey = E2EETestData.createSignalMetadata(
        dhPublicKey: 'Y3VzdG9tREhLZXk=',
      );
      final withoutKey = const E2eeMetadata(protocol: 'signal-v1');

      expect(withKey.dhPublicKey, 'Y3VzdG9tREhLZXk=');
      expect(withoutKey.dhPublicKey, isNull);
    });

    test('fromJson/toJson roundtrip preserves all fields', () {
      final original = E2eeMetadata(
        protocol: 'signal-v1',
        senderKeyChainId: 'chain_roundtrip',
        messageNumber: 99,
        dhPublicKey: 'ZGhLZXk=',
      );
      final json = original.toJson();
      final restored = E2eeMetadata.fromJson(json);

      expect(restored, original);
      expect(restored.protocol, original.protocol);
      expect(restored.senderKeyChainId, original.senderKeyChainId);
      expect(restored.messageNumber, original.messageNumber);
      expect(restored.dhPublicKey, original.dhPublicKey);
    });
  });

  // ==================== X3dhHeader ====================

  group('X3dhHeader', () {
    test('identityKey and ephemeralKey are required', () {
      final header = E2EETestData.createX3dhHeader();

      expect(header.identityKey, 'aWRlbnRpdHlLZXk=');
      expect(header.ephemeralKey, 'ZXBoZW1lcmFsS2V5');
    });

    test('oneTimePreKeyId is optional', () {
      final withOtk = E2EETestData.createX3dhHeader(otkId: 5);
      final withoutOtk = const X3dhHeader(
        identityKey: 'aWRlbnRpdHlLZXk=',
        ephemeralKey: 'ZXBoZW1lcmFsS2V5',
      );

      expect(withOtk.oneTimePreKeyId, 5);
      expect(withoutOtk.oneTimePreKeyId, isNull);
    });

    test('fromJson/toJson roundtrip preserves all fields', () {
      final original = E2EETestData.createX3dhHeader(otkId: 3);
      final json = original.toJson();
      final restored = X3dhHeader.fromJson(json);

      expect(restored, original);
      expect(restored.identityKey, original.identityKey);
      expect(restored.ephemeralKey, original.ephemeralKey);
      expect(restored.oneTimePreKeyId, original.oneTimePreKeyId);
    });
  });
}
