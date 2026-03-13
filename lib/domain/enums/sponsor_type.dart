/// Sponsor type for group buys.
enum SponsorType {
  community,
  brand,
  platform;

  static SponsorType fromString(String? value) {
    if (value == null) return SponsorType.community;
    return SponsorType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => SponsorType.community,
    );
  }
}
