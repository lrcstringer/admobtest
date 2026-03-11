// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthChallengeModel {

 String get challengeId; String get userId; String get nonce; String get status; DateTime get createdAt; DateTime get expiresAt; String? get deviceId; DateTime? get respondedAt;
/// Create a copy of AuthChallengeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthChallengeModelCopyWith<AuthChallengeModel> get copyWith => _$AuthChallengeModelCopyWithImpl<AuthChallengeModel>(this as AuthChallengeModel, _$identity);

  /// Serializes this AuthChallengeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthChallengeModel&&(identical(other.challengeId, challengeId) || other.challengeId == challengeId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,challengeId,userId,nonce,status,createdAt,expiresAt,deviceId,respondedAt);

@override
String toString() {
  return 'AuthChallengeModel(challengeId: $challengeId, userId: $userId, nonce: $nonce, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, deviceId: $deviceId, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class $AuthChallengeModelCopyWith<$Res>  {
  factory $AuthChallengeModelCopyWith(AuthChallengeModel value, $Res Function(AuthChallengeModel) _then) = _$AuthChallengeModelCopyWithImpl;
@useResult
$Res call({
 String challengeId, String userId, String nonce, String status, DateTime createdAt, DateTime expiresAt, String? deviceId, DateTime? respondedAt
});




}
/// @nodoc
class _$AuthChallengeModelCopyWithImpl<$Res>
    implements $AuthChallengeModelCopyWith<$Res> {
  _$AuthChallengeModelCopyWithImpl(this._self, this._then);

  final AuthChallengeModel _self;
  final $Res Function(AuthChallengeModel) _then;

/// Create a copy of AuthChallengeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? challengeId = null,Object? userId = null,Object? nonce = null,Object? status = null,Object? createdAt = null,Object? expiresAt = null,Object? deviceId = freezed,Object? respondedAt = freezed,}) {
  return _then(_self.copyWith(
challengeId: null == challengeId ? _self.challengeId : challengeId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthChallengeModel].
extension AuthChallengeModelPatterns on AuthChallengeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthChallengeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthChallengeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthChallengeModel value)  $default,){
final _that = this;
switch (_that) {
case _AuthChallengeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthChallengeModel value)?  $default,){
final _that = this;
switch (_that) {
case _AuthChallengeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String challengeId,  String userId,  String nonce,  String status,  DateTime createdAt,  DateTime expiresAt,  String? deviceId,  DateTime? respondedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthChallengeModel() when $default != null:
return $default(_that.challengeId,_that.userId,_that.nonce,_that.status,_that.createdAt,_that.expiresAt,_that.deviceId,_that.respondedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String challengeId,  String userId,  String nonce,  String status,  DateTime createdAt,  DateTime expiresAt,  String? deviceId,  DateTime? respondedAt)  $default,) {final _that = this;
switch (_that) {
case _AuthChallengeModel():
return $default(_that.challengeId,_that.userId,_that.nonce,_that.status,_that.createdAt,_that.expiresAt,_that.deviceId,_that.respondedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String challengeId,  String userId,  String nonce,  String status,  DateTime createdAt,  DateTime expiresAt,  String? deviceId,  DateTime? respondedAt)?  $default,) {final _that = this;
switch (_that) {
case _AuthChallengeModel() when $default != null:
return $default(_that.challengeId,_that.userId,_that.nonce,_that.status,_that.createdAt,_that.expiresAt,_that.deviceId,_that.respondedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthChallengeModel extends AuthChallengeModel {
  const _AuthChallengeModel({required this.challengeId, required this.userId, required this.nonce, required this.status, required this.createdAt, required this.expiresAt, this.deviceId, this.respondedAt}): super._();
  factory _AuthChallengeModel.fromJson(Map<String, dynamic> json) => _$AuthChallengeModelFromJson(json);

@override final  String challengeId;
@override final  String userId;
@override final  String nonce;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime expiresAt;
@override final  String? deviceId;
@override final  DateTime? respondedAt;

/// Create a copy of AuthChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthChallengeModelCopyWith<_AuthChallengeModel> get copyWith => __$AuthChallengeModelCopyWithImpl<_AuthChallengeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthChallengeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthChallengeModel&&(identical(other.challengeId, challengeId) || other.challengeId == challengeId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,challengeId,userId,nonce,status,createdAt,expiresAt,deviceId,respondedAt);

@override
String toString() {
  return 'AuthChallengeModel(challengeId: $challengeId, userId: $userId, nonce: $nonce, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, deviceId: $deviceId, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class _$AuthChallengeModelCopyWith<$Res> implements $AuthChallengeModelCopyWith<$Res> {
  factory _$AuthChallengeModelCopyWith(_AuthChallengeModel value, $Res Function(_AuthChallengeModel) _then) = __$AuthChallengeModelCopyWithImpl;
@override @useResult
$Res call({
 String challengeId, String userId, String nonce, String status, DateTime createdAt, DateTime expiresAt, String? deviceId, DateTime? respondedAt
});




}
/// @nodoc
class __$AuthChallengeModelCopyWithImpl<$Res>
    implements _$AuthChallengeModelCopyWith<$Res> {
  __$AuthChallengeModelCopyWithImpl(this._self, this._then);

  final _AuthChallengeModel _self;
  final $Res Function(_AuthChallengeModel) _then;

/// Create a copy of AuthChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? challengeId = null,Object? userId = null,Object? nonce = null,Object? status = null,Object? createdAt = null,Object? expiresAt = null,Object? deviceId = freezed,Object? respondedAt = freezed,}) {
  return _then(_AuthChallengeModel(
challengeId: null == challengeId ? _self.challengeId : challengeId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
