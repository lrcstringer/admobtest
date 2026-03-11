// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Referral {

 String get id; String get referrerUserId; String get refereeUserId; String? get refereeDisplayName; String? get refereeUsername; String? get refereeAvatarUrl; ReferralStatus get status; String get referralCode; int? get referrerReward; int? get refereeReward; DateTime get createdAt; DateTime? get registeredAt; DateTime? get qualifiedAt; DateTime? get rewardedAt; DateTime? get expiresAt;
/// Create a copy of Referral
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferralCopyWith<Referral> get copyWith => _$ReferralCopyWithImpl<Referral>(this as Referral, _$identity);

  /// Serializes this Referral to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Referral&&(identical(other.id, id) || other.id == id)&&(identical(other.referrerUserId, referrerUserId) || other.referrerUserId == referrerUserId)&&(identical(other.refereeUserId, refereeUserId) || other.refereeUserId == refereeUserId)&&(identical(other.refereeDisplayName, refereeDisplayName) || other.refereeDisplayName == refereeDisplayName)&&(identical(other.refereeUsername, refereeUsername) || other.refereeUsername == refereeUsername)&&(identical(other.refereeAvatarUrl, refereeAvatarUrl) || other.refereeAvatarUrl == refereeAvatarUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.referrerReward, referrerReward) || other.referrerReward == referrerReward)&&(identical(other.refereeReward, refereeReward) || other.refereeReward == refereeReward)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.qualifiedAt, qualifiedAt) || other.qualifiedAt == qualifiedAt)&&(identical(other.rewardedAt, rewardedAt) || other.rewardedAt == rewardedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referrerUserId,refereeUserId,refereeDisplayName,refereeUsername,refereeAvatarUrl,status,referralCode,referrerReward,refereeReward,createdAt,registeredAt,qualifiedAt,rewardedAt,expiresAt);

@override
String toString() {
  return 'Referral(id: $id, referrerUserId: $referrerUserId, refereeUserId: $refereeUserId, refereeDisplayName: $refereeDisplayName, refereeUsername: $refereeUsername, refereeAvatarUrl: $refereeAvatarUrl, status: $status, referralCode: $referralCode, referrerReward: $referrerReward, refereeReward: $refereeReward, createdAt: $createdAt, registeredAt: $registeredAt, qualifiedAt: $qualifiedAt, rewardedAt: $rewardedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $ReferralCopyWith<$Res>  {
  factory $ReferralCopyWith(Referral value, $Res Function(Referral) _then) = _$ReferralCopyWithImpl;
@useResult
$Res call({
 String id, String referrerUserId, String refereeUserId, String? refereeDisplayName, String? refereeUsername, String? refereeAvatarUrl, ReferralStatus status, String referralCode, int? referrerReward, int? refereeReward, DateTime createdAt, DateTime? registeredAt, DateTime? qualifiedAt, DateTime? rewardedAt, DateTime? expiresAt
});




}
/// @nodoc
class _$ReferralCopyWithImpl<$Res>
    implements $ReferralCopyWith<$Res> {
  _$ReferralCopyWithImpl(this._self, this._then);

  final Referral _self;
  final $Res Function(Referral) _then;

/// Create a copy of Referral
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? referrerUserId = null,Object? refereeUserId = null,Object? refereeDisplayName = freezed,Object? refereeUsername = freezed,Object? refereeAvatarUrl = freezed,Object? status = null,Object? referralCode = null,Object? referrerReward = freezed,Object? refereeReward = freezed,Object? createdAt = null,Object? registeredAt = freezed,Object? qualifiedAt = freezed,Object? rewardedAt = freezed,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referrerUserId: null == referrerUserId ? _self.referrerUserId : referrerUserId // ignore: cast_nullable_to_non_nullable
as String,refereeUserId: null == refereeUserId ? _self.refereeUserId : refereeUserId // ignore: cast_nullable_to_non_nullable
as String,refereeDisplayName: freezed == refereeDisplayName ? _self.refereeDisplayName : refereeDisplayName // ignore: cast_nullable_to_non_nullable
as String?,refereeUsername: freezed == refereeUsername ? _self.refereeUsername : refereeUsername // ignore: cast_nullable_to_non_nullable
as String?,refereeAvatarUrl: freezed == refereeAvatarUrl ? _self.refereeAvatarUrl : refereeAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReferralStatus,referralCode: null == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String,referrerReward: freezed == referrerReward ? _self.referrerReward : referrerReward // ignore: cast_nullable_to_non_nullable
as int?,refereeReward: freezed == refereeReward ? _self.refereeReward : refereeReward // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,registeredAt: freezed == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,qualifiedAt: freezed == qualifiedAt ? _self.qualifiedAt : qualifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rewardedAt: freezed == rewardedAt ? _self.rewardedAt : rewardedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Referral].
extension ReferralPatterns on Referral {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Referral value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Referral() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Referral value)  $default,){
final _that = this;
switch (_that) {
case _Referral():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Referral value)?  $default,){
final _that = this;
switch (_that) {
case _Referral() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String referrerUserId,  String refereeUserId,  String? refereeDisplayName,  String? refereeUsername,  String? refereeAvatarUrl,  ReferralStatus status,  String referralCode,  int? referrerReward,  int? refereeReward,  DateTime createdAt,  DateTime? registeredAt,  DateTime? qualifiedAt,  DateTime? rewardedAt,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Referral() when $default != null:
return $default(_that.id,_that.referrerUserId,_that.refereeUserId,_that.refereeDisplayName,_that.refereeUsername,_that.refereeAvatarUrl,_that.status,_that.referralCode,_that.referrerReward,_that.refereeReward,_that.createdAt,_that.registeredAt,_that.qualifiedAt,_that.rewardedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String referrerUserId,  String refereeUserId,  String? refereeDisplayName,  String? refereeUsername,  String? refereeAvatarUrl,  ReferralStatus status,  String referralCode,  int? referrerReward,  int? refereeReward,  DateTime createdAt,  DateTime? registeredAt,  DateTime? qualifiedAt,  DateTime? rewardedAt,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _Referral():
return $default(_that.id,_that.referrerUserId,_that.refereeUserId,_that.refereeDisplayName,_that.refereeUsername,_that.refereeAvatarUrl,_that.status,_that.referralCode,_that.referrerReward,_that.refereeReward,_that.createdAt,_that.registeredAt,_that.qualifiedAt,_that.rewardedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String referrerUserId,  String refereeUserId,  String? refereeDisplayName,  String? refereeUsername,  String? refereeAvatarUrl,  ReferralStatus status,  String referralCode,  int? referrerReward,  int? refereeReward,  DateTime createdAt,  DateTime? registeredAt,  DateTime? qualifiedAt,  DateTime? rewardedAt,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _Referral() when $default != null:
return $default(_that.id,_that.referrerUserId,_that.refereeUserId,_that.refereeDisplayName,_that.refereeUsername,_that.refereeAvatarUrl,_that.status,_that.referralCode,_that.referrerReward,_that.refereeReward,_that.createdAt,_that.registeredAt,_that.qualifiedAt,_that.rewardedAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Referral extends Referral {
  const _Referral({required this.id, required this.referrerUserId, required this.refereeUserId, this.refereeDisplayName, this.refereeUsername, this.refereeAvatarUrl, required this.status, required this.referralCode, this.referrerReward, this.refereeReward, required this.createdAt, this.registeredAt, this.qualifiedAt, this.rewardedAt, this.expiresAt}): super._();
  factory _Referral.fromJson(Map<String, dynamic> json) => _$ReferralFromJson(json);

@override final  String id;
@override final  String referrerUserId;
@override final  String refereeUserId;
@override final  String? refereeDisplayName;
@override final  String? refereeUsername;
@override final  String? refereeAvatarUrl;
@override final  ReferralStatus status;
@override final  String referralCode;
@override final  int? referrerReward;
@override final  int? refereeReward;
@override final  DateTime createdAt;
@override final  DateTime? registeredAt;
@override final  DateTime? qualifiedAt;
@override final  DateTime? rewardedAt;
@override final  DateTime? expiresAt;

/// Create a copy of Referral
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferralCopyWith<_Referral> get copyWith => __$ReferralCopyWithImpl<_Referral>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferralToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Referral&&(identical(other.id, id) || other.id == id)&&(identical(other.referrerUserId, referrerUserId) || other.referrerUserId == referrerUserId)&&(identical(other.refereeUserId, refereeUserId) || other.refereeUserId == refereeUserId)&&(identical(other.refereeDisplayName, refereeDisplayName) || other.refereeDisplayName == refereeDisplayName)&&(identical(other.refereeUsername, refereeUsername) || other.refereeUsername == refereeUsername)&&(identical(other.refereeAvatarUrl, refereeAvatarUrl) || other.refereeAvatarUrl == refereeAvatarUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.referrerReward, referrerReward) || other.referrerReward == referrerReward)&&(identical(other.refereeReward, refereeReward) || other.refereeReward == refereeReward)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.qualifiedAt, qualifiedAt) || other.qualifiedAt == qualifiedAt)&&(identical(other.rewardedAt, rewardedAt) || other.rewardedAt == rewardedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,referrerUserId,refereeUserId,refereeDisplayName,refereeUsername,refereeAvatarUrl,status,referralCode,referrerReward,refereeReward,createdAt,registeredAt,qualifiedAt,rewardedAt,expiresAt);

@override
String toString() {
  return 'Referral(id: $id, referrerUserId: $referrerUserId, refereeUserId: $refereeUserId, refereeDisplayName: $refereeDisplayName, refereeUsername: $refereeUsername, refereeAvatarUrl: $refereeAvatarUrl, status: $status, referralCode: $referralCode, referrerReward: $referrerReward, refereeReward: $refereeReward, createdAt: $createdAt, registeredAt: $registeredAt, qualifiedAt: $qualifiedAt, rewardedAt: $rewardedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$ReferralCopyWith<$Res> implements $ReferralCopyWith<$Res> {
  factory _$ReferralCopyWith(_Referral value, $Res Function(_Referral) _then) = __$ReferralCopyWithImpl;
@override @useResult
$Res call({
 String id, String referrerUserId, String refereeUserId, String? refereeDisplayName, String? refereeUsername, String? refereeAvatarUrl, ReferralStatus status, String referralCode, int? referrerReward, int? refereeReward, DateTime createdAt, DateTime? registeredAt, DateTime? qualifiedAt, DateTime? rewardedAt, DateTime? expiresAt
});




}
/// @nodoc
class __$ReferralCopyWithImpl<$Res>
    implements _$ReferralCopyWith<$Res> {
  __$ReferralCopyWithImpl(this._self, this._then);

  final _Referral _self;
  final $Res Function(_Referral) _then;

/// Create a copy of Referral
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? referrerUserId = null,Object? refereeUserId = null,Object? refereeDisplayName = freezed,Object? refereeUsername = freezed,Object? refereeAvatarUrl = freezed,Object? status = null,Object? referralCode = null,Object? referrerReward = freezed,Object? refereeReward = freezed,Object? createdAt = null,Object? registeredAt = freezed,Object? qualifiedAt = freezed,Object? rewardedAt = freezed,Object? expiresAt = freezed,}) {
  return _then(_Referral(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,referrerUserId: null == referrerUserId ? _self.referrerUserId : referrerUserId // ignore: cast_nullable_to_non_nullable
as String,refereeUserId: null == refereeUserId ? _self.refereeUserId : refereeUserId // ignore: cast_nullable_to_non_nullable
as String,refereeDisplayName: freezed == refereeDisplayName ? _self.refereeDisplayName : refereeDisplayName // ignore: cast_nullable_to_non_nullable
as String?,refereeUsername: freezed == refereeUsername ? _self.refereeUsername : refereeUsername // ignore: cast_nullable_to_non_nullable
as String?,refereeAvatarUrl: freezed == refereeAvatarUrl ? _self.refereeAvatarUrl : refereeAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReferralStatus,referralCode: null == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String,referrerReward: freezed == referrerReward ? _self.referrerReward : referrerReward // ignore: cast_nullable_to_non_nullable
as int?,refereeReward: freezed == refereeReward ? _self.refereeReward : refereeReward // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,registeredAt: freezed == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,qualifiedAt: freezed == qualifiedAt ? _self.qualifiedAt : qualifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rewardedAt: freezed == rewardedAt ? _self.rewardedAt : rewardedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ReferralStats {

 int get totalReferrals; int get pendingReferrals; int get completedReferrals; int get totalEarned; String get referralCode; String get referralLink;
/// Create a copy of ReferralStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferralStatsCopyWith<ReferralStats> get copyWith => _$ReferralStatsCopyWithImpl<ReferralStats>(this as ReferralStats, _$identity);

  /// Serializes this ReferralStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferralStats&&(identical(other.totalReferrals, totalReferrals) || other.totalReferrals == totalReferrals)&&(identical(other.pendingReferrals, pendingReferrals) || other.pendingReferrals == pendingReferrals)&&(identical(other.completedReferrals, completedReferrals) || other.completedReferrals == completedReferrals)&&(identical(other.totalEarned, totalEarned) || other.totalEarned == totalEarned)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.referralLink, referralLink) || other.referralLink == referralLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalReferrals,pendingReferrals,completedReferrals,totalEarned,referralCode,referralLink);

@override
String toString() {
  return 'ReferralStats(totalReferrals: $totalReferrals, pendingReferrals: $pendingReferrals, completedReferrals: $completedReferrals, totalEarned: $totalEarned, referralCode: $referralCode, referralLink: $referralLink)';
}


}

/// @nodoc
abstract mixin class $ReferralStatsCopyWith<$Res>  {
  factory $ReferralStatsCopyWith(ReferralStats value, $Res Function(ReferralStats) _then) = _$ReferralStatsCopyWithImpl;
@useResult
$Res call({
 int totalReferrals, int pendingReferrals, int completedReferrals, int totalEarned, String referralCode, String referralLink
});




}
/// @nodoc
class _$ReferralStatsCopyWithImpl<$Res>
    implements $ReferralStatsCopyWith<$Res> {
  _$ReferralStatsCopyWithImpl(this._self, this._then);

  final ReferralStats _self;
  final $Res Function(ReferralStats) _then;

/// Create a copy of ReferralStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalReferrals = null,Object? pendingReferrals = null,Object? completedReferrals = null,Object? totalEarned = null,Object? referralCode = null,Object? referralLink = null,}) {
  return _then(_self.copyWith(
totalReferrals: null == totalReferrals ? _self.totalReferrals : totalReferrals // ignore: cast_nullable_to_non_nullable
as int,pendingReferrals: null == pendingReferrals ? _self.pendingReferrals : pendingReferrals // ignore: cast_nullable_to_non_nullable
as int,completedReferrals: null == completedReferrals ? _self.completedReferrals : completedReferrals // ignore: cast_nullable_to_non_nullable
as int,totalEarned: null == totalEarned ? _self.totalEarned : totalEarned // ignore: cast_nullable_to_non_nullable
as int,referralCode: null == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String,referralLink: null == referralLink ? _self.referralLink : referralLink // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReferralStats].
extension ReferralStatsPatterns on ReferralStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReferralStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReferralStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReferralStats value)  $default,){
final _that = this;
switch (_that) {
case _ReferralStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReferralStats value)?  $default,){
final _that = this;
switch (_that) {
case _ReferralStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalReferrals,  int pendingReferrals,  int completedReferrals,  int totalEarned,  String referralCode,  String referralLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReferralStats() when $default != null:
return $default(_that.totalReferrals,_that.pendingReferrals,_that.completedReferrals,_that.totalEarned,_that.referralCode,_that.referralLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalReferrals,  int pendingReferrals,  int completedReferrals,  int totalEarned,  String referralCode,  String referralLink)  $default,) {final _that = this;
switch (_that) {
case _ReferralStats():
return $default(_that.totalReferrals,_that.pendingReferrals,_that.completedReferrals,_that.totalEarned,_that.referralCode,_that.referralLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalReferrals,  int pendingReferrals,  int completedReferrals,  int totalEarned,  String referralCode,  String referralLink)?  $default,) {final _that = this;
switch (_that) {
case _ReferralStats() when $default != null:
return $default(_that.totalReferrals,_that.pendingReferrals,_that.completedReferrals,_that.totalEarned,_that.referralCode,_that.referralLink);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReferralStats implements ReferralStats {
  const _ReferralStats({required this.totalReferrals, required this.pendingReferrals, required this.completedReferrals, required this.totalEarned, required this.referralCode, required this.referralLink});
  factory _ReferralStats.fromJson(Map<String, dynamic> json) => _$ReferralStatsFromJson(json);

@override final  int totalReferrals;
@override final  int pendingReferrals;
@override final  int completedReferrals;
@override final  int totalEarned;
@override final  String referralCode;
@override final  String referralLink;

/// Create a copy of ReferralStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferralStatsCopyWith<_ReferralStats> get copyWith => __$ReferralStatsCopyWithImpl<_ReferralStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReferralStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferralStats&&(identical(other.totalReferrals, totalReferrals) || other.totalReferrals == totalReferrals)&&(identical(other.pendingReferrals, pendingReferrals) || other.pendingReferrals == pendingReferrals)&&(identical(other.completedReferrals, completedReferrals) || other.completedReferrals == completedReferrals)&&(identical(other.totalEarned, totalEarned) || other.totalEarned == totalEarned)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.referralLink, referralLink) || other.referralLink == referralLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalReferrals,pendingReferrals,completedReferrals,totalEarned,referralCode,referralLink);

@override
String toString() {
  return 'ReferralStats(totalReferrals: $totalReferrals, pendingReferrals: $pendingReferrals, completedReferrals: $completedReferrals, totalEarned: $totalEarned, referralCode: $referralCode, referralLink: $referralLink)';
}


}

/// @nodoc
abstract mixin class _$ReferralStatsCopyWith<$Res> implements $ReferralStatsCopyWith<$Res> {
  factory _$ReferralStatsCopyWith(_ReferralStats value, $Res Function(_ReferralStats) _then) = __$ReferralStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalReferrals, int pendingReferrals, int completedReferrals, int totalEarned, String referralCode, String referralLink
});




}
/// @nodoc
class __$ReferralStatsCopyWithImpl<$Res>
    implements _$ReferralStatsCopyWith<$Res> {
  __$ReferralStatsCopyWithImpl(this._self, this._then);

  final _ReferralStats _self;
  final $Res Function(_ReferralStats) _then;

/// Create a copy of ReferralStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalReferrals = null,Object? pendingReferrals = null,Object? completedReferrals = null,Object? totalEarned = null,Object? referralCode = null,Object? referralLink = null,}) {
  return _then(_ReferralStats(
totalReferrals: null == totalReferrals ? _self.totalReferrals : totalReferrals // ignore: cast_nullable_to_non_nullable
as int,pendingReferrals: null == pendingReferrals ? _self.pendingReferrals : pendingReferrals // ignore: cast_nullable_to_non_nullable
as int,completedReferrals: null == completedReferrals ? _self.completedReferrals : completedReferrals // ignore: cast_nullable_to_non_nullable
as int,totalEarned: null == totalEarned ? _self.totalEarned : totalEarned // ignore: cast_nullable_to_non_nullable
as int,referralCode: null == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String,referralLink: null == referralLink ? _self.referralLink : referralLink // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
