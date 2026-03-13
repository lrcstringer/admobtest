import 'dart:async';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/conversation.dart';
import 'package:imalichat/domain/entities/message.dart';
import 'package:imalichat/domain/enums/conversation_type.dart';
import 'package:imalichat/domain/enums/message_status.dart';
import 'package:imalichat/domain/enums/message_type.dart';
import 'package:imalichat/domain/repositories/conversation_repository.dart';
import 'package:imalichat/presentation/blocs/conversation/conversation_bloc.dart';

// =============================================================================
// MOCKS
// =============================================================================

class MockConversationRepository extends Mock
    implements ConversationRepository {}

// =============================================================================
// FIXTURES
// =============================================================================

const _currentUserId = 'user_alice';
const _otherUserId = 'user_bob';
const _convId = 'conv_001';
const _convId2 = 'conv_002';

final _now = DateTime(2026, 3, 13, 10, 0);

Conversation _makeConversation({
  String id = _convId,
  ConversationType type = ConversationType.p2p,
  List<String>? participantIds,
  Map<String, bool>? accepted,
  Map<String, int>? unreadCounts,
  Duration? disappearingMessagesDuration,
}) =>
    Conversation(
      id: id,
      type: type,
      participantIds: participantIds ?? [_currentUserId, _otherUserId],
      participants: {
        _currentUserId:
            const ParticipantInfo(displayName: 'Alice'),
        _otherUserId:
            const ParticipantInfo(displayName: 'Bob'),
      },
      unreadCounts: unreadCounts ?? {},
      archived: {},
      pinned: {},
      muted: {},
      accepted: accepted ?? {},
      createdAt: _now,
      disappearingMessagesDuration: disappearingMessagesDuration,
    );

Message _makeTextMessage({
  String id = 'msg_001',
  String senderId = _currentUserId,
  MessageStatus status = MessageStatus.sent,
  String? textContent,
}) =>
    Message(
      id: id,
      senderId: senderId,
      senderName: senderId == _currentUserId ? 'Alice' : 'Bob',
      type: MessageType.text,
      status: status,
      textContent: textContent ?? 'Hello',
      createdAt: _now,
    );

Message _makeTokenRequestMessage({
  String id = 'msg_token_req',
  String senderId = _otherUserId,
  MessageStatus status = MessageStatus.pending,
  int amount = 100,
}) =>
    Message(
      id: id,
      senderId: senderId,
      senderName: 'Bob',
      type: MessageType.tokenRequest,
      status: status,
      textContent: 'Pay me',
      tokenAmount: amount,
      recipientId: _currentUserId,
      createdAt: _now,
    );

Message _makeMediaMessage({
  String id = 'msg_media',
  String senderId = _currentUserId,
}) =>
    Message(
      id: id,
      senderId: senderId,
      senderName: 'Alice',
      type: MessageType.image,
      status: MessageStatus.sent,
      media: const MessageMedia(
        url: 'https://example.com/img.jpg',
        fileName: 'img.jpg',
        fileSize: 2048,
        mimeType: 'image/jpeg',
        mediaKey: 'key123',
        thumbKey: 'thumb123',
      ),
      createdAt: _now,
    );

// =============================================================================
// HELPER: stubs shared across many tests
// =============================================================================

void _stubEmptyStreams(MockConversationRepository repo) {
  when(() => repo.currentUserId).thenReturn(_currentUserId);
  when(() => repo.watchMessages(conversationId: any(named: 'conversationId')))
      .thenAnswer((_) => const Stream.empty());
  when(() =>
          repo.watchTypingState(conversationId: any(named: 'conversationId')))
      .thenAnswer((_) => const Stream.empty());
  // Parameterless stubs must come after parameterized ones to avoid
  // mocktail ArgumentMatcher leakage.
  when(() => repo.watchConversations())
      .thenAnswer((_) => const Stream.empty());
  when(() => repo.watchTotalUnreadCount())
      .thenAnswer((_) => const Stream.empty());
}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late MockConversationRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(FakeFile());
  });

  setUp(() {
    mockRepo = MockConversationRepository();
    _stubEmptyStreams(mockRepo);
  });

  // ===========================================================================
  // 1. watchConversations
  // ===========================================================================

  group('watchConversations', () {
    blocTest<ConversationBloc, ConversationState>(
      'emits loading then loaded with conversations from one-shot read',
      build: () {
        final convs = [_makeConversation()];
        when(() => mockRepo.getConversations())
            .thenAnswer((_) async => Right(convs));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.watchConversations()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loading),
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loaded)
            .having((s) => s.conversations.length, 'conversations.length', 1),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error when getConversations fails',
      build: () {
        when(() => mockRepo.getConversations())
            .thenAnswer((_) async => const Left(Failure.network()));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.watchConversations()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loading),
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.error)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'subscribes to stream and dispatches conversationsUpdated on new data',
      build: () {
        final convs = [_makeConversation()];
        when(() => mockRepo.getConversations())
            .thenAnswer((_) async => Right(convs));
        final controller =
            StreamController<Either<Failure, List<Conversation>>>();
        when(() => mockRepo.watchConversations())
            .thenAnswer((_) => controller.stream);
        // Emit an update after initial load
        Future.delayed(const Duration(milliseconds: 50), () {
          final updated = [
            _makeConversation(),
            _makeConversation(id: _convId2),
          ];
          controller.add(Right(updated));
        });
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.watchConversations()),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loading),
        isA<ConversationState>()
            .having((s) => s.conversations.length, 'length', 1),
        // After stream emits, conversationsUpdated fires
        isA<ConversationState>()
            .having((s) => s.conversations.length, 'length', 2),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'dispatches streamError when watch stream emits failure',
      build: () {
        final convs = [_makeConversation()];
        when(() => mockRepo.getConversations())
            .thenAnswer((_) async => Right(convs));
        final controller =
            StreamController<Either<Failure, List<Conversation>>>();
        when(() => mockRepo.watchConversations())
            .thenAnswer((_) => controller.stream);
        Future.delayed(const Duration(milliseconds: 50), () {
          controller.add(const Left(Failure.network()));
        });
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.watchConversations()),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loading),
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loaded),
        isA<ConversationState>()
            .having((s) => s.hasStreamError, 'hasStreamError', true),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'skips loading spinner when conversations already present (re-dispatch)',
      build: () {
        // Return a different conversation to avoid state deduplication
        when(() => mockRepo.getConversations())
            .thenAnswer((_) async => Right([
                  _makeConversation(),
                  _makeConversation(id: _convId2),
                ]));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        status: ConversationStatus.loaded,
        conversations: [_makeConversation()],
      ),
      act: (bloc) => bloc.add(const ConversationEvent.watchConversations()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        // No loading state emitted — goes straight to loaded with fresh data
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loaded)
            .having((s) => s.conversations.length, 'length', 2),
      ],
    );
  });

  // ===========================================================================
  // 2. conversationsUpdated
  // ===========================================================================

  group('conversationsUpdated', () {
    blocTest<ConversationBloc, ConversationState>(
      'merges accepted status: preserves local accepted=true over incoming false',
      build: () => ConversationBloc(mockRepo),
      seed: () => ConversationState(
        status: ConversationStatus.loaded,
        conversations: [
          _makeConversation(accepted: {_currentUserId: true}),
        ],
      ),
      act: (bloc) => bloc.add(ConversationEvent.conversationsUpdated([
        // Incoming has accepted=false AND a different lastMessageText to ensure
        // the emitted state differs from the seed (avoiding BLoC deduplication).
        _makeConversation(accepted: {_currentUserId: false}),
        _makeConversation(id: _convId2, accepted: {_currentUserId: true}),
      ])),
      expect: () => [
        isA<ConversationState>()
            .having(
              (s) => s.conversations
                  .firstWhere((c) => c.id == _convId)
                  .isAcceptedFor(_currentUserId),
              'accepted preserved for original conv',
              true,
            )
            .having(
                (s) => s.conversations.length, 'conversations.length', 2),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'refreshes selectedConversation when it exists in updated list',
      build: () => ConversationBloc(mockRepo),
      seed: () => ConversationState(
        status: ConversationStatus.loaded,
        conversations: [_makeConversation()],
        selectedConversation: _makeConversation(),
      ),
      act: (bloc) {
        // Send an update with an extra conversation to ensure state differs
        bloc.add(ConversationEvent.conversationsUpdated([
          _makeConversation(),
          _makeConversation(id: _convId2),
        ]));
      },
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.selectedConversation?.id,
                'selectedConversation', _convId)
            .having(
                (s) => s.conversations.length, 'conversations.length', 2),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'computes messageRequestCount from merged conversations',
      build: () => ConversationBloc(mockRepo),
      seed: () => const ConversationState(
        status: ConversationStatus.loaded,
      ),
      act: (bloc) => bloc.add(ConversationEvent.conversationsUpdated([
        _makeConversation(
            id: 'conv_a', accepted: {_currentUserId: false}),
        _makeConversation(
            id: 'conv_b', accepted: {_currentUserId: true}),
        _makeConversation(
            id: 'conv_c', accepted: {_currentUserId: false}),
      ])),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.messageRequestCount, 'messageRequestCount', 2),
      ],
    );
  });

  // ===========================================================================
  // 3. selectConversation
  // ===========================================================================

  group('selectConversation', () {
    blocTest<ConversationBloc, ConversationState>(
      'finds conversation in local state, loads messages, subscribes to streams',
      build: () {
        when(() => mockRepo.getMessages(
              conversationId: _convId,
              limit: any(named: 'limit'),
              before: any(named: 'before'),
            )).thenAnswer(
            (_) async => Right([_makeTextMessage()]));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        status: ConversationStatus.loaded,
        conversations: [_makeConversation()],
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.selectConversation(_convId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.selectedConversation?.id, 'selected', _convId)
            .having((s) => s.hasLoadedMessages, 'hasLoadedMessages', true)
            .having((s) => s.messages.length, 'messages.length', 1)
            .having((s) => s.isSyncingMessages, 'isSyncingMessages', false),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'falls back to repo.getConversationById when not in local state',
      build: () {
        when(() => mockRepo.getConversationById(_convId))
            .thenAnswer((_) async => Right(_makeConversation()));
        when(() => mockRepo.getMessages(
              conversationId: _convId,
              limit: any(named: 'limit'),
              before: any(named: 'before'),
            )).thenAnswer((_) async => const Right([]));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) =>
          bloc.add(const ConversationEvent.selectConversation(_convId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.selectedConversation?.id, 'selected', _convId)
            .having((s) => s.hasLoadedMessages, 'hasLoadedMessages', true)
            .having((s) => s.isSyncingMessages, 'isSyncingMessages', true),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error when getConversationById fails and conv not in state',
      build: () {
        when(() => mockRepo.getConversationById(_convId))
            .thenAnswer((_) async => const Left(Failure.network()));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) =>
          bloc.add(const ConversationEvent.selectConversation(_convId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.hasLoadedMessages, 'hasLoadedMessages', true)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'sets isSyncingMessages=true when local messages are empty',
      build: () {
        when(() => mockRepo.getMessages(
              conversationId: _convId,
              limit: any(named: 'limit'),
              before: any(named: 'before'),
            )).thenAnswer((_) async => const Right([]));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        status: ConversationStatus.loaded,
        conversations: [_makeConversation()],
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.selectConversation(_convId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isSyncingMessages, 'isSyncingMessages', true)
            .having((s) => s.hasLoadedMessages, 'hasLoadedMessages', true),
      ],
    );
  });

  // ===========================================================================
  // 4. getOrCreateConversation
  // ===========================================================================

  group('getOrCreateConversation', () {
    blocTest<ConversationBloc, ConversationState>(
      'emits loading, then loaded with conversation and messages',
      build: () {
        when(() => mockRepo.getOrCreateConversation(
              participantId: _otherUserId,
            )).thenAnswer((_) async => Right(_makeConversation()));
        when(() => mockRepo.getMessages(
              conversationId: _convId,
              limit: any(named: 'limit'),
              before: any(named: 'before'),
            )).thenAnswer((_) async => Right([_makeTextMessage()]));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(
          const ConversationEvent.getOrCreateConversation(_otherUserId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loading),
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loaded)
            .having((s) => s.selectedConversation?.id, 'selected', _convId)
            .having((s) => s.messages.length, 'messages.length', 1)
            .having((s) => s.hasLoadedMessages, 'hasLoadedMessages', true),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error when getOrCreateConversation fails',
      build: () {
        when(() => mockRepo.getOrCreateConversation(
              participantId: _otherUserId,
            )).thenAnswer(
            (_) async => const Left(Failure.serverError(message: 'boom')));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(
          const ConversationEvent.getOrCreateConversation(_otherUserId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loading),
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.error)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'subscribes to watchMessages after successful creation',
      build: () {
        when(() => mockRepo.getOrCreateConversation(
              participantId: _otherUserId,
            )).thenAnswer((_) async => Right(_makeConversation()));
        when(() => mockRepo.getMessages(
              conversationId: _convId,
              limit: any(named: 'limit'),
              before: any(named: 'before'),
            )).thenAnswer((_) async => const Right([]));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(
          const ConversationEvent.getOrCreateConversation(_otherUserId)),
      wait: const Duration(milliseconds: 100),
      verify: (_) {
        verify(() => mockRepo.watchMessages(conversationId: _convId))
            .called(1);
      },
    );
  });

  // ===========================================================================
  // 5. messagesUpdated
  // ===========================================================================

  group('messagesUpdated', () {
    blocTest<ConversationBloc, ConversationState>(
      'updates messages and clears isSyncingMessages',
      build: () => ConversationBloc(mockRepo),
      seed: () => const ConversationState(isSyncingMessages: true),
      act: (bloc) => bloc.add(ConversationEvent.messagesUpdated([
        _makeTextMessage(),
        _makeTextMessage(id: 'msg_002'),
      ])),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.messages.length, 'messages.length', 2)
            .having((s) => s.isSyncingMessages, 'isSyncingMessages', false)
            .having((s) => s.hasLoadedMessages, 'hasLoadedMessages', true),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'replaces existing messages entirely (single source of truth)',
      build: () => ConversationBloc(mockRepo),
      seed: () => ConversationState(
        messages: [_makeTextMessage(), _makeTextMessage(id: 'msg_old')],
      ),
      act: (bloc) => bloc.add(ConversationEvent.messagesUpdated([
        _makeTextMessage(id: 'msg_new'),
      ])),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.messages.length, 'messages.length', 1)
            .having((s) => s.messages.first.id, 'first msg id', 'msg_new'),
      ],
    );
  });

  // ===========================================================================
  // 6. sendMediaMessage
  // ===========================================================================

  group('sendMediaMessage', () {
    blocTest<ConversationBloc, ConversationState>(
      'does nothing when selectedConversation is null',
      build: () => ConversationBloc(mockRepo),
      act: (bloc) => bloc.add(ConversationEvent.sendMediaMessage(
        conversationId: _convId,
        mediaFile: FakeFile(),
        mediaType: 'image/jpeg',
        recipientId: _otherUserId,
      )),
      expect: () => [],
    );

    blocTest<ConversationBloc, ConversationState>(
      'does nothing for non-P2P conversations',
      build: () => ConversationBloc(mockRepo),
      seed: () => ConversationState(
        selectedConversation:
            _makeConversation(type: ConversationType.collection),
      ),
      act: (bloc) => bloc.add(ConversationEvent.sendMediaMessage(
        conversationId: _convId,
        mediaFile: FakeFile(),
        mediaType: 'image/jpeg',
        recipientId: _otherUserId,
      )),
      expect: () => [],
    );

    blocTest<ConversationBloc, ConversationState>(
      'sets isSending=true then false on success',
      build: () {
        when(() => mockRepo.sendMediaMessage(
              conversationId: any(named: 'conversationId'),
              mediaFile: any(named: 'mediaFile'),
              mediaType: any(named: 'mediaType'),
              recipientId: any(named: 'recipientId'),
              caption: any(named: 'caption'),
              durationSeconds: any(named: 'durationSeconds'),
              replyToMessageId: any(named: 'replyToMessageId'),
              thumbnailFile: any(named: 'thumbnailFile'),
            )).thenAnswer((_) async => Right(_makeMediaMessage()));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        selectedConversation: _makeConversation(),
      ),
      act: (bloc) => bloc.add(ConversationEvent.sendMediaMessage(
        conversationId: _convId,
        mediaFile: FakeFile(),
        mediaType: 'image/jpeg',
        recipientId: _otherUserId,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', true),
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', false),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error on failure',
      build: () {
        when(() => mockRepo.sendMediaMessage(
              conversationId: any(named: 'conversationId'),
              mediaFile: any(named: 'mediaFile'),
              mediaType: any(named: 'mediaType'),
              recipientId: any(named: 'recipientId'),
              caption: any(named: 'caption'),
              durationSeconds: any(named: 'durationSeconds'),
              replyToMessageId: any(named: 'replyToMessageId'),
              thumbnailFile: any(named: 'thumbnailFile'),
            )).thenAnswer((_) async => const Left(Failure.network()));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        selectedConversation: _makeConversation(),
      ),
      act: (bloc) => bloc.add(ConversationEvent.sendMediaMessage(
        conversationId: _convId,
        mediaFile: FakeFile(),
        mediaType: 'image/jpeg',
        recipientId: _otherUserId,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', true),
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', false)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );
  });

  // ===========================================================================
  // 7. sendTokens
  // ===========================================================================

  group('sendTokens', () {
    blocTest<ConversationBloc, ConversationState>(
      'emits isSending=true then false on success',
      build: () {
        when(() => mockRepo.sendTokens(
              conversationId: any(named: 'conversationId'),
              recipientId: any(named: 'recipientId'),
              amount: any(named: 'amount'),
              message: any(named: 'message'),
              subAccountId: any(named: 'subAccountId'),
            )).thenAnswer((_) async => Right(_makeTextMessage()));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.sendTokens(
        conversationId: _convId,
        recipientId: _otherUserId,
        amount: 500,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', true),
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', false),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error on failure',
      build: () {
        when(() => mockRepo.sendTokens(
              conversationId: any(named: 'conversationId'),
              recipientId: any(named: 'recipientId'),
              amount: any(named: 'amount'),
              message: any(named: 'message'),
              subAccountId: any(named: 'subAccountId'),
            )).thenAnswer(
            (_) async => const Left(Failure.insufficientBalance()));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.sendTokens(
        conversationId: _convId,
        recipientId: _otherUserId,
        amount: 500,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', true),
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', false)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );
  });

  // ===========================================================================
  // 8. sendTokensToUser
  // ===========================================================================

  group('sendTokensToUser', () {
    blocTest<ConversationBloc, ConversationState>(
      'gets/creates conversation then sends tokens (isSend=true)',
      build: () {
        when(() => mockRepo.getOrCreateConversation(
              participantId: _otherUserId,
            )).thenAnswer((_) async => Right(_makeConversation()));
        when(() => mockRepo.sendTokens(
              conversationId: any(named: 'conversationId'),
              recipientId: any(named: 'recipientId'),
              amount: any(named: 'amount'),
              message: any(named: 'message'),
              subAccountId: any(named: 'subAccountId'),
            )).thenAnswer((_) async => Right(_makeTextMessage()));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.sendTokensToUser(
        recipientId: _otherUserId,
        amount: 200,
        isSend: true,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', true),
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', false),
      ],
      verify: (_) {
        verify(() => mockRepo.sendTokens(
              conversationId: _convId,
              recipientId: _otherUserId,
              amount: 200,
              message: null,
              subAccountId: null,
            )).called(1);
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'gets/creates conversation then requests tokens (isSend=false)',
      build: () {
        when(() => mockRepo.getOrCreateConversation(
              participantId: _otherUserId,
            )).thenAnswer((_) async => Right(_makeConversation()));
        when(() => mockRepo.requestTokens(
              conversationId: any(named: 'conversationId'),
              recipientId: any(named: 'recipientId'),
              amount: any(named: 'amount'),
              message: any(named: 'message'),
              subAccountId: any(named: 'subAccountId'),
            )).thenAnswer((_) async => Right(_makeTextMessage()));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.sendTokensToUser(
        recipientId: _otherUserId,
        amount: 200,
        isSend: false,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', true),
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', false),
      ],
      verify: (_) {
        verify(() => mockRepo.requestTokens(
              conversationId: _convId,
              recipientId: _otherUserId,
              amount: 200,
              message: null,
              subAccountId: null,
            )).called(1);
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error when getOrCreateConversation fails',
      build: () {
        when(() => mockRepo.getOrCreateConversation(
              participantId: _otherUserId,
            )).thenAnswer((_) async => const Left(Failure.network()));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.sendTokensToUser(
        recipientId: _otherUserId,
        amount: 200,
        isSend: true,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', true),
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', false)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error when sendTokens fails after conversation creation',
      build: () {
        when(() => mockRepo.getOrCreateConversation(
              participantId: _otherUserId,
            )).thenAnswer((_) async => Right(_makeConversation()));
        when(() => mockRepo.sendTokens(
              conversationId: any(named: 'conversationId'),
              recipientId: any(named: 'recipientId'),
              amount: any(named: 'amount'),
              message: any(named: 'message'),
              subAccountId: any(named: 'subAccountId'),
            )).thenAnswer(
            (_) async => const Left(Failure.insufficientBalance()));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.sendTokensToUser(
        recipientId: _otherUserId,
        amount: 200,
        isSend: true,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', true),
        isA<ConversationState>()
            .having((s) => s.isSending, 'isSending', false)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );
  });

  // ===========================================================================
  // 9. acceptTokenRequest
  // ===========================================================================

  group('acceptTokenRequest', () {
    final tokenReq = _makeTokenRequestMessage();

    blocTest<ConversationBloc, ConversationState>(
      'optimistically sets status=paid, then keeps it on success',
      build: () {
        when(() => mockRepo.acceptTokenRequest(
              messageId: any(named: 'messageId'),
              conversationId: any(named: 'conversationId'),
            )).thenAnswer((_) async => Right(_makeTextMessage()));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(messages: [tokenReq]),
      act: (bloc) => bloc.add(const ConversationEvent.acceptTokenRequest(
        messageId: 'msg_token_req',
        conversationId: _convId,
      )),
      expect: () => [
        isA<ConversationState>().having(
          (s) => s.messages.first.status,
          'optimistic paid',
          MessageStatus.paid,
        ),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'reverts to pending on failure',
      build: () {
        when(() => mockRepo.acceptTokenRequest(
              messageId: any(named: 'messageId'),
              conversationId: any(named: 'conversationId'),
            )).thenAnswer(
            (_) async => const Left(Failure.insufficientBalance()));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(messages: [tokenReq]),
      act: (bloc) => bloc.add(const ConversationEvent.acceptTokenRequest(
        messageId: 'msg_token_req',
        conversationId: _convId,
      )),
      expect: () => [
        // Optimistic: paid
        isA<ConversationState>().having(
          (s) => s.messages.first.status,
          'optimistic paid',
          MessageStatus.paid,
        ),
        // Reverted: pending
        isA<ConversationState>()
            .having(
              (s) => s.messages.first.status,
              'reverted pending',
              MessageStatus.pending,
            )
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );
  });

  // ===========================================================================
  // 10. declineTokenRequest
  // ===========================================================================

  group('declineTokenRequest', () {
    final tokenReq = _makeTokenRequestMessage();

    blocTest<ConversationBloc, ConversationState>(
      'optimistically sets status=declined, keeps on success',
      build: () {
        when(() => mockRepo.declineTokenRequest(
              messageId: any(named: 'messageId'),
              conversationId: any(named: 'conversationId'),
            )).thenAnswer((_) async => Right(_makeTextMessage()));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(messages: [tokenReq]),
      act: (bloc) => bloc.add(const ConversationEvent.declineTokenRequest(
        messageId: 'msg_token_req',
        conversationId: _convId,
      )),
      expect: () => [
        isA<ConversationState>().having(
          (s) => s.messages.first.status,
          'optimistic declined',
          MessageStatus.declined,
        ),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'reverts to pending on failure',
      build: () {
        when(() => mockRepo.declineTokenRequest(
              messageId: any(named: 'messageId'),
              conversationId: any(named: 'conversationId'),
            )).thenAnswer((_) async => const Left(Failure.network()));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(messages: [tokenReq]),
      act: (bloc) => bloc.add(const ConversationEvent.declineTokenRequest(
        messageId: 'msg_token_req',
        conversationId: _convId,
      )),
      expect: () => [
        isA<ConversationState>().having(
          (s) => s.messages.first.status,
          'optimistic declined',
          MessageStatus.declined,
        ),
        isA<ConversationState>()
            .having(
              (s) => s.messages.first.status,
              'reverted pending',
              MessageStatus.pending,
            )
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );
  });

  // ===========================================================================
  // 11. acceptConversation
  // ===========================================================================

  group('acceptConversation', () {
    blocTest<ConversationBloc, ConversationState>(
      'optimistically updates accepted flag and decrements messageRequestCount on success',
      build: () {
        when(() => mockRepo.acceptConversation(
              conversationId: _convId,
            )).thenAnswer((_) async => const Right(null));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        status: ConversationStatus.loaded,
        conversations: [
          _makeConversation(accepted: {_currentUserId: false}),
        ],
        selectedConversation:
            _makeConversation(accepted: {_currentUserId: false}),
        messageRequestCount: 3,
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.acceptConversation(_convId)),
      expect: () => [
        isA<ConversationState>()
            .having(
              (s) => s.conversations.first.isAcceptedFor(_currentUserId),
              'accepted in list',
              true,
            )
            .having(
              (s) => s.selectedConversation?.isAcceptedFor(_currentUserId),
              'accepted selected',
              true,
            )
            .having(
                (s) => s.messageRequestCount, 'messageRequestCount', 2),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error on failure without updating accepted flag',
      build: () {
        when(() => mockRepo.acceptConversation(
              conversationId: _convId,
            )).thenAnswer((_) async => const Left(Failure.network()));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        status: ConversationStatus.loaded,
        conversations: [
          _makeConversation(accepted: {_currentUserId: false}),
        ],
        messageRequestCount: 3,
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.acceptConversation(_convId)),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.errorMessage, 'errorMessage', isNotNull)
            .having(
                (s) => s.messageRequestCount, 'unchanged count', 3),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'clamps messageRequestCount to 0 (never goes negative)',
      build: () {
        when(() => mockRepo.acceptConversation(
              conversationId: _convId,
            )).thenAnswer((_) async => const Right(null));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        status: ConversationStatus.loaded,
        conversations: [
          _makeConversation(accepted: {_currentUserId: false}),
        ],
        messageRequestCount: 0,
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.acceptConversation(_convId)),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.messageRequestCount, 'clamped to 0', 0),
      ],
    );
  });

  // ===========================================================================
  // 12. clearChat
  // ===========================================================================

  group('clearChat', () {
    blocTest<ConversationBloc, ConversationState>(
      'sets isClearingChat=true, clears messages on success',
      build: () {
        when(() => mockRepo.clearChat(conversationId: _convId))
            .thenAnswer((_) async => const Right(null));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        messages: [_makeTextMessage(), _makeTextMessage(id: 'msg_002')],
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.clearChat(_convId)),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isClearingChat, 'isClearingChat', true),
        isA<ConversationState>()
            .having((s) => s.isClearingChat, 'isClearingChat', false)
            .having((s) => s.messages, 'messages', isEmpty),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error and keeps messages on failure',
      build: () {
        when(() => mockRepo.clearChat(conversationId: _convId))
            .thenAnswer((_) async => const Left(Failure.network()));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        messages: [_makeTextMessage()],
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.clearChat(_convId)),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isClearingChat, 'isClearingChat', true),
        isA<ConversationState>()
            .having((s) => s.isClearingChat, 'isClearingChat', false)
            .having((s) => s.messages.length, 'messages preserved', 1)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );
  });

  // ===========================================================================
  // 13. retryMessage
  // ===========================================================================

  group('retryMessage', () {
    blocTest<ConversationBloc, ConversationState>(
      'delegates to repo — no state change on success',
      build: () {
        when(() => mockRepo.retryMessage('msg_fail'))
            .thenAnswer((_) async => const Right(null));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.retryMessage(
        conversationId: _convId,
        messageId: 'msg_fail',
      )),
      expect: () => [],
      verify: (_) {
        verify(() => mockRepo.retryMessage('msg_fail')).called(1);
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error on failure',
      build: () {
        when(() => mockRepo.retryMessage('msg_fail'))
            .thenAnswer((_) async => const Left(Failure.network()));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.retryMessage(
        conversationId: _convId,
        messageId: 'msg_fail',
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );
  });

  // ===========================================================================
  // 14. unreadCountUpdated
  // ===========================================================================

  group('unreadCountUpdated', () {
    blocTest<ConversationBloc, ConversationState>(
      'updates totalUnreadCount',
      build: () => ConversationBloc(mockRepo),
      act: (bloc) =>
          bloc.add(const ConversationEvent.unreadCountUpdated(7)),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.totalUnreadCount, 'totalUnreadCount', 7),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'sets count to zero',
      build: () => ConversationBloc(mockRepo),
      seed: () => const ConversationState(totalUnreadCount: 5),
      act: (bloc) =>
          bloc.add(const ConversationEvent.unreadCountUpdated(0)),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.totalUnreadCount, 'totalUnreadCount', 0),
      ],
    );
  });

  // ===========================================================================
  // 15. setTyping
  // ===========================================================================

  group('setTyping', () {
    blocTest<ConversationBloc, ConversationState>(
      'calls repo.setTyping(isTyping: true)',
      build: () {
        when(() => mockRepo.setTyping(
              conversationId: _convId,
              isTyping: true,
            )).thenAnswer((_) async => const Right(null));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.setTyping(
        conversationId: _convId,
        isTyping: true,
      )),
      wait: const Duration(milliseconds: 50),
      expect: () => [],
      verify: (_) {
        verify(() => mockRepo.setTyping(
              conversationId: _convId,
              isTyping: true,
            )).called(1);
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'calls repo.setTyping(isTyping: false) when stopping',
      build: () {
        when(() => mockRepo.setTyping(
              conversationId: _convId,
              isTyping: false,
            )).thenAnswer((_) async => const Right(null));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.setTyping(
        conversationId: _convId,
        isTyping: false,
      )),
      wait: const Duration(milliseconds: 50),
      expect: () => [],
      verify: (_) {
        verify(() => mockRepo.setTyping(
              conversationId: _convId,
              isTyping: false,
            )).called(1);
      },
    );
  });

  // ===========================================================================
  // 16. typingStateUpdated
  // ===========================================================================

  group('typingStateUpdated', () {
    blocTest<ConversationBloc, ConversationState>(
      'updates typingUsers map',
      build: () => ConversationBloc(mockRepo),
      act: (bloc) => bloc.add(
          const ConversationEvent.typingStateUpdated({_otherUserId: true})),
      expect: () => [
        isA<ConversationState>().having(
          (s) => s.typingUsers,
          'typingUsers',
          {_otherUserId: true},
        ),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'clears typingUsers when empty map arrives',
      build: () => ConversationBloc(mockRepo),
      seed: () =>
          const ConversationState(typingUsers: {_otherUserId: true}),
      act: (bloc) =>
          bloc.add(const ConversationEvent.typingStateUpdated({})),
      expect: () => [
        isA<ConversationState>().having(
          (s) => s.typingUsers,
          'typingUsers',
          isEmpty,
        ),
      ],
    );
  });

  // ===========================================================================
  // 17. searchMessages
  // ===========================================================================

  group('searchMessages', () {
    blocTest<ConversationBloc, ConversationState>(
      'sets isSearchingMessages=true, then returns results',
      build: () {
        when(() => mockRepo.searchMessages(
              conversationId: _convId,
              query: 'hello',
            )).thenAnswer((_) async => Right([_makeTextMessage()]));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.searchMessages(
        conversationId: _convId,
        query: 'hello',
      )),
      expect: () => [
        isA<ConversationState>()
            .having(
                (s) => s.isSearchingMessages, 'isSearchingMessages', true)
            .having((s) => s.messageSearchQuery, 'query', 'hello'),
        isA<ConversationState>()
            .having(
                (s) => s.isSearchingMessages, 'isSearchingMessages', false)
            .having((s) => s.messageSearchResults.length, 'results', 1),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'returns empty results on failure',
      build: () {
        when(() => mockRepo.searchMessages(
              conversationId: _convId,
              query: 'xyz',
            )).thenAnswer((_) async => const Left(Failure.cacheError()));
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.searchMessages(
        conversationId: _convId,
        query: 'xyz',
      )),
      expect: () => [
        isA<ConversationState>()
            .having(
                (s) => s.isSearchingMessages, 'isSearchingMessages', true),
        isA<ConversationState>()
            .having(
                (s) => s.isSearchingMessages, 'isSearchingMessages', false)
            .having(
                (s) => s.messageSearchResults, 'results', isEmpty),
      ],
    );
  });

  // ===========================================================================
  // 18. clearMessageSearch
  // ===========================================================================

  group('clearMessageSearch', () {
    blocTest<ConversationBloc, ConversationState>(
      'clears search state',
      build: () => ConversationBloc(mockRepo),
      seed: () => ConversationState(
        isSearchingMessages: false,
        messageSearchQuery: 'hello',
        messageSearchResults: [_makeTextMessage()],
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.clearMessageSearch()),
      expect: () => [
        isA<ConversationState>()
            .having(
                (s) => s.messageSearchResults, 'results', isEmpty)
            .having(
                (s) => s.isSearchingMessages, 'isSearching', false)
            .having((s) => s.messageSearchQuery, 'query', isNull),
      ],
    );
  });

  // ===========================================================================
  // 19. setDisappearingMessages
  // ===========================================================================

  group('setDisappearingMessages', () {
    blocTest<ConversationBloc, ConversationState>(
      'optimistically updates selectedConversation on success',
      build: () {
        when(() => mockRepo.setDisappearingMessages(
              conversationId: _convId,
              duration: const Duration(hours: 24),
            )).thenAnswer((_) async => const Right(null));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        selectedConversation: _makeConversation(),
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.setDisappearingMessages(
        conversationId: _convId,
        duration: Duration(hours: 24),
      )),
      expect: () => [
        isA<ConversationState>().having(
          (s) => s.selectedConversation?.disappearingMessagesDuration,
          'duration',
          const Duration(hours: 24),
        ),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'sets duration to null to disable',
      build: () {
        when(() => mockRepo.setDisappearingMessages(
              conversationId: _convId,
              duration: null,
            )).thenAnswer((_) async => const Right(null));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        selectedConversation: _makeConversation(
          disappearingMessagesDuration: const Duration(hours: 24),
        ),
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.setDisappearingMessages(
        conversationId: _convId,
        duration: null,
      )),
      expect: () => [
        isA<ConversationState>().having(
          (s) => s.selectedConversation?.disappearingMessagesDuration,
          'duration',
          isNull,
        ),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error on failure without updating selectedConversation',
      build: () {
        when(() => mockRepo.setDisappearingMessages(
              conversationId: _convId,
              duration: const Duration(hours: 24),
            )).thenAnswer((_) async => const Left(Failure.network()));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        selectedConversation: _makeConversation(),
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.setDisappearingMessages(
        conversationId: _convId,
        duration: Duration(hours: 24),
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.errorMessage, 'errorMessage', isNotNull)
            .having(
              (s) => s.selectedConversation?.disappearingMessagesDuration,
              'unchanged',
              isNull,
            ),
      ],
    );
  });

  // ===========================================================================
  // 20. forwardMessage
  // ===========================================================================

  group('forwardMessage', () {
    blocTest<ConversationBloc, ConversationState>(
      'sets isForwarding=true then false on success, extracts plaintext for text message',
      build: () {
        when(() => mockRepo.forwardMessage(
              sourceConversationId: any(named: 'sourceConversationId'),
              sourceMessageId: any(named: 'sourceMessageId'),
              targetConversationId: any(named: 'targetConversationId'),
              plaintextContent: any(named: 'plaintextContent'),
            )).thenAnswer((_) async => const Right('fwd_msg_id'));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        messages: [_makeTextMessage(id: 'msg_src', textContent: 'Forward me')],
      ),
      act: (bloc) => bloc.add(const ConversationEvent.forwardMessage(
        sourceConversationId: _convId,
        sourceMessageId: 'msg_src',
        targetConversationId: _convId2,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isForwarding, 'isForwarding', true),
        isA<ConversationState>()
            .having((s) => s.isForwarding, 'isForwarding', false),
      ],
      verify: (_) {
        verify(() => mockRepo.forwardMessage(
              sourceConversationId: _convId,
              sourceMessageId: 'msg_src',
              targetConversationId: _convId2,
              plaintextContent: 'Forward me',
            )).called(1);
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'extracts JSON plaintext for media messages',
      build: () {
        when(() => mockRepo.forwardMessage(
              sourceConversationId: any(named: 'sourceConversationId'),
              sourceMessageId: any(named: 'sourceMessageId'),
              targetConversationId: any(named: 'targetConversationId'),
              plaintextContent: any(named: 'plaintextContent'),
            )).thenAnswer((_) async => const Right('fwd_msg_id'));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        messages: [_makeMediaMessage(id: 'msg_media_src')],
      ),
      act: (bloc) => bloc.add(const ConversationEvent.forwardMessage(
        sourceConversationId: _convId,
        sourceMessageId: 'msg_media_src',
        targetConversationId: _convId2,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isForwarding, 'isForwarding', true),
        isA<ConversationState>()
            .having((s) => s.isForwarding, 'isForwarding', false),
      ],
      verify: (_) {
        // Verify that plaintextContent is a JSON string containing media info
        final captured = verify(() => mockRepo.forwardMessage(
              sourceConversationId: _convId,
              sourceMessageId: 'msg_media_src',
              targetConversationId: _convId2,
              plaintextContent: captureAny(named: 'plaintextContent'),
            )).captured.single as String;
        expect(captured, contains('"media"'));
        expect(captured, contains('"url"'));
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'emits error on failure',
      build: () {
        when(() => mockRepo.forwardMessage(
              sourceConversationId: any(named: 'sourceConversationId'),
              sourceMessageId: any(named: 'sourceMessageId'),
              targetConversationId: any(named: 'targetConversationId'),
              plaintextContent: any(named: 'plaintextContent'),
            )).thenAnswer((_) async => const Left(Failure.network()));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        messages: [_makeTextMessage(id: 'msg_src')],
      ),
      act: (bloc) => bloc.add(const ConversationEvent.forwardMessage(
        sourceConversationId: _convId,
        sourceMessageId: 'msg_src',
        targetConversationId: _convId2,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isForwarding, 'isForwarding', true),
        isA<ConversationState>()
            .having((s) => s.isForwarding, 'isForwarding', false)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'passes null plaintextContent when message not found in state',
      build: () {
        when(() => mockRepo.forwardMessage(
              sourceConversationId: any(named: 'sourceConversationId'),
              sourceMessageId: any(named: 'sourceMessageId'),
              targetConversationId: any(named: 'targetConversationId'),
              plaintextContent: any(named: 'plaintextContent'),
            )).thenAnswer((_) async => const Right('fwd_msg_id'));
        return ConversationBloc(mockRepo);
      },
      seed: () => const ConversationState(messages: []),
      act: (bloc) => bloc.add(const ConversationEvent.forwardMessage(
        sourceConversationId: _convId,
        sourceMessageId: 'msg_not_found',
        targetConversationId: _convId2,
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isForwarding, 'isForwarding', true),
        isA<ConversationState>()
            .having((s) => s.isForwarding, 'isForwarding', false),
      ],
      verify: (_) {
        verify(() => mockRepo.forwardMessage(
              sourceConversationId: _convId,
              sourceMessageId: 'msg_not_found',
              targetConversationId: _convId2,
              plaintextContent: null,
            )).called(1);
      },
    );
  });

  // ===========================================================================
  // 21. streamError / clearError
  // ===========================================================================

  group('streamError and clearError', () {
    blocTest<ConversationBloc, ConversationState>(
      'streamError sets hasStreamError=true',
      build: () => ConversationBloc(mockRepo),
      act: (bloc) =>
          bloc.add(const ConversationEvent.streamError()),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.hasStreamError, 'hasStreamError', true),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'clearError resets errorMessage and hasStreamError',
      build: () => ConversationBloc(mockRepo),
      seed: () => const ConversationState(
        errorMessage: 'some error',
        hasStreamError: true,
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.clearError()),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.hasStreamError, 'hasStreamError', false)
            .having((s) => s.errorMessage, 'errorMessage', isNull),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'clearError on clean state still emits (copyWith creates new instance)',
      build: () => ConversationBloc(mockRepo),
      act: (bloc) =>
          bloc.add(const ConversationEvent.clearError()),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.hasStreamError, 'hasStreamError', false)
            .having((s) => s.errorMessage, 'errorMessage', isNull),
      ],
    );
  });

  // ===========================================================================
  // ADDITIONAL EDGE CASES
  // ===========================================================================

  group('edge cases', () {
    blocTest<ConversationBloc, ConversationState>(
      'watchConversations subscribes to unread count stream',
      build: () {
        when(() => mockRepo.getConversations())
            .thenAnswer((_) async => const Right([]));
        final unreadController = StreamController<Either<Failure, int>>();
        when(() => mockRepo.watchTotalUnreadCount())
            .thenAnswer((_) => unreadController.stream);
        Future.delayed(const Duration(milliseconds: 50), () {
          unreadController.add(const Right(5));
        });
        return ConversationBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const ConversationEvent.watchConversations()),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loading),
        isA<ConversationState>()
            .having((s) => s.status, 'status', ConversationStatus.loaded),
        isA<ConversationState>()
            .having((s) => s.totalUnreadCount, 'unreadCount', 5),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'selectConversation subscribes to typing stream',
      build: () {
        final typingController = StreamController<Map<String, bool>>();
        when(() => mockRepo.watchTypingState(conversationId: _convId))
            .thenAnswer((_) => typingController.stream);
        when(() => mockRepo.getMessages(
              conversationId: _convId,
              limit: any(named: 'limit'),
              before: any(named: 'before'),
            )).thenAnswer((_) async => const Right([]));
        Future.delayed(const Duration(milliseconds: 50), () {
          typingController.add({_otherUserId: true});
        });
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        status: ConversationStatus.loaded,
        conversations: [_makeConversation()],
      ),
      act: (bloc) =>
          bloc.add(const ConversationEvent.selectConversation(_convId)),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.selectedConversation?.id, 'selected', _convId),
        isA<ConversationState>().having(
          (s) => s.typingUsers,
          'typingUsers',
          {_otherUserId: true},
        ),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'conversationsUpdated with empty userId skips merge logic',
      build: () {
        when(() => mockRepo.currentUserId).thenReturn(null);
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        status: ConversationStatus.loaded,
        conversations: [
          _makeConversation(accepted: {_currentUserId: true}),
        ],
      ),
      act: (bloc) => bloc.add(ConversationEvent.conversationsUpdated([
        _makeConversation(accepted: {_currentUserId: false}),
      ])),
      expect: () => [
        isA<ConversationState>().having(
          (s) => s.conversations.first.isAcceptedFor(_currentUserId),
          'not merged (userId empty)',
          false,
        ),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'loadMessages appends when before param is provided (pagination)',
      build: () {
        when(() => mockRepo.getMessages(
              conversationId: _convId,
              limit: 50,
              before: any(named: 'before'),
            )).thenAnswer((_) async => Right([
              _makeTextMessage(id: 'msg_old', textContent: 'Old msg'),
            ]));
        return ConversationBloc(mockRepo);
      },
      seed: () => ConversationState(
        messages: [_makeTextMessage(id: 'msg_new', textContent: 'New msg')],
      ),
      act: (bloc) => bloc.add(ConversationEvent.loadMessages(
        conversationId: _convId,
        limit: 50,
        before: _now.subtract(const Duration(hours: 1)),
      )),
      expect: () => [
        isA<ConversationState>()
            .having((s) => s.isLoadingMessages, 'loading', true),
        isA<ConversationState>()
            .having((s) => s.messages.length, 'appended length', 2)
            .having((s) => s.isLoadingMessages, 'loading', false),
      ],
    );

    blocTest<ConversationBloc, ConversationState>(
      'sendTextMessage guards: empty text is ignored',
      build: () => ConversationBloc(mockRepo),
      act: (bloc) => bloc.add(const ConversationEvent.sendTextMessage(
        conversationId: _convId,
        text: '   ',
      )),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockRepo.sendTextMessage(
              conversationId: any(named: 'conversationId'),
              text: any(named: 'text'),
              replyToMessageId: any(named: 'replyToMessageId'),
              recipientId: any(named: 'recipientId'),
            ));
      },
    );

    blocTest<ConversationBloc, ConversationState>(
      'sendTextMessage guards: non-P2P conversation is ignored',
      build: () => ConversationBloc(mockRepo),
      seed: () => ConversationState(
        selectedConversation:
            _makeConversation(type: ConversationType.collection),
      ),
      act: (bloc) => bloc.add(const ConversationEvent.sendTextMessage(
        conversationId: _convId,
        text: 'Hello',
      )),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockRepo.sendTextMessage(
              conversationId: any(named: 'conversationId'),
              text: any(named: 'text'),
              replyToMessageId: any(named: 'replyToMessageId'),
              recipientId: any(named: 'recipientId'),
            ));
      },
    );
  });
}

// =============================================================================
// FAKES
// =============================================================================

/// Fake File for sendMediaMessage tests (avoids dart:io File dependency)
class FakeFile extends Fake implements File {}
