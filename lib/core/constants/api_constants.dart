/// API-related constants
abstract class ApiConstants {
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String walletsCollection = 'wallets';
  static const String transactionsCollection = 'transactions';
  static const String engagementsCollection = 'engagements';
  static const String earnThreadsCollection = 'earnThreads';
  static const String earnOpportunitiesCollection = 'earnOpportunities';
  static const String chatThreadsCollection = 'chatThreads';
  static const String chatCardsCollection = 'chatCards';
  static const String contactsCollection = 'contacts';
  static const String referralsCollection = 'referrals';
  static const String userScoresCollection = 'userScores';
  static const String potPoolsCollection = 'potPools';
  static const String purchasesCollection = 'purchases';
  static const String processedKeysCollection = 'processedKeys';
  static const String fraudFlagsCollection = 'fraudFlags';

  // Cloud Functions
  static const String fnRequestOtp = 'requestOtp';
  static const String fnStartEngagement = 'startEngagement';
  static const String fnProcessEngagement = 'processEngagement';
  static const String fnSendTokens = 'sendTokens';
  static const String fnCreateRequest = 'createRequest';
  static const String fnPayRequest = 'payRequest';
  static const String fnDeclineRequest = 'declineRequest';
  static const String fnRequestCashout = 'requestCashout';
  static const String fnSyncContacts = 'syncContacts';
  static const String fnInviteContact = 'inviteContact';
  static const String fnPurchaseAirtime = 'purchaseAirtime';
  static const String fnPurchaseElectricity = 'purchaseElectricity';

  // Error Codes
  static const String errDailyCapReached = 'DAILY_CAP_REACHED';
  static const String errInsufficientBalance = 'INSUFFICIENT_BALANCE';
  static const String errUserSuspended = 'USER_SUSPENDED';
  static const String errNotEligible = 'NOT_ELIGIBLE';
  static const String errInvalidOtp = 'INVALID_OTP';
  static const String errOtpExpired = 'OTP_EXPIRED';
  static const String errTooManyAttempts = 'TOO_MANY_ATTEMPTS';
}
