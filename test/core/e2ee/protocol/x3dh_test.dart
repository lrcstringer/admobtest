import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/core/e2ee/protocol/double_ratchet.dart';
import 'package:imalichat/core/e2ee/protocol/kdf.dart';
import 'package:imalichat/core/e2ee/protocol/x3dh.dart';
import 'package:imalichat/core/services/crypto_service.dart';

void main() {
  late CryptoService crypto;
  late SignalKdf kdf;
  late SpecX3dh x3dh;
  late SpecDoubleRatchet ratchet;

  setUp(() {
    crypto = CryptoService();
    kdf = SignalKdf(crypto);
    x3dh = SpecX3dh(crypto, kdf);
    ratchet = SpecDoubleRatchet(crypto, kdf);
  });

  /// Generate a full key bundle for Bob (the receiver).
  Future<_BobBundle> generateBobBundle() async {
    final identityKp = await crypto.generateX25519KeyPair();
    final spkKp = await crypto.generateX25519KeyPair();
    final otkKp = await crypto.generateX25519KeyPair();
    final ed25519Kp = await crypto.generateEd25519KeyPair();

    // Sign the SPK with Ed25519
    final spkSignature = await crypto.ed25519Sign(
      spkKp['publicKey']!,
      ed25519Kp['privateKey']!,
    );

    return _BobBundle(
      identityPrivate: identityKp['privateKey']!,
      identityPublic: identityKp['publicKey']!,
      spkPrivate: spkKp['privateKey']!,
      spkPublic: spkKp['publicKey']!,
      spkSignature: spkSignature,
      otkPrivate: otkKp['privateKey']!,
      otkPublic: otkKp['publicKey']!,
      ed25519Public: ed25519Kp['publicKey']!,
    );
  }

  group('SpecX3dh — shared secret agreement', () {
    test('initiator and receiver derive the same shared secret (with OTK)',
        () async {
      final aliceIdKp = await crypto.generateX25519KeyPair();
      final bobBundle = await generateBobBundle();

      // Alice (initiator)
      final aliceResult = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
        theirOneTimePreKey: bobBundle.otkPublic,
      );

      // Bob (receiver)
      final bobResult = await x3dh.computeReceiver(
        ourIdentityPrivate: bobBundle.identityPrivate,
        ourIdentityPublic: bobBundle.identityPublic,
        ourSignedPreKeyPrivate: bobBundle.spkPrivate,
        ourSignedPreKeyPublic: bobBundle.spkPublic,
        theirIdentityPublic: aliceIdKp['publicKey']!,
        theirEphemeralPublic: aliceResult.ephemeralPublic,
        ourOneTimePreKeyPrivate: bobBundle.otkPrivate,
      );

      // Both should derive the same SK
      expect(aliceResult.sharedSecret, equals(bobResult.sharedSecret));
      // Both should compute the same AD
      expect(aliceResult.associatedData, equals(bobResult.associatedData));
    });

    test('initiator and receiver derive the same shared secret (without OTK)',
        () async {
      final aliceIdKp = await crypto.generateX25519KeyPair();
      final bobBundle = await generateBobBundle();

      // Alice without OTK
      final aliceResult = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
        theirOneTimePreKey: null,
      );

      // Bob without OTK
      final bobResult = await x3dh.computeReceiver(
        ourIdentityPrivate: bobBundle.identityPrivate,
        ourIdentityPublic: bobBundle.identityPublic,
        ourSignedPreKeyPrivate: bobBundle.spkPrivate,
        ourSignedPreKeyPublic: bobBundle.spkPublic,
        theirIdentityPublic: aliceIdKp['publicKey']!,
        theirEphemeralPublic: aliceResult.ephemeralPublic,
        ourOneTimePreKeyPrivate: null,
      );

      expect(aliceResult.sharedSecret, equals(bobResult.sharedSecret));
      expect(aliceResult.associatedData, equals(bobResult.associatedData));
    });

    test('OTK vs no-OTK produces different shared secrets', () async {
      final aliceIdKp = await crypto.generateX25519KeyPair();
      final bobBundle = await generateBobBundle();

      final withOtk = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
        theirOneTimePreKey: bobBundle.otkPublic,
      );

      final withoutOtk = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
        theirOneTimePreKey: null,
      );

      // Different because DH4 is included/excluded
      expect(withOtk.sharedSecret, isNot(equals(withoutOtk.sharedSecret)));
    });
  });

  group('SpecX3dh — associated data', () {
    test('AD is IK_A(initiator) || IK_B(receiver), 64 bytes', () async {
      final aliceIdKp = await crypto.generateX25519KeyPair();
      final bobBundle = await generateBobBundle();

      final result = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
      );

      expect(result.associatedData.length, 64);
      // First 32 bytes = Alice's IK (initiator)
      expect(
        result.associatedData.sublist(0, 32),
        equals(aliceIdKp['publicKey']!),
      );
      // Last 32 bytes = Bob's IK (receiver)
      expect(
        result.associatedData.sublist(32, 64),
        equals(bobBundle.identityPublic),
      );
    });

    test('AD matches between initiator and receiver sessions', () async {
      final aliceIdKp = await crypto.generateX25519KeyPair();
      final bobBundle = await generateBobBundle();

      final aliceResult = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
      );

      final bobResult = await x3dh.computeReceiver(
        ourIdentityPrivate: bobBundle.identityPrivate,
        ourIdentityPublic: bobBundle.identityPublic,
        ourSignedPreKeyPrivate: bobBundle.spkPrivate,
        ourSignedPreKeyPublic: bobBundle.spkPublic,
        theirIdentityPublic: aliceIdKp['publicKey']!,
        theirEphemeralPublic: aliceResult.ephemeralPublic,
      );

      // Session AD should also match
      expect(
        aliceResult.sessionState.associatedData,
        equals(bobResult.sessionState.associatedData),
      );
    });
  });

  group('SpecX3dh — SPK verification', () {
    test('valid SPK signature verifies', () async {
      final bobBundle = await generateBobBundle();

      final valid = await x3dh.verifySignedPreKey(
        signedPreKey: bobBundle.spkPublic,
        signature: bobBundle.spkSignature,
        ed25519PublicKey: bobBundle.ed25519Public,
      );
      expect(valid, isTrue);
    });

    test('tampered SPK signature fails verification', () async {
      final bobBundle = await generateBobBundle();

      final tamperedSig = Uint8List.fromList(bobBundle.spkSignature);
      tamperedSig[0] ^= 0xFF;

      final valid = await x3dh.verifySignedPreKey(
        signedPreKey: bobBundle.spkPublic,
        signature: tamperedSig,
        ed25519PublicKey: bobBundle.ed25519Public,
      );
      expect(valid, isFalse);
    });

    test('wrong key fails SPK verification', () async {
      final bobBundle = await generateBobBundle();
      final wrongKp = await crypto.generateEd25519KeyPair();

      final valid = await x3dh.verifySignedPreKey(
        signedPreKey: bobBundle.spkPublic,
        signature: bobBundle.spkSignature,
        ed25519PublicKey: wrongKp['publicKey']!,
      );
      expect(valid, isFalse);
    });
  });

  group('SpecX3dh — session state properties', () {
    test('initiator session has send chain but no recv chain', () async {
      final aliceIdKp = await crypto.generateX25519KeyPair();
      final bobBundle = await generateBobBundle();

      final result = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
      );

      final state = result.sessionState;
      expect(state.isInitiator, isTrue);
      expect(state.sendChainKey, isNotNull);
      expect(state.recvChainKey, isNull);
      expect(state.dhRecvPublic, equals(bobBundle.spkPublic));
      expect(state.sendMessageNumber, 0);
      expect(state.recvMessageNumber, 0);
    });

    test('receiver session has no send/recv chain initially', () async {
      final aliceIdKp = await crypto.generateX25519KeyPair();
      final bobBundle = await generateBobBundle();

      final aliceResult = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
      );

      final bobResult = await x3dh.computeReceiver(
        ourIdentityPrivate: bobBundle.identityPrivate,
        ourIdentityPublic: bobBundle.identityPublic,
        ourSignedPreKeyPrivate: bobBundle.spkPrivate,
        ourSignedPreKeyPublic: bobBundle.spkPublic,
        theirIdentityPublic: aliceIdKp['publicKey']!,
        theirEphemeralPublic: aliceResult.ephemeralPublic,
      );

      final state = bobResult.sessionState;
      expect(state.isInitiator, isFalse);
      expect(state.sendChainKey, isNull);
      expect(state.recvChainKey, isNull);
      expect(state.dhRecvPublic, isNull);
    });
  });

  group('SpecX3dh + SpecDoubleRatchet — end-to-end', () {
    test('full handshake → encrypt → decrypt → reply', () async {
      final aliceIdKp = await crypto.generateX25519KeyPair();
      final bobBundle = await generateBobBundle();

      // 1. Alice performs X3DH
      final aliceX3dh = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
        theirOneTimePreKey: bobBundle.otkPublic,
      );

      // 2. Alice encrypts first message
      final enc1 = await ratchet.encrypt(
        aliceX3dh.sessionState,
        'Hello Bob, this is our first secure message!',
      );
      var aliceState = enc1.state;

      // 3. Bob performs X3DH
      final bobX3dh = await x3dh.computeReceiver(
        ourIdentityPrivate: bobBundle.identityPrivate,
        ourIdentityPublic: bobBundle.identityPublic,
        ourSignedPreKeyPrivate: bobBundle.spkPrivate,
        ourSignedPreKeyPublic: bobBundle.spkPublic,
        theirIdentityPublic: aliceIdKp['publicKey']!,
        theirEphemeralPublic: aliceX3dh.ephemeralPublic,
        ourOneTimePreKeyPrivate: bobBundle.otkPrivate,
      );

      // 4. Bob decrypts Alice's first message
      final dec1 = await ratchet.decrypt(
        bobX3dh.sessionState,
        enc1.header,
        enc1.ciphertext,
      );
      var bobState = dec1.state;
      expect(dec1.plaintext, 'Hello Bob, this is our first secure message!');

      // 5. Bob replies
      final enc2 = await ratchet.encrypt(bobState, 'Hi Alice, got it!');
      bobState = enc2.state;

      // 6. Alice decrypts Bob's reply
      final dec2 = await ratchet.decrypt(
        aliceState,
        enc2.header,
        enc2.ciphertext,
      );
      aliceState = dec2.state;
      expect(dec2.plaintext, 'Hi Alice, got it!');

      // 7. Continue conversation
      final enc3 = await ratchet.encrypt(aliceState, 'Great, E2EE works!');
      aliceState = enc3.state;

      final dec3 = await ratchet.decrypt(bobState, enc3.header, enc3.ciphertext);
      bobState = dec3.state;
      expect(dec3.plaintext, 'Great, E2EE works!');
    });

    test('full handshake without OTK works end-to-end', () async {
      final aliceIdKp = await crypto.generateX25519KeyPair();
      final bobBundle = await generateBobBundle();

      // X3DH without OTK
      final aliceX3dh = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
        theirOneTimePreKey: null,
      );

      final enc = await ratchet.encrypt(aliceX3dh.sessionState, 'No OTK msg');

      final bobX3dh = await x3dh.computeReceiver(
        ourIdentityPrivate: bobBundle.identityPrivate,
        ourIdentityPublic: bobBundle.identityPublic,
        ourSignedPreKeyPrivate: bobBundle.spkPrivate,
        ourSignedPreKeyPublic: bobBundle.spkPublic,
        theirIdentityPublic: aliceIdKp['publicKey']!,
        theirEphemeralPublic: aliceX3dh.ephemeralPublic,
        ourOneTimePreKeyPrivate: null,
      );

      final dec = await ratchet.decrypt(
        bobX3dh.sessionState,
        enc.header,
        enc.ciphertext,
      );
      expect(dec.plaintext, 'No OTK msg');
    });

    test('20 message conversation with alternating senders', () async {
      final aliceIdKp = await crypto.generateX25519KeyPair();
      final bobBundle = await generateBobBundle();

      final aliceX3dh = await x3dh.computeInitiator(
        ourIdentityPrivate: aliceIdKp['privateKey']!,
        ourIdentityPublic: aliceIdKp['publicKey']!,
        theirIdentityPublic: bobBundle.identityPublic,
        theirSignedPreKey: bobBundle.spkPublic,
        theirOneTimePreKey: bobBundle.otkPublic,
      );

      // Alice sends first message
      final enc0 = await ratchet.encrypt(aliceX3dh.sessionState, 'msg-0');
      var aliceState = enc0.state;

      final bobX3dh = await x3dh.computeReceiver(
        ourIdentityPrivate: bobBundle.identityPrivate,
        ourIdentityPublic: bobBundle.identityPublic,
        ourSignedPreKeyPrivate: bobBundle.spkPrivate,
        ourSignedPreKeyPublic: bobBundle.spkPublic,
        theirIdentityPublic: aliceIdKp['publicKey']!,
        theirEphemeralPublic: aliceX3dh.ephemeralPublic,
        ourOneTimePreKeyPrivate: bobBundle.otkPrivate,
      );

      final dec0 = await ratchet.decrypt(
        bobX3dh.sessionState,
        enc0.header,
        enc0.ciphertext,
      );
      var bobState = dec0.state;
      expect(dec0.plaintext, 'msg-0');

      // Alternate 20 messages
      for (var i = 1; i <= 20; i++) {
        if (i.isOdd) {
          // Bob -> Alice
          final enc = await ratchet.encrypt(bobState, 'bob-$i');
          bobState = enc.state;
          final dec = await ratchet.decrypt(
            aliceState,
            enc.header,
            enc.ciphertext,
          );
          aliceState = dec.state;
          expect(dec.plaintext, 'bob-$i');
        } else {
          // Alice -> Bob
          final enc = await ratchet.encrypt(aliceState, 'alice-$i');
          aliceState = enc.state;
          final dec = await ratchet.decrypt(
            bobState,
            enc.header,
            enc.ciphertext,
          );
          bobState = dec.state;
          expect(dec.plaintext, 'alice-$i');
        }
      }
    });
  });
}

/// Helper class holding Bob's full key bundle for tests.
class _BobBundle {
  final Uint8List identityPrivate;
  final Uint8List identityPublic;
  final Uint8List spkPrivate;
  final Uint8List spkPublic;
  final Uint8List spkSignature;
  final Uint8List otkPrivate;
  final Uint8List otkPublic;
  final Uint8List ed25519Public;

  _BobBundle({
    required this.identityPrivate,
    required this.identityPublic,
    required this.spkPrivate,
    required this.spkPublic,
    required this.spkSignature,
    required this.otkPrivate,
    required this.otkPublic,
    required this.ed25519Public,
  });
}
