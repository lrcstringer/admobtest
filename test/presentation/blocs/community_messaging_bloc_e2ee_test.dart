import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/message.dart';
import 'package:imalichat/domain/repositories/community_repository.dart';
import 'package:imalichat/presentation/blocs/community_messaging/community_messaging_bloc.dart';

import '../../helpers/e2ee_test_helpers.dart';

class MockCommunityRepository extends Mock implements CommunityRepository {}

void main() {
  late MockCommunityRepository mockCommunityRepository;

  const testCommunityId = E2EETestData.testCommunityId;

  // Test fixtures
  final plaintextMessage = E2EETestData.createPlaintextMessage();
  final encryptedMessage = E2EETestData.createEncryptedMessage(
    id: 'msg_encrypted',
    senderId: E2EETestData.testRecipientId,
  );
  final waitingForKeyMessage = E2EETestData.createWaitingForKeyMessage();
  final sentMessage = E2EETestData.createPlaintextMessage(
    id: 'msg_sent',
    senderId: E2EETestData.testUserId,
    textContent: 'Sent to community',
  );

  CommunityMessagingBloc createBloc() => CommunityMessagingBloc(
        mockCommunityRepository,
        communityId: testCommunityId,
      );

  setUpAll(() async {
    // Initialize Firebase platform mocks so FirebaseAuth.instance doesn't throw
    TestWidgetsFlutterBinding.ensureInitialized();
    setupFirebaseCoreMocks();
    await Firebase.initializeApp();
  });

  setUp(() {
    mockCommunityRepository = MockCommunityRepository();

    // Default stubs for streams that may be triggered
    when(() => mockCommunityRepository.watchMessages(
          communityId: any(named: 'communityId'),
          limit: any(named: 'limit'),
        )).thenAnswer((_) => const Stream.empty());
  });

  group('CommunityMessagingBloc - E2EE Message Handling', () {
    // =========================================================================
    // Initial state
    // =========================================================================

    test('initial state is correct', () {
      final bloc = createBloc();
      expect(bloc.state.communityId, testCommunityId);
      expect(bloc.state.messages, isEmpty);
      expect(bloc.state.isLoading, false);
      expect(bloc.state.isSending, false);
      bloc.close();
    });

    // =========================================================================
    // loadMessages
    // =========================================================================

    group('loadMessages', () {
      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'emits [isLoading=true, loaded with messages] when loadMessages succeeds',
        build: () {
          when(() => mockCommunityRepository.getMessages(
                communityId: any(named: 'communityId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer(
            (_) async => Right([plaintextMessage, encryptedMessage]),
          );
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const CommunityMessagingEvent.loadMessages()),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.messages.length, 'messages.length', 2),
        ],
      );

      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'emits error when loadMessages fails',
        build: () {
          when(() => mockCommunityRepository.getMessages(
                communityId: any(named: 'communityId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const CommunityMessagingEvent.loadMessages()),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // =========================================================================
    // sendTextMessage
    // =========================================================================

    group('sendTextMessage', () {
      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'calls repository.sendTextMessage and emits sending states',
        build: () {
          when(() => mockCommunityRepository.sendTextMessage(
                communityId: any(named: 'communityId'),
                text: any(named: 'text'),
                replyToMessageId: any(named: 'replyToMessageId'),
              )).thenAnswer((_) async => Right(sentMessage));
          return createBloc();
        },
        act: (bloc) => bloc.add(const CommunityMessagingEvent.sendTextMessage(
          text: 'Hello community!',
        )),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isSending, 'isSending', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isSending, 'isSending', false),
        ],
        verify: (_) {
          verify(() => mockCommunityRepository.sendTextMessage(
                communityId: testCommunityId,
                text: 'Hello community!',
                replyToMessageId: null,
              )).called(1);
        },
      );

      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'emits error on send failure',
        build: () {
          when(() => mockCommunityRepository.sendTextMessage(
                communityId: any(named: 'communityId'),
                text: any(named: 'text'),
                replyToMessageId: any(named: 'replyToMessageId'),
              )).thenAnswer((_) async => const Left(Failure.network()));
          return createBloc();
        },
        act: (bloc) => bloc.add(const CommunityMessagingEvent.sendTextMessage(
          text: 'This will fail',
        )),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isSending, 'isSending', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isSending, 'isSending', false)
              .having((s) => s.errorMessage, 'errorMessage', isNotNull),
        ],
      );
    });

    // =========================================================================
    // watchMessages
    // =========================================================================

    group('watchMessages', () {
      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'emits decrypted messages from stream via messagesUpdated',
        build: () {
          final streamController =
              StreamController<Either<Failure, List<Message>>>();
          when(() => mockCommunityRepository.watchMessages(
                communityId: any(named: 'communityId'),
                limit: any(named: 'limit'),
              )).thenAnswer((_) => streamController.stream);

          // Emit messages after a short delay
          Future.delayed(const Duration(milliseconds: 50), () {
            streamController.add(
                Right([plaintextMessage, waitingForKeyMessage]));
          });

          return createBloc();
        },
        act: (bloc) async {
          bloc.add(const CommunityMessagingEvent.watchMessages());
          await Future.delayed(const Duration(milliseconds: 150));
        },
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.messages.length, 'messages.length', 2)
              .having(
                (s) => s.messages.any((m) =>
                    m.textContent == '[Waiting for encryption key...]'),
                'has waiting-for-key message',
                true,
              ),
        ],
      );
    });

    // =========================================================================
    // Messages with E2EE decryption states
    // =========================================================================

    group('messages with E2EE decryption states', () {
      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'messages with [Waiting for encryption key...] appear in state',
        build: () {
          when(() => mockCommunityRepository.getMessages(
                communityId: any(named: 'communityId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer(
            (_) async =>
                Right([plaintextMessage, waitingForKeyMessage]),
          );
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const CommunityMessagingEvent.loadMessages()),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.messages.length, 'messages.length', 2)
              .having(
                (s) => s.messages.any((m) =>
                    m.textContent == '[Waiting for encryption key...]'),
                'has waiting-for-key message',
                true,
              )
              .having(
                (s) => s.messages
                    .any((m) => m.e2ee?.protocol == 'sender-key-v2'),
                'has sender-key protocol metadata',
                true,
              ),
        ],
      );

      blocTest<CommunityMessagingBloc, CommunityMessagingState>(
        'mixed encrypted and plaintext messages in loaded state',
        build: () {
          final mixedMessages = [
            plaintextMessage,
            encryptedMessage,
            waitingForKeyMessage,
            E2EETestData.createSystemMessage(),
          ];
          when(() => mockCommunityRepository.getMessages(
                communityId: any(named: 'communityId'),
                limit: any(named: 'limit'),
                before: any(named: 'before'),
              )).thenAnswer((_) async => Right(mixedMessages));
          return createBloc();
        },
        act: (bloc) =>
            bloc.add(const CommunityMessagingEvent.loadMessages()),
        expect: () => [
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<CommunityMessagingState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.messages.length, 'messages.length', 4)
              .having(
                (s) => s.messages.where((m) => m.isEncrypted).length,
                'encrypted message count',
                2,
              )
              .having(
                (s) => s.messages
                    .where((m) => m.isTextMessage)
                    .length,
                'text message count',
                3,
              ),
        ],
      );
    });
  });

  // ===========================================================================
  // HIGH-3: Stream messages merged with paginated older messages
  // ===========================================================================

  group('HIGH-3: Stream messages merged with paginated older messages', () {
    // Helper to create messages with distinct timestamps and IDs
    Message makeMsg(String id, DateTime createdAt, {String? text}) =>
        E2EETestData.createPlaintextMessage(
          id: id,
          textContent: text ?? 'Message $id',
        ).copyWith(createdAt: createdAt);

    final now = DateTime(2024, 6, 10, 12, 0);
    final streamMsg1 = makeMsg('stream_1', now.subtract(const Duration(minutes: 1)));
    final streamMsg2 = makeMsg('stream_2', now);
    final oldPaginatedMsg1 = makeMsg('old_1', now.subtract(const Duration(hours: 2)));
    final oldPaginatedMsg2 = makeMsg('old_2', now.subtract(const Duration(hours: 3)));
    // A message that has the same ID as a stream message (duplicate scenario)
    final duplicateMsg = makeMsg('stream_1', now.subtract(const Duration(minutes: 1)),
        text: 'Stale copy of stream_1');

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'stream messages merge with older paginated messages when hasMore=true',
      build: () {
        when(() => mockCommunityRepository.watchMessages(
              communityId: any(named: 'communityId'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) => const Stream.empty());
        return createBloc();
      },
      seed: () => CommunityMessagingState(
        communityId: testCommunityId,
        messages: [streamMsg1, oldPaginatedMsg1, oldPaginatedMsg2],
        hasMore: true,
      ),
      act: (bloc) => bloc.add(
        CommunityMessagingEvent.messagesUpdated([streamMsg1, streamMsg2]),
      ),
      expect: () => [
        isA<CommunityMessagingState>()
            .having(
              (s) => s.messages.length,
              'total messages (2 stream + 2 old paginated)',
              4,
            )
            .having(
              (s) => s.messages.map((m) => m.id).toList(),
              'message IDs in order',
              ['stream_1', 'stream_2', 'old_1', 'old_2'],
            ),
      ],
    );

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'paginated messages older than stream window are preserved',
      build: () {
        when(() => mockCommunityRepository.watchMessages(
              communityId: any(named: 'communityId'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) => const Stream.empty());
        return createBloc();
      },
      seed: () => CommunityMessagingState(
        communityId: testCommunityId,
        messages: [oldPaginatedMsg1, oldPaginatedMsg2],
        hasMore: true,
      ),
      act: (bloc) => bloc.add(
        CommunityMessagingEvent.messagesUpdated([streamMsg1, streamMsg2]),
      ),
      expect: () => [
        isA<CommunityMessagingState>().having(
          (s) => s.messages.any((m) => m.id == 'old_1'),
          'old_1 preserved',
          true,
        ).having(
          (s) => s.messages.any((m) => m.id == 'old_2'),
          'old_2 preserved',
          true,
        ),
      ],
    );

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'duplicate messages (same ID in stream and paginated) are deduplicated',
      build: () {
        when(() => mockCommunityRepository.watchMessages(
              communityId: any(named: 'communityId'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) => const Stream.empty());
        return createBloc();
      },
      seed: () => CommunityMessagingState(
        communityId: testCommunityId,
        messages: [duplicateMsg, oldPaginatedMsg1],
        hasMore: true,
      ),
      act: (bloc) => bloc.add(
        CommunityMessagingEvent.messagesUpdated([streamMsg1, streamMsg2]),
      ),
      expect: () => [
        isA<CommunityMessagingState>()
            .having(
              (s) => s.messages.where((m) => m.id == 'stream_1').length,
              'stream_1 appears exactly once',
              1,
            )
            .having(
              (s) => s.messages.length,
              'total messages (2 stream + 1 old paginated, no duplicate)',
              3,
            ),
      ],
    );

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'when state has no paginated messages, stream messages replace all',
      build: () {
        when(() => mockCommunityRepository.watchMessages(
              communityId: any(named: 'communityId'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) => const Stream.empty());
        return createBloc();
      },
      seed: () => CommunityMessagingState(
        communityId: testCommunityId,
        messages: [],
        hasMore: false,
      ),
      act: (bloc) => bloc.add(
        CommunityMessagingEvent.messagesUpdated([streamMsg1, streamMsg2]),
      ),
      expect: () => [
        isA<CommunityMessagingState>()
            .having(
              (s) => s.messages.length,
              'messages.length',
              2,
            )
            .having(
              (s) => s.messages.map((m) => m.id).toList(),
              'only stream messages',
              ['stream_1', 'stream_2'],
            ),
      ],
    );

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'when hasMore=false, stream messages replace all even if state has messages',
      build: () {
        when(() => mockCommunityRepository.watchMessages(
              communityId: any(named: 'communityId'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) => const Stream.empty());
        return createBloc();
      },
      seed: () => CommunityMessagingState(
        communityId: testCommunityId,
        messages: [oldPaginatedMsg1, oldPaginatedMsg2],
        hasMore: false,
      ),
      act: (bloc) => bloc.add(
        CommunityMessagingEvent.messagesUpdated([streamMsg1, streamMsg2]),
      ),
      expect: () => [
        isA<CommunityMessagingState>()
            .having(
              (s) => s.messages.length,
              'messages.length',
              2,
            )
            .having(
              (s) => s.messages.map((m) => m.id).toSet(),
              'only stream message IDs',
              {'stream_1', 'stream_2'},
            ),
      ],
    );
  });

  // ===========================================================================
  // M10: Optimistic reactions with rollback on failure
  // ===========================================================================

  group('M10: Reactions — addReaction and removeReaction', () {
    // Note: FirebaseAuth.instance.currentUser is null in unit tests (no Firebase
    // initialised), so the optimistic-update code path inside _onAddReaction /
    // _onRemoveReaction is skipped. We test that:
    //   1. The repository method is called with the correct parameters.
    //   2. On failure the errorMessage is set (the non-optimistic failure branch).

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'addReaction calls repository.addReaction with correct params',
      build: () {
        when(() => mockCommunityRepository.addReaction(
              communityId: any(named: 'communityId'),
              messageId: any(named: 'messageId'),
              emoji: any(named: 'emoji'),
            )).thenAnswer((_) async => const Right(null));
        return createBloc();
      },
      act: (bloc) => bloc.add(const CommunityMessagingEvent.addReaction(
        messageId: 'msg_001',
        emoji: '👍',
      )),
      verify: (_) {
        verify(() => mockCommunityRepository.addReaction(
              communityId: testCommunityId,
              messageId: 'msg_001',
              emoji: '👍',
            )).called(1);
      },
    );

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'addReaction sets errorMessage on repository failure',
      build: () {
        when(() => mockCommunityRepository.addReaction(
              communityId: any(named: 'communityId'),
              messageId: any(named: 'messageId'),
              emoji: any(named: 'emoji'),
            )).thenAnswer(
                (_) async => const Left(Failure.network(message: 'offline')));
        return createBloc();
      },
      act: (bloc) => bloc.add(const CommunityMessagingEvent.addReaction(
        messageId: 'msg_001',
        emoji: '👍',
      )),
      expect: () => [
        isA<CommunityMessagingState>()
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'removeReaction calls repository.removeReaction with correct params',
      build: () {
        when(() => mockCommunityRepository.removeReaction(
              communityId: any(named: 'communityId'),
              messageId: any(named: 'messageId'),
              emoji: any(named: 'emoji'),
            )).thenAnswer((_) async => const Right(null));
        return createBloc();
      },
      act: (bloc) => bloc.add(const CommunityMessagingEvent.removeReaction(
        messageId: 'msg_001',
        emoji: '❤️',
      )),
      verify: (_) {
        verify(() => mockCommunityRepository.removeReaction(
              communityId: testCommunityId,
              messageId: 'msg_001',
              emoji: '❤️',
            )).called(1);
      },
    );

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'removeReaction sets errorMessage on repository failure',
      build: () {
        when(() => mockCommunityRepository.removeReaction(
              communityId: any(named: 'communityId'),
              messageId: any(named: 'messageId'),
              emoji: any(named: 'emoji'),
            )).thenAnswer(
                (_) async => const Left(Failure.network(message: 'offline')));
        return createBloc();
      },
      act: (bloc) => bloc.add(const CommunityMessagingEvent.removeReaction(
        messageId: 'msg_001',
        emoji: '❤️',
      )),
      expect: () => [
        isA<CommunityMessagingState>()
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );
  });

  // ===========================================================================
  // M6 + HIGH-8: markAsRead awaits and handles errors gracefully
  // ===========================================================================

  group('M6 + HIGH-8: markAsRead awaits and handles errors gracefully', () {
    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'markAsRead calls repository.markAsRead with correct communityId',
      build: () {
        when(() => mockCommunityRepository.markAsRead(
              communityId: any(named: 'communityId'),
            )).thenAnswer((_) async => const Right(null));
        return createBloc();
      },
      act: (bloc) => bloc.add(const CommunityMessagingEvent.markAsRead()),
      verify: (_) {
        verify(() => mockCommunityRepository.markAsRead(
              communityId: testCommunityId,
            )).called(1);
      },
    );

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'markAsRead failure is logged but does not emit error state',
      build: () {
        when(() => mockCommunityRepository.markAsRead(
              communityId: any(named: 'communityId'),
            )).thenAnswer(
                (_) async => const Left(Failure.network(message: 'offline')));
        return createBloc();
      },
      act: (bloc) => bloc.add(const CommunityMessagingEvent.markAsRead()),
      expect: () => [],  // No state changes — error is only logged via debugPrint
    );
  });

  // ===========================================================================
  // loadMore deduplication
  // ===========================================================================

  group('loadMore deduplication', () {
    final now = DateTime(2024, 6, 10, 12, 0);

    final existingMsg1 = E2EETestData.createPlaintextMessage(
      id: 'msg_A',
      textContent: 'First',
    ).copyWith(createdAt: now);

    final existingMsg2 = E2EETestData.createPlaintextMessage(
      id: 'msg_B',
      textContent: 'Second',
    ).copyWith(createdAt: now.subtract(const Duration(minutes: 5)));

    // Overlapping message that already exists in state
    final duplicateFromServer = E2EETestData.createPlaintextMessage(
      id: 'msg_B',
      textContent: 'Second (server copy)',
    ).copyWith(createdAt: now.subtract(const Duration(minutes: 5)));

    final newOlderMsg = E2EETestData.createPlaintextMessage(
      id: 'msg_C',
      textContent: 'Third (older)',
    ).copyWith(createdAt: now.subtract(const Duration(minutes: 10)));

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'loadMore filters out duplicate messages already in state',
      build: () {
        when(() => mockCommunityRepository.getMessages(
              communityId: any(named: 'communityId'),
              limit: any(named: 'limit'),
              before: any(named: 'before'),
            )).thenAnswer(
                (_) async => Right([duplicateFromServer, newOlderMsg]));
        when(() => mockCommunityRepository.watchMessages(
              communityId: any(named: 'communityId'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) => const Stream.empty());
        return createBloc();
      },
      seed: () => CommunityMessagingState(
        communityId: testCommunityId,
        messages: [existingMsg1, existingMsg2],
        hasMore: true,
      ),
      act: (bloc) => bloc.add(const CommunityMessagingEvent.loadMore()),
      expect: () => [
        // First emission: isLoading=true
        isA<CommunityMessagingState>()
            .having((s) => s.isLoading, 'isLoading', true),
        // Second emission: loaded with deduped results
        isA<CommunityMessagingState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having(
              (s) => s.messages.length,
              'messages.length (2 existing + 1 new, duplicate filtered)',
              3,
            )
            .having(
              (s) => s.messages.map((m) => m.id).toList(),
              'message IDs',
              ['msg_A', 'msg_B', 'msg_C'],
            ),
      ],
    );

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'loadMore does not emit when hasMore is false',
      build: () {
        when(() => mockCommunityRepository.watchMessages(
              communityId: any(named: 'communityId'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) => const Stream.empty());
        return createBloc();
      },
      seed: () => CommunityMessagingState(
        communityId: testCommunityId,
        messages: [existingMsg1],
        hasMore: false,
      ),
      act: (bloc) => bloc.add(const CommunityMessagingEvent.loadMore()),
      expect: () => [],  // No state changes — early return
    );

    blocTest<CommunityMessagingBloc, CommunityMessagingState>(
      'loadMore does not emit when messages list is empty',
      build: () {
        when(() => mockCommunityRepository.watchMessages(
              communityId: any(named: 'communityId'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) => const Stream.empty());
        return createBloc();
      },
      seed: () => CommunityMessagingState(
        communityId: testCommunityId,
        messages: [],
        hasMore: true,
      ),
      act: (bloc) => bloc.add(const CommunityMessagingEvent.loadMore()),
      expect: () => [],  // No state changes — early return
    );
  });
}
