import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/chat_thread.dart';

void main() {
  group('ChatThread', () {
    late ChatThread thread;

    setUp(() {
      thread = ChatThread(
        id: 'thread123',
        type: ChatThreadType.p2p,
        participantIds: ['user1', 'user2'],
        displayName: 'John Doe',
        lastMessagePreview: 'Hello there!',
        lastMessageAt: DateTime(2024, 1, 1),
        unreadCount: 3,
        isPinned: false,
        isMuted: false,
        isArchived: false,
        createdAt: DateTime(2024, 1, 1),
      );
    });

    group('hasUnread', () {
      test('returns true when unreadCount > 0', () {
        expect(thread.hasUnread, true);
      });

      test('returns false when unreadCount is 0', () {
        final noUnread = thread.copyWith(unreadCount: 0);
        expect(noUnread.hasUnread, false);
      });
    });

    group('displayInitials', () {
      test('returns two letters from two-word name', () {
        expect(thread.displayInitials, 'JD');
      });

      test('returns first two chars from single-word name', () {
        final singleName = thread.copyWith(displayName: 'John');
        expect(singleName.displayInitials, 'JO');
      });

      test('returns ?? for empty name', () {
        final emptyName = thread.copyWith(displayName: '');
        expect(emptyName.displayInitials, '??');
      });

      test('handles single character name', () {
        final singleChar = thread.copyWith(displayName: 'J');
        expect(singleChar.displayInitials, 'J');
      });
    });

    group('ChatThreadType', () {
      test('different thread types are distinct', () {
        final p2pThread = thread;
        final brandThread = thread.copyWith(type: ChatThreadType.brand);
        final systemThread = thread.copyWith(type: ChatThreadType.system);

        expect(p2pThread.type, ChatThreadType.p2p);
        expect(brandThread.type, ChatThreadType.brand);
        expect(systemThread.type, ChatThreadType.system);
      });
    });
  });
}
