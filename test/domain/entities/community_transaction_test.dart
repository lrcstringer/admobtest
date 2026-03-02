import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/community_transaction.dart';

void main() {
  // ==================== HELPERS ====================

  CommunityTransaction createTransaction({
    String id = 'txn_001',
    String communityId = 'community_001',
    String? journalId,
    CommunityTransactionType type = CommunityTransactionType.contribution,
    int amount = 1000,
    String memberId = 'user_001',
    String memberName = 'Test User',
    String? description,
    CommunityTransactionStatus status = CommunityTransactionStatus.pending,
    String? approvedBy,
    String? rejectedBy,
    String? rejectionReason,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return CommunityTransaction(
      id: id,
      communityId: communityId,
      journalId: journalId,
      type: type,
      amount: amount,
      memberId: memberId,
      memberName: memberName,
      description: description,
      status: status,
      approvedBy: approvedBy,
      rejectedBy: rejectedBy,
      rejectionReason: rejectionReason,
      createdAt: createdAt ?? DateTime(2024, 6, 1),
      completedAt: completedAt,
    );
  }

  CommunityApproval createApproval({
    String id = 'approval_001',
    String communityId = 'community_001',
    String transactionId = 'txn_001',
    String requestedBy = 'user_001',
    String requestedByName = 'Test User',
    int amount = 10000,
    CommunityTransactionType type = CommunityTransactionType.withdrawal,
    String? description,
    List<String> approvers = const [],
    int requiredApprovals = 2,
    ApprovalStatus status = ApprovalStatus.pending,
    DateTime? createdAt,
    DateTime? expiresAt,
  }) {
    return CommunityApproval(
      id: id,
      communityId: communityId,
      transactionId: transactionId,
      requestedBy: requestedBy,
      requestedByName: requestedByName,
      amount: amount,
      type: type,
      description: description,
      approvers: approvers,
      requiredApprovals: requiredApprovals,
      status: status,
      createdAt: createdAt ?? DateTime(2024, 6, 1),
      expiresAt: expiresAt ?? DateTime.now().add(const Duration(days: 7)),
    );
  }

  // ==================== COMMUNITY TRANSACTION TESTS ====================

  group('CommunityTransaction', () {
    group('entity creation', () {
      test('creates a valid transaction with required fields', () {
        final txn = createTransaction();

        expect(txn.id, equals('txn_001'));
        expect(txn.communityId, equals('community_001'));
        expect(txn.type, equals(CommunityTransactionType.contribution));
        expect(txn.amount, equals(1000));
        expect(txn.memberId, equals('user_001'));
        expect(txn.memberName, equals('Test User'));
        expect(txn.status, equals(CommunityTransactionStatus.pending));
      });

      test('copyWith creates a modified copy', () {
        final original = createTransaction();
        final modified = original.copyWith(
          status: CommunityTransactionStatus.approved,
          approvedBy: 'admin_001',
        );

        expect(modified.status, equals(CommunityTransactionStatus.approved));
        expect(modified.approvedBy, equals('admin_001'));
        expect(modified.id, equals(original.id));
        expect(modified.amount, equals(original.amount));
      });

      test('optional fields default to null', () {
        final txn = createTransaction();

        expect(txn.journalId, isNull);
        expect(txn.description, isNull);
        expect(txn.approvedBy, isNull);
        expect(txn.rejectedBy, isNull);
        expect(txn.rejectionReason, isNull);
        expect(txn.completedAt, isNull);
      });
    });

    group('tokenAmount', () {
      test('wraps amount as TokenAmount', () {
        final txn = createTransaction(amount: 5000);

        expect(txn.tokenAmount.value, equals(5000));
      });

      test('handles zero amount', () {
        final txn = createTransaction(amount: 0);

        expect(txn.tokenAmount.value, equals(0));
      });
    });

    group('status helpers', () {
      test('isPending is true only for pending status', () {
        expect(
          createTransaction(status: CommunityTransactionStatus.pending).isPending,
          isTrue,
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.approved).isPending,
          isFalse,
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.completed)
              .isPending,
          isFalse,
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.rejected).isPending,
          isFalse,
        );
      });

      test('isApproved is true only for approved status', () {
        expect(
          createTransaction(status: CommunityTransactionStatus.approved)
              .isApproved,
          isTrue,
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.pending).isApproved,
          isFalse,
        );
      });

      test('isCompleted is true only for completed status', () {
        expect(
          createTransaction(status: CommunityTransactionStatus.completed)
              .isCompleted,
          isTrue,
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.pending)
              .isCompleted,
          isFalse,
        );
      });

      test('isRejected is true only for rejected status', () {
        expect(
          createTransaction(status: CommunityTransactionStatus.rejected)
              .isRejected,
          isTrue,
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.pending).isRejected,
          isFalse,
        );
      });
    });

    group('needsApproval', () {
      test('returns true only for pending status', () {
        expect(
          createTransaction(status: CommunityTransactionStatus.pending)
              .needsApproval,
          isTrue,
        );
      });

      test('returns false for non-pending statuses', () {
        expect(
          createTransaction(status: CommunityTransactionStatus.approved)
              .needsApproval,
          isFalse,
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.completed)
              .needsApproval,
          isFalse,
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.rejected)
              .needsApproval,
          isFalse,
        );
      });
    });

    group('isInflow', () {
      test('contribution is an inflow', () {
        final txn = createTransaction(type: CommunityTransactionType.contribution);
        expect(txn.isInflow, isTrue);
        expect(txn.isOutflow, isFalse);
      });

      test('transferIn is an inflow', () {
        final txn = createTransaction(type: CommunityTransactionType.transferIn);
        expect(txn.isInflow, isTrue);
        expect(txn.isOutflow, isFalse);
      });

      test('penalty is an inflow', () {
        final txn = createTransaction(type: CommunityTransactionType.penalty);
        expect(txn.isInflow, isTrue);
        expect(txn.isOutflow, isFalse);
      });
    });

    group('isOutflow', () {
      test('withdrawal is an outflow', () {
        final txn = createTransaction(type: CommunityTransactionType.withdrawal);
        expect(txn.isOutflow, isTrue);
        expect(txn.isInflow, isFalse);
      });

      test('transferOut is an outflow', () {
        final txn = createTransaction(type: CommunityTransactionType.transferOut);
        expect(txn.isOutflow, isTrue);
        expect(txn.isInflow, isFalse);
      });

      test('payout is an outflow', () {
        final txn = createTransaction(type: CommunityTransactionType.payout);
        expect(txn.isOutflow, isTrue);
        expect(txn.isInflow, isFalse);
      });
    });

    group('every transaction type is either inflow or outflow', () {
      test('all CommunityTransactionType values are categorized', () {
        for (final type in CommunityTransactionType.values) {
          final txn = createTransaction(type: type);
          final isEither = txn.isInflow || txn.isOutflow;
          expect(isEither, isTrue,
              reason: '${type.name} should be either inflow or outflow');
          // No type should be both
          expect(txn.isInflow && txn.isOutflow, isFalse,
              reason: '${type.name} should not be both inflow and outflow');
        }
      });
    });

    group('typeDisplayName', () {
      test('returns correct display name for each type', () {
        expect(
          createTransaction(type: CommunityTransactionType.contribution)
              .typeDisplayName,
          equals('Contribution'),
        );
        expect(
          createTransaction(type: CommunityTransactionType.withdrawal)
              .typeDisplayName,
          equals('Withdrawal'),
        );
        expect(
          createTransaction(type: CommunityTransactionType.transferIn)
              .typeDisplayName,
          equals('Transfer In'),
        );
        expect(
          createTransaction(type: CommunityTransactionType.transferOut)
              .typeDisplayName,
          equals('Transfer Out'),
        );
        expect(
          createTransaction(type: CommunityTransactionType.penalty)
              .typeDisplayName,
          equals('Penalty'),
        );
        expect(
          createTransaction(type: CommunityTransactionType.payout)
              .typeDisplayName,
          equals('Payout'),
        );
      });
    });

    group('statusDisplayName', () {
      test('returns correct display name for each status', () {
        expect(
          createTransaction(status: CommunityTransactionStatus.pending)
              .statusDisplayName,
          equals('Pending'),
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.approved)
              .statusDisplayName,
          equals('Approved'),
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.completed)
              .statusDisplayName,
          equals('Completed'),
        );
        expect(
          createTransaction(status: CommunityTransactionStatus.rejected)
              .statusDisplayName,
          equals('Rejected'),
        );
      });
    });

    group('typeIcon', () {
      test('returns correct icon name for each type', () {
        expect(
          createTransaction(type: CommunityTransactionType.contribution).typeIcon,
          equals('add_circle'),
        );
        expect(
          createTransaction(type: CommunityTransactionType.withdrawal).typeIcon,
          equals('remove_circle'),
        );
        expect(
          createTransaction(type: CommunityTransactionType.transferIn).typeIcon,
          equals('arrow_downward'),
        );
        expect(
          createTransaction(type: CommunityTransactionType.transferOut).typeIcon,
          equals('arrow_upward'),
        );
        expect(
          createTransaction(type: CommunityTransactionType.penalty).typeIcon,
          equals('warning'),
        );
        expect(
          createTransaction(type: CommunityTransactionType.payout).typeIcon,
          equals('payments'),
        );
      });
    });
  });

  // ==================== COMMUNITY APPROVAL TESTS ====================

  group('CommunityApproval', () {
    group('entity creation', () {
      test('creates a valid approval with required fields', () {
        final approval = createApproval();

        expect(approval.id, equals('approval_001'));
        expect(approval.communityId, equals('community_001'));
        expect(approval.transactionId, equals('txn_001'));
        expect(approval.requestedBy, equals('user_001'));
        expect(approval.requestedByName, equals('Test User'));
        expect(approval.amount, equals(10000));
        expect(approval.type, equals(CommunityTransactionType.withdrawal));
        expect(approval.requiredApprovals, equals(2));
        expect(approval.status, equals(ApprovalStatus.pending));
      });

      test('copyWith creates a modified copy', () {
        final original = createApproval();
        final modified = original.copyWith(
          status: ApprovalStatus.approved,
          approvers: ['admin_001', 'admin_002'],
        );

        expect(modified.status, equals(ApprovalStatus.approved));
        expect(modified.approvers.length, equals(2));
        expect(modified.id, equals(original.id));
      });
    });

    group('isPending', () {
      test('returns true when status is pending and time has not passed', () {
        final approval = createApproval(
          status: ApprovalStatus.pending,
          expiresAt: DateTime.now().add(const Duration(days: 7)),
        );

        expect(approval.isPending, isTrue);
      });

      test('returns false when status is pending but time has passed', () {
        final approval = createApproval(
          status: ApprovalStatus.pending,
          expiresAt: DateTime.now().subtract(const Duration(days: 1)),
        );

        expect(approval.isPending, isFalse);
      });

      test('returns false when status is not pending', () {
        final approved = createApproval(status: ApprovalStatus.approved);
        final rejected = createApproval(status: ApprovalStatus.rejected);
        final expired = createApproval(status: ApprovalStatus.expired);

        expect(approved.isPending, isFalse);
        expect(rejected.isPending, isFalse);
        expect(expired.isPending, isFalse);
      });
    });

    group('isApproved', () {
      test('returns true only for approved status', () {
        expect(createApproval(status: ApprovalStatus.approved).isApproved, isTrue);
        expect(createApproval(status: ApprovalStatus.pending).isApproved, isFalse);
        expect(
            createApproval(status: ApprovalStatus.rejected).isApproved, isFalse);
        expect(createApproval(status: ApprovalStatus.expired).isApproved, isFalse);
      });
    });

    group('isRejected', () {
      test('returns true only for rejected status', () {
        expect(
            createApproval(status: ApprovalStatus.rejected).isRejected, isTrue);
        expect(
            createApproval(status: ApprovalStatus.pending).isRejected, isFalse);
        expect(
            createApproval(status: ApprovalStatus.approved).isRejected, isFalse);
      });
    });

    group('isExpired', () {
      test('returns true when status is expired', () {
        final approval = createApproval(
          status: ApprovalStatus.expired,
          expiresAt: DateTime.now().add(const Duration(days: 7)),
        );

        expect(approval.isExpired, isTrue);
      });

      test('returns true when time has passed regardless of status', () {
        final approval = createApproval(
          status: ApprovalStatus.pending,
          expiresAt: DateTime.now().subtract(const Duration(days: 1)),
        );

        expect(approval.isExpired, isTrue);
      });

      test('returns false when status is not expired and time has not passed', () {
        final approval = createApproval(
          status: ApprovalStatus.pending,
          expiresAt: DateTime.now().add(const Duration(days: 7)),
        );

        expect(approval.isExpired, isFalse);
      });

      test('returns true for approved status but expired time', () {
        // isExpired checks hasTimePassed OR status == expired
        final approval = createApproval(
          status: ApprovalStatus.approved,
          expiresAt: DateTime.now().subtract(const Duration(hours: 1)),
        );

        expect(approval.isExpired, isTrue);
      });
    });

    group('hasTimePassed', () {
      test('returns true when expiresAt is in the past', () {
        final approval = createApproval(
          expiresAt: DateTime.now().subtract(const Duration(seconds: 1)),
        );

        expect(approval.hasTimePassed, isTrue);
      });

      test('returns false when expiresAt is in the future', () {
        final approval = createApproval(
          expiresAt: DateTime.now().add(const Duration(days: 30)),
        );

        expect(approval.hasTimePassed, isFalse);
      });
    });

    group('approvalCount / hasApproved', () {
      test('approvalCount returns number of approvers', () {
        final noApprovers = createApproval(approvers: []);
        final twoApprovers =
            createApproval(approvers: ['admin_001', 'admin_002']);

        expect(noApprovers.approvalCount, equals(0));
        expect(twoApprovers.approvalCount, equals(2));
      });

      test('hasApproved returns true for a user in approvers list', () {
        final approval = createApproval(approvers: ['admin_001', 'admin_002']);

        expect(approval.hasApproved('admin_001'), isTrue);
        expect(approval.hasApproved('admin_002'), isTrue);
        expect(approval.hasApproved('admin_003'), isFalse);
      });

      test('hasApproved returns false for empty approvers list', () {
        final approval = createApproval(approvers: []);

        expect(approval.hasApproved('admin_001'), isFalse);
      });
    });

    group('combined pending + expired interaction', () {
      test('pending with future expiry is truly pending and not expired', () {
        final approval = createApproval(
          status: ApprovalStatus.pending,
          expiresAt: DateTime.now().add(const Duration(days: 7)),
        );

        expect(approval.isPending, isTrue);
        expect(approval.isExpired, isFalse);
      });

      test('pending with past expiry is expired and not pending', () {
        final approval = createApproval(
          status: ApprovalStatus.pending,
          expiresAt: DateTime.now().subtract(const Duration(days: 1)),
        );

        expect(approval.isPending, isFalse);
        expect(approval.isExpired, isTrue);
      });

      test('explicitly expired status is always expired', () {
        final approval = createApproval(
          status: ApprovalStatus.expired,
          expiresAt: DateTime.now().add(const Duration(days: 7)),
        );

        expect(approval.isPending, isFalse);
        expect(approval.isExpired, isTrue);
      });
    });
  });
}
