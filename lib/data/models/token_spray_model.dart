import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/token_spray.dart';
import '../../domain/enums/spray_occasion.dart';
import '../../domain/enums/spray_status.dart';

part 'token_spray_model.freezed.dart';

@freezed
class TokenSprayModel with _$TokenSprayModel {
  const factory TokenSprayModel({
    required String id,
    required String communityId,
    required String communityName,
    required String messageId,
    required String creatorId,
    required String creatorName,
    required String recipientId,
    required String recipientName,
    required String occasion,
    required String occasionText,
    required String message,
    int? targetAmount,
    required int currentTotal,
    required Map<String, Map<String, dynamic>> contributions,
    required int contributorCount,
    @Default([]) List<Map<String, dynamic>> topContributors,
    required String status,
    required DateTime createdAt,
    DateTime? closedAt,
    DateTime? claimedAt,
    required DateTime expiresAt,
  }) = _TokenSprayModel;

  const TokenSprayModel._();

  factory TokenSprayModel.fromJson(Map<String, dynamic> json) {
    final rawContributions = json['contributions'];
    final rawTopContributors = json['topContributors'];

    return TokenSprayModel(
      id: json['id'] as String,
      communityId: json['communityId'] as String,
      communityName: json['communityName'] as String? ?? '',
      messageId: json['messageId'] as String? ?? '',
      creatorId: json['creatorId'] as String,
      creatorName: json['creatorName'] as String? ?? 'Unknown',
      recipientId: json['recipientId'] as String,
      recipientName: json['recipientName'] as String? ?? 'Unknown',
      occasion: json['occasion'] as String? ?? 'custom',
      occasionText: json['occasionText'] as String? ?? '',
      message: json['message'] as String? ?? '',
      targetAmount: json['targetAmount'] as int?,
      currentTotal: json['currentTotal'] as int? ?? 0,
      contributions: _parseContributions(rawContributions),
      contributorCount: json['contributorCount'] as int? ?? 0,
      topContributors: _parseTopContributors(rawTopContributors),
      status: json['status'] as String? ?? 'active',
      createdAt: _parseDateTimeRequired(json['createdAt']),
      closedAt: _parseDateTime(json['closedAt']),
      claimedAt: _parseDateTime(json['claimedAt']),
      expiresAt: _parseDateTimeRequired(json['expiresAt']),
    );
  }

  factory TokenSprayModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TokenSprayModel.fromJson({...data, 'id': doc.id});
  }

  TokenSpray toEntity() {
    return TokenSpray(
      id: id,
      communityId: communityId,
      communityName: communityName,
      messageId: messageId,
      creatorId: creatorId,
      creatorName: creatorName,
      recipientId: recipientId,
      recipientName: recipientName,
      occasion: _parseSprayOccasion(occasion),
      occasionText: occasionText,
      message: message,
      targetAmount: targetAmount,
      currentTotal: currentTotal,
      contributions: _toEntityContributions(),
      contributorCount: contributorCount,
      topContributors: _toEntityTopContributors(),
      status: _parseSprayStatus(status),
      createdAt: createdAt,
      closedAt: closedAt,
      claimedAt: claimedAt,
      expiresAt: expiresAt,
    );
  }

  Map<String, SprayContribution> _toEntityContributions() {
    return contributions.map((key, value) {
      return MapEntry(
        key,
        SprayContribution(
          amount: value['amount'] as int? ?? 0,
          contributedAt: _parseDateTimeRequired(value['contributedAt']),
          displayName: value['displayName'] as String? ?? 'Unknown',
          message: value['message'] as String?,
        ),
      );
    });
  }

  List<SprayTopContributor> _toEntityTopContributors() {
    return topContributors.map((raw) {
      return SprayTopContributor(
        userId: raw['userId'] as String? ?? '',
        displayName: raw['displayName'] as String? ?? 'Unknown',
        amount: raw['amount'] as int? ?? 0,
        rank: raw['rank'] as int? ?? 0,
      );
    }).toList();
  }

  // =========================================================================
  // PARSE HELPERS
  // =========================================================================

  static SprayOccasion _parseSprayOccasion(String value) {
    switch (value) {
      case 'new_job':
        return SprayOccasion.newJob;
      case 'birthday':
        return SprayOccasion.birthday;
      case 'graduation':
        return SprayOccasion.graduation;
      case 'new_baby':
        return SprayOccasion.newBaby;
      case 'wedding':
        return SprayOccasion.wedding;
      case 'achievement':
        return SprayOccasion.achievement;
      case 'custom':
        return SprayOccasion.custom;
      default:
        return SprayOccasion.custom;
    }
  }

  static SprayStatus _parseSprayStatus(String value) {
    switch (value) {
      case 'active':
        return SprayStatus.active;
      case 'closed':
        return SprayStatus.closed;
      case 'claimed':
        return SprayStatus.claimed;
      case 'expired':
        return SprayStatus.expired;
      default:
        return SprayStatus.active;
    }
  }

  static Map<String, Map<String, dynamic>> _parseContributions(dynamic raw) {
    if (raw == null || raw is! Map) return {};
    return raw.map((key, value) {
      return MapEntry(
        key.toString(),
        value is Map ? Map<String, dynamic>.from(value) : <String, dynamic>{},
      );
    });
  }

  static List<Map<String, dynamic>> _parseTopContributors(dynamic raw) {
    if (raw == null || raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  static DateTime _parseDateTimeRequired(dynamic raw) {
    if (raw is Timestamp) return raw.toDate();
    if (raw is String) return DateTime.parse(raw);
    if (raw is DateTime) return raw;
    return DateTime.now();
  }

  static DateTime? _parseDateTime(dynamic raw) {
    if (raw == null) return null;
    if (raw is Timestamp) return raw.toDate();
    if (raw is String) return DateTime.parse(raw);
    if (raw is DateTime) return raw;
    return null;
  }
}
