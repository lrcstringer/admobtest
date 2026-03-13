/// Application-wide constants for iMaliChat
abstract class AppConstants {
  // Token Economics
  /// Value of 1 token in ZAR (R0.01 per token)
  static const double tokenValueZar = 0.01;

  /// Number of tokens per R1 ZAR (100 tokens = R1)
  static const int tokensPerZar = 100;

  /// Convert tokens to ZAR
  static double tokensToZar(int tokens) => tokens / tokensPerZar;

  /// Convert ZAR to tokens
  static int zarToTokens(double zar) => (zar * tokensPerZar).round();

  static const int rewardStdTokens = 5;
  static const int rewardBonusTokens = 10;
  static const double bonusShare = 0.20;

  // Reward Splits
  static const double splitUser = 0.90;
  static const double splitDailyPot = 0.05;
  static const double splitWeeklyPot = 0.05;

  // Caps & Limits
  static const int dailyEarnCap = 30;
  static const int cashoutMinTokens = 500;
  static const int chatSendDailyCapTokens = 50000;
  static const int chatRequestMaxTokens = 20000;

  // Eligibility
  static const int newUserPotLockHours = 48;
  static const int firstCashoutEligibilityDays = 7;
  static const int firstCashoutHoldHours = 48;

  // Streaks (score multipliers)
  static const Map<int, double> streakMultipliers = {
    3: 1.20,
    7: 1.35,
    14: 1.50,
  };

  // Pot Distributions
  static const List<double> dailyPotSplits = [0.40, 0.25, 0.20, 0.10, 0.05];
  static const int weeklyPotTopN = 10;

  // Referrals
  static const int refStarterTokens = 10;
  static const int refMilestoneTokens = 40;
  static const int refMilestoneActions = 25;
  static const int refMilestoneDays = 14;
  static const double refAssistScorePercent = 0.20;
  static const int refAssistScoreDailyCap = 8;

  // Pot Close Times (SAST = UTC+2)
  static const int dailyPotCloseHour = 20;
  static const int weeklyPotCloseDay = 7; // Sunday

  // App Info
  static const String appName = 'iMaliChat';
  static const String appVersion = '1.0.0';

  // Deep Links
  static const String deepLinkDomain = 'https://imalichat.app';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration otpTimeout = Duration(seconds: 60);

  // Animation Durations
  static const Duration animFast = Duration(milliseconds: 150);
  static const Duration animNormal = Duration(milliseconds: 300);
  static const Duration animSlow = Duration(milliseconds: 500);
}
