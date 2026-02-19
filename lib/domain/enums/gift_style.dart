/// Visual style for iMali gift messages.
enum GiftStyle {
  ndlovukazi,
  celebration,
  love,
  birthday,
  professional;

  String get displayName {
    switch (this) {
      case GiftStyle.ndlovukazi:
        return 'Ndlovukazi';
      case GiftStyle.celebration:
        return 'Celebration';
      case GiftStyle.love:
        return 'Love';
      case GiftStyle.birthday:
        return 'Birthday';
      case GiftStyle.professional:
        return 'Professional';
    }
  }
}
