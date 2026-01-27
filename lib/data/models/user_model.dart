import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/enums/user_status.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String oddienceUserId,
    required String phoneNumber,
    required String displayName,
    String? username,
    String? usernameLower,
    String? avatarUrl,
    String? gender,
    DateTime? dateOfBirth,
    String? province,
    String? firstName,
    String? lastName,
    required UserStatus status,
    String? referralCode,
    String? referredBy,
    required bool hasAcceptedTerms,
    required bool hasCompletedOnboarding,
    required bool isPotEligible,
    DateTime? potEligibleAt,
    String? fcmToken,
    int? riskScore,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Convert to domain entity
  User toEntity() => User(
        id: oddienceUserId,
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
        riskScore: riskScore,
        profile: UserProfile(
          displayName: displayName,
          username: username,
          avatarUrl: avatarUrl,
          gender: gender,
          dateOfBirth: dateOfBirth,
          province: province,
          firstName: firstName,
          lastName: lastName,
        ),
      );

  /// Create from domain entity
  factory UserModel.fromEntity(User user) => UserModel(
        oddienceUserId: user.id,
        phoneNumber: user.phoneNumber,
        displayName: user.profile?.displayName ?? 'iMali User',
        username: user.profile?.username,
        usernameLower: user.profile?.username?.toLowerCase(),
        avatarUrl: user.profile?.avatarUrl,
        gender: user.profile?.gender,
        dateOfBirth: user.profile?.dateOfBirth,
        province: user.profile?.province,
        firstName: user.profile?.firstName,
        lastName: user.profile?.lastName,
        status: user.status,
        referralCode: user.referralCode,
        referredBy: null,
        hasAcceptedTerms: user.hasAcceptedTerms,
        hasCompletedOnboarding: user.hasCompletedOnboarding,
        isPotEligible: user.isPotEligible,
        potEligibleAt: user.potEligibleAt,
        fcmToken: null,
        riskScore: user.riskScore,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
        lastActiveAt: user.lastActiveAt,
      );
}
