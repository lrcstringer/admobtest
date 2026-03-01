import 'package:flutter_test/flutter_test.dart';
import 'package:imalichat/domain/entities/token_pool.dart';
import 'package:imalichat/domain/enums/gift_style.dart';
import 'package:imalichat/domain/enums/pool_mode.dart';
import 'package:imalichat/domain/enums/pool_status.dart';

/// Helper to build a pool with sensible defaults
TokenPool _pool({
  PoolMode mode = PoolMode.sasaza,
  PoolStatus status = PoolStatus.collecting,
  String organizerId = 'org',
  String? recipientId = 'recip',
  int totalAmount = 5000,
  Map<String, PoolContribution>? contributions,
  List<String> inviteeIds = const ['inv1', 'inv2'],
  DateTime? expiresAt,
}) {
  return TokenPool(
    id: 'pool_test',
    mode: mode,
    status: status,
    organizerId: organizerId,
    organizerName: 'Organizer',
    recipientId: recipientId,
    recipientName: recipientId != null ? 'Recipient' : null,
    conversationId: 'conv_test',
    title: 'Test Pool',
    style: GiftStyle.celebration,
    totalAmount: totalAmount,
    contributionCount: 3,
    contributorCount: 2,
    contributions: contributions ?? {},
    inviteeIds: inviteeIds,
    expiresAt: expiresAt,
    createdAt: DateTime(2024, 6, 1),
    updatedAt: DateTime(2024, 6, 1),
    groupAccountId: 'group:pool_test',
  );
}

void main() {
  group('TokenPool', () {
    // ── Mode helpers ────────────────────────────────────────────────────

    group('mode helpers', () {
      test('isSasaza returns true for sasaza mode', () {
        final pool = _pool(mode: PoolMode.sasaza);
        expect(pool.isSasaza, isTrue);
        expect(pool.isSave, isFalse);
      });

      test('isSave returns true for save mode', () {
        final pool = _pool(mode: PoolMode.save);
        expect(pool.isSave, isTrue);
        expect(pool.isSasaza, isFalse);
      });
    });

    // ── Status helpers ──────────────────────────────────────────────────

    group('status helpers', () {
      test('isCollecting returns true for collecting status', () {
        final pool = _pool(status: PoolStatus.collecting);
        expect(pool.isCollecting, isTrue);
        expect(pool.isSent, isFalse);
      });

      test('isSent returns true for sent status', () {
        final pool = _pool(status: PoolStatus.sent);
        expect(pool.isSent, isTrue);
      });

      test('isCompleted returns true for completed status', () {
        final pool = _pool(status: PoolStatus.completed);
        expect(pool.isCompleted, isTrue);
      });

      test('isCancelled returns true for cancelled status', () {
        final pool = _pool(status: PoolStatus.cancelled);
        expect(pool.isCancelled, isTrue);
      });

      test('isExpired returns true for expired status', () {
        final pool = _pool(status: PoolStatus.expired);
        expect(pool.isExpired, isTrue);
      });

      test('isExpired returns true when expiresAt is in the past', () {
        final pool = _pool(
          status: PoolStatus.collecting,
          expiresAt: DateTime(2020, 1, 1),
        );
        expect(pool.isExpired, isTrue);
      });

      test('isExpired returns false when expiresAt is in the future', () {
        final pool = _pool(
          status: PoolStatus.collecting,
          expiresAt: DateTime(2099, 1, 1),
        );
        expect(pool.isExpired, isFalse);
      });

      test('isExpired returns false when expiresAt is null and status is collecting', () {
        final pool = _pool(status: PoolStatus.collecting, expiresAt: null);
        expect(pool.isExpired, isFalse);
      });
    });

    // ── isTerminal ──────────────────────────────────────────────────────

    group('isTerminal', () {
      test('returns true for completed status', () {
        expect(_pool(status: PoolStatus.completed).isTerminal, isTrue);
      });

      test('returns true for cancelled status', () {
        expect(_pool(status: PoolStatus.cancelled).isTerminal, isTrue);
      });

      test('returns true for expired status', () {
        expect(_pool(status: PoolStatus.expired).isTerminal, isTrue);
      });

      test('returns false for collecting status', () {
        expect(_pool(status: PoolStatus.collecting).isTerminal, isFalse);
      });

      test('returns false for sent status', () {
        expect(_pool(status: PoolStatus.sent).isTerminal, isFalse);
      });
    });

    // ── isActive ────────────────────────────────────────────────────────

    group('isActive', () {
      test('returns true for collecting status', () {
        expect(_pool(status: PoolStatus.collecting).isActive, isTrue);
      });

      test('returns false for sent status', () {
        expect(_pool(status: PoolStatus.sent).isActive, isFalse);
      });

      test('returns false for completed status', () {
        expect(_pool(status: PoolStatus.completed).isActive, isFalse);
      });
    });

    // ── Financial helpers ───────────────────────────────────────────────

    group('financial helpers', () {
      test('hasContributions returns true when totalAmount > 0', () {
        expect(_pool(totalAmount: 5000).hasContributions, isTrue);
      });

      test('hasContributions returns false when totalAmount is 0', () {
        expect(_pool(totalAmount: 0).hasContributions, isFalse);
      });

      test('totalAmountZar converts tokens to ZAR correctly', () {
        expect(_pool(totalAmount: 5000).totalAmountZar, equals(50.0));
      });

      test('totalAmountZar returns 0.0 when totalAmount is 0', () {
        expect(_pool(totalAmount: 0).totalAmountZar, equals(0.0));
      });
    });

    // ── hasContributed / contributionFor ────────────────────────────────

    group('hasContributed / contributionFor', () {
      final contributions = {
        'user123': PoolContribution(
          userId: 'user123',
          displayName: 'Alice',
          totalAmount: 3000,
          contributionCount: 2,
          anonymous: false,
          lastContributedAt: DateTime(2024, 6, 1),
        ),
      };

      test('hasContributed returns true when userId exists', () {
        final pool = _pool(contributions: contributions);
        expect(pool.hasContributed('user123'), isTrue);
      });

      test('hasContributed returns false when userId not in map', () {
        final pool = _pool(contributions: contributions);
        expect(pool.hasContributed('nonexistent'), isFalse);
      });

      test('contributionFor returns totalAmount for existing contributor', () {
        final pool = _pool(contributions: contributions);
        expect(pool.contributionFor('user123'), equals(3000));
      });

      test('contributionFor returns 0 for non-existent contributor', () {
        final pool = _pool(contributions: contributions);
        expect(pool.contributionFor('nonexistent'), equals(0));
      });
    });

    // ── Participant helpers ─────────────────────────────────────────────

    group('participant helpers', () {
      test('isOrganizer returns true for organizerId', () {
        final pool = _pool(organizerId: 'org123');
        expect(pool.isOrganizer('org123'), isTrue);
        expect(pool.isOrganizer('other'), isFalse);
      });

      test('isRecipient returns true for recipientId', () {
        final pool = _pool(recipientId: 'recip123');
        expect(pool.isRecipient('recip123'), isTrue);
        expect(pool.isRecipient('other'), isFalse);
      });

      test('isRecipient returns false when recipientId is null', () {
        final pool = _pool(recipientId: null);
        expect(pool.isRecipient('anyone'), isFalse);
      });

      test('isInvitee returns true for userId in inviteeIds', () {
        final pool = _pool(inviteeIds: ['inv1', 'inv2']);
        expect(pool.isInvitee('inv1'), isTrue);
        expect(pool.isInvitee('other'), isFalse);
      });

      test('allParticipantIds includes organizer and all invitees', () {
        final pool = _pool(organizerId: 'org', inviteeIds: ['a', 'b']);
        expect(pool.allParticipantIds, equals(['org', 'a', 'b']));
      });
    });

    // ── canContribute ───────────────────────────────────────────────────

    group('canContribute', () {
      test('returns true for organizer when pool is collecting', () {
        final pool = _pool(organizerId: 'org', status: PoolStatus.collecting);
        expect(pool.canContribute('org'), isTrue);
      });

      test('returns true for invitee when pool is collecting', () {
        final pool = _pool(inviteeIds: ['inv1'], status: PoolStatus.collecting);
        expect(pool.canContribute('inv1'), isTrue);
      });

      test('returns false for non-participant', () {
        final pool = _pool(status: PoolStatus.collecting);
        expect(pool.canContribute('stranger'), isFalse);
      });

      test('returns false when pool is not collecting', () {
        final pool = _pool(organizerId: 'org', status: PoolStatus.sent);
        expect(pool.canContribute('org'), isFalse);
      });
    });

    // ── canSend ─────────────────────────────────────────────────────────

    group('canSend', () {
      test('returns true for organizer of sasaza pool with contributions', () {
        final pool = _pool(
          mode: PoolMode.sasaza,
          status: PoolStatus.collecting,
          organizerId: 'org',
          totalAmount: 1000,
        );
        expect(pool.canSend('org'), isTrue);
      });

      test('returns false for non-organizer', () {
        final pool = _pool(
          mode: PoolMode.sasaza,
          status: PoolStatus.collecting,
          organizerId: 'org',
          totalAmount: 1000,
        );
        expect(pool.canSend('other'), isFalse);
      });

      test('returns false for save mode', () {
        final pool = _pool(
          mode: PoolMode.save,
          status: PoolStatus.collecting,
          organizerId: 'org',
          totalAmount: 1000,
        );
        expect(pool.canSend('org'), isFalse);
      });

      test('returns false when pool has no contributions', () {
        final pool = _pool(
          mode: PoolMode.sasaza,
          status: PoolStatus.collecting,
          organizerId: 'org',
          totalAmount: 0,
        );
        expect(pool.canSend('org'), isFalse);
      });

      test('returns false when pool is not collecting', () {
        final pool = _pool(
          mode: PoolMode.sasaza,
          status: PoolStatus.sent,
          organizerId: 'org',
          totalAmount: 1000,
        );
        expect(pool.canSend('org'), isFalse);
      });
    });

    // ── canDistribute ───────────────────────────────────────────────────

    group('canDistribute', () {
      test('returns true for organizer of save pool with contributions', () {
        final pool = _pool(
          mode: PoolMode.save,
          status: PoolStatus.collecting,
          organizerId: 'org',
          totalAmount: 1000,
        );
        expect(pool.canDistribute('org'), isTrue);
      });

      test('returns false for sasaza mode', () {
        final pool = _pool(
          mode: PoolMode.sasaza,
          status: PoolStatus.collecting,
          organizerId: 'org',
          totalAmount: 1000,
        );
        expect(pool.canDistribute('org'), isFalse);
      });

      test('returns false for non-organizer', () {
        final pool = _pool(
          mode: PoolMode.save,
          status: PoolStatus.collecting,
          organizerId: 'org',
          totalAmount: 1000,
        );
        expect(pool.canDistribute('other'), isFalse);
      });

      test('returns false when pool has no contributions', () {
        final pool = _pool(
          mode: PoolMode.save,
          status: PoolStatus.collecting,
          organizerId: 'org',
          totalAmount: 0,
        );
        expect(pool.canDistribute('org'), isFalse);
      });
    });

    // ── canCancel ───────────────────────────────────────────────────────

    group('canCancel', () {
      test('returns true for organizer when collecting', () {
        final pool = _pool(organizerId: 'org', status: PoolStatus.collecting);
        expect(pool.canCancel('org'), isTrue);
      });

      test('returns false for non-organizer', () {
        final pool = _pool(organizerId: 'org', status: PoolStatus.collecting);
        expect(pool.canCancel('other'), isFalse);
      });

      test('returns false when pool is not collecting', () {
        final pool = _pool(organizerId: 'org', status: PoolStatus.sent);
        expect(pool.canCancel('org'), isFalse);
      });
    });

    // ── visibleContributorNames / anonymousCount ────────────────────────

    group('visibleContributorNames / anonymousCount', () {
      final mixedContributions = {
        'u1': PoolContribution(
          userId: 'u1',
          displayName: 'Alice',
          totalAmount: 100,
          contributionCount: 1,
          anonymous: false,
          lastContributedAt: DateTime(2024, 6, 1),
        ),
        'u2': PoolContribution(
          userId: 'u2',
          displayName: 'Bob',
          totalAmount: 200,
          contributionCount: 1,
          anonymous: true,
          lastContributedAt: DateTime(2024, 6, 1),
        ),
        'u3': PoolContribution(
          userId: 'u3',
          displayName: 'Charlie',
          totalAmount: 300,
          contributionCount: 1,
          anonymous: false,
          lastContributedAt: DateTime(2024, 6, 1),
        ),
      };

      test('returns names of non-anonymous contributors only', () {
        final pool = _pool(contributions: mixedContributions);
        expect(pool.visibleContributorNames, containsAll(['Alice', 'Charlie']));
        expect(pool.visibleContributorNames, isNot(contains('Bob')));
      });

      test('anonymousCount returns count of anonymous contributors', () {
        final pool = _pool(contributions: mixedContributions);
        expect(pool.anonymousCount, equals(1));
      });

      test('returns empty list when all contributors are anonymous', () {
        final allAnon = {
          'u1': PoolContribution(
            userId: 'u1',
            displayName: 'X',
            totalAmount: 100,
            contributionCount: 1,
            anonymous: true,
            lastContributedAt: DateTime(2024, 6, 1),
          ),
        };
        final pool = _pool(contributions: allAnon);
        expect(pool.visibleContributorNames, isEmpty);
        expect(pool.anonymousCount, equals(1));
      });

      test('returns empty list when there are no contributions', () {
        final pool = _pool(contributions: {});
        expect(pool.visibleContributorNames, isEmpty);
        expect(pool.anonymousCount, equals(0));
      });
    });
  });

  // ── PoolContribution ───────────────────────────────────────────────────

  group('PoolContribution', () {
    test('stores all values correctly', () {
      final c = PoolContribution(
        userId: 'u1',
        displayName: 'Alice',
        totalAmount: 500,
        contributionCount: 3,
        anonymous: true,
        lastContributedAt: DateTime(2024, 6, 1),
      );
      expect(c.userId, 'u1');
      expect(c.displayName, 'Alice');
      expect(c.totalAmount, 500);
      expect(c.contributionCount, 3);
      expect(c.anonymous, isTrue);
    });
  });

  // ── PoolPayout ─────────────────────────────────────────────────────────

  group('PoolPayout', () {
    test('stores all values correctly', () {
      const p = PoolPayout(userId: 'u1', displayName: 'Alice', amount: 1000);
      expect(p.userId, 'u1');
      expect(p.displayName, 'Alice');
      expect(p.amount, 1000);
    });
  });
}
