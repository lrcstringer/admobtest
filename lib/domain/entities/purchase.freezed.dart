// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Purchase {

 String get id; String get walletId; String get userId; String get providerId; String get providerName; PurchaseCategory get category; int get tokenAmount; double get zarAmount; PurchaseStatus get status; String get productCode; String get productName; String? get recipientNumber; String? get voucherCode; String? get voucherPin; String? get reference; String? get failureReason; Map<String, dynamic>? get metadata; DateTime get createdAt; DateTime? get processedAt; DateTime? get completedAt;
/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseCopyWith<Purchase> get copyWith => _$PurchaseCopyWithImpl<Purchase>(this as Purchase, _$identity);

  /// Serializes this Purchase to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Purchase&&(identical(other.id, id) || other.id == id)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.category, category) || other.category == category)&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.zarAmount, zarAmount) || other.zarAmount == zarAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.recipientNumber, recipientNumber) || other.recipientNumber == recipientNumber)&&(identical(other.voucherCode, voucherCode) || other.voucherCode == voucherCode)&&(identical(other.voucherPin, voucherPin) || other.voucherPin == voucherPin)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,walletId,userId,providerId,providerName,category,tokenAmount,zarAmount,status,productCode,productName,recipientNumber,voucherCode,voucherPin,reference,failureReason,const DeepCollectionEquality().hash(metadata),createdAt,processedAt,completedAt]);

@override
String toString() {
  return 'Purchase(id: $id, walletId: $walletId, userId: $userId, providerId: $providerId, providerName: $providerName, category: $category, tokenAmount: $tokenAmount, zarAmount: $zarAmount, status: $status, productCode: $productCode, productName: $productName, recipientNumber: $recipientNumber, voucherCode: $voucherCode, voucherPin: $voucherPin, reference: $reference, failureReason: $failureReason, metadata: $metadata, createdAt: $createdAt, processedAt: $processedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $PurchaseCopyWith<$Res>  {
  factory $PurchaseCopyWith(Purchase value, $Res Function(Purchase) _then) = _$PurchaseCopyWithImpl;
@useResult
$Res call({
 String id, String walletId, String userId, String providerId, String providerName, PurchaseCategory category, int tokenAmount, double zarAmount, PurchaseStatus status, String productCode, String productName, String? recipientNumber, String? voucherCode, String? voucherPin, String? reference, String? failureReason, Map<String, dynamic>? metadata, DateTime createdAt, DateTime? processedAt, DateTime? completedAt
});




}
/// @nodoc
class _$PurchaseCopyWithImpl<$Res>
    implements $PurchaseCopyWith<$Res> {
  _$PurchaseCopyWithImpl(this._self, this._then);

  final Purchase _self;
  final $Res Function(Purchase) _then;

/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? walletId = null,Object? userId = null,Object? providerId = null,Object? providerName = null,Object? category = null,Object? tokenAmount = null,Object? zarAmount = null,Object? status = null,Object? productCode = null,Object? productName = null,Object? recipientNumber = freezed,Object? voucherCode = freezed,Object? voucherPin = freezed,Object? reference = freezed,Object? failureReason = freezed,Object? metadata = freezed,Object? createdAt = null,Object? processedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,walletId: null == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PurchaseCategory,tokenAmount: null == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int,zarAmount: null == zarAmount ? _self.zarAmount : zarAmount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PurchaseStatus,productCode: null == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,recipientNumber: freezed == recipientNumber ? _self.recipientNumber : recipientNumber // ignore: cast_nullable_to_non_nullable
as String?,voucherCode: freezed == voucherCode ? _self.voucherCode : voucherCode // ignore: cast_nullable_to_non_nullable
as String?,voucherPin: freezed == voucherPin ? _self.voucherPin : voucherPin // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Purchase].
extension PurchasePatterns on Purchase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Purchase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Purchase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Purchase value)  $default,){
final _that = this;
switch (_that) {
case _Purchase():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Purchase value)?  $default,){
final _that = this;
switch (_that) {
case _Purchase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String walletId,  String userId,  String providerId,  String providerName,  PurchaseCategory category,  int tokenAmount,  double zarAmount,  PurchaseStatus status,  String productCode,  String productName,  String? recipientNumber,  String? voucherCode,  String? voucherPin,  String? reference,  String? failureReason,  Map<String, dynamic>? metadata,  DateTime createdAt,  DateTime? processedAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Purchase() when $default != null:
return $default(_that.id,_that.walletId,_that.userId,_that.providerId,_that.providerName,_that.category,_that.tokenAmount,_that.zarAmount,_that.status,_that.productCode,_that.productName,_that.recipientNumber,_that.voucherCode,_that.voucherPin,_that.reference,_that.failureReason,_that.metadata,_that.createdAt,_that.processedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String walletId,  String userId,  String providerId,  String providerName,  PurchaseCategory category,  int tokenAmount,  double zarAmount,  PurchaseStatus status,  String productCode,  String productName,  String? recipientNumber,  String? voucherCode,  String? voucherPin,  String? reference,  String? failureReason,  Map<String, dynamic>? metadata,  DateTime createdAt,  DateTime? processedAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _Purchase():
return $default(_that.id,_that.walletId,_that.userId,_that.providerId,_that.providerName,_that.category,_that.tokenAmount,_that.zarAmount,_that.status,_that.productCode,_that.productName,_that.recipientNumber,_that.voucherCode,_that.voucherPin,_that.reference,_that.failureReason,_that.metadata,_that.createdAt,_that.processedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String walletId,  String userId,  String providerId,  String providerName,  PurchaseCategory category,  int tokenAmount,  double zarAmount,  PurchaseStatus status,  String productCode,  String productName,  String? recipientNumber,  String? voucherCode,  String? voucherPin,  String? reference,  String? failureReason,  Map<String, dynamic>? metadata,  DateTime createdAt,  DateTime? processedAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _Purchase() when $default != null:
return $default(_that.id,_that.walletId,_that.userId,_that.providerId,_that.providerName,_that.category,_that.tokenAmount,_that.zarAmount,_that.status,_that.productCode,_that.productName,_that.recipientNumber,_that.voucherCode,_that.voucherPin,_that.reference,_that.failureReason,_that.metadata,_that.createdAt,_that.processedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Purchase extends Purchase {
  const _Purchase({required this.id, required this.walletId, required this.userId, required this.providerId, required this.providerName, required this.category, required this.tokenAmount, required this.zarAmount, required this.status, required this.productCode, required this.productName, this.recipientNumber, this.voucherCode, this.voucherPin, this.reference, this.failureReason, final  Map<String, dynamic>? metadata, required this.createdAt, this.processedAt, this.completedAt}): _metadata = metadata,super._();
  factory _Purchase.fromJson(Map<String, dynamic> json) => _$PurchaseFromJson(json);

@override final  String id;
@override final  String walletId;
@override final  String userId;
@override final  String providerId;
@override final  String providerName;
@override final  PurchaseCategory category;
@override final  int tokenAmount;
@override final  double zarAmount;
@override final  PurchaseStatus status;
@override final  String productCode;
@override final  String productName;
@override final  String? recipientNumber;
@override final  String? voucherCode;
@override final  String? voucherPin;
@override final  String? reference;
@override final  String? failureReason;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime createdAt;
@override final  DateTime? processedAt;
@override final  DateTime? completedAt;

/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseCopyWith<_Purchase> get copyWith => __$PurchaseCopyWithImpl<_Purchase>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Purchase&&(identical(other.id, id) || other.id == id)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.category, category) || other.category == category)&&(identical(other.tokenAmount, tokenAmount) || other.tokenAmount == tokenAmount)&&(identical(other.zarAmount, zarAmount) || other.zarAmount == zarAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.recipientNumber, recipientNumber) || other.recipientNumber == recipientNumber)&&(identical(other.voucherCode, voucherCode) || other.voucherCode == voucherCode)&&(identical(other.voucherPin, voucherPin) || other.voucherPin == voucherPin)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,walletId,userId,providerId,providerName,category,tokenAmount,zarAmount,status,productCode,productName,recipientNumber,voucherCode,voucherPin,reference,failureReason,const DeepCollectionEquality().hash(_metadata),createdAt,processedAt,completedAt]);

@override
String toString() {
  return 'Purchase(id: $id, walletId: $walletId, userId: $userId, providerId: $providerId, providerName: $providerName, category: $category, tokenAmount: $tokenAmount, zarAmount: $zarAmount, status: $status, productCode: $productCode, productName: $productName, recipientNumber: $recipientNumber, voucherCode: $voucherCode, voucherPin: $voucherPin, reference: $reference, failureReason: $failureReason, metadata: $metadata, createdAt: $createdAt, processedAt: $processedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$PurchaseCopyWith<$Res> implements $PurchaseCopyWith<$Res> {
  factory _$PurchaseCopyWith(_Purchase value, $Res Function(_Purchase) _then) = __$PurchaseCopyWithImpl;
@override @useResult
$Res call({
 String id, String walletId, String userId, String providerId, String providerName, PurchaseCategory category, int tokenAmount, double zarAmount, PurchaseStatus status, String productCode, String productName, String? recipientNumber, String? voucherCode, String? voucherPin, String? reference, String? failureReason, Map<String, dynamic>? metadata, DateTime createdAt, DateTime? processedAt, DateTime? completedAt
});




}
/// @nodoc
class __$PurchaseCopyWithImpl<$Res>
    implements _$PurchaseCopyWith<$Res> {
  __$PurchaseCopyWithImpl(this._self, this._then);

  final _Purchase _self;
  final $Res Function(_Purchase) _then;

/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? walletId = null,Object? userId = null,Object? providerId = null,Object? providerName = null,Object? category = null,Object? tokenAmount = null,Object? zarAmount = null,Object? status = null,Object? productCode = null,Object? productName = null,Object? recipientNumber = freezed,Object? voucherCode = freezed,Object? voucherPin = freezed,Object? reference = freezed,Object? failureReason = freezed,Object? metadata = freezed,Object? createdAt = null,Object? processedAt = freezed,Object? completedAt = freezed,}) {
  return _then(_Purchase(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,walletId: null == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PurchaseCategory,tokenAmount: null == tokenAmount ? _self.tokenAmount : tokenAmount // ignore: cast_nullable_to_non_nullable
as int,zarAmount: null == zarAmount ? _self.zarAmount : zarAmount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PurchaseStatus,productCode: null == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,recipientNumber: freezed == recipientNumber ? _self.recipientNumber : recipientNumber // ignore: cast_nullable_to_non_nullable
as String?,voucherCode: freezed == voucherCode ? _self.voucherCode : voucherCode // ignore: cast_nullable_to_non_nullable
as String?,voucherPin: freezed == voucherPin ? _self.voucherPin : voucherPin // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
