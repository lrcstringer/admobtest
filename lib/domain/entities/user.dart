import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/user_status.dart';
import 'user_profile.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Core user entity
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String phoneNumber,
    required UserStatus status,
    required bool isPotEligible,
    required bool hasAcceptedTerms,
    required bool hasCompletedOnboarding,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
    DateTime? potEligibleAt,
    String? referralCode,
    String? referredBy,
    String? currentVisitorId,
    UserProfile? profile,
    int? riskScore,
    String? primaryDeviceId,
    String? riskLevel,
    DateTime? lastLoginAt,
    @Default('none') String kycTier,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Check if user is verified and active
  bool get isVerified => status == UserStatus.active;

  /// Check if user can earn (verified + profile complete)
  bool get canEarn => isVerified && profile != null;

  /// Check if user can cashout (7 days since signup)
  bool get canCashout {
    final daysSinceSignup = DateTime.now().difference(createdAt).inDays;
    return daysSinceSignup >= 7;
  }

  /// Check if user is eligible for pot participation now
  bool get isPotEligibleNow {
    if (!isPotEligible) return false;
    if (potEligibleAt == null) return false;
    return DateTime.now().isAfter(potEligibleAt!);
  }

  /// Check if onboarding is required
  bool get needsOnboarding => !hasCompletedOnboarding || !hasAcceptedTerms;

  /// Get display name or username or phone
  String get displayName {
    if (profile?.displayName != null && profile!.displayName.isNotEmpty) {
      return profile!.displayName;
    }
    if (profile?.username != null) {
      return '@${profile!.username}';
    }
    return phoneNumber;
  }

  /// Get user initials
  String get initials {
    if (profile?.displayName != null && profile!.displayName.isNotEmpty) {
      final parts = profile!.displayName.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return profile!.displayName.substring(0, 2).toUpperCase();
    }
    return '??';
  }
}
