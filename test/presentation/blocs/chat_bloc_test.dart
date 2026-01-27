import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/repositories/chat_repository.dart';
import 'package:imalichat/presentation/blocs/chat/chat_bloc.dart';

import '../../helpers/test_helpers.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late MockChatRepository mockChatRepository;

  setUp(() {
    mockChatRepository = MockChatRepository();
  });

  group('ChatBloc', () {
    test('initial state is correct', () {
      final bloc = ChatBloc(mockChatRepository);
      expect(bloc.state.status, ChatStatus.initial);
      expect(bloc.state.threads, isEmpty);
      expect(bloc.state.messages, isEmpty);
      bloc.close();
    });

    group('LoadThreads', () {
      blocTest<ChatBloc, ChatState>(
        'emits [loading, success] when getChatThreads succeeds',
        build: () {
          when(() => mockChatRepository.getChatThreads())
              .thenAnswer((_) async => Right(TestData.chatThreadList));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.loadThreads()),
        expect: () => [
          isA<ChatState>().having((s) => s.status, 'status', ChatStatus.loading),
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.success)
              .having((s) => s.threads, 'threads', TestData.chatThreadList),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'emits [loading, failure] when getChatThreads fails',
        build: () {
          when(() => mockChatRepository.getChatThreads())
              .thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.loadThreads()),
        expect: () => [
          isA<ChatState>().having((s) => s.status, 'status', ChatStatus.loading),
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('SelectThread', () {
      blocTest<ChatBloc, ChatState>(
        'selects thread and starts watching messages',
        build: () {
          when(() => mockChatRepository.watchMessages(
                threadId: any(named: 'threadId'),
                limit: any(named: 'limit'),
              )).thenAnswer((_) => Stream.value(const Right([])));
          return ChatBloc(mockChatRepository);
        },
        seed: () => ChatState(threads: TestData.chatThreadList),
        act: (bloc) => bloc.add(const ChatEvent.selectThread('thread123')),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.selectedThread?.id, 'selectedThread.id', 'thread123')
              .having((s) => s.messages, 'messages', isEmpty),
        ],
      );
    });

    group('ThreadsUpdated', () {
      blocTest<ChatBloc, ChatState>(
        'updates threads in state',
        build: () => ChatBloc(mockChatRepository),
        act: (bloc) => bloc.add(ChatEvent.threadsUpdated(TestData.chatThreadList)),
        expect: () => [
          isA<ChatState>()
              .having((s) => s.status, 'status', ChatStatus.success)
              .having((s) => s.threads, 'threads', TestData.chatThreadList),
        ],
      );
    });

    group('UnreadCountUpdated', () {
      blocTest<ChatBloc, ChatState>(
        'updates total unread count',
        build: () => ChatBloc(mockChatRepository),
        act: (bloc) => bloc.add(const ChatEvent.unreadCountUpdated(5)),
        expect: () => [
          isA<ChatState>().having((s) => s.totalUnreadCount, 'totalUnreadCount', 5),
        ],
      );
    });

    group('SendTextMessage', () {
      blocTest<ChatBloc, ChatState>(
        'emits [sending, sent] when sendTextMessage succeeds',
        build: () {
          when(() => mockChatRepository.sendTextMessage(
                threadId: any(named: 'threadId'),
                text: any(named: 'text'),
              )).thenAnswer((_) async => Right(TestData.textChatCard));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.sendTextMessage(
          threadId: 'thread123',
          text: 'Hello!',
        )),
        expect: () => [
          isA<ChatState>().having((s) => s.isSending, 'isSending', true),
          isA<ChatState>().having((s) => s.isSending, 'isSending', false),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'emits error when sendTextMessage fails',
        build: () {
          when(() => mockChatRepository.sendTextMessage(
                threadId: any(named: 'threadId'),
                text: any(named: 'text'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.sendTextMessage(
          threadId: 'thread123',
          text: 'Hello!',
        )),
        expect: () => [
          isA<ChatState>().having((s) => s.isSending, 'isSending', true),
          isA<ChatState>()
              .having((s) => s.isSending, 'isSending', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    group('SendTokens', () {
      blocTest<ChatBloc, ChatState>(
        'sends tokens successfully',
        build: () {
          when(() => mockChatRepository.sendTokens(
                threadId: any(named: 'threadId'),
                recipientId: any(named: 'recipientId'),
                amount: any(named: 'amount'),
                message: any(named: 'message'),
              )).thenAnswer((_) async => Right(TestData.tokenSendCard));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.sendTokens(
          threadId: 'thread123',
          recipientId: 'user456',
          amount: 100,
        )),
        expect: () => [
          isA<ChatState>().having((s) => s.isSending, 'isSending', true),
          isA<ChatState>().having((s) => s.isSending, 'isSending', false),
        ],
      );
    });

    group('TogglePinThread', () {
      blocTest<ChatBloc, ChatState>(
        'pins thread successfully',
        build: () {
          when(() => mockChatRepository.togglePinThread(
                threadId: any(named: 'threadId'),
                isPinned: any(named: 'isPinned'),
              )).thenAnswer((_) async => const Right(null));
          return ChatBloc(mockChatRepository);
        },
        act: (bloc) => bloc.add(const ChatEvent.togglePinThread(
          threadId: 'thread123',
          isPinned: true,
        )),
        expect: () => [],
        verify: (_) {
          verify(() => mockChatRepository.togglePinThread(
                threadId: 'thread123',
                isPinned: true,
              )).called(1);
        },
      );
    });

    group('ClearError', () {
      blocTest<ChatBloc, ChatState>(
        'clears error message',
        build: () => ChatBloc(mockChatRepository),
        seed: () => const ChatState(errorMessage: 'Some error'),
        act: (bloc) => bloc.add(const ChatEvent.clearError()),
        expect: () => [
          isA<ChatState>().having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );
    });
  });
}
