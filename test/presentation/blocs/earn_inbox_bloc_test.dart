import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/inbox_client.dart';
import 'package:imalichat/domain/repositories/earn_repository.dart';
import 'package:imalichat/presentation/blocs/earn_inbox/earn_inbox_bloc.dart';

class MockEarnRepository extends Mock implements EarnRepository {}

void main() {
  late MockEarnRepository mockRepo;
  late EarnInboxBloc bloc;

  final testInboxResult = EligibleInboxResult(
    clients: const [
      InboxClient(
        clientId: 'client_001',
        clientName: 'Test Brand',
        isPinned: false,
        isFeatured: false,
        activeThreadCount: 0,
        threads: [],
      ),
    ],
    dailyCompletions: 5,
    dailyEarnCap: 30,
    dailyLimitReached: false,
  );

  final refreshedInboxResult = EligibleInboxResult(
    clients: const [
      InboxClient(
        clientId: 'client_001',
        clientName: 'Test Brand Updated',
        isPinned: false,
        isFeatured: false,
        activeThreadCount: 1,
        threads: [],
      ),
      InboxClient(
        clientId: 'client_002',
        clientName: 'New Brand',
        isPinned: true,
        isFeatured: false,
        activeThreadCount: 2,
        threads: [],
      ),
    ],
    dailyCompletions: 6,
    dailyEarnCap: 30,
    dailyLimitReached: false,
  );

  setUp(() {
    mockRepo = MockEarnRepository();
    // Default stubs
    when(() => mockRepo.getEligibleInbox(forceRefresh: any(named: 'forceRefresh')))
        .thenAnswer((_) async => Right(testInboxResult));
    when(() => mockRepo.getEarnNotifications())
        .thenAnswer((_) async => const Right([]));
    when(() => mockRepo.markNotificationRead(any()))
        .thenAnswer((_) async => const Right(null));
    when(() => mockRepo.markAllNotificationsRead())
        .thenAnswer((_) async => const Right(null));

    bloc = EarnInboxBloc(mockRepo);
  });

  tearDown(() => bloc.close());

  group('EarnInboxBloc', () {
    test('initial state is correct', () {
      expect(bloc.state.status, equals(EarnInboxStatus.initial));
      expect(bloc.state.clients, isEmpty);
      expect(bloc.state.dailyCompletions, equals(0));
    });

    // ── loadInbox ──

    blocTest<EarnInboxBloc, EarnInboxState>(
      'loadInbox calls getEligibleInbox without forceRefresh',
      build: () => bloc,
      act: (bloc) => bloc.add(const EarnInboxEvent.loadInbox()),
      verify: (_) {
        verify(() => mockRepo.getEligibleInbox(forceRefresh: false)).called(1);
      },
    );

    blocTest<EarnInboxBloc, EarnInboxState>(
      'loadInbox emits loading then loaded with clients',
      build: () => bloc,
      act: (bloc) => bloc.add(const EarnInboxEvent.loadInbox()),
      expect: () => [
        isA<EarnInboxState>().having(
          (s) => s.status,
          'status',
          EarnInboxStatus.loading,
        ),
        isA<EarnInboxState>()
            .having((s) => s.status, 'status', EarnInboxStatus.loaded)
            .having((s) => s.clients.length, 'clients.length', 1)
            .having((s) => s.dailyCompletions, 'dailyCompletions', 5),
        // Also emits for loadNotifications
        isA<EarnInboxState>(),
        isA<EarnInboxState>(),
      ],
    );

    blocTest<EarnInboxBloc, EarnInboxState>(
      'loadInbox emits error on failure',
      build: () {
        when(() => mockRepo.getEligibleInbox(forceRefresh: any(named: 'forceRefresh')))
            .thenAnswer((_) async => Left(Failure.serverError(message: 'Network error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const EarnInboxEvent.loadInbox()),
      expect: () => [
        isA<EarnInboxState>().having(
          (s) => s.status,
          'status',
          EarnInboxStatus.loading,
        ),
        isA<EarnInboxState>()
            .having((s) => s.status, 'status', EarnInboxStatus.error)
            .having((s) => s.errorMessage, 'errorMessage', 'Network error'),
        // loadNotifications still fires
        isA<EarnInboxState>(),
        isA<EarnInboxState>(),
      ],
    );

    // ── refreshInbox (forceRefresh: true) ──

    blocTest<EarnInboxBloc, EarnInboxState>(
      'refreshInbox calls getEligibleInbox with forceRefresh: true',
      build: () {
        when(() => mockRepo.getEligibleInbox(forceRefresh: true))
            .thenAnswer((_) async => Right(refreshedInboxResult));
        return bloc;
      },
      act: (bloc) => bloc.add(const EarnInboxEvent.refreshInbox()),
      verify: (_) {
        verify(() => mockRepo.getEligibleInbox(forceRefresh: true)).called(1);
      },
    );

    blocTest<EarnInboxBloc, EarnInboxState>(
      'refreshInbox updates clients and dailyCompletions',
      build: () {
        when(() => mockRepo.getEligibleInbox(forceRefresh: true))
            .thenAnswer((_) async => Right(refreshedInboxResult));
        return bloc;
      },
      act: (bloc) => bloc.add(const EarnInboxEvent.refreshInbox()),
      expect: () => [
        isA<EarnInboxState>()
            .having((s) => s.status, 'status', EarnInboxStatus.loaded)
            .having((s) => s.clients.length, 'clients.length', 2)
            .having((s) => s.dailyCompletions, 'dailyCompletions', 6),
        // loadNotifications
        isA<EarnInboxState>(),
        isA<EarnInboxState>(),
      ],
    );

    blocTest<EarnInboxBloc, EarnInboxState>(
      'refreshInbox clears error on success',
      build: () {
        when(() => mockRepo.getEligibleInbox(forceRefresh: true))
            .thenAnswer((_) async => Right(refreshedInboxResult));
        return bloc;
      },
      seed: () => const EarnInboxState(
        status: EarnInboxStatus.loaded,
        errorMessage: 'old error',
      ),
      act: (bloc) => bloc.add(const EarnInboxEvent.refreshInbox()),
      expect: () => [
        isA<EarnInboxState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          isNull,
        ),
        isA<EarnInboxState>(),
        isA<EarnInboxState>(),
      ],
    );

    // ── toggleClient ──

    blocTest<EarnInboxBloc, EarnInboxState>(
      'toggleClient expands the client',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const EarnInboxEvent.toggleClient(clientId: 'client_001')),
      expect: () => [
        isA<EarnInboxState>().having(
          (s) => s.expandedClientId,
          'expandedClientId',
          'client_001',
        ),
      ],
    );

    blocTest<EarnInboxBloc, EarnInboxState>(
      'toggleClient collapses when same client toggled again',
      build: () => bloc,
      seed: () => const EarnInboxState(expandedClientId: 'client_001'),
      act: (bloc) =>
          bloc.add(const EarnInboxEvent.toggleClient(clientId: 'client_001')),
      expect: () => [
        isA<EarnInboxState>().having(
          (s) => s.expandedClientId,
          'expandedClientId',
          isNull,
        ),
      ],
    );

    // ── clearError ──

    blocTest<EarnInboxBloc, EarnInboxState>(
      'clearError removes errorMessage',
      build: () => bloc,
      seed: () => const EarnInboxState(errorMessage: 'some error'),
      act: (bloc) => bloc.add(const EarnInboxEvent.clearError()),
      expect: () => [
        isA<EarnInboxState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          isNull,
        ),
      ],
    );
  });
}
