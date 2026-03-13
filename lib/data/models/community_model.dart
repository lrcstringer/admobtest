import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/community.dart';
import '../../domain/enums/community_status.dart';
import '../../domain/enums/community_type.dart';
import '../../core/utils/firestore_helpers.dart';
import 'group_model.dart'; // Reuse StokvelSettingsModel

part 'community_model.freezed.dart';
part 'community_model.g.dart';

/// Data model for CommunitySettings
@freezed
abstract class CommunitySettingsModel with _$CommunitySettingsModel {
  const factory CommunitySettingsModel({
    @Default(100) int maxMembers,
    @Default(true) bool allowMemberInvites,
    @Default(false) bool onlyAdminsPost,
    @Default(true) bool membersCanShareMedia,
    @Default(false) bool enableFinancials,
    @Default(5000) int requireApprovalAbove,
    @Default(false) bool allowMemberWithdrawals,
    @Default('none') String contributionCycle,
    @Default(0) int contributionAmount,
    @Default(0) int penaltyPercentage,
  }) = _CommunitySettingsModel;

  const CommunitySettingsModel._();

  factory CommunitySettingsModel.fromJson(Map<String, dynamic> json) =>
      _$CommunitySettingsModelFromJson(json);

  CommunitySettings toEntity() => CommunitySettings(
        maxMembers: maxMembers,
        allowMemberInvites: allowMemberInvites,
        onlyAdminsPost: onlyAdminsPost,
        membersCanShareMedia: membersCanShareMedia,
        enableFinancials: enableFinancials,
        requireApprovalAbove: requireApprovalAbove,
        allowMemberWithdrawals: allowMemberWithdrawals,
        contributionCycle: contributionCycle,
        contributionAmount: contributionAmount,
        penaltyPercentage: penaltyPercentage,
      );

  factory CommunitySettingsModel.fromEntity(CommunitySettings entity) =>
      CommunitySettingsModel(
        maxMembers: entity.maxMembers,
        allowMemberInvites: entity.allowMemberInvites,
        onlyAdminsPost: entity.onlyAdminsPost,
        membersCanShareMedia: entity.membersCanShareMedia,
        enableFinancials: entity.enableFinancials,
        requireApprovalAbove: entity.requireApprovalAbove,
        allowMemberWithdrawals: entity.allowMemberWithdrawals,
        contributionCycle: entity.contributionCycle,
        contributionAmount: entity.contributionAmount,
        penaltyPercentage: entity.penaltyPercentage,
      );
}

/// Data model for Community
///
/// Maps between Firestore document and Community entity.
/// Collection: communities/{communityId}
@freezed
abstract class CommunityModel with _$CommunityModel {
  const factory CommunityModel({
    required String id,
    required String type,
    required String name,
    String? description,
    String? avatarUrl,
    required String ownerId,
    required List<String> memberIds,
    required List<String> adminIds,
    required int memberCount,
    @Default(0) int totalBalance,
    required String status,
    required CommunitySettingsModel settings,
    StokvelSettingsModel? stokvelSettings,
    // Last message preview (flat fields — mapped from nested Firestore lastMessage)
    String? lastMessageText,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    @NullableTimestampConverter() DateTime? lastMessageAt,
    // Per-user state
    @Default({}) Map<String, int> unreadCounts,
    @Default({}) Map<String, bool> muted,
    // E2EE: per-user encrypted last message previews
    @Default({}) Map<String, String> lastMessageEncryptedPreviews,
    // Timestamps
    @TimestampConverter() required DateTime createdAt,
    @NullableTimestampConverter() DateTime? updatedAt,
  }) = _CommunityModel;

  const CommunityModel._();

  factory CommunityModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityModelFromJson(json);

  /// Create from Firestore document
  factory CommunityModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    final sanitized = sanitizeFirestoreData(data);

    // Flatten nested lastMessage into top-level fields
    final lastMessage = sanitized['lastMessage'];
    if (lastMessage is Map<String, dynamic>) {
      sanitized['lastMessageText'] = lastMessage['text'] as String?;
      sanitized['lastMessageSenderId'] = lastMessage['senderId'] as String?;
      sanitized['lastMessageSenderName'] = lastMessage['senderName'] as String?;
      sanitized['lastMessageType'] = lastMessage['type'] as String?;
      // After sanitizeFirestoreData, Timestamps are ISO strings, not
      // Timestamp objects. Accept both formats so the @NullableTimestamp-
      // Converter can parse the value in fromJson.
      final ts = lastMessage['timestamp'];
      if (ts != null) {
        sanitized['lastMessageAt'] = ts;
      }
      sanitized.remove('lastMessage');
    }

    // Rename 'stokvel' to 'stokvelSettings' for model compatibility
    if (sanitized.containsKey('stokvel') &&
        !sanitized.containsKey('stokvelSettings')) {
      sanitized['stokvelSettings'] = sanitized.remove('stokvel');
    }

    // Cast unreadCounts map values to int
    final unreadRaw = sanitized['unreadCounts'];
    if (unreadRaw is Map) {
      sanitized['unreadCounts'] = Map<String, int>.from(
        unreadRaw.map(
            (k, v) => MapEntry(k.toString(), (v as num?)?.toInt() ?? 0)),
      );
    }

    // Cast muted map values to bool
    final mutedRaw = sanitized['muted'];
    if (mutedRaw is Map) {
      sanitized['muted'] = Map<String, bool>.from(
        mutedRaw.map((k, v) => MapEntry(k.toString(), v == true)),
      );
    }

    // Cast lastMessageEncryptedPreviews map values to String
    final encPreviews = sanitized['lastMessageEncryptedPreviews'];
    if (encPreviews is Map) {
      sanitized['lastMessageEncryptedPreviews'] = Map<String, String>.from(
        encPreviews.map((k, v) => MapEntry(k.toString(), v?.toString() ?? '')),
      );
    }

    return CommunityModel.fromJson({
      ...sanitized,
      'id': doc.id,
    });
  }

  /// Convert to domain entity
  Community toEntity() => Community(
        id: id,
        type: CommunityType.values.firstWhere(
          (e) => e.name == type,
          orElse: () {
            debugPrint('WARNING: Unknown community type "$type", defaulting to regular');
            return CommunityType.regular;
          },
        ),
        name: name,
        description: description,
        avatarUrl: avatarUrl,
        ownerId: ownerId,
        memberIds: memberIds,
        adminIds: adminIds,
        memberCount: memberCount,
        totalBalance: totalBalance,
        status: CommunityStatus.values.firstWhere(
          (e) => e.name == status,
          orElse: () {
            debugPrint('WARNING: Unknown community status "$status", defaulting to active');
            return CommunityStatus.active;
          },
        ),
        settings: settings.toEntity(),
        stokvelSettings: stokvelSettings?.toEntity(),
        lastMessageText: lastMessageText,
        lastMessageSenderId: lastMessageSenderId,
        lastMessageSenderName: lastMessageSenderName,
        lastMessageType: lastMessageType,
        lastMessageAt: lastMessageAt,
        unreadCounts: unreadCounts,
        muted: muted,
        lastMessageEncryptedPreviews: lastMessageEncryptedPreviews,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Create from domain entity
  factory CommunityModel.fromEntity(Community entity) => CommunityModel(
        id: entity.id,
        type: entity.type.name,
        name: entity.name,
        description: entity.description,
        avatarUrl: entity.avatarUrl,
        ownerId: entity.ownerId,
        memberIds: entity.memberIds,
        adminIds: entity.adminIds,
        memberCount: entity.memberCount,
        totalBalance: entity.totalBalance,
        status: entity.status.name,
        settings: CommunitySettingsModel.fromEntity(entity.settings),
        stokvelSettings: entity.stokvelSettings != null
            ? StokvelSettingsModel.fromEntity(entity.stokvelSettings!)
            : null,
        lastMessageText: entity.lastMessageText,
        lastMessageSenderId: entity.lastMessageSenderId,
        lastMessageSenderName: entity.lastMessageSenderName,
        lastMessageType: entity.lastMessageType,
        lastMessageAt: entity.lastMessageAt,
        unreadCounts: entity.unreadCounts,
        muted: entity.muted,
        lastMessageEncryptedPreviews: entity.lastMessageEncryptedPreviews,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}
