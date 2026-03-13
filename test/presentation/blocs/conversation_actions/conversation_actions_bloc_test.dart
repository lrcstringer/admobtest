import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/repositories/conversation_repository.dart';
import 'package:imalichat/presentation/blocs/conversation_actions/conversation_actions_bloc.dart';

class MockConversationRepository extends Mock
    implements ConversationRepository {}

void main() {
  late MockConversationRepository mockRepo;

  setUp(() {
    mockRepo = MockConversationRepository();
  });

  ConversationActionsBloc buildBloc() => ConversationActionsBloc(mockRepo);

  const tConversationId = 'conv_123';
  const tMessageId = 'msg_456';
  const tEmoji = '\u{1F44D}';
  const tFailure = Failure.network(message: 'Something went wrong');
  const tErrorMessage = 'Something went wrong';

  // ===========================================================================
  // markAsRead
  // ===========================================================================

  group('markAsRead', () {
    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'success - calls repository, emits nothing',
      build: () {
        when(() => mockRepo.markAsRead(conversationId: tConversationId))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const ConversationActionsEvent.markAsRead(tConversationId)),
      expect: () => <ConversationActionsState>[],
      verify: (_) {
        verify(() => mockRepo.markAsRead(conversationId: tConversationId))
            .called(1);
      },
    );

    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'failure - emits state with errorMessage',
      build: () {
        when(() => mockRepo.markAsRead(conversationId: tConversationId))
            .thenAnswer((_) async => const Left(tFailure));
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const ConversationActionsEvent.markAsRead(tConversationId)),
      expect: () => [
        const ConversationActionsState(errorMessage: tErrorMessage),
      ],
    );
  });

  // ===========================================================================
  // togglePin
  // ===========================================================================

  group('togglePin', () {
    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'success - calls repository with correct params, emits nothing',
      build: () {
        when(() => mockRepo.togglePin(
              conversationId: tConversationId,
              pinned: true,
            )).thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ConversationActionsEvent.togglePin(
        conversationId: tConversationId,
        pinned: true,
      )),
      expect: () => <ConversationActionsState>[],
      verify: (_) {
        verify(() => mockRepo.togglePin(
              conversationId: tConversationId,
              pinned: true,
            )).called(1);
      },
    );

    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'failure - emits state with errorMessage',
      build: () {
        when(() => mockRepo.togglePin(
              conversationId: tConversationId,
              pinned: true,
            )).thenAnswer((_) async => const Left(tFailure));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ConversationActionsEvent.togglePin(
        conversationId: tConversationId,
        pinned: true,
      )),
      expect: () => [
        const ConversationActionsState(errorMessage: tErrorMessage),
      ],
    );
  });

  // ===========================================================================
  // toggleMute
  // ===========================================================================

  group('toggleMute', () {
    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'success - calls repository with correct params, emits nothing',
      build: () {
        when(() => mockRepo.toggleMute(
              conversationId: tConversationId,
              muted: true,
            )).thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ConversationActionsEvent.toggleMute(
        conversationId: tConversationId,
        muted: true,
      )),
      expect: () => <ConversationActionsState>[],
      verify: (_) {
        verify(() => mockRepo.toggleMute(
              conversationId: tConversationId,
              muted: true,
            )).called(1);
      },
    );

    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'failure - emits state with errorMessage',
      build: () {
        when(() => mockRepo.toggleMute(
              conversationId: tConversationId,
              muted: true,
            )).thenAnswer((_) async => const Left(tFailure));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ConversationActionsEvent.toggleMute(
        conversationId: tConversationId,
        muted: true,
      )),
      expect: () => [
        const ConversationActionsState(errorMessage: tErrorMessage),
      ],
    );
  });

  // ===========================================================================
  // archiveConversation
  // ===========================================================================

  group('archiveConversation', () {
    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'success - calls repository, emits nothing',
      build: () {
        when(() => mockRepo.archiveConversation(tConversationId))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const ConversationActionsEvent.archiveConversation(tConversationId),
      ),
      expect: () => <ConversationActionsState>[],
      verify: (_) {
        verify(() => mockRepo.archiveConversation(tConversationId)).called(1);
      },
    );

    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'failure - emits state with errorMessage',
      build: () {
        when(() => mockRepo.archiveConversation(tConversationId))
            .thenAnswer((_) async => const Left(tFailure));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const ConversationActionsEvent.archiveConversation(tConversationId),
      ),
      expect: () => [
        const ConversationActionsState(errorMessage: tErrorMessage),
      ],
    );
  });

  // ===========================================================================
  // addReaction
  // ===========================================================================

  group('addReaction', () {
    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'success - calls repository with correct params, emits nothing',
      build: () {
        when(() => mockRepo.addReaction(
              conversationId: tConversationId,
              messageId: tMessageId,
              emoji: tEmoji,
            )).thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ConversationActionsEvent.addReaction(
        conversationId: tConversationId,
        messageId: tMessageId,
        emoji: tEmoji,
      )),
      expect: () => <ConversationActionsState>[],
      verify: (_) {
        verify(() => mockRepo.addReaction(
              conversationId: tConversationId,
              messageId: tMessageId,
              emoji: tEmoji,
            )).called(1);
      },
    );

    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'failure - emits state with errorMessage',
      build: () {
        when(() => mockRepo.addReaction(
              conversationId: tConversationId,
              messageId: tMessageId,
              emoji: tEmoji,
            )).thenAnswer((_) async => const Left(tFailure));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ConversationActionsEvent.addReaction(
        conversationId: tConversationId,
        messageId: tMessageId,
        emoji: tEmoji,
      )),
      expect: () => [
        const ConversationActionsState(errorMessage: tErrorMessage),
      ],
    );
  });

  // ===========================================================================
  // removeReaction
  // ===========================================================================

  group('removeReaction', () {
    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'success - calls repository with correct params, emits nothing',
      build: () {
        when(() => mockRepo.removeReaction(
              conversationId: tConversationId,
              messageId: tMessageId,
              emoji: tEmoji,
            )).thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ConversationActionsEvent.removeReaction(
        conversationId: tConversationId,
        messageId: tMessageId,
        emoji: tEmoji,
      )),
      expect: () => <ConversationActionsState>[],
      verify: (_) {
        verify(() => mockRepo.removeReaction(
              conversationId: tConversationId,
              messageId: tMessageId,
              emoji: tEmoji,
            )).called(1);
      },
    );

    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'failure - emits state with errorMessage',
      build: () {
        when(() => mockRepo.removeReaction(
              conversationId: tConversationId,
              messageId: tMessageId,
              emoji: tEmoji,
            )).thenAnswer((_) async => const Left(tFailure));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ConversationActionsEvent.removeReaction(
        conversationId: tConversationId,
        messageId: tMessageId,
        emoji: tEmoji,
      )),
      expect: () => [
        const ConversationActionsState(errorMessage: tErrorMessage),
      ],
    );
  });

  // ===========================================================================
  // deleteMessageForEveryone
  // ===========================================================================

  group('deleteMessageForEveryone', () {
    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'success - calls repository with correct params, emits nothing',
      build: () {
        when(() => mockRepo.deleteMessageForEveryone(
              conversationId: tConversationId,
              messageId: tMessageId,
            )).thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const ConversationActionsEvent.deleteMessageForEveryone(
        conversationId: tConversationId,
        messageId: tMessageId,
      )),
      expect: () => <ConversationActionsState>[],
      verify: (_) {
        verify(() => mockRepo.deleteMessageForEveryone(
              conversationId: tConversationId,
              messageId: tMessageId,
            )).called(1);
      },
    );

    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'failure - emits state with errorMessage',
      build: () {
        when(() => mockRepo.deleteMessageForEveryone(
              conversationId: tConversationId,
              messageId: tMessageId,
            )).thenAnswer((_) async => const Left(tFailure));
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const ConversationActionsEvent.deleteMessageForEveryone(
        conversationId: tConversationId,
        messageId: tMessageId,
      )),
      expect: () => [
        const ConversationActionsState(errorMessage: tErrorMessage),
      ],
    );
  });

  // ===========================================================================
  // clearError
  // ===========================================================================

  group('clearError', () {
    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'clears existing error',
      build: buildBloc,
      seed: () => const ConversationActionsState(errorMessage: 'err'),
      act: (bloc) =>
          bloc.add(const ConversationActionsEvent.clearError()),
      expect: () => [
        const ConversationActionsState(errorMessage: null),
      ],
    );

    blocTest<ConversationActionsBloc, ConversationActionsState>(
      'emits same state when no error present',
      build: buildBloc,
      act: (bloc) =>
          bloc.add(const ConversationActionsEvent.clearError()),
      expect: () => [
        const ConversationActionsState(errorMessage: null),
      ],
    );
  });
}
