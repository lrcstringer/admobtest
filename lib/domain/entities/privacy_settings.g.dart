// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrivacySettingsImpl _$$PrivacySettingsImplFromJson(
  Map<String, dynamic> json,
) => _$PrivacySettingsImpl(
  discoverability:
      $enumDecodeNullable(_$DiscoverabilityEnumMap, json['discoverability']) ??
      Discoverability.everyone,
  phoneNumberVisibility:
      $enumDecodeNullable(
        _$PhoneNumberVisibilityEnumMap,
        json['phoneNumberVisibility'],
      ) ??
      PhoneNumberVisibility.contactsOnly,
  profilePhotoVisibility:
      $enumDecodeNullable(
        _$ProfilePhotoVisibilityEnumMap,
        json['profilePhotoVisibility'],
      ) ??
      ProfilePhotoVisibility.everyone,
  lastSeenVisibility:
      $enumDecodeNullable(
        _$LastSeenVisibilityEnumMap,
        json['lastSeenVisibility'],
      ) ??
      LastSeenVisibility.everyone,
  readReceipts: json['readReceipts'] as bool? ?? true,
  groupAddPermission:
      $enumDecodeNullable(
        _$GroupAddPermissionEnumMap,
        json['groupAddPermission'],
      ) ??
      GroupAddPermission.everyone,
  brandMessaging:
      $enumDecodeNullable(_$BrandMessagingEnumMap, json['brandMessaging']) ??
      BrandMessaging.allowAll,
);

Map<String, dynamic> _$$PrivacySettingsImplToJson(
  _$PrivacySettingsImpl instance,
) => <String, dynamic>{
  'discoverability': _$DiscoverabilityEnumMap[instance.discoverability]!,
  'phoneNumberVisibility':
      _$PhoneNumberVisibilityEnumMap[instance.phoneNumberVisibility]!,
  'profilePhotoVisibility':
      _$ProfilePhotoVisibilityEnumMap[instance.profilePhotoVisibility]!,
  'lastSeenVisibility':
      _$LastSeenVisibilityEnumMap[instance.lastSeenVisibility]!,
  'readReceipts': instance.readReceipts,
  'groupAddPermission':
      _$GroupAddPermissionEnumMap[instance.groupAddPermission]!,
  'brandMessaging': _$BrandMessagingEnumMap[instance.brandMessaging]!,
};

const _$DiscoverabilityEnumMap = {
  Discoverability.everyone: 'everyone',
  Discoverability.contactsOnly: 'contactsOnly',
  Discoverability.nobody: 'nobody',
};

const _$PhoneNumberVisibilityEnumMap = {
  PhoneNumberVisibility.contactsOnly: 'contactsOnly',
  PhoneNumberVisibility.nobody: 'nobody',
};

const _$ProfilePhotoVisibilityEnumMap = {
  ProfilePhotoVisibility.everyone: 'everyone',
  ProfilePhotoVisibility.contactsOnly: 'contactsOnly',
};

const _$LastSeenVisibilityEnumMap = {
  LastSeenVisibility.everyone: 'everyone',
  LastSeenVisibility.contactsOnly: 'contactsOnly',
  LastSeenVisibility.nobody: 'nobody',
};

const _$GroupAddPermissionEnumMap = {
  GroupAddPermission.everyone: 'everyone',
  GroupAddPermission.contactsOnly: 'contactsOnly',
};

const _$BrandMessagingEnumMap = {
  BrandMessaging.allowAll: 'allowAll',
  BrandMessaging.optedInOnly: 'optedInOnly',
  BrandMessaging.none: 'none',
};
