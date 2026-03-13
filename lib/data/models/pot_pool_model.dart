import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pot_pool.dart';
import '../../domain/enums/pot_type.dart';

part 'pot_pool_model.freezed.dart';

@freezed
abstract class PotPoolModel with _$PotPoolModel {
  const factory PotPoolModel({
    required String id,
    required String type,
    required int totalTokens,
    required int participantCount,
    required DateTime periodStart,
    required DateTime periodEnd,
    required bool isActive,
    required bool isDistributed,
    DateTime? distributedAt,
    List<PotWinnerModel>? winners,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _PotPoolModel;

  const PotPoolModel._();

  factory PotPoolModel.fromJson(Map<String, dynamic> json) {
    final periodStart = json['periodStart'];
    final periodEnd = json['periodEnd'];
    final createdAt = json['createdAt'];
    final updatedAt = json['updatedAt'];
    final distributedAt = json['distributedAt'];
    final winners = json['winners'] as List?;

    return PotPoolModel(
      id: json['id'] as String,
      type: json['type'] as String? ?? 'daily',
      totalTokens: json['totalTokens'] as int? ?? 0,
      participantCount: json['participantCount'] as int? ?? 0,
      periodStart: periodStart is Timestamp
          ? periodStart.toDate()
          : DateTime.parse(periodStart as String),
      periodEnd: periodEnd is Timestamp
          ? periodEnd.toDate()
          : DateTime.parse(periodEnd as String),
      isActive: json['isActive'] as bool? ?? false,
      isDistributed: json['isDistributed'] as bool? ?? false,
      distributedAt: distributedAt == null
          ? null
          : distributedAt is Timestamp
              ? distributedAt.toDate()
              : DateTime.parse(distributedAt as String),
      winners: winners?.map((w) => PotWinnerModel.fromJson(w as Map<String, dynamic>)).toList(),
      createdAt: createdAt is Timestamp
          ? createdAt.toDate()
          : DateTime.parse(createdAt as String),
      updatedAt: updatedAt == null
          ? null
          : updatedAt is Timestamp
              ? updatedAt.toDate()
              : DateTime.parse(updatedAt as String),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'type': type,
      'totalTokens': totalTokens,
      'participantCount': participantCount,
      'periodStart': Timestamp.fromDate(periodStart),
      'periodEnd': Timestamp.fromDate(periodEnd),
      'isActive': isActive,
      'isDistributed': isDistributed,
      'distributedAt': distributedAt != null ? Timestamp.fromDate(distributedAt!) : null,
      'winners': winners?.map((w) => w.toFirestoreJson()).toList(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  PotPool toEntity() {
    return PotPool(
      id: id,
      type: _parsePotType(type),
      totalTokens: totalTokens,
      participantCount: participantCount,
      periodStart: periodStart,
      periodEnd: periodEnd,
      isActive: isActive,
      isDistributed: isDistributed,
      distributedAt: distributedAt,
      winners: winners?.map((w) => w.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory PotPoolModel.fromEntity(PotPool entity) {
    return PotPoolModel(
      id: entity.id,
      type: entity.type.name,
      totalTokens: entity.totalTokens,
      participantCount: entity.participantCount,
      periodStart: entity.periodStart,
      periodEnd: entity.periodEnd,
      isActive: entity.isActive,
      isDistributed: entity.isDistributed,
      distributedAt: entity.distributedAt,
      winners: entity.winners?.map((w) => PotWinnerModel.fromEntity(w)).toList(),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static PotType _parsePotType(String type) {
    switch (type) {
      case 'daily':
        return PotType.daily;
      case 'weekly':
        return PotType.weekly;
      default:
        return PotType.daily;
    }
  }
}

@freezed
abstract class PotWinnerModel with _$PotWinnerModel {
  const factory PotWinnerModel({
    required String userId,
    required String displayName,
    String? username,
    required int rank,
    required int tokensWon,
    required double percentage,
  }) = _PotWinnerModel;

  const PotWinnerModel._();

  factory PotWinnerModel.fromJson(Map<String, dynamic> json) {
    return PotWinnerModel(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String? ?? 'User',
      username: json['username'] as String?,
      rank: json['rank'] as int? ?? 0,
      tokensWon: json['tokensWon'] as int? ?? 0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'username': username,
      'rank': rank,
      'tokensWon': tokensWon,
      'percentage': percentage,
    };
  }

  PotWinner toEntity() {
    return PotWinner(
      userId: userId,
      displayName: displayName,
      username: username,
      rank: rank,
      tokensWon: tokensWon,
      percentage: percentage,
    );
  }

  factory PotWinnerModel.fromEntity(PotWinner entity) {
    return PotWinnerModel(
      userId: entity.userId,
      displayName: entity.displayName,
      username: entity.username,
      rank: entity.rank,
      tokensWon: entity.tokensWon,
      percentage: entity.percentage,
    );
  }
}
