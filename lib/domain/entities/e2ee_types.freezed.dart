// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'e2ee_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

KeyBundle _$KeyBundleFromJson(Map<String, dynamic> json) {
  return _KeyBundle.fromJson(json);
}

/// @nodoc
mixin _$KeyBundle {
  /// The long-term identity key pair (X25519), base64-encoded as "priv|pub".
  String get identityKeyPair => throw _privateConstructorUsedError;

  /// The signed pre-key (rotated periodically), base64-encoded as "priv|pub".
  String get signedPreKey => throw _privateConstructorUsedError;

  /// Signature over the signed pre-key using the identity key.
  String get signedPreKeySignature => throw _privateConstructorUsedError;

  /// List of one-time pre-keys (consumed on first message), base64-encoded.
  List<String> get oneTimePreKeys => throw _privateConstructorUsedError;

  /// Local registration ID for this device.
  int get registrationId => throw _privateConstructorUsedError;

  /// Ed25519 signing key pair, base64-encoded as "priv|pub".
  /// Used for verifiable signatures on the signed pre-key.
  /// Null for bundles generated before Ed25519 support was added.
  String? get ed25519IdentityKeyPair => throw _privateConstructorUsedError;

  /// Ed25519 signature over the signed pre-key's public key bytes.
  /// Verifiable by any party using the Ed25519 public key.
  String? get ed25519Signature => throw _privateConstructorUsedError;

  /// Serializes this KeyBundle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of KeyBundle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyBundleCopyWith<KeyBundle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyBundleCopyWith<$Res> {
  factory $KeyBundleCopyWith(KeyBundle value, $Res Function(KeyBundle) then) =
      _$KeyBundleCopyWithImpl<$Res, KeyBundle>;
  @useResult
  $Res call({
    String identityKeyPair,
    String signedPreKey,
    String signedPreKeySignature,
    List<String> oneTimePreKeys,
    int registrationId,
    String? ed25519IdentityKeyPair,
    String? ed25519Signature,
  });
}

/// @nodoc
class _$KeyBundleCopyWithImpl<$Res, $Val extends KeyBundle>
    implements $KeyBundleCopyWith<$Res> {
  _$KeyBundleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyBundle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityKeyPair = null,
    Object? signedPreKey = null,
    Object? signedPreKeySignature = null,
    Object? oneTimePreKeys = null,
    Object? registrationId = null,
    Object? ed25519IdentityKeyPair = freezed,
    Object? ed25519Signature = freezed,
  }) {
    return _then(
      _value.copyWith(
            identityKeyPair: null == identityKeyPair
                ? _value.identityKeyPair
                : identityKeyPair // ignore: cast_nullable_to_non_nullable
                      as String,
            signedPreKey: null == signedPreKey
                ? _value.signedPreKey
                : signedPreKey // ignore: cast_nullable_to_non_nullable
                      as String,
            signedPreKeySignature: null == signedPreKeySignature
                ? _value.signedPreKeySignature
                : signedPreKeySignature // ignore: cast_nullable_to_non_nullable
                      as String,
            oneTimePreKeys: null == oneTimePreKeys
                ? _value.oneTimePreKeys
                : oneTimePreKeys // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            registrationId: null == registrationId
                ? _value.registrationId
                : registrationId // ignore: cast_nullable_to_non_nullable
                      as int,
            ed25519IdentityKeyPair: freezed == ed25519IdentityKeyPair
                ? _value.ed25519IdentityKeyPair
                : ed25519IdentityKeyPair // ignore: cast_nullable_to_non_nullable
                      as String?,
            ed25519Signature: freezed == ed25519Signature
                ? _value.ed25519Signature
                : ed25519Signature // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KeyBundleImplCopyWith<$Res>
    implements $KeyBundleCopyWith<$Res> {
  factory _$$KeyBundleImplCopyWith(
    _$KeyBundleImpl value,
    $Res Function(_$KeyBundleImpl) then,
  ) = __$$KeyBundleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String identityKeyPair,
    String signedPreKey,
    String signedPreKeySignature,
    List<String> oneTimePreKeys,
    int registrationId,
    String? ed25519IdentityKeyPair,
    String? ed25519Signature,
  });
}

/// @nodoc
class __$$KeyBundleImplCopyWithImpl<$Res>
    extends _$KeyBundleCopyWithImpl<$Res, _$KeyBundleImpl>
    implements _$$KeyBundleImplCopyWith<$Res> {
  __$$KeyBundleImplCopyWithImpl(
    _$KeyBundleImpl _value,
    $Res Function(_$KeyBundleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KeyBundle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityKeyPair = null,
    Object? signedPreKey = null,
    Object? signedPreKeySignature = null,
    Object? oneTimePreKeys = null,
    Object? registrationId = null,
    Object? ed25519IdentityKeyPair = freezed,
    Object? ed25519Signature = freezed,
  }) {
    return _then(
      _$KeyBundleImpl(
        identityKeyPair: null == identityKeyPair
            ? _value.identityKeyPair
            : identityKeyPair // ignore: cast_nullable_to_non_nullable
                  as String,
        signedPreKey: null == signedPreKey
            ? _value.signedPreKey
            : signedPreKey // ignore: cast_nullable_to_non_nullable
                  as String,
        signedPreKeySignature: null == signedPreKeySignature
            ? _value.signedPreKeySignature
            : signedPreKeySignature // ignore: cast_nullable_to_non_nullable
                  as String,
        oneTimePreKeys: null == oneTimePreKeys
            ? _value._oneTimePreKeys
            : oneTimePreKeys // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        registrationId: null == registrationId
            ? _value.registrationId
            : registrationId // ignore: cast_nullable_to_non_nullable
                  as int,
        ed25519IdentityKeyPair: freezed == ed25519IdentityKeyPair
            ? _value.ed25519IdentityKeyPair
            : ed25519IdentityKeyPair // ignore: cast_nullable_to_non_nullable
                  as String?,
        ed25519Signature: freezed == ed25519Signature
            ? _value.ed25519Signature
            : ed25519Signature // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KeyBundleImpl implements _KeyBundle {
  const _$KeyBundleImpl({
    required this.identityKeyPair,
    required this.signedPreKey,
    required this.signedPreKeySignature,
    required final List<String> oneTimePreKeys,
    required this.registrationId,
    this.ed25519IdentityKeyPair,
    this.ed25519Signature,
  }) : _oneTimePreKeys = oneTimePreKeys;

  factory _$KeyBundleImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyBundleImplFromJson(json);

  /// The long-term identity key pair (X25519), base64-encoded as "priv|pub".
  @override
  final String identityKeyPair;

  /// The signed pre-key (rotated periodically), base64-encoded as "priv|pub".
  @override
  final String signedPreKey;

  /// Signature over the signed pre-key using the identity key.
  @override
  final String signedPreKeySignature;

  /// List of one-time pre-keys (consumed on first message), base64-encoded.
  final List<String> _oneTimePreKeys;

  /// List of one-time pre-keys (consumed on first message), base64-encoded.
  @override
  List<String> get oneTimePreKeys {
    if (_oneTimePreKeys is EqualUnmodifiableListView) return _oneTimePreKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_oneTimePreKeys);
  }

  /// Local registration ID for this device.
  @override
  final int registrationId;

  /// Ed25519 signing key pair, base64-encoded as "priv|pub".
  /// Used for verifiable signatures on the signed pre-key.
  /// Null for bundles generated before Ed25519 support was added.
  @override
  final String? ed25519IdentityKeyPair;

  /// Ed25519 signature over the signed pre-key's public key bytes.
  /// Verifiable by any party using the Ed25519 public key.
  @override
  final String? ed25519Signature;

  @override
  String toString() {
    return 'KeyBundle(identityKeyPair: $identityKeyPair, signedPreKey: $signedPreKey, signedPreKeySignature: $signedPreKeySignature, oneTimePreKeys: $oneTimePreKeys, registrationId: $registrationId, ed25519IdentityKeyPair: $ed25519IdentityKeyPair, ed25519Signature: $ed25519Signature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyBundleImpl &&
            (identical(other.identityKeyPair, identityKeyPair) ||
                other.identityKeyPair == identityKeyPair) &&
            (identical(other.signedPreKey, signedPreKey) ||
                other.signedPreKey == signedPreKey) &&
            (identical(other.signedPreKeySignature, signedPreKeySignature) ||
                other.signedPreKeySignature == signedPreKeySignature) &&
            const DeepCollectionEquality().equals(
              other._oneTimePreKeys,
              _oneTimePreKeys,
            ) &&
            (identical(other.registrationId, registrationId) ||
                other.registrationId == registrationId) &&
            (identical(other.ed25519IdentityKeyPair, ed25519IdentityKeyPair) ||
                other.ed25519IdentityKeyPair == ed25519IdentityKeyPair) &&
            (identical(other.ed25519Signature, ed25519Signature) ||
                other.ed25519Signature == ed25519Signature));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    identityKeyPair,
    signedPreKey,
    signedPreKeySignature,
    const DeepCollectionEquality().hash(_oneTimePreKeys),
    registrationId,
    ed25519IdentityKeyPair,
    ed25519Signature,
  );

  /// Create a copy of KeyBundle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyBundleImplCopyWith<_$KeyBundleImpl> get copyWith =>
      __$$KeyBundleImplCopyWithImpl<_$KeyBundleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyBundleImplToJson(this);
  }
}

abstract class _KeyBundle implements KeyBundle {
  const factory _KeyBundle({
    required final String identityKeyPair,
    required final String signedPreKey,
    required final String signedPreKeySignature,
    required final List<String> oneTimePreKeys,
    required final int registrationId,
    final String? ed25519IdentityKeyPair,
    final String? ed25519Signature,
  }) = _$KeyBundleImpl;

  factory _KeyBundle.fromJson(Map<String, dynamic> json) =
      _$KeyBundleImpl.fromJson;

  /// The long-term identity key pair (X25519), base64-encoded as "priv|pub".
  @override
  String get identityKeyPair;

  /// The signed pre-key (rotated periodically), base64-encoded as "priv|pub".
  @override
  String get signedPreKey;

  /// Signature over the signed pre-key using the identity key.
  @override
  String get signedPreKeySignature;

  /// List of one-time pre-keys (consumed on first message), base64-encoded.
  @override
  List<String> get oneTimePreKeys;

  /// Local registration ID for this device.
  @override
  int get registrationId;

  /// Ed25519 signing key pair, base64-encoded as "priv|pub".
  /// Used for verifiable signatures on the signed pre-key.
  /// Null for bundles generated before Ed25519 support was added.
  @override
  String? get ed25519IdentityKeyPair;

  /// Ed25519 signature over the signed pre-key's public key bytes.
  /// Verifiable by any party using the Ed25519 public key.
  @override
  String? get ed25519Signature;

  /// Create a copy of KeyBundle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyBundleImplCopyWith<_$KeyBundleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PublicKeyBundle _$PublicKeyBundleFromJson(Map<String, dynamic> json) {
  return _PublicKeyBundle.fromJson(json);
}

/// @nodoc
mixin _$PublicKeyBundle {
  /// The recipient's public identity key (X25519), base64-encoded.
  String get identityKey => throw _privateConstructorUsedError;

  /// The recipient's current signed pre-key (X25519), base64-encoded.
  String get signedPreKey => throw _privateConstructorUsedError;

  /// Signature over the signed pre-key, base64-encoded.
  String get signedPreKeySignature => throw _privateConstructorUsedError;

  /// Available one-time pre-keys (server returns one), base64-encoded.
  List<String> get oneTimePreKeys => throw _privateConstructorUsedError;

  /// The recipient's registration ID.
  int get registrationId => throw _privateConstructorUsedError;

  /// The user ID this bundle belongs to.
  String get userId => throw _privateConstructorUsedError;

  /// Ed25519 public identity key for signature verification, base64-encoded.
  /// Null for bundles generated before Ed25519 support.
  String? get ed25519IdentityKey => throw _privateConstructorUsedError;

  /// Ed25519 signature over the signed pre-key public bytes, base64-encoded.
  /// Verifiable using [ed25519IdentityKey].
  String? get ed25519Signature => throw _privateConstructorUsedError;

  /// Serializes this PublicKeyBundle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublicKeyBundle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublicKeyBundleCopyWith<PublicKeyBundle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicKeyBundleCopyWith<$Res> {
  factory $PublicKeyBundleCopyWith(
    PublicKeyBundle value,
    $Res Function(PublicKeyBundle) then,
  ) = _$PublicKeyBundleCopyWithImpl<$Res, PublicKeyBundle>;
  @useResult
  $Res call({
    String identityKey,
    String signedPreKey,
    String signedPreKeySignature,
    List<String> oneTimePreKeys,
    int registrationId,
    String userId,
    String? ed25519IdentityKey,
    String? ed25519Signature,
  });
}

/// @nodoc
class _$PublicKeyBundleCopyWithImpl<$Res, $Val extends PublicKeyBundle>
    implements $PublicKeyBundleCopyWith<$Res> {
  _$PublicKeyBundleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublicKeyBundle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityKey = null,
    Object? signedPreKey = null,
    Object? signedPreKeySignature = null,
    Object? oneTimePreKeys = null,
    Object? registrationId = null,
    Object? userId = null,
    Object? ed25519IdentityKey = freezed,
    Object? ed25519Signature = freezed,
  }) {
    return _then(
      _value.copyWith(
            identityKey: null == identityKey
                ? _value.identityKey
                : identityKey // ignore: cast_nullable_to_non_nullable
                      as String,
            signedPreKey: null == signedPreKey
                ? _value.signedPreKey
                : signedPreKey // ignore: cast_nullable_to_non_nullable
                      as String,
            signedPreKeySignature: null == signedPreKeySignature
                ? _value.signedPreKeySignature
                : signedPreKeySignature // ignore: cast_nullable_to_non_nullable
                      as String,
            oneTimePreKeys: null == oneTimePreKeys
                ? _value.oneTimePreKeys
                : oneTimePreKeys // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            registrationId: null == registrationId
                ? _value.registrationId
                : registrationId // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            ed25519IdentityKey: freezed == ed25519IdentityKey
                ? _value.ed25519IdentityKey
                : ed25519IdentityKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            ed25519Signature: freezed == ed25519Signature
                ? _value.ed25519Signature
                : ed25519Signature // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PublicKeyBundleImplCopyWith<$Res>
    implements $PublicKeyBundleCopyWith<$Res> {
  factory _$$PublicKeyBundleImplCopyWith(
    _$PublicKeyBundleImpl value,
    $Res Function(_$PublicKeyBundleImpl) then,
  ) = __$$PublicKeyBundleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String identityKey,
    String signedPreKey,
    String signedPreKeySignature,
    List<String> oneTimePreKeys,
    int registrationId,
    String userId,
    String? ed25519IdentityKey,
    String? ed25519Signature,
  });
}

/// @nodoc
class __$$PublicKeyBundleImplCopyWithImpl<$Res>
    extends _$PublicKeyBundleCopyWithImpl<$Res, _$PublicKeyBundleImpl>
    implements _$$PublicKeyBundleImplCopyWith<$Res> {
  __$$PublicKeyBundleImplCopyWithImpl(
    _$PublicKeyBundleImpl _value,
    $Res Function(_$PublicKeyBundleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PublicKeyBundle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityKey = null,
    Object? signedPreKey = null,
    Object? signedPreKeySignature = null,
    Object? oneTimePreKeys = null,
    Object? registrationId = null,
    Object? userId = null,
    Object? ed25519IdentityKey = freezed,
    Object? ed25519Signature = freezed,
  }) {
    return _then(
      _$PublicKeyBundleImpl(
        identityKey: null == identityKey
            ? _value.identityKey
            : identityKey // ignore: cast_nullable_to_non_nullable
                  as String,
        signedPreKey: null == signedPreKey
            ? _value.signedPreKey
            : signedPreKey // ignore: cast_nullable_to_non_nullable
                  as String,
        signedPreKeySignature: null == signedPreKeySignature
            ? _value.signedPreKeySignature
            : signedPreKeySignature // ignore: cast_nullable_to_non_nullable
                  as String,
        oneTimePreKeys: null == oneTimePreKeys
            ? _value._oneTimePreKeys
            : oneTimePreKeys // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        registrationId: null == registrationId
            ? _value.registrationId
            : registrationId // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        ed25519IdentityKey: freezed == ed25519IdentityKey
            ? _value.ed25519IdentityKey
            : ed25519IdentityKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        ed25519Signature: freezed == ed25519Signature
            ? _value.ed25519Signature
            : ed25519Signature // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PublicKeyBundleImpl implements _PublicKeyBundle {
  const _$PublicKeyBundleImpl({
    required this.identityKey,
    required this.signedPreKey,
    required this.signedPreKeySignature,
    required final List<String> oneTimePreKeys,
    required this.registrationId,
    required this.userId,
    this.ed25519IdentityKey,
    this.ed25519Signature,
  }) : _oneTimePreKeys = oneTimePreKeys;

  factory _$PublicKeyBundleImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublicKeyBundleImplFromJson(json);

  /// The recipient's public identity key (X25519), base64-encoded.
  @override
  final String identityKey;

  /// The recipient's current signed pre-key (X25519), base64-encoded.
  @override
  final String signedPreKey;

  /// Signature over the signed pre-key, base64-encoded.
  @override
  final String signedPreKeySignature;

  /// Available one-time pre-keys (server returns one), base64-encoded.
  final List<String> _oneTimePreKeys;

  /// Available one-time pre-keys (server returns one), base64-encoded.
  @override
  List<String> get oneTimePreKeys {
    if (_oneTimePreKeys is EqualUnmodifiableListView) return _oneTimePreKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_oneTimePreKeys);
  }

  /// The recipient's registration ID.
  @override
  final int registrationId;

  /// The user ID this bundle belongs to.
  @override
  final String userId;

  /// Ed25519 public identity key for signature verification, base64-encoded.
  /// Null for bundles generated before Ed25519 support.
  @override
  final String? ed25519IdentityKey;

  /// Ed25519 signature over the signed pre-key public bytes, base64-encoded.
  /// Verifiable using [ed25519IdentityKey].
  @override
  final String? ed25519Signature;

  @override
  String toString() {
    return 'PublicKeyBundle(identityKey: $identityKey, signedPreKey: $signedPreKey, signedPreKeySignature: $signedPreKeySignature, oneTimePreKeys: $oneTimePreKeys, registrationId: $registrationId, userId: $userId, ed25519IdentityKey: $ed25519IdentityKey, ed25519Signature: $ed25519Signature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicKeyBundleImpl &&
            (identical(other.identityKey, identityKey) ||
                other.identityKey == identityKey) &&
            (identical(other.signedPreKey, signedPreKey) ||
                other.signedPreKey == signedPreKey) &&
            (identical(other.signedPreKeySignature, signedPreKeySignature) ||
                other.signedPreKeySignature == signedPreKeySignature) &&
            const DeepCollectionEquality().equals(
              other._oneTimePreKeys,
              _oneTimePreKeys,
            ) &&
            (identical(other.registrationId, registrationId) ||
                other.registrationId == registrationId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.ed25519IdentityKey, ed25519IdentityKey) ||
                other.ed25519IdentityKey == ed25519IdentityKey) &&
            (identical(other.ed25519Signature, ed25519Signature) ||
                other.ed25519Signature == ed25519Signature));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    identityKey,
    signedPreKey,
    signedPreKeySignature,
    const DeepCollectionEquality().hash(_oneTimePreKeys),
    registrationId,
    userId,
    ed25519IdentityKey,
    ed25519Signature,
  );

  /// Create a copy of PublicKeyBundle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicKeyBundleImplCopyWith<_$PublicKeyBundleImpl> get copyWith =>
      __$$PublicKeyBundleImplCopyWithImpl<_$PublicKeyBundleImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PublicKeyBundleImplToJson(this);
  }
}

abstract class _PublicKeyBundle implements PublicKeyBundle {
  const factory _PublicKeyBundle({
    required final String identityKey,
    required final String signedPreKey,
    required final String signedPreKeySignature,
    required final List<String> oneTimePreKeys,
    required final int registrationId,
    required final String userId,
    final String? ed25519IdentityKey,
    final String? ed25519Signature,
  }) = _$PublicKeyBundleImpl;

  factory _PublicKeyBundle.fromJson(Map<String, dynamic> json) =
      _$PublicKeyBundleImpl.fromJson;

  /// The recipient's public identity key (X25519), base64-encoded.
  @override
  String get identityKey;

  /// The recipient's current signed pre-key (X25519), base64-encoded.
  @override
  String get signedPreKey;

  /// Signature over the signed pre-key, base64-encoded.
  @override
  String get signedPreKeySignature;

  /// Available one-time pre-keys (server returns one), base64-encoded.
  @override
  List<String> get oneTimePreKeys;

  /// The recipient's registration ID.
  @override
  int get registrationId;

  /// The user ID this bundle belongs to.
  @override
  String get userId;

  /// Ed25519 public identity key for signature verification, base64-encoded.
  /// Null for bundles generated before Ed25519 support.
  @override
  String? get ed25519IdentityKey;

  /// Ed25519 signature over the signed pre-key public bytes, base64-encoded.
  /// Verifiable using [ed25519IdentityKey].
  @override
  String? get ed25519Signature;

  /// Create a copy of PublicKeyBundle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublicKeyBundleImplCopyWith<_$PublicKeyBundleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BackupMetadata _$BackupMetadataFromJson(Map<String, dynamic> json) {
  return _BackupMetadata.fromJson(json);
}

/// @nodoc
mixin _$BackupMetadata {
  /// Whether a backup exists on the server.
  bool get backupExists => throw _privateConstructorUsedError;

  /// When the last backup was created/updated.
  DateTime? get lastBackupAt => throw _privateConstructorUsedError;

  /// Version number of the backup format.
  int? get backupVersion => throw _privateConstructorUsedError;

  /// The user ID this backup belongs to.
  String get userId => throw _privateConstructorUsedError;

  /// Serializes this BackupMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BackupMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BackupMetadataCopyWith<BackupMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackupMetadataCopyWith<$Res> {
  factory $BackupMetadataCopyWith(
    BackupMetadata value,
    $Res Function(BackupMetadata) then,
  ) = _$BackupMetadataCopyWithImpl<$Res, BackupMetadata>;
  @useResult
  $Res call({
    bool backupExists,
    DateTime? lastBackupAt,
    int? backupVersion,
    String userId,
  });
}

/// @nodoc
class _$BackupMetadataCopyWithImpl<$Res, $Val extends BackupMetadata>
    implements $BackupMetadataCopyWith<$Res> {
  _$BackupMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BackupMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backupExists = null,
    Object? lastBackupAt = freezed,
    Object? backupVersion = freezed,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            backupExists: null == backupExists
                ? _value.backupExists
                : backupExists // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastBackupAt: freezed == lastBackupAt
                ? _value.lastBackupAt
                : lastBackupAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            backupVersion: freezed == backupVersion
                ? _value.backupVersion
                : backupVersion // ignore: cast_nullable_to_non_nullable
                      as int?,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BackupMetadataImplCopyWith<$Res>
    implements $BackupMetadataCopyWith<$Res> {
  factory _$$BackupMetadataImplCopyWith(
    _$BackupMetadataImpl value,
    $Res Function(_$BackupMetadataImpl) then,
  ) = __$$BackupMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool backupExists,
    DateTime? lastBackupAt,
    int? backupVersion,
    String userId,
  });
}

/// @nodoc
class __$$BackupMetadataImplCopyWithImpl<$Res>
    extends _$BackupMetadataCopyWithImpl<$Res, _$BackupMetadataImpl>
    implements _$$BackupMetadataImplCopyWith<$Res> {
  __$$BackupMetadataImplCopyWithImpl(
    _$BackupMetadataImpl _value,
    $Res Function(_$BackupMetadataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BackupMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backupExists = null,
    Object? lastBackupAt = freezed,
    Object? backupVersion = freezed,
    Object? userId = null,
  }) {
    return _then(
      _$BackupMetadataImpl(
        backupExists: null == backupExists
            ? _value.backupExists
            : backupExists // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastBackupAt: freezed == lastBackupAt
            ? _value.lastBackupAt
            : lastBackupAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        backupVersion: freezed == backupVersion
            ? _value.backupVersion
            : backupVersion // ignore: cast_nullable_to_non_nullable
                  as int?,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BackupMetadataImpl implements _BackupMetadata {
  const _$BackupMetadataImpl({
    required this.backupExists,
    this.lastBackupAt,
    this.backupVersion,
    required this.userId,
  });

  factory _$BackupMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BackupMetadataImplFromJson(json);

  /// Whether a backup exists on the server.
  @override
  final bool backupExists;

  /// When the last backup was created/updated.
  @override
  final DateTime? lastBackupAt;

  /// Version number of the backup format.
  @override
  final int? backupVersion;

  /// The user ID this backup belongs to.
  @override
  final String userId;

  @override
  String toString() {
    return 'BackupMetadata(backupExists: $backupExists, lastBackupAt: $lastBackupAt, backupVersion: $backupVersion, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackupMetadataImpl &&
            (identical(other.backupExists, backupExists) ||
                other.backupExists == backupExists) &&
            (identical(other.lastBackupAt, lastBackupAt) ||
                other.lastBackupAt == lastBackupAt) &&
            (identical(other.backupVersion, backupVersion) ||
                other.backupVersion == backupVersion) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    backupExists,
    lastBackupAt,
    backupVersion,
    userId,
  );

  /// Create a copy of BackupMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupMetadataImplCopyWith<_$BackupMetadataImpl> get copyWith =>
      __$$BackupMetadataImplCopyWithImpl<_$BackupMetadataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BackupMetadataImplToJson(this);
  }
}

abstract class _BackupMetadata implements BackupMetadata {
  const factory _BackupMetadata({
    required final bool backupExists,
    final DateTime? lastBackupAt,
    final int? backupVersion,
    required final String userId,
  }) = _$BackupMetadataImpl;

  factory _BackupMetadata.fromJson(Map<String, dynamic> json) =
      _$BackupMetadataImpl.fromJson;

  /// Whether a backup exists on the server.
  @override
  bool get backupExists;

  /// When the last backup was created/updated.
  @override
  DateTime? get lastBackupAt;

  /// Version number of the backup format.
  @override
  int? get backupVersion;

  /// The user ID this backup belongs to.
  @override
  String get userId;

  /// Create a copy of BackupMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BackupMetadataImplCopyWith<_$BackupMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
