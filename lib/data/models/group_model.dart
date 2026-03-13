// DEPRECATED: Use CommunityModel instead. Will be removed in a future cleanup PR.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/group.dart';
import '../../core/utils/firestore_helpers.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

/// Data model for GroupSettings
@freezed
abstract class GroupSettingsModel with _$GroupSettingsModel {
  const factory GroupSettingsModel({
    required int requireApprovalAbove,
    required bool allowMemberWithdrawals,
    required String contributionCycle,
    required int contributionAmount,
    required int penaltyPercentage,
  }) = _GroupSettingsModel;

  const GroupSettingsModel._();

  factory GroupSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$GroupSettingsModelFromJson(json);

  GroupSettings toEntity() => GroupSettings(
        requireApprovalAbove: requireApprovalAbove,
        allowMemberWithdrawals: allowMemberWithdrawals,
        contributionCycle: ContributionCycle.values.firstWhere(
          (e) => e.name == contributionCycle,
          orElse: () => ContributionCycle.none,
        ),
        contributionAmount: contributionAmount,
        penaltyPercentage: penaltyPercentage,
      );

  factory GroupSettingsModel.fromEntity(GroupSettings entity) =>
      GroupSettingsModel(
        requireApprovalAbove: entity.requireApprovalAbove,
        allowMemberWithdrawals: entity.allowMemberWithdrawals,
        contributionCycle: entity.contributionCycle.name,
        contributionAmount: entity.contributionAmount,
        penaltyPercentage: entity.penaltyPercentage,
      );
}

/// Data model for StokvelSettings
@freezed
abstract class StokvelSettingsModel with _$StokvelSettingsModel {
  const factory StokvelSettingsModel({
    required String payoutType,
    required String payoutSchedule,
    String? currentPayoutRecipient,
    @NullableTimestampConverter() DateTime? nextPayoutDate,
    required List<String> payoutOrder,
  }) = _StokvelSettingsModel;

  const StokvelSettingsModel._();

  factory StokvelSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$StokvelSettingsModelFromJson(json);

  StokvelSettings toEntity() => StokvelSettings(
        payoutType: PayoutType.values.firstWhere(
          (e) => e.name == payoutType || _snakeToCamel(payoutType) == e.name,
          orElse: () => PayoutType.rotating,
        ),
        payoutSchedule: payoutSchedule,
        currentPayoutRecipient: currentPayoutRecipient,
        nextPayoutDate: nextPayoutDate,
        payoutOrder: payoutOrder,
      );

  factory StokvelSettingsModel.fromEntity(StokvelSettings entity) =>
      StokvelSettingsModel(
        payoutType: entity.payoutType.name,
        payoutSchedule: entity.payoutSchedule,
        currentPayoutRecipient: entity.currentPayoutRecipient,
        nextPayoutDate: entity.nextPayoutDate,
        payoutOrder: entity.payoutOrder,
      );
}

String _snakeToCamel(String s) {
  final parts = s.split('_');
  if (parts.length == 1) return s;
  return parts.first +
      parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
}

/// Data model for Group
///
/// Maps between Firestore document and Group entity.
/// Collection: groups/{groupId}
@freezed
abstract class GroupModel with _$GroupModel {
  const factory GroupModel({
    required String id,
    required String type,
    required String name,
    required String description,
    String? avatarUrl,
    required String ownerId,
    required List<String> memberIds,
    required int memberCount,
    required int totalBalance,
    required String status,
    required GroupSettingsModel settings,
    StokvelSettingsModel? stokvelSettings,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _GroupModel;

  const GroupModel._();

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  /// Create from Firestore document
  factory GroupModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    final sanitized = sanitizeFirestoreData(data);
    return GroupModel.fromJson({
      ...sanitized,
      'id': doc.id,
    });
  }

  /// Convert to domain entity
  Group toEntity() => Group(
        id: id,
        type: GroupType.values.firstWhere(
          (e) => e.name == type,
          orElse: () => GroupType.club,
        ),
        name: name,
        description: description,
        avatarUrl: avatarUrl,
        ownerId: ownerId,
        memberIds: memberIds,
        memberCount: memberCount,
        totalBalance: totalBalance,
        status: GroupStatus.values.firstWhere(
          (e) => e.name == status,
          orElse: () => GroupStatus.active,
        ),
        settings: settings.toEntity(),
        stokvelSettings: stokvelSettings?.toEntity(),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Create from domain entity
  factory GroupModel.fromEntity(Group entity) => GroupModel(
        id: entity.id,
        type: entity.type.name,
        name: entity.name,
        description: entity.description,
        avatarUrl: entity.avatarUrl,
        ownerId: entity.ownerId,
        memberIds: entity.memberIds,
        memberCount: entity.memberCount,
        totalBalance: entity.totalBalance,
        status: entity.status.name,
        settings: GroupSettingsModel.fromEntity(entity.settings),
        stokvelSettings: entity.stokvelSettings != null
            ? StokvelSettingsModel.fromEntity(entity.stokvelSettings!)
            : null,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}
