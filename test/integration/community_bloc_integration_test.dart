import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/domain/entities/community.dart';
import 'package:imalichat/domain/entities/community_member.dart';
import 'package:imalichat/domain/entities/community_transaction.dart';
import 'package:imalichat/domain/enums/community_status.dart';
import 'package:imalichat/domain/enums/community_type.dart';
import 'package:imalichat/domain/enums/member_role.dart';
import 'package:imalichat/domain/enums/member_status.dart';
import 'package:imalichat/domain/repositories/community_repository.dart';
import 'package:imalichat/presentation/blocs/community/community_bloc.dart';

// =============================================================================
// MOCKS
// =============================================================================

class MockCommunityRepository extends Mock implements CommunityRepository {}

// =============================================================================
// FALLBACK VALUES
// =============================================================================

class FakeCreateCommunityParams extends Fake
    implements CreateCommunityParams {}

class FakeUpdateCommunityParams extends Fake
    implements UpdateCommunityParams {}

// =============================================================================
// TEST FIXTURES
// =============================================================================

const _communityId = 'community_1';
const _communityId2 = 'community_2';
const _userId = 'user_1';
const _memberId = 'member_1';
const _memberId2 = 'member_2';
const _transactionId = 'txn_1';

final _now = DateTime(2026, 3, 2);

Community _makeCommunity({
  String id = _communityId,
  String name = 'Test Community',
  CommunityType type = CommunityType.regular,
  CommunityStatus status = CommunityStatus.active,
  int totalBalance = 10000,
}) =>
    Community(
      id: id,
      type: type,
      name: name,
      ownerId: _userId,
      memberIds: [_userId, _memberId],
      adminIds: [_userId],
      memberCount: 2,
      totalBalance: totalBalance,
      status: status,
      settings: const CommunitySettings(),
      unreadCounts: const {},
      muted: const {},
      createdAt: _now,
    );

CommunityMember _makeMember({
  String id = _memberId,
  String communityId = _communityId,
  String userId = _userId,
  String displayName = 'Test User',
  MemberRole role = MemberRole.member,
  MemberStatus status = MemberStatus.active,
  String? communityName,
}) =>
    CommunityMember(
      id: id,
      communityId: communityId,
      userId: userId,
      displayName: displayName,
      role: role,
      status: status,
      invitedBy: _userId,
      invitedAt: _now,
      communityName: communityName,
    );

CommunityTransaction _makeTransaction({
  String id = _transactionId,
  CommunityTransactionType type = CommunityTransactionType.contribution,
  int amount = 500,
  CommunityTransactionStatus status = CommunityTransactionStatus.completed,
}) =>
    CommunityTransaction(
      id: id,
      communityId: _communityId,
      type: type,
      amount: amount,
      memberId: _memberId,
      memberName: 'Test User',
      status: status,
      createdAt: _now,
    );

CommunityApproval _makeApproval({
  String id = 'approval_1',
  String transactionId = _transactionId,
}) =>
    CommunityApproval(
      id: id,
      communityId: _communityId,
      transactionId: transactionId,
      requestedBy: _memberId,
      requestedByName: 'Test User',
      amount: 5000,
      type: CommunityTransactionType.withdrawal,
      approvers: const [],
      requiredApprovals: 2,
      status: ApprovalStatus.pending,
      createdAt: _now,
      expiresAt: _now.add(const Duration(days: 7)),
    );

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late MockCommunityRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(FakeCreateCommunityParams());
    registerFallbackValue(FakeUpdateCommunityParams());
    registerFallbackValue(MemberRole.member);
  });

  setUp(() {
    mockRepo = MockCommunityRepository();

    // Default stubs for streams that are auto-triggered by various handlers.
    // Prevents MissingStubError when the BLoC fires watch* events.
    when(() => mockRepo.watchUserCommunities())
        .thenAnswer((_) => const Stream.empty());
    when(() => mockRepo.watchTotalCommunityUnreadCount())
        .thenAnswer((_) => const Stream.empty());
    when(() => mockRepo.watchMembers(any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockRepo.watchTransactions(any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockRepo.watchPendingApprovals(any()))
        .thenAnswer((_) => const Stream.empty());
    when(() => mockRepo.refreshMembers(any()))
        .thenAnswer((_) async => const Right(null));
  });

  CommunityBloc buildBloc() => CommunityBloc(mockRepo);

  group('CommunityBloc Integration Flows', () {
    // =========================================================================
    // 1. Accept invitation -> refreshes data
    // =========================================================================
    blocTest<CommunityBloc, CommunityState>(
      '1. Accept invitation -> auto-dispatches loadUserCommunities + loadPendingInvitations',
      build: () {
        when(() => mockRepo.acceptInvitation(any()))
            .thenAnswer((_) async => const Right(null));
        // Stubs for the auto-dispatched follow-up events
        when(() => mockRepo.getUserCommunities())
            .thenAnswer((_) async => Right([_makeCommunity()]));
        when(() => mockRepo.getPendingInvitations())
            .thenAnswer((_) async => const Right([]));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.acceptInvitation(communityId: _communityId),
      ),
      wait: const Duration(milliseconds: 300),
      verify: (bloc) {
        // acceptInvitation was called
        verify(() => mockRepo.acceptInvitation(_communityId)).called(1);
        // loadUserCommunities auto-fired after success
        verify(() => mockRepo.getUserCommunities()).called(1);
        // loadPendingInvitations auto-fired after success
        verify(() => mockRepo.getPendingInvitations()).called(1);
        // State reflects loaded communities
        expect(bloc.state.status, CommunityLoadingStatus.loaded);
        expect(bloc.state.communities, hasLength(1));
        expect(bloc.state.communities.first.id, _communityId);
        // Pending invitations cleared
        expect(bloc.state.pendingInvitations, isEmpty);
      },
    );

    // =========================================================================
    // 2. Decline invitation -> removes from state
    // =========================================================================
    blocTest<CommunityBloc, CommunityState>(
      '2. Decline invitation -> optimistically removes invitation from pendingInvitations state',
      seed: () => CommunityState(
        pendingInvitations: [
          _makeMember(
            id: 'inv_1',
            communityId: _communityId,
            status: MemberStatus.invited,
            communityName: 'Test Community',
          ),
          _makeMember(
            id: 'inv_2',
            communityId: _communityId2,
            status: MemberStatus.invited,
            communityName: 'Other Community',
          ),
        ],
      ),
      build: () {
        when(() => mockRepo.declineInvitation(any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.declineInvitation(communityId: _communityId),
      ),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        verify(() => mockRepo.declineInvitation(_communityId)).called(1);
        // The declined invitation (communityId) is removed from state
        expect(bloc.state.pendingInvitations, hasLength(1));
        expect(
          bloc.state.pendingInvitations.first.communityId,
          _communityId2,
        );
      },
    );

    // =========================================================================
    // 3. Watch members -> updates state
    // =========================================================================
    blocTest<CommunityBloc, CommunityState>(
      '3. Watch members -> stream emits new member list -> state.selectedCommunityMembers updated',
      build: () {
        final members = [
          _makeMember(id: _memberId, displayName: 'Alice'),
          _makeMember(id: _memberId2, userId: _memberId2, displayName: 'Bob'),
        ];
        when(() => mockRepo.watchMembers(_communityId)).thenAnswer(
          (_) => Stream.value(Right(members)),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.watchMembers(communityId: _communityId),
      ),
      wait: const Duration(milliseconds: 300),
      verify: (bloc) {
        verify(() => mockRepo.watchMembers(_communityId)).called(1);
        verify(() => mockRepo.refreshMembers(_communityId)).called(1);
        expect(bloc.state.selectedCommunityMembers, hasLength(2));
        expect(
          bloc.state.selectedCommunityMembers.map((m) => m.displayName),
          containsAll(['Alice', 'Bob']),
        );
      },
    );

    // =========================================================================
    // 4. Load community details -> starts all watches
    // =========================================================================
    blocTest<CommunityBloc, CommunityState>(
      '4. Load community details -> auto-starts watchMembers, watchTransactions, watchPendingApprovals',
      build: () {
        final community = _makeCommunity();
        when(() => mockRepo.getCommunity(any()))
            .thenAnswer((_) async => Right(community));
        // Wire up streams for the auto-dispatched watch events
        final members = [_makeMember(displayName: 'Alice')];
        final transactions = [_makeTransaction()];
        final approvals = [_makeApproval()];
        when(() => mockRepo.watchMembers(_communityId)).thenAnswer(
          (_) => Stream.value(Right(members)),
        );
        when(() => mockRepo.watchTransactions(_communityId)).thenAnswer(
          (_) => Stream.value(Right(transactions)),
        );
        when(() => mockRepo.watchPendingApprovals(_communityId)).thenAnswer(
          (_) => Stream.value(Right(approvals)),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.loadCommunityDetails(communityId: _communityId),
      ),
      wait: const Duration(milliseconds: 300),
      verify: (bloc) {
        // getCommunity called first
        verify(() => mockRepo.getCommunity(_communityId)).called(1);
        // All three watch methods are called
        verify(() => mockRepo.watchMembers(_communityId)).called(1);
        verify(() => mockRepo.watchTransactions(_communityId)).called(1);
        verify(() => mockRepo.watchPendingApprovals(_communityId)).called(1);
        verify(() => mockRepo.refreshMembers(_communityId)).called(1);
        // State reflects all the loaded data
        expect(bloc.state.selectedCommunity, isNotNull);
        expect(bloc.state.selectedCommunity!.id, _communityId);
        expect(bloc.state.selectedCommunityMembers, hasLength(1));
        expect(bloc.state.selectedCommunityTransactions, hasLength(1));
        expect(bloc.state.selectedCommunityApprovals, hasLength(1));
      },
    );

    // =========================================================================
    // 5. Create community -> community list updated
    // =========================================================================
    blocTest<CommunityBloc, CommunityState>(
      '5. Create community -> new community added to state.communities list',
      seed: () => CommunityState(
        status: CommunityLoadingStatus.loaded,
        communities: [_makeCommunity()],
      ),
      build: () {
        final newCommunity = _makeCommunity(
          id: _communityId2,
          name: 'Second Community',
        );
        when(() => mockRepo.createCommunity(any()))
            .thenAnswer((_) async => Right(newCommunity));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        CommunityEvent.createCommunity(
          params: CreateCommunityParams(
            type: CommunityType.regular,
            name: 'Second Community',
          ),
        ),
      ),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        verify(() => mockRepo.createCommunity(any())).called(1);
        // Communities list now has both original and new community
        expect(bloc.state.communities, hasLength(2));
        expect(
          bloc.state.communities.map((c) => c.id),
          containsAll([_communityId, _communityId2]),
        );
      },
    );

    // =========================================================================
    // 6. Contribute -> success message with amount
    // =========================================================================
    blocTest<CommunityBloc, CommunityState>(
      '6. Contribute -> successMessage contains formatted amount',
      build: () {
        final transaction = _makeTransaction(
          amount: 1500,
          type: CommunityTransactionType.contribution,
          status: CommunityTransactionStatus.completed,
        );
        when(() => mockRepo.contribute(
              any(),
              any(),
              description: any(named: 'description'),
            )).thenAnswer((_) async => Right(transaction));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.contribute(
          communityId: _communityId,
          amount: 1500,
          description: 'Monthly contribution',
        ),
      ),
      // The BLoC emits: [processing, success (with message), idle (cleared)]
      // We check transient states for the success message.
      expect: () => [
        // processing
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        // success — message contains the amount
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.successMessage,
              'successMessage',
              contains('1500'),
            ),
        // idle — auto-reset
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (bloc) {
        verify(() => mockRepo.contribute(
              _communityId,
              1500,
              description: 'Monthly contribution',
            )).called(1);
      },
    );

    // =========================================================================
    // 7. Multiple operations sequence: Load -> select -> details -> contribute
    //    -> approve -> verify final state reflects all operations
    // =========================================================================
    blocTest<CommunityBloc, CommunityState>(
      '7. Multi-step: load communities -> load details -> contribute -> approve -> final state correct',
      build: () {
        final community = _makeCommunity(totalBalance: 10000);
        final members = [_makeMember(displayName: 'Alice')];
        final approval = _makeApproval(transactionId: 'txn_pending_1');
        final contributionTxn = _makeTransaction(
          id: 'txn_contrib_1',
          amount: 1000,
          type: CommunityTransactionType.contribution,
          status: CommunityTransactionStatus.completed,
        );

        // getUserCommunities
        when(() => mockRepo.getUserCommunities())
            .thenAnswer((_) async => Right([community]));

        // getCommunity (loadCommunityDetails)
        when(() => mockRepo.getCommunity(any()))
            .thenAnswer((_) async => Right(community));

        // Watch streams for subcollections
        when(() => mockRepo.watchMembers(_communityId)).thenAnswer(
          (_) => Stream.value(Right(members)),
        );
        when(() => mockRepo.watchTransactions(_communityId)).thenAnswer(
          (_) => Stream.value(Right([
            _makeTransaction(
              id: 'txn_existing',
              status: CommunityTransactionStatus.completed,
            ),
          ])),
        );
        when(() => mockRepo.watchPendingApprovals(_communityId)).thenAnswer(
          (_) => Stream.value(Right([approval])),
        );

        // contribute
        when(() => mockRepo.contribute(
              any(),
              any(),
              description: any(named: 'description'),
            )).thenAnswer((_) async => Right(contributionTxn));

        // approveTransaction
        when(() => mockRepo.approveTransaction(any(), any()))
            .thenAnswer((_) async => const Right(null));

        return buildBloc();
      },
      act: (bloc) async {
        // Step 1: Load communities
        bloc.add(const CommunityEvent.loadUserCommunities());
        await Future.delayed(const Duration(milliseconds: 200));

        // Step 2: Load community details (triggers watchMembers,
        // watchTransactions, watchPendingApprovals)
        bloc.add(const CommunityEvent.loadCommunityDetails(
          communityId: _communityId,
        ));
        await Future.delayed(const Duration(milliseconds: 200));

        // Step 3: Contribute
        bloc.add(const CommunityEvent.contribute(
          communityId: _communityId,
          amount: 1000,
        ));
        await Future.delayed(const Duration(milliseconds: 200));

        // Step 4: Approve the pending transaction
        bloc.add(const CommunityEvent.approveTransaction(
          communityId: _communityId,
          transactionId: 'txn_pending_1',
        ));
        await Future.delayed(const Duration(milliseconds: 200));
      },
      wait: const Duration(milliseconds: 300),
      verify: (bloc) {
        // Verify all repository methods were called in the expected sequence
        verify(() => mockRepo.getUserCommunities()).called(1);
        verify(() => mockRepo.getCommunity(_communityId)).called(1);
        verify(() => mockRepo.watchMembers(_communityId)).called(1);
        verify(() => mockRepo.watchTransactions(_communityId)).called(1);
        verify(() => mockRepo.watchPendingApprovals(_communityId)).called(1);
        verify(() => mockRepo.contribute(
              _communityId,
              1000,
              description: null,
            )).called(1);
        verify(() => mockRepo.approveTransaction(
              _communityId,
              'txn_pending_1',
            )).called(1);

        // Final state assertions
        final s = bloc.state;

        // Communities list was loaded
        expect(s.status, CommunityLoadingStatus.loaded);
        expect(s.communities, hasLength(1));
        expect(s.communities.first.id, _communityId);

        // Selected community was set
        expect(s.selectedCommunity, isNotNull);
        expect(s.selectedCommunity!.id, _communityId);

        // Members stream populated state
        expect(s.selectedCommunityMembers, hasLength(1));
        expect(s.selectedCommunityMembers.first.displayName, 'Alice');

        // Transactions stream populated state
        expect(s.selectedCommunityTransactions, hasLength(1));

        // Approval was optimistically removed after approve
        expect(
          s.selectedCommunityApprovals
              .where((a) => a.transactionId == 'txn_pending_1'),
          isEmpty,
        );

        // Operation returned to idle after all operations
        expect(s.operationStatus, CommunityOperationStatus.idle);
      },
    );
  });
}
