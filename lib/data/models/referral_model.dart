import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/referral.dart';

part 'referral_model.freezed.dart';

@freezed
abstract class ReferralModel with _$ReferralModel {
  const factory ReferralModel({
    required String id,
    required String referrerUserId,
    required String refereeUserId,
    String? refereeDisplayName,
    String? refereeUsername,
    String? refereeAvatarUrl,
    required String status,
    required String referralCode,
    int? referrerReward,
    int? refereeReward,
    required DateTime createdAt,
    DateTime? registeredAt,
    DateTime? qualifiedAt,
    DateTime? rewardedAt,
    DateTime? expiresAt,
  }) = _ReferralModel;

  const ReferralModel._();

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    final registeredAt = json['registeredAt'];
    final qualifiedAt = json['qualifiedAt'];
    final rewardedAt = json['rewardedAt'];
    final expiresAt = json['expiresAt'];

    return ReferralModel(
      id: json['id'] as String,
      referrerUserId: json['referrerUserId'] as String,
      refereeUserId: json['refereeUserId'] as String,
      refereeDisplayName: json['refereeDisplayName'] as String?,
      refereeUsername: json['refereeUsername'] as String?,
      refereeAvatarUrl: json['refereeAvatarUrl'] as String?,
      status: json['status'] as String? ?? 'pending',
      referralCode: json['referralCode'] as String,
      referrerReward: json['referrerReward'] as int?,
      refereeReward: json['refereeReward'] as int?,
      createdAt: createdAt is Timestamp
          ? createdAt.toDate()
          : DateTime.parse(createdAt as String),
      registeredAt: registeredAt == null
          ? null
          : registeredAt is Timestamp
              ? registeredAt.toDate()
              : DateTime.parse(registeredAt as String),
      qualifiedAt: qualifiedAt == null
          ? null
          : qualifiedAt is Timestamp
              ? qualifiedAt.toDate()
              : DateTime.parse(qualifiedAt as String),
      rewardedAt: rewardedAt == null
          ? null
          : rewardedAt is Timestamp
              ? rewardedAt.toDate()
              : DateTime.parse(rewardedAt as String),
      expiresAt: expiresAt == null
          ? null
          : expiresAt is Timestamp
              ? expiresAt.toDate()
              : DateTime.parse(expiresAt as String),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'referrerUserId': referrerUserId,
      'refereeUserId': refereeUserId,
      'refereeDisplayName': refereeDisplayName,
      'refereeUsername': refereeUsername,
      'refereeAvatarUrl': refereeAvatarUrl,
      'status': status,
      'referralCode': referralCode,
      'referrerReward': referrerReward,
      'refereeReward': refereeReward,
      'createdAt': Timestamp.fromDate(createdAt),
      'registeredAt': registeredAt != null ? Timestamp.fromDate(registeredAt!) : null,
      'qualifiedAt': qualifiedAt != null ? Timestamp.fromDate(qualifiedAt!) : null,
      'rewardedAt': rewardedAt != null ? Timestamp.fromDate(rewardedAt!) : null,
      'expiresAt': expiresAt != null ? Timestamp.fromDate(expiresAt!) : null,
    };
  }

  Referral toEntity() {
    return Referral(
      id: id,
      referrerUserId: referrerUserId,
      refereeUserId: refereeUserId,
      refereeDisplayName: refereeDisplayName,
      refereeUsername: refereeUsername,
      refereeAvatarUrl: refereeAvatarUrl,
      status: _parseStatus(status),
      referralCode: referralCode,
      referrerReward: referrerReward,
      refereeReward: refereeReward,
      createdAt: createdAt,
      registeredAt: registeredAt,
      qualifiedAt: qualifiedAt,
      rewardedAt: rewardedAt,
      expiresAt: expiresAt,
    );
  }

  factory ReferralModel.fromEntity(Referral entity) {
    return ReferralModel(
      id: entity.id,
      referrerUserId: entity.referrerUserId,
      refereeUserId: entity.refereeUserId,
      refereeDisplayName: entity.refereeDisplayName,
      refereeUsername: entity.refereeUsername,
      refereeAvatarUrl: entity.refereeAvatarUrl,
      status: entity.status.name,
      referralCode: entity.referralCode,
      referrerReward: entity.referrerReward,
      refereeReward: entity.refereeReward,
      createdAt: entity.createdAt,
      registeredAt: entity.registeredAt,
      qualifiedAt: entity.qualifiedAt,
      rewardedAt: entity.rewardedAt,
      expiresAt: entity.expiresAt,
    );
  }

  static ReferralStatus _parseStatus(String status) {
    switch (status) {
      case 'pending':
        return ReferralStatus.pending;
      case 'registered':
        return ReferralStatus.registered;
      case 'qualified':
        return ReferralStatus.qualified;
      case 'rewarded':
        return ReferralStatus.rewarded;
      case 'expired':
        return ReferralStatus.expired;
      default:
        return ReferralStatus.pending;
    }
  }
}

@freezed
abstract class ReferralStatsModel with _$ReferralStatsModel {
  const factory ReferralStatsModel({
    required int totalReferrals,
    required int pendingReferrals,
    required int completedReferrals,
    required int totalEarned,
    required String referralCode,
    required String referralLink,
  }) = _ReferralStatsModel;

  const ReferralStatsModel._();

  factory ReferralStatsModel.fromJson(Map<String, dynamic> json) {
    return ReferralStatsModel(
      totalReferrals: json['totalReferrals'] as int? ?? 0,
      pendingReferrals: json['pendingReferrals'] as int? ?? 0,
      completedReferrals: json['completedReferrals'] as int? ?? 0,
      totalEarned: json['totalEarned'] as int? ?? 0,
      referralCode: json['referralCode'] as String? ?? '',
      referralLink: json['referralLink'] as String? ?? '',
    );
  }

  ReferralStats toEntity() {
    return ReferralStats(
      totalReferrals: totalReferrals,
      pendingReferrals: pendingReferrals,
      completedReferrals: completedReferrals,
      totalEarned: totalEarned,
      referralCode: referralCode,
      referralLink: referralLink,
    );
  }

  factory ReferralStatsModel.fromEntity(ReferralStats entity) {
    return ReferralStatsModel(
      totalReferrals: entity.totalReferrals,
      pendingReferrals: entity.pendingReferrals,
      completedReferrals: entity.completedReferrals,
      totalEarned: entity.totalEarned,
      referralCode: entity.referralCode,
      referralLink: entity.referralLink,
    );
  }
}
