// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buy_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BuyOrderModel {
  String get id => throw _privateConstructorUsedError;
  String get buyerId => throw _privateConstructorUsedError;
  String get buyerName => throw _privateConstructorUsedError;
  String get sellerId => throw _privateConstructorUsedError;
  String get sellerName => throw _privateConstructorUsedError;
  String get listingId => throw _privateConstructorUsedError;
  String get listingTitle => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  double get amountZar => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  String? get escrowJournalId => throw _privateConstructorUsedError;
  String? get releaseJournalId => throw _privateConstructorUsedError;
  String? get refundJournalId => throw _privateConstructorUsedError;
  String? get disputeReason => throw _privateConstructorUsedError;
  String? get disputeResolution => throw _privateConstructorUsedError;
  String? get chatConversationId => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get escrowedAt => throw _privateConstructorUsedError;
  DateTime? get fulfilledAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get disputedAt => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;

  /// Create a copy of BuyOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuyOrderModelCopyWith<BuyOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuyOrderModelCopyWith<$Res> {
  factory $BuyOrderModelCopyWith(
    BuyOrderModel value,
    $Res Function(BuyOrderModel) then,
  ) = _$BuyOrderModelCopyWithImpl<$Res, BuyOrderModel>;
  @useResult
  $Res call({
    String id,
    String buyerId,
    String buyerName,
    String sellerId,
    String sellerName,
    String listingId,
    String listingTitle,
    int amount,
    double amountZar,
    OrderStatus status,
    String? escrowJournalId,
    String? releaseJournalId,
    String? refundJournalId,
    String? disputeReason,
    String? disputeResolution,
    String? chatConversationId,
    String? thumbnailUrl,
    DateTime createdAt,
    DateTime? escrowedAt,
    DateTime? fulfilledAt,
    DateTime? completedAt,
    DateTime? disputedAt,
    DateTime? resolvedAt,
    DateTime? cancelledAt,
  });
}

/// @nodoc
class _$BuyOrderModelCopyWithImpl<$Res, $Val extends BuyOrderModel>
    implements $BuyOrderModelCopyWith<$Res> {
  _$BuyOrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BuyOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? buyerId = null,
    Object? buyerName = null,
    Object? sellerId = null,
    Object? sellerName = null,
    Object? listingId = null,
    Object? listingTitle = null,
    Object? amount = null,
    Object? amountZar = null,
    Object? status = null,
    Object? escrowJournalId = freezed,
    Object? releaseJournalId = freezed,
    Object? refundJournalId = freezed,
    Object? disputeReason = freezed,
    Object? disputeResolution = freezed,
    Object? chatConversationId = freezed,
    Object? thumbnailUrl = freezed,
    Object? createdAt = null,
    Object? escrowedAt = freezed,
    Object? fulfilledAt = freezed,
    Object? completedAt = freezed,
    Object? disputedAt = freezed,
    Object? resolvedAt = freezed,
    Object? cancelledAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            buyerId: null == buyerId
                ? _value.buyerId
                : buyerId // ignore: cast_nullable_to_non_nullable
                      as String,
            buyerName: null == buyerName
                ? _value.buyerName
                : buyerName // ignore: cast_nullable_to_non_nullable
                      as String,
            sellerId: null == sellerId
                ? _value.sellerId
                : sellerId // ignore: cast_nullable_to_non_nullable
                      as String,
            sellerName: null == sellerName
                ? _value.sellerName
                : sellerName // ignore: cast_nullable_to_non_nullable
                      as String,
            listingId: null == listingId
                ? _value.listingId
                : listingId // ignore: cast_nullable_to_non_nullable
                      as String,
            listingTitle: null == listingTitle
                ? _value.listingTitle
                : listingTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            amountZar: null == amountZar
                ? _value.amountZar
                : amountZar // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as OrderStatus,
            escrowJournalId: freezed == escrowJournalId
                ? _value.escrowJournalId
                : escrowJournalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            releaseJournalId: freezed == releaseJournalId
                ? _value.releaseJournalId
                : releaseJournalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            refundJournalId: freezed == refundJournalId
                ? _value.refundJournalId
                : refundJournalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            disputeReason: freezed == disputeReason
                ? _value.disputeReason
                : disputeReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            disputeResolution: freezed == disputeResolution
                ? _value.disputeResolution
                : disputeResolution // ignore: cast_nullable_to_non_nullable
                      as String?,
            chatConversationId: freezed == chatConversationId
                ? _value.chatConversationId
                : chatConversationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            escrowedAt: freezed == escrowedAt
                ? _value.escrowedAt
                : escrowedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            fulfilledAt: freezed == fulfilledAt
                ? _value.fulfilledAt
                : fulfilledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            disputedAt: freezed == disputedAt
                ? _value.disputedAt
                : disputedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BuyOrderModelImplCopyWith<$Res>
    implements $BuyOrderModelCopyWith<$Res> {
  factory _$$BuyOrderModelImplCopyWith(
    _$BuyOrderModelImpl value,
    $Res Function(_$BuyOrderModelImpl) then,
  ) = __$$BuyOrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String buyerId,
    String buyerName,
    String sellerId,
    String sellerName,
    String listingId,
    String listingTitle,
    int amount,
    double amountZar,
    OrderStatus status,
    String? escrowJournalId,
    String? releaseJournalId,
    String? refundJournalId,
    String? disputeReason,
    String? disputeResolution,
    String? chatConversationId,
    String? thumbnailUrl,
    DateTime createdAt,
    DateTime? escrowedAt,
    DateTime? fulfilledAt,
    DateTime? completedAt,
    DateTime? disputedAt,
    DateTime? resolvedAt,
    DateTime? cancelledAt,
  });
}

/// @nodoc
class __$$BuyOrderModelImplCopyWithImpl<$Res>
    extends _$BuyOrderModelCopyWithImpl<$Res, _$BuyOrderModelImpl>
    implements _$$BuyOrderModelImplCopyWith<$Res> {
  __$$BuyOrderModelImplCopyWithImpl(
    _$BuyOrderModelImpl _value,
    $Res Function(_$BuyOrderModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BuyOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? buyerId = null,
    Object? buyerName = null,
    Object? sellerId = null,
    Object? sellerName = null,
    Object? listingId = null,
    Object? listingTitle = null,
    Object? amount = null,
    Object? amountZar = null,
    Object? status = null,
    Object? escrowJournalId = freezed,
    Object? releaseJournalId = freezed,
    Object? refundJournalId = freezed,
    Object? disputeReason = freezed,
    Object? disputeResolution = freezed,
    Object? chatConversationId = freezed,
    Object? thumbnailUrl = freezed,
    Object? createdAt = null,
    Object? escrowedAt = freezed,
    Object? fulfilledAt = freezed,
    Object? completedAt = freezed,
    Object? disputedAt = freezed,
    Object? resolvedAt = freezed,
    Object? cancelledAt = freezed,
  }) {
    return _then(
      _$BuyOrderModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        buyerId: null == buyerId
            ? _value.buyerId
            : buyerId // ignore: cast_nullable_to_non_nullable
                  as String,
        buyerName: null == buyerName
            ? _value.buyerName
            : buyerName // ignore: cast_nullable_to_non_nullable
                  as String,
        sellerId: null == sellerId
            ? _value.sellerId
            : sellerId // ignore: cast_nullable_to_non_nullable
                  as String,
        sellerName: null == sellerName
            ? _value.sellerName
            : sellerName // ignore: cast_nullable_to_non_nullable
                  as String,
        listingId: null == listingId
            ? _value.listingId
            : listingId // ignore: cast_nullable_to_non_nullable
                  as String,
        listingTitle: null == listingTitle
            ? _value.listingTitle
            : listingTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        amountZar: null == amountZar
            ? _value.amountZar
            : amountZar // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as OrderStatus,
        escrowJournalId: freezed == escrowJournalId
            ? _value.escrowJournalId
            : escrowJournalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        releaseJournalId: freezed == releaseJournalId
            ? _value.releaseJournalId
            : releaseJournalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        refundJournalId: freezed == refundJournalId
            ? _value.refundJournalId
            : refundJournalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        disputeReason: freezed == disputeReason
            ? _value.disputeReason
            : disputeReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        disputeResolution: freezed == disputeResolution
            ? _value.disputeResolution
            : disputeResolution // ignore: cast_nullable_to_non_nullable
                  as String?,
        chatConversationId: freezed == chatConversationId
            ? _value.chatConversationId
            : chatConversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        escrowedAt: freezed == escrowedAt
            ? _value.escrowedAt
            : escrowedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        fulfilledAt: freezed == fulfilledAt
            ? _value.fulfilledAt
            : fulfilledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        disputedAt: freezed == disputedAt
            ? _value.disputedAt
            : disputedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$BuyOrderModelImpl extends _BuyOrderModel {
  const _$BuyOrderModelImpl({
    required this.id,
    required this.buyerId,
    required this.buyerName,
    required this.sellerId,
    required this.sellerName,
    required this.listingId,
    required this.listingTitle,
    required this.amount,
    required this.amountZar,
    required this.status,
    this.escrowJournalId,
    this.releaseJournalId,
    this.refundJournalId,
    this.disputeReason,
    this.disputeResolution,
    this.chatConversationId,
    this.thumbnailUrl,
    required this.createdAt,
    this.escrowedAt,
    this.fulfilledAt,
    this.completedAt,
    this.disputedAt,
    this.resolvedAt,
    this.cancelledAt,
  }) : super._();

  @override
  final String id;
  @override
  final String buyerId;
  @override
  final String buyerName;
  @override
  final String sellerId;
  @override
  final String sellerName;
  @override
  final String listingId;
  @override
  final String listingTitle;
  @override
  final int amount;
  @override
  final double amountZar;
  @override
  final OrderStatus status;
  @override
  final String? escrowJournalId;
  @override
  final String? releaseJournalId;
  @override
  final String? refundJournalId;
  @override
  final String? disputeReason;
  @override
  final String? disputeResolution;
  @override
  final String? chatConversationId;
  @override
  final String? thumbnailUrl;
  @override
  final DateTime createdAt;
  @override
  final DateTime? escrowedAt;
  @override
  final DateTime? fulfilledAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? disputedAt;
  @override
  final DateTime? resolvedAt;
  @override
  final DateTime? cancelledAt;

  @override
  String toString() {
    return 'BuyOrderModel(id: $id, buyerId: $buyerId, buyerName: $buyerName, sellerId: $sellerId, sellerName: $sellerName, listingId: $listingId, listingTitle: $listingTitle, amount: $amount, amountZar: $amountZar, status: $status, escrowJournalId: $escrowJournalId, releaseJournalId: $releaseJournalId, refundJournalId: $refundJournalId, disputeReason: $disputeReason, disputeResolution: $disputeResolution, chatConversationId: $chatConversationId, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt, escrowedAt: $escrowedAt, fulfilledAt: $fulfilledAt, completedAt: $completedAt, disputedAt: $disputedAt, resolvedAt: $resolvedAt, cancelledAt: $cancelledAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuyOrderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.buyerId, buyerId) || other.buyerId == buyerId) &&
            (identical(other.buyerName, buyerName) ||
                other.buyerName == buyerName) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.sellerName, sellerName) ||
                other.sellerName == sellerName) &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.listingTitle, listingTitle) ||
                other.listingTitle == listingTitle) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.amountZar, amountZar) ||
                other.amountZar == amountZar) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.escrowJournalId, escrowJournalId) ||
                other.escrowJournalId == escrowJournalId) &&
            (identical(other.releaseJournalId, releaseJournalId) ||
                other.releaseJournalId == releaseJournalId) &&
            (identical(other.refundJournalId, refundJournalId) ||
                other.refundJournalId == refundJournalId) &&
            (identical(other.disputeReason, disputeReason) ||
                other.disputeReason == disputeReason) &&
            (identical(other.disputeResolution, disputeResolution) ||
                other.disputeResolution == disputeResolution) &&
            (identical(other.chatConversationId, chatConversationId) ||
                other.chatConversationId == chatConversationId) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.escrowedAt, escrowedAt) ||
                other.escrowedAt == escrowedAt) &&
            (identical(other.fulfilledAt, fulfilledAt) ||
                other.fulfilledAt == fulfilledAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.disputedAt, disputedAt) ||
                other.disputedAt == disputedAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    buyerId,
    buyerName,
    sellerId,
    sellerName,
    listingId,
    listingTitle,
    amount,
    amountZar,
    status,
    escrowJournalId,
    releaseJournalId,
    refundJournalId,
    disputeReason,
    disputeResolution,
    chatConversationId,
    thumbnailUrl,
    createdAt,
    escrowedAt,
    fulfilledAt,
    completedAt,
    disputedAt,
    resolvedAt,
    cancelledAt,
  ]);

  /// Create a copy of BuyOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuyOrderModelImplCopyWith<_$BuyOrderModelImpl> get copyWith =>
      __$$BuyOrderModelImplCopyWithImpl<_$BuyOrderModelImpl>(this, _$identity);
}

abstract class _BuyOrderModel extends BuyOrderModel {
  const factory _BuyOrderModel({
    required final String id,
    required final String buyerId,
    required final String buyerName,
    required final String sellerId,
    required final String sellerName,
    required final String listingId,
    required final String listingTitle,
    required final int amount,
    required final double amountZar,
    required final OrderStatus status,
    final String? escrowJournalId,
    final String? releaseJournalId,
    final String? refundJournalId,
    final String? disputeReason,
    final String? disputeResolution,
    final String? chatConversationId,
    final String? thumbnailUrl,
    required final DateTime createdAt,
    final DateTime? escrowedAt,
    final DateTime? fulfilledAt,
    final DateTime? completedAt,
    final DateTime? disputedAt,
    final DateTime? resolvedAt,
    final DateTime? cancelledAt,
  }) = _$BuyOrderModelImpl;
  const _BuyOrderModel._() : super._();

  @override
  String get id;
  @override
  String get buyerId;
  @override
  String get buyerName;
  @override
  String get sellerId;
  @override
  String get sellerName;
  @override
  String get listingId;
  @override
  String get listingTitle;
  @override
  int get amount;
  @override
  double get amountZar;
  @override
  OrderStatus get status;
  @override
  String? get escrowJournalId;
  @override
  String? get releaseJournalId;
  @override
  String? get refundJournalId;
  @override
  String? get disputeReason;
  @override
  String? get disputeResolution;
  @override
  String? get chatConversationId;
  @override
  String? get thumbnailUrl;
  @override
  DateTime get createdAt;
  @override
  DateTime? get escrowedAt;
  @override
  DateTime? get fulfilledAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get disputedAt;
  @override
  DateTime? get resolvedAt;
  @override
  DateTime? get cancelledAt;

  /// Create a copy of BuyOrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuyOrderModelImplCopyWith<_$BuyOrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
