import 'package:freezed_annotation/freezed_annotation.dart';

part 'pot_distribution.freezed.dart';
part 'pot_distribution.g.dart';

/// Represents how a pot's prize pool is distributed among winners
@freezed
abstract class PotDistribution with _$PotDistribution {
  const factory PotDistribution({
    required String id,
    required String potPoolId,
    required PotType potType,
    required DateTime drawDate,
    required int totalPrizePool,
    required int totalParticipants,
    required int totalEntries,
    required List<PotWinnerAllocation> winners,
    required DistributionStatus status,
    required DateTime createdAt,
    DateTime? processedAt,
    String? transactionBatchId,
  }) = _PotDistribution;

  factory PotDistribution.fromJson(Map<String, dynamic> json) =>
      _$PotDistributionFromJson(json);
}

/// Represents a single winner's allocation from a pot distribution
@freezed
abstract class PotWinnerAllocation with _$PotWinnerAllocation {
  const factory PotWinnerAllocation({
    required String userId,
    required int rank,
    required int prizeAmount,
    required int entryCount,
    required double winProbability,
    String? transactionId,
    bool? notificationSent,
  }) = _PotWinnerAllocation;

  factory PotWinnerAllocation.fromJson(Map<String, dynamic> json) =>
      _$PotWinnerAllocationFromJson(json);
}

/// Type of pot (daily or weekly)
enum PotType {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
}

/// Status of pot distribution
enum DistributionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
}
