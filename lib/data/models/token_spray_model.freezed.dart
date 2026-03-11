// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_spray_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TokenSprayModel {

 String get id; String get communityId; String get communityName; String get messageId; String get creatorId; String get creatorName; String get recipientId; String get recipientName; String get occasion; String get occasionText; String get message; int? get targetAmount; int get currentTotal; Map<String, Map<String, dynamic>> get contributions; int get contributorCount; List<Map<String, dynamic>> get topContributors; String get status; DateTime get createdAt; DateTime? get closedAt; DateTime? get claimedAt; DateTime get expiresAt;
/// Create a copy of TokenSprayModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenSprayModelCopyWith<TokenSprayModel> get copyWith => _$TokenSprayModelCopyWithImpl<TokenSprayModel>(this as TokenSprayModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenSprayModel&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.communityName, communityName) || other.communityName == communityName)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.occasionText, occasionText) || other.occasionText == occasionText)&&(identical(other.message, message) || other.message == message)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.currentTotal, currentTotal) || other.currentTotal == currentTotal)&&const DeepCollectionEquality().equals(other.contributions, contributions)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&const DeepCollectionEquality().equals(other.topContributors, topContributors)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,communityId,communityName,messageId,creatorId,creatorName,recipientId,recipientName,occasion,occasionText,message,targetAmount,currentTotal,const DeepCollectionEquality().hash(contributions),contributorCount,const DeepCollectionEquality().hash(topContributors),status,createdAt,closedAt,claimedAt,expiresAt]);

@override
String toString() {
  return 'TokenSprayModel(id: $id, communityId: $communityId, communityName: $communityName, messageId: $messageId, creatorId: $creatorId, creatorName: $creatorName, recipientId: $recipientId, recipientName: $recipientName, occasion: $occasion, occasionText: $occasionText, message: $message, targetAmount: $targetAmount, currentTotal: $currentTotal, contributions: $contributions, contributorCount: $contributorCount, topContributors: $topContributors, status: $status, createdAt: $createdAt, closedAt: $closedAt, claimedAt: $claimedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $TokenSprayModelCopyWith<$Res>  {
  factory $TokenSprayModelCopyWith(TokenSprayModel value, $Res Function(TokenSprayModel) _then) = _$TokenSprayModelCopyWithImpl;
@useResult
$Res call({
 String id, String communityId, String communityName, String messageId, String creatorId, String creatorName, String recipientId, String recipientName, String occasion, String occasionText, String message, int? targetAmount, int currentTotal, Map<String, Map<String, dynamic>> contributions, int contributorCount, List<Map<String, dynamic>> topContributors, String status, DateTime createdAt, DateTime? closedAt, DateTime? claimedAt, DateTime expiresAt
});




}
/// @nodoc
class _$TokenSprayModelCopyWithImpl<$Res>
    implements $TokenSprayModelCopyWith<$Res> {
  _$TokenSprayModelCopyWithImpl(this._self, this._then);

  final TokenSprayModel _self;
  final $Res Function(TokenSprayModel) _then;

/// Create a copy of TokenSprayModel
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
as String,occasionText: null == occasionText ? _self.occasionText : occasionText // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as int?,currentTotal: null == currentTotal ? _self.currentTotal : currentTotal // ignore: cast_nullable_to_non_nullable
as int,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,topContributors: null == topContributors ? _self.topContributors : topContributors // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenSprayModel].
extension TokenSprayModelPatterns on TokenSprayModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenSprayModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenSprayModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenSprayModel value)  $default,){
final _that = this;
switch (_that) {
case _TokenSprayModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenSprayModel value)?  $default,){
final _that = this;
switch (_that) {
case _TokenSprayModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String communityId,  String communityName,  String messageId,  String creatorId,  String creatorName,  String recipientId,  String recipientName,  String occasion,  String occasionText,  String message,  int? targetAmount,  int currentTotal,  Map<String, Map<String, dynamic>> contributions,  int contributorCount,  List<Map<String, dynamic>> topContributors,  String status,  DateTime createdAt,  DateTime? closedAt,  DateTime? claimedAt,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenSprayModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String communityId,  String communityName,  String messageId,  String creatorId,  String creatorName,  String recipientId,  String recipientName,  String occasion,  String occasionText,  String message,  int? targetAmount,  int currentTotal,  Map<String, Map<String, dynamic>> contributions,  int contributorCount,  List<Map<String, dynamic>> topContributors,  String status,  DateTime createdAt,  DateTime? closedAt,  DateTime? claimedAt,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _TokenSprayModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String communityId,  String communityName,  String messageId,  String creatorId,  String creatorName,  String recipientId,  String recipientName,  String occasion,  String occasionText,  String message,  int? targetAmount,  int currentTotal,  Map<String, Map<String, dynamic>> contributions,  int contributorCount,  List<Map<String, dynamic>> topContributors,  String status,  DateTime createdAt,  DateTime? closedAt,  DateTime? claimedAt,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _TokenSprayModel() when $default != null:
return $default(_that.id,_that.communityId,_that.communityName,_that.messageId,_that.creatorId,_that.creatorName,_that.recipientId,_that.recipientName,_that.occasion,_that.occasionText,_that.message,_that.targetAmount,_that.currentTotal,_that.contributions,_that.contributorCount,_that.topContributors,_that.status,_that.createdAt,_that.closedAt,_that.claimedAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _TokenSprayModel extends TokenSprayModel {
  const _TokenSprayModel({required this.id, required this.communityId, required this.communityName, required this.messageId, required this.creatorId, required this.creatorName, required this.recipientId, required this.recipientName, required this.occasion, required this.occasionText, required this.message, this.targetAmount, required this.currentTotal, required final  Map<String, Map<String, dynamic>> contributions, required this.contributorCount, final  List<Map<String, dynamic>> topContributors = const [], required this.status, required this.createdAt, this.closedAt, this.claimedAt, required this.expiresAt}): _contributions = contributions,_topContributors = topContributors,super._();
  

@override final  String id;
@override final  String communityId;
@override final  String communityName;
@override final  String messageId;
@override final  String creatorId;
@override final  String creatorName;
@override final  String recipientId;
@override final  String recipientName;
@override final  String occasion;
@override final  String occasionText;
@override final  String message;
@override final  int? targetAmount;
@override final  int currentTotal;
 final  Map<String, Map<String, dynamic>> _contributions;
@override Map<String, Map<String, dynamic>> get contributions {
  if (_contributions is EqualUnmodifiableMapView) return _contributions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_contributions);
}

@override final  int contributorCount;
 final  List<Map<String, dynamic>> _topContributors;
@override@JsonKey() List<Map<String, dynamic>> get topContributors {
  if (_topContributors is EqualUnmodifiableListView) return _topContributors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topContributors);
}

@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime? closedAt;
@override final  DateTime? claimedAt;
@override final  DateTime expiresAt;

/// Create a copy of TokenSprayModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenSprayModelCopyWith<_TokenSprayModel> get copyWith => __$TokenSprayModelCopyWithImpl<_TokenSprayModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenSprayModel&&(identical(other.id, id) || other.id == id)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.communityName, communityName) || other.communityName == communityName)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.creatorName, creatorName) || other.creatorName == creatorName)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.occasionText, occasionText) || other.occasionText == occasionText)&&(identical(other.message, message) || other.message == message)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.currentTotal, currentTotal) || other.currentTotal == currentTotal)&&const DeepCollectionEquality().equals(other._contributions, _contributions)&&(identical(other.contributorCount, contributorCount) || other.contributorCount == contributorCount)&&const DeepCollectionEquality().equals(other._topContributors, _topContributors)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.claimedAt, claimedAt) || other.claimedAt == claimedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,communityId,communityName,messageId,creatorId,creatorName,recipientId,recipientName,occasion,occasionText,message,targetAmount,currentTotal,const DeepCollectionEquality().hash(_contributions),contributorCount,const DeepCollectionEquality().hash(_topContributors),status,createdAt,closedAt,claimedAt,expiresAt]);

@override
String toString() {
  return 'TokenSprayModel(id: $id, communityId: $communityId, communityName: $communityName, messageId: $messageId, creatorId: $creatorId, creatorName: $creatorName, recipientId: $recipientId, recipientName: $recipientName, occasion: $occasion, occasionText: $occasionText, message: $message, targetAmount: $targetAmount, currentTotal: $currentTotal, contributions: $contributions, contributorCount: $contributorCount, topContributors: $topContributors, status: $status, createdAt: $createdAt, closedAt: $closedAt, claimedAt: $claimedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$TokenSprayModelCopyWith<$Res> implements $TokenSprayModelCopyWith<$Res> {
  factory _$TokenSprayModelCopyWith(_TokenSprayModel value, $Res Function(_TokenSprayModel) _then) = __$TokenSprayModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String communityId, String communityName, String messageId, String creatorId, String creatorName, String recipientId, String recipientName, String occasion, String occasionText, String message, int? targetAmount, int currentTotal, Map<String, Map<String, dynamic>> contributions, int contributorCount, List<Map<String, dynamic>> topContributors, String status, DateTime createdAt, DateTime? closedAt, DateTime? claimedAt, DateTime expiresAt
});




}
/// @nodoc
class __$TokenSprayModelCopyWithImpl<$Res>
    implements _$TokenSprayModelCopyWith<$Res> {
  __$TokenSprayModelCopyWithImpl(this._self, this._then);

  final _TokenSprayModel _self;
  final $Res Function(_TokenSprayModel) _then;

/// Create a copy of TokenSprayModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityId = null,Object? communityName = null,Object? messageId = null,Object? creatorId = null,Object? creatorName = null,Object? recipientId = null,Object? recipientName = null,Object? occasion = null,Object? occasionText = null,Object? message = null,Object? targetAmount = freezed,Object? currentTotal = null,Object? contributions = null,Object? contributorCount = null,Object? topContributors = null,Object? status = null,Object? createdAt = null,Object? closedAt = freezed,Object? claimedAt = freezed,Object? expiresAt = null,}) {
  return _then(_TokenSprayModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,communityName: null == communityName ? _self.communityName : communityName // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,creatorName: null == creatorName ? _self.creatorName : creatorName // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,occasion: null == occasion ? _self.occasion : occasion // ignore: cast_nullable_to_non_nullable
as String,occasionText: null == occasionText ? _self.occasionText : occasionText // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as int?,currentTotal: null == currentTotal ? _self.currentTotal : currentTotal // ignore: cast_nullable_to_non_nullable
as int,contributions: null == contributions ? _self._contributions : contributions // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,contributorCount: null == contributorCount ? _self.contributorCount : contributorCount // ignore: cast_nullable_to_non_nullable
as int,topContributors: null == topContributors ? _self._topContributors : topContributors // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,claimedAt: freezed == claimedAt ? _self.claimedAt : claimedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
