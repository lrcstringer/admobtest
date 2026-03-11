// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cashout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CashoutModel {

 String get id; String get walletId; String get userId; int get tokenAmount; double get zarAmount; String get method; String get status; String get destinationDetails; String? get bankName; String? get accountNumber; String? get accountHolderName; String? get mobileNumber; String? get reference; String? get failureReason; DateTime get createdAt; DateTime? get processedAt; DateTime? get completedAt; DateTime? get failedAt;
/// Create a copy of CashoutModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashoutModelCopyWith<CashoutModel> get copyWith => _$CashoutModelCopyWithImpl<CashoutModel>(this as CashoutModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.zarAmount, zarAmount) || other.zarAmount == zarAmount)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&(identical(other.destinationDetails, destinationDetails) || other.destinationDetails == destinationDetails)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountHolderName, accountHolderName) || other.accountHolderName == accountHolderName)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,walletId,userId,tokenAmount,zarAmount,method,status,destinationDetails,bankName,accountNumber,accountHolderName,mobileNumber,reference,failureReason,createdAt,processedAt,completedAt,failedAt);

@override
String toString() {
  return 'CashoutModel(id: $id, walletId: $walletId, userId: $userId, tokenAmount: $tokenAmount, zarAmount: $zarAmount, method: $method, status: $status, destinationDetails: $destinationDetails, bankName: $bankName, accountNumber: $accountNumber, accountHolderName: $accountHolderName, mobileNumber: $mobileNumber, reference: $reference, failureReason: $failureReason, createdAt: $createdAt, processedAt: $processedAt, completedAt: $completedAt, failedAt: $failedAt)';
}


}

/// @nodoc
abstract mixin class $CashoutModelCopyWith<$Res>  {
  factory $CashoutModelCopyWith(CashoutModel value, $Res Function(CashoutModel) _then) = _$CashoutModelCopyWithImpl;
@useResult
$Res call({
 String id, String walletId, String userId, int tokenAmount, double zarAmount, String method, String status, String destinationDetails, String? bankName, String? accountNumber, String? accountHolderName, String? mobileNumber, String? reference, String? failureReason, DateTime createdAt, DateTime? processedAt, DateTime? completedAt, DateTime? failedAt
});




}
/// @nodoc
class _$CashoutModelCopyWithImpl<$Res>
    implements $CashoutModelCopyWith<$Res> {
  _$CashoutModelCopyWithImpl(this._self, this._then);

  final CashoutModel _self;
  final $Res Function(CashoutModel) _then;

/// Create a copy of CashoutModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? walletId = null,Object? userId = null,Object? tokenAmount = null,Object? zarAmount = null,Object? method = null,Object? status = null,Object? destinationDetails = null,Object? bankName = freezed,Object? accountNumber = freezed,Object? accountHolderName = freezed,Object? mobileNumber = freezed,Object? reference = freezed,Object? failureReason = freezed,Object? createdAt = null,Object? processedAt = freezed,Object? completedAt = freezed,Object? failedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,walletId: null == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,tokenAmount: null == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int,zarAmount: null == zarAmount ? _self.zarAmount : zarAmount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,destinationDetails: null == destinationDetails ? _self.destinationDetails : destinationDetails // ignore: cast_nullable_to_non_nullable
as String,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,accountHolderName: freezed == accountHolderName ? _self.accountHolderName : accountHolderName // ignore: cast_nullable_to_non_nullable
as String?,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashoutModel].
extension CashoutModelPatterns on CashoutModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashoutModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashoutModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashoutModel value)  $default,){
final _that = this;
switch (_that) {
case _CashoutModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashoutModel value)?  $default,){
final _that = this;
switch (_that) {
case _CashoutModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String walletId,  String userId,  int tokenAmount,  double zarAmount,  String method,  String status,  String destinationDetails,  String? bankName,  String? accountNumber,  String? accountHolderName,  String? mobileNumber,  String? reference,  String? failureReason,  DateTime createdAt,  DateTime? processedAt,  DateTime? completedAt,  DateTime? failedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashoutModel() when $default != null:
return $default(_that.id,_that.walletId,_that.userId,_that.tokenAmount,_that.zarAmount,_that.method,_that.status,_that.destinationDetails,_that.bankName,_that.accountNumber,_that.accountHolderName,_that.mobileNumber,_that.reference,_that.failureReason,_that.createdAt,_that.processedAt,_that.completedAt,_that.failedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String walletId,  String userId,  int tokenAmount,  double zarAmount,  String method,  String status,  String destinationDetails,  String? bankName,  String? accountNumber,  String? accountHolderName,  String? mobileNumber,  String? reference,  String? failureReason,  DateTime createdAt,  DateTime? processedAt,  DateTime? completedAt,  DateTime? failedAt)  $default,) {final _that = this;
switch (_that) {
case _CashoutModel():
return $default(_that.id,_that.walletId,_that.userId,_that.tokenAmount,_that.zarAmount,_that.method,_that.status,_that.destinationDetails,_that.bankName,_that.accountNumber,_that.accountHolderName,_that.mobileNumber,_that.reference,_that.failureReason,_that.createdAt,_that.processedAt,_that.completedAt,_that.failedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String walletId,  String userId,  int tokenAmount,  double zarAmount,  String method,  String status,  String destinationDetails,  String? bankName,  String? accountNumber,  String? accountHolderName,  String? mobileNumber,  String? reference,  String? failureReason,  DateTime createdAt,  DateTime? processedAt,  DateTime? completedAt,  DateTime? failedAt)?  $default,) {final _that = this;
switch (_that) {
case _CashoutModel() when $default != null:
return $default(_that.id,_that.walletId,_that.userId,_that.tokenAmount,_that.zarAmount,_that.method,_that.status,_that.destinationDetails,_that.bankName,_that.accountNumber,_that.accountHolderName,_that.mobileNumber,_that.reference,_that.failureReason,_that.createdAt,_that.processedAt,_that.completedAt,_that.failedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CashoutModel extends CashoutModel {
  const _CashoutModel({required this.id, required this.walletId, required this.userId, required this.tokenAmount, required this.zarAmount, required this.method, required this.status, required this.destinationDetails, this.bankName, this.accountNumber, this.accountHolderName, this.mobileNumber, this.reference, this.failureReason, required this.createdAt, this.processedAt, this.completedAt, this.failedAt}): super._();
  

@override final  String id;
@override final  String walletId;
@override final  String userId;
@override final  int tokenAmount;
@override final  double zarAmount;
@override final  String method;
@override final  String status;
@override final  String destinationDetails;
@override final  String? bankName;
@override final  String? accountNumber;
@override final  String? accountHolderName;
@override final  String? mobileNumber;
@override final  String? reference;
@override final  String? failureReason;
@override final  DateTime createdAt;
@override final  DateTime? processedAt;
@override final  DateTime? completedAt;
@override final  DateTime? failedAt;

/// Create a copy of CashoutModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashoutModelCopyWith<_CashoutModel> get copyWith => __$CashoutModelCopyWithImpl<_CashoutModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.zarAmount, zarAmount) || other.zarAmount == zarAmount)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&(identical(other.destinationDetails, destinationDetails) || other.destinationDetails == destinationDetails)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountHolderName, accountHolderName) || other.accountHolderName == accountHolderName)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,walletId,userId,tokenAmount,zarAmount,method,status,destinationDetails,bankName,accountNumber,accountHolderName,mobileNumber,reference,failureReason,createdAt,processedAt,completedAt,failedAt);

@override
String toString() {
  return 'CashoutModel(id: $id, walletId: $walletId, userId: $userId, tokenAmount: $tokenAmount, zarAmount: $zarAmount, method: $method, status: $status, destinationDetails: $destinationDetails, bankName: $bankName, accountNumber: $accountNumber, accountHolderName: $accountHolderName, mobileNumber: $mobileNumber, reference: $reference, failureReason: $failureReason, createdAt: $createdAt, processedAt: $processedAt, completedAt: $completedAt, failedAt: $failedAt)';
}


}

/// @nodoc
abstract mixin class _$CashoutModelCopyWith<$Res> implements $CashoutModelCopyWith<$Res> {
  factory _$CashoutModelCopyWith(_CashoutModel value, $Res Function(_CashoutModel) _then) = __$CashoutModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String walletId, String userId, int tokenAmount, double zarAmount, String method, String status, String destinationDetails, String? bankName, String? accountNumber, String? accountHolderName, String? mobileNumber, String? reference, String? failureReason, DateTime createdAt, DateTime? processedAt, DateTime? completedAt, DateTime? failedAt
});




}
/// @nodoc
class __$CashoutModelCopyWithImpl<$Res>
    implements _$CashoutModelCopyWith<$Res> {
  __$CashoutModelCopyWithImpl(this._self, this._then);

  final _CashoutModel _self;
  final $Res Function(_CashoutModel) _then;

/// Create a copy of CashoutModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? walletId = null,Object? userId = null,Object? tokenAmount = null,Object? zarAmount = null,Object? method = null,Object? status = null,Object? destinationDetails = null,Object? bankName = freezed,Object? accountNumber = freezed,Object? accountHolderName = freezed,Object? mobileNumber = freezed,Object? reference = freezed,Object? failureReason = freezed,Object? createdAt = null,Object? processedAt = freezed,Object? completedAt = freezed,Object? failedAt = freezed,}) {
  return _then(_CashoutModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,walletId: null == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,tokenAmount: null == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int,zarAmount: null == zarAmount ? _self.zarAmount : zarAmount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,destinationDetails: null == destinationDetails ? _self.destinationDetails : destinationDetails // ignore: cast_nullable_to_non_nullable
as String,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,accountHolderName: freezed == accountHolderName ? _self.accountHolderName : accountHolderName // ignore: cast_nullable_to_non_nullable
as String?,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failedAt: freezed == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
