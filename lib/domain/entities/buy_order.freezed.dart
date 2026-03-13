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

 String get id; String get buyerId; String get buyerName; String get sellerId; String get sellerName; String get listingId; String get listingTitle; int get amount; double get amountZar; OrderStatus get status; String? get escrowJournalId; String? get releaseJournalId; String? get refundJournalId; String? get disputeReason; String? get disputeResolution; String? get chatConversationId; String? get thumbnailUrl; DateTime get createdAt; DateTime? get escrowedAt; DateTime? get fulfilledAt; DateTime? get completedAt; DateTime? get disputedAt; DateTime? get resolvedAt; DateTime? get cancelledAt;// ── New fields (Spec §8.25) ──
 int? get deliveryFee; int get totalAmount; DeliveryMethod? get deliveryMethod; String? get deliveredVia; String? get trackingInfo; DateTime? get deliveryDeadline; DateTime? get buyerConfirmationDeadline; RefundType? get refundType; String? get disputeDetails; List<String> get disputePhotos; String? get offerId; String? get sellerDisputeResponse; List<String> get sellerDisputePhotos; String? get sellerProposedResolution; int? get disputeResolutionAmount; String? get disputeResolutionNote; DateTime? get sellerRespondedAt; bool get adminReviewRequired; String? get adminReviewReason; DateTime? get refundedAt; int get version;
/// Create a copy of BuyOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuyOrderCopyWith<BuyOrder> get copyWith => _$BuyOrderCopyWithImpl<BuyOrder>(this as BuyOrder, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuyOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.listingTitle, listingTitle) || other.listingTitle == listingTitle)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountZar, amountZar) || other.amountZar == amountZar)&&(identical(other.status, status) || other.status == status)&&(identical(other.escrowJournalId, escrowJournalId) || other.escrowJournalId == escrowJournalId)&&(identical(other.releaseJournalId, releaseJournalId) || other.releaseJournalId == releaseJournalId)&&(identical(other.refundJournalId, refundJournalId) || other.refundJournalId == refundJournalId)&&(identical(other.disputeReason, disputeReason) || other.disputeReason == disputeReason)&&(identical(other.disputeResolution, disputeResolution) || other.disputeResolution == disputeResolution)&&(identical(other.chatConversationId, chatConversationId) || other.chatConversationId == chatConversationId)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.escrowedAt, escrowedAt) || other.escrowedAt == escrowedAt)&&(identical(other.fulfilledAt, fulfilledAt) || other.fulfilledAt == fulfilledAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.disputedAt, disputedAt) || other.disputedAt == disputedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.deliveryMethod, deliveryMethod) || other.deliveryMethod == deliveryMethod)&&(identical(other.deliveredVia, deliveredVia) || other.deliveredVia == deliveredVia)&&(identical(other.trackingInfo, trackingInfo) || other.trackingInfo == trackingInfo)&&(identical(other.deliveryDeadline, deliveryDeadline) || other.deliveryDeadline == deliveryDeadline)&&(identical(other.buyerConfirmationDeadline, buyerConfirmationDeadline) || other.buyerConfirmationDeadline == buyerConfirmationDeadline)&&(identical(other.refundType, refundType) || other.refundType == refundType)&&(identical(other.disputeDetails, disputeDetails) || other.disputeDetails == disputeDetails)&&const DeepCollectionEquality().equals(other.disputePhotos, disputePhotos)&&(identical(other.offerId, offerId) || other.offerId == offerId)&&(identical(other.sellerDisputeResponse, sellerDisputeResponse) || other.sellerDisputeResponse == sellerDisputeResponse)&&const DeepCollectionEquality().equals(other.sellerDisputePhotos, sellerDisputePhotos)&&(identical(other.sellerProposedResolution, sellerProposedResolution) || other.sellerProposedResolution == sellerProposedResolution)&&(identical(other.disputeResolutionAmount, disputeResolutionAmount) || other.disputeResolutionAmount == disputeResolutionAmount)&&(identical(other.disputeResolutionNote, disputeResolutionNote) || other.disputeResolutionNote == disputeResolutionNote)&&(identical(other.sellerRespondedAt, sellerRespondedAt) || other.sellerRespondedAt == sellerRespondedAt)&&(identical(other.adminReviewRequired, adminReviewRequired) || other.adminReviewRequired == adminReviewRequired)&&(identical(other.adminReviewReason, adminReviewReason) || other.adminReviewReason == adminReviewReason)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,buyerId,buyerName,sellerId,sellerName,listingId,listingTitle,amount,amountZar,status,escrowJournalId,releaseJournalId,refundJournalId,disputeReason,disputeResolution,chatConversationId,thumbnailUrl,createdAt,escrowedAt,fulfilledAt,completedAt,disputedAt,resolvedAt,cancelledAt,deliveryFee,totalAmount,deliveryMethod,deliveredVia,trackingInfo,deliveryDeadline,buyerConfirmationDeadline,refundType,disputeDetails,const DeepCollectionEquality().hash(disputePhotos),offerId,sellerDisputeResponse,const DeepCollectionEquality().hash(sellerDisputePhotos),sellerProposedResolution,disputeResolutionAmount,disputeResolutionNote,sellerRespondedAt,adminReviewRequired,adminReviewReason,refundedAt,version]);

@override
String toString() {
  return 'BuyOrder(id: $id, buyerId: $buyerId, buyerName: $buyerName, sellerId: $sellerId, sellerName: $sellerName, listingId: $listingId, listingTitle: $listingTitle, amount: $amount, amountZar: $amountZar, status: $status, escrowJournalId: $escrowJournalId, releaseJournalId: $releaseJournalId, refundJournalId: $refundJournalId, disputeReason: $disputeReason, disputeResolution: $disputeResolution, chatConversationId: $chatConversationId, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt, escrowedAt: $escrowedAt, fulfilledAt: $fulfilledAt, completedAt: $completedAt, disputedAt: $disputedAt, resolvedAt: $resolvedAt, cancelledAt: $cancelledAt, deliveryFee: $deliveryFee, totalAmount: $totalAmount, deliveryMethod: $deliveryMethod, deliveredVia: $deliveredVia, trackingInfo: $trackingInfo, deliveryDeadline: $deliveryDeadline, buyerConfirmationDeadline: $buyerConfirmationDeadline, refundType: $refundType, disputeDetails: $disputeDetails, disputePhotos: $disputePhotos, offerId: $offerId, sellerDisputeResponse: $sellerDisputeResponse, sellerDisputePhotos: $sellerDisputePhotos, sellerProposedResolution: $sellerProposedResolution, disputeResolutionAmount: $disputeResolutionAmount, disputeResolutionNote: $disputeResolutionNote, sellerRespondedAt: $sellerRespondedAt, adminReviewRequired: $adminReviewRequired, adminReviewReason: $adminReviewReason, refundedAt: $refundedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $BuyOrderCopyWith<$Res>  {
  factory $BuyOrderCopyWith(BuyOrder value, $Res Function(BuyOrder) _then) = _$BuyOrderCopyWithImpl;
@useResult
$Res call({
 String id, String buyerId, String buyerName, String sellerId, String sellerName, String listingId, String listingTitle, int amount, double amountZar, OrderStatus status, String? escrowJournalId, String? releaseJournalId, String? refundJournalId, String? disputeReason, String? disputeResolution, String? chatConversationId, String? thumbnailUrl, DateTime createdAt, DateTime? escrowedAt, DateTime? fulfilledAt, DateTime? completedAt, DateTime? disputedAt, DateTime? resolvedAt, DateTime? cancelledAt, int? deliveryFee, int totalAmount, DeliveryMethod? deliveryMethod, String? deliveredVia, String? trackingInfo, DateTime? deliveryDeadline, DateTime? buyerConfirmationDeadline, RefundType? refundType, String? disputeDetails, List<String> disputePhotos, String? offerId, String? sellerDisputeResponse, List<String> sellerDisputePhotos, String? sellerProposedResolution, int? disputeResolutionAmount, String? disputeResolutionNote, DateTime? sellerRespondedAt, bool adminReviewRequired, String? adminReviewReason, DateTime? refundedAt, int version
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? buyerId = null,Object? buyerName = null,Object? sellerId = null,Object? sellerName = null,Object? listingId = null,Object? listingTitle = null,Object? amount = null,Object? amountZar = null,Object? status = null,Object? escrowJournalId = freezed,Object? releaseJournalId = freezed,Object? refundJournalId = freezed,Object? disputeReason = freezed,Object? disputeResolution = freezed,Object? chatConversationId = freezed,Object? thumbnailUrl = freezed,Object? createdAt = null,Object? escrowedAt = freezed,Object? fulfilledAt = freezed,Object? completedAt = freezed,Object? disputedAt = freezed,Object? resolvedAt = freezed,Object? cancelledAt = freezed,Object? deliveryFee = freezed,Object? totalAmount = null,Object? deliveryMethod = freezed,Object? deliveredVia = freezed,Object? trackingInfo = freezed,Object? deliveryDeadline = freezed,Object? buyerConfirmationDeadline = freezed,Object? refundType = freezed,Object? disputeDetails = freezed,Object? disputePhotos = null,Object? offerId = freezed,Object? sellerDisputeResponse = freezed,Object? sellerDisputePhotos = null,Object? sellerProposedResolution = freezed,Object? disputeResolutionAmount = freezed,Object? disputeResolutionNote = freezed,Object? sellerRespondedAt = freezed,Object? adminReviewRequired = null,Object? adminReviewReason = freezed,Object? refundedAt = freezed,Object? version = null,}) {
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
as DateTime?,deliveryFee: freezed == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as int?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,deliveryMethod: freezed == deliveryMethod ? _self.deliveryMethod : deliveryMethod // ignore: cast_nullable_to_non_nullable
as DeliveryMethod?,deliveredVia: freezed == deliveredVia ? _self.deliveredVia : deliveredVia // ignore: cast_nullable_to_non_nullable
as String?,trackingInfo: freezed == trackingInfo ? _self.trackingInfo : trackingInfo // ignore: cast_nullable_to_non_nullable
as String?,deliveryDeadline: freezed == deliveryDeadline ? _self.deliveryDeadline : deliveryDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerConfirmationDeadline: freezed == buyerConfirmationDeadline ? _self.buyerConfirmationDeadline : buyerConfirmationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,refundType: freezed == refundType ? _self.refundType : refundType // ignore: cast_nullable_to_non_nullable
as RefundType?,disputeDetails: freezed == disputeDetails ? _self.disputeDetails : disputeDetails // ignore: cast_nullable_to_non_nullable
as String?,disputePhotos: null == disputePhotos ? _self.disputePhotos : disputePhotos // ignore: cast_nullable_to_non_nullable
as List<String>,offerId: freezed == offerId ? _self.offerId : offerId // ignore: cast_nullable_to_non_nullable
as String?,sellerDisputeResponse: freezed == sellerDisputeResponse ? _self.sellerDisputeResponse : sellerDisputeResponse // ignore: cast_nullable_to_non_nullable
as String?,sellerDisputePhotos: null == sellerDisputePhotos ? _self.sellerDisputePhotos : sellerDisputePhotos // ignore: cast_nullable_to_non_nullable
as List<String>,sellerProposedResolution: freezed == sellerProposedResolution ? _self.sellerProposedResolution : sellerProposedResolution // ignore: cast_nullable_to_non_nullable
as String?,disputeResolutionAmount: freezed == disputeResolutionAmount ? _self.disputeResolutionAmount : disputeResolutionAmount // ignore: cast_nullable_to_non_nullable
as int?,disputeResolutionNote: freezed == disputeResolutionNote ? _self.disputeResolutionNote : disputeResolutionNote // ignore: cast_nullable_to_non_nullable
as String?,sellerRespondedAt: freezed == sellerRespondedAt ? _self.sellerRespondedAt : sellerRespondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminReviewRequired: null == adminReviewRequired ? _self.adminReviewRequired : adminReviewRequired // ignore: cast_nullable_to_non_nullable
as bool,adminReviewReason: freezed == adminReviewReason ? _self.adminReviewReason : adminReviewReason // ignore: cast_nullable_to_non_nullable
as String?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String buyerId,  String buyerName,  String sellerId,  String sellerName,  String listingId,  String listingTitle,  int amount,  double amountZar,  OrderStatus status,  String? escrowJournalId,  String? releaseJournalId,  String? refundJournalId,  String? disputeReason,  String? disputeResolution,  String? chatConversationId,  String? thumbnailUrl,  DateTime createdAt,  DateTime? escrowedAt,  DateTime? fulfilledAt,  DateTime? completedAt,  DateTime? disputedAt,  DateTime? resolvedAt,  DateTime? cancelledAt,  int? deliveryFee,  int totalAmount,  DeliveryMethod? deliveryMethod,  String? deliveredVia,  String? trackingInfo,  DateTime? deliveryDeadline,  DateTime? buyerConfirmationDeadline,  RefundType? refundType,  String? disputeDetails,  List<String> disputePhotos,  String? offerId,  String? sellerDisputeResponse,  List<String> sellerDisputePhotos,  String? sellerProposedResolution,  int? disputeResolutionAmount,  String? disputeResolutionNote,  DateTime? sellerRespondedAt,  bool adminReviewRequired,  String? adminReviewReason,  DateTime? refundedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuyOrder() when $default != null:
return $default(_that.id,_that.buyerId,_that.buyerName,_that.sellerId,_that.sellerName,_that.listingId,_that.listingTitle,_that.amount,_that.amountZar,_that.status,_that.escrowJournalId,_that.releaseJournalId,_that.refundJournalId,_that.disputeReason,_that.disputeResolution,_that.chatConversationId,_that.thumbnailUrl,_that.createdAt,_that.escrowedAt,_that.fulfilledAt,_that.completedAt,_that.disputedAt,_that.resolvedAt,_that.cancelledAt,_that.deliveryFee,_that.totalAmount,_that.deliveryMethod,_that.deliveredVia,_that.trackingInfo,_that.deliveryDeadline,_that.buyerConfirmationDeadline,_that.refundType,_that.disputeDetails,_that.disputePhotos,_that.offerId,_that.sellerDisputeResponse,_that.sellerDisputePhotos,_that.sellerProposedResolution,_that.disputeResolutionAmount,_that.disputeResolutionNote,_that.sellerRespondedAt,_that.adminReviewRequired,_that.adminReviewReason,_that.refundedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String buyerId,  String buyerName,  String sellerId,  String sellerName,  String listingId,  String listingTitle,  int amount,  double amountZar,  OrderStatus status,  String? escrowJournalId,  String? releaseJournalId,  String? refundJournalId,  String? disputeReason,  String? disputeResolution,  String? chatConversationId,  String? thumbnailUrl,  DateTime createdAt,  DateTime? escrowedAt,  DateTime? fulfilledAt,  DateTime? completedAt,  DateTime? disputedAt,  DateTime? resolvedAt,  DateTime? cancelledAt,  int? deliveryFee,  int totalAmount,  DeliveryMethod? deliveryMethod,  String? deliveredVia,  String? trackingInfo,  DateTime? deliveryDeadline,  DateTime? buyerConfirmationDeadline,  RefundType? refundType,  String? disputeDetails,  List<String> disputePhotos,  String? offerId,  String? sellerDisputeResponse,  List<String> sellerDisputePhotos,  String? sellerProposedResolution,  int? disputeResolutionAmount,  String? disputeResolutionNote,  DateTime? sellerRespondedAt,  bool adminReviewRequired,  String? adminReviewReason,  DateTime? refundedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _BuyOrder():
return $default(_that.id,_that.buyerId,_that.buyerName,_that.sellerId,_that.sellerName,_that.listingId,_that.listingTitle,_that.amount,_that.amountZar,_that.status,_that.escrowJournalId,_that.releaseJournalId,_that.refundJournalId,_that.disputeReason,_that.disputeResolution,_that.chatConversationId,_that.thumbnailUrl,_that.createdAt,_that.escrowedAt,_that.fulfilledAt,_that.completedAt,_that.disputedAt,_that.resolvedAt,_that.cancelledAt,_that.deliveryFee,_that.totalAmount,_that.deliveryMethod,_that.deliveredVia,_that.trackingInfo,_that.deliveryDeadline,_that.buyerConfirmationDeadline,_that.refundType,_that.disputeDetails,_that.disputePhotos,_that.offerId,_that.sellerDisputeResponse,_that.sellerDisputePhotos,_that.sellerProposedResolution,_that.disputeResolutionAmount,_that.disputeResolutionNote,_that.sellerRespondedAt,_that.adminReviewRequired,_that.adminReviewReason,_that.refundedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String buyerId,  String buyerName,  String sellerId,  String sellerName,  String listingId,  String listingTitle,  int amount,  double amountZar,  OrderStatus status,  String? escrowJournalId,  String? releaseJournalId,  String? refundJournalId,  String? disputeReason,  String? disputeResolution,  String? chatConversationId,  String? thumbnailUrl,  DateTime createdAt,  DateTime? escrowedAt,  DateTime? fulfilledAt,  DateTime? completedAt,  DateTime? disputedAt,  DateTime? resolvedAt,  DateTime? cancelledAt,  int? deliveryFee,  int totalAmount,  DeliveryMethod? deliveryMethod,  String? deliveredVia,  String? trackingInfo,  DateTime? deliveryDeadline,  DateTime? buyerConfirmationDeadline,  RefundType? refundType,  String? disputeDetails,  List<String> disputePhotos,  String? offerId,  String? sellerDisputeResponse,  List<String> sellerDisputePhotos,  String? sellerProposedResolution,  int? disputeResolutionAmount,  String? disputeResolutionNote,  DateTime? sellerRespondedAt,  bool adminReviewRequired,  String? adminReviewReason,  DateTime? refundedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _BuyOrder() when $default != null:
return $default(_that.id,_that.buyerId,_that.buyerName,_that.sellerId,_that.sellerName,_that.listingId,_that.listingTitle,_that.amount,_that.amountZar,_that.status,_that.escrowJournalId,_that.releaseJournalId,_that.refundJournalId,_that.disputeReason,_that.disputeResolution,_that.chatConversationId,_that.thumbnailUrl,_that.createdAt,_that.escrowedAt,_that.fulfilledAt,_that.completedAt,_that.disputedAt,_that.resolvedAt,_that.cancelledAt,_that.deliveryFee,_that.totalAmount,_that.deliveryMethod,_that.deliveredVia,_that.trackingInfo,_that.deliveryDeadline,_that.buyerConfirmationDeadline,_that.refundType,_that.disputeDetails,_that.disputePhotos,_that.offerId,_that.sellerDisputeResponse,_that.sellerDisputePhotos,_that.sellerProposedResolution,_that.disputeResolutionAmount,_that.disputeResolutionNote,_that.sellerRespondedAt,_that.adminReviewRequired,_that.adminReviewReason,_that.refundedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc


class _BuyOrder extends BuyOrder {
  const _BuyOrder({required this.id, required this.buyerId, required this.buyerName, required this.sellerId, required this.sellerName, required this.listingId, required this.listingTitle, required this.amount, required this.amountZar, required this.status, this.escrowJournalId, this.releaseJournalId, this.refundJournalId, this.disputeReason, this.disputeResolution, this.chatConversationId, this.thumbnailUrl, required this.createdAt, this.escrowedAt, this.fulfilledAt, this.completedAt, this.disputedAt, this.resolvedAt, this.cancelledAt, this.deliveryFee, this.totalAmount = 0, this.deliveryMethod, this.deliveredVia, this.trackingInfo, this.deliveryDeadline, this.buyerConfirmationDeadline, this.refundType, this.disputeDetails, final  List<String> disputePhotos = const [], this.offerId, this.sellerDisputeResponse, final  List<String> sellerDisputePhotos = const [], this.sellerProposedResolution, this.disputeResolutionAmount, this.disputeResolutionNote, this.sellerRespondedAt, this.adminReviewRequired = false, this.adminReviewReason, this.refundedAt, this.version = 0}): _disputePhotos = disputePhotos,_sellerDisputePhotos = sellerDisputePhotos,super._();
  

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
// ── New fields (Spec §8.25) ──
@override final  int? deliveryFee;
@override@JsonKey() final  int totalAmount;
@override final  DeliveryMethod? deliveryMethod;
@override final  String? deliveredVia;
@override final  String? trackingInfo;
@override final  DateTime? deliveryDeadline;
@override final  DateTime? buyerConfirmationDeadline;
@override final  RefundType? refundType;
@override final  String? disputeDetails;
 final  List<String> _disputePhotos;
@override@JsonKey() List<String> get disputePhotos {
  if (_disputePhotos is EqualUnmodifiableListView) return _disputePhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_disputePhotos);
}

@override final  String? offerId;
@override final  String? sellerDisputeResponse;
 final  List<String> _sellerDisputePhotos;
@override@JsonKey() List<String> get sellerDisputePhotos {
  if (_sellerDisputePhotos is EqualUnmodifiableListView) return _sellerDisputePhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sellerDisputePhotos);
}

@override final  String? sellerProposedResolution;
@override final  int? disputeResolutionAmount;
@override final  String? disputeResolutionNote;
@override final  DateTime? sellerRespondedAt;
@override@JsonKey() final  bool adminReviewRequired;
@override final  String? adminReviewReason;
@override final  DateTime? refundedAt;
@override@JsonKey() final  int version;

/// Create a copy of BuyOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuyOrderCopyWith<_BuyOrder> get copyWith => __$BuyOrderCopyWithImpl<_BuyOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuyOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.buyerName, buyerName) || other.buyerName == buyerName)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.listingTitle, listingTitle) || other.listingTitle == listingTitle)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountZar, amountZar) || other.amountZar == amountZar)&&(identical(other.status, status) || other.status == status)&&(identical(other.escrowJournalId, escrowJournalId) || other.escrowJournalId == escrowJournalId)&&(identical(other.releaseJournalId, releaseJournalId) || other.releaseJournalId == releaseJournalId)&&(identical(other.refundJournalId, refundJournalId) || other.refundJournalId == refundJournalId)&&(identical(other.disputeReason, disputeReason) || other.disputeReason == disputeReason)&&(identical(other.disputeResolution, disputeResolution) || other.disputeResolution == disputeResolution)&&(identical(other.chatConversationId, chatConversationId) || other.chatConversationId == chatConversationId)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.escrowedAt, escrowedAt) || other.escrowedAt == escrowedAt)&&(identical(other.fulfilledAt, fulfilledAt) || other.fulfilledAt == fulfilledAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.disputedAt, disputedAt) || other.disputedAt == disputedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.deliveryMethod, deliveryMethod) || other.deliveryMethod == deliveryMethod)&&(identical(other.deliveredVia, deliveredVia) || other.deliveredVia == deliveredVia)&&(identical(other.trackingInfo, trackingInfo) || other.trackingInfo == trackingInfo)&&(identical(other.deliveryDeadline, deliveryDeadline) || other.deliveryDeadline == deliveryDeadline)&&(identical(other.buyerConfirmationDeadline, buyerConfirmationDeadline) || other.buyerConfirmationDeadline == buyerConfirmationDeadline)&&(identical(other.refundType, refundType) || other.refundType == refundType)&&(identical(other.disputeDetails, disputeDetails) || other.disputeDetails == disputeDetails)&&const DeepCollectionEquality().equals(other._disputePhotos, _disputePhotos)&&(identical(other.offerId, offerId) || other.offerId == offerId)&&(identical(other.sellerDisputeResponse, sellerDisputeResponse) || other.sellerDisputeResponse == sellerDisputeResponse)&&const DeepCollectionEquality().equals(other._sellerDisputePhotos, _sellerDisputePhotos)&&(identical(other.sellerProposedResolution, sellerProposedResolution) || other.sellerProposedResolution == sellerProposedResolution)&&(identical(other.disputeResolutionAmount, disputeResolutionAmount) || other.disputeResolutionAmount == disputeResolutionAmount)&&(identical(other.disputeResolutionNote, disputeResolutionNote) || other.disputeResolutionNote == disputeResolutionNote)&&(identical(other.sellerRespondedAt, sellerRespondedAt) || other.sellerRespondedAt == sellerRespondedAt)&&(identical(other.adminReviewRequired, adminReviewRequired) || other.adminReviewRequired == adminReviewRequired)&&(identical(other.adminReviewReason, adminReviewReason) || other.adminReviewReason == adminReviewReason)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,buyerId,buyerName,sellerId,sellerName,listingId,listingTitle,amount,amountZar,status,escrowJournalId,releaseJournalId,refundJournalId,disputeReason,disputeResolution,chatConversationId,thumbnailUrl,createdAt,escrowedAt,fulfilledAt,completedAt,disputedAt,resolvedAt,cancelledAt,deliveryFee,totalAmount,deliveryMethod,deliveredVia,trackingInfo,deliveryDeadline,buyerConfirmationDeadline,refundType,disputeDetails,const DeepCollectionEquality().hash(_disputePhotos),offerId,sellerDisputeResponse,const DeepCollectionEquality().hash(_sellerDisputePhotos),sellerProposedResolution,disputeResolutionAmount,disputeResolutionNote,sellerRespondedAt,adminReviewRequired,adminReviewReason,refundedAt,version]);

@override
String toString() {
  return 'BuyOrder(id: $id, buyerId: $buyerId, buyerName: $buyerName, sellerId: $sellerId, sellerName: $sellerName, listingId: $listingId, listingTitle: $listingTitle, amount: $amount, amountZar: $amountZar, status: $status, escrowJournalId: $escrowJournalId, releaseJournalId: $releaseJournalId, refundJournalId: $refundJournalId, disputeReason: $disputeReason, disputeResolution: $disputeResolution, chatConversationId: $chatConversationId, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt, escrowedAt: $escrowedAt, fulfilledAt: $fulfilledAt, completedAt: $completedAt, disputedAt: $disputedAt, resolvedAt: $resolvedAt, cancelledAt: $cancelledAt, deliveryFee: $deliveryFee, totalAmount: $totalAmount, deliveryMethod: $deliveryMethod, deliveredVia: $deliveredVia, trackingInfo: $trackingInfo, deliveryDeadline: $deliveryDeadline, buyerConfirmationDeadline: $buyerConfirmationDeadline, refundType: $refundType, disputeDetails: $disputeDetails, disputePhotos: $disputePhotos, offerId: $offerId, sellerDisputeResponse: $sellerDisputeResponse, sellerDisputePhotos: $sellerDisputePhotos, sellerProposedResolution: $sellerProposedResolution, disputeResolutionAmount: $disputeResolutionAmount, disputeResolutionNote: $disputeResolutionNote, sellerRespondedAt: $sellerRespondedAt, adminReviewRequired: $adminReviewRequired, adminReviewReason: $adminReviewReason, refundedAt: $refundedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$BuyOrderCopyWith<$Res> implements $BuyOrderCopyWith<$Res> {
  factory _$BuyOrderCopyWith(_BuyOrder value, $Res Function(_BuyOrder) _then) = __$BuyOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String buyerId, String buyerName, String sellerId, String sellerName, String listingId, String listingTitle, int amount, double amountZar, OrderStatus status, String? escrowJournalId, String? releaseJournalId, String? refundJournalId, String? disputeReason, String? disputeResolution, String? chatConversationId, String? thumbnailUrl, DateTime createdAt, DateTime? escrowedAt, DateTime? fulfilledAt, DateTime? completedAt, DateTime? disputedAt, DateTime? resolvedAt, DateTime? cancelledAt, int? deliveryFee, int totalAmount, DeliveryMethod? deliveryMethod, String? deliveredVia, String? trackingInfo, DateTime? deliveryDeadline, DateTime? buyerConfirmationDeadline, RefundType? refundType, String? disputeDetails, List<String> disputePhotos, String? offerId, String? sellerDisputeResponse, List<String> sellerDisputePhotos, String? sellerProposedResolution, int? disputeResolutionAmount, String? disputeResolutionNote, DateTime? sellerRespondedAt, bool adminReviewRequired, String? adminReviewReason, DateTime? refundedAt, int version
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? buyerId = null,Object? buyerName = null,Object? sellerId = null,Object? sellerName = null,Object? listingId = null,Object? listingTitle = null,Object? amount = null,Object? amountZar = null,Object? status = null,Object? escrowJournalId = freezed,Object? releaseJournalId = freezed,Object? refundJournalId = freezed,Object? disputeReason = freezed,Object? disputeResolution = freezed,Object? chatConversationId = freezed,Object? thumbnailUrl = freezed,Object? createdAt = null,Object? escrowedAt = freezed,Object? fulfilledAt = freezed,Object? completedAt = freezed,Object? disputedAt = freezed,Object? resolvedAt = freezed,Object? cancelledAt = freezed,Object? deliveryFee = freezed,Object? totalAmount = null,Object? deliveryMethod = freezed,Object? deliveredVia = freezed,Object? trackingInfo = freezed,Object? deliveryDeadline = freezed,Object? buyerConfirmationDeadline = freezed,Object? refundType = freezed,Object? disputeDetails = freezed,Object? disputePhotos = null,Object? offerId = freezed,Object? sellerDisputeResponse = freezed,Object? sellerDisputePhotos = null,Object? sellerProposedResolution = freezed,Object? disputeResolutionAmount = freezed,Object? disputeResolutionNote = freezed,Object? sellerRespondedAt = freezed,Object? adminReviewRequired = null,Object? adminReviewReason = freezed,Object? refundedAt = freezed,Object? version = null,}) {
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
as DateTime?,deliveryFee: freezed == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as int?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,deliveryMethod: freezed == deliveryMethod ? _self.deliveryMethod : deliveryMethod // ignore: cast_nullable_to_non_nullable
as DeliveryMethod?,deliveredVia: freezed == deliveredVia ? _self.deliveredVia : deliveredVia // ignore: cast_nullable_to_non_nullable
as String?,trackingInfo: freezed == trackingInfo ? _self.trackingInfo : trackingInfo // ignore: cast_nullable_to_non_nullable
as String?,deliveryDeadline: freezed == deliveryDeadline ? _self.deliveryDeadline : deliveryDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,buyerConfirmationDeadline: freezed == buyerConfirmationDeadline ? _self.buyerConfirmationDeadline : buyerConfirmationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,refundType: freezed == refundType ? _self.refundType : refundType // ignore: cast_nullable_to_non_nullable
as RefundType?,disputeDetails: freezed == disputeDetails ? _self.disputeDetails : disputeDetails // ignore: cast_nullable_to_non_nullable
as String?,disputePhotos: null == disputePhotos ? _self._disputePhotos : disputePhotos // ignore: cast_nullable_to_non_nullable
as List<String>,offerId: freezed == offerId ? _self.offerId : offerId // ignore: cast_nullable_to_non_nullable
as String?,sellerDisputeResponse: freezed == sellerDisputeResponse ? _self.sellerDisputeResponse : sellerDisputeResponse // ignore: cast_nullable_to_non_nullable
as String?,sellerDisputePhotos: null == sellerDisputePhotos ? _self._sellerDisputePhotos : sellerDisputePhotos // ignore: cast_nullable_to_non_nullable
as List<String>,sellerProposedResolution: freezed == sellerProposedResolution ? _self.sellerProposedResolution : sellerProposedResolution // ignore: cast_nullable_to_non_nullable
as String?,disputeResolutionAmount: freezed == disputeResolutionAmount ? _self.disputeResolutionAmount : disputeResolutionAmount // ignore: cast_nullable_to_non_nullable
as int?,disputeResolutionNote: freezed == disputeResolutionNote ? _self.disputeResolutionNote : disputeResolutionNote // ignore: cast_nullable_to_non_nullable
as String?,sellerRespondedAt: freezed == sellerRespondedAt ? _self.sellerRespondedAt : sellerRespondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminReviewRequired: null == adminReviewRequired ? _self.adminReviewRequired : adminReviewRequired // ignore: cast_nullable_to_non_nullable
as bool,adminReviewReason: freezed == adminReviewReason ? _self.adminReviewReason : adminReviewReason // ignore: cast_nullable_to_non_nullable
as String?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
