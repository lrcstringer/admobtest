// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_buy_contribution_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupBuyContributionModel {

 String get id; String get userId; String get userName; int get amount; String? get journalId; String? get deliveryAddress; DateTime get contributedAt; String? get voucherCode; bool get hasCollected; DateTime? get collectedAt; String get walletId;
/// Create a copy of GroupBuyContributionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupBuyContributionModelCopyWith<GroupBuyContributionModel> get copyWith => _$GroupBuyContributionModelCopyWithImpl<GroupBuyContributionModel>(this as GroupBuyContributionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupBuyContributionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.contributedAt, contributedAt) || other.contributedAt == contributedAt)&&(identical(other.voucherCode, voucherCode) || other.voucherCode == voucherCode)&&(identical(other.hasCollected, hasCollected) || other.hasCollected == hasCollected)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt)&&(identical(other.walletId, walletId) || other.walletId == walletId));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,amount,journalId,deliveryAddress,contributedAt,voucherCode,hasCollected,collectedAt,walletId);

@override
String toString() {
  return 'GroupBuyContributionModel(id: $id, userId: $userId, userName: $userName, amount: $amount, journalId: $journalId, deliveryAddress: $deliveryAddress, contributedAt: $contributedAt, voucherCode: $voucherCode, hasCollected: $hasCollected, collectedAt: $collectedAt, walletId: $walletId)';
}


}

/// @nodoc
abstract mixin class $GroupBuyContributionModelCopyWith<$Res>  {
  factory $GroupBuyContributionModelCopyWith(GroupBuyContributionModel value, $Res Function(GroupBuyContributionModel) _then) = _$GroupBuyContributionModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String userName, int amount, String? journalId, String? deliveryAddress, DateTime contributedAt, String? voucherCode, bool hasCollected, DateTime? collectedAt, String walletId
});




}
/// @nodoc
class _$GroupBuyContributionModelCopyWithImpl<$Res>
    implements $GroupBuyContributionModelCopyWith<$Res> {
  _$GroupBuyContributionModelCopyWithImpl(this._self, this._then);

  final GroupBuyContributionModel _self;
  final $Res Function(GroupBuyContributionModel) _then;

/// Create a copy of GroupBuyContributionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? amount = null,Object? journalId = freezed,Object? deliveryAddress = freezed,Object? contributedAt = null,Object? voucherCode = freezed,Object? hasCollected = null,Object? collectedAt = freezed,Object? walletId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,deliveryAddress: freezed == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String?,contributedAt: null == contributedAt ? _self.contributedAt : contributedAt // ignore: cast_nullable_to_non_nullable
as DateTime,voucherCode: freezed == voucherCode ? _self.voucherCode : voucherCode // ignore: cast_nullable_to_non_nullable
as String?,hasCollected: null == hasCollected ? _self.hasCollected : hasCollected // ignore: cast_nullable_to_non_nullable
as bool,collectedAt: freezed == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,walletId: null == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupBuyContributionModel].
extension GroupBuyContributionModelPatterns on GroupBuyContributionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupBuyContributionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupBuyContributionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupBuyContributionModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupBuyContributionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupBuyContributionModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupBuyContributionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  int amount,  String? journalId,  String? deliveryAddress,  DateTime contributedAt,  String? voucherCode,  bool hasCollected,  DateTime? collectedAt,  String walletId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupBuyContributionModel() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.amount,_that.journalId,_that.deliveryAddress,_that.contributedAt,_that.voucherCode,_that.hasCollected,_that.collectedAt,_that.walletId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  int amount,  String? journalId,  String? deliveryAddress,  DateTime contributedAt,  String? voucherCode,  bool hasCollected,  DateTime? collectedAt,  String walletId)  $default,) {final _that = this;
switch (_that) {
case _GroupBuyContributionModel():
return $default(_that.id,_that.userId,_that.userName,_that.amount,_that.journalId,_that.deliveryAddress,_that.contributedAt,_that.voucherCode,_that.hasCollected,_that.collectedAt,_that.walletId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String userName,  int amount,  String? journalId,  String? deliveryAddress,  DateTime contributedAt,  String? voucherCode,  bool hasCollected,  DateTime? collectedAt,  String walletId)?  $default,) {final _that = this;
switch (_that) {
case _GroupBuyContributionModel() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.amount,_that.journalId,_that.deliveryAddress,_that.contributedAt,_that.voucherCode,_that.hasCollected,_that.collectedAt,_that.walletId);case _:
  return null;

}
}

}

/// @nodoc


class _GroupBuyContributionModel extends GroupBuyContributionModel {
  const _GroupBuyContributionModel({required this.id, required this.userId, required this.userName, required this.amount, this.journalId, this.deliveryAddress, required this.contributedAt, this.voucherCode, this.hasCollected = false, this.collectedAt, this.walletId = 'primary'}): super._();
  

@override final  String id;
@override final  String userId;
@override final  String userName;
@override final  int amount;
@override final  String? journalId;
@override final  String? deliveryAddress;
@override final  DateTime contributedAt;
@override final  String? voucherCode;
@override@JsonKey() final  bool hasCollected;
@override final  DateTime? collectedAt;
@override@JsonKey() final  String walletId;

/// Create a copy of GroupBuyContributionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupBuyContributionModelCopyWith<_GroupBuyContributionModel> get copyWith => __$GroupBuyContributionModelCopyWithImpl<_GroupBuyContributionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupBuyContributionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.journalId, journalId) || other.journalId == journalId)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.contributedAt, contributedAt) || other.contributedAt == contributedAt)&&(identical(other.voucherCode, voucherCode) || other.voucherCode == voucherCode)&&(identical(other.hasCollected, hasCollected) || other.hasCollected == hasCollected)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt)&&(identical(other.walletId, walletId) || other.walletId == walletId));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,amount,journalId,deliveryAddress,contributedAt,voucherCode,hasCollected,collectedAt,walletId);

@override
String toString() {
  return 'GroupBuyContributionModel(id: $id, userId: $userId, userName: $userName, amount: $amount, journalId: $journalId, deliveryAddress: $deliveryAddress, contributedAt: $contributedAt, voucherCode: $voucherCode, hasCollected: $hasCollected, collectedAt: $collectedAt, walletId: $walletId)';
}


}

/// @nodoc
abstract mixin class _$GroupBuyContributionModelCopyWith<$Res> implements $GroupBuyContributionModelCopyWith<$Res> {
  factory _$GroupBuyContributionModelCopyWith(_GroupBuyContributionModel value, $Res Function(_GroupBuyContributionModel) _then) = __$GroupBuyContributionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String userName, int amount, String? journalId, String? deliveryAddress, DateTime contributedAt, String? voucherCode, bool hasCollected, DateTime? collectedAt, String walletId
});




}
/// @nodoc
class __$GroupBuyContributionModelCopyWithImpl<$Res>
    implements _$GroupBuyContributionModelCopyWith<$Res> {
  __$GroupBuyContributionModelCopyWithImpl(this._self, this._then);

  final _GroupBuyContributionModel _self;
  final $Res Function(_GroupBuyContributionModel) _then;

/// Create a copy of GroupBuyContributionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? amount = null,Object? journalId = freezed,Object? deliveryAddress = freezed,Object? contributedAt = null,Object? voucherCode = freezed,Object? hasCollected = null,Object? collectedAt = freezed,Object? walletId = null,}) {
  return _then(_GroupBuyContributionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,journalId: freezed == journalId ? _self.journalId : journalId // ignore: cast_nullable_to_non_nullable
as String?,deliveryAddress: freezed == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String?,contributedAt: null == contributedAt ? _self.contributedAt : contributedAt // ignore: cast_nullable_to_non_nullable
as DateTime,voucherCode: freezed == voucherCode ? _self.voucherCode : voucherCode // ignore: cast_nullable_to_non_nullable
as String?,hasCollected: null == hasCollected ? _self.hasCollected : hasCollected // ignore: cast_nullable_to_non_nullable
as bool,collectedAt: freezed == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,walletId: null == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
