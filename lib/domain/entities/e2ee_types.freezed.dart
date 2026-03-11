// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'e2ee_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyBundle {

/// The long-term identity key pair (X25519), base64-encoded as "priv|pub".
 String get identityKeyPair;/// The signed pre-key (rotated periodically), base64-encoded as "priv|pub".
 String get signedPreKey;/// Signature over the signed pre-key using the identity key.
 String get signedPreKeySignature;/// List of one-time pre-keys (consumed on first message), base64-encoded.
 List<String> get oneTimePreKeys;/// Local registration ID for this device.
 int get registrationId;/// Ed25519 signing key pair, base64-encoded as "priv|pub".
/// Used for verifiable signatures on the signed pre-key.
/// Null for bundles generated before Ed25519 support was added.
 String? get ed25519IdentityKeyPair;/// Ed25519 signature over the signed pre-key's public key bytes.
/// Verifiable by any party using the Ed25519 public key.
 String? get ed25519Signature;// ── v2 (Signal-compliant) fields ──────────────────────────────
/// Integer ID of the current signed pre-key (for SPK rotation tracking).
/// Null for v1 bundles.
 int? get signedPreKeyId;/// Next one-time pre-key ID counter (monotonically increasing).
/// Used to assign integer IDs to newly generated OTKs.
 int? get nextOneTimePreKeyId;/// Protocol version (2 = spec-compliant Signal Protocol).
 int get protocolVersion;/// Previous signed pre-key (retained during grace period), base64 "priv|pub".
 String? get previousSignedPreKey;/// ID of the previous signed pre-key.
 int? get previousSignedPreKeyId;/// Signature of the previous signed pre-key.
 String? get previousSignedPreKeySignature;/// Timestamp when the current SPK was created (for grace period calculation).
 DateTime? get signedPreKeyTimestamp;/// Timestamp when the previous SPK was created (for grace period expiry).
 DateTime? get previousSignedPreKeyTimestamp;
/// Create a copy of KeyBundle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyBundleCopyWith<KeyBundle> get copyWith => _$KeyBundleCopyWithImpl<KeyBundle>(this as KeyBundle, _$identity);

  /// Serializes this KeyBundle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyBundle&&(identical(other.identityKeyPair, identityKeyPair) || other.identityKeyPair == identityKeyPair)&&(identical(other.signedPreKey, signedPreKey) || other.signedPreKey == signedPreKey)&&(identical(other.signedPreKeySignature, signedPreKeySignature) || other.signedPreKeySignature == signedPreKeySignature)&&const DeepCollectionEquality().equals(other.oneTimePreKeys, oneTimePreKeys)&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.ed25519IdentityKeyPair, ed25519IdentityKeyPair) || other.ed25519IdentityKeyPair == ed25519IdentityKeyPair)&&(identical(other.ed25519Signature, ed25519Signature) || other.ed25519Signature == ed25519Signature)&&(identical(other.signedPreKeyId, signedPreKeyId) || other.signedPreKeyId == signedPreKeyId)&&(identical(other.nextOneTimePreKeyId, nextOneTimePreKeyId) || other.nextOneTimePreKeyId == nextOneTimePreKeyId)&&(identical(other.protocolVersion, protocolVersion) || other.protocolVersion == protocolVersion)&&(identical(other.previousSignedPreKey, previousSignedPreKey) || other.previousSignedPreKey == previousSignedPreKey)&&(identical(other.previousSignedPreKeyId, previousSignedPreKeyId) || other.previousSignedPreKeyId == previousSignedPreKeyId)&&(identical(other.previousSignedPreKeySignature, previousSignedPreKeySignature) || other.previousSignedPreKeySignature == previousSignedPreKeySignature)&&(identical(other.signedPreKeyTimestamp, signedPreKeyTimestamp) || other.signedPreKeyTimestamp == signedPreKeyTimestamp)&&(identical(other.previousSignedPreKeyTimestamp, previousSignedPreKeyTimestamp) || other.previousSignedPreKeyTimestamp == previousSignedPreKeyTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identityKeyPair,signedPreKey,signedPreKeySignature,const DeepCollectionEquality().hash(oneTimePreKeys),registrationId,ed25519IdentityKeyPair,ed25519Signature,signedPreKeyId,nextOneTimePreKeyId,protocolVersion,previousSignedPreKey,previousSignedPreKeyId,previousSignedPreKeySignature,signedPreKeyTimestamp,previousSignedPreKeyTimestamp);

@override
String toString() {
  return 'KeyBundle(identityKeyPair: $identityKeyPair, signedPreKey: $signedPreKey, signedPreKeySignature: $signedPreKeySignature, oneTimePreKeys: $oneTimePreKeys, registrationId: $registrationId, ed25519IdentityKeyPair: $ed25519IdentityKeyPair, ed25519Signature: $ed25519Signature, signedPreKeyId: $signedPreKeyId, nextOneTimePreKeyId: $nextOneTimePreKeyId, protocolVersion: $protocolVersion, previousSignedPreKey: $previousSignedPreKey, previousSignedPreKeyId: $previousSignedPreKeyId, previousSignedPreKeySignature: $previousSignedPreKeySignature, signedPreKeyTimestamp: $signedPreKeyTimestamp, previousSignedPreKeyTimestamp: $previousSignedPreKeyTimestamp)';
}


}

/// @nodoc
abstract mixin class $KeyBundleCopyWith<$Res>  {
  factory $KeyBundleCopyWith(KeyBundle value, $Res Function(KeyBundle) _then) = _$KeyBundleCopyWithImpl;
@useResult
$Res call({
 String identityKeyPair, String signedPreKey, String signedPreKeySignature, List<String> oneTimePreKeys, int registrationId, String? ed25519IdentityKeyPair, String? ed25519Signature, int? signedPreKeyId, int? nextOneTimePreKeyId, int protocolVersion, String? previousSignedPreKey, int? previousSignedPreKeyId, String? previousSignedPreKeySignature, DateTime? signedPreKeyTimestamp, DateTime? previousSignedPreKeyTimestamp
});




}
/// @nodoc
class _$KeyBundleCopyWithImpl<$Res>
    implements $KeyBundleCopyWith<$Res> {
  _$KeyBundleCopyWithImpl(this._self, this._then);

  final KeyBundle _self;
  final $Res Function(KeyBundle) _then;

/// Create a copy of KeyBundle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identityKeyPair = null,Object? signedPreKey = null,Object? signedPreKeySignature = null,Object? oneTimePreKeys = null,Object? registrationId = null,Object? ed25519IdentityKeyPair = freezed,Object? ed25519Signature = freezed,Object? signedPreKeyId = freezed,Object? nextOneTimePreKeyId = freezed,Object? protocolVersion = null,Object? previousSignedPreKey = freezed,Object? previousSignedPreKeyId = freezed,Object? previousSignedPreKeySignature = freezed,Object? signedPreKeyTimestamp = freezed,Object? previousSignedPreKeyTimestamp = freezed,}) {
  return _then(_self.copyWith(
identityKeyPair: null == identityKeyPair ? _self.identityKeyPair : identityKeyPair // ignore: cast_nullable_to_non_nullable
as String,signedPreKey: null == signedPreKey ? _self.signedPreKey : signedPreKey // ignore: cast_nullable_to_non_nullable
as String,signedPreKeySignature: null == signedPreKeySignature ? _self.signedPreKeySignature : signedPreKeySignature // ignore: cast_nullable_to_non_nullable
as String,oneTimePreKeys: null == oneTimePreKeys ? _self.oneTimePreKeys : oneTimePreKeys // ignore: cast_nullable_to_non_nullable
as List<String>,registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as int,ed25519IdentityKeyPair: freezed == ed25519IdentityKeyPair ? _self.ed25519IdentityKeyPair : ed25519IdentityKeyPair // ignore: cast_nullable_to_non_nullable
as String?,ed25519Signature: freezed == ed25519Signature ? _self.ed25519Signature : ed25519Signature // ignore: cast_nullable_to_non_nullable
as String?,signedPreKeyId: freezed == signedPreKeyId ? _self.signedPreKeyId : signedPreKeyId // ignore: cast_nullable_to_non_nullable
as int?,nextOneTimePreKeyId: freezed == nextOneTimePreKeyId ? _self.nextOneTimePreKeyId : nextOneTimePreKeyId // ignore: cast_nullable_to_non_nullable
as int?,protocolVersion: null == protocolVersion ? _self.protocolVersion : protocolVersion // ignore: cast_nullable_to_non_nullable
as int,previousSignedPreKey: freezed == previousSignedPreKey ? _self.previousSignedPreKey : previousSignedPreKey // ignore: cast_nullable_to_non_nullable
as String?,previousSignedPreKeyId: freezed == previousSignedPreKeyId ? _self.previousSignedPreKeyId : previousSignedPreKeyId // ignore: cast_nullable_to_non_nullable
as int?,previousSignedPreKeySignature: freezed == previousSignedPreKeySignature ? _self.previousSignedPreKeySignature : previousSignedPreKeySignature // ignore: cast_nullable_to_non_nullable
as String?,signedPreKeyTimestamp: freezed == signedPreKeyTimestamp ? _self.signedPreKeyTimestamp : signedPreKeyTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,previousSignedPreKeyTimestamp: freezed == previousSignedPreKeyTimestamp ? _self.previousSignedPreKeyTimestamp : previousSignedPreKeyTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [KeyBundle].
extension KeyBundlePatterns on KeyBundle {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeyBundle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeyBundle() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeyBundle value)  $default,){
final _that = this;
switch (_that) {
case _KeyBundle():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeyBundle value)?  $default,){
final _that = this;
switch (_that) {
case _KeyBundle() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identityKeyPair,  String signedPreKey,  String signedPreKeySignature,  List<String> oneTimePreKeys,  int registrationId,  String? ed25519IdentityKeyPair,  String? ed25519Signature,  int? signedPreKeyId,  int? nextOneTimePreKeyId,  int protocolVersion,  String? previousSignedPreKey,  int? previousSignedPreKeyId,  String? previousSignedPreKeySignature,  DateTime? signedPreKeyTimestamp,  DateTime? previousSignedPreKeyTimestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeyBundle() when $default != null:
return $default(_that.identityKeyPair,_that.signedPreKey,_that.signedPreKeySignature,_that.oneTimePreKeys,_that.registrationId,_that.ed25519IdentityKeyPair,_that.ed25519Signature,_that.signedPreKeyId,_that.nextOneTimePreKeyId,_that.protocolVersion,_that.previousSignedPreKey,_that.previousSignedPreKeyId,_that.previousSignedPreKeySignature,_that.signedPreKeyTimestamp,_that.previousSignedPreKeyTimestamp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identityKeyPair,  String signedPreKey,  String signedPreKeySignature,  List<String> oneTimePreKeys,  int registrationId,  String? ed25519IdentityKeyPair,  String? ed25519Signature,  int? signedPreKeyId,  int? nextOneTimePreKeyId,  int protocolVersion,  String? previousSignedPreKey,  int? previousSignedPreKeyId,  String? previousSignedPreKeySignature,  DateTime? signedPreKeyTimestamp,  DateTime? previousSignedPreKeyTimestamp)  $default,) {final _that = this;
switch (_that) {
case _KeyBundle():
return $default(_that.identityKeyPair,_that.signedPreKey,_that.signedPreKeySignature,_that.oneTimePreKeys,_that.registrationId,_that.ed25519IdentityKeyPair,_that.ed25519Signature,_that.signedPreKeyId,_that.nextOneTimePreKeyId,_that.protocolVersion,_that.previousSignedPreKey,_that.previousSignedPreKeyId,_that.previousSignedPreKeySignature,_that.signedPreKeyTimestamp,_that.previousSignedPreKeyTimestamp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identityKeyPair,  String signedPreKey,  String signedPreKeySignature,  List<String> oneTimePreKeys,  int registrationId,  String? ed25519IdentityKeyPair,  String? ed25519Signature,  int? signedPreKeyId,  int? nextOneTimePreKeyId,  int protocolVersion,  String? previousSignedPreKey,  int? previousSignedPreKeyId,  String? previousSignedPreKeySignature,  DateTime? signedPreKeyTimestamp,  DateTime? previousSignedPreKeyTimestamp)?  $default,) {final _that = this;
switch (_that) {
case _KeyBundle() when $default != null:
return $default(_that.identityKeyPair,_that.signedPreKey,_that.signedPreKeySignature,_that.oneTimePreKeys,_that.registrationId,_that.ed25519IdentityKeyPair,_that.ed25519Signature,_that.signedPreKeyId,_that.nextOneTimePreKeyId,_that.protocolVersion,_that.previousSignedPreKey,_that.previousSignedPreKeyId,_that.previousSignedPreKeySignature,_that.signedPreKeyTimestamp,_that.previousSignedPreKeyTimestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KeyBundle implements KeyBundle {
  const _KeyBundle({required this.identityKeyPair, required this.signedPreKey, required this.signedPreKeySignature, required final  List<String> oneTimePreKeys, required this.registrationId, this.ed25519IdentityKeyPair, this.ed25519Signature, this.signedPreKeyId, this.nextOneTimePreKeyId, this.protocolVersion = 2, this.previousSignedPreKey, this.previousSignedPreKeyId, this.previousSignedPreKeySignature, this.signedPreKeyTimestamp, this.previousSignedPreKeyTimestamp}): _oneTimePreKeys = oneTimePreKeys;
  factory _KeyBundle.fromJson(Map<String, dynamic> json) => _$KeyBundleFromJson(json);

/// The long-term identity key pair (X25519), base64-encoded as "priv|pub".
@override final  String identityKeyPair;
/// The signed pre-key (rotated periodically), base64-encoded as "priv|pub".
@override final  String signedPreKey;
/// Signature over the signed pre-key using the identity key.
@override final  String signedPreKeySignature;
/// List of one-time pre-keys (consumed on first message), base64-encoded.
 final  List<String> _oneTimePreKeys;
/// List of one-time pre-keys (consumed on first message), base64-encoded.
@override List<String> get oneTimePreKeys {
  if (_oneTimePreKeys is EqualUnmodifiableListView) return _oneTimePreKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_oneTimePreKeys);
}

/// Local registration ID for this device.
@override final  int registrationId;
/// Ed25519 signing key pair, base64-encoded as "priv|pub".
/// Used for verifiable signatures on the signed pre-key.
/// Null for bundles generated before Ed25519 support was added.
@override final  String? ed25519IdentityKeyPair;
/// Ed25519 signature over the signed pre-key's public key bytes.
/// Verifiable by any party using the Ed25519 public key.
@override final  String? ed25519Signature;
// ── v2 (Signal-compliant) fields ──────────────────────────────
/// Integer ID of the current signed pre-key (for SPK rotation tracking).
/// Null for v1 bundles.
@override final  int? signedPreKeyId;
/// Next one-time pre-key ID counter (monotonically increasing).
/// Used to assign integer IDs to newly generated OTKs.
@override final  int? nextOneTimePreKeyId;
/// Protocol version (2 = spec-compliant Signal Protocol).
@override@JsonKey() final  int protocolVersion;
/// Previous signed pre-key (retained during grace period), base64 "priv|pub".
@override final  String? previousSignedPreKey;
/// ID of the previous signed pre-key.
@override final  int? previousSignedPreKeyId;
/// Signature of the previous signed pre-key.
@override final  String? previousSignedPreKeySignature;
/// Timestamp when the current SPK was created (for grace period calculation).
@override final  DateTime? signedPreKeyTimestamp;
/// Timestamp when the previous SPK was created (for grace period expiry).
@override final  DateTime? previousSignedPreKeyTimestamp;

/// Create a copy of KeyBundle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeyBundleCopyWith<_KeyBundle> get copyWith => __$KeyBundleCopyWithImpl<_KeyBundle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KeyBundleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeyBundle&&(identical(other.identityKeyPair, identityKeyPair) || other.identityKeyPair == identityKeyPair)&&(identical(other.signedPreKey, signedPreKey) || other.signedPreKey == signedPreKey)&&(identical(other.signedPreKeySignature, signedPreKeySignature) || other.signedPreKeySignature == signedPreKeySignature)&&const DeepCollectionEquality().equals(other._oneTimePreKeys, _oneTimePreKeys)&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.ed25519IdentityKeyPair, ed25519IdentityKeyPair) || other.ed25519IdentityKeyPair == ed25519IdentityKeyPair)&&(identical(other.ed25519Signature, ed25519Signature) || other.ed25519Signature == ed25519Signature)&&(identical(other.signedPreKeyId, signedPreKeyId) || other.signedPreKeyId == signedPreKeyId)&&(identical(other.nextOneTimePreKeyId, nextOneTimePreKeyId) || other.nextOneTimePreKeyId == nextOneTimePreKeyId)&&(identical(other.protocolVersion, protocolVersion) || other.protocolVersion == protocolVersion)&&(identical(other.previousSignedPreKey, previousSignedPreKey) || other.previousSignedPreKey == previousSignedPreKey)&&(identical(other.previousSignedPreKeyId, previousSignedPreKeyId) || other.previousSignedPreKeyId == previousSignedPreKeyId)&&(identical(other.previousSignedPreKeySignature, previousSignedPreKeySignature) || other.previousSignedPreKeySignature == previousSignedPreKeySignature)&&(identical(other.signedPreKeyTimestamp, signedPreKeyTimestamp) || other.signedPreKeyTimestamp == signedPreKeyTimestamp)&&(identical(other.previousSignedPreKeyTimestamp, previousSignedPreKeyTimestamp) || other.previousSignedPreKeyTimestamp == previousSignedPreKeyTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identityKeyPair,signedPreKey,signedPreKeySignature,const DeepCollectionEquality().hash(_oneTimePreKeys),registrationId,ed25519IdentityKeyPair,ed25519Signature,signedPreKeyId,nextOneTimePreKeyId,protocolVersion,previousSignedPreKey,previousSignedPreKeyId,previousSignedPreKeySignature,signedPreKeyTimestamp,previousSignedPreKeyTimestamp);

@override
String toString() {
  return 'KeyBundle(identityKeyPair: $identityKeyPair, signedPreKey: $signedPreKey, signedPreKeySignature: $signedPreKeySignature, oneTimePreKeys: $oneTimePreKeys, registrationId: $registrationId, ed25519IdentityKeyPair: $ed25519IdentityKeyPair, ed25519Signature: $ed25519Signature, signedPreKeyId: $signedPreKeyId, nextOneTimePreKeyId: $nextOneTimePreKeyId, protocolVersion: $protocolVersion, previousSignedPreKey: $previousSignedPreKey, previousSignedPreKeyId: $previousSignedPreKeyId, previousSignedPreKeySignature: $previousSignedPreKeySignature, signedPreKeyTimestamp: $signedPreKeyTimestamp, previousSignedPreKeyTimestamp: $previousSignedPreKeyTimestamp)';
}


}

/// @nodoc
abstract mixin class _$KeyBundleCopyWith<$Res> implements $KeyBundleCopyWith<$Res> {
  factory _$KeyBundleCopyWith(_KeyBundle value, $Res Function(_KeyBundle) _then) = __$KeyBundleCopyWithImpl;
@override @useResult
$Res call({
 String identityKeyPair, String signedPreKey, String signedPreKeySignature, List<String> oneTimePreKeys, int registrationId, String? ed25519IdentityKeyPair, String? ed25519Signature, int? signedPreKeyId, int? nextOneTimePreKeyId, int protocolVersion, String? previousSignedPreKey, int? previousSignedPreKeyId, String? previousSignedPreKeySignature, DateTime? signedPreKeyTimestamp, DateTime? previousSignedPreKeyTimestamp
});




}
/// @nodoc
class __$KeyBundleCopyWithImpl<$Res>
    implements _$KeyBundleCopyWith<$Res> {
  __$KeyBundleCopyWithImpl(this._self, this._then);

  final _KeyBundle _self;
  final $Res Function(_KeyBundle) _then;

/// Create a copy of KeyBundle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identityKeyPair = null,Object? signedPreKey = null,Object? signedPreKeySignature = null,Object? oneTimePreKeys = null,Object? registrationId = null,Object? ed25519IdentityKeyPair = freezed,Object? ed25519Signature = freezed,Object? signedPreKeyId = freezed,Object? nextOneTimePreKeyId = freezed,Object? protocolVersion = null,Object? previousSignedPreKey = freezed,Object? previousSignedPreKeyId = freezed,Object? previousSignedPreKeySignature = freezed,Object? signedPreKeyTimestamp = freezed,Object? previousSignedPreKeyTimestamp = freezed,}) {
  return _then(_KeyBundle(
identityKeyPair: null == identityKeyPair ? _self.identityKeyPair : identityKeyPair // ignore: cast_nullable_to_non_nullable
as String,signedPreKey: null == signedPreKey ? _self.signedPreKey : signedPreKey // ignore: cast_nullable_to_non_nullable
as String,signedPreKeySignature: null == signedPreKeySignature ? _self.signedPreKeySignature : signedPreKeySignature // ignore: cast_nullable_to_non_nullable
as String,oneTimePreKeys: null == oneTimePreKeys ? _self._oneTimePreKeys : oneTimePreKeys // ignore: cast_nullable_to_non_nullable
as List<String>,registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as int,ed25519IdentityKeyPair: freezed == ed25519IdentityKeyPair ? _self.ed25519IdentityKeyPair : ed25519IdentityKeyPair // ignore: cast_nullable_to_non_nullable
as String?,ed25519Signature: freezed == ed25519Signature ? _self.ed25519Signature : ed25519Signature // ignore: cast_nullable_to_non_nullable
as String?,signedPreKeyId: freezed == signedPreKeyId ? _self.signedPreKeyId : signedPreKeyId // ignore: cast_nullable_to_non_nullable
as int?,nextOneTimePreKeyId: freezed == nextOneTimePreKeyId ? _self.nextOneTimePreKeyId : nextOneTimePreKeyId // ignore: cast_nullable_to_non_nullable
as int?,protocolVersion: null == protocolVersion ? _self.protocolVersion : protocolVersion // ignore: cast_nullable_to_non_nullable
as int,previousSignedPreKey: freezed == previousSignedPreKey ? _self.previousSignedPreKey : previousSignedPreKey // ignore: cast_nullable_to_non_nullable
as String?,previousSignedPreKeyId: freezed == previousSignedPreKeyId ? _self.previousSignedPreKeyId : previousSignedPreKeyId // ignore: cast_nullable_to_non_nullable
as int?,previousSignedPreKeySignature: freezed == previousSignedPreKeySignature ? _self.previousSignedPreKeySignature : previousSignedPreKeySignature // ignore: cast_nullable_to_non_nullable
as String?,signedPreKeyTimestamp: freezed == signedPreKeyTimestamp ? _self.signedPreKeyTimestamp : signedPreKeyTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,previousSignedPreKeyTimestamp: freezed == previousSignedPreKeyTimestamp ? _self.previousSignedPreKeyTimestamp : previousSignedPreKeyTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PublicKeyBundle {

/// The recipient's public identity key (X25519), base64-encoded.
 String get identityKey;/// The recipient's current signed pre-key (X25519), base64-encoded.
 String get signedPreKey;/// Signature over the signed pre-key, base64-encoded.
 String get signedPreKeySignature;/// Available one-time pre-keys (server returns one), base64-encoded.
 List<String> get oneTimePreKeys;/// The recipient's registration ID.
 int get registrationId;/// The user ID this bundle belongs to.
 String get userId;/// Ed25519 public identity key for signature verification, base64-encoded.
/// Null for bundles generated before Ed25519 support.
 String? get ed25519IdentityKey;/// Ed25519 signature over the signed pre-key public bytes, base64-encoded.
/// Verifiable using [ed25519IdentityKey].
 String? get ed25519Signature;// ── v2 (Signal-compliant) fields ──────────────────────────────
/// Integer ID of the signed pre-key (for X3DH header).
 int? get signedPreKeyId;/// Integer ID of the one-time pre-key returned by the server.
/// Null if no OTK was available (X3DH without DH4).
 int? get oneTimePreKeyId;/// Protocol version supported by this peer (2 = spec-compliant).
 int get protocolVersion;
/// Create a copy of PublicKeyBundle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicKeyBundleCopyWith<PublicKeyBundle> get copyWith => _$PublicKeyBundleCopyWithImpl<PublicKeyBundle>(this as PublicKeyBundle, _$identity);

  /// Serializes this PublicKeyBundle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicKeyBundle&&(identical(other.identityKey, identityKey) || other.identityKey == identityKey)&&(identical(other.signedPreKey, signedPreKey) || other.signedPreKey == signedPreKey)&&(identical(other.signedPreKeySignature, signedPreKeySignature) || other.signedPreKeySignature == signedPreKeySignature)&&const DeepCollectionEquality().equals(other.oneTimePreKeys, oneTimePreKeys)&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.ed25519IdentityKey, ed25519IdentityKey) || other.ed25519IdentityKey == ed25519IdentityKey)&&(identical(other.ed25519Signature, ed25519Signature) || other.ed25519Signature == ed25519Signature)&&(identical(other.signedPreKeyId, signedPreKeyId) || other.signedPreKeyId == signedPreKeyId)&&(identical(other.oneTimePreKeyId, oneTimePreKeyId) || other.oneTimePreKeyId == oneTimePreKeyId)&&(identical(other.protocolVersion, protocolVersion) || other.protocolVersion == protocolVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identityKey,signedPreKey,signedPreKeySignature,const DeepCollectionEquality().hash(oneTimePreKeys),registrationId,userId,ed25519IdentityKey,ed25519Signature,signedPreKeyId,oneTimePreKeyId,protocolVersion);

@override
String toString() {
  return 'PublicKeyBundle(identityKey: $identityKey, signedPreKey: $signedPreKey, signedPreKeySignature: $signedPreKeySignature, oneTimePreKeys: $oneTimePreKeys, registrationId: $registrationId, userId: $userId, ed25519IdentityKey: $ed25519IdentityKey, ed25519Signature: $ed25519Signature, signedPreKeyId: $signedPreKeyId, oneTimePreKeyId: $oneTimePreKeyId, protocolVersion: $protocolVersion)';
}


}

/// @nodoc
abstract mixin class $PublicKeyBundleCopyWith<$Res>  {
  factory $PublicKeyBundleCopyWith(PublicKeyBundle value, $Res Function(PublicKeyBundle) _then) = _$PublicKeyBundleCopyWithImpl;
@useResult
$Res call({
 String identityKey, String signedPreKey, String signedPreKeySignature, List<String> oneTimePreKeys, int registrationId, String userId, String? ed25519IdentityKey, String? ed25519Signature, int? signedPreKeyId, int? oneTimePreKeyId, int protocolVersion
});




}
/// @nodoc
class _$PublicKeyBundleCopyWithImpl<$Res>
    implements $PublicKeyBundleCopyWith<$Res> {
  _$PublicKeyBundleCopyWithImpl(this._self, this._then);

  final PublicKeyBundle _self;
  final $Res Function(PublicKeyBundle) _then;

/// Create a copy of PublicKeyBundle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identityKey = null,Object? signedPreKey = null,Object? signedPreKeySignature = null,Object? oneTimePreKeys = null,Object? registrationId = null,Object? userId = null,Object? ed25519IdentityKey = freezed,Object? ed25519Signature = freezed,Object? signedPreKeyId = freezed,Object? oneTimePreKeyId = freezed,Object? protocolVersion = null,}) {
  return _then(_self.copyWith(
identityKey: null == identityKey ? _self.identityKey : identityKey // ignore: cast_nullable_to_non_nullable
as String,signedPreKey: null == signedPreKey ? _self.signedPreKey : signedPreKey // ignore: cast_nullable_to_non_nullable
as String,signedPreKeySignature: null == signedPreKeySignature ? _self.signedPreKeySignature : signedPreKeySignature // ignore: cast_nullable_to_non_nullable
as String,oneTimePreKeys: null == oneTimePreKeys ? _self.oneTimePreKeys : oneTimePreKeys // ignore: cast_nullable_to_non_nullable
as List<String>,registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,ed25519IdentityKey: freezed == ed25519IdentityKey ? _self.ed25519IdentityKey : ed25519IdentityKey // ignore: cast_nullable_to_non_nullable
as String?,ed25519Signature: freezed == ed25519Signature ? _self.ed25519Signature : ed25519Signature // ignore: cast_nullable_to_non_nullable
as String?,signedPreKeyId: freezed == signedPreKeyId ? _self.signedPreKeyId : signedPreKeyId // ignore: cast_nullable_to_non_nullable
as int?,oneTimePreKeyId: freezed == oneTimePreKeyId ? _self.oneTimePreKeyId : oneTimePreKeyId // ignore: cast_nullable_to_non_nullable
as int?,protocolVersion: null == protocolVersion ? _self.protocolVersion : protocolVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicKeyBundle].
extension PublicKeyBundlePatterns on PublicKeyBundle {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicKeyBundle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicKeyBundle() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicKeyBundle value)  $default,){
final _that = this;
switch (_that) {
case _PublicKeyBundle():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicKeyBundle value)?  $default,){
final _that = this;
switch (_that) {
case _PublicKeyBundle() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String identityKey,  String signedPreKey,  String signedPreKeySignature,  List<String> oneTimePreKeys,  int registrationId,  String userId,  String? ed25519IdentityKey,  String? ed25519Signature,  int? signedPreKeyId,  int? oneTimePreKeyId,  int protocolVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicKeyBundle() when $default != null:
return $default(_that.identityKey,_that.signedPreKey,_that.signedPreKeySignature,_that.oneTimePreKeys,_that.registrationId,_that.userId,_that.ed25519IdentityKey,_that.ed25519Signature,_that.signedPreKeyId,_that.oneTimePreKeyId,_that.protocolVersion);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String identityKey,  String signedPreKey,  String signedPreKeySignature,  List<String> oneTimePreKeys,  int registrationId,  String userId,  String? ed25519IdentityKey,  String? ed25519Signature,  int? signedPreKeyId,  int? oneTimePreKeyId,  int protocolVersion)  $default,) {final _that = this;
switch (_that) {
case _PublicKeyBundle():
return $default(_that.identityKey,_that.signedPreKey,_that.signedPreKeySignature,_that.oneTimePreKeys,_that.registrationId,_that.userId,_that.ed25519IdentityKey,_that.ed25519Signature,_that.signedPreKeyId,_that.oneTimePreKeyId,_that.protocolVersion);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String identityKey,  String signedPreKey,  String signedPreKeySignature,  List<String> oneTimePreKeys,  int registrationId,  String userId,  String? ed25519IdentityKey,  String? ed25519Signature,  int? signedPreKeyId,  int? oneTimePreKeyId,  int protocolVersion)?  $default,) {final _that = this;
switch (_that) {
case _PublicKeyBundle() when $default != null:
return $default(_that.identityKey,_that.signedPreKey,_that.signedPreKeySignature,_that.oneTimePreKeys,_that.registrationId,_that.userId,_that.ed25519IdentityKey,_that.ed25519Signature,_that.signedPreKeyId,_that.oneTimePreKeyId,_that.protocolVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicKeyBundle implements PublicKeyBundle {
  const _PublicKeyBundle({required this.identityKey, required this.signedPreKey, required this.signedPreKeySignature, required final  List<String> oneTimePreKeys, required this.registrationId, required this.userId, this.ed25519IdentityKey, this.ed25519Signature, this.signedPreKeyId, this.oneTimePreKeyId, this.protocolVersion = 2}): _oneTimePreKeys = oneTimePreKeys;
  factory _PublicKeyBundle.fromJson(Map<String, dynamic> json) => _$PublicKeyBundleFromJson(json);

/// The recipient's public identity key (X25519), base64-encoded.
@override final  String identityKey;
/// The recipient's current signed pre-key (X25519), base64-encoded.
@override final  String signedPreKey;
/// Signature over the signed pre-key, base64-encoded.
@override final  String signedPreKeySignature;
/// Available one-time pre-keys (server returns one), base64-encoded.
 final  List<String> _oneTimePreKeys;
/// Available one-time pre-keys (server returns one), base64-encoded.
@override List<String> get oneTimePreKeys {
  if (_oneTimePreKeys is EqualUnmodifiableListView) return _oneTimePreKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_oneTimePreKeys);
}

/// The recipient's registration ID.
@override final  int registrationId;
/// The user ID this bundle belongs to.
@override final  String userId;
/// Ed25519 public identity key for signature verification, base64-encoded.
/// Null for bundles generated before Ed25519 support.
@override final  String? ed25519IdentityKey;
/// Ed25519 signature over the signed pre-key public bytes, base64-encoded.
/// Verifiable using [ed25519IdentityKey].
@override final  String? ed25519Signature;
// ── v2 (Signal-compliant) fields ──────────────────────────────
/// Integer ID of the signed pre-key (for X3DH header).
@override final  int? signedPreKeyId;
/// Integer ID of the one-time pre-key returned by the server.
/// Null if no OTK was available (X3DH without DH4).
@override final  int? oneTimePreKeyId;
/// Protocol version supported by this peer (2 = spec-compliant).
@override@JsonKey() final  int protocolVersion;

/// Create a copy of PublicKeyBundle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicKeyBundleCopyWith<_PublicKeyBundle> get copyWith => __$PublicKeyBundleCopyWithImpl<_PublicKeyBundle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicKeyBundleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicKeyBundle&&(identical(other.identityKey, identityKey) || other.identityKey == identityKey)&&(identical(other.signedPreKey, signedPreKey) || other.signedPreKey == signedPreKey)&&(identical(other.signedPreKeySignature, signedPreKeySignature) || other.signedPreKeySignature == signedPreKeySignature)&&const DeepCollectionEquality().equals(other._oneTimePreKeys, _oneTimePreKeys)&&(identical(other.registrationId, registrationId) || other.registrationId == registrationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.ed25519IdentityKey, ed25519IdentityKey) || other.ed25519IdentityKey == ed25519IdentityKey)&&(identical(other.ed25519Signature, ed25519Signature) || other.ed25519Signature == ed25519Signature)&&(identical(other.signedPreKeyId, signedPreKeyId) || other.signedPreKeyId == signedPreKeyId)&&(identical(other.oneTimePreKeyId, oneTimePreKeyId) || other.oneTimePreKeyId == oneTimePreKeyId)&&(identical(other.protocolVersion, protocolVersion) || other.protocolVersion == protocolVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,identityKey,signedPreKey,signedPreKeySignature,const DeepCollectionEquality().hash(_oneTimePreKeys),registrationId,userId,ed25519IdentityKey,ed25519Signature,signedPreKeyId,oneTimePreKeyId,protocolVersion);

@override
String toString() {
  return 'PublicKeyBundle(identityKey: $identityKey, signedPreKey: $signedPreKey, signedPreKeySignature: $signedPreKeySignature, oneTimePreKeys: $oneTimePreKeys, registrationId: $registrationId, userId: $userId, ed25519IdentityKey: $ed25519IdentityKey, ed25519Signature: $ed25519Signature, signedPreKeyId: $signedPreKeyId, oneTimePreKeyId: $oneTimePreKeyId, protocolVersion: $protocolVersion)';
}


}

/// @nodoc
abstract mixin class _$PublicKeyBundleCopyWith<$Res> implements $PublicKeyBundleCopyWith<$Res> {
  factory _$PublicKeyBundleCopyWith(_PublicKeyBundle value, $Res Function(_PublicKeyBundle) _then) = __$PublicKeyBundleCopyWithImpl;
@override @useResult
$Res call({
 String identityKey, String signedPreKey, String signedPreKeySignature, List<String> oneTimePreKeys, int registrationId, String userId, String? ed25519IdentityKey, String? ed25519Signature, int? signedPreKeyId, int? oneTimePreKeyId, int protocolVersion
});




}
/// @nodoc
class __$PublicKeyBundleCopyWithImpl<$Res>
    implements _$PublicKeyBundleCopyWith<$Res> {
  __$PublicKeyBundleCopyWithImpl(this._self, this._then);

  final _PublicKeyBundle _self;
  final $Res Function(_PublicKeyBundle) _then;

/// Create a copy of PublicKeyBundle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identityKey = null,Object? signedPreKey = null,Object? signedPreKeySignature = null,Object? oneTimePreKeys = null,Object? registrationId = null,Object? userId = null,Object? ed25519IdentityKey = freezed,Object? ed25519Signature = freezed,Object? signedPreKeyId = freezed,Object? oneTimePreKeyId = freezed,Object? protocolVersion = null,}) {
  return _then(_PublicKeyBundle(
identityKey: null == identityKey ? _self.identityKey : identityKey // ignore: cast_nullable_to_non_nullable
as String,signedPreKey: null == signedPreKey ? _self.signedPreKey : signedPreKey // ignore: cast_nullable_to_non_nullable
as String,signedPreKeySignature: null == signedPreKeySignature ? _self.signedPreKeySignature : signedPreKeySignature // ignore: cast_nullable_to_non_nullable
as String,oneTimePreKeys: null == oneTimePreKeys ? _self._oneTimePreKeys : oneTimePreKeys // ignore: cast_nullable_to_non_nullable
as List<String>,registrationId: null == registrationId ? _self.registrationId : registrationId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,ed25519IdentityKey: freezed == ed25519IdentityKey ? _self.ed25519IdentityKey : ed25519IdentityKey // ignore: cast_nullable_to_non_nullable
as String?,ed25519Signature: freezed == ed25519Signature ? _self.ed25519Signature : ed25519Signature // ignore: cast_nullable_to_non_nullable
as String?,signedPreKeyId: freezed == signedPreKeyId ? _self.signedPreKeyId : signedPreKeyId // ignore: cast_nullable_to_non_nullable
as int?,oneTimePreKeyId: freezed == oneTimePreKeyId ? _self.oneTimePreKeyId : oneTimePreKeyId // ignore: cast_nullable_to_non_nullable
as int?,protocolVersion: null == protocolVersion ? _self.protocolVersion : protocolVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BackupMetadata {

/// Whether a backup exists on the server.
 bool get backupExists;/// When the last backup was created/updated.
 DateTime? get lastBackupAt;/// Version number of the backup format.
 int? get backupVersion;/// The user ID this backup belongs to.
 String get userId;
/// Create a copy of BackupMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupMetadataCopyWith<BackupMetadata> get copyWith => _$BackupMetadataCopyWithImpl<BackupMetadata>(this as BackupMetadata, _$identity);

  /// Serializes this BackupMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupMetadata&&(identical(other.backupExists, backupExists) || other.backupExists == backupExists)&&(identical(other.lastBackupAt, lastBackupAt) || other.lastBackupAt == lastBackupAt)&&(identical(other.backupVersion, backupVersion) || other.backupVersion == backupVersion)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backupExists,lastBackupAt,backupVersion,userId);

@override
String toString() {
  return 'BackupMetadata(backupExists: $backupExists, lastBackupAt: $lastBackupAt, backupVersion: $backupVersion, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $BackupMetadataCopyWith<$Res>  {
  factory $BackupMetadataCopyWith(BackupMetadata value, $Res Function(BackupMetadata) _then) = _$BackupMetadataCopyWithImpl;
@useResult
$Res call({
 bool backupExists, DateTime? lastBackupAt, int? backupVersion, String userId
});




}
/// @nodoc
class _$BackupMetadataCopyWithImpl<$Res>
    implements $BackupMetadataCopyWith<$Res> {
  _$BackupMetadataCopyWithImpl(this._self, this._then);

  final BackupMetadata _self;
  final $Res Function(BackupMetadata) _then;

/// Create a copy of BackupMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backupExists = null,Object? lastBackupAt = freezed,Object? backupVersion = freezed,Object? userId = null,}) {
  return _then(_self.copyWith(
backupExists: null == backupExists ? _self.backupExists : backupExists // ignore: cast_nullable_to_non_nullable
as bool,lastBackupAt: freezed == lastBackupAt ? _self.lastBackupAt : lastBackupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,backupVersion: freezed == backupVersion ? _self.backupVersion : backupVersion // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupMetadata].
extension BackupMetadataPatterns on BackupMetadata {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupMetadata() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupMetadata value)  $default,){
final _that = this;
switch (_that) {
case _BackupMetadata():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _BackupMetadata() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool backupExists,  DateTime? lastBackupAt,  int? backupVersion,  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupMetadata() when $default != null:
return $default(_that.backupExists,_that.lastBackupAt,_that.backupVersion,_that.userId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool backupExists,  DateTime? lastBackupAt,  int? backupVersion,  String userId)  $default,) {final _that = this;
switch (_that) {
case _BackupMetadata():
return $default(_that.backupExists,_that.lastBackupAt,_that.backupVersion,_that.userId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool backupExists,  DateTime? lastBackupAt,  int? backupVersion,  String userId)?  $default,) {final _that = this;
switch (_that) {
case _BackupMetadata() when $default != null:
return $default(_that.backupExists,_that.lastBackupAt,_that.backupVersion,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupMetadata implements BackupMetadata {
  const _BackupMetadata({required this.backupExists, this.lastBackupAt, this.backupVersion, required this.userId});
  factory _BackupMetadata.fromJson(Map<String, dynamic> json) => _$BackupMetadataFromJson(json);

/// Whether a backup exists on the server.
@override final  bool backupExists;
/// When the last backup was created/updated.
@override final  DateTime? lastBackupAt;
/// Version number of the backup format.
@override final  int? backupVersion;
/// The user ID this backup belongs to.
@override final  String userId;

/// Create a copy of BackupMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupMetadataCopyWith<_BackupMetadata> get copyWith => __$BackupMetadataCopyWithImpl<_BackupMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupMetadata&&(identical(other.backupExists, backupExists) || other.backupExists == backupExists)&&(identical(other.lastBackupAt, lastBackupAt) || other.lastBackupAt == lastBackupAt)&&(identical(other.backupVersion, backupVersion) || other.backupVersion == backupVersion)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backupExists,lastBackupAt,backupVersion,userId);

@override
String toString() {
  return 'BackupMetadata(backupExists: $backupExists, lastBackupAt: $lastBackupAt, backupVersion: $backupVersion, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$BackupMetadataCopyWith<$Res> implements $BackupMetadataCopyWith<$Res> {
  factory _$BackupMetadataCopyWith(_BackupMetadata value, $Res Function(_BackupMetadata) _then) = __$BackupMetadataCopyWithImpl;
@override @useResult
$Res call({
 bool backupExists, DateTime? lastBackupAt, int? backupVersion, String userId
});




}
/// @nodoc
class __$BackupMetadataCopyWithImpl<$Res>
    implements _$BackupMetadataCopyWith<$Res> {
  __$BackupMetadataCopyWithImpl(this._self, this._then);

  final _BackupMetadata _self;
  final $Res Function(_BackupMetadata) _then;

/// Create a copy of BackupMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backupExists = null,Object? lastBackupAt = freezed,Object? backupVersion = freezed,Object? userId = null,}) {
  return _then(_BackupMetadata(
backupExists: null == backupExists ? _self.backupExists : backupExists // ignore: cast_nullable_to_non_nullable
as bool,lastBackupAt: freezed == lastBackupAt ? _self.lastBackupAt : lastBackupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,backupVersion: freezed == backupVersion ? _self.backupVersion : backupVersion // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
