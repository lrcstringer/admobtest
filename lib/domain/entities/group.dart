import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/token_amount.dart';

part 'group.freezed.dart';
part 'group.g.dart';

// DEPRECATED: Use Community entities instead. Will be removed in a future cleanup PR.

/// Group types supported by the platform
enum GroupType {
  @JsonValue('stokvel')
  stokvel,
  @JsonValue('family')
  family,
  @JsonValue('organization')
  organization,
  @JsonValue('club')
  club,
}

/// Group status
enum GroupStatus {
  @JsonValue('active')
  active,
  @JsonValue('suspended')
  suspended,
  @JsonValue('closed')
  closed,
}

/// Contribution cycle frequency (for stokvels)
enum ContributionCycle {
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('none')
  none,
}

/// Stokvel payout types
enum PayoutType {
  @JsonValue('rotating')
  rotating,
  @JsonValue('lottery')
  lottery,
  @JsonValue('fixed_date')
  fixedDate,
  @JsonValue('goal_reached')
  goalReached,
}

/// Group settings
@freezed
abstract class GroupSettings with _$GroupSettings {
  const factory GroupSettings({
    required int requireApprovalAbove,
    required bool allowMemberWithdrawals,
    required ContributionCycle contributionCycle,
    required int contributionAmount,
    required int penaltyPercentage,
  }) = _GroupSettings;

  const GroupSettings._();

  factory GroupSettings.fromJson(Map<String, dynamic> json) =>
      _$GroupSettingsFromJson(json);

  /// Default settings for a group type
  factory GroupSettings.defaultFor(GroupType type) {
    switch (type) {
      case GroupType.stokvel:
        return const GroupSettings(
          requireApprovalAbove: 5000,
          allowMemberWithdrawals: false,
          contributionCycle: ContributionCycle.monthly,
          contributionAmount: 1000,
          penaltyPercentage: 5,
        );
      default:
        return const GroupSettings(
          requireApprovalAbove: 5000,
          allowMemberWithdrawals: true,
          contributionCycle: ContributionCycle.none,
          contributionAmount: 0,
          penaltyPercentage: 0,
        );
    }
  }
}

/// Extended settings for stokvel groups
@freezed
abstract class StokvelSettings with _$StokvelSettings {
  const factory StokvelSettings({
    required PayoutType payoutType,
    required String payoutSchedule,
    String? currentPayoutRecipient,
    DateTime? nextPayoutDate,
    required List<String> payoutOrder,
  }) = _StokvelSettings;

  const StokvelSettings._();

  factory StokvelSettings.fromJson(Map<String, dynamic> json) =>
      _$StokvelSettingsFromJson(json);

  /// Default stokvel settings
  factory StokvelSettings.defaultSettings() {
    return const StokvelSettings(
      payoutType: PayoutType.rotating,
      payoutSchedule: '0 0 1 * *',
      currentPayoutRecipient: null,
      nextPayoutDate: null,
      payoutOrder: [],
    );
  }
}

/// Group entity
///
/// Represents a shared account for multiple users (stokvels, family, organizations, clubs).
@freezed
abstract class Group with _$Group {
  const factory Group({
    required String id,
    required GroupType type,
    required String name,
    required String description,
    String? avatarUrl,
    required String ownerId,
    required List<String> memberIds,
    required int memberCount,
    required int totalBalance,
    required GroupStatus status,
    required GroupSettings settings,
    StokvelSettings? stokvelSettings,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Group;

  const Group._();

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  /// Get balance as TokenAmount
  TokenAmount get tokenBalance => TokenAmount(totalBalance);

  /// Check if user is a member
  bool isMember(String userId) => memberIds.contains(userId);

  /// Check if user is the owner
  bool isOwner(String userId) => ownerId == userId;

  /// Check if group is active
  bool get isActive => status == GroupStatus.active;

  /// Check if group is a stokvel
  bool get isStokvel => type == GroupType.stokvel;

  /// Get display name for group type
  String get typeDisplayName {
    switch (type) {
      case GroupType.stokvel:
        return 'Stokvel';
      case GroupType.family:
        return 'Family';
      case GroupType.organization:
        return 'Organization';
      case GroupType.club:
        return 'Club';
    }
  }

  /// Get status display name
  String get statusDisplayName {
    switch (status) {
      case GroupStatus.active:
        return 'Active';
      case GroupStatus.suspended:
        return 'Suspended';
      case GroupStatus.closed:
        return 'Closed';
    }
  }
}
