// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trusted_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrustedDevice _$TrustedDeviceFromJson(Map<String, dynamic> json) {
  return _TrustedDevice.fromJson(json);
}

/// @nodoc
mixin _$TrustedDevice {
  String get deviceId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get publicKeyPem => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;
  bool get trusted => throw _privateConstructorUsedError;
  bool get revoked => throw _privateConstructorUsedError;
  DateTime get registeredAt => throw _privateConstructorUsedError;
  DateTime? get lastUsedAt => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;
  String? get deviceModel => throw _privateConstructorUsedError;
  String? get osVersion => throw _privateConstructorUsedError;
  String? get appVersion => throw _privateConstructorUsedError;
  String? get manufacturer => throw _privateConstructorUsedError;
  bool? get hardwareBacked => throw _privateConstructorUsedError;
  bool? get strongBox => throw _privateConstructorUsedError;

  /// Serializes this TrustedDevice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrustedDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrustedDeviceCopyWith<TrustedDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrustedDeviceCopyWith<$Res> {
  factory $TrustedDeviceCopyWith(
    TrustedDevice value,
    $Res Function(TrustedDevice) then,
  ) = _$TrustedDeviceCopyWithImpl<$Res, TrustedDevice>;
  @useResult
  $Res call({
    String deviceId,
    String userId,
    String publicKeyPem,
    String platform,
    bool trusted,
    bool revoked,
    DateTime registeredAt,
    DateTime? lastUsedAt,
    String? fcmToken,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    String? manufacturer,
    bool? hardwareBacked,
    bool? strongBox,
  });
}

/// @nodoc
class _$TrustedDeviceCopyWithImpl<$Res, $Val extends TrustedDevice>
    implements $TrustedDeviceCopyWith<$Res> {
  _$TrustedDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrustedDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = null,
    Object? userId = null,
    Object? publicKeyPem = null,
    Object? platform = null,
    Object? trusted = null,
    Object? revoked = null,
    Object? registeredAt = null,
    Object? lastUsedAt = freezed,
    Object? fcmToken = freezed,
    Object? deviceModel = freezed,
    Object? osVersion = freezed,
    Object? appVersion = freezed,
    Object? manufacturer = freezed,
    Object? hardwareBacked = freezed,
    Object? strongBox = freezed,
  }) {
    return _then(
      _value.copyWith(
            deviceId: null == deviceId
                ? _value.deviceId
                : deviceId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            publicKeyPem: null == publicKeyPem
                ? _value.publicKeyPem
                : publicKeyPem // ignore: cast_nullable_to_non_nullable
                      as String,
            platform: null == platform
                ? _value.platform
                : platform // ignore: cast_nullable_to_non_nullable
                      as String,
            trusted: null == trusted
                ? _value.trusted
                : trusted // ignore: cast_nullable_to_non_nullable
                      as bool,
            revoked: null == revoked
                ? _value.revoked
                : revoked // ignore: cast_nullable_to_non_nullable
                      as bool,
            registeredAt: null == registeredAt
                ? _value.registeredAt
                : registeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastUsedAt: freezed == lastUsedAt
                ? _value.lastUsedAt
                : lastUsedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            fcmToken: freezed == fcmToken
                ? _value.fcmToken
                : fcmToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            deviceModel: freezed == deviceModel
                ? _value.deviceModel
                : deviceModel // ignore: cast_nullable_to_non_nullable
                      as String?,
            osVersion: freezed == osVersion
                ? _value.osVersion
                : osVersion // ignore: cast_nullable_to_non_nullable
                      as String?,
            appVersion: freezed == appVersion
                ? _value.appVersion
                : appVersion // ignore: cast_nullable_to_non_nullable
                      as String?,
            manufacturer: freezed == manufacturer
                ? _value.manufacturer
                : manufacturer // ignore: cast_nullable_to_non_nullable
                      as String?,
            hardwareBacked: freezed == hardwareBacked
                ? _value.hardwareBacked
                : hardwareBacked // ignore: cast_nullable_to_non_nullable
                      as bool?,
            strongBox: freezed == strongBox
                ? _value.strongBox
                : strongBox // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrustedDeviceImplCopyWith<$Res>
    implements $TrustedDeviceCopyWith<$Res> {
  factory _$$TrustedDeviceImplCopyWith(
    _$TrustedDeviceImpl value,
    $Res Function(_$TrustedDeviceImpl) then,
  ) = __$$TrustedDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String deviceId,
    String userId,
    String publicKeyPem,
    String platform,
    bool trusted,
    bool revoked,
    DateTime registeredAt,
    DateTime? lastUsedAt,
    String? fcmToken,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    String? manufacturer,
    bool? hardwareBacked,
    bool? strongBox,
  });
}

/// @nodoc
class __$$TrustedDeviceImplCopyWithImpl<$Res>
    extends _$TrustedDeviceCopyWithImpl<$Res, _$TrustedDeviceImpl>
    implements _$$TrustedDeviceImplCopyWith<$Res> {
  __$$TrustedDeviceImplCopyWithImpl(
    _$TrustedDeviceImpl _value,
    $Res Function(_$TrustedDeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrustedDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = null,
    Object? userId = null,
    Object? publicKeyPem = null,
    Object? platform = null,
    Object? trusted = null,
    Object? revoked = null,
    Object? registeredAt = null,
    Object? lastUsedAt = freezed,
    Object? fcmToken = freezed,
    Object? deviceModel = freezed,
    Object? osVersion = freezed,
    Object? appVersion = freezed,
    Object? manufacturer = freezed,
    Object? hardwareBacked = freezed,
    Object? strongBox = freezed,
  }) {
    return _then(
      _$TrustedDeviceImpl(
        deviceId: null == deviceId
            ? _value.deviceId
            : deviceId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        publicKeyPem: null == publicKeyPem
            ? _value.publicKeyPem
            : publicKeyPem // ignore: cast_nullable_to_non_nullable
                  as String,
        platform: null == platform
            ? _value.platform
            : platform // ignore: cast_nullable_to_non_nullable
                  as String,
        trusted: null == trusted
            ? _value.trusted
            : trusted // ignore: cast_nullable_to_non_nullable
                  as bool,
        revoked: null == revoked
            ? _value.revoked
            : revoked // ignore: cast_nullable_to_non_nullable
                  as bool,
        registeredAt: null == registeredAt
            ? _value.registeredAt
            : registeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastUsedAt: freezed == lastUsedAt
            ? _value.lastUsedAt
            : lastUsedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        fcmToken: freezed == fcmToken
            ? _value.fcmToken
            : fcmToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        deviceModel: freezed == deviceModel
            ? _value.deviceModel
            : deviceModel // ignore: cast_nullable_to_non_nullable
                  as String?,
        osVersion: freezed == osVersion
            ? _value.osVersion
            : osVersion // ignore: cast_nullable_to_non_nullable
                  as String?,
        appVersion: freezed == appVersion
            ? _value.appVersion
            : appVersion // ignore: cast_nullable_to_non_nullable
                  as String?,
        manufacturer: freezed == manufacturer
            ? _value.manufacturer
            : manufacturer // ignore: cast_nullable_to_non_nullable
                  as String?,
        hardwareBacked: freezed == hardwareBacked
            ? _value.hardwareBacked
            : hardwareBacked // ignore: cast_nullable_to_non_nullable
                  as bool?,
        strongBox: freezed == strongBox
            ? _value.strongBox
            : strongBox // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrustedDeviceImpl extends _TrustedDevice {
  const _$TrustedDeviceImpl({
    required this.deviceId,
    required this.userId,
    required this.publicKeyPem,
    required this.platform,
    required this.trusted,
    required this.revoked,
    required this.registeredAt,
    this.lastUsedAt,
    this.fcmToken,
    this.deviceModel,
    this.osVersion,
    this.appVersion,
    this.manufacturer,
    this.hardwareBacked,
    this.strongBox,
  }) : super._();

  factory _$TrustedDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrustedDeviceImplFromJson(json);

  @override
  final String deviceId;
  @override
  final String userId;
  @override
  final String publicKeyPem;
  @override
  final String platform;
  @override
  final bool trusted;
  @override
  final bool revoked;
  @override
  final DateTime registeredAt;
  @override
  final DateTime? lastUsedAt;
  @override
  final String? fcmToken;
  @override
  final String? deviceModel;
  @override
  final String? osVersion;
  @override
  final String? appVersion;
  @override
  final String? manufacturer;
  @override
  final bool? hardwareBacked;
  @override
  final bool? strongBox;

  @override
  String toString() {
    return 'TrustedDevice(deviceId: $deviceId, userId: $userId, publicKeyPem: $publicKeyPem, platform: $platform, trusted: $trusted, revoked: $revoked, registeredAt: $registeredAt, lastUsedAt: $lastUsedAt, fcmToken: $fcmToken, deviceModel: $deviceModel, osVersion: $osVersion, appVersion: $appVersion, manufacturer: $manufacturer, hardwareBacked: $hardwareBacked, strongBox: $strongBox)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrustedDeviceImpl &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.publicKeyPem, publicKeyPem) ||
                other.publicKeyPem == publicKeyPem) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.trusted, trusted) || other.trusted == trusted) &&
            (identical(other.revoked, revoked) || other.revoked == revoked) &&
            (identical(other.registeredAt, registeredAt) ||
                other.registeredAt == registeredAt) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.deviceModel, deviceModel) ||
                other.deviceModel == deviceModel) &&
            (identical(other.osVersion, osVersion) ||
                other.osVersion == osVersion) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.hardwareBacked, hardwareBacked) ||
                other.hardwareBacked == hardwareBacked) &&
            (identical(other.strongBox, strongBox) ||
                other.strongBox == strongBox));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    deviceId,
    userId,
    publicKeyPem,
    platform,
    trusted,
    revoked,
    registeredAt,
    lastUsedAt,
    fcmToken,
    deviceModel,
    osVersion,
    appVersion,
    manufacturer,
    hardwareBacked,
    strongBox,
  );

  /// Create a copy of TrustedDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrustedDeviceImplCopyWith<_$TrustedDeviceImpl> get copyWith =>
      __$$TrustedDeviceImplCopyWithImpl<_$TrustedDeviceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrustedDeviceImplToJson(this);
  }
}

abstract class _TrustedDevice extends TrustedDevice {
  const factory _TrustedDevice({
    required final String deviceId,
    required final String userId,
    required final String publicKeyPem,
    required final String platform,
    required final bool trusted,
    required final bool revoked,
    required final DateTime registeredAt,
    final DateTime? lastUsedAt,
    final String? fcmToken,
    final String? deviceModel,
    final String? osVersion,
    final String? appVersion,
    final String? manufacturer,
    final bool? hardwareBacked,
    final bool? strongBox,
  }) = _$TrustedDeviceImpl;
  const _TrustedDevice._() : super._();

  factory _TrustedDevice.fromJson(Map<String, dynamic> json) =
      _$TrustedDeviceImpl.fromJson;

  @override
  String get deviceId;
  @override
  String get userId;
  @override
  String get publicKeyPem;
  @override
  String get platform;
  @override
  bool get trusted;
  @override
  bool get revoked;
  @override
  DateTime get registeredAt;
  @override
  DateTime? get lastUsedAt;
  @override
  String? get fcmToken;
  @override
  String? get deviceModel;
  @override
  String? get osVersion;
  @override
  String? get appVersion;
  @override
  String? get manufacturer;
  @override
  bool? get hardwareBacked;
  @override
  bool? get strongBox;

  /// Create a copy of TrustedDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrustedDeviceImplCopyWith<_$TrustedDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
