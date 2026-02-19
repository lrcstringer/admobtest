import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/spray_occasion.dart';
import '../enums/spray_status.dart';

part 'token_spray.freezed.dart';
part 'token_spray.g.dart';

@freezed
class SprayContribution with _$SprayContribution {
  const factory SprayContribution({
    required int amount,
    required DateTime contributedAt,
    required String displayName,
    String? message,
  }) = _SprayContribution;

  factory SprayContribution.fromJson(Map<String, dynamic> json) =>
      _$SprayContributionFromJson(json);
}

@freezed
class SprayTopContributor with _$SprayTopContributor {
  const factory SprayTopContributor({
    required String userId,
    required String displayName,
    required int amount,
    required int rank,
  }) = _SprayTopContributor;

  factory SprayTopContributor.fromJson(Map<String, dynamic> json) =>
      _$SprayTopContributorFromJson(json);
}

@freezed
class TokenSpray with _$TokenSpray {
  const factory TokenSpray({
    required String id,
    required String communityId,
    required String communityName,
    required String messageId,
    required String creatorId,
    required String creatorName,
    required String recipientId,
    required String recipientName,
    required SprayOccasion occasion,
    required String occasionText,
    required String message,
    int? targetAmount,
    required int currentTotal,
    required Map<String, SprayContribution> contributions,
    required int contributorCount,
    @Default([]) List<SprayTopContributor> topContributors,
    required SprayStatus status,
    required DateTime createdAt,
    DateTime? closedAt,
    DateTime? claimedAt,
    required DateTime expiresAt,
  }) = _TokenSpray;

  const TokenSpray._();

  factory TokenSpray.fromJson(Map<String, dynamic> json) =>
      _$TokenSprayFromJson(json);

  bool get isActive => status == SprayStatus.active;
  bool get isClosed => status == SprayStatus.closed;
  bool get isClaimed => status == SprayStatus.claimed;
  bool get isExpired =>
      status == SprayStatus.expired || DateTime.now().isAfter(expiresAt);
  double get currentTotalZar => currentTotal / 100;
  double get progressPercent =>
      targetAmount != null && targetAmount! > 0
          ? (currentTotal / targetAmount!).clamp(0.0, 1.0)
          : 0.0;
  bool hasContributed(String userId) => contributions.containsKey(userId);
}
