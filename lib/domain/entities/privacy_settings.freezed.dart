// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'privacy_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PrivacySettings _$PrivacySettingsFromJson(Map<String, dynamic> json) {
  return _PrivacySettings.fromJson(json);
}

/// @nodoc
mixin _$PrivacySettings {
  /// Who can find this user via search
  Discoverability get discoverability => throw _privateConstructorUsedError;

  /// Who can see this user's phone number
  PhoneNumberVisibility get phoneNumberVisibility =>
      throw _privateConstructorUsedError;

  /// Who can see this user's profile photo
  ProfilePhotoVisibility get profilePhotoVisibility =>
      throw _privateConstructorUsedError;

  /// Who can see this user's last seen / online status
  LastSeenVisibility get lastSeenVisibility =>
      throw _privateConstructorUsedError;

  /// Whether read receipts are enabled
  bool get readReceipts => throw _privateConstructorUsedError;

  /// Who can add this user to groups/communities
  GroupAddPermission get groupAddPermission =>
      throw _privateConstructorUsedError;

  /// Whether brands can message this user
  BrandMessaging get brandMessaging => throw _privateConstructorUsedError;

  /// Serializes this PrivacySettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrivacySettingsCopyWith<PrivacySettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrivacySettingsCopyWith<$Res> {
  factory $PrivacySettingsCopyWith(
    PrivacySettings value,
    $Res Function(PrivacySettings) then,
  ) = _$PrivacySettingsCopyWithImpl<$Res, PrivacySettings>;
  @useResult
  $Res call({
    Discoverability discoverability,
    PhoneNumberVisibility phoneNumberVisibility,
    ProfilePhotoVisibility profilePhotoVisibility,
    LastSeenVisibility lastSeenVisibility,
    bool readReceipts,
    GroupAddPermission groupAddPermission,
    BrandMessaging brandMessaging,
  });
}

/// @nodoc
class _$PrivacySettingsCopyWithImpl<$Res, $Val extends PrivacySettings>
    implements $PrivacySettingsCopyWith<$Res> {
  _$PrivacySettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discoverability = null,
    Object? phoneNumberVisibility = null,
    Object? profilePhotoVisibility = null,
    Object? lastSeenVisibility = null,
    Object? readReceipts = null,
    Object? groupAddPermission = null,
    Object? brandMessaging = null,
  }) {
    return _then(
      _value.copyWith(
            discoverability: null == discoverability
                ? _value.discoverability
                : discoverability // ignore: cast_nullable_to_non_nullable
                      as Discoverability,
            phoneNumberVisibility: null == phoneNumberVisibility
                ? _value.phoneNumberVisibility
                : phoneNumberVisibility // ignore: cast_nullable_to_non_nullable
                      as PhoneNumberVisibility,
            profilePhotoVisibility: null == profilePhotoVisibility
                ? _value.profilePhotoVisibility
                : profilePhotoVisibility // ignore: cast_nullable_to_non_nullable
                      as ProfilePhotoVisibility,
            lastSeenVisibility: null == lastSeenVisibility
                ? _value.lastSeenVisibility
                : lastSeenVisibility // ignore: cast_nullable_to_non_nullable
                      as LastSeenVisibility,
            readReceipts: null == readReceipts
                ? _value.readReceipts
                : readReceipts // ignore: cast_nullable_to_non_nullable
                      as bool,
            groupAddPermission: null == groupAddPermission
                ? _value.groupAddPermission
                : groupAddPermission // ignore: cast_nullable_to_non_nullable
                      as GroupAddPermission,
            brandMessaging: null == brandMessaging
                ? _value.brandMessaging
                : brandMessaging // ignore: cast_nullable_to_non_nullable
                      as BrandMessaging,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PrivacySettingsImplCopyWith<$Res>
    implements $PrivacySettingsCopyWith<$Res> {
  factory _$$PrivacySettingsImplCopyWith(
    _$PrivacySettingsImpl value,
    $Res Function(_$PrivacySettingsImpl) then,
  ) = __$$PrivacySettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Discoverability discoverability,
    PhoneNumberVisibility phoneNumberVisibility,
    ProfilePhotoVisibility profilePhotoVisibility,
    LastSeenVisibility lastSeenVisibility,
    bool readReceipts,
    GroupAddPermission groupAddPermission,
    BrandMessaging brandMessaging,
  });
}

/// @nodoc
class __$$PrivacySettingsImplCopyWithImpl<$Res>
    extends _$PrivacySettingsCopyWithImpl<$Res, _$PrivacySettingsImpl>
    implements _$$PrivacySettingsImplCopyWith<$Res> {
  __$$PrivacySettingsImplCopyWithImpl(
    _$PrivacySettingsImpl _value,
    $Res Function(_$PrivacySettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discoverability = null,
    Object? phoneNumberVisibility = null,
    Object? profilePhotoVisibility = null,
    Object? lastSeenVisibility = null,
    Object? readReceipts = null,
    Object? groupAddPermission = null,
    Object? brandMessaging = null,
  }) {
    return _then(
      _$PrivacySettingsImpl(
        discoverability: null == discoverability
            ? _value.discoverability
            : discoverability // ignore: cast_nullable_to_non_nullable
                  as Discoverability,
        phoneNumberVisibility: null == phoneNumberVisibility
            ? _value.phoneNumberVisibility
            : phoneNumberVisibility // ignore: cast_nullable_to_non_nullable
                  as PhoneNumberVisibility,
        profilePhotoVisibility: null == profilePhotoVisibility
            ? _value.profilePhotoVisibility
            : profilePhotoVisibility // ignore: cast_nullable_to_non_nullable
                  as ProfilePhotoVisibility,
        lastSeenVisibility: null == lastSeenVisibility
            ? _value.lastSeenVisibility
            : lastSeenVisibility // ignore: cast_nullable_to_non_nullable
                  as LastSeenVisibility,
        readReceipts: null == readReceipts
            ? _value.readReceipts
            : readReceipts // ignore: cast_nullable_to_non_nullable
                  as bool,
        groupAddPermission: null == groupAddPermission
            ? _value.groupAddPermission
            : groupAddPermission // ignore: cast_nullable_to_non_nullable
                  as GroupAddPermission,
        brandMessaging: null == brandMessaging
            ? _value.brandMessaging
            : brandMessaging // ignore: cast_nullable_to_non_nullable
                  as BrandMessaging,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrivacySettingsImpl implements _PrivacySettings {
  const _$PrivacySettingsImpl({
    this.discoverability = Discoverability.everyone,
    this.phoneNumberVisibility = PhoneNumberVisibility.contactsOnly,
    this.profilePhotoVisibility = ProfilePhotoVisibility.everyone,
    this.lastSeenVisibility = LastSeenVisibility.everyone,
    this.readReceipts = true,
    this.groupAddPermission = GroupAddPermission.everyone,
    this.brandMessaging = BrandMessaging.allowAll,
  });

  factory _$PrivacySettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrivacySettingsImplFromJson(json);

  /// Who can find this user via search
  @override
  @JsonKey()
  final Discoverability discoverability;

  /// Who can see this user's phone number
  @override
  @JsonKey()
  final PhoneNumberVisibility phoneNumberVisibility;

  /// Who can see this user's profile photo
  @override
  @JsonKey()
  final ProfilePhotoVisibility profilePhotoVisibility;

  /// Who can see this user's last seen / online status
  @override
  @JsonKey()
  final LastSeenVisibility lastSeenVisibility;

  /// Whether read receipts are enabled
  @override
  @JsonKey()
  final bool readReceipts;

  /// Who can add this user to groups/communities
  @override
  @JsonKey()
  final GroupAddPermission groupAddPermission;

  /// Whether brands can message this user
  @override
  @JsonKey()
  final BrandMessaging brandMessaging;

  @override
  String toString() {
    return 'PrivacySettings(discoverability: $discoverability, phoneNumberVisibility: $phoneNumberVisibility, profilePhotoVisibility: $profilePhotoVisibility, lastSeenVisibility: $lastSeenVisibility, readReceipts: $readReceipts, groupAddPermission: $groupAddPermission, brandMessaging: $brandMessaging)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrivacySettingsImpl &&
            (identical(other.discoverability, discoverability) ||
                other.discoverability == discoverability) &&
            (identical(other.phoneNumberVisibility, phoneNumberVisibility) ||
                other.phoneNumberVisibility == phoneNumberVisibility) &&
            (identical(other.profilePhotoVisibility, profilePhotoVisibility) ||
                other.profilePhotoVisibility == profilePhotoVisibility) &&
            (identical(other.lastSeenVisibility, lastSeenVisibility) ||
                other.lastSeenVisibility == lastSeenVisibility) &&
            (identical(other.readReceipts, readReceipts) ||
                other.readReceipts == readReceipts) &&
            (identical(other.groupAddPermission, groupAddPermission) ||
                other.groupAddPermission == groupAddPermission) &&
            (identical(other.brandMessaging, brandMessaging) ||
                other.brandMessaging == brandMessaging));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    discoverability,
    phoneNumberVisibility,
    profilePhotoVisibility,
    lastSeenVisibility,
    readReceipts,
    groupAddPermission,
    brandMessaging,
  );

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrivacySettingsImplCopyWith<_$PrivacySettingsImpl> get copyWith =>
      __$$PrivacySettingsImplCopyWithImpl<_$PrivacySettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PrivacySettingsImplToJson(this);
  }
}

abstract class _PrivacySettings implements PrivacySettings {
  const factory _PrivacySettings({
    final Discoverability discoverability,
    final PhoneNumberVisibility phoneNumberVisibility,
    final ProfilePhotoVisibility profilePhotoVisibility,
    final LastSeenVisibility lastSeenVisibility,
    final bool readReceipts,
    final GroupAddPermission groupAddPermission,
    final BrandMessaging brandMessaging,
  }) = _$PrivacySettingsImpl;

  factory _PrivacySettings.fromJson(Map<String, dynamic> json) =
      _$PrivacySettingsImpl.fromJson;

  /// Who can find this user via search
  @override
  Discoverability get discoverability;

  /// Who can see this user's phone number
  @override
  PhoneNumberVisibility get phoneNumberVisibility;

  /// Who can see this user's profile photo
  @override
  ProfilePhotoVisibility get profilePhotoVisibility;

  /// Who can see this user's last seen / online status
  @override
  LastSeenVisibility get lastSeenVisibility;

  /// Whether read receipts are enabled
  @override
  bool get readReceipts;

  /// Who can add this user to groups/communities
  @override
  GroupAddPermission get groupAddPermission;

  /// Whether brands can message this user
  @override
  BrandMessaging get brandMessaging;

  /// Create a copy of PrivacySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrivacySettingsImplCopyWith<_$PrivacySettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
