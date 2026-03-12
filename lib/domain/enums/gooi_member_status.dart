/// Status of a member within a Gooi-Gooi group.
enum GooiMemberStatus {
  invited,
  accepted,
  active,
  suspended,
  removed,
}

extension GooiMemberStatusX on GooiMemberStatus {
  String get displayName {
    switch (this) {
      case GooiMemberStatus.invited:
        return 'Invited';
      case GooiMemberStatus.accepted:
        return 'Accepted';
      case GooiMemberStatus.active:
        return 'Active';
      case GooiMemberStatus.suspended:
        return 'Suspended';
      case GooiMemberStatus.removed:
        return 'Removed';
    }
  }

  bool get isParticipating =>
      this == GooiMemberStatus.accepted || this == GooiMemberStatus.active;

  static GooiMemberStatus fromString(String value) {
    return GooiMemberStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => GooiMemberStatus.invited,
    );
  }
}
