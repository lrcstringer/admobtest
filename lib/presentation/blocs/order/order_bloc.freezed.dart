// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrderEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderEventCopyWith<$Res> {
  factory $OrderEventCopyWith(
    OrderEvent value,
    $Res Function(OrderEvent) then,
  ) = _$OrderEventCopyWithImpl<$Res, OrderEvent>;
}

/// @nodoc
class _$OrderEventCopyWithImpl<$Res, $Val extends OrderEvent>
    implements $OrderEventCopyWith<$Res> {
  _$OrderEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadBuyerOrdersImplCopyWith<$Res> {
  factory _$$LoadBuyerOrdersImplCopyWith(
    _$LoadBuyerOrdersImpl value,
    $Res Function(_$LoadBuyerOrdersImpl) then,
  ) = __$$LoadBuyerOrdersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadBuyerOrdersImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$LoadBuyerOrdersImpl>
    implements _$$LoadBuyerOrdersImplCopyWith<$Res> {
  __$$LoadBuyerOrdersImplCopyWithImpl(
    _$LoadBuyerOrdersImpl _value,
    $Res Function(_$LoadBuyerOrdersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadBuyerOrdersImpl implements _LoadBuyerOrders {
  const _$LoadBuyerOrdersImpl();

  @override
  String toString() {
    return 'OrderEvent.loadBuyerOrders()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadBuyerOrdersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) {
    return loadBuyerOrders();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) {
    return loadBuyerOrders?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadBuyerOrders != null) {
      return loadBuyerOrders();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadBuyerOrders(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadBuyerOrders?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadBuyerOrders != null) {
      return loadBuyerOrders(this);
    }
    return orElse();
  }
}

abstract class _LoadBuyerOrders implements OrderEvent {
  const factory _LoadBuyerOrders() = _$LoadBuyerOrdersImpl;
}

/// @nodoc
abstract class _$$LoadSellerOrdersImplCopyWith<$Res> {
  factory _$$LoadSellerOrdersImplCopyWith(
    _$LoadSellerOrdersImpl value,
    $Res Function(_$LoadSellerOrdersImpl) then,
  ) = __$$LoadSellerOrdersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadSellerOrdersImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$LoadSellerOrdersImpl>
    implements _$$LoadSellerOrdersImplCopyWith<$Res> {
  __$$LoadSellerOrdersImplCopyWithImpl(
    _$LoadSellerOrdersImpl _value,
    $Res Function(_$LoadSellerOrdersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadSellerOrdersImpl implements _LoadSellerOrders {
  const _$LoadSellerOrdersImpl();

  @override
  String toString() {
    return 'OrderEvent.loadSellerOrders()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadSellerOrdersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) {
    return loadSellerOrders();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) {
    return loadSellerOrders?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadSellerOrders != null) {
      return loadSellerOrders();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadSellerOrders(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadSellerOrders?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadSellerOrders != null) {
      return loadSellerOrders(this);
    }
    return orElse();
  }
}

abstract class _LoadSellerOrders implements OrderEvent {
  const factory _LoadSellerOrders() = _$LoadSellerOrdersImpl;
}

/// @nodoc
abstract class _$$SelectOrderImplCopyWith<$Res> {
  factory _$$SelectOrderImplCopyWith(
    _$SelectOrderImpl value,
    $Res Function(_$SelectOrderImpl) then,
  ) = __$$SelectOrderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class __$$SelectOrderImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$SelectOrderImpl>
    implements _$$SelectOrderImplCopyWith<$Res> {
  __$$SelectOrderImplCopyWithImpl(
    _$SelectOrderImpl _value,
    $Res Function(_$SelectOrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = null}) {
    return _then(
      _$SelectOrderImpl(
        null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SelectOrderImpl implements _SelectOrder {
  const _$SelectOrderImpl(this.orderId);

  @override
  final String orderId;

  @override
  String toString() {
    return 'OrderEvent.selectOrder(orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectOrderImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectOrderImplCopyWith<_$SelectOrderImpl> get copyWith =>
      __$$SelectOrderImplCopyWithImpl<_$SelectOrderImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) {
    return selectOrder(orderId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) {
    return selectOrder?.call(orderId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (selectOrder != null) {
      return selectOrder(orderId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return selectOrder(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return selectOrder?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (selectOrder != null) {
      return selectOrder(this);
    }
    return orElse();
  }
}

abstract class _SelectOrder implements OrderEvent {
  const factory _SelectOrder(final String orderId) = _$SelectOrderImpl;

  String get orderId;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectOrderImplCopyWith<_$SelectOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BuyItemImplCopyWith<$Res> {
  factory _$$BuyItemImplCopyWith(
    _$BuyItemImpl value,
    $Res Function(_$BuyItemImpl) then,
  ) = __$$BuyItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String listingId, String walletId});
}

/// @nodoc
class __$$BuyItemImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$BuyItemImpl>
    implements _$$BuyItemImplCopyWith<$Res> {
  __$$BuyItemImplCopyWithImpl(
    _$BuyItemImpl _value,
    $Res Function(_$BuyItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? listingId = null, Object? walletId = null}) {
    return _then(
      _$BuyItemImpl(
        listingId: null == listingId
            ? _value.listingId
            : listingId // ignore: cast_nullable_to_non_nullable
                  as String,
        walletId: null == walletId
            ? _value.walletId
            : walletId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$BuyItemImpl implements _BuyItem {
  const _$BuyItemImpl({required this.listingId, required this.walletId});

  @override
  final String listingId;
  @override
  final String walletId;

  @override
  String toString() {
    return 'OrderEvent.buyItem(listingId: $listingId, walletId: $walletId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuyItemImpl &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, listingId, walletId);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuyItemImplCopyWith<_$BuyItemImpl> get copyWith =>
      __$$BuyItemImplCopyWithImpl<_$BuyItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) {
    return buyItem(listingId, walletId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) {
    return buyItem?.call(listingId, walletId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (buyItem != null) {
      return buyItem(listingId, walletId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return buyItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return buyItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (buyItem != null) {
      return buyItem(this);
    }
    return orElse();
  }
}

abstract class _BuyItem implements OrderEvent {
  const factory _BuyItem({
    required final String listingId,
    required final String walletId,
  }) = _$BuyItemImpl;

  String get listingId;
  String get walletId;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuyItemImplCopyWith<_$BuyItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmFulfilmentImplCopyWith<$Res> {
  factory _$$ConfirmFulfilmentImplCopyWith(
    _$ConfirmFulfilmentImpl value,
    $Res Function(_$ConfirmFulfilmentImpl) then,
  ) = __$$ConfirmFulfilmentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class __$$ConfirmFulfilmentImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$ConfirmFulfilmentImpl>
    implements _$$ConfirmFulfilmentImplCopyWith<$Res> {
  __$$ConfirmFulfilmentImplCopyWithImpl(
    _$ConfirmFulfilmentImpl _value,
    $Res Function(_$ConfirmFulfilmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = null}) {
    return _then(
      _$ConfirmFulfilmentImpl(
        null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmFulfilmentImpl implements _ConfirmFulfilment {
  const _$ConfirmFulfilmentImpl(this.orderId);

  @override
  final String orderId;

  @override
  String toString() {
    return 'OrderEvent.confirmFulfilment(orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmFulfilmentImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmFulfilmentImplCopyWith<_$ConfirmFulfilmentImpl> get copyWith =>
      __$$ConfirmFulfilmentImplCopyWithImpl<_$ConfirmFulfilmentImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) {
    return confirmFulfilment(orderId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) {
    return confirmFulfilment?.call(orderId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (confirmFulfilment != null) {
      return confirmFulfilment(orderId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return confirmFulfilment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return confirmFulfilment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (confirmFulfilment != null) {
      return confirmFulfilment(this);
    }
    return orElse();
  }
}

abstract class _ConfirmFulfilment implements OrderEvent {
  const factory _ConfirmFulfilment(final String orderId) =
      _$ConfirmFulfilmentImpl;

  String get orderId;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmFulfilmentImplCopyWith<_$ConfirmFulfilmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmReceiptImplCopyWith<$Res> {
  factory _$$ConfirmReceiptImplCopyWith(
    _$ConfirmReceiptImpl value,
    $Res Function(_$ConfirmReceiptImpl) then,
  ) = __$$ConfirmReceiptImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class __$$ConfirmReceiptImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$ConfirmReceiptImpl>
    implements _$$ConfirmReceiptImplCopyWith<$Res> {
  __$$ConfirmReceiptImplCopyWithImpl(
    _$ConfirmReceiptImpl _value,
    $Res Function(_$ConfirmReceiptImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = null}) {
    return _then(
      _$ConfirmReceiptImpl(
        null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConfirmReceiptImpl implements _ConfirmReceipt {
  const _$ConfirmReceiptImpl(this.orderId);

  @override
  final String orderId;

  @override
  String toString() {
    return 'OrderEvent.confirmReceipt(orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmReceiptImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmReceiptImplCopyWith<_$ConfirmReceiptImpl> get copyWith =>
      __$$ConfirmReceiptImplCopyWithImpl<_$ConfirmReceiptImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) {
    return confirmReceipt(orderId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) {
    return confirmReceipt?.call(orderId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (confirmReceipt != null) {
      return confirmReceipt(orderId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return confirmReceipt(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return confirmReceipt?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (confirmReceipt != null) {
      return confirmReceipt(this);
    }
    return orElse();
  }
}

abstract class _ConfirmReceipt implements OrderEvent {
  const factory _ConfirmReceipt(final String orderId) = _$ConfirmReceiptImpl;

  String get orderId;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmReceiptImplCopyWith<_$ConfirmReceiptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelOrderImplCopyWith<$Res> {
  factory _$$CancelOrderImplCopyWith(
    _$CancelOrderImpl value,
    $Res Function(_$CancelOrderImpl) then,
  ) = __$$CancelOrderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String orderId});
}

/// @nodoc
class __$$CancelOrderImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$CancelOrderImpl>
    implements _$$CancelOrderImplCopyWith<$Res> {
  __$$CancelOrderImplCopyWithImpl(
    _$CancelOrderImpl _value,
    $Res Function(_$CancelOrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = null}) {
    return _then(
      _$CancelOrderImpl(
        null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CancelOrderImpl implements _CancelOrder {
  const _$CancelOrderImpl(this.orderId);

  @override
  final String orderId;

  @override
  String toString() {
    return 'OrderEvent.cancelOrder(orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelOrderImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelOrderImplCopyWith<_$CancelOrderImpl> get copyWith =>
      __$$CancelOrderImplCopyWithImpl<_$CancelOrderImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) {
    return cancelOrder(orderId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) {
    return cancelOrder?.call(orderId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (cancelOrder != null) {
      return cancelOrder(orderId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return cancelOrder(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return cancelOrder?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (cancelOrder != null) {
      return cancelOrder(this);
    }
    return orElse();
  }
}

abstract class _CancelOrder implements OrderEvent {
  const factory _CancelOrder(final String orderId) = _$CancelOrderImpl;

  String get orderId;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelOrderImplCopyWith<_$CancelOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DisputeOrderImplCopyWith<$Res> {
  factory _$$DisputeOrderImplCopyWith(
    _$DisputeOrderImpl value,
    $Res Function(_$DisputeOrderImpl) then,
  ) = __$$DisputeOrderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String orderId, String reason});
}

/// @nodoc
class __$$DisputeOrderImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$DisputeOrderImpl>
    implements _$$DisputeOrderImplCopyWith<$Res> {
  __$$DisputeOrderImplCopyWithImpl(
    _$DisputeOrderImpl _value,
    $Res Function(_$DisputeOrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? orderId = null, Object? reason = null}) {
    return _then(
      _$DisputeOrderImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DisputeOrderImpl implements _DisputeOrder {
  const _$DisputeOrderImpl({required this.orderId, required this.reason});

  @override
  final String orderId;
  @override
  final String reason;

  @override
  String toString() {
    return 'OrderEvent.disputeOrder(orderId: $orderId, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisputeOrderImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderId, reason);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DisputeOrderImplCopyWith<_$DisputeOrderImpl> get copyWith =>
      __$$DisputeOrderImplCopyWithImpl<_$DisputeOrderImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) {
    return disputeOrder(orderId, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) {
    return disputeOrder?.call(orderId, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (disputeOrder != null) {
      return disputeOrder(orderId, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return disputeOrder(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return disputeOrder?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (disputeOrder != null) {
      return disputeOrder(this);
    }
    return orElse();
  }
}

abstract class _DisputeOrder implements OrderEvent {
  const factory _DisputeOrder({
    required final String orderId,
    required final String reason,
  }) = _$DisputeOrderImpl;

  String get orderId;
  String get reason;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DisputeOrderImplCopyWith<_$DisputeOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VouchForProviderImplCopyWith<$Res> {
  factory _$$VouchForProviderImplCopyWith(
    _$VouchForProviderImpl value,
    $Res Function(_$VouchForProviderImpl) then,
  ) = __$$VouchForProviderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String providerId, String orderId, int rating, String? comment});
}

/// @nodoc
class __$$VouchForProviderImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$VouchForProviderImpl>
    implements _$$VouchForProviderImplCopyWith<$Res> {
  __$$VouchForProviderImplCopyWithImpl(
    _$VouchForProviderImpl _value,
    $Res Function(_$VouchForProviderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? orderId = null,
    Object? rating = null,
    Object? comment = freezed,
  }) {
    return _then(
      _$VouchForProviderImpl(
        providerId: null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        comment: freezed == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$VouchForProviderImpl implements _VouchForProvider {
  const _$VouchForProviderImpl({
    required this.providerId,
    required this.orderId,
    required this.rating,
    this.comment,
  });

  @override
  final String providerId;
  @override
  final String orderId;
  @override
  final int rating;
  @override
  final String? comment;

  @override
  String toString() {
    return 'OrderEvent.vouchForProvider(providerId: $providerId, orderId: $orderId, rating: $rating, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VouchForProviderImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, providerId, orderId, rating, comment);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VouchForProviderImplCopyWith<_$VouchForProviderImpl> get copyWith =>
      __$$VouchForProviderImplCopyWithImpl<_$VouchForProviderImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) {
    return vouchForProvider(providerId, orderId, rating, comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) {
    return vouchForProvider?.call(providerId, orderId, rating, comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (vouchForProvider != null) {
      return vouchForProvider(providerId, orderId, rating, comment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return vouchForProvider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return vouchForProvider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (vouchForProvider != null) {
      return vouchForProvider(this);
    }
    return orElse();
  }
}

abstract class _VouchForProvider implements OrderEvent {
  const factory _VouchForProvider({
    required final String providerId,
    required final String orderId,
    required final int rating,
    final String? comment,
  }) = _$VouchForProviderImpl;

  String get providerId;
  String get orderId;
  int get rating;
  String? get comment;

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VouchForProviderImplCopyWith<_$VouchForProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearMessagesImplCopyWith<$Res> {
  factory _$$ClearMessagesImplCopyWith(
    _$ClearMessagesImpl value,
    $Res Function(_$ClearMessagesImpl) then,
  ) = __$$ClearMessagesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearMessagesImplCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res, _$ClearMessagesImpl>
    implements _$$ClearMessagesImplCopyWith<$Res> {
  __$$ClearMessagesImplCopyWithImpl(
    _$ClearMessagesImpl _value,
    $Res Function(_$ClearMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearMessagesImpl implements _ClearMessages {
  const _$ClearMessagesImpl();

  @override
  String toString() {
    return 'OrderEvent.clearMessages()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearMessagesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadBuyerOrders,
    required TResult Function() loadSellerOrders,
    required TResult Function(String orderId) selectOrder,
    required TResult Function(String listingId, String walletId) buyItem,
    required TResult Function(String orderId) confirmFulfilment,
    required TResult Function(String orderId) confirmReceipt,
    required TResult Function(String orderId) cancelOrder,
    required TResult Function(String orderId, String reason) disputeOrder,
    required TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )
    vouchForProvider,
    required TResult Function() clearMessages,
  }) {
    return clearMessages();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadBuyerOrders,
    TResult? Function()? loadSellerOrders,
    TResult? Function(String orderId)? selectOrder,
    TResult? Function(String listingId, String walletId)? buyItem,
    TResult? Function(String orderId)? confirmFulfilment,
    TResult? Function(String orderId)? confirmReceipt,
    TResult? Function(String orderId)? cancelOrder,
    TResult? Function(String orderId, String reason)? disputeOrder,
    TResult? Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult? Function()? clearMessages,
  }) {
    return clearMessages?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadBuyerOrders,
    TResult Function()? loadSellerOrders,
    TResult Function(String orderId)? selectOrder,
    TResult Function(String listingId, String walletId)? buyItem,
    TResult Function(String orderId)? confirmFulfilment,
    TResult Function(String orderId)? confirmReceipt,
    TResult Function(String orderId)? cancelOrder,
    TResult Function(String orderId, String reason)? disputeOrder,
    TResult Function(
      String providerId,
      String orderId,
      int rating,
      String? comment,
    )?
    vouchForProvider,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (clearMessages != null) {
      return clearMessages();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadBuyerOrders value) loadBuyerOrders,
    required TResult Function(_LoadSellerOrders value) loadSellerOrders,
    required TResult Function(_SelectOrder value) selectOrder,
    required TResult Function(_BuyItem value) buyItem,
    required TResult Function(_ConfirmFulfilment value) confirmFulfilment,
    required TResult Function(_ConfirmReceipt value) confirmReceipt,
    required TResult Function(_CancelOrder value) cancelOrder,
    required TResult Function(_DisputeOrder value) disputeOrder,
    required TResult Function(_VouchForProvider value) vouchForProvider,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return clearMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult? Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult? Function(_SelectOrder value)? selectOrder,
    TResult? Function(_BuyItem value)? buyItem,
    TResult? Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult? Function(_ConfirmReceipt value)? confirmReceipt,
    TResult? Function(_CancelOrder value)? cancelOrder,
    TResult? Function(_DisputeOrder value)? disputeOrder,
    TResult? Function(_VouchForProvider value)? vouchForProvider,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return clearMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadBuyerOrders value)? loadBuyerOrders,
    TResult Function(_LoadSellerOrders value)? loadSellerOrders,
    TResult Function(_SelectOrder value)? selectOrder,
    TResult Function(_BuyItem value)? buyItem,
    TResult Function(_ConfirmFulfilment value)? confirmFulfilment,
    TResult Function(_ConfirmReceipt value)? confirmReceipt,
    TResult Function(_CancelOrder value)? cancelOrder,
    TResult Function(_DisputeOrder value)? disputeOrder,
    TResult Function(_VouchForProvider value)? vouchForProvider,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (clearMessages != null) {
      return clearMessages(this);
    }
    return orElse();
  }
}

abstract class _ClearMessages implements OrderEvent {
  const factory _ClearMessages() = _$ClearMessagesImpl;
}

/// @nodoc
mixin _$OrderState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingDetail => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  List<BuyOrder> get buyerOrders => throw _privateConstructorUsedError;
  List<BuyOrder> get sellerOrders => throw _privateConstructorUsedError;
  BuyOrder? get selectedOrder => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderStateCopyWith<OrderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStateCopyWith<$Res> {
  factory $OrderStateCopyWith(
    OrderState value,
    $Res Function(OrderState) then,
  ) = _$OrderStateCopyWithImpl<$Res, OrderState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isLoadingDetail,
    bool isProcessing,
    List<BuyOrder> buyerOrders,
    List<BuyOrder> sellerOrders,
    BuyOrder? selectedOrder,
    String? errorMessage,
    String? successMessage,
  });

  $BuyOrderCopyWith<$Res>? get selectedOrder;
}

/// @nodoc
class _$OrderStateCopyWithImpl<$Res, $Val extends OrderState>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingDetail = null,
    Object? isProcessing = null,
    Object? buyerOrders = null,
    Object? sellerOrders = null,
    Object? selectedOrder = freezed,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingDetail: null == isLoadingDetail
                ? _value.isLoadingDetail
                : isLoadingDetail // ignore: cast_nullable_to_non_nullable
                      as bool,
            isProcessing: null == isProcessing
                ? _value.isProcessing
                : isProcessing // ignore: cast_nullable_to_non_nullable
                      as bool,
            buyerOrders: null == buyerOrders
                ? _value.buyerOrders
                : buyerOrders // ignore: cast_nullable_to_non_nullable
                      as List<BuyOrder>,
            sellerOrders: null == sellerOrders
                ? _value.sellerOrders
                : sellerOrders // ignore: cast_nullable_to_non_nullable
                      as List<BuyOrder>,
            selectedOrder: freezed == selectedOrder
                ? _value.selectedOrder
                : selectedOrder // ignore: cast_nullable_to_non_nullable
                      as BuyOrder?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BuyOrderCopyWith<$Res>? get selectedOrder {
    if (_value.selectedOrder == null) {
      return null;
    }

    return $BuyOrderCopyWith<$Res>(_value.selectedOrder!, (value) {
      return _then(_value.copyWith(selectedOrder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderStateImplCopyWith<$Res>
    implements $OrderStateCopyWith<$Res> {
  factory _$$OrderStateImplCopyWith(
    _$OrderStateImpl value,
    $Res Function(_$OrderStateImpl) then,
  ) = __$$OrderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isLoadingDetail,
    bool isProcessing,
    List<BuyOrder> buyerOrders,
    List<BuyOrder> sellerOrders,
    BuyOrder? selectedOrder,
    String? errorMessage,
    String? successMessage,
  });

  @override
  $BuyOrderCopyWith<$Res>? get selectedOrder;
}

/// @nodoc
class __$$OrderStateImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$OrderStateImpl>
    implements _$$OrderStateImplCopyWith<$Res> {
  __$$OrderStateImplCopyWithImpl(
    _$OrderStateImpl _value,
    $Res Function(_$OrderStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLoadingDetail = null,
    Object? isProcessing = null,
    Object? buyerOrders = null,
    Object? sellerOrders = null,
    Object? selectedOrder = freezed,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$OrderStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingDetail: null == isLoadingDetail
            ? _value.isLoadingDetail
            : isLoadingDetail // ignore: cast_nullable_to_non_nullable
                  as bool,
        isProcessing: null == isProcessing
            ? _value.isProcessing
            : isProcessing // ignore: cast_nullable_to_non_nullable
                  as bool,
        buyerOrders: null == buyerOrders
            ? _value._buyerOrders
            : buyerOrders // ignore: cast_nullable_to_non_nullable
                  as List<BuyOrder>,
        sellerOrders: null == sellerOrders
            ? _value._sellerOrders
            : sellerOrders // ignore: cast_nullable_to_non_nullable
                  as List<BuyOrder>,
        selectedOrder: freezed == selectedOrder
            ? _value.selectedOrder
            : selectedOrder // ignore: cast_nullable_to_non_nullable
                  as BuyOrder?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OrderStateImpl implements _OrderState {
  const _$OrderStateImpl({
    this.isLoading = false,
    this.isLoadingDetail = false,
    this.isProcessing = false,
    final List<BuyOrder> buyerOrders = const [],
    final List<BuyOrder> sellerOrders = const [],
    this.selectedOrder,
    this.errorMessage,
    this.successMessage,
  }) : _buyerOrders = buyerOrders,
       _sellerOrders = sellerOrders;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingDetail;
  @override
  @JsonKey()
  final bool isProcessing;
  final List<BuyOrder> _buyerOrders;
  @override
  @JsonKey()
  List<BuyOrder> get buyerOrders {
    if (_buyerOrders is EqualUnmodifiableListView) return _buyerOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buyerOrders);
  }

  final List<BuyOrder> _sellerOrders;
  @override
  @JsonKey()
  List<BuyOrder> get sellerOrders {
    if (_sellerOrders is EqualUnmodifiableListView) return _sellerOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sellerOrders);
  }

  @override
  final BuyOrder? selectedOrder;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'OrderState(isLoading: $isLoading, isLoadingDetail: $isLoadingDetail, isProcessing: $isProcessing, buyerOrders: $buyerOrders, sellerOrders: $sellerOrders, selectedOrder: $selectedOrder, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingDetail, isLoadingDetail) ||
                other.isLoadingDetail == isLoadingDetail) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            const DeepCollectionEquality().equals(
              other._buyerOrders,
              _buyerOrders,
            ) &&
            const DeepCollectionEquality().equals(
              other._sellerOrders,
              _sellerOrders,
            ) &&
            (identical(other.selectedOrder, selectedOrder) ||
                other.selectedOrder == selectedOrder) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isLoadingDetail,
    isProcessing,
    const DeepCollectionEquality().hash(_buyerOrders),
    const DeepCollectionEquality().hash(_sellerOrders),
    selectedOrder,
    errorMessage,
    successMessage,
  );

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStateImplCopyWith<_$OrderStateImpl> get copyWith =>
      __$$OrderStateImplCopyWithImpl<_$OrderStateImpl>(this, _$identity);
}

abstract class _OrderState implements OrderState {
  const factory _OrderState({
    final bool isLoading,
    final bool isLoadingDetail,
    final bool isProcessing,
    final List<BuyOrder> buyerOrders,
    final List<BuyOrder> sellerOrders,
    final BuyOrder? selectedOrder,
    final String? errorMessage,
    final String? successMessage,
  }) = _$OrderStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLoadingDetail;
  @override
  bool get isProcessing;
  @override
  List<BuyOrder> get buyerOrders;
  @override
  List<BuyOrder> get sellerOrders;
  @override
  BuyOrder? get selectedOrder;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderStateImplCopyWith<_$OrderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
