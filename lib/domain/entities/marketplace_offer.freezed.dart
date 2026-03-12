// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarketplaceOffer {

 String get id; String get listingId; String get buyerId; String get sellerId; int get offerAmount; int get originalPrice; OfferStatus get status; int? get counterAmount; String? get chatConversationId; DateTime? get expiresAt; DateTime get createdAt; DateTime? get respondedAt;
/// Create a copy of MarketplaceOffer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketplaceOfferCopyWith<MarketplaceOffer> get copyWith => _$MarketplaceOfferCopyWithImpl<MarketplaceOffer>(this as MarketplaceOffer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketplaceOffer&&(identical(other.id, id) || other.id == id)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.offerAmount, offerAmount) || other.offerAmount == offerAmount)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.status, status) || other.status == status)&&(identical(other.counterAmount, counterAmount) || other.counterAmount == counterAmount)&&(identical(other.chatConversationId, chatConversationId) || other.chatConversationId == chatConversationId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,listingId,buyerId,sellerId,offerAmount,originalPrice,status,counterAmount,chatConversationId,expiresAt,createdAt,respondedAt);

@override
String toString() {
  return 'MarketplaceOffer(id: $id, listingId: $listingId, buyerId: $buyerId, sellerId: $sellerId, offerAmount: $offerAmount, originalPrice: $originalPrice, status: $status, counterAmount: $counterAmount, chatConversationId: $chatConversationId, expiresAt: $expiresAt, createdAt: $createdAt, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class $MarketplaceOfferCopyWith<$Res>  {
  factory $MarketplaceOfferCopyWith(MarketplaceOffer value, $Res Function(MarketplaceOffer) _then) = _$MarketplaceOfferCopyWithImpl;
@useResult
$Res call({
 String id, String listingId, String buyerId, String sellerId, int offerAmount, int originalPrice, OfferStatus status, int? counterAmount, String? chatConversationId, DateTime? expiresAt, DateTime createdAt, DateTime? respondedAt
});




}
/// @nodoc
class _$MarketplaceOfferCopyWithImpl<$Res>
    implements $MarketplaceOfferCopyWith<$Res> {
  _$MarketplaceOfferCopyWithImpl(this._self, this._then);

  final MarketplaceOffer _self;
  final $Res Function(MarketplaceOffer) _then;

/// Create a copy of MarketplaceOffer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? listingId = null,Object? buyerId = null,Object? sellerId = null,Object? offerAmount = null,Object? originalPrice = null,Object? status = null,Object? counterAmount = freezed,Object? chatConversationId = freezed,Object? expiresAt = freezed,Object? createdAt = null,Object? respondedAt = freezed,}) {
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
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketplaceOffer].
extension MarketplaceOfferPatterns on MarketplaceOffer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketplaceOffer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketplaceOffer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketplaceOffer value)  $default,){
final _that = this;
switch (_that) {
case _MarketplaceOffer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketplaceOffer value)?  $default,){
final _that = this;
switch (_that) {
case _MarketplaceOffer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String listingId,  String buyerId,  String sellerId,  int offerAmount,  int originalPrice,  OfferStatus status,  int? counterAmount,  String? chatConversationId,  DateTime? expiresAt,  DateTime createdAt,  DateTime? respondedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketplaceOffer() when $default != null:
return $default(_that.id,_that.listingId,_that.buyerId,_that.sellerId,_that.offerAmount,_that.originalPrice,_that.status,_that.counterAmount,_that.chatConversationId,_that.expiresAt,_that.createdAt,_that.respondedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String listingId,  String buyerId,  String sellerId,  int offerAmount,  int originalPrice,  OfferStatus status,  int? counterAmount,  String? chatConversationId,  DateTime? expiresAt,  DateTime createdAt,  DateTime? respondedAt)  $default,) {final _that = this;
switch (_that) {
case _MarketplaceOffer():
return $default(_that.id,_that.listingId,_that.buyerId,_that.sellerId,_that.offerAmount,_that.originalPrice,_that.status,_that.counterAmount,_that.chatConversationId,_that.expiresAt,_that.createdAt,_that.respondedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String listingId,  String buyerId,  String sellerId,  int offerAmount,  int originalPrice,  OfferStatus status,  int? counterAmount,  String? chatConversationId,  DateTime? expiresAt,  DateTime createdAt,  DateTime? respondedAt)?  $default,) {final _that = this;
switch (_that) {
case _MarketplaceOffer() when $default != null:
return $default(_that.id,_that.listingId,_that.buyerId,_that.sellerId,_that.offerAmount,_that.originalPrice,_that.status,_that.counterAmount,_that.chatConversationId,_that.expiresAt,_that.createdAt,_that.respondedAt);case _:
  return null;

}
}

}

/// @nodoc


class _MarketplaceOffer extends MarketplaceOffer {
  const _MarketplaceOffer({required this.id, required this.listingId, required this.buyerId, required this.sellerId, required this.offerAmount, required this.originalPrice, required this.status, this.counterAmount, this.chatConversationId, this.expiresAt, required this.createdAt, this.respondedAt}): super._();
  

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

/// Create a copy of MarketplaceOffer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketplaceOfferCopyWith<_MarketplaceOffer> get copyWith => __$MarketplaceOfferCopyWithImpl<_MarketplaceOffer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketplaceOffer&&(identical(other.id, id) || other.id == id)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.offerAmount, offerAmount) || other.offerAmount == offerAmount)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.status, status) || other.status == status)&&(identical(other.counterAmount, counterAmount) || other.counterAmount == counterAmount)&&(identical(other.chatConversationId, chatConversationId) || other.chatConversationId == chatConversationId)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,listingId,buyerId,sellerId,offerAmount,originalPrice,status,counterAmount,chatConversationId,expiresAt,createdAt,respondedAt);

@override
String toString() {
  return 'MarketplaceOffer(id: $id, listingId: $listingId, buyerId: $buyerId, sellerId: $sellerId, offerAmount: $offerAmount, originalPrice: $originalPrice, status: $status, counterAmount: $counterAmount, chatConversationId: $chatConversationId, expiresAt: $expiresAt, createdAt: $createdAt, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class _$MarketplaceOfferCopyWith<$Res> implements $MarketplaceOfferCopyWith<$Res> {
  factory _$MarketplaceOfferCopyWith(_MarketplaceOffer value, $Res Function(_MarketplaceOffer) _then) = __$MarketplaceOfferCopyWithImpl;
@override @useResult
$Res call({
 String id, String listingId, String buyerId, String sellerId, int offerAmount, int originalPrice, OfferStatus status, int? counterAmount, String? chatConversationId, DateTime? expiresAt, DateTime createdAt, DateTime? respondedAt
});




}
/// @nodoc
class __$MarketplaceOfferCopyWithImpl<$Res>
    implements _$MarketplaceOfferCopyWith<$Res> {
  __$MarketplaceOfferCopyWithImpl(this._self, this._then);

  final _MarketplaceOffer _self;
  final $Res Function(_MarketplaceOffer) _then;

/// Create a copy of MarketplaceOffer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? listingId = null,Object? buyerId = null,Object? sellerId = null,Object? offerAmount = null,Object? originalPrice = null,Object? status = null,Object? counterAmount = freezed,Object? chatConversationId = freezed,Object? expiresAt = freezed,Object? createdAt = null,Object? respondedAt = freezed,}) {
  return _then(_MarketplaceOffer(
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
as DateTime?,
  ));
}


}

// dart format on
