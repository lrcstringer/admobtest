import 'package:imalichat/domain/entities/user.dart';
import 'package:imalichat/domain/entities/chat_thread.dart';
import 'package:imalichat/domain/entities/chat_card.dart';
import 'package:imalichat/domain/entities/referral.dart';
import 'package:imalichat/domain/entities/pot_pool.dart';
import 'package:imalichat/domain/entities/earn_thread.dart';
import 'package:imalichat/domain/entities/engagement.dart';
import 'package:imalichat/domain/entities/ledger_account.dart';
import 'package:imalichat/domain/entities/ledger_journal.dart';
import 'package:imalichat/domain/enums/user_status.dart';
import 'package:imalichat/domain/enums/engagement_status.dart';
import 'package:imalichat/domain/enums/pot_type.dart';
import 'package:imalichat/domain/enums/chat_card_type.dart';
import 'package:imalichat/domain/enums/chat_card_status.dart';
import 'package:imalichat/domain/entities/user_score.dart';

/// Test fixtures and helpers for unit and widget tests

class TestData {
  TestData._();

  // ==================== USERS ====================

  /// Test user - active and complete
  static User get testUser => User(
        id: 'user123',
        phoneNumber: '+27612345678',
        status: UserStatus.active,
        isPotEligible: true,
        hasAcceptedTerms: true,
        hasCompletedOnboarding: true,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

  /// Pending test user - needs onboarding
  static User get pendingUser => User(
        id: 'user456',
        phoneNumber: '+27712345678',
        status: UserStatus.pending,
        isPotEligible: false,
        hasAcceptedTerms: false,
        hasCompletedOnboarding: false,
        createdAt: DateTime(2024, 1, 1),
      );

  /// User needing onboarding
  static User get userNeedsOnboarding => User(
        id: 'user789',
        phoneNumber: '+27812345678',
        status: UserStatus.active,
        isPotEligible: false,
        hasAcceptedTerms: true,
        hasCompletedOnboarding: false,
        createdAt: DateTime(2024, 1, 1),
      );

  /// Suspended user
  static User get suspendedUser => User(
        id: 'user_suspended',
        phoneNumber: '+27912345678',
        status: UserStatus.suspended,
        isPotEligible: false,
        hasAcceptedTerms: true,
        hasCompletedOnboarding: true,
        createdAt: DateTime(2024, 1, 1),
      );

  // ==================== LEDGER ACCOUNTS ====================

  /// Test ledger account
  static LedgerAccount get testLedgerAccount => LedgerAccount(
        id: 'user:user123',
        type: LedgerAccountType.user,
        name: 'Test User Account',
        ownerId: 'user123',
        balance: 10000,
        status: LedgerAccountStatus.active,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

  /// Test ledger account with high balance
  static LedgerAccount get richLedgerAccount => LedgerAccount(
        id: 'user:user456',
        type: LedgerAccountType.user,
        name: 'Rich User Account',
        ownerId: 'user456',
        balance: 500000,
        status: LedgerAccountStatus.active,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

  /// Test ledger account with low balance
  static LedgerAccount get poorLedgerAccount => LedgerAccount(
        id: 'user:user789',
        type: LedgerAccountType.user,
        name: 'Poor User Account',
        ownerId: 'user789',
        balance: 1000,
        status: LedgerAccountStatus.active,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

  // ==================== LEDGER JOURNALS ====================

  /// Test ledger journal - earning
  static LedgerJournal get earnJournal => LedgerJournal(
        id: 'journal123',
        idempotencyKey: 'earn-user123-20240101-001',
        type: LedgerJournalType.earn,
        status: LedgerJournalStatus.posted,
        description: 'Watched ad',
        entries: [
          LedgerEntry(
            id: 'entry1',
            accountId: 'user:user123',
            entryType: LedgerEntryType.credit,
            amount: 100,
            balanceAfter: 10100,
          ),
          LedgerEntry(
            id: 'entry2',
            accountId: 'system:earn',
            entryType: LedgerEntryType.debit,
            amount: 100,
            balanceAfter: 0,
          ),
        ],
        totalDebits: 100,
        totalCredits: 100,
        initiatedBy: 'system',
        createdAt: DateTime(2024, 1, 1),
        postedAt: DateTime(2024, 1, 1),
      );

  /// Test ledger journal - cashout
  static LedgerJournal get cashoutJournal => LedgerJournal(
        id: 'journal456',
        idempotencyKey: 'cashout-user123-20240101-001',
        type: LedgerJournalType.cashoutInitiate,
        status: LedgerJournalStatus.posted,
        description: 'Cashout to bank',
        entries: [
          LedgerEntry(
            id: 'entry3',
            accountId: 'user:user123',
            entryType: LedgerEntryType.debit,
            amount: 5000,
            balanceAfter: 5000,
          ),
          LedgerEntry(
            id: 'entry4',
            accountId: 'system:cashout',
            entryType: LedgerEntryType.credit,
            amount: 5000,
            balanceAfter: 5000,
          ),
        ],
        totalDebits: 5000,
        totalCredits: 5000,
        initiatedBy: 'user123',
        createdAt: DateTime(2024, 1, 1),
        postedAt: DateTime(2024, 1, 1),
      );

  /// Test ledger journal - pot win
  static LedgerJournal get potWinJournal => LedgerJournal(
        id: 'journal789',
        idempotencyKey: 'potwin-user123-20240101-001',
        type: LedgerJournalType.potWin,
        status: LedgerJournalStatus.posted,
        description: 'Daily pot winner!',
        entries: [
          LedgerEntry(
            id: 'entry5',
            accountId: 'user:user123',
            entryType: LedgerEntryType.credit,
            amount: 10000,
            balanceAfter: 20000,
          ),
          LedgerEntry(
            id: 'entry6',
            accountId: 'system:pot',
            entryType: LedgerEntryType.debit,
            amount: 10000,
            balanceAfter: 0,
          ),
        ],
        totalDebits: 10000,
        totalCredits: 10000,
        initiatedBy: 'system',
        createdAt: DateTime(2024, 1, 1),
        postedAt: DateTime(2024, 1, 1),
      );

  /// List of test ledger journals
  static List<LedgerJournal> get ledgerJournalList => [
        earnJournal,
        cashoutJournal,
        potWinJournal,
      ];

  // ==================== CHAT ====================

  /// Test chat thread - P2P
  static ChatThread get testChatThread => ChatThread(
        id: 'thread123',
        type: ChatThreadType.p2p,
        participantIds: ['user123', 'user456'],
        displayName: 'John Doe',
        lastMessagePreview: 'Hey, how are you?',
        lastMessageAt: DateTime(2024, 1, 1),
        unreadCount: 2,
        isPinned: false,
        isMuted: false,
        isArchived: false,
        createdAt: DateTime(2024, 1, 1),
      );

  /// Pinned chat thread
  static ChatThread get pinnedChatThread => ChatThread(
        id: 'thread456',
        type: ChatThreadType.p2p,
        participantIds: ['user123', 'user789'],
        displayName: 'Jane Smith',
        lastMessagePreview: 'Thanks for the tokens!',
        lastMessageAt: DateTime(2024, 1, 2),
        unreadCount: 0,
        isPinned: true,
        isMuted: false,
        isArchived: false,
        createdAt: DateTime(2024, 1, 1),
      );

  /// Brand chat thread
  static ChatThread get brandChatThread => ChatThread(
        id: 'thread_brand',
        type: ChatThreadType.brand,
        participantIds: ['user123', 'brand123'],
        displayName: 'iMali Support',
        avatarColor: '#FF5733',
        lastMessagePreview: 'Welcome to iMali!',
        lastMessageAt: DateTime(2024, 1, 1),
        unreadCount: 1,
        isPinned: false,
        isMuted: false,
        isArchived: false,
        createdAt: DateTime(2024, 1, 1),
      );

  /// List of chat threads
  static List<ChatThread> get chatThreadList => [
        pinnedChatThread,
        testChatThread,
        brandChatThread,
      ];

  // ==================== CHAT CARDS ====================

  /// Test chat card - text message
  static ChatCard get textChatCard => ChatCard(
        id: 'card123',
        threadId: 'thread123',
        senderId: 'user123',
        type: ChatCardType.text,
        status: ChatCardStatus.pending,
        textContent: 'Hello, how are you?',
        createdAt: DateTime(2024, 1, 1),
      );

  /// Test chat card - token send
  static ChatCard get tokenSendCard => ChatCard(
        id: 'card456',
        threadId: 'thread123',
        senderId: 'user123',
        type: ChatCardType.tokenSend,
        status: ChatCardStatus.paid,
        tokenAmount: 100,
        recipientId: 'user456',
        createdAt: DateTime(2024, 1, 1),
      );

  /// Test chat card - token request
  static ChatCard get tokenRequestCard => ChatCard(
        id: 'card789',
        threadId: 'thread123',
        senderId: 'user456',
        type: ChatCardType.tokenRequest,
        status: ChatCardStatus.pending,
        tokenAmount: 50,
        recipientId: 'user123',
        createdAt: DateTime(2024, 1, 1),
        expiresAt: DateTime(2024, 1, 8),
      );

  /// List of chat cards
  static List<ChatCard> get chatCardList => [
        textChatCard,
        tokenSendCard,
        tokenRequestCard,
      ];

  // ==================== REFERRALS ====================

  /// Test referral - pending
  static Referral get pendingReferral => Referral(
        id: 'ref123',
        referrerUserId: 'user123',
        refereeUserId: 'user456',
        refereeDisplayName: 'New User',
        status: ReferralStatus.pending,
        referralCode: 'ABC123',
        createdAt: DateTime(2024, 1, 1),
        expiresAt: DateTime(2024, 1, 8),
      );

  /// Test referral - completed
  static Referral get completedReferral => Referral(
        id: 'ref456',
        referrerUserId: 'user123',
        refereeUserId: 'user789',
        refereeDisplayName: 'Completed User',
        status: ReferralStatus.rewarded,
        referralCode: 'ABC123',
        referrerReward: 500,
        refereeReward: 250,
        createdAt: DateTime(2024, 1, 1),
        registeredAt: DateTime(2024, 1, 2),
        qualifiedAt: DateTime(2024, 1, 5),
        rewardedAt: DateTime(2024, 1, 5),
      );

  /// Test referral stats
  static ReferralStats get testReferralStats => const ReferralStats(
        totalReferrals: 10,
        pendingReferrals: 3,
        completedReferrals: 7,
        totalEarned: 3500,
        referralCode: 'ABC123',
        referralLink: 'https://imali.co.za/ref/ABC123',
      );

  /// List of referrals
  static List<Referral> get referralList => [
        pendingReferral,
        completedReferral,
      ];

  // ==================== POT ====================

  /// Test daily pot
  static PotPool get dailyPot => PotPool(
        id: 'pot_daily',
        type: PotType.daily,
        totalTokens: 50000,
        participantCount: 1000,
        periodStart: DateTime(2024, 1, 1),
        periodEnd: DateTime(2024, 1, 2),
        isActive: true,
        isDistributed: false,
        createdAt: DateTime(2024, 1, 1),
      );

  /// Test weekly pot
  static PotPool get weeklyPot => PotPool(
        id: 'pot_weekly',
        type: PotType.weekly,
        totalTokens: 250000,
        participantCount: 5000,
        periodStart: DateTime(2024, 1, 1),
        periodEnd: DateTime(2024, 1, 7),
        isActive: true,
        isDistributed: false,
        createdAt: DateTime(2024, 1, 1),
      );

  /// Test pot winner
  static PotWinner get testPotWinner => const PotWinner(
        oddienceUserId: 'user123',
        displayName: 'Test User',
        username: 'testuser',
        rank: 1,
        tokensWon: 25000,
        percentage: 50.0,
      );

  /// Test user score
  static UserScore get testUserScore => UserScore(
        oddienceUserId: 'user123',
        displayName: 'Test User',
        username: 'testuser',
        totalTokensEarned: 5000,
        rank: 5,
        previousRank: 8,
        engagementsCompleted: 50,
        currentStreak: 7,
        longestStreak: 14,
        periodStart: DateTime(2024, 1, 1),
        periodEnd: DateTime(2024, 1, 7),
        updatedAt: DateTime(2024, 1, 1),
      );

  // ==================== EARN ====================

  /// Test earn thread
  static EarnThread get testEarnThread => EarnThread(
        id: 'earn_thread_1',
        brandId: 'brand123',
        brandName: 'Test Brand',
        avatarColor: '#FF5733',
        isPinned: false,
        isActive: true,
        availableOpportunities: 5,
        completedOpportunities: 10,
        createdAt: DateTime(2024, 1, 1),
        lastActivityAt: DateTime(2024, 1, 1),
      );

  /// Test earn thread - no opportunities
  static EarnThread get emptyEarnThread => EarnThread(
        id: 'earn_thread_2',
        brandId: 'brand456',
        brandName: 'Empty Brand',
        isPinned: false,
        isActive: true,
        availableOpportunities: 0,
        completedOpportunities: 5,
        createdAt: DateTime(2024, 1, 1),
      );

  /// List of earn threads
  static List<EarnThread> get earnThreadList => [
        testEarnThread,
        emptyEarnThread,
      ];

  /// Test engagement - in progress
  static Engagement get inProgressEngagement => Engagement(
        id: 'engagement123',
        oddienceUserId: 'user123',
        oddienceCampaignId: 'campaign123',
        earnOpportunityId: 'opp123',
        status: EngagementStatus.watching,
        startedAt: DateTime(2024, 1, 1),
        watchDurationSeconds: 15,
        requiredDurationSeconds: 30,
        answers: const [],
        attemptNumber: 1,
        createdAt: DateTime(2024, 1, 1),
      );

  /// Test engagement - completed
  static Engagement get completedEngagement => Engagement(
        id: 'engagement456',
        oddienceUserId: 'user123',
        oddienceCampaignId: 'campaign123',
        earnOpportunityId: 'opp123',
        status: EngagementStatus.completed,
        startedAt: DateTime(2024, 1, 1),
        completedAt: DateTime(2024, 1, 1),
        watchDurationSeconds: 30,
        requiredDurationSeconds: 30,
        answers: [
          EngagementAnswer(
            questionId: 'q1',
            selectedOption: 'A',
            answeredAt: DateTime(2024, 1, 1),
            isCorrect: true,
          ),
        ],
        tokensEarned: 100,
        attemptNumber: 1,
        createdAt: DateTime(2024, 1, 1),
      );

  /// List of engagements
  static List<Engagement> get engagementList => [
        inProgressEngagement,
        completedEngagement,
      ];

  // ==================== VALIDATION DATA ====================

  /// Test phone numbers
  static const validPhoneNumbers = [
    '+27612345678',
    '0612345678',
    '0712345678',
    '0812345678',
  ];

  static const invalidPhoneNumbers = [
    '123',
    '0512345678',
    '+1234567890',
    'abc',
  ];

  /// Test referral codes
  static const validReferralCodes = [
    'ABC123',
    'IMALI2024',
    'XYZ789',
  ];

  static const invalidReferralCodes = [
    'AB',
    'abc',
    'ABC-123',
  ];

  /// Test usernames
  static const validUsernames = [
    'johndoe',
    'user_123',
    'imali_user',
  ];

  static const invalidUsernames = [
    'ab', // Too short
    'user name', // Has space
    'user@name', // Invalid character
  ];

  /// Test email addresses
  static const validEmails = [
    'test@example.com',
    'user.name@domain.co.za',
    'user+tag@gmail.com',
  ];

  static const invalidEmails = [
    'invalid',
    '@nodomain.com',
    'no@',
  ];
}

/// Helper to compare dates ignoring milliseconds
bool datesEqual(DateTime a, DateTime b) {
  return a.year == b.year &&
      a.month == b.month &&
      a.day == b.day &&
      a.hour == b.hour &&
      a.minute == b.minute &&
      a.second == b.second;
}

/// Helper to wait for async operations in tests
Future<void> pumpAndSettle() async {
  await Future.delayed(const Duration(milliseconds: 100));
}

/// Helper to create a stream that emits once
Stream<T> singleValueStream<T>(T value) async* {
  yield value;
}

/// Helper to create a stream that emits error
Stream<T> errorStream<T>(Object error) async* {
  throw error;
}
