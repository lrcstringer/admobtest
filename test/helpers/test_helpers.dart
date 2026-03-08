import 'package:imalichat/domain/entities/user.dart';
import 'package:imalichat/domain/entities/chat_thread.dart';
import 'package:imalichat/domain/entities/chat_card.dart';
import 'package:imalichat/domain/entities/referral.dart';
import 'package:imalichat/domain/entities/pot_pool.dart';
import 'package:imalichat/domain/entities/earn_thread.dart';
import 'package:imalichat/domain/entities/earn_opportunity.dart';
import 'package:imalichat/domain/entities/engagement.dart';
import 'package:imalichat/domain/entities/ledger_account.dart';
import 'package:imalichat/domain/entities/ledger_journal.dart';
import 'package:imalichat/domain/entities/sub_account.dart';
import 'package:imalichat/domain/entities/cashout.dart';
import 'package:imalichat/domain/entities/user_engagement_stats.dart';
import 'package:imalichat/domain/entities/gift.dart';
import 'package:imalichat/domain/entities/token_pool.dart';
import 'package:imalichat/domain/enums/gift_status.dart';
import 'package:imalichat/domain/enums/user_status.dart';
import 'package:imalichat/domain/enums/engagement_status.dart';
import 'package:imalichat/domain/enums/pot_type.dart';
import 'package:imalichat/domain/enums/chat_card_type.dart';
import 'package:imalichat/domain/enums/chat_card_status.dart';
import 'package:imalichat/domain/enums/cashout_status.dart';
import 'package:imalichat/domain/enums/pool_mode.dart';
import 'package:imalichat/domain/enums/pool_status.dart';
import 'package:imalichat/domain/enums/gift_style.dart';
import 'package:imalichat/domain/entities/user_score.dart';
import 'package:imalichat/domain/repositories/earn_repository.dart';
import 'package:imalichat/domain/value_objects/engagement_evidence.dart';

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

  /// Frozen ledger account
  static LedgerAccount get frozenLedgerAccount => LedgerAccount(
        id: 'user:user_frozen',
        type: LedgerAccountType.user,
        name: 'Frozen User Account',
        ownerId: 'user_frozen',
        balance: 50000,
        status: LedgerAccountStatus.frozen,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

  /// System ledger account (e.g., earn pool)
  static LedgerAccount get systemLedgerAccount => LedgerAccount(
        id: 'system:earn',
        type: LedgerAccountType.system,
        name: 'Earn Pool',
        balance: 1000000,
        status: LedgerAccountStatus.active,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

  /// Account with allocated balance (sub-accounts)
  static LedgerAccount get accountWithAllocation => LedgerAccount(
        id: 'user:user_alloc',
        type: LedgerAccountType.user,
        name: 'User With Allocation',
        ownerId: 'user_alloc',
        balance: 20000,
        allocatedBalance: 5000,
        status: LedgerAccountStatus.active,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

  // ==================== SUB-ACCOUNTS ====================

  /// Default (unrestricted) sub-account
  static SubAccount get defaultSubAccount => SubAccount(
        id: 'sub_default',
        userId: 'user123',
        name: 'My Savings',
        balance: 3000,
        lifetimeCredits: 5000,
        lifetimeDebits: 2000,
        isActive: true,
        isDefault: true,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

  /// Brand-restricted sub-account
  static SubAccount get brandSubAccount => SubAccount(
        id: 'sub_brand',
        userId: 'user123',
        accountTypeId: 'brand_cola',
        name: 'Cola Rewards',
        balance: 500,
        lifetimeCredits: 500,
        lifetimeDebits: 0,
        isActive: true,
        isDefault: false,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

  /// List of sub-accounts
  static List<SubAccount> get subAccountList => [
        defaultSubAccount,
        brandSubAccount,
      ];

  // ==================== ENGAGEMENT STATS ====================

  /// No streak stats
  static UserEngagementStats get noStreakStats => UserEngagementStats(
        userId: 'user123',
        currentStreak: 0,
        longestStreak: 5,
        totalEngagementsCompleted: 20,
        totalTokensEarned: 2000,
        updatedAt: DateTime(2024, 1, 1),
      );

  /// Starter streak (days 1-2, multiplier 1.0)
  static UserEngagementStats get starterStreakStats => UserEngagementStats(
        userId: 'user123',
        currentStreak: 2,
        longestStreak: 5,
        totalEngagementsCompleted: 30,
        totalTokensEarned: 3000,
        updatedAt: DateTime(2024, 1, 1),
      );

  /// Growing streak (days 3-6, multiplier 1.2)
  static UserEngagementStats get growingStreakStats => UserEngagementStats(
        userId: 'user123',
        currentStreak: 5,
        longestStreak: 10,
        totalEngagementsCompleted: 50,
        totalTokensEarned: 5000,
        updatedAt: DateTime(2024, 1, 1),
      );

  /// Strong streak (days 7-9, multiplier 1.35)
  static UserEngagementStats get strongStreakStats => UserEngagementStats(
        userId: 'user123',
        currentStreak: 8,
        longestStreak: 14,
        totalEngagementsCompleted: 80,
        totalTokensEarned: 8000,
        updatedAt: DateTime(2024, 1, 1),
      );

  /// Master streak (days 10+, multiplier 1.5)
  static UserEngagementStats get masterStreakStats => UserEngagementStats(
        userId: 'user123',
        currentStreak: 14,
        longestStreak: 14,
        totalEngagementsCompleted: 140,
        totalTokensEarned: 14000,
        updatedAt: DateTime(2024, 1, 1),
      );

  // ==================== CASHOUTS ====================

  /// Pending cashout (bank transfer)
  static Cashout get pendingCashout => Cashout(
        id: 'cashout_pending',
        walletId: 'user:user123',
        userId: 'user123',
        tokenAmount: 5000,
        zarAmount: 50.0,
        method: CashoutMethod.bankTransfer,
        status: CashoutStatus.pending,
        destinationDetails: 'FNB *****1234',
        bankName: 'FNB',
        accountNumber: '62000001234',
        accountHolderName: 'Test User',
        createdAt: DateTime(2024, 1, 1),
      );

  /// Completed cashout (e-wallet)
  static Cashout get completedCashout => Cashout(
        id: 'cashout_completed',
        walletId: 'user:user123',
        userId: 'user123',
        tokenAmount: 10000,
        zarAmount: 100.0,
        method: CashoutMethod.ewallet,
        status: CashoutStatus.completed,
        destinationDetails: '+27612345678',
        mobileNumber: '+27612345678',
        reference: 'REF-12345',
        createdAt: DateTime(2024, 1, 1),
        processedAt: DateTime(2024, 1, 2),
        completedAt: DateTime(2024, 1, 2),
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
        userId: 'user123',
        displayName: 'Test User',
        username: 'testuser',
        rank: 1,
        tokensWon: 25000,
        percentage: 50.0,
      );

  /// Test user score
  static UserScore get testUserScore => UserScore(
        userId: 'user123',
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
        clientId: 'client123',
        clientName: 'Test Brand',
        clientAvatarColor: '#FF5733',
        title: 'Test Thread',
        isPinned: false,
        isFeatured: false,
        isActive: true,
        availableOpportunities: 5,
        completedOpportunities: 10,
        createdAt: DateTime(2024, 1, 1),
        lastActivityAt: DateTime(2024, 1, 1),
      );

  /// Test earn thread - no opportunities
  static EarnThread get emptyEarnThread => EarnThread(
        id: 'earn_thread_2',
        clientId: 'client456',
        clientName: 'Empty Brand',
        title: 'Empty Thread',
        isPinned: false,
        isFeatured: false,
        isActive: true,
        availableOpportunities: 0,
        completedOpportunities: 5,
        createdAt: DateTime(2024, 1, 1),
      );

  /// Featured earn thread
  static EarnThread get featuredEarnThread => EarnThread(
        id: 'earn_thread_3',
        clientId: 'client789',
        clientName: 'Featured Brand',
        clientAvatarColor: '#00FF00',
        title: 'Featured Campaign',
        isPinned: true,
        isFeatured: true,
        isActive: true,
        availableOpportunities: 10,
        completedOpportunities: 100,
        createdAt: DateTime(2024, 1, 1),
      );

  /// List of earn threads
  static List<EarnThread> get earnThreadList => [
        testEarnThread,
        emptyEarnThread,
        featuredEarnThread,
      ];

  /// EligibleThreadsResult with threads and daily limit info
  static EligibleThreadsResult get eligibleThreadsResult => EligibleThreadsResult(
        threads: earnThreadList,
        dailyCompletions: 5,
        dailyEarnCap: 30,
        dailyLimitReached: false,
      );

  /// EligibleThreadsResult when daily limit is reached
  static EligibleThreadsResult get dailyLimitReachedResult => EligibleThreadsResult(
        threads: earnThreadList,
        dailyCompletions: 30,
        dailyEarnCap: 30,
        dailyLimitReached: true,
      );

  /// Empty threads result
  static EligibleThreadsResult get emptyThreadsResult => const EligibleThreadsResult(
        threads: [],
        dailyCompletions: 0,
        dailyEarnCap: 30,
        dailyLimitReached: false,
      );

  // ==================== EARN OPPORTUNITIES ====================

  /// Test video opportunity
  static EarnOpportunity get videoOpportunity => EarnOpportunity(
        id: 'opp_video_1',
        threadId: 'earn_thread_1',
        title: 'Watch Video',
        description: 'Watch this video and earn tokens',
        earningType: EarningType.video,
        tokenReward: 100,
        streakPoints: 1,
        mediaType: MediaType.video,
        mediaUrl: 'https://example.com/video.mp4',
        questions: [
          SurveyQuestion(
            id: 'q1',
            text: 'What did you think of the video?',
            questionType: QuestionType.singleSelect,
            options: ['Great', 'Good', 'OK', 'Bad'],
            orderIndex: 0,
          ),
        ],
        durationSeconds: 30,
        isActive: true,
        clientId: 'client123',
        clientName: 'Test Brand',
      );

  /// Test survey opportunity
  static EarnOpportunity get surveyOpportunity => EarnOpportunity(
        id: 'opp_survey_1',
        threadId: 'earn_thread_1',
        title: 'Complete Survey',
        description: 'Answer questions and earn tokens',
        earningType: EarningType.survey,
        tokenReward: 150,
        streakPoints: 2,
        mediaType: MediaType.image,
        mediaUrl: 'https://example.com/image.png',
        questions: [
          SurveyQuestion(
            id: 'q1',
            text: 'Question 1',
            questionType: QuestionType.singleSelect,
            options: ['A', 'B', 'C'],
            orderIndex: 0,
          ),
          SurveyQuestion(
            id: 'q2',
            text: 'Question 2',
            questionType: QuestionType.singleSelect,
            options: ['X', 'Y', 'Z'],
            orderIndex: 1,
          ),
        ],
        durationSeconds: 60,
        isActive: true,
        clientId: 'client123',
        clientName: 'Test Brand',
      );

  /// Test bonus opportunity
  static EarnOpportunity get bonusOpportunity => EarnOpportunity(
        id: 'opp_bonus_1',
        threadId: 'earn_thread_1',
        title: 'Bonus Opportunity',
        earningType: EarningType.video,
        tokenReward: 100,
        mediaType: MediaType.video,
        questions: [],
        durationSeconds: 30,
        isActive: true,
        bonusReward: true,
        bonusRewardMultiplier: 2.0,
        bonusIntervalType: BonusIntervalType.random,
      );

  /// Expired opportunity
  static EarnOpportunity get expiredOpportunity => EarnOpportunity(
        id: 'opp_expired',
        threadId: 'earn_thread_1',
        title: 'Expired Opportunity',
        earningType: EarningType.video,
        tokenReward: 50,
        mediaType: MediaType.video,
        questions: [],
        durationSeconds: 30,
        isActive: true,
        expiresAt: DateTime(2024, 1, 1), // Past date
      );

  /// AdMob opportunity (rewarded video ad)
  static EarnOpportunity get adMobOpportunity => EarnOpportunity(
        id: 'opp_admob_1',
        threadId: 'imalichat_watch_earn',
        title: 'Watch Ad',
        description: 'Watch a short video ad to earn tokens',
        earningType: EarningType.adVideo,
        tokenReward: 5,
        streakPoints: 1,
        mediaType: MediaType.adMob,
        questions: [
          SurveyQuestion(
            id: 'admob_q1',
            text: 'Did you watch the full video ad?',
            questionType: QuestionType.singleSelect,
            options: ['Yes, I watched it completely', 'Most of it', 'Not really'],
            orderIndex: 0,
            isAttentionCheck: true,
            correctAnswer: 'Yes, I watched it completely',
          ),
        ],
        durationSeconds: 30,
        isActive: true,
        clientId: 'imalichat',
        clientName: 'IMaliChat',
        dailyLimitPerUser: 3,
      );

  /// List of opportunities
  static List<EarnOpportunity> get opportunityList => [
        videoOpportunity,
        surveyOpportunity,
        bonusOpportunity,
      ];

  // ==================== ENGAGEMENT EVIDENCE ====================

  /// Test engagement evidence
  static EngagementEvidence get testEvidence => EngagementEvidence(
        deviceFingerprint: 'device_123abc',
        integrityToken: 'integrity_token_xyz',
        watchDurationMs: 30000,
        videoSeeked: false,
        screenVisible: true,
        appInForeground: true,
        surveyResponseTimesMs: [1500, 2000, 1800],
        videoStartedAt: DateTime(2024, 1, 1, 10, 0, 0),
        surveySubmittedAt: DateTime(2024, 1, 1, 10, 1, 0),
        clientAttentionScore: 0.95,
      );

  /// Evidence with video seeking (suspicious)
  static EngagementEvidence get suspiciousEvidence => EngagementEvidence(
        deviceFingerprint: 'device_456def',
        watchDurationMs: 5000,
        videoSeeked: true,
        screenVisible: false,
        appInForeground: false,
        surveyResponseTimesMs: [100, 100, 100],
        videoStartedAt: DateTime(2024, 1, 1, 10, 0, 0),
        surveySubmittedAt: DateTime(2024, 1, 1, 10, 0, 10),
        clientAttentionScore: 0.2,
      );

  /// Test engagement - in progress
  static Engagement get inProgressEngagement => Engagement(
        id: 'engagement123',
        userId: 'user123',
        audienceCampaignId: 'campaign123',
        earnOpportunityId: 'opp123',
        status: EngagementStatus.watching,
        startedAt: DateTime(2024, 1, 1),
        watchDurationSeconds: 15,
        requiredDurationSeconds: 30,
        answers: const [],
        attemptNumber: 1,
        createdAt: DateTime(2024, 1, 1),
        threadId: 'earn_thread_1',
        clientId: 'client123',
      );

  /// Test engagement - completed
  static Engagement get completedEngagement => Engagement(
        id: 'engagement456',
        userId: 'user123',
        audienceCampaignId: 'campaign123',
        earnOpportunityId: 'opp123',
        status: EngagementStatus.completed,
        startedAt: DateTime(2024, 1, 1),
        completedAt: DateTime(2024, 1, 1),
        watchDurationSeconds: 30,
        requiredDurationSeconds: 30,
        answers: [
          EngagementAnswer(
            questionId: 'q1',
            questionType: 'single_select',
            selectedOption: 'A',
            answeredAt: DateTime(2024, 1, 1),
            isCorrect: true,
          ),
        ],
        tokensEarned: 100,
        attemptNumber: 1,
        createdAt: DateTime(2024, 1, 1),
        threadId: 'earn_thread_1',
        clientId: 'client123',
        streakDayAtCompletion: 3,
        multiplierApplied: 1.2,
      );

  /// Test engagement - surveying phase
  static Engagement get surveyingEngagement => Engagement(
        id: 'engagement789',
        userId: 'user123',
        audienceCampaignId: 'campaign123',
        earnOpportunityId: 'opp123',
        status: EngagementStatus.surveying,
        startedAt: DateTime(2024, 1, 1),
        watchDurationSeconds: 30,
        requiredDurationSeconds: 30,
        answers: const [],
        attemptNumber: 1,
        createdAt: DateTime(2024, 1, 1),
      );

  /// Test engagement - failed
  static Engagement get failedEngagement => Engagement(
        id: 'engagement_failed',
        userId: 'user123',
        audienceCampaignId: 'campaign123',
        earnOpportunityId: 'opp123',
        status: EngagementStatus.failed,
        startedAt: DateTime(2024, 1, 1),
        watchDurationSeconds: 10,
        requiredDurationSeconds: 30,
        answers: const [],
        attemptNumber: 1,
        createdAt: DateTime(2024, 1, 1),
        failureReason: 'Video not watched fully',
      );

  /// Test engagement - abandoned
  static Engagement get abandonedEngagement => Engagement(
        id: 'engagement_abandoned',
        userId: 'user123',
        audienceCampaignId: 'campaign123',
        earnOpportunityId: 'opp123',
        status: EngagementStatus.abandoned,
        startedAt: DateTime(2024, 1, 1),
        watchDurationSeconds: 5,
        requiredDurationSeconds: 30,
        answers: const [],
        attemptNumber: 1,
        createdAt: DateTime(2024, 1, 1),
      );

  /// List of engagements
  static List<Engagement> get engagementList => [
        inProgressEngagement,
        completedEngagement,
        surveyingEngagement,
      ];

  /// List of completed engagements for history
  static List<Engagement> get engagementHistoryList => [
        completedEngagement,
        completedEngagement.copyWith(
          id: 'engagement_history_2',
          tokensEarned: 150,
          createdAt: DateTime(2024, 1, 2),
          completedAt: DateTime(2024, 1, 2),
        ),
        completedEngagement.copyWith(
          id: 'engagement_history_3',
          tokensEarned: 200,
          createdAt: DateTime(2024, 1, 3),
          completedAt: DateTime(2024, 1, 3),
        ),
      ];

  // ==================== TOKEN POOLS ====================

  static final _poolBaseTime = DateTime(2024, 6, 1);

  /// Collecting sasaza pool with contributions (one anonymous)
  static TokenPool get collectingSasazaPool => TokenPool(
        id: 'pool_sasaza_1',
        mode: PoolMode.sasaza,
        status: PoolStatus.collecting,
        organizerId: 'user123',
        organizerName: 'Test Organizer',
        recipientId: 'user789',
        recipientName: 'Gift Recipient',
        conversationId: 'conv_123',
        title: 'Birthday Gift',
        message: 'Happy Birthday!',
        style: GiftStyle.birthday,
        totalAmount: 5000,
        contributionCount: 3,
        contributorCount: 2,
        contributions: {
          'user123': PoolContribution(
            userId: 'user123',
            displayName: 'Test Organizer',
            totalAmount: 3000,
            contributionCount: 2,
            anonymous: false,
            lastContributedAt: _poolBaseTime,
          ),
          'user456': PoolContribution(
            userId: 'user456',
            displayName: 'Anonymous Friend',
            totalAmount: 2000,
            contributionCount: 1,
            anonymous: true,
            lastContributedAt: _poolBaseTime,
          ),
        },
        inviteeIds: const ['user456', 'user789_inv'],
        expiresAt: DateTime(2024, 7, 1),
        createdAt: _poolBaseTime,
        updatedAt: _poolBaseTime,
        groupAccountId: 'group:pool_sasaza_1',
      );

  /// Collecting save pool (no recipient)
  static TokenPool get collectingSavePool => TokenPool(
        id: 'pool_save_1',
        mode: PoolMode.save,
        status: PoolStatus.collecting,
        organizerId: 'user123',
        organizerName: 'Test Organizer',
        conversationId: 'conv_456',
        title: 'Holiday Savings',
        message: 'Let us save together!',
        style: GiftStyle.celebration,
        totalAmount: 10000,
        contributionCount: 5,
        contributorCount: 3,
        contributions: {
          'user123': PoolContribution(
            userId: 'user123',
            displayName: 'Test Organizer',
            totalAmount: 5000,
            contributionCount: 2,
            anonymous: false,
            lastContributedAt: _poolBaseTime,
          ),
          'user456': PoolContribution(
            userId: 'user456',
            displayName: 'Saver 2',
            totalAmount: 3000,
            contributionCount: 2,
            anonymous: false,
            lastContributedAt: _poolBaseTime,
          ),
          'user789': PoolContribution(
            userId: 'user789',
            displayName: 'Saver 3',
            totalAmount: 2000,
            contributionCount: 1,
            anonymous: true,
            lastContributedAt: _poolBaseTime,
          ),
        },
        inviteeIds: const ['user456', 'user789'],
        createdAt: _poolBaseTime,
        updatedAt: _poolBaseTime,
        groupAccountId: 'group:pool_save_1',
      );

  /// Sent sasaza pool (awaiting recipient)
  static TokenPool get sentSasazaPool => collectingSasazaPool.copyWith(
        status: PoolStatus.sent,
        sentAt: _poolBaseTime.add(const Duration(days: 1)),
        giftMessageId: 'msg_gift_1',
        giftConversationId: 'conv_gift_1',
      );

  /// Completed pool
  static TokenPool get completedPool => collectingSasazaPool.copyWith(
        status: PoolStatus.completed,
        completedAt: _poolBaseTime.add(const Duration(days: 2)),
      );

  /// Cancelled pool
  static TokenPool get cancelledPool => collectingSasazaPool.copyWith(
        status: PoolStatus.cancelled,
        cancelledAt: _poolBaseTime.add(const Duration(days: 1)),
      );

  /// Expired pool
  static TokenPool get expiredPool => collectingSasazaPool.copyWith(
        status: PoolStatus.expired,
      );

  /// Empty pool (collecting, zero contributions)
  static TokenPool get emptyCollectingPool => TokenPool(
        id: 'pool_empty',
        mode: PoolMode.sasaza,
        status: PoolStatus.collecting,
        organizerId: 'user123',
        organizerName: 'Test Organizer',
        conversationId: 'conv_empty',
        title: 'New Pool',
        style: GiftStyle.celebration,
        inviteeIds: const ['user456'],
        createdAt: _poolBaseTime,
        updatedAt: _poolBaseTime,
        groupAccountId: 'group:pool_empty',
      );

  /// List of pools for getMyPools tests
  static List<TokenPool> get tokenPoolList => [
        collectingSasazaPool,
        collectingSavePool,
        sentSasazaPool,
      ];

  // ==================== GIFTS ====================

  static final _giftBaseTime = DateTime(2024, 6, 1);

  static Gift get pendingGift => Gift(
        id: 'gift_1',
        senderId: 'user_sender',
        senderName: 'Test Sender',
        recipientId: 'user_recipient',
        recipientName: 'Test Recipient',
        amount: 500,
        conversationId: 'conv_1',
        messageId: 'msg_gift_1',
        message: 'Happy birthday!',
        style: GiftStyle.birthday,
        status: GiftStatus.pending,
        createdAt: _giftBaseTime,
        expiresAt: _giftBaseTime.add(const Duration(days: 7)),
      );

  static Gift get openedGift => pendingGift.copyWith(
        status: GiftStatus.opened,
        openedAt: _giftBaseTime.add(const Duration(hours: 2)),
      );

  static Gift get claimedGift => pendingGift.copyWith(
        status: GiftStatus.claimed,
        openedAt: _giftBaseTime.add(const Duration(hours: 2)),
        claimedAt: _giftBaseTime.add(const Duration(hours: 3)),
        creditTransactionId: 'txn_credit_1',
      );

  static Gift get expiredGift => pendingGift.copyWith(
        status: GiftStatus.expired,
        expiresAt: _giftBaseTime.subtract(const Duration(days: 1)),
      );

  static Gift get communityGift => pendingGift.copyWith(
        id: 'gift_community_1',
        conversationId: null,
        communityId: 'community_1',
      );

  static const GiftStats testGiftStats = GiftStats(
    totalSent: 5,
    totalReceived: 3,
    totalAmountSent: 2500,
    totalAmountReceived: 1500,
  );

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
