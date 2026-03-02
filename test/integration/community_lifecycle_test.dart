import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/community.dart';
import 'package:imalichat/domain/entities/community_member.dart';
import 'package:imalichat/domain/entities/community_transaction.dart';
import 'package:imalichat/domain/entities/group.dart';
import 'package:imalichat/domain/entities/message.dart';
import 'package:imalichat/domain/enums/community_status.dart';
import 'package:imalichat/domain/enums/community_type.dart';
import 'package:imalichat/domain/enums/member_role.dart';
import 'package:imalichat/domain/enums/member_status.dart';
import 'package:imalichat/domain/enums/message_status.dart';
import 'package:imalichat/domain/enums/message_type.dart';
import 'package:imalichat/domain/repositories/community_repository.dart';
import 'package:mocktail/mocktail.dart';

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
// CONSTANTS
// =============================================================================

const _ownerId = 'owner_user_1';
const _memberId = 'invited_user_2';
const _communityId = 'community_abc';
const _communityName = 'Test Community';
const _stokvelCommunityId = 'stokvel_xyz';

// =============================================================================
// FIXTURES
// =============================================================================

Community _createCommunity({
  String id = _communityId,
  CommunityType type = CommunityType.regular,
  String name = _communityName,
  CommunityStatus status = CommunityStatus.active,
  List<String> memberIds = const ['owner_user_1'],
  List<String> adminIds = const ['owner_user_1'],
  int memberCount = 1,
  int totalBalance = 0,
  CommunitySettings? settings,
  StokvelSettings? stokvelSettings,
}) {
  return Community(
    id: id,
    type: type,
    name: name,
    description: 'A test community',
    ownerId: _ownerId,
    memberIds: memberIds,
    adminIds: adminIds,
    memberCount: memberCount,
    totalBalance: totalBalance,
    status: status,
    settings: settings ?? const CommunitySettings(),
    stokvelSettings: stokvelSettings,
    unreadCounts: const {},
    muted: const {},
    createdAt: DateTime(2026, 1, 1),
  );
}

CommunityMember _createMember({
  String userId = _memberId,
  String communityId = _communityId,
  MemberRole role = MemberRole.member,
  MemberStatus status = MemberStatus.active,
  int contributionBalance = 0,
  DateTime? joinedAt,
}) {
  return CommunityMember(
    id: '${communityId}_$userId',
    communityId: communityId,
    userId: userId,
    displayName: 'User $userId',
    role: role,
    status: status,
    contributionBalance: contributionBalance,
    joinedAt: joinedAt ?? DateTime(2026, 1, 2),
    invitedBy: _ownerId,
    invitedAt: DateTime(2026, 1, 1),
  );
}

CommunityTransaction _createTransaction({
  String id = 'txn_1',
  String communityId = _stokvelCommunityId,
  CommunityTransactionType type = CommunityTransactionType.contribution,
  int amount = 1000,
  CommunityTransactionStatus status = CommunityTransactionStatus.completed,
  String memberId = _ownerId,
  String? approvedBy,
}) {
  return CommunityTransaction(
    id: id,
    communityId: communityId,
    type: type,
    amount: amount,
    memberId: memberId,
    memberName: 'User $memberId',
    status: status,
    approvedBy: approvedBy,
    createdAt: DateTime(2026, 1, 5),
    completedAt:
        status == CommunityTransactionStatus.completed
            ? DateTime(2026, 1, 5)
            : null,
  );
}

Message _createMessage({
  String id = 'msg_1',
  String senderId = _ownerId,
  String communityId = _communityId,
}) {
  return Message(
    id: id,
    senderId: senderId,
    senderName: 'User $senderId',
    type: MessageType.text,
    status: MessageStatus.sent,
    textContent: 'Hello community!',
    communityId: communityId,
    createdAt: DateTime(2026, 1, 3),
  );
}

CommunityApproval _createApproval({
  String id = 'approval_1',
  String communityId = _stokvelCommunityId,
  String transactionId = 'txn_withdraw_1',
  int amount = 10000,
  ApprovalStatus status = ApprovalStatus.pending,
  List<String> approvers = const [],
}) {
  return CommunityApproval(
    id: id,
    communityId: communityId,
    transactionId: transactionId,
    requestedBy: _memberId,
    requestedByName: 'User $_memberId',
    amount: amount,
    type: CommunityTransactionType.withdrawal,
    approvers: approvers,
    requiredApprovals: 1,
    status: status,
    createdAt: DateTime(2026, 1, 6),
    expiresAt: DateTime.now().add(const Duration(days: 30)),
  );
}

// =============================================================================
// TESTS
// =============================================================================

void main() {
  late MockCommunityRepository repo;

  setUpAll(() {
    registerFallbackValue(FakeCreateCommunityParams());
    registerFallbackValue(FakeUpdateCommunityParams());
    registerFallbackValue(MemberRole.member);
  });

  setUp(() {
    repo = MockCommunityRepository();
  });

  // ---------------------------------------------------------------------------
  // 1. Create community -> verify state
  // ---------------------------------------------------------------------------
  group('Create community -> verify state', () {
    test('creates a regular community with correct fields and settings', () async {
      final settings = const CommunitySettings(
        maxMembers: 50,
        allowMemberInvites: true,
        onlyAdminsPost: false,
      );

      final expectedCommunity = _createCommunity(settings: settings);

      when(() => repo.createCommunity(any())).thenAnswer(
        (_) async => Right(expectedCommunity),
      );

      final result = await repo.createCommunity(
        CreateCommunityParams(
          type: CommunityType.regular,
          name: _communityName,
          description: 'A test community',
          settings: settings,
        ),
      );

      expect(result.isRight(), isTrue);
      final community = result.getOrElse(() => throw Exception('Expected Right'));

      expect(community.name, equals(_communityName));
      expect(community.type, equals(CommunityType.regular));
      expect(community.status, equals(CommunityStatus.active));
      expect(community.ownerId, equals(_ownerId));
      expect(community.settings.maxMembers, equals(50));
      expect(community.settings.allowMemberInvites, isTrue);
      expect(community.settings.onlyAdminsPost, isFalse);
      expect(community.memberIds, contains(_ownerId));
      expect(community.memberCount, equals(1));

      verify(() => repo.createCommunity(any())).called(1);
    });
  });

  // ---------------------------------------------------------------------------
  // 2. Invite -> accept flow
  // ---------------------------------------------------------------------------
  group('Invite -> accept flow', () {
    test('invite member then accept produces active member with correct role',
        () async {
      final community = _createCommunity();

      // Step 1: Create community
      when(() => repo.createCommunity(any())).thenAnswer(
        (_) async => Right(community),
      );

      // Step 2: Invite member
      when(() => repo.inviteMember(_communityId, _memberId, MemberRole.member))
          .thenAnswer((_) async => const Right(null));

      // Step 3: Accept invitation
      when(() => repo.acceptInvitation(_communityId))
          .thenAnswer((_) async => const Right(null));

      // Step 4: Get members (after acceptance)
      final ownerMember = _createMember(
        userId: _ownerId,
        role: MemberRole.owner,
        status: MemberStatus.active,
      );
      final acceptedMember = _createMember(
        userId: _memberId,
        role: MemberRole.member,
        status: MemberStatus.active,
      );

      when(() => repo.getMembers(_communityId)).thenAnswer(
        (_) async => Right([ownerMember, acceptedMember]),
      );

      // Execute the flow
      final createResult = await repo.createCommunity(
        CreateCommunityParams(
          type: CommunityType.regular,
          name: _communityName,
        ),
      );
      expect(createResult.isRight(), isTrue);

      final inviteResult = await repo.inviteMember(
        _communityId,
        _memberId,
        MemberRole.member,
      );
      expect(inviteResult.isRight(), isTrue);

      final acceptResult = await repo.acceptInvitation(_communityId);
      expect(acceptResult.isRight(), isTrue);

      final membersResult = await repo.getMembers(_communityId);
      expect(membersResult.isRight(), isTrue);

      final members = membersResult.getOrElse(() => []);
      expect(members.length, equals(2));

      final invited = members.firstWhere((m) => m.userId == _memberId);
      expect(invited.role, equals(MemberRole.member));
      expect(invited.status, equals(MemberStatus.active));
      expect(invited.isActive, isTrue);

      // Verify call sequence
      verify(() => repo.createCommunity(any())).called(1);
      verify(() => repo.inviteMember(_communityId, _memberId, MemberRole.member))
          .called(1);
      verify(() => repo.acceptInvitation(_communityId)).called(1);
      verify(() => repo.getMembers(_communityId)).called(1);
    });
  });

  // ---------------------------------------------------------------------------
  // 3. Invite -> decline flow
  // ---------------------------------------------------------------------------
  group('Invite -> decline flow', () {
    test('invite member then decline removes member from pending invitations',
        () async {
      // Invite member
      when(() => repo.inviteMember(_communityId, _memberId, MemberRole.member))
          .thenAnswer((_) async => const Right(null));

      // Decline invitation
      when(() => repo.declineInvitation(_communityId))
          .thenAnswer((_) async => const Right(null));

      // After decline, pending invitations should be empty
      when(() => repo.getPendingInvitations()).thenAnswer(
        (_) async => const Right(<CommunityMember>[]),
      );

      final inviteResult = await repo.inviteMember(
        _communityId,
        _memberId,
        MemberRole.member,
      );
      expect(inviteResult.isRight(), isTrue);

      final declineResult = await repo.declineInvitation(_communityId);
      expect(declineResult.isRight(), isTrue);

      final pendingResult = await repo.getPendingInvitations();
      expect(pendingResult.isRight(), isTrue);

      final pending = pendingResult.getOrElse(() => []);
      expect(pending, isEmpty);

      verify(() => repo.inviteMember(_communityId, _memberId, MemberRole.member))
          .called(1);
      verify(() => repo.declineInvitation(_communityId)).called(1);
      verify(() => repo.getPendingInvitations()).called(1);
    });
  });

  // ---------------------------------------------------------------------------
  // 4. Full community lifecycle
  // ---------------------------------------------------------------------------
  group('Full community lifecycle', () {
    test(
      'create -> invite -> accept -> send message -> markAsRead -> leave',
      () async {
        final community = _createCommunity(
          memberIds: [_ownerId, _memberId],
          memberCount: 2,
        );
        final message = _createMessage();

        // Create
        when(() => repo.createCommunity(any())).thenAnswer(
          (_) async => Right(community),
        );

        // Invite
        when(() => repo.inviteMember(_communityId, _memberId, MemberRole.member))
            .thenAnswer((_) async => const Right(null));

        // Accept
        when(() => repo.acceptInvitation(_communityId))
            .thenAnswer((_) async => const Right(null));

        // Send message
        when(
          () => repo.sendTextMessage(
            communityId: _communityId,
            text: 'Hello community!',
          ),
        ).thenAnswer((_) async => Right(message));

        // Mark as read
        when(() => repo.markAsRead(communityId: _communityId))
            .thenAnswer((_) async => const Right(null));

        // Leave
        when(() => repo.leaveCommunity(_communityId))
            .thenAnswer((_) async => const Right(null));

        // Execute the full lifecycle
        final createResult = await repo.createCommunity(
          CreateCommunityParams(
            type: CommunityType.regular,
            name: _communityName,
          ),
        );
        expect(createResult.isRight(), isTrue);

        final inviteResult = await repo.inviteMember(
          _communityId,
          _memberId,
          MemberRole.member,
        );
        expect(inviteResult.isRight(), isTrue);

        final acceptResult = await repo.acceptInvitation(_communityId);
        expect(acceptResult.isRight(), isTrue);

        final msgResult = await repo.sendTextMessage(
          communityId: _communityId,
          text: 'Hello community!',
        );
        expect(msgResult.isRight(), isTrue);
        final sentMessage =
            msgResult.getOrElse(() => throw Exception('Expected Right'));
        expect(sentMessage.textContent, equals('Hello community!'));
        expect(sentMessage.type, equals(MessageType.text));

        final readResult = await repo.markAsRead(communityId: _communityId);
        expect(readResult.isRight(), isTrue);

        final leaveResult = await repo.leaveCommunity(_communityId);
        expect(leaveResult.isRight(), isTrue);

        // Verify the full call sequence
        verifyInOrder([
          () => repo.createCommunity(any()),
          () => repo.inviteMember(_communityId, _memberId, MemberRole.member),
          () => repo.acceptInvitation(_communityId),
          () => repo.sendTextMessage(
                communityId: _communityId,
                text: 'Hello community!',
              ),
          () => repo.markAsRead(communityId: _communityId),
          () => repo.leaveCommunity(_communityId),
        ]);
      },
    );
  });

  // ---------------------------------------------------------------------------
  // 5. Stokvel contribution flow
  // ---------------------------------------------------------------------------
  group('Stokvel contribution flow', () {
    test(
      'create stokvel -> contribute -> verify completed transaction and balance',
      () async {
        final stokvelSettings = StokvelSettings(
          payoutType: PayoutType.rotating,
          payoutSchedule: '0 0 1 * *',
          payoutOrder: [_ownerId, _memberId],
        );

        final stokvelCommunity = _createCommunity(
          id: _stokvelCommunityId,
          type: CommunityType.stokvel,
          name: 'Test Stokvel',
          settings: CommunitySettings.defaultFor(CommunityType.stokvel),
          stokvelSettings: stokvelSettings,
          totalBalance: 0,
        );

        final completedContribution = _createTransaction(
          id: 'txn_contrib_1',
          communityId: _stokvelCommunityId,
          type: CommunityTransactionType.contribution,
          amount: 1000,
          status: CommunityTransactionStatus.completed,
          memberId: _ownerId,
        );

        // Create stokvel community
        when(() => repo.createCommunity(any())).thenAnswer(
          (_) async => Right(stokvelCommunity),
        );

        // Contribute
        when(() => repo.contribute(_stokvelCommunityId, 1000)).thenAnswer(
          (_) async => Right(completedContribution),
        );

        // Check balance after contribution
        when(() => repo.getBalance(_stokvelCommunityId)).thenAnswer(
          (_) async => const Right(1000),
        );

        // Execute
        final createResult = await repo.createCommunity(
          CreateCommunityParams(
            type: CommunityType.stokvel,
            name: 'Test Stokvel',
            settings: CommunitySettings.defaultFor(CommunityType.stokvel),
            stokvelSettings: stokvelSettings,
          ),
        );
        expect(createResult.isRight(), isTrue);
        final created =
            createResult.getOrElse(() => throw Exception('Expected Right'));
        expect(created.isStokvel, isTrue);
        expect(created.hasFinancials, isTrue);

        final contribResult =
            await repo.contribute(_stokvelCommunityId, 1000);
        expect(contribResult.isRight(), isTrue);
        final txn =
            contribResult.getOrElse(() => throw Exception('Expected Right'));
        expect(txn.type, equals(CommunityTransactionType.contribution));
        expect(txn.amount, equals(1000));
        expect(txn.status, equals(CommunityTransactionStatus.completed));
        expect(txn.isCompleted, isTrue);

        final balanceResult = await repo.getBalance(_stokvelCommunityId);
        expect(balanceResult.isRight(), isTrue);
        final balance = balanceResult.getOrElse(() => 0);
        expect(balance, equals(1000));

        verify(() => repo.createCommunity(any())).called(1);
        verify(() => repo.contribute(_stokvelCommunityId, 1000)).called(1);
        verify(() => repo.getBalance(_stokvelCommunityId)).called(1);
      },
    );
  });

  // ---------------------------------------------------------------------------
  // 6. Withdrawal requiring approval
  // ---------------------------------------------------------------------------
  group('Withdrawal requiring approval', () {
    test(
      'contribute -> withdraw above threshold -> pending -> approve -> completed',
      () async {
        // The default stokvel settings have requireApprovalAbove = 5000.
        // A withdrawal of 10000 tokens should require approval.

        final pendingWithdrawal = _createTransaction(
          id: 'txn_withdraw_1',
          communityId: _stokvelCommunityId,
          type: CommunityTransactionType.withdrawal,
          amount: 10000,
          status: CommunityTransactionStatus.pending,
          memberId: _memberId,
        );

        final completedWithdrawal = _createTransaction(
          id: 'txn_withdraw_1',
          communityId: _stokvelCommunityId,
          type: CommunityTransactionType.withdrawal,
          amount: 10000,
          status: CommunityTransactionStatus.completed,
          memberId: _memberId,
          approvedBy: _ownerId,
        );

        final pendingApproval = _createApproval(
          transactionId: 'txn_withdraw_1',
          amount: 10000,
          status: ApprovalStatus.pending,
        );

        // Step 1: Contribute first (to have a balance)
        when(() => repo.contribute(_stokvelCommunityId, 15000)).thenAnswer(
          (_) async => Right(_createTransaction(
            id: 'txn_contrib_1',
            amount: 15000,
            status: CommunityTransactionStatus.completed,
          )),
        );

        // Step 2: Withdraw above threshold -> returns pending
        when(() => repo.withdraw(_stokvelCommunityId, 10000)).thenAnswer(
          (_) async => Right(pendingWithdrawal),
        );

        // Step 3: Verify pending approval exists
        when(() => repo.getPendingApprovals(_stokvelCommunityId)).thenAnswer(
          (_) async => Right([pendingApproval]),
        );

        // Step 4: Approve the transaction
        when(
          () => repo.approveTransaction(
            _stokvelCommunityId,
            'txn_withdraw_1',
          ),
        ).thenAnswer((_) async => const Right(null));

        // Step 5: Verify transaction is now completed
        when(() => repo.getTransactions(_stokvelCommunityId)).thenAnswer(
          (_) async => Right([
            _createTransaction(
              id: 'txn_contrib_1',
              amount: 15000,
              status: CommunityTransactionStatus.completed,
            ),
            completedWithdrawal,
          ]),
        );

        // Execute the flow
        final contribResult =
            await repo.contribute(_stokvelCommunityId, 15000);
        expect(contribResult.isRight(), isTrue);

        final withdrawResult =
            await repo.withdraw(_stokvelCommunityId, 10000);
        expect(withdrawResult.isRight(), isTrue);
        final withdrawal =
            withdrawResult.getOrElse(() => throw Exception('Expected Right'));
        expect(withdrawal.status, equals(CommunityTransactionStatus.pending));
        expect(withdrawal.isPending, isTrue);
        expect(withdrawal.needsApproval, isTrue);

        final approvalsResult =
            await repo.getPendingApprovals(_stokvelCommunityId);
        expect(approvalsResult.isRight(), isTrue);
        final approvals = approvalsResult.getOrElse(() => []);
        expect(approvals.length, equals(1));
        expect(approvals.first.amount, equals(10000));
        expect(approvals.first.status, equals(ApprovalStatus.pending));
        expect(approvals.first.isPending, isTrue);

        final approveResult = await repo.approveTransaction(
          _stokvelCommunityId,
          'txn_withdraw_1',
        );
        expect(approveResult.isRight(), isTrue);

        final transactionsResult =
            await repo.getTransactions(_stokvelCommunityId);
        expect(transactionsResult.isRight(), isTrue);
        final transactions = transactionsResult.getOrElse(() => []);
        final finalWithdrawal =
            transactions.firstWhere((t) => t.id == 'txn_withdraw_1');
        expect(
          finalWithdrawal.status,
          equals(CommunityTransactionStatus.completed),
        );
        expect(finalWithdrawal.isCompleted, isTrue);
        expect(finalWithdrawal.approvedBy, equals(_ownerId));

        // Verify sequence
        verifyInOrder([
          () => repo.contribute(_stokvelCommunityId, 15000),
          () => repo.withdraw(_stokvelCommunityId, 10000),
          () => repo.getPendingApprovals(_stokvelCommunityId),
          () => repo.approveTransaction(
                _stokvelCommunityId,
                'txn_withdraw_1',
              ),
          () => repo.getTransactions(_stokvelCommunityId),
        ]);
      },
    );
  });

  // ---------------------------------------------------------------------------
  // 7. Member role management
  // ---------------------------------------------------------------------------
  group('Member role management', () {
    test(
      'invite -> accept -> change to admin -> verify -> change to viewer -> verify',
      () async {
        // Invite + accept
        when(() => repo.inviteMember(_communityId, _memberId, MemberRole.member))
            .thenAnswer((_) async => const Right(null));
        when(() => repo.acceptInvitation(_communityId))
            .thenAnswer((_) async => const Right(null));

        // Change role to admin
        when(
          () => repo.updateMemberRole(
            _communityId,
            _memberId,
            MemberRole.admin,
          ),
        ).thenAnswer((_) async => const Right(null));

        // After admin promotion
        final adminMember = _createMember(
          userId: _memberId,
          role: MemberRole.admin,
          status: MemberStatus.active,
        );

        // First getMembers call (after admin promotion)
        // Second getMembers call (after viewer demotion)
        final viewerMember = _createMember(
          userId: _memberId,
          role: MemberRole.viewer,
          status: MemberStatus.active,
        );

        var getMembersCallCount = 0;
        when(() => repo.getMembers(_communityId)).thenAnswer((_) async {
          getMembersCallCount++;
          if (getMembersCallCount == 1) {
            return Right([
              _createMember(
                userId: _ownerId,
                role: MemberRole.owner,
                status: MemberStatus.active,
              ),
              adminMember,
            ]);
          }
          return Right([
            _createMember(
              userId: _ownerId,
              role: MemberRole.owner,
              status: MemberStatus.active,
            ),
            viewerMember,
          ]);
        });

        // Change role to viewer
        when(
          () => repo.updateMemberRole(
            _communityId,
            _memberId,
            MemberRole.viewer,
          ),
        ).thenAnswer((_) async => const Right(null));

        // Execute the flow
        final inviteResult = await repo.inviteMember(
          _communityId,
          _memberId,
          MemberRole.member,
        );
        expect(inviteResult.isRight(), isTrue);

        final acceptResult = await repo.acceptInvitation(_communityId);
        expect(acceptResult.isRight(), isTrue);

        // Promote to admin
        final promoteResult = await repo.updateMemberRole(
          _communityId,
          _memberId,
          MemberRole.admin,
        );
        expect(promoteResult.isRight(), isTrue);

        // Verify admin role
        final membersAfterPromotion = await repo.getMembers(_communityId);
        expect(membersAfterPromotion.isRight(), isTrue);
        final promoted = membersAfterPromotion
            .getOrElse(() => [])
            .firstWhere((m) => m.userId == _memberId);
        expect(promoted.role, equals(MemberRole.admin));
        expect(promoted.isAdmin, isTrue);
        expect(promoted.canManageMembers, isTrue);
        expect(promoted.canEditSettings, isTrue);

        // Demote to viewer
        final demoteResult = await repo.updateMemberRole(
          _communityId,
          _memberId,
          MemberRole.viewer,
        );
        expect(demoteResult.isRight(), isTrue);

        // Verify viewer role
        final membersAfterDemotion = await repo.getMembers(_communityId);
        expect(membersAfterDemotion.isRight(), isTrue);
        final demoted = membersAfterDemotion
            .getOrElse(() => [])
            .firstWhere((m) => m.userId == _memberId);
        expect(demoted.role, equals(MemberRole.viewer));
        expect(demoted.isAdmin, isFalse);
        expect(demoted.canManageMembers, isFalse);
        expect(demoted.canApproveFunds, isFalse);
        expect(demoted.canTransferFunds, isFalse);

        verify(() => repo.inviteMember(_communityId, _memberId, MemberRole.member))
            .called(1);
        verify(() => repo.acceptInvitation(_communityId)).called(1);
        verify(
          () => repo.updateMemberRole(
            _communityId,
            _memberId,
            MemberRole.admin,
          ),
        ).called(1);
        verify(
          () => repo.updateMemberRole(
            _communityId,
            _memberId,
            MemberRole.viewer,
          ),
        ).called(1);
        verify(() => repo.getMembers(_communityId)).called(2);
      },
    );
  });

  // ---------------------------------------------------------------------------
  // 8. Delete community
  // ---------------------------------------------------------------------------
  group('Delete community', () {
    test('create community -> delete -> verify marked as deleted', () async {
      final community = _createCommunity();
      final deletedCommunity = _createCommunity(
        status: CommunityStatus.closed,
      );

      // Create
      when(() => repo.createCommunity(any())).thenAnswer(
        (_) async => Right(community),
      );

      // Delete
      when(() => repo.deleteCommunity(_communityId))
          .thenAnswer((_) async => const Right(null));

      // Get after deletion returns closed community
      when(() => repo.getCommunity(_communityId)).thenAnswer(
        (_) async => Right(deletedCommunity),
      );

      // Execute
      final createResult = await repo.createCommunity(
        CreateCommunityParams(
          type: CommunityType.regular,
          name: _communityName,
        ),
      );
      expect(createResult.isRight(), isTrue);
      final created =
          createResult.getOrElse(() => throw Exception('Expected Right'));
      expect(created.status, equals(CommunityStatus.active));
      expect(created.isActive, isTrue);

      final deleteResult = await repo.deleteCommunity(_communityId);
      expect(deleteResult.isRight(), isTrue);

      final getResult = await repo.getCommunity(_communityId);
      expect(getResult.isRight(), isTrue);
      final afterDeletion =
          getResult.getOrElse(() => throw Exception('Expected Right'));
      expect(afterDeletion.status, equals(CommunityStatus.closed));
      expect(afterDeletion.isClosed, isTrue);
      expect(afterDeletion.isActive, isFalse);

      verifyInOrder([
        () => repo.createCommunity(any()),
        () => repo.deleteCommunity(_communityId),
        () => repo.getCommunity(_communityId),
      ]);
    });
  });
}
