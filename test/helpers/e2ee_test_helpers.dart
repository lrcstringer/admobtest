import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:imalichat/core/services/crypto_service.dart';
import 'package:imalichat/core/services/key_backup_service.dart';
import 'package:imalichat/core/services/key_management_service.dart';
import 'package:imalichat/core/services/sender_key_service.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';
import 'package:imalichat/domain/entities/e2ee_types.dart';
import 'package:imalichat/domain/entities/message.dart';
import 'package:imalichat/domain/enums/message_status.dart';
import 'package:imalichat/domain/enums/message_type.dart';
import 'package:mocktail/mocktail.dart';

// ==================== MOCKS ====================

class MockCryptoService extends Mock implements CryptoService {}

class MockKeyManagementService extends Mock implements KeyManagementService {}

class MockSignalProtocolService extends Mock implements SignalProtocolService {}

class MockSenderKeyService extends Mock implements SenderKeyService {}

class MockKeyBackupService extends Mock implements KeyBackupService {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

class MockHttpsCallable extends Mock implements HttpsCallable {}

class MockHttpsCallableResult extends Mock
    implements HttpsCallableResult<dynamic> {}

// ==================== MOCK DEPENDENCY CONTAINER ====================

class MockE2EEDependencies {
  late MockCryptoService cryptoService;
  late MockKeyManagementService keyManagementService;
  late MockSignalProtocolService signalProtocolService;
  late MockSenderKeyService senderKeyService;
  late MockKeyBackupService keyBackupService;
  late MockFlutterSecureStorage secureStorage;
  late MockFirebaseFunctions functions;
  late MockHttpsCallable httpsCallable;
  late MockHttpsCallableResult callableResult;

  MockE2EEDependencies() {
    cryptoService = MockCryptoService();
    keyManagementService = MockKeyManagementService();
    signalProtocolService = MockSignalProtocolService();
    senderKeyService = MockSenderKeyService();
    keyBackupService = MockKeyBackupService();
    secureStorage = MockFlutterSecureStorage();
    functions = MockFirebaseFunctions();
    httpsCallable = MockHttpsCallable();
    callableResult = MockHttpsCallableResult();
  }
}

// ==================== TEST FIXTURES ====================

class E2EETestData {
  E2EETestData._();

  // ---- IDs ----
  static const testUserId = 'alice_user_id';
  static const testRecipientId = 'bob_user_id';
  static const testCommunityId = 'community_123';
  static const testMessageId = 'msg_001';
  static const testConversationId = 'conv_abc';

  // ---- Key Bundles ----
  static KeyBundle createTestKeyBundle({
    String? identityKeyPair,
    int registrationId = 12345,
  }) =>
      KeyBundle(
        identityKeyPair: identityKeyPair ?? 'cHJpdmF0ZUtleQ==|cHVibGljS2V5',
        signedPreKey: 'c2lnbmVkUHJlS2V5UHJpdmF0ZQ==|c2lnbmVkUHJlS2V5UHVibGlj',
        signedPreKeySignature: 'c2lnbmF0dXJl',
        oneTimePreKeys: [
          'b3RrMVByaXY=|b3RrMVB1Yg==',
          'b3RrMlByaXY=|b3RrMlB1Yg==',
          'b3RrM1ByaXY=|b3RrM1B1Yg==',
        ],
        registrationId: registrationId,
      );

  static PublicKeyBundle createTestPublicKeyBundle({
    String userId = testRecipientId,
  }) =>
      PublicKeyBundle(
        identityKey: 'cHVibGljS2V5',
        signedPreKey: 'c2lnbmVkUHJlS2V5UHVibGlj',
        signedPreKeySignature: 'c2lnbmF0dXJl',
        oneTimePreKeys: ['b3RrMVB1Yg=='],
        registrationId: 67890,
        userId: userId,
      );

  static BackupMetadata createTestBackupMetadata({
    bool backupExists = true,
    String userId = testUserId,
  }) =>
      BackupMetadata(
        backupExists: backupExists,
        lastBackupAt: DateTime(2024, 6, 1),
        backupVersion: 1,
        userId: userId,
      );

  // ---- E2EE Metadata ----
  static E2eeMetadata createSignalMetadata({
    int messageNumber = 0,
    String? dhPublicKey,
  }) =>
      E2eeMetadata(
        protocol: 'signal-v2',
        messageNumber: messageNumber,
        dhPublicKey: dhPublicKey ?? 'ZGhQdWJsaWNLZXk=',
      );

  static E2eeMetadata createSenderKeyMetadata({
    int messageNumber = 0,
    String? senderKeyChainId,
  }) =>
      E2eeMetadata(
        protocol: 'sender-key-v2',
        senderKeyChainId: senderKeyChainId ?? 'chain_abc',
        messageNumber: messageNumber,
      );

  static X3dhHeader createX3dhHeader({int? otkId}) => X3dhHeader(
        identityKey: 'aWRlbnRpdHlLZXk=',
        ephemeralKey: 'ZXBoZW1lcmFsS2V5',
        oneTimePreKeyId: otkId ?? 0,
      );

  // ---- Messages ----
  static Message createPlaintextMessage({
    String id = testMessageId,
    String senderId = testUserId,
    String? textContent,
  }) =>
      Message(
        id: id,
        senderId: senderId,
        senderName: 'Alice',
        type: MessageType.text,
        status: MessageStatus.sent,
        textContent: textContent ?? 'Hello, world!',
        createdAt: DateTime(2024, 6, 1, 12, 0),
      );

  static Message createEncryptedMessage({
    String id = testMessageId,
    String senderId = testUserId,
    String? ciphertext,
    E2eeMetadata? e2ee,
    X3dhHeader? x3dhHeader,
  }) =>
      Message(
        id: id,
        senderId: senderId,
        senderName: 'Alice',
        type: MessageType.text,
        status: MessageStatus.sent,
        textContent: null,
        ciphertext: ciphertext ?? 'ZW5jcnlwdGVkRGF0YQ==',
        e2ee: e2ee ?? createSignalMetadata(),
        x3dhHeader: x3dhHeader,
        createdAt: DateTime(2024, 6, 1, 12, 0),
      );

  static Message createDecryptionFailedMessage({
    String senderId = testRecipientId,
  }) =>
      Message(
        id: 'msg_decrypt_fail',
        senderId: senderId,
        senderName: 'Bob',
        type: MessageType.text,
        status: MessageStatus.sent,
        textContent: '[Cannot decrypt]',
        ciphertext: 'ZW5jcnlwdGVkRGF0YQ==',
        e2ee: createSignalMetadata(),
        createdAt: DateTime(2024, 6, 1, 12, 0),
      );

  static Message createWaitingForKeyMessage({
    String senderId = testRecipientId,
  }) =>
      Message(
        id: 'msg_waiting_key',
        senderId: senderId,
        senderName: 'Bob',
        type: MessageType.text,
        status: MessageStatus.sent,
        textContent: '[Waiting for encryption key...]',
        ciphertext: 'ZW5jcnlwdGVkRGF0YQ==',
        e2ee: createSenderKeyMetadata(),
        createdAt: DateTime(2024, 6, 1, 12, 0),
      );

  static Message createTokenSendMessage({
    bool isMe = true,
    int amount = 500,
  }) =>
      Message(
        id: 'msg_token_send',
        senderId: isMe ? testUserId : testRecipientId,
        senderName: isMe ? 'Alice' : 'Bob',
        type: MessageType.tokenSend,
        status: MessageStatus.sent,
        textContent: 'Here are your tokens!',
        tokenAmount: amount,
        recipientId: isMe ? testRecipientId : testUserId,
        createdAt: DateTime(2024, 6, 1, 12, 0),
      );

  static Message createSystemMessage({String? text}) => Message(
        id: 'msg_system',
        senderId: 'system',
        senderName: 'System',
        type: MessageType.system,
        status: MessageStatus.sent,
        textContent: text ?? 'Alice joined the conversation',
        createdAt: DateTime(2024, 6, 1, 12, 0),
      );

  static Message createMediaMessage({
    bool encrypted = false,
    MessageType type = MessageType.image,
  }) =>
      Message(
        id: 'msg_media',
        senderId: testUserId,
        senderName: 'Alice',
        type: type,
        status: MessageStatus.sent,
        media: MessageMedia(
          url: 'https://example.com/image.jpg',
          thumbnailUrl: 'https://example.com/image_thumb.jpg',
          fileName: 'image.jpg',
          fileSize: 1024,
          mimeType: 'image/jpeg',
          mediaKey: encrypted ? 'bWVkaWFLZXk=' : null,
          thumbKey: encrypted ? 'dGh1bWJLZXk=' : null,
        ),
        ciphertext: encrypted ? 'ZW5jcnlwdGVk' : null,
        e2ee: encrypted ? createSignalMetadata() : null,
        createdAt: DateTime(2024, 6, 1, 12, 0),
      );

  // ---- Crypto helpers ----
  static Uint8List testKey32 = Uint8List.fromList(List.generate(32, (i) => i));
  static Uint8List testKey16 = Uint8List.fromList(List.generate(16, (i) => i));
  static Uint8List testNonce12 =
      Uint8List.fromList(List.generate(12, (i) => i));
  static Uint8List testData =
      Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

  /// Simulates AES-GCM encrypted output: nonce(12) + ciphertext(n) + mac(16)
  static Uint8List createFakeEncryptedOutput({int plaintextLength = 10}) {
    final nonce = List.generate(12, (i) => i);
    final ct = List.generate(plaintextLength, (i) => i + 100);
    final mac = List.generate(16, (i) => i + 200);
    return Uint8List.fromList(nonce + ct + mac);
  }
}
