// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent()';
}


}

/// @nodoc
class $OrderEventCopyWith<$Res>  {
$OrderEventCopyWith(OrderEvent _, $Res Function(OrderEvent) __);
}


/// Adds pattern-matching-related methods to [OrderEvent].
extension OrderEventPatterns on OrderEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadBuyerOrders value)?  loadBuyerOrders,TResult Function( _LoadSellerOrders value)?  loadSellerOrders,TResult Function( _SelectOrder value)?  selectOrder,TResult Function( _BuyItem value)?  buyItem,TResult Function( _ConfirmFulfilment value)?  confirmFulfilment,TResult Function( _ConfirmReceipt value)?  confirmReceipt,TResult Function( _CancelOrder value)?  cancelOrder,TResult Function( _DisputeOrder value)?  disputeOrder,TResult Function( _VouchForProvider value)?  vouchForProvider,TResult Function( _LoadLinkedOffer value)?  loadLinkedOffer,TResult Function( _ClearMessages value)?  clearMessages,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadBuyerOrders() when loadBuyerOrders != null:
return loadBuyerOrders(_that);case _LoadSellerOrders() when loadSellerOrders != null:
return loadSellerOrders(_that);case _SelectOrder() when selectOrder != null:
return selectOrder(_that);case _BuyItem() when buyItem != null:
return buyItem(_that);case _ConfirmFulfilment() when confirmFulfilment != null:
return confirmFulfilment(_that);case _ConfirmReceipt() when confirmReceipt != null:
return confirmReceipt(_that);case _CancelOrder() when cancelOrder != null:
return cancelOrder(_that);case _DisputeOrder() when disputeOrder != null:
return disputeOrder(_that);case _VouchForProvider() when vouchForProvider != null:
return vouchForProvider(_that);case _LoadLinkedOffer() when loadLinkedOffer != null:
return loadLinkedOffer(_that);case _ClearMessages() when clearMessages != null:
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadBuyerOrders value)  loadBuyerOrders,required TResult Function( _LoadSellerOrders value)  loadSellerOrders,required TResult Function( _SelectOrder value)  selectOrder,required TResult Function( _BuyItem value)  buyItem,required TResult Function( _ConfirmFulfilment value)  confirmFulfilment,required TResult Function( _ConfirmReceipt value)  confirmReceipt,required TResult Function( _CancelOrder value)  cancelOrder,required TResult Function( _DisputeOrder value)  disputeOrder,required TResult Function( _VouchForProvider value)  vouchForProvider,required TResult Function( _LoadLinkedOffer value)  loadLinkedOffer,required TResult Function( _ClearMessages value)  clearMessages,}){
final _that = this;
switch (_that) {
case _LoadBuyerOrders():
return loadBuyerOrders(_that);case _LoadSellerOrders():
return loadSellerOrders(_that);case _SelectOrder():
return selectOrder(_that);case _BuyItem():
return buyItem(_that);case _ConfirmFulfilment():
return confirmFulfilment(_that);case _ConfirmReceipt():
return confirmReceipt(_that);case _CancelOrder():
return cancelOrder(_that);case _DisputeOrder():
return disputeOrder(_that);case _VouchForProvider():
return vouchForProvider(_that);case _LoadLinkedOffer():
return loadLinkedOffer(_that);case _ClearMessages():
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadBuyerOrders value)?  loadBuyerOrders,TResult? Function( _LoadSellerOrders value)?  loadSellerOrders,TResult? Function( _SelectOrder value)?  selectOrder,TResult? Function( _BuyItem value)?  buyItem,TResult? Function( _ConfirmFulfilment value)?  confirmFulfilment,TResult? Function( _ConfirmReceipt value)?  confirmReceipt,TResult? Function( _CancelOrder value)?  cancelOrder,TResult? Function( _DisputeOrder value)?  disputeOrder,TResult? Function( _VouchForProvider value)?  vouchForProvider,TResult? Function( _LoadLinkedOffer value)?  loadLinkedOffer,TResult? Function( _ClearMessages value)?  clearMessages,}){
final _that = this;
switch (_that) {
case _LoadBuyerOrders() when loadBuyerOrders != null:
return loadBuyerOrders(_that);case _LoadSellerOrders() when loadSellerOrders != null:
return loadSellerOrders(_that);case _SelectOrder() when selectOrder != null:
return selectOrder(_that);case _BuyItem() when buyItem != null:
return buyItem(_that);case _ConfirmFulfilment() when confirmFulfilment != null:
return confirmFulfilment(_that);case _ConfirmReceipt() when confirmReceipt != null:
return confirmReceipt(_that);case _CancelOrder() when cancelOrder != null:
return cancelOrder(_that);case _DisputeOrder() when disputeOrder != null:
return disputeOrder(_that);case _VouchForProvider() when vouchForProvider != null:
return vouchForProvider(_that);case _LoadLinkedOffer() when loadLinkedOffer != null:
return loadLinkedOffer(_that);case _ClearMessages() when clearMessages != null:
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadBuyerOrders,TResult Function()?  loadSellerOrders,TResult Function( String orderId)?  selectOrder,TResult Function( String listingId,  String walletId)?  buyItem,TResult Function( String orderId)?  confirmFulfilment,TResult Function( String orderId)?  confirmReceipt,TResult Function( String orderId)?  cancelOrder,TResult Function( String orderId,  String reason)?  disputeOrder,TResult Function( String providerId,  String orderId,  int rating,  String? comment)?  vouchForProvider,TResult Function( String offerId)?  loadLinkedOffer,TResult Function()?  clearMessages,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadBuyerOrders() when loadBuyerOrders != null:
return loadBuyerOrders();case _LoadSellerOrders() when loadSellerOrders != null:
return loadSellerOrders();case _SelectOrder() when selectOrder != null:
return selectOrder(_that.orderId);case _BuyItem() when buyItem != null:
return buyItem(_that.listingId,_that.walletId);case _ConfirmFulfilment() when confirmFulfilment != null:
return confirmFulfilment(_that.orderId);case _ConfirmReceipt() when confirmReceipt != null:
return confirmReceipt(_that.orderId);case _CancelOrder() when cancelOrder != null:
return cancelOrder(_that.orderId);case _DisputeOrder() when disputeOrder != null:
return disputeOrder(_that.orderId,_that.reason);case _VouchForProvider() when vouchForProvider != null:
return vouchForProvider(_that.providerId,_that.orderId,_that.rating,_that.comment);case _LoadLinkedOffer() when loadLinkedOffer != null:
return loadLinkedOffer(_that.offerId);case _ClearMessages() when clearMessages != null:
return clearMessages();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadBuyerOrders,required TResult Function()  loadSellerOrders,required TResult Function( String orderId)  selectOrder,required TResult Function( String listingId,  String walletId)  buyItem,required TResult Function( String orderId)  confirmFulfilment,required TResult Function( String orderId)  confirmReceipt,required TResult Function( String orderId)  cancelOrder,required TResult Function( String orderId,  String reason)  disputeOrder,required TResult Function( String providerId,  String orderId,  int rating,  String? comment)  vouchForProvider,required TResult Function( String offerId)  loadLinkedOffer,required TResult Function()  clearMessages,}) {final _that = this;
switch (_that) {
case _LoadBuyerOrders():
return loadBuyerOrders();case _LoadSellerOrders():
return loadSellerOrders();case _SelectOrder():
return selectOrder(_that.orderId);case _BuyItem():
return buyItem(_that.listingId,_that.walletId);case _ConfirmFulfilment():
return confirmFulfilment(_that.orderId);case _ConfirmReceipt():
return confirmReceipt(_that.orderId);case _CancelOrder():
return cancelOrder(_that.orderId);case _DisputeOrder():
return disputeOrder(_that.orderId,_that.reason);case _VouchForProvider():
return vouchForProvider(_that.providerId,_that.orderId,_that.rating,_that.comment);case _LoadLinkedOffer():
return loadLinkedOffer(_that.offerId);case _ClearMessages():
return clearMessages();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadBuyerOrders,TResult? Function()?  loadSellerOrders,TResult? Function( String orderId)?  selectOrder,TResult? Function( String listingId,  String walletId)?  buyItem,TResult? Function( String orderId)?  confirmFulfilment,TResult? Function( String orderId)?  confirmReceipt,TResult? Function( String orderId)?  cancelOrder,TResult? Function( String orderId,  String reason)?  disputeOrder,TResult? Function( String providerId,  String orderId,  int rating,  String? comment)?  vouchForProvider,TResult? Function( String offerId)?  loadLinkedOffer,TResult? Function()?  clearMessages,}) {final _that = this;
switch (_that) {
case _LoadBuyerOrders() when loadBuyerOrders != null:
return loadBuyerOrders();case _LoadSellerOrders() when loadSellerOrders != null:
return loadSellerOrders();case _SelectOrder() when selectOrder != null:
return selectOrder(_that.orderId);case _BuyItem() when buyItem != null:
return buyItem(_that.listingId,_that.walletId);case _ConfirmFulfilment() when confirmFulfilment != null:
return confirmFulfilment(_that.orderId);case _ConfirmReceipt() when confirmReceipt != null:
return confirmReceipt(_that.orderId);case _CancelOrder() when cancelOrder != null:
return cancelOrder(_that.orderId);case _DisputeOrder() when disputeOrder != null:
return disputeOrder(_that.orderId,_that.reason);case _VouchForProvider() when vouchForProvider != null:
return vouchForProvider(_that.providerId,_that.orderId,_that.rating,_that.comment);case _LoadLinkedOffer() when loadLinkedOffer != null:
return loadLinkedOffer(_that.offerId);case _ClearMessages() when clearMessages != null:
return clearMessages();case _:
  return null;

}
}

}

/// @nodoc


class _LoadBuyerOrders implements OrderEvent {
  const _LoadBuyerOrders();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadBuyerOrders);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.loadBuyerOrders()';
}


}




/// @nodoc


class _LoadSellerOrders implements OrderEvent {
  const _LoadSellerOrders();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadSellerOrders);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.loadSellerOrders()';
}


}




/// @nodoc


class _SelectOrder implements OrderEvent {
  const _SelectOrder(this.orderId);
  

 final  String orderId;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectOrderCopyWith<_SelectOrder> get copyWith => __$SelectOrderCopyWithImpl<_SelectOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectOrder&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'OrderEvent.selectOrder(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class _$SelectOrderCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$SelectOrderCopyWith(_SelectOrder value, $Res Function(_SelectOrder) _then) = __$SelectOrderCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class __$SelectOrderCopyWithImpl<$Res>
    implements _$SelectOrderCopyWith<$Res> {
  __$SelectOrderCopyWithImpl(this._self, this._then);

  final _SelectOrder _self;
  final $Res Function(_SelectOrder) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(_SelectOrder(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _BuyItem implements OrderEvent {
  const _BuyItem({required this.listingId, required this.walletId});
  

 final  String listingId;
 final  String walletId;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuyItemCopyWith<_BuyItem> get copyWith => __$BuyItemCopyWithImpl<_BuyItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuyItem&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.walletId, walletId) || other.walletId == walletId));
}


@override
int get hashCode => Object.hash(runtimeType,listingId,walletId);

@override
String toString() {
  return 'OrderEvent.buyItem(listingId: $listingId, walletId: $walletId)';
}


}

/// @nodoc
abstract mixin class _$BuyItemCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$BuyItemCopyWith(_BuyItem value, $Res Function(_BuyItem) _then) = __$BuyItemCopyWithImpl;
@useResult
$Res call({
 String listingId, String walletId
});




}
/// @nodoc
class __$BuyItemCopyWithImpl<$Res>
    implements _$BuyItemCopyWith<$Res> {
  __$BuyItemCopyWithImpl(this._self, this._then);

  final _BuyItem _self;
  final $Res Function(_BuyItem) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? listingId = null,Object? walletId = null,}) {
  return _then(_BuyItem(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,walletId: null == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ConfirmFulfilment implements OrderEvent {
  const _ConfirmFulfilment(this.orderId);
  

 final  String orderId;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmFulfilmentCopyWith<_ConfirmFulfilment> get copyWith => __$ConfirmFulfilmentCopyWithImpl<_ConfirmFulfilment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmFulfilment&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'OrderEvent.confirmFulfilment(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class _$ConfirmFulfilmentCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$ConfirmFulfilmentCopyWith(_ConfirmFulfilment value, $Res Function(_ConfirmFulfilment) _then) = __$ConfirmFulfilmentCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class __$ConfirmFulfilmentCopyWithImpl<$Res>
    implements _$ConfirmFulfilmentCopyWith<$Res> {
  __$ConfirmFulfilmentCopyWithImpl(this._self, this._then);

  final _ConfirmFulfilment _self;
  final $Res Function(_ConfirmFulfilment) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(_ConfirmFulfilment(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ConfirmReceipt implements OrderEvent {
  const _ConfirmReceipt(this.orderId);
  

 final  String orderId;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmReceiptCopyWith<_ConfirmReceipt> get copyWith => __$ConfirmReceiptCopyWithImpl<_ConfirmReceipt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmReceipt&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'OrderEvent.confirmReceipt(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class _$ConfirmReceiptCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$ConfirmReceiptCopyWith(_ConfirmReceipt value, $Res Function(_ConfirmReceipt) _then) = __$ConfirmReceiptCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class __$ConfirmReceiptCopyWithImpl<$Res>
    implements _$ConfirmReceiptCopyWith<$Res> {
  __$ConfirmReceiptCopyWithImpl(this._self, this._then);

  final _ConfirmReceipt _self;
  final $Res Function(_ConfirmReceipt) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(_ConfirmReceipt(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CancelOrder implements OrderEvent {
  const _CancelOrder(this.orderId);
  

 final  String orderId;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelOrderCopyWith<_CancelOrder> get copyWith => __$CancelOrderCopyWithImpl<_CancelOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelOrder&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'OrderEvent.cancelOrder(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class _$CancelOrderCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$CancelOrderCopyWith(_CancelOrder value, $Res Function(_CancelOrder) _then) = __$CancelOrderCopyWithImpl;
@useResult
$Res call({
 String orderId
});




}
/// @nodoc
class __$CancelOrderCopyWithImpl<$Res>
    implements _$CancelOrderCopyWith<$Res> {
  __$CancelOrderCopyWithImpl(this._self, this._then);

  final _CancelOrder _self;
  final $Res Function(_CancelOrder) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(_CancelOrder(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DisputeOrder implements OrderEvent {
  const _DisputeOrder({required this.orderId, required this.reason});
  

 final  String orderId;
 final  String reason;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisputeOrderCopyWith<_DisputeOrder> get copyWith => __$DisputeOrderCopyWithImpl<_DisputeOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisputeOrder&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,reason);

@override
String toString() {
  return 'OrderEvent.disputeOrder(orderId: $orderId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$DisputeOrderCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$DisputeOrderCopyWith(_DisputeOrder value, $Res Function(_DisputeOrder) _then) = __$DisputeOrderCopyWithImpl;
@useResult
$Res call({
 String orderId, String reason
});




}
/// @nodoc
class __$DisputeOrderCopyWithImpl<$Res>
    implements _$DisputeOrderCopyWith<$Res> {
  __$DisputeOrderCopyWithImpl(this._self, this._then);

  final _DisputeOrder _self;
  final $Res Function(_DisputeOrder) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? reason = null,}) {
  return _then(_DisputeOrder(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VouchForProvider implements OrderEvent {
  const _VouchForProvider({required this.providerId, required this.orderId, required this.rating, this.comment});
  

 final  String providerId;
 final  String orderId;
 final  int rating;
 final  String? comment;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VouchForProviderCopyWith<_VouchForProvider> get copyWith => __$VouchForProviderCopyWithImpl<_VouchForProvider>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VouchForProvider&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}


@override
int get hashCode => Object.hash(runtimeType,providerId,orderId,rating,comment);

@override
String toString() {
  return 'OrderEvent.vouchForProvider(providerId: $providerId, orderId: $orderId, rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$VouchForProviderCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$VouchForProviderCopyWith(_VouchForProvider value, $Res Function(_VouchForProvider) _then) = __$VouchForProviderCopyWithImpl;
@useResult
$Res call({
 String providerId, String orderId, int rating, String? comment
});




}
/// @nodoc
class __$VouchForProviderCopyWithImpl<$Res>
    implements _$VouchForProviderCopyWith<$Res> {
  __$VouchForProviderCopyWithImpl(this._self, this._then);

  final _VouchForProvider _self;
  final $Res Function(_VouchForProvider) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? providerId = null,Object? orderId = null,Object? rating = null,Object? comment = freezed,}) {
  return _then(_VouchForProvider(
providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadLinkedOffer implements OrderEvent {
  const _LoadLinkedOffer(this.offerId);
  

 final  String offerId;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadLinkedOfferCopyWith<_LoadLinkedOffer> get copyWith => __$LoadLinkedOfferCopyWithImpl<_LoadLinkedOffer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadLinkedOffer&&(identical(other.offerId, offerId) || other.offerId == offerId));
}


@override
int get hashCode => Object.hash(runtimeType,offerId);

@override
String toString() {
  return 'OrderEvent.loadLinkedOffer(offerId: $offerId)';
}


}

/// @nodoc
abstract mixin class _$LoadLinkedOfferCopyWith<$Res> implements $OrderEventCopyWith<$Res> {
  factory _$LoadLinkedOfferCopyWith(_LoadLinkedOffer value, $Res Function(_LoadLinkedOffer) _then) = __$LoadLinkedOfferCopyWithImpl;
@useResult
$Res call({
 String offerId
});




}
/// @nodoc
class __$LoadLinkedOfferCopyWithImpl<$Res>
    implements _$LoadLinkedOfferCopyWith<$Res> {
  __$LoadLinkedOfferCopyWithImpl(this._self, this._then);

  final _LoadLinkedOffer _self;
  final $Res Function(_LoadLinkedOffer) _then;

/// Create a copy of OrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? offerId = null,}) {
  return _then(_LoadLinkedOffer(
null == offerId ? _self.offerId : offerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearMessages implements OrderEvent {
  const _ClearMessages();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearMessages);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderEvent.clearMessages()';
}


}




/// @nodoc
mixin _$OrderState {

 bool get isLoading; bool get isLoadingDetail; bool get isProcessing; List<BuyOrder> get buyerOrders; List<BuyOrder> get sellerOrders; BuyOrder? get selectedOrder;/// Offer linked to the selected order (loaded via loadLinkedOffer)
 MarketplaceOffer? get linkedOffer; String? get errorMessage; String? get successMessage;
/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderStateCopyWith<OrderState> get copyWith => _$OrderStateCopyWithImpl<OrderState>(this as OrderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingDetail, isLoadingDetail) || other.isLoadingDetail == isLoadingDetail)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&const DeepCollectionEquality().equals(other.buyerOrders, buyerOrders)&&const DeepCollectionEquality().equals(other.sellerOrders, sellerOrders)&&(identical(other.selectedOrder, selectedOrder) || other.selectedOrder == selectedOrder)&&(identical(other.linkedOffer, linkedOffer) || other.linkedOffer == linkedOffer)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingDetail,isProcessing,const DeepCollectionEquality().hash(buyerOrders),const DeepCollectionEquality().hash(sellerOrders),selectedOrder,linkedOffer,errorMessage,successMessage);

@override
String toString() {
  return 'OrderState(isLoading: $isLoading, isLoadingDetail: $isLoadingDetail, isProcessing: $isProcessing, buyerOrders: $buyerOrders, sellerOrders: $sellerOrders, selectedOrder: $selectedOrder, linkedOffer: $linkedOffer, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $OrderStateCopyWith<$Res>  {
  factory $OrderStateCopyWith(OrderState value, $Res Function(OrderState) _then) = _$OrderStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingDetail, bool isProcessing, List<BuyOrder> buyerOrders, List<BuyOrder> sellerOrders, BuyOrder? selectedOrder, MarketplaceOffer? linkedOffer, String? errorMessage, String? successMessage
});


$BuyOrderCopyWith<$Res>? get selectedOrder;$MarketplaceOfferCopyWith<$Res>? get linkedOffer;

}
/// @nodoc
class _$OrderStateCopyWithImpl<$Res>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._self, this._then);

  final OrderState _self;
  final $Res Function(OrderState) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingDetail = null,Object? isProcessing = null,Object? buyerOrders = null,Object? sellerOrders = null,Object? selectedOrder = freezed,Object? linkedOffer = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingDetail: null == isLoadingDetail ? _self.isLoadingDetail : isLoadingDetail // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,buyerOrders: null == buyerOrders ? _self.buyerOrders : buyerOrders // ignore: cast_nullable_to_non_nullable
as List<BuyOrder>,sellerOrders: null == sellerOrders ? _self.sellerOrders : sellerOrders // ignore: cast_nullable_to_non_nullable
as List<BuyOrder>,selectedOrder: freezed == selectedOrder ? _self.selectedOrder : selectedOrder // ignore: cast_nullable_to_non_nullable
as BuyOrder?,linkedOffer: freezed == linkedOffer ? _self.linkedOffer : linkedOffer // ignore: cast_nullable_to_non_nullable
as MarketplaceOffer?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BuyOrderCopyWith<$Res>? get selectedOrder {
    if (_self.selectedOrder == null) {
    return null;
  }

  return $BuyOrderCopyWith<$Res>(_self.selectedOrder!, (value) {
    return _then(_self.copyWith(selectedOrder: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketplaceOfferCopyWith<$Res>? get linkedOffer {
    if (_self.linkedOffer == null) {
    return null;
  }

  return $MarketplaceOfferCopyWith<$Res>(_self.linkedOffer!, (value) {
    return _then(_self.copyWith(linkedOffer: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderState].
extension OrderStatePatterns on OrderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderState value)  $default,){
final _that = this;
switch (_that) {
case _OrderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderState value)?  $default,){
final _that = this;
switch (_that) {
case _OrderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingDetail,  bool isProcessing,  List<BuyOrder> buyerOrders,  List<BuyOrder> sellerOrders,  BuyOrder? selectedOrder,  MarketplaceOffer? linkedOffer,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderState() when $default != null:
return $default(_that.isLoading,_that.isLoadingDetail,_that.isProcessing,_that.buyerOrders,_that.sellerOrders,_that.selectedOrder,_that.linkedOffer,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingDetail,  bool isProcessing,  List<BuyOrder> buyerOrders,  List<BuyOrder> sellerOrders,  BuyOrder? selectedOrder,  MarketplaceOffer? linkedOffer,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _OrderState():
return $default(_that.isLoading,_that.isLoadingDetail,_that.isProcessing,_that.buyerOrders,_that.sellerOrders,_that.selectedOrder,_that.linkedOffer,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isLoadingDetail,  bool isProcessing,  List<BuyOrder> buyerOrders,  List<BuyOrder> sellerOrders,  BuyOrder? selectedOrder,  MarketplaceOffer? linkedOffer,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _OrderState() when $default != null:
return $default(_that.isLoading,_that.isLoadingDetail,_that.isProcessing,_that.buyerOrders,_that.sellerOrders,_that.selectedOrder,_that.linkedOffer,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _OrderState implements OrderState {
  const _OrderState({this.isLoading = false, this.isLoadingDetail = false, this.isProcessing = false, final  List<BuyOrder> buyerOrders = const [], final  List<BuyOrder> sellerOrders = const [], this.selectedOrder, this.linkedOffer, this.errorMessage, this.successMessage}): _buyerOrders = buyerOrders,_sellerOrders = sellerOrders;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingDetail;
@override@JsonKey() final  bool isProcessing;
 final  List<BuyOrder> _buyerOrders;
@override@JsonKey() List<BuyOrder> get buyerOrders {
  if (_buyerOrders is EqualUnmodifiableListView) return _buyerOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_buyerOrders);
}

 final  List<BuyOrder> _sellerOrders;
@override@JsonKey() List<BuyOrder> get sellerOrders {
  if (_sellerOrders is EqualUnmodifiableListView) return _sellerOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sellerOrders);
}

@override final  BuyOrder? selectedOrder;
/// Offer linked to the selected order (loaded via loadLinkedOffer)
@override final  MarketplaceOffer? linkedOffer;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderStateCopyWith<_OrderState> get copyWith => __$OrderStateCopyWithImpl<_OrderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingDetail, isLoadingDetail) || other.isLoadingDetail == isLoadingDetail)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&const DeepCollectionEquality().equals(other._buyerOrders, _buyerOrders)&&const DeepCollectionEquality().equals(other._sellerOrders, _sellerOrders)&&(identical(other.selectedOrder, selectedOrder) || other.selectedOrder == selectedOrder)&&(identical(other.linkedOffer, linkedOffer) || other.linkedOffer == linkedOffer)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingDetail,isProcessing,const DeepCollectionEquality().hash(_buyerOrders),const DeepCollectionEquality().hash(_sellerOrders),selectedOrder,linkedOffer,errorMessage,successMessage);

@override
String toString() {
  return 'OrderState(isLoading: $isLoading, isLoadingDetail: $isLoadingDetail, isProcessing: $isProcessing, buyerOrders: $buyerOrders, sellerOrders: $sellerOrders, selectedOrder: $selectedOrder, linkedOffer: $linkedOffer, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$OrderStateCopyWith<$Res> implements $OrderStateCopyWith<$Res> {
  factory _$OrderStateCopyWith(_OrderState value, $Res Function(_OrderState) _then) = __$OrderStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingDetail, bool isProcessing, List<BuyOrder> buyerOrders, List<BuyOrder> sellerOrders, BuyOrder? selectedOrder, MarketplaceOffer? linkedOffer, String? errorMessage, String? successMessage
});


@override $BuyOrderCopyWith<$Res>? get selectedOrder;@override $MarketplaceOfferCopyWith<$Res>? get linkedOffer;

}
/// @nodoc
class __$OrderStateCopyWithImpl<$Res>
    implements _$OrderStateCopyWith<$Res> {
  __$OrderStateCopyWithImpl(this._self, this._then);

  final _OrderState _self;
  final $Res Function(_OrderState) _then;

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingDetail = null,Object? isProcessing = null,Object? buyerOrders = null,Object? sellerOrders = null,Object? selectedOrder = freezed,Object? linkedOffer = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_OrderState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingDetail: null == isLoadingDetail ? _self.isLoadingDetail : isLoadingDetail // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,buyerOrders: null == buyerOrders ? _self._buyerOrders : buyerOrders // ignore: cast_nullable_to_non_nullable
as List<BuyOrder>,sellerOrders: null == sellerOrders ? _self._sellerOrders : sellerOrders // ignore: cast_nullable_to_non_nullable
as List<BuyOrder>,selectedOrder: freezed == selectedOrder ? _self.selectedOrder : selectedOrder // ignore: cast_nullable_to_non_nullable
as BuyOrder?,linkedOffer: freezed == linkedOffer ? _self.linkedOffer : linkedOffer // ignore: cast_nullable_to_non_nullable
as MarketplaceOffer?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BuyOrderCopyWith<$Res>? get selectedOrder {
    if (_self.selectedOrder == null) {
    return null;
  }

  return $BuyOrderCopyWith<$Res>(_self.selectedOrder!, (value) {
    return _then(_self.copyWith(selectedOrder: value));
  });
}/// Create a copy of OrderState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarketplaceOfferCopyWith<$Res>? get linkedOffer {
    if (_self.linkedOffer == null) {
    return null;
  }

  return $MarketplaceOfferCopyWith<$Res>(_self.linkedOffer!, (value) {
    return _then(_self.copyWith(linkedOffer: value));
  });
}
}

// dart format on
