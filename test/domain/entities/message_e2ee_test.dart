import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/message.dart';
import 'package:imalichat/domain/enums/message_type.dart';
import 'package:imalichat/domain/enums/message_status.dart';

import '../../helpers/e2ee_test_helpers.dart';

void main() {
  group('Message E2EE properties', () {
    // ---- isEncrypted ----

    test('isEncrypted returns true when ciphertext is non-null', () {
      final message = E2EETestData.createEncryptedMessage();

      expect(message.isEncrypted, isTrue);
      expect(message.ciphertext, isNotNull);
    });

    test('isEncrypted returns false when ciphertext is null', () {
      final message = E2EETestData.createPlaintextMessage();

      expect(message.isEncrypted, isFalse);
      expect(message.ciphertext, isNull);
    });

    // ---- isSystem ----

    test('isSystem returns true for system type', () {
      final message = E2EETestData.createSystemMessage();

      expect(message.isSystem, isTrue);
      expect(message.type, MessageType.system);
    });

    // ---- isTokenTransfer ----

    test('isTokenTransfer returns true for tokenSend type', () {
      final message = E2EETestData.createTokenSendMessage();

      expect(message.isTokenTransfer, isTrue);
      expect(message.type, MessageType.tokenSend);
    });

    test('isTokenTransfer returns true for tokenRequest type', () {
      final message = Message(
        id: 'msg_token_req',
        senderId: E2EETestData.testRecipientId,
        senderName: 'Bob',
        type: MessageType.tokenRequest,
        status: MessageStatus.sent,
        textContent: 'Please send me 100 tokens',
        tokenAmount: 100,
        recipientId: E2EETestData.testUserId,
        createdAt: DateTime(2024, 6, 1, 12, 0),
      );

      expect(message.isTokenTransfer, isTrue);
      expect(message.type, MessageType.tokenRequest);
    });

    // ---- hasMedia ----

    test('hasMedia returns true when media is non-null', () {
      final message = E2EETestData.createMediaMessage();

      expect(message.hasMedia, isTrue);
      expect(message.media, isNotNull);
    });

    // ---- totalReactions ----

    test('totalReactions counts all reaction entries across emoji types', () {
      final message = E2EETestData.createPlaintextMessage().copyWith(
        reactions: {
          '👍': ['user1', 'user2', 'user3'],
          '❤️': ['user1', 'user4'],
          '😂': ['user5'],
        },
      );

      expect(message.totalReactions, 6);
    });

    // ---- E2eeMetadata construction ----

    test('E2eeMetadata can be created with all fields', () {
      final metadata = E2eeMetadata(
        protocol: 'signal-v1',
        senderKeyChainId: 'chain_xyz',
        messageNumber: 42,
        dhPublicKey: 'ZGhQdWJsaWNLZXk=',
      );

      expect(metadata.protocol, 'signal-v1');
      expect(metadata.senderKeyChainId, 'chain_xyz');
      expect(metadata.messageNumber, 42);
      expect(metadata.dhPublicKey, 'ZGhQdWJsaWNLZXk=');
    });

    // ---- X3dhHeader construction ----

    test('X3dhHeader can be created with all fields', () {
      final header = X3dhHeader(
        identityKey: 'aWRlbnRpdHlLZXk=',
        ephemeralKey: 'ZXBoZW1lcmFsS2V5',
        oneTimePreKeyId: 7,
      );

      expect(header.identityKey, 'aWRlbnRpdHlLZXk=');
      expect(header.ephemeralKey, 'ZXBoZW1lcmFsS2V5');
      expect(header.oneTimePreKeyId, 7);
    });

    // ---- copyWith preserves E2EE fields ----

    test('copyWith preserves E2EE fields when other fields are changed', () {
      final original = E2EETestData.createEncryptedMessage(
        ciphertext: 'c29tZUNpcGhlcnRleHQ=',
        e2ee: E2EETestData.createSignalMetadata(messageNumber: 5),
        x3dhHeader: E2EETestData.createX3dhHeader(otkId: 2),
      );

      final copied = original.copyWith(status: MessageStatus.sent);

      expect(copied.ciphertext, 'c29tZUNpcGhlcnRleHQ=');
      expect(copied.e2ee, isNotNull);
      expect(copied.e2ee!.protocol, 'signal-v1');
      expect(copied.e2ee!.messageNumber, 5);
      expect(copied.x3dhHeader, isNotNull);
      expect(copied.x3dhHeader!.identityKey, 'aWRlbnRpdHlLZXk=');
      expect(copied.x3dhHeader!.oneTimePreKeyId, 2);
    });

    // ---- copyWith can override textContent (decrypt flow) ----

    test('copyWith can override textContent used in decrypt flow', () {
      final encrypted = E2EETestData.createEncryptedMessage(
        ciphertext: 'ZW5jcnlwdGVkRGF0YQ==',
      );

      // Simulate decryption: set textContent while keeping ciphertext
      final decrypted = encrypted.copyWith(
        textContent: 'Hello, this is the decrypted message!',
      );

      expect(decrypted.textContent, 'Hello, this is the decrypted message!');
      expect(decrypted.ciphertext, 'ZW5jcnlwdGVkRGF0YQ==');
      expect(decrypted.isEncrypted, isTrue);
    });

    // ---- MessageMedia includes mediaKey and thumbKey ----

    test('MessageMedia includes mediaKey and thumbKey for encrypted media', () {
      final message = E2EETestData.createMediaMessage(encrypted: true);

      expect(message.media, isNotNull);
      expect(message.media!.mediaKey, 'bWVkaWFLZXk=');
      expect(message.media!.thumbKey, 'dGh1bWJLZXk=');
      expect(message.isEncrypted, isTrue);
    });
  });
}
