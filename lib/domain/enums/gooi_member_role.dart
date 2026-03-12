/// Role of a member within a Gooi-Gooi group.
enum GooiMemberRole {
  initiator,
  member,
  triggerDelegate,
}

extension GooiMemberRoleX on GooiMemberRole {
  String get displayName {
    switch (this) {
      case GooiMemberRole.initiator:
        return 'Initiator';
      case GooiMemberRole.member:
        return 'Member';
      case GooiMemberRole.triggerDelegate:
        return 'Trigger Delegate';
    }
  }

  bool get canTriggerPayout =>
      this == GooiMemberRole.initiator ||
      this == GooiMemberRole.triggerDelegate;

  static GooiMemberRole fromString(String value) {
    switch (value.toUpperCase()) {
      case 'INITIATOR':
        return GooiMemberRole.initiator;
      case 'TRIGGER_DELEGATE':
        return GooiMemberRole.triggerDelegate;
      default:
        return GooiMemberRole.member;
    }
  }
}
