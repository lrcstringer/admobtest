import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/gooi_member.dart';
import '../../domain/enums/gooi_member_role.dart';
import '../../domain/enums/gooi_member_status.dart';

part 'gooi_member_model.freezed.dart';

@freezed
abstract class GooiMemberModel with _$GooiMemberModel {
  const factory GooiMemberModel({
    required String id,
    required String userId,
    required String displayName,
    String? avatarUrl,
    @Default(0) int position,
    required GooiMemberRole role,
    required GooiMemberStatus status,
    @Default(0) int contributedCycles,
    @Default(0) int missedCycles,
    @Default(0) int outstandingDebt,
    @Default(false) bool autoContribute,
    String? autoContributeSubAccountId,
    String? preferredSubAccountId,
    String? delegateTriggerTo,
    DateTime? delegationExpiresAt,
    DateTime? joinedAt,
    required DateTime invitedAt,
    DateTime? removedAt,
  }) = _GooiMemberModel;

  const GooiMemberModel._();

  factory GooiMemberModel.fromJson(Map<String, dynamic> json) {
    return GooiMemberModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      displayName: json['displayName'] as String? ?? 'Unknown',
      avatarUrl: json['avatarUrl'] as String?,
      position: (json['position'] as num?)?.toInt() ?? 0,
      role: GooiMemberRoleX.fromString(json['role'] as String? ?? 'MEMBER'),
      status: GooiMemberStatusX.fromString(json['status'] as String? ?? 'INVITED'),
      contributedCycles: (json['contributedCycles'] as num?)?.toInt() ?? 0,
      missedCycles: (json['missedCycles'] as num?)?.toInt() ?? 0,
      outstandingDebt: (json['outstandingDebt'] as num?)?.toInt() ?? 0,
      autoContribute: json['autoContribute'] as bool? ?? false,
      autoContributeSubAccountId: json['autoContributeSubAccountId'] as String?,
      preferredSubAccountId: json['preferredSubAccountId'] as String?,
      delegateTriggerTo: json['delegateTriggerTo'] as String?,
      delegationExpiresAt: _parseDateTime(json['delegationExpiresAt']),
      joinedAt: _parseDateTime(json['joinedAt']),
      invitedAt: _parseDateTime(json['invitedAt']) ?? DateTime.now(),
      removedAt: _parseDateTime(json['removedAt']),
    );
  }

  factory GooiMemberModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GooiMemberModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'displayName': displayName,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'position': position,
      'role': role.name.toUpperCase(),
      'status': status.name.toUpperCase(),
      'contributedCycles': contributedCycles,
      'missedCycles': missedCycles,
      'outstandingDebt': outstandingDebt,
      'autoContribute': autoContribute,
      if (autoContributeSubAccountId != null) 'autoContributeSubAccountId': autoContributeSubAccountId,
      if (preferredSubAccountId != null) 'preferredSubAccountId': preferredSubAccountId,
      if (delegateTriggerTo != null) 'delegateTriggerTo': delegateTriggerTo,
      if (delegationExpiresAt != null) 'delegationExpiresAt': delegationExpiresAt!.toIso8601String(),
      if (joinedAt != null) 'joinedAt': joinedAt!.toIso8601String(),
      'invitedAt': invitedAt.toIso8601String(),
      if (removedAt != null) 'removedAt': removedAt!.toIso8601String(),
    };
  }

  GooiMember toEntity() {
    return GooiMember(
      id: id,
      userId: userId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      position: position,
      role: role,
      status: status,
      contributedCycles: contributedCycles,
      missedCycles: missedCycles,
      outstandingDebt: outstandingDebt,
      autoContribute: autoContribute,
      autoContributeSubAccountId: autoContributeSubAccountId,
      preferredSubAccountId: preferredSubAccountId,
      delegateTriggerTo: delegateTriggerTo,
      delegationExpiresAt: delegationExpiresAt,
      joinedAt: joinedAt,
      invitedAt: invitedAt,
      removedAt: removedAt,
    );
  }
}

DateTime? _parseDateTime(dynamic value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  if (value is Map) {
    final seconds = value['_seconds'] as int?;
    if (seconds != null) return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
  return null;
}
