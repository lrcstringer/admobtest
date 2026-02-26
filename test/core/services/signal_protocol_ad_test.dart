import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/e2ee/session/double_ratchet_session.dart';
import 'package:imalichat/core/services/signal_protocol_service.dart';

import '../../helpers/e2ee_test_helpers.dart';

/// Tests for [SignalProtocolService.computeAssociatedData].
///
/// Verifies the AD byte layout matches the Signal Protocol spec:
///   AD = senderIdentityKey || receiverIdentityKey || dhPublicKey
///        || messageNumber (4 bytes big-endian)
///        || previousChainLength (4 bytes big-endian)
void main() {
  late SignalProtocolService service;
  late DoubleRatchetSession session;
  late Uint8List dhPublicKey;

  // Known identity keys (16 bytes each for simple math)
  final ourIdentityKeyBytes = Uint8List.fromList(
    List.generate(16, (i) => 0xAA),
  );
  final peerIdentityKeyBytes = Uint8List.fromList(
    List.generate(16, (i) => 0xBB),
  );
  final ourIdentityKeyB64 = base64Encode(ourIdentityKeyBytes);
  final peerIdentityKeyB64 = base64Encode(peerIdentityKeyBytes);

  setUp(() {
    // Create service with mock dependencies (computeAssociatedData is pure)
    service = SignalProtocolService(
      MockKeyManagementService(),
      MockCryptoService(),
      MockFlutterSecureStorage(),
    );

    dhPublicKey = Uint8List.fromList(List.generate(32, (i) => 0xCC));

    session = DoubleRatchetSession(
      rootKey: Uint8List(32),
      sendChainKey: Uint8List(32),
      recvChainKey: Uint8List(32),
      dhSendPrivate: Uint8List(32),
      dhSendPublic: Uint8List(32),
      isInitiator: true,
      ourIdentityKey: ourIdentityKeyB64,
      peerIdentityKey: peerIdentityKeyB64,
    );
  });

  group('computeAssociatedData byte layout', () {
    test('total length = senderKey + receiverKey + dhPub + 4 + 4', () {
      final ad = service.computeAssociatedData(
        session,
        dhPublicKey: dhPublicKey,
        messageNumber: 0,
        previousChainLength: 0,
      );

      // 16 (sender) + 16 (receiver) + 32 (dhPub) + 4 (msgNum) + 4 (prevChain)
      expect(ad.length, equals(16 + 16 + 32 + 4 + 4));
    });

    test('sender identity key at offset 0 (initiator sends ourKey first)', () {
      final ad = service.computeAssociatedData(
        session,
        dhPublicKey: dhPublicKey,
        messageNumber: 0,
        previousChainLength: 0,
      );

      // Initiator: sender = ourIdentityKey
      final senderSlice = ad.sublist(0, 16);
      expect(senderSlice, equals(ourIdentityKeyBytes));
    });

    test('receiver identity key at correct offset', () {
      final ad = service.computeAssociatedData(
        session,
        dhPublicKey: dhPublicKey,
        messageNumber: 0,
        previousChainLength: 0,
      );

      // Initiator: receiver = peerIdentityKey, starts at offset 16
      final receiverSlice = ad.sublist(16, 32);
      expect(receiverSlice, equals(peerIdentityKeyBytes));
    });

    test('message number as 4-byte big-endian at correct offset', () {
      const messageNumber = 258; // 0x00000102 in big-endian
      final ad = service.computeAssociatedData(
        session,
        dhPublicKey: dhPublicKey,
        messageNumber: messageNumber,
        previousChainLength: 0,
      );

      // msgNum offset = 16 + 16 + 32 = 64
      final msgNumBytes = ad.sublist(64, 68);
      final msgNum =
          ByteData.sublistView(msgNumBytes).getInt32(0, Endian.big);
      expect(msgNum, equals(messageNumber));
    });

    test('previous chain length as 4-byte big-endian at correct offset', () {
      const prevChainLength = 1025; // 0x00000401 in big-endian
      final ad = service.computeAssociatedData(
        session,
        dhPublicKey: dhPublicKey,
        messageNumber: 0,
        previousChainLength: prevChainLength,
      );

      // prevChain offset = 16 + 16 + 32 + 4 = 68
      final prevBytes = ad.sublist(68, 72);
      final prev =
          ByteData.sublistView(prevBytes).getInt32(0, Endian.big);
      expect(prev, equals(prevChainLength));
    });

    test('non-initiator swaps sender/receiver keys', () {
      session.isInitiator = false;

      final ad = service.computeAssociatedData(
        session,
        dhPublicKey: dhPublicKey,
        messageNumber: 0,
        previousChainLength: 0,
      );

      // Non-initiator: sender = peerIdentityKey, receiver = ourIdentityKey
      final senderSlice = ad.sublist(0, 16);
      final receiverSlice = ad.sublist(16, 32);
      expect(senderSlice, equals(peerIdentityKeyBytes));
      expect(receiverSlice, equals(ourIdentityKeyBytes));
    });

    test('legacy session without identity keys returns empty AD', () {
      session.ourIdentityKey = null;
      session.peerIdentityKey = null;

      final ad = service.computeAssociatedData(
        session,
        dhPublicKey: dhPublicKey,
        messageNumber: 42,
        previousChainLength: 10,
      );

      expect(ad.length, equals(0));
    });
  });
}
