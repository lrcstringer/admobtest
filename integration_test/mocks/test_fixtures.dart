import 'package:imalichat/domain/entities/earn_opportunity.dart';
import 'package:imalichat/domain/entities/earn_thread.dart';
import 'package:imalichat/domain/entities/engagement.dart';
import 'package:imalichat/domain/entities/ledger_account.dart';
import 'package:imalichat/domain/entities/sub_account.dart';
import 'package:imalichat/domain/entities/targeting_criteria.dart';
import 'package:imalichat/domain/entities/user.dart';
import 'package:imalichat/domain/entities/user_profile.dart';
import 'package:imalichat/domain/enums/engagement_status.dart';
import 'package:imalichat/domain/enums/user_status.dart';
import 'package:imalichat/domain/value_objects/engagement_evidence.dart';

/// Test fixtures for integration tests.
class TestFixtures {
  TestFixtures._();

  /// Authenticated test user
  static User get authenticatedUser => User(
        id: 'test_user_123',
        phoneNumber: '+27612345678',
        status: UserStatus.active,
        isPotEligible: true,
        hasAcceptedTerms: true,
        hasCompletedOnboarding: true,
        referralCode: 'TESTCODE',
        profile: UserProfile(
          displayName: 'Test User',
          username: 'testuser',
          gender: 'male',
          dateOfBirth: DateTime(1990, 5, 15),
          province: 'gauteng',
          city: 'johannesburg',
          languages: const ['english', 'zulu'],
          interests: const ['sports', 'music'],
        ),
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime.now(),
      );

  /// User at daily cap (30 engagements)
  static User get userAtDailyCap => authenticatedUser;

  /// Sample earn threads
  static List<EarnThread> get sampleThreads => [
        EarnThread(
          id: 'thread_1',
          clientId: 'client_1',
          clientName: 'Test Brand',
          title: 'Watch & Earn Campaign',
          description: 'Watch videos and earn tokens',
          isActive: true,
          isPinned: false,
          isFeatured: true,
          availableOpportunities: 3,
          completedOpportunities: 0,
          completedUniqueUsers: 150,
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
        ),
        EarnThread(
          id: 'thread_2',
          clientId: 'client_2',
          clientName: 'Another Brand',
          title: 'Survey & Earn',
          description: 'Answer surveys for tokens',
          isActive: true,
          isPinned: true,
          isFeatured: false,
          availableOpportunities: 5,
          completedOpportunities: 2,
          completedUniqueUsers: 500,
          createdAt: DateTime.now().subtract(const Duration(days: 14)),
        ),
      ];

  /// Featured thread only
  static List<EarnThread> get featuredThreads =>
      sampleThreads.where((t) => t.isFeatured).toList();

  /// Empty threads list
  static List<EarnThread> get emptyThreads => [];

  /// Sample opportunities
  static List<EarnOpportunity> get sampleOpportunities => [
        EarnOpportunity(
          id: 'opp_1',
          threadId: 'thread_1',
          clientId: 'client_1',
          clientName: 'Test Brand',
          title: 'Watch Product Video',
          description: 'Watch this 30 second product video to earn tokens',
          earningType: EarningType.video,
          tokenReward: 100,
          durationSeconds: 30,
          mediaUrl: 'https://example.com/video1.mp4',
          mediaType: MediaType.video,
          questions: const [],
          isActive: true,
          expiresAt: DateTime.now().add(const Duration(days: 30)),
        ),
        EarnOpportunity(
          id: 'opp_2',
          threadId: 'thread_1',
          clientId: 'client_1',
          clientName: 'Test Brand',
          title: 'Product Survey',
          description: 'Complete this short survey about the product',
          earningType: EarningType.survey,
          tokenReward: 150,
          durationSeconds: 60,
          mediaType: MediaType.video,
          questions: const [
            SurveyQuestion(
              id: 'q1',
              text: 'How likely are you to recommend this product?',
              options: ['Very likely', 'Likely', 'Neutral', 'Unlikely'],
              orderIndex: 0,
            ),
            SurveyQuestion(
              id: 'q2',
              text: 'What did you like most?',
              options: ['Quality', 'Price', 'Design', 'Other'],
              orderIndex: 1,
            ),
          ],
          isActive: true,
        ),
      ];

  /// Video opportunity only
  static EarnOpportunity get videoOpportunity => sampleOpportunities.first;

  /// Survey opportunity only
  static EarnOpportunity get surveyOpportunity => sampleOpportunities.last;

  /// Empty opportunities
  static List<EarnOpportunity> get emptyOpportunities => [];

  /// Started engagement
  static Engagement get startedEngagement => Engagement(
        id: 'engagement_1',
        oddienceCampaignId: 'camp_1',
        userId: 'test_user_123',
        earnOpportunityId: 'opp_1',
        threadId: 'thread_1',
        clientId: 'client_1',
        status: EngagementStatus.started,
        startedAt: DateTime.now(),
        watchDurationSeconds: 0,
        requiredDurationSeconds: 30,
        answers: const [],
        attemptNumber: 1,
        createdAt: DateTime.now(),
      );

  /// Watching engagement (in progress)
  static Engagement get watchingEngagement => Engagement(
        id: 'engagement_1',
        oddienceCampaignId: 'camp_1',
        userId: 'test_user_123',
        earnOpportunityId: 'opp_1',
        threadId: 'thread_1',
        clientId: 'client_1',
        status: EngagementStatus.watching,
        startedAt: DateTime.now().subtract(const Duration(seconds: 15)),
        watchDurationSeconds: 15,
        requiredDurationSeconds: 30,
        answers: const [],
        attemptNumber: 1,
        createdAt: DateTime.now().subtract(const Duration(seconds: 15)),
      );

  /// Completed engagement
  static Engagement get completedEngagement => Engagement(
        id: 'engagement_1',
        oddienceCampaignId: 'camp_1',
        userId: 'test_user_123',
        earnOpportunityId: 'opp_1',
        threadId: 'thread_1',
        clientId: 'client_1',
        status: EngagementStatus.completed,
        startedAt: DateTime.now().subtract(const Duration(seconds: 35)),
        completedAt: DateTime.now(),
        watchDurationSeconds: 35,
        requiredDurationSeconds: 30,
        tokensEarned: 100,
        answers: const [],
        attemptNumber: 1,
        createdAt: DateTime.now().subtract(const Duration(seconds: 35)),
      );

  /// Engagement history
  static List<Engagement> get engagementHistory => [
        completedEngagement,
        Engagement(
          id: 'engagement_2',
          oddienceCampaignId: 'camp_1',
          userId: 'test_user_123',
          earnOpportunityId: 'opp_2',
          threadId: 'thread_1',
          clientId: 'client_1',
          status: EngagementStatus.completed,
          startedAt: DateTime.now().subtract(const Duration(hours: 2)),
          completedAt: DateTime.now().subtract(const Duration(hours: 2)),
          watchDurationSeconds: 60,
          requiredDurationSeconds: 60,
          tokensEarned: 150,
          answers: [
            EngagementAnswer(
              questionId: 'q1',
              selectedOption: 'Very likely',
              answeredAt: DateTime.now().subtract(const Duration(hours: 2)),
            ),
            EngagementAnswer(
              questionId: 'q2',
              selectedOption: 'Quality',
              answeredAt: DateTime.now().subtract(const Duration(hours: 2)),
            ),
          ],
          attemptNumber: 1,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ];

  /// Main wallet (sub-account)
  static SubAccount get mainWallet => SubAccount(
        id: 'sub_main',
        userId: 'test_user_123',
        accountTypeId: null,
        name: 'iMaliChat',
        balance: 5000,
        lifetimeCredits: 10000,
        lifetimeDebits: 5000,
        isActive: true,
        isDefault: true,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime.now(),
      );

  /// Ledger account
  static LedgerAccount get userLedgerAccount => LedgerAccount(
        id: 'user:test_user_123',
        type: LedgerAccountType.user,
        name: 'Test User',
        ownerId: 'test_user_123',
        balance: 5000,
        currency: 'TOKEN',
        status: LedgerAccountStatus.active,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime.now(),
      );

  /// Empty targeting (all users)
  static const TargetingCriteria emptyTargeting = TargetingCriteria();

  /// Targeted criteria (males 18-35 in Gauteng)
  static const TargetingCriteria maleTargeting = TargetingCriteria(
    genders: ['male'],
    ageMin: 18,
    ageMax: 35,
    provinces: ['gauteng'],
  );

  /// Sample engagement evidence for video watch
  static EngagementEvidence get videoEvidence => EngagementEvidence(
        deviceFingerprint: 'test_fingerprint_123',
        watchDurationMs: 35000,
        videoSeeked: false,
        screenVisible: true,
        appInForeground: true,
        surveyResponseTimesMs: const [],
        videoStartedAt: DateTime.now().subtract(const Duration(seconds: 35)),
        surveySubmittedAt: DateTime.now(),
      );

  /// Sample engagement evidence for survey
  static EngagementEvidence get surveyEvidence => EngagementEvidence(
        deviceFingerprint: 'test_fingerprint_123',
        watchDurationMs: 60000,
        videoSeeked: false,
        screenVisible: true,
        appInForeground: true,
        surveyResponseTimesMs: const [3000, 2500],
        videoStartedAt: DateTime.now().subtract(const Duration(minutes: 1)),
        surveySubmittedAt: DateTime.now(),
      );
}
