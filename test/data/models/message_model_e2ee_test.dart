import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/message_model.dart';
import 'package:imalichat/domain/entities/message.dart';
import '../../helpers/e2ee_test_helpers.dart';

void main() {
  // =========================================================================
  // SHARED FIXTURES
  // =========================================================================

  final fixedDate = DateTime(2024, 6, 1, 12, 0);
  final fixedDateIso = fixedDate.toIso8601String();

  Map<String, dynamic> baseTextJson({
    Map<String, dynamic>? overrides,
  }) {
    return {
      'id': 'msg_001',
      'senderId': E2EETestData.testUserId,
      'senderName': 'Alice',
      'type': 'text',
      'status': 'sent',
      'textContent': 'Hello, world!',
      'createdAt': fixedDateIso,
      ...?overrides,
    };
  }

  Map<String, dynamic> fullE2eeJson() {
    return baseTextJson(overrides: {
      'textContent': null,
      'ciphertext': 'ZW5jcnlwdGVkRGF0YQ==',
      'e2ee': {
        'protocol': 'signal-v1',
        'dhPublicKey': 'ZGhQdWJsaWNLZXk=',
        'messageNumber': 42,
        'senderKeyChainId': 'chain_abc',
      },
      'x3dhHeader': {
        'identityKey': 'aWRlbnRpdHlLZXk=',
        'ephemeralKey': 'ZXBoZW1lcmFsS2V5',
        'oneTimePreKeyId': 7,
      },
    });
  }

  // =========================================================================
  // fromJson TESTS
  // =========================================================================

  group('MessageModel.fromJson — E2EE fields', () {
    test('standard text message has null E2EE fields', () {
      final model = MessageModel.fromJson(baseTextJson());

      expect(model.id, equals('msg_001'));
      expect(model.textContent, equals('Hello, world!'));
      expect(model.ciphertext, isNull);
      expect(model.e2ee, isNull);
      expect(model.x3dhHeader, isNull);
    });

    test('parses ciphertext field', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'ciphertext': 'ZW5jcnlwdGVkRGF0YQ==',
        }),
      );

      expect(model.ciphertext, equals('ZW5jcnlwdGVkRGF0YQ=='));
    });

    test('parses e2ee metadata map with all sub-fields', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'e2ee': {
            'protocol': 'signal-v1',
            'dhPublicKey': 'ZGhQdWJsaWNLZXk=',
            'messageNumber': 42,
            'senderKeyChainId': 'chain_abc',
          },
        }),
      );

      expect(model.e2ee, isNotNull);
      expect(model.e2ee!['protocol'], equals('signal-v1'));
      expect(model.e2ee!['dhPublicKey'], equals('ZGhQdWJsaWNLZXk='));
      expect(model.e2ee!['messageNumber'], equals(42));
      expect(model.e2ee!['senderKeyChainId'], equals('chain_abc'));
    });

    test('parses x3dhHeader map with all sub-fields', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'x3dhHeader': {
            'identityKey': 'aWRlbnRpdHlLZXk=',
            'ephemeralKey': 'ZXBoZW1lcmFsS2V5',
            'oneTimePreKeyId': 7,
          },
        }),
      );

      expect(model.x3dhHeader, isNotNull);
      expect(model.x3dhHeader!['identityKey'], equals('aWRlbnRpdHlLZXk='));
      expect(model.x3dhHeader!['ephemeralKey'], equals('ZXBoZW1lcmFsS2V5'));
      expect(model.x3dhHeader!['oneTimePreKeyId'], equals(7));
    });

    test('parses all E2EE fields together', () {
      final model = MessageModel.fromJson(fullE2eeJson());

      expect(model.ciphertext, equals('ZW5jcnlwdGVkRGF0YQ=='));
      expect(model.e2ee, isNotNull);
      expect(model.e2ee!['protocol'], equals('signal-v1'));
      expect(model.x3dhHeader, isNotNull);
      expect(model.x3dhHeader!['identityKey'], equals('aWRlbnRpdHlLZXk='));
    });

    test('missing ciphertext key yields null', () {
      final json = baseTextJson();
      // Key is absent entirely
      expect(json.containsKey('ciphertext'), isFalse);

      final model = MessageModel.fromJson(json);
      expect(model.ciphertext, isNull);
    });

    test('explicit null ciphertext yields null', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {'ciphertext': null}),
      );
      expect(model.ciphertext, isNull);
    });

    test('explicit null e2ee yields null', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {'e2ee': null}),
      );
      expect(model.e2ee, isNull);
    });

    test('explicit null x3dhHeader yields null', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {'x3dhHeader': null}),
      );
      expect(model.x3dhHeader, isNull);
    });

    test('media with mediaKey and thumbKey', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'type': 'image',
          'media': {
            'url': 'https://example.com/image.jpg',
            'thumbnailUrl': 'https://example.com/thumb.jpg',
            'fileName': 'image.jpg',
            'fileSize': 2048,
            'mimeType': 'image/jpeg',
            'mediaKey': 'bWVkaWFLZXk=',
            'thumbKey': 'dGh1bWJLZXk=',
          },
        }),
      );

      expect(model.media, isNotNull);
      expect(model.media!['mediaKey'], equals('bWVkaWFLZXk='));
      expect(model.media!['thumbKey'], equals('dGh1bWJLZXk='));
    });

    test('media without mediaKey and thumbKey', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'type': 'image',
          'media': {
            'url': 'https://example.com/image.jpg',
            'fileName': 'image.jpg',
            'fileSize': 2048,
            'mimeType': 'image/jpeg',
          },
        }),
      );

      expect(model.media, isNotNull);
      expect(model.media!.containsKey('mediaKey'), isFalse);
      expect(model.media!.containsKey('thumbKey'), isFalse);
    });

    test('token transfer message without E2EE', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'type': 'tokenSend',
          'tokenAmount': 500,
          'recipientId': E2EETestData.testRecipientId,
          'textContent': 'Here are your tokens!',
        }),
      );

      expect(model.type, equals('tokenSend'));
      expect(model.tokenAmount, equals(500));
      expect(model.ciphertext, isNull);
      expect(model.e2ee, isNull);
    });

    test('system message without E2EE', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'type': 'system',
          'senderId': 'system',
          'senderName': 'System',
          'textContent': 'Alice joined the conversation',
          'systemEventType': 'member_joined',
        }),
      );

      expect(model.type, equals('system'));
      expect(model.systemEventType, equals('member_joined'));
      expect(model.ciphertext, isNull);
      expect(model.e2ee, isNull);
      expect(model.x3dhHeader, isNull);
    });

    test('non-map e2ee value is treated as null', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {'e2ee': 'invalid_string'}),
      );
      expect(model.e2ee, isNull);
    });

    test('non-map x3dhHeader value is treated as null', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {'x3dhHeader': 12345}),
      );
      expect(model.x3dhHeader, isNull);
    });
  });

  // =========================================================================
  // toEntity TESTS
  // =========================================================================

  group('MessageModel.toEntity — E2EE fields', () {
    test('plaintext message entity has null E2EE fields', () {
      final model = MessageModel.fromJson(baseTextJson());
      final entity = model.toEntity();

      expect(entity.ciphertext, isNull);
      expect(entity.e2ee, isNull);
      expect(entity.x3dhHeader, isNull);
      expect(entity.isEncrypted, isFalse);
    });

    test('ciphertext maps correctly to entity', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'ciphertext': 'ZW5jcnlwdGVkRGF0YQ==',
        }),
      );
      final entity = model.toEntity();

      expect(entity.ciphertext, equals('ZW5jcnlwdGVkRGF0YQ=='));
      expect(entity.isEncrypted, isTrue);
    });

    test('e2ee metadata converts to E2eeMetadata entity', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'e2ee': {
            'protocol': 'signal-v1',
            'dhPublicKey': 'ZGhQdWJsaWNLZXk=',
            'messageNumber': 42,
            'senderKeyChainId': 'chain_abc',
          },
        }),
      );
      final entity = model.toEntity();

      expect(entity.e2ee, isNotNull);
      expect(entity.e2ee, isA<E2eeMetadata>());
      expect(entity.e2ee!.protocol, equals('signal-v1'));
      expect(entity.e2ee!.dhPublicKey, equals('ZGhQdWJsaWNLZXk='));
      expect(entity.e2ee!.messageNumber, equals(42));
      expect(entity.e2ee!.senderKeyChainId, equals('chain_abc'));
    });

    test('x3dhHeader converts to X3dhHeader entity', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'x3dhHeader': {
            'identityKey': 'aWRlbnRpdHlLZXk=',
            'ephemeralKey': 'ZXBoZW1lcmFsS2V5',
            'oneTimePreKeyId': 7,
          },
        }),
      );
      final entity = model.toEntity();

      expect(entity.x3dhHeader, isNotNull);
      expect(entity.x3dhHeader, isA<X3dhHeader>());
      expect(entity.x3dhHeader!.identityKey, equals('aWRlbnRpdHlLZXk='));
      expect(entity.x3dhHeader!.ephemeralKey, equals('ZXBoZW1lcmFsS2V5'));
      expect(entity.x3dhHeader!.oneTimePreKeyId, equals(7));
    });

    test('all E2EE fields preserved in entity conversion', () {
      final model = MessageModel.fromJson(fullE2eeJson());
      final entity = model.toEntity();

      expect(entity.ciphertext, equals('ZW5jcnlwdGVkRGF0YQ=='));
      expect(entity.isEncrypted, isTrue);

      expect(entity.e2ee, isNotNull);
      expect(entity.e2ee!.protocol, equals('signal-v1'));
      expect(entity.e2ee!.messageNumber, equals(42));
      expect(entity.e2ee!.dhPublicKey, equals('ZGhQdWJsaWNLZXk='));
      expect(entity.e2ee!.senderKeyChainId, equals('chain_abc'));

      expect(entity.x3dhHeader, isNotNull);
      expect(entity.x3dhHeader!.identityKey, equals('aWRlbnRpdHlLZXk='));
      expect(entity.x3dhHeader!.ephemeralKey, equals('ZXBoZW1lcmFsS2V5'));
      expect(entity.x3dhHeader!.oneTimePreKeyId, equals(7));
    });

    test('media keys preserved through toEntity', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'type': 'image',
          'ciphertext': 'ZW5jcnlwdGVk',
          'e2ee': {'protocol': 'signal-v1'},
          'media': {
            'url': 'https://example.com/image.jpg',
            'thumbnailUrl': 'https://example.com/thumb.jpg',
            'fileName': 'image.jpg',
            'fileSize': 1024,
            'mimeType': 'image/jpeg',
            'mediaKey': 'bWVkaWFLZXk=',
            'thumbKey': 'dGh1bWJLZXk=',
          },
        }),
      );
      final entity = model.toEntity();

      expect(entity.media, isNotNull);
      expect(entity.media!.mediaKey, equals('bWVkaWFLZXk='));
      expect(entity.media!.thumbKey, equals('dGh1bWJLZXk='));
      expect(entity.isEncrypted, isTrue);
      expect(entity.hasMedia, isTrue);
    });

    test('null e2ee map converts to null E2eeMetadata entity', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {'e2ee': null}),
      );
      final entity = model.toEntity();
      expect(entity.e2ee, isNull);
    });

    test('null x3dhHeader map converts to null X3dhHeader entity', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {'x3dhHeader': null}),
      );
      final entity = model.toEntity();
      expect(entity.x3dhHeader, isNull);
    });

    test('e2ee without optional fields uses defaults', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'e2ee': {'protocol': 'sender-key-v1'},
        }),
      );
      final entity = model.toEntity();

      expect(entity.e2ee, isNotNull);
      expect(entity.e2ee!.protocol, equals('sender-key-v1'));
      expect(entity.e2ee!.dhPublicKey, isNull);
      expect(entity.e2ee!.messageNumber, isNull);
      expect(entity.e2ee!.senderKeyChainId, isNull);
    });

    test('x3dhHeader without oneTimePreKeyId', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'x3dhHeader': {
            'identityKey': 'abc',
            'ephemeralKey': 'def',
          },
        }),
      );
      final entity = model.toEntity();

      expect(entity.x3dhHeader, isNotNull);
      expect(entity.x3dhHeader!.identityKey, equals('abc'));
      expect(entity.x3dhHeader!.ephemeralKey, equals('def'));
      expect(entity.x3dhHeader!.oneTimePreKeyId, isNull);
    });

    test('e2ee with missing protocol defaults to signal', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'e2ee': {'messageNumber': 5},
        }),
      );
      final entity = model.toEntity();

      expect(entity.e2ee, isNotNull);
      expect(entity.e2ee!.protocol, equals('signal'));
    });
  });

  // =========================================================================
  // fromEntity / Round-trip TESTS
  // =========================================================================

  group('MessageModel — entity round-trip via E2EETestData helpers', () {
    test('plaintext entity creates model with null E2EE fields', () {
      final entity = E2EETestData.createPlaintextMessage();
      // Build a model matching the entity (simulates what a datasource would do)
      final model = MessageModel(
        id: entity.id,
        senderId: entity.senderId,
        senderName: entity.senderName,
        type: 'text',
        status: 'sent',
        textContent: entity.textContent,
        createdAt: entity.createdAt,
      );

      expect(model.ciphertext, isNull);
      expect(model.e2ee, isNull);
      expect(model.x3dhHeader, isNull);

      final backToEntity = model.toEntity();
      expect(backToEntity.id, equals(entity.id));
      expect(backToEntity.textContent, equals(entity.textContent));
      expect(backToEntity.isEncrypted, isFalse);
    });

    test('encrypted entity survives model round-trip', () {
      final entity = E2EETestData.createEncryptedMessage(
        ciphertext: 'cm91bmR0cmlwQ2lwaGVy',
        e2ee: E2EETestData.createSignalMetadata(messageNumber: 99),
        x3dhHeader: E2EETestData.createX3dhHeader(otkId: 3),
      );

      // Simulate building a model from entity data (as a datasource would)
      final model = MessageModel(
        id: entity.id,
        senderId: entity.senderId,
        senderName: entity.senderName,
        type: 'text',
        status: 'sent',
        textContent: entity.textContent,
        ciphertext: entity.ciphertext,
        e2ee: {
          'protocol': entity.e2ee!.protocol,
          'messageNumber': entity.e2ee!.messageNumber,
          'dhPublicKey': entity.e2ee!.dhPublicKey,
          if (entity.e2ee!.senderKeyChainId != null)
            'senderKeyChainId': entity.e2ee!.senderKeyChainId,
        },
        x3dhHeader: {
          'identityKey': entity.x3dhHeader!.identityKey,
          'ephemeralKey': entity.x3dhHeader!.ephemeralKey,
          if (entity.x3dhHeader!.oneTimePreKeyId != null)
            'oneTimePreKeyId': entity.x3dhHeader!.oneTimePreKeyId,
        },
        createdAt: entity.createdAt,
      );

      final backToEntity = model.toEntity();

      expect(backToEntity.ciphertext, equals('cm91bmR0cmlwQ2lwaGVy'));
      expect(backToEntity.isEncrypted, isTrue);
      expect(backToEntity.e2ee!.protocol, equals('signal-v1'));
      expect(backToEntity.e2ee!.messageNumber, equals(99));
      expect(backToEntity.x3dhHeader!.oneTimePreKeyId, equals(3));
    });

    test('media message with encryption keys survives round-trip', () {
      final entity = E2EETestData.createMediaMessage(encrypted: true);

      final model = MessageModel(
        id: entity.id,
        senderId: entity.senderId,
        senderName: entity.senderName,
        type: 'image',
        status: 'sent',
        ciphertext: entity.ciphertext,
        e2ee: {
          'protocol': entity.e2ee!.protocol,
          'messageNumber': entity.e2ee!.messageNumber,
          'dhPublicKey': entity.e2ee!.dhPublicKey,
        },
        media: {
          'url': entity.media!.url,
          'thumbnailUrl': entity.media!.thumbnailUrl,
          'fileName': entity.media!.fileName,
          'fileSize': entity.media!.fileSize,
          'mimeType': entity.media!.mimeType,
          'mediaKey': entity.media!.mediaKey,
          'thumbKey': entity.media!.thumbKey,
        },
        createdAt: entity.createdAt,
      );

      final backToEntity = model.toEntity();

      expect(backToEntity.hasMedia, isTrue);
      expect(backToEntity.media!.mediaKey, equals('bWVkaWFLZXk='));
      expect(backToEntity.media!.thumbKey, equals('dGh1bWJLZXk='));
      expect(backToEntity.isEncrypted, isTrue);
    });
  });

  // =========================================================================
  // EDGE CASES
  // =========================================================================

  group('MessageModel — E2EE edge cases', () {
    test('empty string ciphertext is preserved (not treated as null)', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {'ciphertext': ''}),
      );

      expect(model.ciphertext, equals(''));
      // Empty string is still non-null; entity considers it "encrypted"
      final entity = model.toEntity();
      expect(entity.ciphertext, equals(''));
      expect(entity.isEncrypted, isTrue);
    });

    test('absent field vs explicit null field both yield null', () {
      final jsonAbsent = baseTextJson(); // no ciphertext key at all
      final jsonNull = baseTextJson(overrides: {'ciphertext': null});

      final modelAbsent = MessageModel.fromJson(jsonAbsent);
      final modelNull = MessageModel.fromJson(jsonNull);

      expect(modelAbsent.ciphertext, isNull);
      expect(modelNull.ciphertext, isNull);
      expect(modelAbsent.ciphertext, equals(modelNull.ciphertext));
    });

    test('timestamp round-trip preserves createdAt', () {
      final model = MessageModel.fromJson(baseTextJson());
      final entity = model.toEntity();

      expect(entity.createdAt, equals(fixedDate));
    });

    test('DateTime string createdAt round-trips through model', () {
      final specificDate = DateTime(2025, 1, 15, 10, 30, 45);
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'createdAt': specificDate.toIso8601String(),
        }),
      );

      expect(model.createdAt, equals(specificDate));
      final entity = model.toEntity();
      expect(entity.createdAt, equals(specificDate));
    });

    test('e2ee map with empty map yields E2eeMetadata with defaults', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'e2ee': <String, dynamic>{},
        }),
      );

      expect(model.e2ee, isNotNull);
      expect(model.e2ee, isA<Map>());

      final entity = model.toEntity();
      expect(entity.e2ee, isNotNull);
      // Empty map → _parseE2eeMetadata returns E2eeMetadata with default protocol
      expect(entity.e2ee!.protocol, equals('signal'));
    });

    test('x3dhHeader map with empty map yields X3dhHeader with defaults', () {
      final model = MessageModel.fromJson(
        baseTextJson(overrides: {
          'x3dhHeader': <String, dynamic>{},
        }),
      );

      expect(model.x3dhHeader, isNotNull);

      final entity = model.toEntity();
      expect(entity.x3dhHeader, isNotNull);
      expect(entity.x3dhHeader!.identityKey, equals(''));
      expect(entity.x3dhHeader!.ephemeralKey, equals(''));
      expect(entity.x3dhHeader!.oneTimePreKeyId, isNull);
    });

    test('copyWith preserves E2EE fields', () {
      final model = MessageModel.fromJson(fullE2eeJson());
      final updated = model.copyWith(textContent: 'updated');

      expect(updated.ciphertext, equals(model.ciphertext));
      expect(updated.e2ee, equals(model.e2ee));
      expect(updated.x3dhHeader, equals(model.x3dhHeader));
      expect(updated.textContent, equals('updated'));
    });

    test('copyWith can clear E2EE fields', () {
      final model = MessageModel.fromJson(fullE2eeJson());
      final cleared = model.copyWith(
        ciphertext: null,
        e2ee: null,
        x3dhHeader: null,
      );

      expect(cleared.ciphertext, isNull);
      expect(cleared.e2ee, isNull);
      expect(cleared.x3dhHeader, isNull);
    });
  });
}
