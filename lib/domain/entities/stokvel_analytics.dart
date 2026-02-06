/// Result of a stokvel payout operation
class StokvelPayoutResult {
  final String transactionId;
  final String journalId;
  final String recipientId;
  final int amount;

  const StokvelPayoutResult({
    required this.transactionId,
    required this.journalId,
    required this.recipientId,
    required this.amount,
  });

  factory StokvelPayoutResult.fromJson(Map<String, dynamic> json) {
    return StokvelPayoutResult(
      transactionId: json['transactionId'] as String,
      journalId: json['journalId'] as String,
      recipientId: json['recipientId'] as String,
      amount: json['amount'] as int,
    );
  }
}

/// Monthly breakdown of stokvel transactions
class MonthlyBreakdown {
  final int contributions;
  final int withdrawals;
  final int payouts;
  final int penalties;

  const MonthlyBreakdown({
    required this.contributions,
    required this.withdrawals,
    required this.payouts,
    required this.penalties,
  });

  factory MonthlyBreakdown.fromJson(Map<String, dynamic> json) {
    return MonthlyBreakdown(
      contributions: json['contributions'] as int? ?? 0,
      withdrawals: json['withdrawals'] as int? ?? 0,
      payouts: json['payouts'] as int? ?? 0,
      penalties: json['penalties'] as int? ?? 0,
    );
  }
}

/// Basic member information for analytics display
class MemberInfo {
  final String displayName;
  final String? avatarUrl;

  const MemberInfo({
    required this.displayName,
    this.avatarUrl,
  });

  factory MemberInfo.fromJson(Map<String, dynamic> json) {
    return MemberInfo(
      displayName: json['displayName'] as String? ?? 'Unknown',
      avatarUrl: json['avatarUrl'] as String?,
    );
  }
}

/// Comprehensive analytics for a stokvel group
class StokvelAnalytics {
  final int totalContributions;
  final int totalWithdrawals;
  final int totalPayouts;
  final int totalPenalties;
  final Map<String, MonthlyBreakdown> monthlyBreakdown;
  final Map<String, int> memberContributions;
  final Map<String, MemberInfo> memberInfo;
  final int currentBalance;

  const StokvelAnalytics({
    required this.totalContributions,
    required this.totalWithdrawals,
    required this.totalPayouts,
    required this.totalPenalties,
    required this.monthlyBreakdown,
    required this.memberContributions,
    required this.memberInfo,
    required this.currentBalance,
  });

  /// Factory that parses the Cloud Function response structure
  /// Expected structure:
  /// {
  ///   "analytics": { totalContributions, totalWithdrawals, monthlyBreakdown, memberContributions, ... },
  ///   "memberInfo": { userId: { displayName, avatarUrl }, ... },
  ///   "currentBalance": int
  /// }
  factory StokvelAnalytics.fromJson(Map<String, dynamic> json) {
    final analytics = json['analytics'] as Map<String, dynamic>? ?? json;
    final memberInfoJson = json['memberInfo'] as Map<String, dynamic>? ?? {};

    return StokvelAnalytics(
      totalContributions: analytics['totalContributions'] as int? ?? 0,
      totalWithdrawals: analytics['totalWithdrawals'] as int? ?? 0,
      totalPayouts: analytics['totalPayouts'] as int? ?? 0,
      totalPenalties: analytics['totalPenalties'] as int? ?? 0,
      monthlyBreakdown:
          (analytics['monthlyBreakdown'] as Map<String, dynamic>? ?? {}).map(
        (k, v) => MapEntry(
            k, MonthlyBreakdown.fromJson(Map<String, dynamic>.from(v as Map))),
      ),
      memberContributions:
          (analytics['memberContributions'] as Map<String, dynamic>? ?? {})
              .map((k, v) => MapEntry(k, v as int)),
      memberInfo: memberInfoJson.map(
        (k, v) =>
            MapEntry(k, MemberInfo.fromJson(Map<String, dynamic>.from(v as Map))),
      ),
      currentBalance: json['currentBalance'] as int? ?? 0,
    );
  }
}
