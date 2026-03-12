import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/gooi_member_role.dart';
import '../enums/gooi_member_status.dart';

part 'gooi_member.freezed.dart';
part 'gooi_member.g.dart';

@freezed
class GooiMember with _$GooiMember {
  const factory GooiMember({
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
    DateTime? delegationExpiresAt,
    DateTime? joinedAt,
    required DateTime invitedAt,
  }) = _GooiMember;

  const GooiMember._();

  factory GooiMember.fromJson(Map<String, dynamic> json) =>
      _$GooiMemberFromJson(json);

  bool get isInitiator => role == GooiMemberRole.initiator;
  bool get isDelegate => role == GooiMemberRole.triggerDelegate;
  bool get hasDebt => outstandingDebt > 0;
}
