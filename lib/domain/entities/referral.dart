import 'package:freezed_annotation/freezed_annotation.dart';

part 'referral.freezed.dart';
part 'referral.g.dart';

/// Referral status
enum ReferralStatus {
  pending,
  registered,
  qualified,
  rewarded,
  expired,
}

/// Referral entity representing a user referral
@freezed
abstract class Referral with _$Referral {
  const factory Referral({
    required String id,
    required String referrerUserId,
    required String refereeUserId,
    String? refereeDisplayName,
    String? refereeUsername,
    String? refereeAvatarUrl,
    required ReferralStatus status,
    required String referralCode,
    int? referrerReward,
    int? refereeReward,
    required DateTime createdAt,
    DateTime? registeredAt,
    DateTime? qualifiedAt,
    DateTime? rewardedAt,
    DateTime? expiresAt,
  }) = _Referral;

  const Referral._();

  factory Referral.fromJson(Map<String, dynamic> json) =>
      _$ReferralFromJson(json);

  /// Check if referral is pending
  bool get isPending => status == ReferralStatus.pending;

  /// Check if referral is complete (rewarded)
  bool get isComplete => status == ReferralStatus.rewarded;

  /// Check if referral has expired
  bool get isExpired {
    if (status == ReferralStatus.expired) return true;
    if (expiresAt != null && DateTime.now().isAfter(expiresAt!)) return true;
    return false;
  }

  /// Get total reward (referrer + referee)
  int get totalReward => (referrerReward ?? 0) + (refereeReward ?? 0);

  /// Get referee initials for avatar
  String get refereeInitials {
    final name = refereeDisplayName ?? refereeUsername ?? '??';
    if (name.isEmpty || name == '??') return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }
}

/// Referral statistics
@freezed
abstract class ReferralStats with _$ReferralStats {
  const factory ReferralStats({
    required int totalReferrals,
    required int pendingReferrals,
    required int completedReferrals,
    required int totalEarned,
    required String referralCode,
    required String referralLink,
  }) = _ReferralStats;

  factory ReferralStats.fromJson(Map<String, dynamic> json) =>
      _$ReferralStatsFromJson(json);
}
