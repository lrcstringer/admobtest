import 'dart:convert';

import 'package:drift/drift.dart';

import '../../domain/entities/community.dart';
import '../../domain/entities/group.dart'; // StokvelSettings
import '../../domain/enums/community_status.dart';
import '../../domain/enums/community_type.dart';
import '../datasources/local/app_database.dart';

/// Maps between [Community] domain entities and [LocalCommunities] DB rows.
class LocalCommunityMapper {
  /// Convert a [Community] entity to a [LocalCommunitiesCompanion] for DB upsert.
  static LocalCommunitiesCompanion toCompanion(Community community) {
    return LocalCommunitiesCompanion(
      id: Value(community.id),
      type: Value(community.type.name),
      name: Value(community.name),
      description: Value(community.description),
      avatarUrl: Value(community.avatarUrl),
      ownerId: Value(community.ownerId),
      memberIdsJson: Value(jsonEncode(community.memberIds)),
      adminIdsJson: Value(jsonEncode(community.adminIds)),
      memberCount: Value(community.memberCount),
      totalBalance: Value(community.totalBalance),
      status: Value(community.status.name),
      settingsJson: Value(jsonEncode(community.settings.toJson())),
      stokvelSettingsJson: Value(
        community.stokvelSettings != null
            ? jsonEncode(community.stokvelSettings!.toJson())
            : null,
      ),
      lastMessageText: Value(community.lastMessageText),
      lastMessageSenderId: Value(community.lastMessageSenderId),
      lastMessageSenderName: Value(community.lastMessageSenderName),
      lastMessageType: Value(community.lastMessageType),
      lastMessageAt: Value(community.lastMessageAt),
      unreadCountsJson: Value(jsonEncode(community.unreadCounts)),
      mutedJson: Value(jsonEncode(community.muted)),
      encryptedPreviewsJson:
          Value(jsonEncode(community.lastMessageEncryptedPreviews)),
      createdAt: Value(community.createdAt),
      updatedAt: Value(community.updatedAt),
    );
  }

  /// Convert a [LocalCommunity] DB row to a [Community] domain entity.
  static Community toEntity(LocalCommunity row) {
    return Community(
      id: row.id,
      type: _parseCommunityType(row.type),
      name: row.name,
      description: row.description,
      avatarUrl: row.avatarUrl,
      ownerId: row.ownerId,
      memberIds: _parseStringList(row.memberIdsJson),
      adminIds: _parseStringList(row.adminIdsJson),
      memberCount: row.memberCount,
      totalBalance: row.totalBalance,
      status: _parseCommunityStatus(row.status),
      settings: _parseSettings(row.settingsJson),
      stokvelSettings: _parseStokvelSettings(row.stokvelSettingsJson),
      lastMessageText: row.lastMessageText,
      lastMessageSenderId: row.lastMessageSenderId,
      lastMessageSenderName: row.lastMessageSenderName,
      lastMessageType: row.lastMessageType,
      lastMessageAt: row.lastMessageAt,
      unreadCounts: _parseIntMap(row.unreadCountsJson),
      muted: _parseBoolMap(row.mutedJson),
      lastMessageEncryptedPreviews:
          _parseStringMap(row.encryptedPreviewsJson),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static CommunityType _parseCommunityType(String value) {
    return CommunityType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => CommunityType.regular,
    );
  }

  static CommunityStatus _parseCommunityStatus(String value) {
    return CommunityStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => CommunityStatus.active,
    );
  }

  static List<String> _parseStringList(String json) {
    try {
      return List<String>.from(jsonDecode(json) as List);
    } catch (_) {
      return [];
    }
  }

  static CommunitySettings _parseSettings(String json) {
    try {
      return CommunitySettings.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
    } catch (_) {
      return const CommunitySettings();
    }
  }

  static StokvelSettings? _parseStokvelSettings(String? json) {
    if (json == null) return null;
    try {
      return StokvelSettings.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  static Map<String, int> _parseIntMap(String json) {
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map((k, v) => MapEntry(k, (v as num?)?.toInt() ?? 0));
    } catch (_) {
      return {};
    }
  }

  static Map<String, bool> _parseBoolMap(String json) {
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map((k, v) => MapEntry(k, (v is bool) ? v : false));
    } catch (_) {
      return {};
    }
  }

  static Map<String, String> _parseStringMap(String json) {
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map((k, v) => MapEntry(k, v as String));
    } catch (_) {
      return {};
    }
  }
}
