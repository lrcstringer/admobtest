// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_spray.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SprayContribution {

 int get amount; DateTime get contributedAt; String get displayName; String? get message;
/// Create a copy of SprayContribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SprayContributionCopyWith<SprayContribution> get copyWith => _$SprayContributionCopyWithImpl<SprayContribution>(this as SprayContribution, _$identity);

  /// Serializes this SprayContribution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SprayContribution&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.contributedAt, contributedAt) || other.contributedAt == contributedAt)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,contributedAt,displayName,message);

@override
String toString() {
  return 'SprayContribution(amount: $amount, contributedAt: $contributedAt, displayName: $displayName, message: $message)';
}


}

/// @nodoc
abstract mixin class $SprayContributionCopyWith<$Res>  {
  factory $SprayContributionCopyWith(SprayContribution value, $Res Function(SprayContribution) _then) = _$SprayContributionCopyWithImpl;
@useResult
$Res call({
 int amount, DateTime contributedAt, String displayName, String? message
});




}
/// @nodoc
class _$SprayContributionCopyWithImpl<$Res>
    implements $SprayContributionCopyWith<$Res> {
  _$SprayContributionCopyWithImpl(this._self, this._then);

  final SprayContribution _self;
  final $Res Function(SprayContribution) _then;

/// Create a copy of SprayContribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? contributedAt = null,Object? displayName = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,contributedAt: null == contributedAt ? _self.contributedAt : contributedAt // ignore: cast_nullable_to_non_nullable
as DateTime,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SprayContribution].
extension SprayContributionPatterns on SprayContribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SprayContribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SprayContribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SprayContribution value)  $default,){
final _that = this;
switch (_that) {
case _SprayContribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SprayContribution value)?  $default,){
final _that = this;
switch (_that) {
case _SprayContribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amount,  DateTime contributedAt,  String displayName,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SprayContribution() when $default != null:
return $default(_that.amount,_that.contributedAt,_that.displayName,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amount,  DateTime contributedAt,  String displayName,  String? message)  $default,) {final _that = this;
switch (_that) {
case _SprayContribution():
return $default(_that.amount,_that.contributedAt,_that.displayName,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amount,  DateTime contributedAt,  String displayName,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _SprayContribution() when $default != null:
return $default(_that.amount,_that.contributedAt,_that.displayName,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SprayContribution implements SprayContribution {
  const _SprayContribution({required this.amount, required this.contributedAt, required this.displayName, this.message});
  factory _SprayContribution.fromJson(Map<String, dynamic> json) => _$SprayContributionFromJson(json);

@override final  int amount;
@override final  DateTime contributedAt;
@override final  String displayName;
@override final  String? message;

/// Create a copy of SprayContribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SprayContributionCopyWith<_SprayContribution> get copyWith => __$SprayContributionCopyWithImpl<_SprayContribution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SprayContributionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SprayContribution&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.contributedAt, contributedAt) || other.contributedAt == contributedAt)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,contributedAt,displayName,message);

@override
String toString() {
  return 'SprayContribution(amount: $amount, contributedAt: $contributedAt, displayName: $displayName, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SprayContributionCopyWith<$Res> implements $SprayContributionCopyWith<$Res> {
  factory _$SprayContributionCopyWith(_SprayContribution value, $Res Function(_SprayContribution) _then) = __$SprayContributionCopyWithImpl;
@override @useResult
$Res call({
 int amount, DateTime contributedAt, String displayName, String? message
});




}
/// @nodoc
class __$SprayContributionCopyWithImpl<$Res>
    implements _$SprayContributionCopyWith<$Res> {
  __$SprayContributionCopyWithImpl(this._self, this._then);

  final _SprayContribution _self;
  final $Res Function(_SprayContribution) _then;

/// Create a copy of SprayContribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? contributedAt = null,Object? displayName = null,Object? message = freezed,}) {
  return _then(_SprayContribution(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,contributedAt: null == contributedAt ? _self.contributedAt : contributedAt // ignore: cast_nullable_to_non_nullable
as DateTime,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SprayTopContributor {

 String get userId; String get displayName; int get amount; int get rank;
/// Create a copy of SprayTopContributor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SprayTopContributorCopyWith<SprayTopContributor> get copyWith => _$SprayTopContributorCopyWithImpl<SprayTopContributor>(this as SprayTopContributor, _$identity);

  /// Serializes this SprayTopContributor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SprayTopContributor&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.rank, rank) || other.rank == rank));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,amount,rank);

@override
String toString() {
  return 'SprayTopContributor(userId: $userId, displayName: $displayName, amount: $amount, rank: $rank)';
}


}

/// @nodoc
abstract mixin class $SprayTopContributorCopyWith<$Res>  {
  factory $SprayTopContributorCopyWith(SprayTopContributor value, $Res Function(SprayTopContributor) _then) = _$SprayTopContributorCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, int amount, int rank
});




}
/// @nodoc
class _$SprayTopContributorCopyWithImpl<$Res>
    implements $SprayTopContributorCopyWith<$Res> {
  _$SprayTopContributorCopyWithImpl(this._self, this._then);

  final SprayTopContributor _self;
  final $Res Function(SprayTopContributor) _then;

/// Create a copy of SprayTopContributor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? amount = null,Object? rank = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SprayTopContributor].
extension SprayTopContributorPatterns on SprayTopContributor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SprayTopContributor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SprayTopContributor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SprayTopContributor value)  $default,){
final _that = this;
switch (_that) {
case _SprayTopContributor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SprayTopContributor value)?  $default,){
final _that = this;
switch (_that) {
case _SprayTopContributor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  int amount,  int rank)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SprayTopContributor() when $default != null:
return $default(_that.userId,_that.displayName,_that.amount,_that.rank);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  int amount,  int rank)  $default,) {final _that = this;
switch (_that) {
case _SprayTopContributor():
return $default(_that.userId,_that.displayName,_that.amount,_that.rank);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  int amount,  int rank)?  $default,) {final _that = this;
switch (_that) {
case _SprayTopContributor() when $default != null:
return $default(_that.userId,_that.displayName,_that.amount,_that.rank);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SprayTopContributor implements SprayTopContributor {
  const _SprayTopContributor({required this.userId, required this.displayName, required this.amount, required this.rank});
  factory _SprayTopContributor.fromJson(Map<String, dynamic> json) => _$SprayTopContributorFromJson(json);

@override final  String userId;
@override final  String displayName;
@override final  int amount;
@override final  int rank;

/// Create a copy of SprayTopContributor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SprayTopContributorCopyWith<_SprayTopContributor> get copyWith => __$SprayTopContributorCopyWithImpl<_SprayTopContributor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SprayTopContributorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SprayTopContributor&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.rank, rank) || other.rank == rank));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,displayName,amount,rank);

@override
String toString() {
  return 'SprayTopContributor(userId: $userId, displayName: $displayName, amount: $amount, rank: $rank)';
}


}

/// @nodoc
abstract mixin class _$SprayTopContributorCopyWith<$Res> implements $SprayTopContributorCopyWith<$Res> {
  factory _$SprayTopContributorCopyWith(_SprayTopContributor value, $Res Function(_SprayTopContributor) _then) = __$SprayTopContributorCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, int amount, int rank
});




}
/// @nodoc
class __$SprayTopContributorCopyWithImpl<$Res>
    implements _$SprayTopContributorCopyWith<$Res> {
  __$SprayTopContributorCopyWithImpl(this._self, this._then);

  final _SprayTopContributor _self;
  final $Res Function(_SprayTopContributor) _then;

/// Create a copy of SprayTopContributor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? amount = null,Object? rank = null,}) {
  return _then(_SprayTopContributor(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TokenSpray {

 String get id; String get communityId; String get communityName; String get messageId; String get creatorId; String get creatorName; String get recipientId; String get recipientName; SprayOccasion get occasion; String get occasionText; String get message; int? get targetAmount; int get currentTotal; Map<String, SprayContribution> get contributions; int get contributorCount; List<SprayTopContributor> get topContributors; SprayStatus get status; DateTime get createdAt; DateTime? get closedAt; DateTime? get claimedAt; DateTime get expiresAt;
/// Create a copy of TokenSpray
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenSprayCopyWith<TokenSpray> get copyWith => _$TokenSprayCopyWithImpl<TokenSpray>(this as TokenSpray, _$identity);

  /// Serializes this TokenSpray to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenSpray&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.communityName, communityName) || other.communityName == communityName)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.occasionText, occasionText) || other.occasionText == occasionText)&&(identical(other.message, message) || other.message == message)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.currentTotal, currentTotal) || other.currentTotal == currentTotal)&&const DeepCollectionEquality().equals(other.contributions, contributions)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&const DeepCollectionEquality().equals(other.topContributors, topContributors)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,communityId,communityName,messageId,creatorId,creatorName,recipientId,recipientName,occasion,occasionText,message,targetAmount,currentTotal,const DeepCollectionEquality().hash(contributions),contributorCount,const DeepCollectionEquality().hash(topContributors),status,createdAt,closedAt,claimedAt,expiresAt]);

@override
String toString() {
  return 'TokenSpray(id: $id, communityId: $communityId, communityName: $communityName, messageId: $messageId, creatorId: $creatorId, creatorName: $creatorName, recipientId: $recipientId, recipientName: $recipientName, occasion: $occasion, occasionText: $occasionText, message: $message, targetAmount: $targetAmount, currentTotal: $currentTotal, contributions: $contributions, contributorCount: $contributorCount, topContributors: $topContributors, status: $status, createdAt: $createdAt, closedAt: $closedAt, claimedAt: $claimedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $TokenSprayCopyWith<$Res>  {
  factory $TokenSprayCopyWith(TokenSpray value, $Res Function(TokenSpray) _then) = _$TokenSprayCopyWithImpl;
@useResult
$Res call({
 String id, String communityId, String communityName, String messageId, String creatorId, String creatorName, String recipientId, String recipientName, SprayOccasion occasion, String occasionText, String message, int? targetAmount, int currentTotal, Map<String, SprayContribution> contributions, int contributorCount, List<SprayTopContributor> topContributors, SprayStatus status, DateTime createdAt, DateTime? closedAt, DateTime? claimedAt, DateTime expiresAt
});




}
/// @nodoc
class _$TokenSprayCopyWithImpl<$Res>
    implements $TokenSprayCopyWith<$Res> {
  _$TokenSprayCopyWithImpl(this._self, this._then);

  final TokenSpray _self;
  final $Res Function(TokenSpray) _then;

/// Create a copy of TokenSpray
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityId = null,Object? communityName = null,Object? messageId = null,Object? creatorId = null,Object? creatorName = null,Object? recipientId = null,Object? recipientName = null,Object? occasion = null,Object? occasionText = null,Object? message = null,Object? targetAmount = freezed,Object? currentTotal = null,Object? contributions = null,Object? contributorCount = null,Object? topContributors = null,Object? status = null,Object? createdAt = null,Object? closedAt = freezed,Object? claimedAt = freezed,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,communityName: null == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,creatorName: null == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,occasion: null == occasion ? _self.occasion : occasion // ignore: cast_nullable_to_non_nullable
as SprayOccasion,occasionText: null == occasionText ? _self.occasionText : occasionText // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as int?,currentTotal: null == currentTotal ? _self.currentTotal : currentTotal // ignore: cast_nullable_to_non_nullable
as int,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as Map<String, SprayContribution>,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,topContributors: null == topContributors ? _self.topContributors : topContributors // ignore: cast_nullable_to_non_nullable
as List<SprayTopContributor>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SprayStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenSpray].
extension TokenSprayPatterns on TokenSpray {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenSpray value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenSpray() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenSpray value)  $default,){
final _that = this;
switch (_that) {
case _TokenSpray():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenSpray value)?  $default,){
final _that = this;
switch (_that) {
case _TokenSpray() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String communityId,  String communityName,  String messageId,  String creatorId,  String creatorName,  String recipientId,  String recipientName,  SprayOccasion occasion,  String occasionText,  String message,  int? targetAmount,  int currentTotal,  Map<String, SprayContribution> contributions,  int contributorCount,  List<SprayTopContributor> topContributors,  SprayStatus status,  DateTime createdAt,  DateTime? closedAt,  DateTime? claimedAt,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenSpray() when $default != null:
return $default(_that.id,_that.communityId,_that.communityName,_that.messageId,_that.creatorId,_that.creatorName,_that.recipientId,_that.recipientName,_that.occasion,_that.occasionText,_that.message,_that.targetAmount,_that.currentTotal,_that.contributions,_that.contributorCount,_that.topContributors,_that.status,_that.createdAt,_that.closedAt,_that.claimedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String communityId,  String communityName,  String messageId,  String creatorId,  String creatorName,  String recipientId,  String recipientName,  SprayOccasion occasion,  String occasionText,  String message,  int? targetAmount,  int currentTotal,  Map<String, SprayContribution> contributions,  int contributorCount,  List<SprayTopContributor> topContributors,  SprayStatus status,  DateTime createdAt,  DateTime? closedAt,  DateTime? claimedAt,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _TokenSpray():
return $default(_that.id,_that.communityId,_that.communityName,_that.messageId,_that.creatorId,_that.creatorName,_that.recipientId,_that.recipientName,_that.occasion,_that.occasionText,_that.message,_that.targetAmount,_that.currentTotal,_that.contributions,_that.contributorCount,_that.topContributors,_that.status,_that.createdAt,_that.closedAt,_that.claimedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String communityId,  String communityName,  String messageId,  String creatorId,  String creatorName,  String recipientId,  String recipientName,  SprayOccasion occasion,  String occasionText,  String message,  int? targetAmount,  int currentTotal,  Map<String, SprayContribution> contributions,  int contributorCount,  List<SprayTopContributor> topContributors,  SprayStatus status,  DateTime createdAt,  DateTime? closedAt,  DateTime? claimedAt,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _TokenSpray() when $default != null:
return $default(_that.id,_that.communityId,_that.communityName,_that.messageId,_that.creatorId,_that.creatorName,_that.recipientId,_that.recipientName,_that.occasion,_that.occasionText,_that.message,_that.targetAmount,_that.currentTotal,_that.contributions,_that.contributorCount,_that.topContributors,_that.status,_that.createdAt,_that.closedAt,_that.claimedAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenSpray extends TokenSpray {
  const _TokenSpray({required this.id, required this.communityId, required this.communityName, required this.messageId, required this.creatorId, required this.creatorName, required this.recipientId, required this.recipientName, required this.occasion, required this.occasionText, required this.message, this.targetAmount, required this.currentTotal, required final  Map<String, SprayContribution> contributions, required this.contributorCount, final  List<SprayTopContributor> topContributors = const [], required this.status, required this.createdAt, this.closedAt, this.claimedAt, required this.expiresAt}): _contributions = contributions,_topContributors = topContributors,super._();
  factory _TokenSpray.fromJson(Map<String, dynamic> json) => _$TokenSprayFromJson(json);

@override final  String id;
@override final  String communityId;
@override final  String communityName;
@override final  String messageId;
@override final  String creatorId;
@override final  String creatorName;
@override final  String recipientId;
@override final  String recipientName;
@override final  SprayOccasion occasion;
@override final  String occasionText;
@override final  String message;
@override final  int? targetAmount;
@override final  int currentTotal;
 final  Map<String, SprayContribution> _contributions;
@override Map<String, SprayContribution> get contributions {
  if (_contributions is EqualUnmodifiableMapView) return _contributions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_contributions);
}

@override final  int contributorCount;
 final  List<SprayTopContributor> _topContributors;
@override@JsonKey() List<SprayTopContributor> get topContributors {
  if (_topContributors is EqualUnmodifiableListView) return _topContributors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topContributors);
}

@override final  SprayStatus status;
@override final  DateTime createdAt;
@override final  DateTime? closedAt;
@override final  DateTime? claimedAt;
@override final  DateTime expiresAt;

/// Create a copy of TokenSpray
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenSprayCopyWith<_TokenSpray> get copyWith => __$TokenSprayCopyWithImpl<_TokenSpray>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenSprayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenSpray&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.communityName, communityName) || other.communityName == communityName)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.occasionText, occasionText) || other.occasionText == occasionText)&&(identical(other.message, message) || other.message == message)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.currentTotal, currentTotal) || other.currentTotal == currentTotal)&&const DeepCollectionEquality().equals(other._contributions, _contributions)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&const DeepCollectionEquality().equals(other._topContributors, _topContributors)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,communityId,communityName,messageId,creatorId,creatorName,recipientId,recipientName,occasion,occasionText,message,targetAmount,currentTotal,const DeepCollectionEquality().hash(_contributions),contributorCount,const DeepCollectionEquality().hash(_topContributors),status,createdAt,closedAt,claimedAt,expiresAt]);

@override
String toString() {
  return 'TokenSpray(id: $id, communityId: $communityId, communityName: $communityName, messageId: $messageId, creatorId: $creatorId, creatorName: $creatorName, recipientId: $recipientId, recipientName: $recipientName, occasion: $occasion, occasionText: $occasionText, message: $message, targetAmount: $targetAmount, currentTotal: $currentTotal, contributions: $contributions, contributorCount: $contributorCount, topContributors: $topContributors, status: $status, createdAt: $createdAt, closedAt: $closedAt, claimedAt: $claimedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$TokenSprayCopyWith<$Res> implements $TokenSprayCopyWith<$Res> {
  factory _$TokenSprayCopyWith(_TokenSpray value, $Res Function(_TokenSpray) _then) = __$TokenSprayCopyWithImpl;
@override @useResult
$Res call({
 String id, String communityId, String communityName, String messageId, String creatorId, String creatorName, String recipientId, String recipientName, SprayOccasion occasion, String occasionText, String message, int? targetAmount, int currentTotal, Map<String, SprayContribution> contributions, int contributorCount, List<SprayTopContributor> topContributors, SprayStatus status, DateTime createdAt, DateTime? closedAt, DateTime? claimedAt, DateTime expiresAt
});




}
/// @nodoc
class __$TokenSprayCopyWithImpl<$Res>
    implements _$TokenSprayCopyWith<$Res> {
  __$TokenSprayCopyWithImpl(this._self, this._then);

  final _TokenSpray _self;
  final $Res Function(_TokenSpray) _then;

/// Create a copy of TokenSpray
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? communityName = null,Object? messageId = null,Object? creatorId = null,Object? creatorName = null,Object? recipientId = null,Object? recipientName = null,Object? occasion = null,Object? occasionText = null,Object? message = null,Object? targetAmount = freezed,Object? currentTotal = null,Object? contributions = null,Object? contributorCount = null,Object? topContributors = null,Object? status = null,Object? createdAt = null,Object? closedAt = freezed,Object? claimedAt = freezed,Object? expiresAt = null,}) {
  return _then(_TokenSpray(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,communityName: null == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,creatorName: null == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,occasion: null == occasion ? _self.occasion : occasion // ignore: cast_nullable_to_non_nullable
as SprayOccasion,occasionText: null == occasionText ? _self.occasionText : occasionText // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as int?,currentTotal: null == currentTotal ? _self.currentTotal : currentTotal // ignore: cast_nullable_to_non_nullable
as int,contributions: null == contributions ? _self._contributions : contributions // ignore: cast_nullable_to_non_nullable
as Map<String, SprayContribution>,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,topContributors: null == topContributors ? _self._topContributors : topContributors // ignore: cast_nullable_to_non_nullable
as List<SprayTopContributor>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SprayStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
