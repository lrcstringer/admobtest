import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/message.dart';
import 'package:imalichat/domain/enums/message_status.dart';
import 'package:imalichat/domain/enums/message_type.dart';
import 'package:imalichat/presentation/widgets/messaging/message_bubble.dart';

import '../../../helpers/e2ee_test_helpers.dart';

void main() {
  const currentUserId = E2EETestData.testUserId;
  const otherUserId = E2EETestData.testRecipientId;

  /// Helper to pump a [MessageBubble] wrapped in MaterialApp + Scaffold.
  Future<void> pumpBubble(
    WidgetTester tester, {
    required Message message,
    required bool isMe,
    bool showSenderName = false,
    ValueChanged<bool>? onTokenRequestAction,
    VoidCallback? onLongPress,
    VoidCallback? onReplyTap,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageBubble(
            message: message,
            isMe: isMe,
            currentUserId: currentUserId,
            showSenderName: showSenderName,
            onTokenRequestAction: onTokenRequestAction,
            onLongPress: onLongPress,
            onReplyTap: onReplyTap,
          ),
        ),
      ),
    );
  }

  // =====================================================================
  // Standard Rendering
  // =====================================================================
  group('Standard rendering', () {
    testWidgets('renders text content for sent message (isMe=true)',
        (tester) async {
      final msg = E2EETestData.createPlaintextMessage(
        senderId: currentUserId,
        textContent: 'Hello from me',
      );

      await pumpBubble(tester, message: msg, isMe: true);

      expect(find.text('Hello from me'), findsOneWidget);
    });

    testWidgets('renders text content for received message (isMe=false)',
        (tester) async {
      final msg = E2EETestData.createPlaintextMessage(
        senderId: otherUserId,
        textContent: 'Hello from them',
      );

      await pumpBubble(tester, message: msg, isMe: false);

      expect(find.text('Hello from them'), findsOneWidget);
    });

    testWidgets('aligns right for sent messages', (tester) async {
      final msg = E2EETestData.createPlaintextMessage(
        senderId: currentUserId,
      );

      await pumpBubble(tester, message: msg, isMe: true);

      final align = tester.widget<Align>(find.byType(Align).first);
      expect(align.alignment, Alignment.centerRight);
    });

    testWidgets('aligns left for received messages', (tester) async {
      final msg = E2EETestData.createPlaintextMessage(
        senderId: otherUserId,
      );

      await pumpBubble(tester, message: msg, isMe: false);

      final align = tester.widget<Align>(find.byType(Align).first);
      expect(align.alignment, Alignment.centerLeft);
    });

    testWidgets('shows sender name when showSenderName=true and !isMe',
        (tester) async {
      final msg = E2EETestData.createPlaintextMessage(
        senderId: otherUserId,
      );

      await pumpBubble(
        tester,
        message: msg,
        isMe: false,
        showSenderName: true,
      );

      // senderName from createPlaintextMessage is 'Alice'
      expect(find.text('Alice'), findsOneWidget);
    });

    testWidgets('hides sender name when showSenderName=false',
        (tester) async {
      final msg = E2EETestData.createPlaintextMessage(
        senderId: otherUserId,
      );

      await pumpBubble(
        tester,
        message: msg,
        isMe: false,
        showSenderName: false,
      );

      // The text content 'Hello, world!' should be there but the sender
      // name should NOT appear as a standalone text widget in the sender
      // name position. We verify by checking no widget shows just 'Alice'
      // in the sender-name padding area.
      // Note: The text 'Alice' is the senderName on the entity but the
      // widget only renders it when showSenderName && !isMe.
      expect(find.text('Hello, world!'), findsOneWidget);
      // 'Alice' should not appear as visible text
      expect(find.text('Alice'), findsNothing);
    });

    testWidgets('timestamp shows in HH:MM format', (tester) async {
      final msg = E2EETestData.createPlaintextMessage(
        senderId: currentUserId,
      );
      // createdAt is DateTime(2024, 6, 1, 12, 0) -> '12:00'

      await pumpBubble(tester, message: msg, isMe: true);

      expect(find.text('12:00'), findsOneWidget);
    });

    testWidgets('status icon shows for sent messages (isMe=true)',
        (tester) async {
      final msg = E2EETestData.createPlaintextMessage(
        senderId: currentUserId,
      );
      // status is MessageStatus.sent -> Icons.done

      await pumpBubble(tester, message: msg, isMe: true);

      expect(find.byIcon(Icons.done), findsOneWidget);
    });
  });

  // =====================================================================
  // E2EE Indicators
  // =====================================================================
  group('E2EE indicators', () {
    testWidgets('shows lock icon when message.isEncrypted=true',
        (tester) async {
      final msg = E2EETestData.createEncryptedMessage(
        senderId: currentUserId,
        // ciphertext is non-null, so isEncrypted == true
      ).copyWith(textContent: 'Decrypted content');

      await pumpBubble(tester, message: msg, isMe: true);

      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('no lock icon when message.isEncrypted=false',
        (tester) async {
      final msg = E2EETestData.createPlaintextMessage(
        senderId: currentUserId,
      );
      // ciphertext is null, so isEncrypted == false

      await pumpBubble(tester, message: msg, isMe: true);

      expect(find.byIcon(Icons.lock), findsNothing);
    });

    testWidgets('[Cannot decrypt] shows italic text with lock_outline icon',
        (tester) async {
      final msg = E2EETestData.createDecryptionFailedMessage(
        senderId: otherUserId,
      );

      await pumpBubble(tester, message: msg, isMe: false);

      // Should show the decryption failed UI
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
      expect(
        find.text('Message cannot be decrypted'),
        findsOneWidget,
      );
    });

    testWidgets(
        'Waiting for encryption key shows italic text with lock_outline icon',
        (tester) async {
      final msg = E2EETestData.createWaitingForKeyMessage(
        senderId: otherUserId,
      );

      await pumpBubble(tester, message: msg, isMe: false);

      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
      expect(
        find.text('Waiting for encryption key...'),
        findsOneWidget,
      );
    });
  });

  // =====================================================================
  // E2EE Display Proof — Decrypted Text Reaches the Screen
  // =====================================================================
  group('E2EE display proof', () {
    testWidgets(
        'Successfully decrypted E2EE message shows plaintext, not "Message cannot be decrypted"',
        (tester) async {
      // This simulates exactly what _decryptIfNeeded returns on success:
      // msg.copyWith(textContent: plaintext) — ciphertext stays set, textContent is populated.
      final msg = E2EETestData.createEncryptedMessage(
        senderId: otherUserId,
        ciphertext: 'ZW5jcnlwdGVkRGF0YQ==',
        e2ee: E2EETestData.createSignalMetadata(),
      ).copyWith(textContent: 'Hello from Alice!');

      await pumpBubble(tester, message: msg, isMe: false);

      // The ACTUAL plaintext MUST be visible on screen
      expect(find.text('Hello from Alice!'), findsOneWidget);
      // "Message cannot be decrypted" MUST NOT appear
      expect(find.text('Message cannot be decrypted'), findsNothing);
      // Lock icon appears (message.isEncrypted is true because ciphertext is set)
      expect(find.byIcon(Icons.lock), findsOneWidget);
      // lock_outline (failure indicator) MUST NOT appear
      expect(find.byIcon(Icons.lock_outline), findsNothing);
    });

    testWidgets(
        'Failed decrypt (textContent=[Cannot decrypt]) shows "Message cannot be decrypted"',
        (tester) async {
      // This simulates _decryptIfNeeded catch block:
      // msg.copyWith(textContent: '[Cannot decrypt]')
      final msg = E2EETestData.createEncryptedMessage(
        senderId: otherUserId,
      ).copyWith(textContent: '[Cannot decrypt]');

      await pumpBubble(tester, message: msg, isMe: false);

      expect(find.text('Message cannot be decrypted'), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
      // The raw sentinel value must NOT leak to the UI
      expect(find.text('[Cannot decrypt]'), findsNothing);
    });

    testWidgets(
        'Encrypted message with null textContent shows "Encrypted message" indicator',
        (tester) async {
      // This is a sent message where the sender's cache hasn't populated yet
      final msg = E2EETestData.createEncryptedMessage(
        senderId: currentUserId,
      );
      // textContent is null, ciphertext is set → isEncrypted && textContent == null

      await pumpBubble(tester, message: msg, isMe: true);

      expect(find.text('Encrypted message'), findsOneWidget);
      // Two lock icons: one in "Encrypted message" row (16px) + one in metadata row (10px)
      expect(find.byIcon(Icons.lock), findsNWidgets(2));
      expect(find.text('Message cannot be decrypted'), findsNothing);
    });

    testWidgets(
        'Long decrypted text renders fully (not truncated by bubble)',
        (tester) async {
      final longText = 'A' * 300;
      final msg = E2EETestData.createEncryptedMessage(
        senderId: otherUserId,
      ).copyWith(textContent: longText);

      await pumpBubble(tester, message: msg, isMe: false);

      expect(find.text(longText), findsOneWidget);
      expect(find.text('Message cannot be decrypted'), findsNothing);
    });

    testWidgets(
        'Unicode/emoji decrypted text displays correctly',
        (tester) async {
      const unicodeText = 'Hello \u2764\ufe0f\ud83d\ude80 world! \u4f60\u597d';
      final msg = E2EETestData.createEncryptedMessage(
        senderId: otherUserId,
      ).copyWith(textContent: unicodeText);

      await pumpBubble(tester, message: msg, isMe: false);

      expect(find.text(unicodeText), findsOneWidget);
    });
  });

  // =====================================================================
  // Token Card
  // =====================================================================
  group('Token card', () {
    testWidgets('token send card renders with amount', (tester) async {
      final msg = E2EETestData.createTokenSendMessage(
        isMe: true,
        amount: 500,
      );

      await pumpBubble(tester, message: msg, isMe: true);
      await tester.pumpAndSettle();

      expect(find.text('500 Tokens'), findsOneWidget);
      expect(find.text('You sent'), findsOneWidget);
    });

    testWidgets(
        'token request card renders Pay/Decline buttons when canAction=true',
        (tester) async {
      // canAction requires: isRequest && recipientId == currentUserId && status == pending
      final msg = Message(
        id: 'msg_token_req',
        senderId: otherUserId,
        senderName: 'Bob',
        type: MessageType.tokenRequest,
        status: MessageStatus.pending,
        textContent: 'Please pay me',
        tokenAmount: 250,
        recipientId: currentUserId,
        createdAt: DateTime(2024, 6, 1, 14, 30),
      );

      await pumpBubble(
        tester,
        message: msg,
        isMe: false,
        onTokenRequestAction: (_) {},
      );
      await tester.pumpAndSettle();

      expect(find.text('250 Tokens'), findsOneWidget);
      expect(find.text('Pay'), findsOneWidget);
      expect(find.text('Decline'), findsOneWidget);
    });

    testWidgets('Pay button fires onTokenRequestAction(true)',
        (tester) async {
      bool? actionValue;

      final msg = Message(
        id: 'msg_token_req',
        senderId: otherUserId,
        senderName: 'Bob',
        type: MessageType.tokenRequest,
        status: MessageStatus.pending,
        tokenAmount: 100,
        recipientId: currentUserId,
        createdAt: DateTime(2024, 6, 1, 14, 30),
      );

      await pumpBubble(
        tester,
        message: msg,
        isMe: false,
        onTokenRequestAction: (value) {
          actionValue = value;
        },
      );

      await tester.tap(find.text('Pay'));
      expect(actionValue, true);
    });

    testWidgets('Decline button fires onTokenRequestAction(false)',
        (tester) async {
      bool? actionValue;

      final msg = Message(
        id: 'msg_token_req',
        senderId: otherUserId,
        senderName: 'Bob',
        type: MessageType.tokenRequest,
        status: MessageStatus.pending,
        tokenAmount: 100,
        recipientId: currentUserId,
        createdAt: DateTime(2024, 6, 1, 14, 30),
      );

      await pumpBubble(
        tester,
        message: msg,
        isMe: false,
        onTokenRequestAction: (value) {
          actionValue = value;
        },
      );

      await tester.tap(find.text('Decline'));
      expect(actionValue, false);
    });
  });

  // =====================================================================
  // System Message
  // =====================================================================
  group('System message', () {
    testWidgets('renders centered for system messages', (tester) async {
      final msg = E2EETestData.createSystemMessage(
        text: 'Alice joined the group',
      );

      await pumpBubble(tester, message: msg, isMe: false);

      // System messages use Center widget
      expect(find.byType(Center), findsOneWidget);
      expect(find.text('Alice joined the group'), findsOneWidget);
    });
  });

  // =====================================================================
  // Reactions
  // =====================================================================
  group('Reactions', () {
    testWidgets('reactions bar shows when totalReactions > 0',
        (tester) async {
      final msg = Message(
        id: 'msg_reactions',
        senderId: currentUserId,
        senderName: 'Alice',
        type: MessageType.text,
        status: MessageStatus.sent,
        textContent: 'Great message',
        reactions: {
          '\u{1F44D}': ['user1', 'user2'],
          '\u{2764}': ['user3'],
        },
        createdAt: DateTime(2024, 6, 1, 12, 0),
      );

      await pumpBubble(tester, message: msg, isMe: true);

      // totalReactions = 3, so the reactions bar should render.
      // Each reaction entry shows as 'emoji count'
      expect(find.textContaining('\u{1F44D}'), findsOneWidget);
      expect(find.textContaining('\u{2764}'), findsOneWidget);
    });
  });
}
