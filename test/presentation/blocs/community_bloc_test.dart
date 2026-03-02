import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:imalichat/core/error/failures.dart';
import 'package:imalichat/domain/entities/community.dart';
import 'package:imalichat/domain/entities/community_member.dart';
import 'package:imalichat/domain/entities/community_transaction.dart';
import 'package:imalichat/domain/entities/stokvel_analytics.dart';
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
const _transactionId2 = 'txn_2';

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

void main() {
  late MockCommunityRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(FakeCreateCommunityParams());
    registerFallbackValue(FakeUpdateCommunityParams());
    registerFallbackValue(MemberRole.member);
  });

  setUp(() {
    mockRepo = MockCommunityRepository();

    // Stub streams that are auto-triggered by various handlers
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

  // ===========================================================================
  // INITIAL STATE
  // ===========================================================================

  group('initial state', () {
    test('has correct defaults', () {
      final bloc = buildBloc();
      expect(bloc.state.status, CommunityLoadingStatus.initial);
      expect(bloc.state.operationStatus, CommunityOperationStatus.idle);
      expect(bloc.state.communities, isEmpty);
      expect(bloc.state.pendingInvitations, isEmpty);
      expect(bloc.state.selectedCommunity, isNull);
      expect(bloc.state.selectedCommunityMembers, isEmpty);
      expect(bloc.state.selectedCommunityTransactions, isEmpty);
      expect(bloc.state.selectedCommunityApprovals, isEmpty);
      expect(bloc.state.totalUnreadCount, 0);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.successMessage, isNull);
      bloc.close();
    });
  });

  // ===========================================================================
  // createCommunity
  // ===========================================================================

  group('createCommunity', () {
    final params = CreateCommunityParams(
      type: CommunityType.regular,
      name: 'New Community',
    );
    final createdCommunity = _makeCommunity(name: 'New Community');

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success, idle] on success',
      build: () {
        when(() => mockRepo.createCommunity(any()))
            .thenAnswer((_) async => Right(createdCommunity));
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(CommunityEvent.createCommunity(params: params)),
      expect: () => [
        // processing
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        // success with community added to list
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.communities.length,
              'communities.length',
              1,
            )
            .having(
              (s) => s.successMessage,
              'successMessage',
              contains('created successfully'),
            ),
        // auto-reset to idle
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (_) {
        verify(() => mockRepo.createCommunity(any())).called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      build: () {
        when(() => mockRepo.createCommunity(any()))
            .thenAnswer((_) async => const Left(Failure.serverError(
                  message: 'Community creation failed',
                )));
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(CommunityEvent.createCommunity(params: params)),
      expect: () => [
        // processing
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        // failure
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.failure,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              'Community creation failed',
            ),
        // auto-reset to idle
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // deleteCommunity
  // ===========================================================================

  group('deleteCommunity', () {
    final community1 = _makeCommunity();
    final community2 = _makeCommunity(id: _communityId2, name: 'Second');

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success with community removed, idle] on success '
      'and resets totalUnreadCount to 0',
      seed: () => CommunityState(
        communities: [community1, community2],
        totalUnreadCount: 5,
      ),
      build: () {
        when(() => mockRepo.deleteCommunity(any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc
          .add(const CommunityEvent.deleteCommunity(communityId: _communityId)),
      expect: () => [
        // processing
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        // success: community removed, unread reset, selected cleared
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.communities.length,
              'communities.length',
              1,
            )
            .having(
              (s) => s.communities.first.id,
              'remaining community id',
              _communityId2,
            )
            .having(
              (s) => s.totalUnreadCount,
              'totalUnreadCount',
              0,
            )
            .having(
              (s) => s.selectedCommunity,
              'selectedCommunity',
              isNull,
            ),
        // auto-reset to idle
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (_) {
        verify(() => mockRepo.deleteCommunity(_communityId)).called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      seed: () => CommunityState(communities: [community1]),
      build: () {
        when(() => mockRepo.deleteCommunity(any()))
            .thenAnswer((_) async => const Left(Failure.serverError(
                  message: 'Delete failed',
                )));
        return buildBloc();
      },
      act: (bloc) => bloc
          .add(const CommunityEvent.deleteCommunity(communityId: _communityId)),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.failure,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // inviteMember
  // ===========================================================================

  group('inviteMember', () {
    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success, idle] on success',
      build: () {
        when(() => mockRepo.inviteMember(any(), any(), any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.inviteMember(
        communityId: _communityId,
        userId: _memberId2,
        role: MemberRole.member,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.successMessage,
              'successMessage',
              'Invitation sent successfully',
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (_) {
        verify(() =>
            mockRepo.inviteMember(_communityId, _memberId2, MemberRole.member))
            .called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      build: () {
        when(() => mockRepo.inviteMember(any(), any(), any()))
            .thenAnswer((_) async => const Left(Failure.serverError(
                  message: 'User not found',
                )));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.inviteMember(
        communityId: _communityId,
        userId: _memberId2,
        role: MemberRole.member,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.failure,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              'User not found',
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // acceptInvitation
  // ===========================================================================

  group('acceptInvitation', () {
    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success, idle] on success and triggers list refresh',
      build: () {
        when(() => mockRepo.acceptInvitation(any()))
            .thenAnswer((_) async => const Right(null));
        // Stubs for the auto-triggered loadUserCommunities + loadPendingInvitations
        when(() => mockRepo.getUserCommunities())
            .thenAnswer((_) async => Right([_makeCommunity()]));
        when(() => mockRepo.getPendingInvitations())
            .thenAnswer((_) async => const Right([]));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.acceptInvitation(communityId: _communityId),
      ),
      expect: () => [
        // processing
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        // success
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.success,
        ),
        // auto-reset to idle
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
        // Then loadUserCommunities fires: loading status
        isA<CommunityState>().having(
          (s) => s.status,
          'status',
          CommunityLoadingStatus.loading,
        ),
        // loadUserCommunities succeeds: loaded with communities
        // Note: loadPendingInvitations (returning []) is deduplicated by
        // Bloc because pendingInvitations defaults to [] and the result is
        // also [], so no separate emission appears.
        isA<CommunityState>()
            .having(
              (s) => s.status,
              'status',
              CommunityLoadingStatus.loaded,
            )
            .having(
              (s) => s.communities.length,
              'communities.length',
              1,
            ),
      ],
      verify: (_) {
        verify(() => mockRepo.acceptInvitation(_communityId)).called(1);
        verify(() => mockRepo.getUserCommunities()).called(1);
        verify(() => mockRepo.getPendingInvitations()).called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      build: () {
        when(() => mockRepo.acceptInvitation(any()))
            .thenAnswer((_) async => const Left(Failure.serverError(
                  message: 'Invitation expired',
                )));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.acceptInvitation(communityId: _communityId),
      ),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.failure,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              'Invitation expired',
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // declineInvitation
  // ===========================================================================

  group('declineInvitation', () {
    final invitation = _makeMember(
      communityId: _communityId,
      status: MemberStatus.invited,
      communityName: 'Test Community',
    );
    final invitation2 = _makeMember(
      id: _memberId2,
      communityId: _communityId2,
      status: MemberStatus.invited,
      communityName: 'Other Community',
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success with invitation removed, idle] on success',
      seed: () =>
          CommunityState(pendingInvitations: [invitation, invitation2]),
      build: () {
        when(() => mockRepo.declineInvitation(any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.declineInvitation(communityId: _communityId),
      ),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.pendingInvitations.length,
              'pendingInvitations.length',
              1,
            )
            .having(
              (s) => s.pendingInvitations.first.communityId,
              'remaining invitation communityId',
              _communityId2,
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (_) {
        verify(() => mockRepo.declineInvitation(_communityId)).called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      seed: () => CommunityState(pendingInvitations: [invitation]),
      build: () {
        when(() => mockRepo.declineInvitation(any()))
            .thenAnswer((_) async => const Left(Failure.network()));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.declineInvitation(communityId: _communityId),
      ),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.failure,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // removeMember
  // ===========================================================================

  group('removeMember', () {
    final member1 = _makeMember(id: _memberId, displayName: 'Alice');
    final member2 = _makeMember(id: _memberId2, displayName: 'Bob');

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success with member removed optimistically, idle]',
      seed: () => CommunityState(
        selectedCommunityMembers: [member1, member2],
      ),
      build: () {
        when(() => mockRepo.removeMember(any(), any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.removeMember(
        communityId: _communityId,
        memberId: _memberId,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.selectedCommunityMembers.length,
              'members.length',
              1,
            )
            .having(
              (s) => s.selectedCommunityMembers.first.id,
              'remaining member id',
              _memberId2,
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (_) {
        verify(() => mockRepo.removeMember(_communityId, _memberId)).called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      seed: () => CommunityState(
        selectedCommunityMembers: [member1, member2],
      ),
      build: () {
        when(() => mockRepo.removeMember(any(), any()))
            .thenAnswer((_) async => const Left(Failure.serverError(
                  message: 'Cannot remove owner',
                )));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.removeMember(
        communityId: _communityId,
        memberId: _memberId,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.failure,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // updateMemberRole
  // ===========================================================================

  group('updateMemberRole', () {
    final member1 = _makeMember(
      id: _memberId,
      displayName: 'Alice',
      role: MemberRole.member,
    );
    final member2 = _makeMember(
      id: _memberId2,
      displayName: 'Bob',
      role: MemberRole.member,
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success with role updated optimistically, idle]',
      seed: () => CommunityState(
        selectedCommunityMembers: [member1, member2],
      ),
      build: () {
        when(() => mockRepo.updateMemberRole(any(), any(), any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.updateMemberRole(
        communityId: _communityId,
        memberId: _memberId,
        role: MemberRole.admin,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.selectedCommunityMembers
                  .firstWhere((m) => m.id == _memberId)
                  .role,
              'updated member role',
              MemberRole.admin,
            )
            .having(
              (s) => s.selectedCommunityMembers
                  .firstWhere((m) => m.id == _memberId2)
                  .role,
              'other member role unchanged',
              MemberRole.member,
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (_) {
        verify(() => mockRepo.updateMemberRole(
              _communityId,
              _memberId,
              MemberRole.admin,
            )).called(1);
      },
    );
  });

  // ===========================================================================
  // approveTransaction
  // ===========================================================================

  group('approveTransaction', () {
    final approval1 = _makeApproval(
      id: 'approval_1',
      transactionId: _transactionId,
    );
    final approval2 = _makeApproval(
      id: 'approval_2',
      transactionId: _transactionId2,
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success with approval removed optimistically, idle]',
      seed: () => CommunityState(
        selectedCommunityApprovals: [approval1, approval2],
      ),
      build: () {
        when(() => mockRepo.approveTransaction(any(), any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.approveTransaction(
        communityId: _communityId,
        transactionId: _transactionId,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.selectedCommunityApprovals.length,
              'approvals.length',
              1,
            )
            .having(
              (s) => s.selectedCommunityApprovals.first.transactionId,
              'remaining approval transactionId',
              _transactionId2,
            )
            .having(
              (s) => s.successMessage,
              'successMessage',
              'Transaction approved',
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (_) {
        verify(() =>
            mockRepo.approveTransaction(_communityId, _transactionId))
            .called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      seed: () => CommunityState(
        selectedCommunityApprovals: [approval1],
      ),
      build: () {
        when(() => mockRepo.approveTransaction(any(), any()))
            .thenAnswer((_) async => const Left(Failure.serverError(
                  message: 'Already approved',
                )));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.approveTransaction(
        communityId: _communityId,
        transactionId: _transactionId,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.failure,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // rejectTransaction
  // ===========================================================================

  group('rejectTransaction', () {
    final approval1 = _makeApproval(
      id: 'approval_1',
      transactionId: _transactionId,
    );
    final approval2 = _makeApproval(
      id: 'approval_2',
      transactionId: _transactionId2,
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success with approval removed optimistically, idle]',
      seed: () => CommunityState(
        selectedCommunityApprovals: [approval1, approval2],
      ),
      build: () {
        when(() => mockRepo.rejectTransaction(any(), any(), reason: any(named: 'reason')))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.rejectTransaction(
        communityId: _communityId,
        transactionId: _transactionId,
        reason: 'Insufficient documentation',
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.selectedCommunityApprovals.length,
              'approvals.length',
              1,
            )
            .having(
              (s) => s.selectedCommunityApprovals.first.transactionId,
              'remaining approval transactionId',
              _transactionId2,
            )
            .having(
              (s) => s.successMessage,
              'successMessage',
              'Transaction rejected',
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (_) {
        verify(() => mockRepo.rejectTransaction(
              _communityId,
              _transactionId,
              reason: 'Insufficient documentation',
            )).called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      seed: () => CommunityState(
        selectedCommunityApprovals: [approval1],
      ),
      build: () {
        when(() => mockRepo.rejectTransaction(any(), any(), reason: any(named: 'reason')))
            .thenAnswer((_) async => const Left(Failure.network()));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.rejectTransaction(
        communityId: _communityId,
        transactionId: _transactionId,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.failure,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // contribute
  // ===========================================================================

  group('contribute', () {
    final completedTxn = _makeTransaction(
      type: CommunityTransactionType.contribution,
      amount: 500,
      status: CommunityTransactionStatus.completed,
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success, idle] on success',
      build: () {
        when(() => mockRepo.contribute(any(), any(),
                description: any(named: 'description')))
            .thenAnswer((_) async => Right(completedTxn));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.contribute(
        communityId: _communityId,
        amount: 500,
        description: 'Monthly contribution',
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.successMessage,
              'successMessage',
              contains('500 tokens'),
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (_) {
        verify(() => mockRepo.contribute(
              _communityId,
              500,
              description: 'Monthly contribution',
            )).called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      build: () {
        when(() => mockRepo.contribute(any(), any(),
                description: any(named: 'description')))
            .thenAnswer(
                (_) async => const Left(Failure.insufficientBalance()));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.contribute(
        communityId: _communityId,
        amount: 500,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.failure,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              contains('Insufficient balance'),
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // withdraw
  // ===========================================================================

  group('withdraw', () {
    blocTest<CommunityBloc, CommunityState>(
      'emits success with immediate withdrawal message when not pending',
      build: () {
        final completedTxn = _makeTransaction(
          type: CommunityTransactionType.withdrawal,
          amount: 1000,
          status: CommunityTransactionStatus.completed,
        );
        when(() => mockRepo.withdraw(any(), any(),
                description: any(named: 'description')))
            .thenAnswer((_) async => Right(completedTxn));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.withdraw(
        communityId: _communityId,
        amount: 1000,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.successMessage,
              'successMessage',
              contains('1000 tokens successful'),
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits success with pending approval message when transaction is pending',
      build: () {
        final pendingTxn = _makeTransaction(
          type: CommunityTransactionType.withdrawal,
          amount: 10000,
          status: CommunityTransactionStatus.pending,
        );
        when(() => mockRepo.withdraw(any(), any(),
                description: any(named: 'description')))
            .thenAnswer((_) async => Right(pendingTxn));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.withdraw(
        communityId: _communityId,
        amount: 10000,
        description: 'Large withdrawal',
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.successMessage,
              'successMessage',
              contains('submitted for approval'),
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      build: () {
        when(() => mockRepo.withdraw(any(), any(),
                description: any(named: 'description')))
            .thenAnswer(
                (_) async => const Left(Failure.insufficientBalance()));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.withdraw(
        communityId: _communityId,
        amount: 999999,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.failure,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // clearError
  // ===========================================================================

  group('clearError', () {
    blocTest<CommunityBloc, CommunityState>(
      'resets operationStatus to idle and clears messages',
      seed: () => const CommunityState(
        operationStatus: CommunityOperationStatus.failure,
        errorMessage: 'Some error',
        successMessage: 'Some success',
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(const CommunityEvent.clearError()),
      expect: () => [
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.idle,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              isNull,
            )
            .having(
              (s) => s.successMessage,
              'successMessage',
              isNull,
            ),
      ],
    );
  });

  // ===========================================================================
  // loadPendingInvitations
  // ===========================================================================

  group('loadPendingInvitations', () {
    final invitations = [
      _makeMember(
        id: 'inv_1',
        communityId: _communityId,
        status: MemberStatus.invited,
        communityName: 'Community A',
      ),
      _makeMember(
        id: 'inv_2',
        communityId: _communityId2,
        status: MemberStatus.invited,
        communityName: 'Community B',
      ),
    ];

    blocTest<CommunityBloc, CommunityState>(
      'emits state with pendingInvitations on success',
      build: () {
        when(() => mockRepo.getPendingInvitations())
            .thenAnswer((_) async => Right(invitations));
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const CommunityEvent.loadPendingInvitations()),
      expect: () => [
        isA<CommunityState>()
            .having(
              (s) => s.pendingInvitations.length,
              'pendingInvitations.length',
              2,
            )
            .having(
              (s) => s.pendingInvitations.first.communityName,
              'first invitation communityName',
              'Community A',
            ),
      ],
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits errorMessage on failure (not just debugPrint)',
      build: () {
        when(() => mockRepo.getPendingInvitations())
            .thenAnswer((_) async => const Left(Failure.network(
                  message: 'Connection lost',
                )));
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const CommunityEvent.loadPendingInvitations()),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.errorMessage,
          'errorMessage',
          contains('Connection lost'),
        ),
      ],
    );
  });

  // ===========================================================================
  // selectedCommunity invalidated
  // ===========================================================================

  group('selectedCommunity invalidated on userCommunitiesUpdated', () {
    final community1 = _makeCommunity(id: _communityId, name: 'Comm1');
    final community2 = _makeCommunity(id: _communityId2, name: 'Comm2');

    blocTest<CommunityBloc, CommunityState>(
      'nullifies selectedCommunity when it is no longer in the communities list',
      seed: () => CommunityState(
        communities: [community1, community2],
        selectedCommunity: community1,
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(
        // Updated list no longer contains community1
        CommunityEvent.userCommunitiesUpdated([community2]),
      ),
      expect: () => [
        isA<CommunityState>()
            .having(
              (s) => s.communities.length,
              'communities.length',
              1,
            )
            .having(
              (s) => s.selectedCommunity,
              'selectedCommunity',
              isNull,
            )
            .having(
              (s) => s.status,
              'status',
              CommunityLoadingStatus.loaded,
            ),
      ],
    );

    blocTest<CommunityBloc, CommunityState>(
      'keeps selectedCommunity when it still exists in the communities list',
      seed: () => CommunityState(
        communities: [community1, community2],
        selectedCommunity: community1,
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(
        CommunityEvent.userCommunitiesUpdated([community1, community2]),
      ),
      expect: () => [
        isA<CommunityState>()
            .having(
              (s) => s.communities.length,
              'communities.length',
              2,
            )
            .having(
              (s) => s.selectedCommunity,
              'selectedCommunity',
              isNotNull,
            )
            .having(
              (s) => s.selectedCommunity?.id,
              'selectedCommunity.id',
              _communityId,
            ),
      ],
    );
  });

  // ===========================================================================
  // loadUserCommunities
  // ===========================================================================

  group('loadUserCommunities', () {
    blocTest<CommunityBloc, CommunityState>(
      'emits [loading, loaded] on success and auto-starts watch',
      build: () {
        when(() => mockRepo.getUserCommunities())
            .thenAnswer((_) async => Right([_makeCommunity()]));
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const CommunityEvent.loadUserCommunities()),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.status,
          'status',
          CommunityLoadingStatus.loading,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.status,
              'status',
              CommunityLoadingStatus.loaded,
            )
            .having(
              (s) => s.communities.length,
              'communities.length',
              1,
            ),
      ],
      verify: (_) {
        verify(() => mockRepo.getUserCommunities()).called(1);
        // watchUserCommunities should be auto-triggered
        verify(() => mockRepo.watchUserCommunities()).called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [loading, error] on failure',
      build: () {
        when(() => mockRepo.getUserCommunities())
            .thenAnswer((_) async => const Left(Failure.network(
                  message: 'Network error',
                )));
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const CommunityEvent.loadUserCommunities()),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.status,
          'status',
          CommunityLoadingStatus.loading,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.status,
              'status',
              CommunityLoadingStatus.error,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              'Network error',
            ),
      ],
      verify: (_) {
        // watchUserCommunities should NOT be called on failure
        verifyNever(() => mockRepo.watchUserCommunities());
      },
    );
  });

  // ===========================================================================
  // loadCommunityDetails
  // ===========================================================================

  group('loadCommunityDetails', () {
    final community = _makeCommunity();

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, idle with selectedCommunity] on success and starts watches',
      build: () {
        when(() => mockRepo.getCommunity(any()))
            .thenAnswer((_) async => Right(community));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.loadCommunityDetails(
            communityId: _communityId),
      ),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.idle,
            )
            .having(
              (s) => s.selectedCommunity?.id,
              'selectedCommunity.id',
              _communityId,
            ),
      ],
      verify: (_) {
        verify(() => mockRepo.getCommunity(_communityId)).called(1);
        // Sub-watches should be started
        verify(() => mockRepo.watchMembers(_communityId)).called(1);
        verify(() => mockRepo.watchTransactions(_communityId)).called(1);
        verify(() => mockRepo.watchPendingApprovals(_communityId)).called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, failure, idle] on error',
      build: () {
        when(() => mockRepo.getCommunity(any()))
            .thenAnswer((_) async => const Left(Failure.serverError(
                  message: 'Community not found',
                )));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.loadCommunityDetails(
            communityId: _communityId),
      ),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.failure,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              'Community not found',
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // unreadCountUpdated
  // ===========================================================================

  group('unreadCountUpdated', () {
    blocTest<CommunityBloc, CommunityState>(
      'updates totalUnreadCount in state',
      build: buildBloc,
      act: (bloc) =>
          bloc.add(const CommunityEvent.unreadCountUpdated(7)),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.totalUnreadCount,
          'totalUnreadCount',
          7,
        ),
      ],
    );
  });

  // ===========================================================================
  // membersUpdated
  // ===========================================================================

  group('membersUpdated', () {
    final members = [
      _makeMember(id: _memberId, displayName: 'Alice'),
      _makeMember(id: _memberId2, displayName: 'Bob'),
    ];

    blocTest<CommunityBloc, CommunityState>(
      'updates selectedCommunityMembers in state',
      build: buildBloc,
      act: (bloc) => bloc.add(CommunityEvent.membersUpdated(members)),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.selectedCommunityMembers.length,
          'selectedCommunityMembers.length',
          2,
        ),
      ],
    );
  });

  // ===========================================================================
  // transactionsUpdated
  // ===========================================================================

  group('transactionsUpdated', () {
    final transactions = [
      _makeTransaction(id: _transactionId),
      _makeTransaction(id: _transactionId2),
    ];

    blocTest<CommunityBloc, CommunityState>(
      'updates selectedCommunityTransactions in state',
      build: buildBloc,
      act: (bloc) =>
          bloc.add(CommunityEvent.transactionsUpdated(transactions)),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.selectedCommunityTransactions.length,
          'selectedCommunityTransactions.length',
          2,
        ),
      ],
    );
  });

  // ===========================================================================
  // pendingApprovalsUpdated
  // ===========================================================================

  group('pendingApprovalsUpdated', () {
    final approvals = [_makeApproval()];

    blocTest<CommunityBloc, CommunityState>(
      'updates selectedCommunityApprovals in state',
      build: buildBloc,
      act: (bloc) =>
          bloc.add(CommunityEvent.pendingApprovalsUpdated(approvals)),
      expect: () => [
        isA<CommunityState>()
            .having(
              (s) => s.selectedCommunityApprovals.length,
              'selectedCommunityApprovals.length',
              1,
            )
            .having(
              (s) => s.hasPendingApprovals,
              'hasPendingApprovals',
              isTrue,
            ),
      ],
    );
  });

  // ===========================================================================
  // clearSelectedCommunity
  // ===========================================================================

  group('clearSelectedCommunity', () {
    blocTest<CommunityBloc, CommunityState>(
      'clears selectedCommunity, members, transactions, and approvals',
      seed: () => CommunityState(
        selectedCommunity: _makeCommunity(),
        selectedCommunityMembers: [_makeMember()],
        selectedCommunityTransactions: [_makeTransaction()],
        selectedCommunityApprovals: [_makeApproval()],
      ),
      build: buildBloc,
      act: (bloc) =>
          bloc.add(const CommunityEvent.clearSelectedCommunity()),
      expect: () => [
        isA<CommunityState>()
            .having(
              (s) => s.selectedCommunity,
              'selectedCommunity',
              isNull,
            )
            .having(
              (s) => s.selectedCommunityMembers,
              'selectedCommunityMembers',
              isEmpty,
            )
            .having(
              (s) => s.selectedCommunityTransactions,
              'selectedCommunityTransactions',
              isEmpty,
            )
            .having(
              (s) => s.selectedCommunityApprovals,
              'selectedCommunityApprovals',
              isEmpty,
            ),
      ],
    );
  });

  // ===========================================================================
  // leaveCommunity
  // ===========================================================================

  group('leaveCommunity', () {
    final community1 = _makeCommunity(id: _communityId, name: 'Comm1');
    final community2 = _makeCommunity(id: _communityId2, name: 'Comm2');

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success with community removed + detail cleared, idle]',
      seed: () => CommunityState(
        communities: [community1, community2],
        selectedCommunity: community1,
        selectedCommunityMembers: [_makeMember()],
        selectedCommunityTransactions: [_makeTransaction()],
        selectedCommunityApprovals: [_makeApproval()],
      ),
      build: () {
        when(() => mockRepo.leaveCommunity(any()))
            .thenAnswer((_) async => const Right(null));
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.leaveCommunity(communityId: _communityId),
      ),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.communities.length,
              'communities.length',
              1,
            )
            .having(
              (s) => s.communities.first.id,
              'remaining community id',
              _communityId2,
            )
            .having(
              (s) => s.selectedCommunity,
              'selectedCommunity',
              isNull,
            )
            .having(
              (s) => s.selectedCommunityMembers,
              'members',
              isEmpty,
            )
            .having(
              (s) => s.selectedCommunityTransactions,
              'transactions',
              isEmpty,
            )
            .having(
              (s) => s.selectedCommunityApprovals,
              'approvals',
              isEmpty,
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
      verify: (_) {
        verify(() => mockRepo.leaveCommunity(_communityId)).called(1);
      },
    );
  });

  // ===========================================================================
  // updateCommunity
  // ===========================================================================

  group('updateCommunity', () {
    final params = UpdateCommunityParams(name: 'Updated Name');

    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success, idle] on success and triggers detail reload',
      build: () {
        when(() => mockRepo.updateCommunity(any(), any()))
            .thenAnswer((_) async => const Right(null));
        // Stub for the auto-triggered loadCommunityDetails
        when(() => mockRepo.getCommunity(any()))
            .thenAnswer((_) async => Right(_makeCommunity(name: 'Updated Name')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(CommunityEvent.updateCommunity(
        communityId: _communityId,
        params: params,
      )),
      expect: () => [
        // processing
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        // success
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.success,
        ),
        // auto-reset to idle
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
        // Then loadCommunityDetails fires: processing
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        // loadCommunityDetails succeeds
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.idle,
            )
            .having(
              (s) => s.selectedCommunity?.name,
              'updated name',
              'Updated Name',
            ),
      ],
      verify: (_) {
        verify(() => mockRepo.updateCommunity(_communityId, any())).called(1);
        verify(() => mockRepo.getCommunity(_communityId)).called(1);
      },
    );
  });

  // ===========================================================================
  // triggerPayout
  // ===========================================================================

  group('triggerPayout', () {
    blocTest<CommunityBloc, CommunityState>(
      'emits [processing, success, idle] on success and refreshes details',
      build: () {
        when(() => mockRepo.triggerPayout(any(), recipientId: any(named: 'recipientId')))
            .thenAnswer((_) async => Right(const StokvelPayoutResult(
                  transactionId: 'txn_payout',
                  journalId: 'jnl_1',
                  recipientId: _memberId,
                  amount: 5000,
                )));
        // Stub for auto-triggered loadCommunityDetails
        when(() => mockRepo.getCommunity(any()))
            .thenAnswer((_) async => Right(_makeCommunity(totalBalance: 5000)));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.triggerPayout(
        communityId: _communityId,
        recipientId: _memberId,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.operationStatus,
              'operationStatus',
              CommunityOperationStatus.success,
            )
            .having(
              (s) => s.successMessage,
              'successMessage',
              contains('5000 tokens'),
            ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
        // loadCommunityDetails auto-triggered
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.processing,
        ),
        isA<CommunityState>().having(
          (s) => s.operationStatus,
          'operationStatus',
          CommunityOperationStatus.idle,
        ),
      ],
    );
  });

  // ===========================================================================
  // loadAnalytics
  // ===========================================================================

  group('loadAnalytics', () {
    final analytics = StokvelAnalytics(
      totalContributions: 50000,
      totalWithdrawals: 10000,
      totalPayouts: 5000,
      totalPenalties: 500,
      monthlyBreakdown: const {},
      memberContributions: const {},
      memberInfo: const {},
      currentBalance: 34500,
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [isLoadingAnalytics=true, loaded analytics] on success',
      build: () {
        when(() => mockRepo.getAnalytics(any(), months: any(named: 'months')))
            .thenAnswer((_) async => Right(analytics));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.loadAnalytics(
        communityId: _communityId,
        months: 3,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.isLoadingAnalytics,
          'isLoadingAnalytics',
          true,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.isLoadingAnalytics,
              'isLoadingAnalytics',
              false,
            )
            .having(
              (s) => s.stokvelAnalytics?.totalContributions,
              'totalContributions',
              50000,
            )
            .having(
              (s) => s.stokvelAnalytics?.currentBalance,
              'currentBalance',
              34500,
            ),
      ],
      verify: (_) {
        verify(() => mockRepo.getAnalytics(_communityId, months: 3)).called(1);
      },
    );

    blocTest<CommunityBloc, CommunityState>(
      'emits [isLoadingAnalytics=true, error] on failure',
      build: () {
        when(() => mockRepo.getAnalytics(any(), months: any(named: 'months')))
            .thenAnswer((_) async => const Left(Failure.serverError(
                  message: 'Analytics unavailable',
                )));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CommunityEvent.loadAnalytics(
        communityId: _communityId,
      )),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.isLoadingAnalytics,
          'isLoadingAnalytics',
          true,
        ),
        isA<CommunityState>()
            .having(
              (s) => s.isLoadingAnalytics,
              'isLoadingAnalytics',
              false,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              'Analytics unavailable',
            ),
      ],
    );
  });

  // ===========================================================================
  // Stream-based watch events (integration-style)
  // ===========================================================================

  group('watchUserCommunities stream integration', () {
    blocTest<CommunityBloc, CommunityState>(
      'processes community updates from stream',
      build: () {
        final communities = [_makeCommunity()];
        when(() => mockRepo.watchUserCommunities()).thenAnswer(
          (_) => Stream.value(Right(communities)),
        );
        when(() => mockRepo.watchTotalCommunityUnreadCount()).thenAnswer(
          (_) => Stream.value(const Right(3)),
        );
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const CommunityEvent.watchUserCommunities()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        // userCommunitiesUpdated from stream
        isA<CommunityState>()
            .having(
              (s) => s.status,
              'status',
              CommunityLoadingStatus.loaded,
            )
            .having(
              (s) => s.communities.length,
              'communities.length',
              1,
            ),
        // unreadCountUpdated from stream
        isA<CommunityState>().having(
          (s) => s.totalUnreadCount,
          'totalUnreadCount',
          3,
        ),
      ],
    );
  });

  group('watchMembers stream integration', () {
    blocTest<CommunityBloc, CommunityState>(
      'processes member updates from stream',
      build: () {
        final members = [_makeMember()];
        when(() => mockRepo.watchMembers(any())).thenAnswer(
          (_) => Stream.value(Right(members)),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const CommunityEvent.watchMembers(communityId: _communityId),
      ),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<CommunityState>().having(
          (s) => s.selectedCommunityMembers.length,
          'selectedCommunityMembers.length',
          1,
        ),
      ],
      verify: (_) {
        verify(() => mockRepo.refreshMembers(_communityId)).called(1);
      },
    );
  });

  // ===========================================================================
  // State helper methods
  // ===========================================================================

  group('CommunityState helper methods', () {
    test('isOwnerOf returns true for owner userId', () {
      final state = CommunityState(
        selectedCommunity: _makeCommunity(),
      );
      expect(state.isOwnerOf(_userId), isTrue);
      expect(state.isOwnerOf('other_user'), isFalse);
    });

    test('isOwnerOf returns false when no selectedCommunity', () {
      const state = CommunityState();
      expect(state.isOwnerOf(_userId), isFalse);
    });

    test('getMemberByUserId finds correct member', () {
      final member = _makeMember(userId: _userId);
      final state = CommunityState(
        selectedCommunityMembers: [member],
      );
      expect(state.getMemberByUserId(_userId), isNotNull);
      expect(state.getMemberByUserId(_userId)?.displayName, 'Test User');
      expect(state.getMemberByUserId('nonexistent'), isNull);
    });

    test('selectedCommunityBalance returns balance or 0', () {
      final state = CommunityState(
        selectedCommunity: _makeCommunity(totalBalance: 5000),
      );
      expect(state.selectedCommunityBalance, 5000);
      expect(state.selectedCommunityBalanceZar, 50.0);

      const emptyState = CommunityState();
      expect(emptyState.selectedCommunityBalance, 0);
      expect(emptyState.selectedCommunityBalanceZar, 0.0);
    });

    test('hasPendingApprovals returns correct value', () {
      const emptyState = CommunityState();
      expect(emptyState.hasPendingApprovals, isFalse);

      final withApprovals = CommunityState(
        selectedCommunityApprovals: [_makeApproval()],
      );
      expect(withApprovals.hasPendingApprovals, isTrue);
    });

    test('getCommunitiesByType filters correctly', () {
      final regular = _makeCommunity(
        id: 'reg_1',
        type: CommunityType.regular,
      );
      final stokvel = _makeCommunity(
        id: 'stk_1',
        type: CommunityType.stokvel,
      );
      final state = CommunityState(communities: [regular, stokvel]);

      expect(state.getCommunitiesByType(CommunityType.regular).length, 1);
      expect(state.getCommunitiesByType(CommunityType.stokvel).length, 1);
    });

    test('activeCommunities filters by active status', () {
      final active = _makeCommunity(
        id: 'a_1',
        status: CommunityStatus.active,
      );
      final suspended = _makeCommunity(
        id: 's_1',
        status: CommunityStatus.suspended,
      );
      final closed = _makeCommunity(
        id: 'c_1',
        status: CommunityStatus.closed,
      );
      final state = CommunityState(
        communities: [active, suspended, closed],
      );

      expect(state.activeCommunities.length, 1);
      expect(state.activeCommunities.first.id, 'a_1');
    });
  });
}
