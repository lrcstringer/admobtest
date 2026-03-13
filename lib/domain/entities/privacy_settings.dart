import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/privacy_enums.dart';

part 'privacy_settings.freezed.dart';
part 'privacy_settings.g.dart';

/// Per-user privacy configuration
@freezed
abstract class PrivacySettings with _$PrivacySettings {
  const factory PrivacySettings({
    /// Who can find this user via search
    @Default(Discoverability.everyone) Discoverability discoverability,

    /// Who can see this user's phone number
    @Default(PhoneNumberVisibility.contactsOnly)
    PhoneNumberVisibility phoneNumberVisibility,

    /// Who can see this user's profile photo
    @Default(ProfilePhotoVisibility.everyone)
    ProfilePhotoVisibility profilePhotoVisibility,

    /// Who can see this user's last seen / online status
    @Default(LastSeenVisibility.everyone) LastSeenVisibility lastSeenVisibility,

    /// Whether read receipts are enabled
    @Default(true) bool readReceipts,

    /// Who can add this user to groups/communities
    @Default(GroupAddPermission.everyone)
    GroupAddPermission groupAddPermission,

    /// Whether brands can message this user
    @Default(BrandMessaging.allowAll) BrandMessaging brandMessaging,
  }) = _PrivacySettings;

  factory PrivacySettings.fromJson(Map<String, dynamic> json) =>
      _$PrivacySettingsFromJson(json);
}
