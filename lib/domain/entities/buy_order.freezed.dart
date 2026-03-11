// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buy_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BuyOrder {

 String get id; String get buyerId; String get buyerName; String get sellerId; String get sellerName; String get listingId; String get listingTitle; int get amount; double get amountZar; OrderStatus get status; String? get escrowJournalId; String? get releaseJournalId; String? get refundJournalId; String? get disputeReason; String? get disputeResolution; String? get chatConversationId; String? get thumbnailUrl; DateTime get createdAt; DateTime? get escrowedAt; DateTime? get fulfilledAt; DateTime? get completedAt; DateTime? get disputedAt; DateTime? get resolvedAt; DateTime? get cancelledAt;
/// Create a copy of BuyOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuyOrderCopyWith<BuyOrder> get copyWith => _$BuyOrderCopyWithImpl<BuyOrder>(this as BuyOrder, _$identity);

  /// Serializes this BuyOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuyOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.listingTitle, listingTitle) || other.listingTitle == listingTitle)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountZar, amountZar) || other.amountZar == amountZar)&&(identical(other.status, status) || other.status == status)&&(identical(other.escrowJournalId, escrowJournalId) || other.escrowJournalId == escrowJournalId)&&(identical(other.releaseJournalId, releaseJournalId) || other.releaseJournalId == releaseJournalId)&&(identical(other.refundJournalId, refundJournalId) || other.refundJournalId == refundJournalId)&&(identical(other.disputeReason, disputeReason) || other.disputeReason == disputeReason)&&(identical(other.disputeResolution, disputeResolution) || other.disputeResolution == disputeResolution)&&(identical(other.chatConversationId, chatConversationId) || other.chatConversationId == chatConversationId)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.escrowedAt, escrowedAt) || other.escrowedAt == escrowedAt)&&(identical(other.fulfilledAt, fulfilledAt) || other.fulfilledAt == fulfilledAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.disputedAt, disputedAt) || other.disputedAt == disputedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,buyerId,buyerName,sellerId,sellerName,listingId,listingTitle,amount,amountZar,status,escrowJournalId,releaseJournalId,refundJournalId,disputeReason,disputeResolution,chatConversationId,thumbnailUrl,createdAt,escrowedAt,fulfilledAt,completedAt,disputedAt,resolvedAt,cancelledAt]);

@override
String toString() {
  return 'BuyOrder(id: $id, buyerId: $buyerId, buyerName: $buyerName, sellerId: $sellerId, sellerName: $sellerName, listingId: $listingId, listingTitle: $listingTitle, amount: $amount, amountZar: $amountZar, status: $status, escrowJournalId: $escrowJournalId, releaseJournalId: $releaseJournalId, refundJournalId: $refundJournalId, disputeReason: $disputeReason, disputeResolution: $disputeResolution, chatConversationId: $chatConversationId, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt, escrowedAt: $escrowedAt, fulfilledAt: $fulfilledAt, completedAt: $completedAt, disputedAt: $disputedAt, resolvedAt: $resolvedAt, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class $BuyOrderCopyWith<$Res>  {
  factory $BuyOrderCopyWith(BuyOrder value, $Res Function(BuyOrder) _then) = _$BuyOrderCopyWithImpl;
@useResult
$Res call({
 String id, String buyerId, String buyerName, String sellerId, String sellerName, String listingId, String listingTitle, int amount, double amountZar, OrderStatus status, String? escrowJournalId, String? releaseJournalId, String? refundJournalId, String? disputeReason, String? disputeResolution, String? chatConversationId, String? thumbnailUrl, DateTime createdAt, DateTime? escrowedAt, DateTime? fulfilledAt, DateTime? completedAt, DateTime? disputedAt, DateTime? resolvedAt, DateTime? cancelledAt
});




}
/// @nodoc
class _$BuyOrderCopyWithImpl<$Res>
    implements $BuyOrderCopyWith<$Res> {
  _$BuyOrderCopyWithImpl(this._self, this._then);

  final BuyOrder _self;
  final $Res Function(BuyOrder) _then;

/// Create a copy of BuyOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? buyerId = null,Object? buyerName = null,Object? sellerId = null,Object? sellerName = null,Object? listingId = null,Object? listingTitle = null,Object? amount = null,Object? amountZar = null,Object? status = null,Object? escrowJournalId = freezed,Object? releaseJournalId = freezed,Object? refundJournalId = freezed,Object? disputeReason = freezed,Object? disputeResolution = freezed,Object? chatConversationId = freezed,Object? thumbnailUrl = freezed,Object? createdAt = null,Object? escrowedAt = freezed,Object? fulfilledAt = freezed,Object? completedAt = freezed,Object? disputedAt = freezed,Object? resolvedAt = freezed,Object? cancelledAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,buyerName: null == buyerName ? _self.buyerName : buyerName // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,listingTitle: null == listingTitle ? _self.listingTitle : listingTitle // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,amountZar: null == amountZar ? _self.amountZar : amountZar // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,escrowJournalId: freezed == escrowJournalId ? _self.escrowJournalId : escrowJournalId // ignore: cast_nullable_to_non_nullable
as String?,releaseJournalId: freezed == releaseJournalId ? _self.releaseJournalId : releaseJournalId // ignore: cast_nullable_to_non_nullable
as String?,refundJournalId: freezed == refundJournalId ? _self.refundJournalId : refundJournalId // ignore: cast_nullable_to_non_nullable
as String?,disputeReason: freezed == disputeReason ? _self.disputeReason : disputeReason // ignore: cast_nullable_to_non_nullable
as String?,disputeResolution: freezed == disputeResolution ? _self.disputeResolution : disputeResolution // ignore: cast_nullable_to_non_nullable
as String?,chatConversationId: freezed == chatConversationId ? _self.chatConversationId : chatConversationId // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,escrowedAt: freezed == escrowedAt ? _self.escrowedAt : escrowedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fulfilledAt: freezed == fulfilledAt ? _self.fulfilledAt : fulfilledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,disputedAt: freezed == disputedAt ? _self.disputedAt : disputedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BuyOrder].
extension BuyOrderPatterns on BuyOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuyOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuyOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuyOrder value)  $default,){
final _that = this;
switch (_that) {
case _BuyOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuyOrder value)?  $default,){
final _that = this;
switch (_that) {
case _BuyOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String buyerId,  String buyerName,  String sellerId,  String sellerName,  String listingId,  String listingTitle,  int amount,  double amountZar,  OrderStatus status,  String? escrowJournalId,  String? releaseJournalId,  String? refundJournalId,  String? disputeReason,  String? disputeResolution,  String? chatConversationId,  String? thumbnailUrl,  DateTime createdAt,  DateTime? escrowedAt,  DateTime? fulfilledAt,  DateTime? completedAt,  DateTime? disputedAt,  DateTime? resolvedAt,  DateTime? cancelledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuyOrder() when $default != null:
return $default(_that.id,_that.buyerId,_that.buyerName,_that.sellerId,_that.sellerName,_that.listingId,_that.listingTitle,_that.amount,_that.amountZar,_that.status,_that.escrowJournalId,_that.releaseJournalId,_that.refundJournalId,_that.disputeReason,_that.disputeResolution,_that.chatConversationId,_that.thumbnailUrl,_that.createdAt,_that.escrowedAt,_that.fulfilledAt,_that.completedAt,_that.disputedAt,_that.resolvedAt,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String buyerId,  String buyerName,  String sellerId,  String sellerName,  String listingId,  String listingTitle,  int amount,  double amountZar,  OrderStatus status,  String? escrowJournalId,  String? releaseJournalId,  String? refundJournalId,  String? disputeReason,  String? disputeResolution,  String? chatConversationId,  String? thumbnailUrl,  DateTime createdAt,  DateTime? escrowedAt,  DateTime? fulfilledAt,  DateTime? completedAt,  DateTime? disputedAt,  DateTime? resolvedAt,  DateTime? cancelledAt)  $default,) {final _that = this;
switch (_that) {
case _BuyOrder():
return $default(_that.id,_that.buyerId,_that.buyerName,_that.sellerId,_that.sellerName,_that.listingId,_that.listingTitle,_that.amount,_that.amountZar,_that.status,_that.escrowJournalId,_that.releaseJournalId,_that.refundJournalId,_that.disputeReason,_that.disputeResolution,_that.chatConversationId,_that.thumbnailUrl,_that.createdAt,_that.escrowedAt,_that.fulfilledAt,_that.completedAt,_that.disputedAt,_that.resolvedAt,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String buyerId,  String buyerName,  String sellerId,  String sellerName,  String listingId,  String listingTitle,  int amount,  double amountZar,  OrderStatus status,  String? escrowJournalId,  String? releaseJournalId,  String? refundJournalId,  String? disputeReason,  String? disputeResolution,  String? chatConversationId,  String? thumbnailUrl,  DateTime createdAt,  DateTime? escrowedAt,  DateTime? fulfilledAt,  DateTime? completedAt,  DateTime? disputedAt,  DateTime? resolvedAt,  DateTime? cancelledAt)?  $default,) {final _that = this;
switch (_that) {
case _BuyOrder() when $default != null:
return $default(_that.id,_that.buyerId,_that.buyerName,_that.sellerId,_that.sellerName,_that.listingId,_that.listingTitle,_that.amount,_that.amountZar,_that.status,_that.escrowJournalId,_that.releaseJournalId,_that.refundJournalId,_that.disputeReason,_that.disputeResolution,_that.chatConversationId,_that.thumbnailUrl,_that.createdAt,_that.escrowedAt,_that.fulfilledAt,_that.completedAt,_that.disputedAt,_that.resolvedAt,_that.cancelledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BuyOrder extends BuyOrder {
  const _BuyOrder({required this.id, required this.buyerId, required this.buyerName, required this.sellerId, required this.sellerName, required this.listingId, required this.listingTitle, required this.amount, required this.amountZar, required this.status, this.escrowJournalId, this.releaseJournalId, this.refundJournalId, this.disputeReason, this.disputeResolution, this.chatConversationId, this.thumbnailUrl, required this.createdAt, this.escrowedAt, this.fulfilledAt, this.completedAt, this.disputedAt, this.resolvedAt, this.cancelledAt}): super._();
  factory _BuyOrder.fromJson(Map<String, dynamic> json) => _$BuyOrderFromJson(json);

@override final  String id;
@override final  String buyerId;
@override final  String buyerName;
@override final  String sellerId;
@override final  String sellerName;
@override final  String listingId;
@override final  String listingTitle;
@override final  int amount;
@override final  double amountZar;
@override final  OrderStatus status;
@override final  String? escrowJournalId;
@override final  String? releaseJournalId;
@override final  String? refundJournalId;
@override final  String? disputeReason;
@override final  String? disputeResolution;
@override final  String? chatConversationId;
@override final  String? thumbnailUrl;
@override final  DateTime createdAt;
@override final  DateTime? escrowedAt;
@override final  DateTime? fulfilledAt;
@override final  DateTime? completedAt;
@override final  DateTime? disputedAt;
@override final  DateTime? resolvedAt;
@override final  DateTime? cancelledAt;

/// Create a copy of BuyOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuyOrderCopyWith<_BuyOrder> get copyWith => __$BuyOrderCopyWithImpl<_BuyOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BuyOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuyOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.listingTitle, listingTitle) || other.listingTitle == listingTitle)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountZar, amountZar) || other.amountZar == amountZar)&&(identical(other.status, status) || other.status == status)&&(identical(other.escrowJournalId, escrowJournalId) || other.escrowJournalId == escrowJournalId)&&(identical(other.releaseJournalId, releaseJournalId) || other.releaseJournalId == releaseJournalId)&&(identical(other.refundJournalId, refundJournalId) || other.refundJournalId == refundJournalId)&&(identical(other.disputeReason, disputeReason) || other.disputeReason == disputeReason)&&(identical(other.disputeResolution, disputeResolution) || other.disputeResolution == disputeResolution)&&(identical(other.chatConversationId, chatConversationId) || other.chatConversationId == chatConversationId)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.escrowedAt, escrowedAt) || other.escrowedAt == escrowedAt)&&(identical(other.fulfilledAt, fulfilledAt) || other.fulfilledAt == fulfilledAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.disputedAt, disputedAt) || other.disputedAt == disputedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,buyerId,buyerName,sellerId,sellerName,listingId,listingTitle,amount,amountZar,status,escrowJournalId,releaseJournalId,refundJournalId,disputeReason,disputeResolution,chatConversationId,thumbnailUrl,createdAt,escrowedAt,fulfilledAt,completedAt,disputedAt,resolvedAt,cancelledAt]);

@override
String toString() {
  return 'BuyOrder(id: $id, buyerId: $buyerId, buyerName: $buyerName, sellerId: $sellerId, sellerName: $sellerName, listingId: $listingId, listingTitle: $listingTitle, amount: $amount, amountZar: $amountZar, status: $status, escrowJournalId: $escrowJournalId, releaseJournalId: $releaseJournalId, refundJournalId: $refundJournalId, disputeReason: $disputeReason, disputeResolution: $disputeResolution, chatConversationId: $chatConversationId, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt, escrowedAt: $escrowedAt, fulfilledAt: $fulfilledAt, completedAt: $completedAt, disputedAt: $disputedAt, resolvedAt: $resolvedAt, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class _$BuyOrderCopyWith<$Res> implements $BuyOrderCopyWith<$Res> {
  factory _$BuyOrderCopyWith(_BuyOrder value, $Res Function(_BuyOrder) _then) = __$BuyOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String buyerId, String buyerName, String sellerId, String sellerName, String listingId, String listingTitle, int amount, double amountZar, OrderStatus status, String? escrowJournalId, String? releaseJournalId, String? refundJournalId, String? disputeReason, String? disputeResolution, String? chatConversationId, String? thumbnailUrl, DateTime createdAt, DateTime? escrowedAt, DateTime? fulfilledAt, DateTime? completedAt, DateTime? disputedAt, DateTime? resolvedAt, DateTime? cancelledAt
});




}
/// @nodoc
class __$BuyOrderCopyWithImpl<$Res>
    implements _$BuyOrderCopyWith<$Res> {
  __$BuyOrderCopyWithImpl(this._self, this._then);

  final _BuyOrder _self;
  final $Res Function(_BuyOrder) _then;

/// Create a copy of BuyOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? buyerId = null,Object? buyerName = null,Object? sellerId = null,Object? sellerName = null,Object? listingId = null,Object? listingTitle = null,Object? amount = null,Object? amountZar = null,Object? status = null,Object? escrowJournalId = freezed,Object? releaseJournalId = freezed,Object? refundJournalId = freezed,Object? disputeReason = freezed,Object? disputeResolution = freezed,Object? chatConversationId = freezed,Object? thumbnailUrl = freezed,Object? createdAt = null,Object? escrowedAt = freezed,Object? fulfilledAt = freezed,Object? completedAt = freezed,Object? disputedAt = freezed,Object? resolvedAt = freezed,Object? cancelledAt = freezed,}) {
  return _then(_BuyOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,buyerName: null == buyerName ? _self.buyerName : buyerName // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,listingTitle: null == listingTitle ? _self.listingTitle : listingTitle // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,amountZar: null == amountZar ? _self.amountZar : amountZar // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,escrowJournalId: freezed == escrowJournalId ? _self.escrowJournalId : escrowJournalId // ignore: cast_nullable_to_non_nullable
as String?,releaseJournalId: freezed == releaseJournalId ? _self.releaseJournalId : releaseJournalId // ignore: cast_nullable_to_non_nullable
as String?,refundJournalId: freezed == refundJournalId ? _self.refundJournalId : refundJournalId // ignore: cast_nullable_to_non_nullable
as String?,disputeReason: freezed == disputeReason ? _self.disputeReason : disputeReason // ignore: cast_nullable_to_non_nullable
as String?,disputeResolution: freezed == disputeResolution ? _self.disputeResolution : disputeResolution // ignore: cast_nullable_to_non_nullable
as String?,chatConversationId: freezed == chatConversationId ? _self.chatConversationId : chatConversationId // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,escrowedAt: freezed == escrowedAt ? _self.escrowedAt : escrowedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fulfilledAt: freezed == fulfilledAt ? _self.fulfilledAt : fulfilledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,disputedAt: freezed == disputedAt ? _self.disputedAt : disputedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
