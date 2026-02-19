import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/enums/user_status.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String phoneNumber,
    required String displayName,
    String? displayNameLower,
    String? username,
    String? usernameLower,
    String? avatarUrl,
    String? avatarColor,
    String? gender,
    DateTime? dateOfBirth,
    String? province,
    String? city,
    String? firstName,
    String? lastName,
    // Targeting fields
    List<String>? languages,
    List<String>? interests,
    required UserStatus status,
    String? referralCode,
    String? referredBy,
    required bool hasAcceptedTerms,
    required bool hasCompletedOnboarding,
    required bool isPotEligible,
    DateTime? potEligibleAt,
    String? fcmToken,
    int? riskScore,
    String? primaryDeviceId,
    String? riskLevel,
    DateTime? lastLoginAt,
    @Default('none') String kycTier,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Convert to domain entity
  User toEntity() => User(
        id: userId,
        phoneNumber: phoneNumber,
        status: status,
        isPotEligible: isPotEligible,
        hasAcceptedTerms: hasAcceptedTerms,
        hasCompletedOnboarding: hasCompletedOnboarding,
        createdAt: createdAt,
        updatedAt: updatedAt,
        lastActiveAt: lastActiveAt,
        potEligibleAt: potEligibleAt,
        referralCode: referralCode,
        referredBy: referredBy,
        riskScore: riskScore,
        primaryDeviceId: primaryDeviceId,
        riskLevel: riskLevel,
        lastLoginAt: lastLoginAt,
        kycTier: kycTier,
        profile: UserProfile(
          displayName: displayName,
          username: username,
          avatarUrl: avatarUrl,
          avatarColor: avatarColor,
          gender: gender,
          dateOfBirth: dateOfBirth,
          province: province,
          city: city,
          firstName: firstName,
          lastName: lastName,
          languages: languages,
          interests: interests,
        ),
      );

  /// Create from domain entity
  factory UserModel.fromEntity(User user) => UserModel(
        userId: user.id,
        phoneNumber: user.phoneNumber,
        displayName: user.profile?.displayName ?? 'iMali User',
        displayNameLower: (user.profile?.displayName ?? 'iMali User').toLowerCase(),
        username: user.profile?.username,
        usernameLower: user.profile?.username?.toLowerCase(),
        avatarUrl: user.profile?.avatarUrl,
        avatarColor: user.profile?.avatarColor,
        gender: user.profile?.gender,
        dateOfBirth: user.profile?.dateOfBirth,
        province: user.profile?.province,
        city: user.profile?.city,
        firstName: user.profile?.firstName,
        lastName: user.profile?.lastName,
        languages: user.profile?.languages,
        interests: user.profile?.interests,
        status: user.status,
        referralCode: user.referralCode,
        referredBy: user.referredBy,
        hasAcceptedTerms: user.hasAcceptedTerms,
        hasCompletedOnboarding: user.hasCompletedOnboarding,
        isPotEligible: user.isPotEligible,
        potEligibleAt: user.potEligibleAt,
        fcmToken: null,
        riskScore: user.riskScore,
        primaryDeviceId: user.primaryDeviceId,
        riskLevel: user.riskLevel,
        lastLoginAt: user.lastLoginAt,
        kycTier: user.kycTier,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
        lastActiveAt: user.lastActiveAt,
      );
}
