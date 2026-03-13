// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_offer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketplaceOfferModel {

 String get id; String get listingId; String get buyerId; String get sellerId; int get offerAmount; int get originalPrice; OfferStatus get status; int? get counterAmount; String? get chatConversationId; DateTime? get expiresAt; DateTime get createdAt; DateTime? get respondedAt; String? get listingTitle; String? get buyerName; String? get sellerName; double? get offerZar; double? get counterZar; String? get message;
/// Create a copy of MarketplaceOfferModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketplaceOfferModelCopyWith<MarketplaceOfferModel> get copyWith => _$MarketplaceOfferModelCopyWithImpl<MarketplaceOfferModel>(this as MarketplaceOfferModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketplaceOfferModel&&(identical(other.id, id) || other.id == id)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.offerAmount, offerAmount) || other.offerAmount == offerAmount)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.status, status) || other.status == status)&&(identical(other.counterAmount, counterAmount) || other.counterAmount == counterAmount)&&(identical(other.chatConversationId, chatConversationId) || other.chatConversationId == chatConversationId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.listingTitle, listingTitle) || other.listingTitle == listingTitle)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.offerZar, offerZar) || other.offerZar == offerZar)&&(identical(other.counterZar, counterZar) || other.counterZar == counterZar)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,id,listingId,buyerId,sellerId,offerAmount,originalPrice,status,counterAmount,chatConversationId,expiresAt,createdAt,respondedAt,listingTitle,buyerName,sellerName,offerZar,counterZar,message);

@override
String toString() {
  return 'MarketplaceOfferModel(id: $id, listingId: $listingId, buyerId: $buyerId, sellerId: $sellerId, offerAmount: $offerAmount, originalPrice: $originalPrice, status: $status, counterAmount: $counterAmount, chatConversationId: $chatConversationId, expiresAt: $expiresAt, createdAt: $createdAt, respondedAt: $respondedAt, listingTitle: $listingTitle, buyerName: $buyerName, sellerName: $sellerName, offerZar: $offerZar, counterZar: $counterZar, message: $message)';
}


}

/// @nodoc
abstract mixin class $MarketplaceOfferModelCopyWith<$Res>  {
  factory $MarketplaceOfferModelCopyWith(MarketplaceOfferModel value, $Res Function(MarketplaceOfferModel) _then) = _$MarketplaceOfferModelCopyWithImpl;
@useResult
$Res call({
 String id, String listingId, String buyerId, String sellerId, int offerAmount, int originalPrice, OfferStatus status, int? counterAmount, String? chatConversationId, DateTime? expiresAt, DateTime createdAt, DateTime? respondedAt, String? listingTitle, String? buyerName, String? sellerName, double? offerZar, double? counterZar, String? message
});




}
/// @nodoc
class _$MarketplaceOfferModelCopyWithImpl<$Res>
    implements $MarketplaceOfferModelCopyWith<$Res> {
  _$MarketplaceOfferModelCopyWithImpl(this._self, this._then);

  final MarketplaceOfferModel _self;
  final $Res Function(MarketplaceOfferModel) _then;

/// Create a copy of MarketplaceOfferModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? listingId = null,Object? buyerId = null,Object? sellerId = null,Object? offerAmount = null,Object? originalPrice = null,Object? status = null,Object? counterAmount = freezed,Object? chatConversationId = freezed,Object? expiresAt = freezed,Object? createdAt = null,Object? respondedAt = freezed,Object? listingTitle = freezed,Object? buyerName = freezed,Object? sellerName = freezed,Object? offerZar = freezed,Object? counterZar = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,offerAmount: null == offerAmount ? _self.offerAmount : offerAmount // ignore: cast_nullable_to_non_nullable
as int,originalPrice: null == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OfferStatus,counterAmount: freezed == counterAmount ? _self.counterAmount : counterAmount // ignore: cast_nullable_to_non_nullable
as int?,chatConversationId: freezed == chatConversationId ? _self.chatConversationId : chatConversationId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listingTitle: freezed == listingTitle ? _self.listingTitle : listingTitle // ignore: cast_nullable_to_non_nullable
as String?,buyerName: freezed == buyerName ? _self.buyerName : buyerName // ignore: cast_nullable_to_non_nullable
as String?,sellerName: freezed == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String?,offerZar: freezed == offerZar ? _self.offerZar : offerZar // ignore: cast_nullable_to_non_nullable
as double?,counterZar: freezed == counterZar ? _self.counterZar : counterZar // ignore: cast_nullable_to_non_nullable
as double?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketplaceOfferModel].
extension MarketplaceOfferModelPatterns on MarketplaceOfferModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketplaceOfferModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketplaceOfferModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketplaceOfferModel value)  $default,){
final _that = this;
switch (_that) {
case _MarketplaceOfferModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketplaceOfferModel value)?  $default,){
final _that = this;
switch (_that) {
case _MarketplaceOfferModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String listingId,  String buyerId,  String sellerId,  int offerAmount,  int originalPrice,  OfferStatus status,  int? counterAmount,  String? chatConversationId,  DateTime? expiresAt,  DateTime createdAt,  DateTime? respondedAt,  String? listingTitle,  String? buyerName,  String? sellerName,  double? offerZar,  double? counterZar,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketplaceOfferModel() when $default != null:
return $default(_that.id,_that.listingId,_that.buyerId,_that.sellerId,_that.offerAmount,_that.originalPrice,_that.status,_that.counterAmount,_that.chatConversationId,_that.expiresAt,_that.createdAt,_that.respondedAt,_that.listingTitle,_that.buyerName,_that.sellerName,_that.offerZar,_that.counterZar,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String listingId,  String buyerId,  String sellerId,  int offerAmount,  int originalPrice,  OfferStatus status,  int? counterAmount,  String? chatConversationId,  DateTime? expiresAt,  DateTime createdAt,  DateTime? respondedAt,  String? listingTitle,  String? buyerName,  String? sellerName,  double? offerZar,  double? counterZar,  String? message)  $default,) {final _that = this;
switch (_that) {
case _MarketplaceOfferModel():
return $default(_that.id,_that.listingId,_that.buyerId,_that.sellerId,_that.offerAmount,_that.originalPrice,_that.status,_that.counterAmount,_that.chatConversationId,_that.expiresAt,_that.createdAt,_that.respondedAt,_that.listingTitle,_that.buyerName,_that.sellerName,_that.offerZar,_that.counterZar,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String listingId,  String buyerId,  String sellerId,  int offerAmount,  int originalPrice,  OfferStatus status,  int? counterAmount,  String? chatConversationId,  DateTime? expiresAt,  DateTime createdAt,  DateTime? respondedAt,  String? listingTitle,  String? buyerName,  String? sellerName,  double? offerZar,  double? counterZar,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _MarketplaceOfferModel() when $default != null:
return $default(_that.id,_that.listingId,_that.buyerId,_that.sellerId,_that.offerAmount,_that.originalPrice,_that.status,_that.counterAmount,_that.chatConversationId,_that.expiresAt,_that.createdAt,_that.respondedAt,_that.listingTitle,_that.buyerName,_that.sellerName,_that.offerZar,_that.counterZar,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _MarketplaceOfferModel extends MarketplaceOfferModel {
  const _MarketplaceOfferModel({required this.id, required this.listingId, required this.buyerId, required this.sellerId, required this.offerAmount, required this.originalPrice, required this.status, this.counterAmount, this.chatConversationId, this.expiresAt, required this.createdAt, this.respondedAt, this.listingTitle, this.buyerName, this.sellerName, this.offerZar, this.counterZar, this.message}): super._();
  

@override final  String id;
@override final  String listingId;
@override final  String buyerId;
@override final  String sellerId;
@override final  int offerAmount;
@override final  int originalPrice;
@override final  OfferStatus status;
@override final  int? counterAmount;
@override final  String? chatConversationId;
@override final  DateTime? expiresAt;
@override final  DateTime createdAt;
@override final  DateTime? respondedAt;
@override final  String? listingTitle;
@override final  String? buyerName;
@override final  String? sellerName;
@override final  double? offerZar;
@override final  double? counterZar;
@override final  String? message;

/// Create a copy of MarketplaceOfferModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketplaceOfferModelCopyWith<_MarketplaceOfferModel> get copyWith => __$MarketplaceOfferModelCopyWithImpl<_MarketplaceOfferModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketplaceOfferModel&&(identical(other.id, id) || other.id == id)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.offerAmount, offerAmount) || other.offerAmount == offerAmount)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.status, status) || other.status == status)&&(identical(other.counterAmount, counterAmount) || other.counterAmount == counterAmount)&&(identical(other.chatConversationId, chatConversationId) || other.chatConversationId == chatConversationId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.listingTitle, listingTitle) || other.listingTitle == listingTitle)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.offerZar, offerZar) || other.offerZar == offerZar)&&(identical(other.counterZar, counterZar) || other.counterZar == counterZar)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,id,listingId,buyerId,sellerId,offerAmount,originalPrice,status,counterAmount,chatConversationId,expiresAt,createdAt,respondedAt,listingTitle,buyerName,sellerName,offerZar,counterZar,message);

@override
String toString() {
  return 'MarketplaceOfferModel(id: $id, listingId: $listingId, buyerId: $buyerId, sellerId: $sellerId, offerAmount: $offerAmount, originalPrice: $originalPrice, status: $status, counterAmount: $counterAmount, chatConversationId: $chatConversationId, expiresAt: $expiresAt, createdAt: $createdAt, respondedAt: $respondedAt, listingTitle: $listingTitle, buyerName: $buyerName, sellerName: $sellerName, offerZar: $offerZar, counterZar: $counterZar, message: $message)';
}


}

/// @nodoc
abstract mixin class _$MarketplaceOfferModelCopyWith<$Res> implements $MarketplaceOfferModelCopyWith<$Res> {
  factory _$MarketplaceOfferModelCopyWith(_MarketplaceOfferModel value, $Res Function(_MarketplaceOfferModel) _then) = __$MarketplaceOfferModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String listingId, String buyerId, String sellerId, int offerAmount, int originalPrice, OfferStatus status, int? counterAmount, String? chatConversationId, DateTime? expiresAt, DateTime createdAt, DateTime? respondedAt, String? listingTitle, String? buyerName, String? sellerName, double? offerZar, double? counterZar, String? message
});




}
/// @nodoc
class __$MarketplaceOfferModelCopyWithImpl<$Res>
    implements _$MarketplaceOfferModelCopyWith<$Res> {
  __$MarketplaceOfferModelCopyWithImpl(this._self, this._then);

  final _MarketplaceOfferModel _self;
  final $Res Function(_MarketplaceOfferModel) _then;

/// Create a copy of MarketplaceOfferModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? listingId = null,Object? buyerId = null,Object? sellerId = null,Object? offerAmount = null,Object? originalPrice = null,Object? status = null,Object? counterAmount = freezed,Object? chatConversationId = freezed,Object? expiresAt = freezed,Object? createdAt = null,Object? respondedAt = freezed,Object? listingTitle = freezed,Object? buyerName = freezed,Object? sellerName = freezed,Object? offerZar = freezed,Object? counterZar = freezed,Object? message = freezed,}) {
  return _then(_MarketplaceOfferModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,offerAmount: null == offerAmount ? _self.offerAmount : offerAmount // ignore: cast_nullable_to_non_nullable
as int,originalPrice: null == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OfferStatus,counterAmount: freezed == counterAmount ? _self.counterAmount : counterAmount // ignore: cast_nullable_to_non_nullable
as int?,chatConversationId: freezed == chatConversationId ? _self.chatConversationId : chatConversationId // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listingTitle: freezed == listingTitle ? _self.listingTitle : listingTitle // ignore: cast_nullable_to_non_nullable
as String?,buyerName: freezed == buyerName ? _self.buyerName : buyerName // ignore: cast_nullable_to_non_nullable
as String?,sellerName: freezed == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String?,offerZar: freezed == offerZar ? _self.offerZar : offerZar // ignore: cast_nullable_to_non_nullable
as double?,counterZar: freezed == counterZar ? _self.counterZar : counterZar // ignore: cast_nullable_to_non_nullable
as double?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
