import 'package:freezed_annotation/freezed_annotation.dart';

/// Role of a community member (same 5-tier hierarchy as groups)
enum MemberRole {
  @JsonValue('owner')
  owner,
  @JsonValue('admin')
  admin,
  @JsonValue('treasurer')
  treasurer,
  @JsonValue('member')
  member,
  @JsonValue('viewer')
  viewer,
}

extension MemberRoleX on MemberRole {
  bool get isOwner => this == MemberRole.owner;
  bool get isAdmin => this == MemberRole.owner || this == MemberRole.admin;
  bool get canManageMembers =>
      this == MemberRole.owner || this == MemberRole.admin;
  bool get canApproveFunds =>
      this == MemberRole.owner ||
      this == MemberRole.admin ||
      this == MemberRole.treasurer;
  bool get canTransferFunds => this != MemberRole.viewer;

  String get displayName {
    switch (this) {
      case MemberRole.owner:
        return 'Owner';
      case MemberRole.admin:
        return 'Admin';
      case MemberRole.treasurer:
        return 'Treasurer';
      case MemberRole.member:
        return 'Member';
      case MemberRole.viewer:
        return 'Viewer';
    }
  }
}
