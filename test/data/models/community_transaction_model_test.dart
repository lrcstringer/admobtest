import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/data/models/community_transaction_model.dart';
import 'package:imalichat/domain/entities/community_transaction.dart';

void main() {
  group('CommunityTransactionModel', () {
    final createdAt = DateTime(2025, 2, 1, 10, 0);
    final completedAt = DateTime(2025, 2, 2, 14, 30);

    /// Creates a complete JSON map for CommunityTransactionModel.fromJson.
    Map<String, dynamic> createValidJson({
      String type = 'contribution',
      String status = 'pending',
      bool includeOptionals = true,
    }) {
      final json = <String, dynamic>{
        'id': 'txn_001',
        'communityId': 'community_001',
        'type': type,
        'amount': 5000,
        'memberId': 'user_001',
        'memberName': 'Test User',
        'status': status,
        'createdAt': createdAt.toIso8601String(),
      };

      if (includeOptionals) {
        json['journalId'] = 'journal_001';
        json['description'] = 'Monthly contribution';
        json['approvedBy'] = 'user_admin';
        json['rejectedBy'] = null;
        json['rejectionReason'] = null;
        json['completedAt'] = completedAt.toIso8601String();
      }

      return json;
    }

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = createValidJson();
        final model = CommunityTransactionModel.fromJson(json);

        expect(model.id, equals('txn_001'));
        expect(model.communityId, equals('community_001'));
        expect(model.journalId, equals('journal_001'));
        expect(model.type, equals('contribution'));
        expect(model.amount, equals(5000));
        expect(model.memberId, equals('user_001'));
        expect(model.memberName, equals('Test User'));
        expect(model.description, equals('Monthly contribution'));
        expect(model.status, equals('pending'));
        expect(model.approvedBy, equals('user_admin'));
        expect(model.rejectedBy, isNull);
        expect(model.rejectionReason, isNull);
        expect(model.createdAt, equals(createdAt));
        expect(model.completedAt, equals(completedAt));
      });

      test('handles missing optional fields', () {
        final json = createValidJson(includeOptionals: false);
        final model = CommunityTransactionModel.fromJson(json);

        expect(model.journalId, isNull);
        expect(model.description, isNull);
        expect(model.approvedBy, isNull);
        expect(model.rejectedBy, isNull);
        expect(model.rejectionReason, isNull);
        expect(model.completedAt, isNull);
      });

      test('parses each transaction type string', () {
        for (final typeStr in [
          'contribution',
          'withdrawal',
          'transfer_in',
          'transfer_out',
          'penalty',
          'payout',
        ]) {
          final json = createValidJson(type: typeStr);
          final model = CommunityTransactionModel.fromJson(json);
          expect(model.type, equals(typeStr));
        }
      });

      test('parses each status string', () {
        for (final statusStr in ['pending', 'approved', 'completed', 'rejected']) {
          final json = createValidJson(status: statusStr);
          final model = CommunityTransactionModel.fromJson(json);
          expect(model.status, equals(statusStr));
        }
      });
    });

    group('toEntity - _parseTransactionType', () {
      test('maps contribution correctly', () {
        final json = createValidJson(type: 'contribution');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.type, equals(CommunityTransactionType.contribution));
        expect(entity.isInflow, isTrue);
        expect(entity.isOutflow, isFalse);
      });

      test('maps withdrawal correctly', () {
        final json = createValidJson(type: 'withdrawal');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.type, equals(CommunityTransactionType.withdrawal));
        expect(entity.isOutflow, isTrue);
        expect(entity.isInflow, isFalse);
      });

      test('maps transfer_in correctly', () {
        final json = createValidJson(type: 'transfer_in');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.type, equals(CommunityTransactionType.transferIn));
        expect(entity.isInflow, isTrue);
      });

      test('maps transfer_out correctly', () {
        final json = createValidJson(type: 'transfer_out');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.type, equals(CommunityTransactionType.transferOut));
        expect(entity.isOutflow, isTrue);
      });

      test('maps penalty correctly', () {
        final json = createValidJson(type: 'penalty');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.type, equals(CommunityTransactionType.penalty));
        expect(entity.isInflow, isTrue);
      });

      test('maps payout correctly', () {
        final json = createValidJson(type: 'payout');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.type, equals(CommunityTransactionType.payout));
        expect(entity.isOutflow, isTrue);
      });

      test('defaults unknown type to contribution with warning', () {
        final json = createValidJson(type: 'nonexistent_type');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        // Unknown type falls back to contribution
        expect(entity.type, equals(CommunityTransactionType.contribution));
      });
    });

    group('toEntity - _parseTransactionStatus', () {
      test('maps pending correctly', () {
        final json = createValidJson(status: 'pending');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.status, equals(CommunityTransactionStatus.pending));
        expect(entity.isPending, isTrue);
        expect(entity.needsApproval, isTrue);
      });

      test('maps approved correctly', () {
        final json = createValidJson(status: 'approved');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.status, equals(CommunityTransactionStatus.approved));
        expect(entity.isApproved, isTrue);
      });

      test('maps completed correctly', () {
        final json = createValidJson(status: 'completed');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.status, equals(CommunityTransactionStatus.completed));
        expect(entity.isCompleted, isTrue);
      });

      test('maps rejected correctly', () {
        final json = createValidJson(status: 'rejected');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.status, equals(CommunityTransactionStatus.rejected));
        expect(entity.isRejected, isTrue);
      });

      test('defaults unknown status to pending with warning', () {
        final json = createValidJson(status: 'cancelled_nonexistent');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        // Unknown status falls back to pending
        expect(entity.status, equals(CommunityTransactionStatus.pending));
      });
    });

    group('toEntity - full field mapping', () {
      test('maps all fields correctly to CommunityTransaction entity', () {
        final json = createValidJson(type: 'withdrawal', status: 'approved');
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.id, equals('txn_001'));
        expect(entity.communityId, equals('community_001'));
        expect(entity.journalId, equals('journal_001'));
        expect(entity.type, equals(CommunityTransactionType.withdrawal));
        expect(entity.amount, equals(5000));
        expect(entity.memberId, equals('user_001'));
        expect(entity.memberName, equals('Test User'));
        expect(entity.description, equals('Monthly contribution'));
        expect(entity.status, equals(CommunityTransactionStatus.approved));
        expect(entity.approvedBy, equals('user_admin'));
        expect(entity.rejectedBy, isNull);
        expect(entity.rejectionReason, isNull);
        expect(entity.createdAt, equals(createdAt));
        expect(entity.completedAt, equals(completedAt));
      });

      test('maps null optional fields to entity', () {
        final json = createValidJson(includeOptionals: false);
        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.journalId, isNull);
        expect(entity.description, isNull);
        expect(entity.approvedBy, isNull);
        expect(entity.rejectedBy, isNull);
        expect(entity.rejectionReason, isNull);
        expect(entity.completedAt, isNull);
      });

      test('rejected transaction maps rejection fields', () {
        final json = createValidJson(status: 'rejected');
        json['rejectedBy'] = 'user_admin';
        json['rejectionReason'] = 'Insufficient documentation';
        json['approvedBy'] = null;

        final entity = CommunityTransactionModel.fromJson(json).toEntity();

        expect(entity.status, equals(CommunityTransactionStatus.rejected));
        expect(entity.rejectedBy, equals('user_admin'));
        expect(entity.rejectionReason, equals('Insufficient documentation'));
        expect(entity.approvedBy, isNull);
      });
    });

    group('fromEntity', () {
      test('serializes all fields from entity', () {
        final entity = CommunityTransaction(
          id: 'txn_fe',
          communityId: 'community_fe',
          journalId: 'journal_fe',
          type: CommunityTransactionType.contribution,
          amount: 1000,
          memberId: 'user_fe',
          memberName: 'From Entity User',
          description: 'FE description',
          status: CommunityTransactionStatus.completed,
          approvedBy: 'admin_fe',
          createdAt: createdAt,
          completedAt: completedAt,
        );

        final model = CommunityTransactionModel.fromEntity(entity);

        expect(model.id, equals('txn_fe'));
        expect(model.communityId, equals('community_fe'));
        expect(model.journalId, equals('journal_fe'));
        expect(model.type, equals('contribution'));
        expect(model.amount, equals(1000));
        expect(model.memberId, equals('user_fe'));
        expect(model.memberName, equals('From Entity User'));
        expect(model.description, equals('FE description'));
        expect(model.status, equals('completed'));
        expect(model.approvedBy, equals('admin_fe'));
        expect(model.createdAt, equals(createdAt));
        expect(model.completedAt, equals(completedAt));
      });

      test('serializes each CommunityTransactionType to correct snake_case string', () {
        CommunityTransactionModel makeModel(CommunityTransactionType type) {
          return CommunityTransactionModel.fromEntity(CommunityTransaction(
            id: 'id',
            communityId: 'cid',
            type: type,
            amount: 100,
            memberId: 'mid',
            memberName: 'name',
            status: CommunityTransactionStatus.pending,
            createdAt: createdAt,
          ));
        }

        expect(makeModel(CommunityTransactionType.contribution).type, equals('contribution'));
        expect(makeModel(CommunityTransactionType.withdrawal).type, equals('withdrawal'));
        expect(makeModel(CommunityTransactionType.transferIn).type, equals('transfer_in'));
        expect(makeModel(CommunityTransactionType.transferOut).type, equals('transfer_out'));
        expect(makeModel(CommunityTransactionType.penalty).type, equals('penalty'));
        expect(makeModel(CommunityTransactionType.payout).type, equals('payout'));
      });

      test('serializes each CommunityTransactionStatus to string name', () {
        CommunityTransactionModel makeModel(CommunityTransactionStatus status) {
          return CommunityTransactionModel.fromEntity(CommunityTransaction(
            id: 'id',
            communityId: 'cid',
            type: CommunityTransactionType.contribution,
            amount: 100,
            memberId: 'mid',
            memberName: 'name',
            status: status,
            createdAt: createdAt,
          ));
        }

        expect(makeModel(CommunityTransactionStatus.pending).status, equals('pending'));
        expect(makeModel(CommunityTransactionStatus.approved).status, equals('approved'));
        expect(makeModel(CommunityTransactionStatus.completed).status, equals('completed'));
        expect(makeModel(CommunityTransactionStatus.rejected).status, equals('rejected'));
      });

      test('handles null optional fields from entity', () {
        final entity = CommunityTransaction(
          id: 'txn_null',
          communityId: 'community_null',
          type: CommunityTransactionType.contribution,
          amount: 500,
          memberId: 'user_null',
          memberName: 'Null User',
          status: CommunityTransactionStatus.pending,
          createdAt: createdAt,
          // journalId, description, approvedBy, rejectedBy, rejectionReason, completedAt all null
        );

        final model = CommunityTransactionModel.fromEntity(entity);

        expect(model.journalId, isNull);
        expect(model.description, isNull);
        expect(model.approvedBy, isNull);
        expect(model.rejectedBy, isNull);
        expect(model.rejectionReason, isNull);
        expect(model.completedAt, isNull);
      });
    });

    group('roundtrip', () {
      test('entity -> model -> entity preserves all data', () {
        final entity = CommunityTransaction(
          id: 'rt_001',
          communityId: 'community_rt',
          journalId: 'journal_rt',
          type: CommunityTransactionType.transferIn,
          amount: 7500,
          memberId: 'user_rt',
          memberName: 'Roundtrip User',
          description: 'Roundtrip transfer',
          status: CommunityTransactionStatus.approved,
          approvedBy: 'admin_rt',
          createdAt: createdAt,
          completedAt: completedAt,
        );

        final model = CommunityTransactionModel.fromEntity(entity);
        final restored = model.toEntity();

        expect(restored.id, equals(entity.id));
        expect(restored.communityId, equals(entity.communityId));
        expect(restored.journalId, equals(entity.journalId));
        expect(restored.type, equals(entity.type));
        expect(restored.amount, equals(entity.amount));
        expect(restored.memberId, equals(entity.memberId));
        expect(restored.memberName, equals(entity.memberName));
        expect(restored.description, equals(entity.description));
        expect(restored.status, equals(entity.status));
        expect(restored.approvedBy, equals(entity.approvedBy));
        expect(restored.rejectedBy, equals(entity.rejectedBy));
        expect(restored.rejectionReason, equals(entity.rejectionReason));
        expect(restored.createdAt, equals(entity.createdAt));
        expect(restored.completedAt, equals(entity.completedAt));
      });

      test('roundtrip preserves all transaction types', () {
        for (final type in CommunityTransactionType.values) {
          final entity = CommunityTransaction(
            id: 'rt_type',
            communityId: 'cid',
            type: type,
            amount: 100,
            memberId: 'mid',
            memberName: 'name',
            status: CommunityTransactionStatus.pending,
            createdAt: createdAt,
          );

          final model = CommunityTransactionModel.fromEntity(entity);
          final restored = model.toEntity();

          expect(restored.type, equals(type),
              reason: 'Type ${type.name} should roundtrip correctly');
        }
      });

      test('roundtrip preserves all transaction statuses', () {
        for (final status in CommunityTransactionStatus.values) {
          final entity = CommunityTransaction(
            id: 'rt_status',
            communityId: 'cid',
            type: CommunityTransactionType.contribution,
            amount: 100,
            memberId: 'mid',
            memberName: 'name',
            status: status,
            createdAt: createdAt,
          );

          final model = CommunityTransactionModel.fromEntity(entity);
          final restored = model.toEntity();

          expect(restored.status, equals(status),
              reason: 'Status ${status.name} should roundtrip correctly');
        }
      });

      test('json -> model -> entity -> model -> verify fields', () {
        final json = createValidJson(type: 'transfer_out', status: 'completed');
        final model1 = CommunityTransactionModel.fromJson(json);
        final entity = model1.toEntity();
        final model2 = CommunityTransactionModel.fromEntity(entity);

        expect(model2.id, equals(model1.id));
        expect(model2.communityId, equals(model1.communityId));
        expect(model2.journalId, equals(model1.journalId));
        expect(model2.type, equals(model1.type));
        expect(model2.amount, equals(model1.amount));
        expect(model2.memberId, equals(model1.memberId));
        expect(model2.memberName, equals(model1.memberName));
        expect(model2.description, equals(model1.description));
        expect(model2.status, equals(model1.status));
        expect(model2.approvedBy, equals(model1.approvedBy));
        expect(model2.createdAt, equals(model1.createdAt));
        expect(model2.completedAt, equals(model1.completedAt));
      });
    });

    group('equality', () {
      test('two models with same values are equal', () {
        final model1 = CommunityTransactionModel(
          id: 'eq_001',
          communityId: 'c1',
          type: 'contribution',
          amount: 1000,
          memberId: 'u1',
          memberName: 'User',
          status: 'pending',
          createdAt: createdAt,
        );
        final model2 = CommunityTransactionModel(
          id: 'eq_001',
          communityId: 'c1',
          type: 'contribution',
          amount: 1000,
          memberId: 'u1',
          memberName: 'User',
          status: 'pending',
          createdAt: createdAt,
        );

        expect(model1, equals(model2));
      });

      test('two models with different ids are not equal', () {
        final model1 = CommunityTransactionModel(
          id: 'eq_001',
          communityId: 'c1',
          type: 'contribution',
          amount: 1000,
          memberId: 'u1',
          memberName: 'User',
          status: 'pending',
          createdAt: createdAt,
        );
        final model2 = CommunityTransactionModel(
          id: 'eq_002',
          communityId: 'c1',
          type: 'contribution',
          amount: 1000,
          memberId: 'u1',
          memberName: 'User',
          status: 'pending',
          createdAt: createdAt,
        );

        expect(model1, isNot(equals(model2)));
      });
    });

    group('copyWith', () {
      test('creates copy with updated fields', () {
        final original = CommunityTransactionModel(
          id: 'cw_001',
          communityId: 'c1',
          type: 'contribution',
          amount: 1000,
          memberId: 'u1',
          memberName: 'User',
          status: 'pending',
          createdAt: createdAt,
        );

        final updated = original.copyWith(
          status: 'approved',
          approvedBy: 'admin',
          amount: 2000,
        );

        expect(updated.status, equals('approved'));
        expect(updated.approvedBy, equals('admin'));
        expect(updated.amount, equals(2000));
        // Unchanged fields preserved
        expect(updated.id, equals('cw_001'));
        expect(updated.communityId, equals('c1'));
        expect(updated.type, equals('contribution'));
        expect(updated.memberId, equals('u1'));
      });
    });
  });

  group('CommunityApprovalModel', () {
    final createdAt = DateTime(2025, 3, 1, 8, 0);
    final expiresAt = DateTime(2025, 3, 8, 8, 0);

    /// Creates a complete JSON map for CommunityApprovalModel.fromJson.
    Map<String, dynamic> createApprovalJson({
      String type = 'withdrawal',
      String status = 'pending',
    }) {
      return <String, dynamic>{
        'id': 'approval_001',
        'communityId': 'community_001',
        'transactionId': 'txn_001',
        'requestedBy': 'user_001',
        'requestedByName': 'Test User',
        'amount': 10000,
        'type': type,
        'description': 'Large withdrawal request',
        'approvers': <String>['admin_1', 'admin_2'],
        'requiredApprovals': 2,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
        'expiresAt': expiresAt.toIso8601String(),
      };
    }

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = createApprovalJson();
        final model = CommunityApprovalModel.fromJson(json);

        expect(model.id, equals('approval_001'));
        expect(model.communityId, equals('community_001'));
        expect(model.transactionId, equals('txn_001'));
        expect(model.requestedBy, equals('user_001'));
        expect(model.requestedByName, equals('Test User'));
        expect(model.amount, equals(10000));
        expect(model.type, equals('withdrawal'));
        expect(model.description, equals('Large withdrawal request'));
        expect(model.approvers, equals(['admin_1', 'admin_2']));
        expect(model.requiredApprovals, equals(2));
        expect(model.status, equals('pending'));
        expect(model.createdAt, equals(createdAt));
        expect(model.expiresAt, equals(expiresAt));
      });
    });

    group('toEntity', () {
      test('maps all fields correctly to CommunityApproval entity', () {
        final json = createApprovalJson(type: 'withdrawal', status: 'pending');
        final entity = CommunityApprovalModel.fromJson(json).toEntity();

        expect(entity.id, equals('approval_001'));
        expect(entity.communityId, equals('community_001'));
        expect(entity.transactionId, equals('txn_001'));
        expect(entity.requestedBy, equals('user_001'));
        expect(entity.requestedByName, equals('Test User'));
        expect(entity.amount, equals(10000));
        expect(entity.type, equals(CommunityTransactionType.withdrawal));
        expect(entity.description, equals('Large withdrawal request'));
        expect(entity.approvers, equals(['admin_1', 'admin_2']));
        expect(entity.requiredApprovals, equals(2));
        expect(entity.status, equals(ApprovalStatus.pending));
        expect(entity.createdAt, equals(createdAt));
        expect(entity.expiresAt, equals(expiresAt));
      });

      test('maps each ApprovalStatus correctly', () {
        for (final statusStr in ['pending', 'approved', 'rejected', 'expired']) {
          final json = createApprovalJson(status: statusStr);
          final entity = CommunityApprovalModel.fromJson(json).toEntity();

          final expected = ApprovalStatus.values.firstWhere((e) => e.name == statusStr);
          expect(entity.status, equals(expected),
              reason: 'Status "$statusStr" should map to ApprovalStatus.$statusStr');
        }
      });

      test('defaults unknown approval status to pending with warning', () {
        final json = createApprovalJson(status: 'cancelled_nonexistent');
        final entity = CommunityApprovalModel.fromJson(json).toEntity();

        expect(entity.status, equals(ApprovalStatus.pending));
      });

      test('maps transaction type via shared _parseTransactionType', () {
        for (final entry in {
          'contribution': CommunityTransactionType.contribution,
          'withdrawal': CommunityTransactionType.withdrawal,
          'transfer_in': CommunityTransactionType.transferIn,
          'transfer_out': CommunityTransactionType.transferOut,
          'penalty': CommunityTransactionType.penalty,
          'payout': CommunityTransactionType.payout,
        }.entries) {
          final json = createApprovalJson(type: entry.key);
          final entity = CommunityApprovalModel.fromJson(json).toEntity();

          expect(entity.type, equals(entry.value),
              reason: 'Type "${entry.key}" should map to ${entry.value}');
        }
      });
    });

    group('fromEntity', () {
      test('serializes all fields from entity', () {
        final entity = CommunityApproval(
          id: 'approval_fe',
          communityId: 'community_fe',
          transactionId: 'txn_fe',
          requestedBy: 'user_fe',
          requestedByName: 'FE User',
          amount: 20000,
          type: CommunityTransactionType.payout,
          description: 'Payout request',
          approvers: ['admin_1'],
          requiredApprovals: 1,
          status: ApprovalStatus.approved,
          createdAt: createdAt,
          expiresAt: expiresAt,
        );

        final model = CommunityApprovalModel.fromEntity(entity);

        expect(model.id, equals('approval_fe'));
        expect(model.communityId, equals('community_fe'));
        expect(model.transactionId, equals('txn_fe'));
        expect(model.requestedBy, equals('user_fe'));
        expect(model.requestedByName, equals('FE User'));
        expect(model.amount, equals(20000));
        expect(model.type, equals('payout'));
        expect(model.description, equals('Payout request'));
        expect(model.approvers, equals(['admin_1']));
        expect(model.requiredApprovals, equals(1));
        expect(model.status, equals('approved'));
        expect(model.createdAt, equals(createdAt));
        expect(model.expiresAt, equals(expiresAt));
      });

      test('serializes each ApprovalStatus to string name', () {
        for (final status in ApprovalStatus.values) {
          final entity = CommunityApproval(
            id: 'id',
            communityId: 'cid',
            transactionId: 'tid',
            requestedBy: 'rb',
            requestedByName: 'name',
            amount: 100,
            type: CommunityTransactionType.contribution,
            approvers: const [],
            requiredApprovals: 1,
            status: status,
            createdAt: createdAt,
            expiresAt: expiresAt,
          );

          final model = CommunityApprovalModel.fromEntity(entity);
          expect(model.status, equals(status.name),
              reason: 'ApprovalStatus.${status.name} should serialize to "${status.name}"');
        }
      });
    });

    group('roundtrip', () {
      test('entity -> model -> entity preserves all data', () {
        final entity = CommunityApproval(
          id: 'rt_approval',
          communityId: 'community_rt',
          transactionId: 'txn_rt',
          requestedBy: 'user_rt',
          requestedByName: 'RT User',
          amount: 15000,
          type: CommunityTransactionType.transferOut,
          description: 'Roundtrip test',
          approvers: ['admin_1', 'admin_2', 'admin_3'],
          requiredApprovals: 2,
          status: ApprovalStatus.pending,
          createdAt: createdAt,
          expiresAt: expiresAt,
        );

        final model = CommunityApprovalModel.fromEntity(entity);
        final restored = model.toEntity();

        expect(restored.id, equals(entity.id));
        expect(restored.communityId, equals(entity.communityId));
        expect(restored.transactionId, equals(entity.transactionId));
        expect(restored.requestedBy, equals(entity.requestedBy));
        expect(restored.requestedByName, equals(entity.requestedByName));
        expect(restored.amount, equals(entity.amount));
        expect(restored.type, equals(entity.type));
        expect(restored.description, equals(entity.description));
        expect(restored.approvers, equals(entity.approvers));
        expect(restored.requiredApprovals, equals(entity.requiredApprovals));
        expect(restored.status, equals(entity.status));
        expect(restored.createdAt, equals(entity.createdAt));
        expect(restored.expiresAt, equals(entity.expiresAt));
      });
    });
  });
}
