// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RewardEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function(String itemId) loadItemDetail,
    required TResult Function(String itemId, String? location) redeemItem,
    required TResult Function() refreshItems,
    required TResult Function() clearSelectedItem,
    required TResult Function() clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function(String itemId)? loadItemDetail,
    TResult? Function(String itemId, String? location)? redeemItem,
    TResult? Function()? refreshItems,
    TResult? Function()? clearSelectedItem,
    TResult? Function()? clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function(String itemId)? loadItemDetail,
    TResult Function(String itemId, String? location)? redeemItem,
    TResult Function()? refreshItems,
    TResult Function()? clearSelectedItem,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_LoadItemDetail value) loadItemDetail,
    required TResult Function(_RedeemItem value) redeemItem,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_ClearSelectedItem value) clearSelectedItem,
    required TResult Function(_ClearMessages value) clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_LoadItemDetail value)? loadItemDetail,
    TResult? Function(_RedeemItem value)? redeemItem,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_LoadItemDetail value)? loadItemDetail,
    TResult Function(_RedeemItem value)? redeemItem,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardEventCopyWith<$Res> {
  factory $RewardEventCopyWith(
    RewardEvent value,
    $Res Function(RewardEvent) then,
  ) = _$RewardEventCopyWithImpl<$Res, RewardEvent>;
}

/// @nodoc
class _$RewardEventCopyWithImpl<$Res, $Val extends RewardEvent>
    implements $RewardEventCopyWith<$Res> {
  _$RewardEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadItemsImplCopyWith<$Res> {
  factory _$$LoadItemsImplCopyWith(
    _$LoadItemsImpl value,
    $Res Function(_$LoadItemsImpl) then,
  ) = __$$LoadItemsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadItemsImplCopyWithImpl<$Res>
    extends _$RewardEventCopyWithImpl<$Res, _$LoadItemsImpl>
    implements _$$LoadItemsImplCopyWith<$Res> {
  __$$LoadItemsImplCopyWithImpl(
    _$LoadItemsImpl _value,
    $Res Function(_$LoadItemsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadItemsImpl implements _LoadItems {
  const _$LoadItemsImpl();

  @override
  String toString() {
    return 'RewardEvent.loadItems()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadItemsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function(String itemId) loadItemDetail,
    required TResult Function(String itemId, String? location) redeemItem,
    required TResult Function() refreshItems,
    required TResult Function() clearSelectedItem,
    required TResult Function() clearMessages,
  }) {
    return loadItems();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function(String itemId)? loadItemDetail,
    TResult? Function(String itemId, String? location)? redeemItem,
    TResult? Function()? refreshItems,
    TResult? Function()? clearSelectedItem,
    TResult? Function()? clearMessages,
  }) {
    return loadItems?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function(String itemId)? loadItemDetail,
    TResult Function(String itemId, String? location)? redeemItem,
    TResult Function()? refreshItems,
    TResult Function()? clearSelectedItem,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadItems != null) {
      return loadItems();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_LoadItemDetail value) loadItemDetail,
    required TResult Function(_RedeemItem value) redeemItem,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_ClearSelectedItem value) clearSelectedItem,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_LoadItemDetail value)? loadItemDetail,
    TResult? Function(_RedeemItem value)? redeemItem,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_LoadItemDetail value)? loadItemDetail,
    TResult Function(_RedeemItem value)? redeemItem,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadItems != null) {
      return loadItems(this);
    }
    return orElse();
  }
}

abstract class _LoadItems implements RewardEvent {
  const factory _LoadItems() = _$LoadItemsImpl;
}

/// @nodoc
abstract class _$$LoadItemDetailImplCopyWith<$Res> {
  factory _$$LoadItemDetailImplCopyWith(
    _$LoadItemDetailImpl value,
    $Res Function(_$LoadItemDetailImpl) then,
  ) = __$$LoadItemDetailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String itemId});
}

/// @nodoc
class __$$LoadItemDetailImplCopyWithImpl<$Res>
    extends _$RewardEventCopyWithImpl<$Res, _$LoadItemDetailImpl>
    implements _$$LoadItemDetailImplCopyWith<$Res> {
  __$$LoadItemDetailImplCopyWithImpl(
    _$LoadItemDetailImpl _value,
    $Res Function(_$LoadItemDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? itemId = null}) {
    return _then(
      _$LoadItemDetailImpl(
        null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadItemDetailImpl implements _LoadItemDetail {
  const _$LoadItemDetailImpl(this.itemId);

  @override
  final String itemId;

  @override
  String toString() {
    return 'RewardEvent.loadItemDetail(itemId: $itemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadItemDetailImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, itemId);

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadItemDetailImplCopyWith<_$LoadItemDetailImpl> get copyWith =>
      __$$LoadItemDetailImplCopyWithImpl<_$LoadItemDetailImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function(String itemId) loadItemDetail,
    required TResult Function(String itemId, String? location) redeemItem,
    required TResult Function() refreshItems,
    required TResult Function() clearSelectedItem,
    required TResult Function() clearMessages,
  }) {
    return loadItemDetail(itemId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function(String itemId)? loadItemDetail,
    TResult? Function(String itemId, String? location)? redeemItem,
    TResult? Function()? refreshItems,
    TResult? Function()? clearSelectedItem,
    TResult? Function()? clearMessages,
  }) {
    return loadItemDetail?.call(itemId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function(String itemId)? loadItemDetail,
    TResult Function(String itemId, String? location)? redeemItem,
    TResult Function()? refreshItems,
    TResult Function()? clearSelectedItem,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadItemDetail != null) {
      return loadItemDetail(itemId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_LoadItemDetail value) loadItemDetail,
    required TResult Function(_RedeemItem value) redeemItem,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_ClearSelectedItem value) clearSelectedItem,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadItemDetail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_LoadItemDetail value)? loadItemDetail,
    TResult? Function(_RedeemItem value)? redeemItem,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadItemDetail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_LoadItemDetail value)? loadItemDetail,
    TResult Function(_RedeemItem value)? redeemItem,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadItemDetail != null) {
      return loadItemDetail(this);
    }
    return orElse();
  }
}

abstract class _LoadItemDetail implements RewardEvent {
  const factory _LoadItemDetail(final String itemId) = _$LoadItemDetailImpl;

  String get itemId;

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadItemDetailImplCopyWith<_$LoadItemDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RedeemItemImplCopyWith<$Res> {
  factory _$$RedeemItemImplCopyWith(
    _$RedeemItemImpl value,
    $Res Function(_$RedeemItemImpl) then,
  ) = __$$RedeemItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String itemId, String? location});
}

/// @nodoc
class __$$RedeemItemImplCopyWithImpl<$Res>
    extends _$RewardEventCopyWithImpl<$Res, _$RedeemItemImpl>
    implements _$$RedeemItemImplCopyWith<$Res> {
  __$$RedeemItemImplCopyWithImpl(
    _$RedeemItemImpl _value,
    $Res Function(_$RedeemItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? itemId = null, Object? location = freezed}) {
    return _then(
      _$RedeemItemImpl(
        null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RedeemItemImpl implements _RedeemItem {
  const _$RedeemItemImpl(this.itemId, {this.location});

  @override
  final String itemId;
  @override
  final String? location;

  @override
  String toString() {
    return 'RewardEvent.redeemItem(itemId: $itemId, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RedeemItemImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, itemId, location);

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RedeemItemImplCopyWith<_$RedeemItemImpl> get copyWith =>
      __$$RedeemItemImplCopyWithImpl<_$RedeemItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function(String itemId) loadItemDetail,
    required TResult Function(String itemId, String? location) redeemItem,
    required TResult Function() refreshItems,
    required TResult Function() clearSelectedItem,
    required TResult Function() clearMessages,
  }) {
    return redeemItem(itemId, location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function(String itemId)? loadItemDetail,
    TResult? Function(String itemId, String? location)? redeemItem,
    TResult? Function()? refreshItems,
    TResult? Function()? clearSelectedItem,
    TResult? Function()? clearMessages,
  }) {
    return redeemItem?.call(itemId, location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function(String itemId)? loadItemDetail,
    TResult Function(String itemId, String? location)? redeemItem,
    TResult Function()? refreshItems,
    TResult Function()? clearSelectedItem,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (redeemItem != null) {
      return redeemItem(itemId, location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_LoadItemDetail value) loadItemDetail,
    required TResult Function(_RedeemItem value) redeemItem,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_ClearSelectedItem value) clearSelectedItem,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return redeemItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_LoadItemDetail value)? loadItemDetail,
    TResult? Function(_RedeemItem value)? redeemItem,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return redeemItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_LoadItemDetail value)? loadItemDetail,
    TResult Function(_RedeemItem value)? redeemItem,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (redeemItem != null) {
      return redeemItem(this);
    }
    return orElse();
  }
}

abstract class _RedeemItem implements RewardEvent {
  const factory _RedeemItem(final String itemId, {final String? location}) =
      _$RedeemItemImpl;

  String get itemId;
  String? get location;

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RedeemItemImplCopyWith<_$RedeemItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshItemsImplCopyWith<$Res> {
  factory _$$RefreshItemsImplCopyWith(
    _$RefreshItemsImpl value,
    $Res Function(_$RefreshItemsImpl) then,
  ) = __$$RefreshItemsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshItemsImplCopyWithImpl<$Res>
    extends _$RewardEventCopyWithImpl<$Res, _$RefreshItemsImpl>
    implements _$$RefreshItemsImplCopyWith<$Res> {
  __$$RefreshItemsImplCopyWithImpl(
    _$RefreshItemsImpl _value,
    $Res Function(_$RefreshItemsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshItemsImpl implements _RefreshItems {
  const _$RefreshItemsImpl();

  @override
  String toString() {
    return 'RewardEvent.refreshItems()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshItemsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function(String itemId) loadItemDetail,
    required TResult Function(String itemId, String? location) redeemItem,
    required TResult Function() refreshItems,
    required TResult Function() clearSelectedItem,
    required TResult Function() clearMessages,
  }) {
    return refreshItems();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function(String itemId)? loadItemDetail,
    TResult? Function(String itemId, String? location)? redeemItem,
    TResult? Function()? refreshItems,
    TResult? Function()? clearSelectedItem,
    TResult? Function()? clearMessages,
  }) {
    return refreshItems?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function(String itemId)? loadItemDetail,
    TResult Function(String itemId, String? location)? redeemItem,
    TResult Function()? refreshItems,
    TResult Function()? clearSelectedItem,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (refreshItems != null) {
      return refreshItems();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_LoadItemDetail value) loadItemDetail,
    required TResult Function(_RedeemItem value) redeemItem,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_ClearSelectedItem value) clearSelectedItem,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return refreshItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_LoadItemDetail value)? loadItemDetail,
    TResult? Function(_RedeemItem value)? redeemItem,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return refreshItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_LoadItemDetail value)? loadItemDetail,
    TResult Function(_RedeemItem value)? redeemItem,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (refreshItems != null) {
      return refreshItems(this);
    }
    return orElse();
  }
}

abstract class _RefreshItems implements RewardEvent {
  const factory _RefreshItems() = _$RefreshItemsImpl;
}

/// @nodoc
abstract class _$$ClearSelectedItemImplCopyWith<$Res> {
  factory _$$ClearSelectedItemImplCopyWith(
    _$ClearSelectedItemImpl value,
    $Res Function(_$ClearSelectedItemImpl) then,
  ) = __$$ClearSelectedItemImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSelectedItemImplCopyWithImpl<$Res>
    extends _$RewardEventCopyWithImpl<$Res, _$ClearSelectedItemImpl>
    implements _$$ClearSelectedItemImplCopyWith<$Res> {
  __$$ClearSelectedItemImplCopyWithImpl(
    _$ClearSelectedItemImpl _value,
    $Res Function(_$ClearSelectedItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSelectedItemImpl implements _ClearSelectedItem {
  const _$ClearSelectedItemImpl();

  @override
  String toString() {
    return 'RewardEvent.clearSelectedItem()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSelectedItemImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadItems,
    required TResult Function(String itemId) loadItemDetail,
    required TResult Function(String itemId, String? location) redeemItem,
    required TResult Function() refreshItems,
    required TResult Function() clearSelectedItem,
    required TResult Function() clearMessages,
  }) {
    return clearSelectedItem();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function(String itemId)? loadItemDetail,
    TResult? Function(String itemId, String? location)? redeemItem,
    TResult? Function()? refreshItems,
    TResult? Function()? clearSelectedItem,
    TResult? Function()? clearMessages,
  }) {
    return clearSelectedItem?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function(String itemId)? loadItemDetail,
    TResult Function(String itemId, String? location)? redeemItem,
    TResult Function()? refreshItems,
    TResult Function()? clearSelectedItem,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (clearSelectedItem != null) {
      return clearSelectedItem();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_LoadItemDetail value) loadItemDetail,
    required TResult Function(_RedeemItem value) redeemItem,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_ClearSelectedItem value) clearSelectedItem,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return clearSelectedItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_LoadItemDetail value)? loadItemDetail,
    TResult? Function(_RedeemItem value)? redeemItem,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return clearSelectedItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_LoadItemDetail value)? loadItemDetail,
    TResult Function(_RedeemItem value)? redeemItem,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (clearSelectedItem != null) {
      return clearSelectedItem(this);
    }
    return orElse();
  }
}

abstract class _ClearSelectedItem implements RewardEvent {
  const factory _ClearSelectedItem() = _$ClearSelectedItemImpl;
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
    extends _$RewardEventCopyWithImpl<$Res, _$ClearMessagesImpl>
    implements _$$ClearMessagesImplCopyWith<$Res> {
  __$$ClearMessagesImplCopyWithImpl(
    _$ClearMessagesImpl _value,
    $Res Function(_$ClearMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearMessagesImpl implements _ClearMessages {
  const _$ClearMessagesImpl();

  @override
  String toString() {
    return 'RewardEvent.clearMessages()';
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
    required TResult Function() loadItems,
    required TResult Function(String itemId) loadItemDetail,
    required TResult Function(String itemId, String? location) redeemItem,
    required TResult Function() refreshItems,
    required TResult Function() clearSelectedItem,
    required TResult Function() clearMessages,
  }) {
    return clearMessages();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadItems,
    TResult? Function(String itemId)? loadItemDetail,
    TResult? Function(String itemId, String? location)? redeemItem,
    TResult? Function()? refreshItems,
    TResult? Function()? clearSelectedItem,
    TResult? Function()? clearMessages,
  }) {
    return clearMessages?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadItems,
    TResult Function(String itemId)? loadItemDetail,
    TResult Function(String itemId, String? location)? redeemItem,
    TResult Function()? refreshItems,
    TResult Function()? clearSelectedItem,
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
    required TResult Function(_LoadItems value) loadItems,
    required TResult Function(_LoadItemDetail value) loadItemDetail,
    required TResult Function(_RedeemItem value) redeemItem,
    required TResult Function(_RefreshItems value) refreshItems,
    required TResult Function(_ClearSelectedItem value) clearSelectedItem,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return clearMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadItems value)? loadItems,
    TResult? Function(_LoadItemDetail value)? loadItemDetail,
    TResult? Function(_RedeemItem value)? redeemItem,
    TResult? Function(_RefreshItems value)? refreshItems,
    TResult? Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return clearMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadItems value)? loadItems,
    TResult Function(_LoadItemDetail value)? loadItemDetail,
    TResult Function(_RedeemItem value)? redeemItem,
    TResult Function(_RefreshItems value)? refreshItems,
    TResult Function(_ClearSelectedItem value)? clearSelectedItem,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (clearMessages != null) {
      return clearMessages(this);
    }
    return orElse();
  }
}

abstract class _ClearMessages implements RewardEvent {
  const factory _ClearMessages() = _$ClearMessagesImpl;
}

/// @nodoc
mixin _$RewardState {
  List<RewardItem> get items => throw _privateConstructorUsedError;
  RewardItem? get selectedItem => throw _privateConstructorUsedError;
  RewardLoadStatus get status => throw _privateConstructorUsedError;
  RewardLoadStatus get detailStatus => throw _privateConstructorUsedError;
  RewardLoadStatus get redeemStatus => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of RewardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RewardStateCopyWith<RewardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardStateCopyWith<$Res> {
  factory $RewardStateCopyWith(
    RewardState value,
    $Res Function(RewardState) then,
  ) = _$RewardStateCopyWithImpl<$Res, RewardState>;
  @useResult
  $Res call({
    List<RewardItem> items,
    RewardItem? selectedItem,
    RewardLoadStatus status,
    RewardLoadStatus detailStatus,
    RewardLoadStatus redeemStatus,
    String? errorMessage,
    String? successMessage,
  });

  $RewardItemCopyWith<$Res>? get selectedItem;
}

/// @nodoc
class _$RewardStateCopyWithImpl<$Res, $Val extends RewardState>
    implements $RewardStateCopyWith<$Res> {
  _$RewardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RewardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? selectedItem = freezed,
    Object? status = null,
    Object? detailStatus = null,
    Object? redeemStatus = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<RewardItem>,
            selectedItem: freezed == selectedItem
                ? _value.selectedItem
                : selectedItem // ignore: cast_nullable_to_non_nullable
                      as RewardItem?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RewardLoadStatus,
            detailStatus: null == detailStatus
                ? _value.detailStatus
                : detailStatus // ignore: cast_nullable_to_non_nullable
                      as RewardLoadStatus,
            redeemStatus: null == redeemStatus
                ? _value.redeemStatus
                : redeemStatus // ignore: cast_nullable_to_non_nullable
                      as RewardLoadStatus,
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

  /// Create a copy of RewardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RewardItemCopyWith<$Res>? get selectedItem {
    if (_value.selectedItem == null) {
      return null;
    }

    return $RewardItemCopyWith<$Res>(_value.selectedItem!, (value) {
      return _then(_value.copyWith(selectedItem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RewardStateImplCopyWith<$Res>
    implements $RewardStateCopyWith<$Res> {
  factory _$$RewardStateImplCopyWith(
    _$RewardStateImpl value,
    $Res Function(_$RewardStateImpl) then,
  ) = __$$RewardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<RewardItem> items,
    RewardItem? selectedItem,
    RewardLoadStatus status,
    RewardLoadStatus detailStatus,
    RewardLoadStatus redeemStatus,
    String? errorMessage,
    String? successMessage,
  });

  @override
  $RewardItemCopyWith<$Res>? get selectedItem;
}

/// @nodoc
class __$$RewardStateImplCopyWithImpl<$Res>
    extends _$RewardStateCopyWithImpl<$Res, _$RewardStateImpl>
    implements _$$RewardStateImplCopyWith<$Res> {
  __$$RewardStateImplCopyWithImpl(
    _$RewardStateImpl _value,
    $Res Function(_$RewardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? selectedItem = freezed,
    Object? status = null,
    Object? detailStatus = null,
    Object? redeemStatus = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$RewardStateImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<RewardItem>,
        selectedItem: freezed == selectedItem
            ? _value.selectedItem
            : selectedItem // ignore: cast_nullable_to_non_nullable
                  as RewardItem?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RewardLoadStatus,
        detailStatus: null == detailStatus
            ? _value.detailStatus
            : detailStatus // ignore: cast_nullable_to_non_nullable
                  as RewardLoadStatus,
        redeemStatus: null == redeemStatus
            ? _value.redeemStatus
            : redeemStatus // ignore: cast_nullable_to_non_nullable
                  as RewardLoadStatus,
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

class _$RewardStateImpl extends _RewardState {
  const _$RewardStateImpl({
    final List<RewardItem> items = const [],
    this.selectedItem,
    this.status = RewardLoadStatus.initial,
    this.detailStatus = RewardLoadStatus.initial,
    this.redeemStatus = RewardLoadStatus.initial,
    this.errorMessage,
    this.successMessage,
  }) : _items = items,
       super._();

  final List<RewardItem> _items;
  @override
  @JsonKey()
  List<RewardItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final RewardItem? selectedItem;
  @override
  @JsonKey()
  final RewardLoadStatus status;
  @override
  @JsonKey()
  final RewardLoadStatus detailStatus;
  @override
  @JsonKey()
  final RewardLoadStatus redeemStatus;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'RewardState(items: $items, selectedItem: $selectedItem, status: $status, detailStatus: $detailStatus, redeemStatus: $redeemStatus, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RewardStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.selectedItem, selectedItem) ||
                other.selectedItem == selectedItem) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.detailStatus, detailStatus) ||
                other.detailStatus == detailStatus) &&
            (identical(other.redeemStatus, redeemStatus) ||
                other.redeemStatus == redeemStatus) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    selectedItem,
    status,
    detailStatus,
    redeemStatus,
    errorMessage,
    successMessage,
  );

  /// Create a copy of RewardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RewardStateImplCopyWith<_$RewardStateImpl> get copyWith =>
      __$$RewardStateImplCopyWithImpl<_$RewardStateImpl>(this, _$identity);
}

abstract class _RewardState extends RewardState {
  const factory _RewardState({
    final List<RewardItem> items,
    final RewardItem? selectedItem,
    final RewardLoadStatus status,
    final RewardLoadStatus detailStatus,
    final RewardLoadStatus redeemStatus,
    final String? errorMessage,
    final String? successMessage,
  }) = _$RewardStateImpl;
  const _RewardState._() : super._();

  @override
  List<RewardItem> get items;
  @override
  RewardItem? get selectedItem;
  @override
  RewardLoadStatus get status;
  @override
  RewardLoadStatus get detailStatus;
  @override
  RewardLoadStatus get redeemStatus;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of RewardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RewardStateImplCopyWith<_$RewardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
