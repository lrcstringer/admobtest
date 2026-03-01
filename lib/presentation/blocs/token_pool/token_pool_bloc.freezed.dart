// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_pool_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TokenPoolEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPoolEventCopyWith<$Res> {
  factory $TokenPoolEventCopyWith(
    TokenPoolEvent value,
    $Res Function(TokenPoolEvent) then,
  ) = _$TokenPoolEventCopyWithImpl<$Res, TokenPoolEvent>;
}

/// @nodoc
class _$TokenPoolEventCopyWithImpl<$Res, $Val extends TokenPoolEvent>
    implements $TokenPoolEventCopyWith<$Res> {
  _$TokenPoolEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CreatePoolImplCopyWith<$Res> {
  factory _$$CreatePoolImplCopyWith(
    _$CreatePoolImpl value,
    $Res Function(_$CreatePoolImpl) then,
  ) = __$$CreatePoolImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    PoolMode mode,
    String title,
    String message,
    GiftStyle style,
    String? recipientId,
    List<String> inviteeIds,
  });
}

/// @nodoc
class __$$CreatePoolImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$CreatePoolImpl>
    implements _$$CreatePoolImplCopyWith<$Res> {
  __$$CreatePoolImplCopyWithImpl(
    _$CreatePoolImpl _value,
    $Res Function(_$CreatePoolImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? title = null,
    Object? message = null,
    Object? style = null,
    Object? recipientId = freezed,
    Object? inviteeIds = null,
  }) {
    return _then(
      _$CreatePoolImpl(
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as PoolMode,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        style: null == style
            ? _value.style
            : style // ignore: cast_nullable_to_non_nullable
                  as GiftStyle,
        recipientId: freezed == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String?,
        inviteeIds: null == inviteeIds
            ? _value._inviteeIds
            : inviteeIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$CreatePoolImpl implements _CreatePool {
  const _$CreatePoolImpl({
    required this.mode,
    required this.title,
    required this.message,
    required this.style,
    this.recipientId,
    required final List<String> inviteeIds,
  }) : _inviteeIds = inviteeIds;

  @override
  final PoolMode mode;
  @override
  final String title;
  @override
  final String message;
  @override
  final GiftStyle style;
  @override
  final String? recipientId;
  final List<String> _inviteeIds;
  @override
  List<String> get inviteeIds {
    if (_inviteeIds is EqualUnmodifiableListView) return _inviteeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inviteeIds);
  }

  @override
  String toString() {
    return 'TokenPoolEvent.createPool(mode: $mode, title: $title, message: $message, style: $style, recipientId: $recipientId, inviteeIds: $inviteeIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePoolImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            const DeepCollectionEquality().equals(
              other._inviteeIds,
              _inviteeIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    mode,
    title,
    message,
    style,
    recipientId,
    const DeepCollectionEquality().hash(_inviteeIds),
  );

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePoolImplCopyWith<_$CreatePoolImpl> get copyWith =>
      __$$CreatePoolImplCopyWithImpl<_$CreatePoolImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return createPool(mode, title, message, style, recipientId, inviteeIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return createPool?.call(
      mode,
      title,
      message,
      style,
      recipientId,
      inviteeIds,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (createPool != null) {
      return createPool(mode, title, message, style, recipientId, inviteeIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return createPool(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return createPool?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (createPool != null) {
      return createPool(this);
    }
    return orElse();
  }
}

abstract class _CreatePool implements TokenPoolEvent {
  const factory _CreatePool({
    required final PoolMode mode,
    required final String title,
    required final String message,
    required final GiftStyle style,
    final String? recipientId,
    required final List<String> inviteeIds,
  }) = _$CreatePoolImpl;

  PoolMode get mode;
  String get title;
  String get message;
  GiftStyle get style;
  String? get recipientId;
  List<String> get inviteeIds;

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePoolImplCopyWith<_$CreatePoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContributeImplCopyWith<$Res> {
  factory _$$ContributeImplCopyWith(
    _$ContributeImpl value,
    $Res Function(_$ContributeImpl) then,
  ) = __$$ContributeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String poolId, int amount, bool anonymous});
}

/// @nodoc
class __$$ContributeImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$ContributeImpl>
    implements _$$ContributeImplCopyWith<$Res> {
  __$$ContributeImplCopyWithImpl(
    _$ContributeImpl _value,
    $Res Function(_$ContributeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolId = null,
    Object? amount = null,
    Object? anonymous = null,
  }) {
    return _then(
      _$ContributeImpl(
        poolId: null == poolId
            ? _value.poolId
            : poolId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        anonymous: null == anonymous
            ? _value.anonymous
            : anonymous // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ContributeImpl implements _Contribute {
  const _$ContributeImpl({
    required this.poolId,
    required this.amount,
    required this.anonymous,
  });

  @override
  final String poolId;
  @override
  final int amount;
  @override
  final bool anonymous;

  @override
  String toString() {
    return 'TokenPoolEvent.contribute(poolId: $poolId, amount: $amount, anonymous: $anonymous)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContributeImpl &&
            (identical(other.poolId, poolId) || other.poolId == poolId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.anonymous, anonymous) ||
                other.anonymous == anonymous));
  }

  @override
  int get hashCode => Object.hash(runtimeType, poolId, amount, anonymous);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContributeImplCopyWith<_$ContributeImpl> get copyWith =>
      __$$ContributeImplCopyWithImpl<_$ContributeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return contribute(poolId, amount, anonymous);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return contribute?.call(poolId, amount, anonymous);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (contribute != null) {
      return contribute(poolId, amount, anonymous);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return contribute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return contribute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (contribute != null) {
      return contribute(this);
    }
    return orElse();
  }
}

abstract class _Contribute implements TokenPoolEvent {
  const factory _Contribute({
    required final String poolId,
    required final int amount,
    required final bool anonymous,
  }) = _$ContributeImpl;

  String get poolId;
  int get amount;
  bool get anonymous;

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContributeImplCopyWith<_$ContributeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendGroupGiftImplCopyWith<$Res> {
  factory _$$SendGroupGiftImplCopyWith(
    _$SendGroupGiftImpl value,
    $Res Function(_$SendGroupGiftImpl) then,
  ) = __$$SendGroupGiftImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String poolId});
}

/// @nodoc
class __$$SendGroupGiftImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$SendGroupGiftImpl>
    implements _$$SendGroupGiftImplCopyWith<$Res> {
  __$$SendGroupGiftImplCopyWithImpl(
    _$SendGroupGiftImpl _value,
    $Res Function(_$SendGroupGiftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? poolId = null}) {
    return _then(
      _$SendGroupGiftImpl(
        null == poolId
            ? _value.poolId
            : poolId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SendGroupGiftImpl implements _SendGroupGift {
  const _$SendGroupGiftImpl(this.poolId);

  @override
  final String poolId;

  @override
  String toString() {
    return 'TokenPoolEvent.sendGroupGift(poolId: $poolId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendGroupGiftImpl &&
            (identical(other.poolId, poolId) || other.poolId == poolId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, poolId);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendGroupGiftImplCopyWith<_$SendGroupGiftImpl> get copyWith =>
      __$$SendGroupGiftImplCopyWithImpl<_$SendGroupGiftImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return sendGroupGift(poolId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return sendGroupGift?.call(poolId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (sendGroupGift != null) {
      return sendGroupGift(poolId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return sendGroupGift(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return sendGroupGift?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (sendGroupGift != null) {
      return sendGroupGift(this);
    }
    return orElse();
  }
}

abstract class _SendGroupGift implements TokenPoolEvent {
  const factory _SendGroupGift(final String poolId) = _$SendGroupGiftImpl;

  String get poolId;

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendGroupGiftImplCopyWith<_$SendGroupGiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DistributePoolImplCopyWith<$Res> {
  factory _$$DistributePoolImplCopyWith(
    _$DistributePoolImpl value,
    $Res Function(_$DistributePoolImpl) then,
  ) = __$$DistributePoolImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String poolId, List<Map<String, dynamic>> payouts});
}

/// @nodoc
class __$$DistributePoolImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$DistributePoolImpl>
    implements _$$DistributePoolImplCopyWith<$Res> {
  __$$DistributePoolImplCopyWithImpl(
    _$DistributePoolImpl _value,
    $Res Function(_$DistributePoolImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? poolId = null, Object? payouts = null}) {
    return _then(
      _$DistributePoolImpl(
        poolId: null == poolId
            ? _value.poolId
            : poolId // ignore: cast_nullable_to_non_nullable
                  as String,
        payouts: null == payouts
            ? _value._payouts
            : payouts // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
      ),
    );
  }
}

/// @nodoc

class _$DistributePoolImpl implements _DistributePool {
  const _$DistributePoolImpl({
    required this.poolId,
    required final List<Map<String, dynamic>> payouts,
  }) : _payouts = payouts;

  @override
  final String poolId;
  final List<Map<String, dynamic>> _payouts;
  @override
  List<Map<String, dynamic>> get payouts {
    if (_payouts is EqualUnmodifiableListView) return _payouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payouts);
  }

  @override
  String toString() {
    return 'TokenPoolEvent.distributePool(poolId: $poolId, payouts: $payouts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistributePoolImpl &&
            (identical(other.poolId, poolId) || other.poolId == poolId) &&
            const DeepCollectionEquality().equals(other._payouts, _payouts));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    poolId,
    const DeepCollectionEquality().hash(_payouts),
  );

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DistributePoolImplCopyWith<_$DistributePoolImpl> get copyWith =>
      __$$DistributePoolImplCopyWithImpl<_$DistributePoolImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return distributePool(poolId, payouts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return distributePool?.call(poolId, payouts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (distributePool != null) {
      return distributePool(poolId, payouts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return distributePool(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return distributePool?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (distributePool != null) {
      return distributePool(this);
    }
    return orElse();
  }
}

abstract class _DistributePool implements TokenPoolEvent {
  const factory _DistributePool({
    required final String poolId,
    required final List<Map<String, dynamic>> payouts,
  }) = _$DistributePoolImpl;

  String get poolId;
  List<Map<String, dynamic>> get payouts;

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DistributePoolImplCopyWith<_$DistributePoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelPoolImplCopyWith<$Res> {
  factory _$$CancelPoolImplCopyWith(
    _$CancelPoolImpl value,
    $Res Function(_$CancelPoolImpl) then,
  ) = __$$CancelPoolImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String poolId});
}

/// @nodoc
class __$$CancelPoolImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$CancelPoolImpl>
    implements _$$CancelPoolImplCopyWith<$Res> {
  __$$CancelPoolImplCopyWithImpl(
    _$CancelPoolImpl _value,
    $Res Function(_$CancelPoolImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? poolId = null}) {
    return _then(
      _$CancelPoolImpl(
        null == poolId
            ? _value.poolId
            : poolId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CancelPoolImpl implements _CancelPool {
  const _$CancelPoolImpl(this.poolId);

  @override
  final String poolId;

  @override
  String toString() {
    return 'TokenPoolEvent.cancelPool(poolId: $poolId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelPoolImpl &&
            (identical(other.poolId, poolId) || other.poolId == poolId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, poolId);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelPoolImplCopyWith<_$CancelPoolImpl> get copyWith =>
      __$$CancelPoolImplCopyWithImpl<_$CancelPoolImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return cancelPool(poolId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return cancelPool?.call(poolId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (cancelPool != null) {
      return cancelPool(poolId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return cancelPool(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return cancelPool?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (cancelPool != null) {
      return cancelPool(this);
    }
    return orElse();
  }
}

abstract class _CancelPool implements TokenPoolEvent {
  const factory _CancelPool(final String poolId) = _$CancelPoolImpl;

  String get poolId;

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelPoolImplCopyWith<_$CancelPoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OpenGroupGiftImplCopyWith<$Res> {
  factory _$$OpenGroupGiftImplCopyWith(
    _$OpenGroupGiftImpl value,
    $Res Function(_$OpenGroupGiftImpl) then,
  ) = __$$OpenGroupGiftImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String poolId});
}

/// @nodoc
class __$$OpenGroupGiftImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$OpenGroupGiftImpl>
    implements _$$OpenGroupGiftImplCopyWith<$Res> {
  __$$OpenGroupGiftImplCopyWithImpl(
    _$OpenGroupGiftImpl _value,
    $Res Function(_$OpenGroupGiftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? poolId = null}) {
    return _then(
      _$OpenGroupGiftImpl(
        null == poolId
            ? _value.poolId
            : poolId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$OpenGroupGiftImpl implements _OpenGroupGift {
  const _$OpenGroupGiftImpl(this.poolId);

  @override
  final String poolId;

  @override
  String toString() {
    return 'TokenPoolEvent.openGroupGift(poolId: $poolId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpenGroupGiftImpl &&
            (identical(other.poolId, poolId) || other.poolId == poolId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, poolId);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpenGroupGiftImplCopyWith<_$OpenGroupGiftImpl> get copyWith =>
      __$$OpenGroupGiftImplCopyWithImpl<_$OpenGroupGiftImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return openGroupGift(poolId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return openGroupGift?.call(poolId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (openGroupGift != null) {
      return openGroupGift(poolId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return openGroupGift(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return openGroupGift?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (openGroupGift != null) {
      return openGroupGift(this);
    }
    return orElse();
  }
}

abstract class _OpenGroupGift implements TokenPoolEvent {
  const factory _OpenGroupGift(final String poolId) = _$OpenGroupGiftImpl;

  String get poolId;

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpenGroupGiftImplCopyWith<_$OpenGroupGiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClaimGroupGiftImplCopyWith<$Res> {
  factory _$$ClaimGroupGiftImplCopyWith(
    _$ClaimGroupGiftImpl value,
    $Res Function(_$ClaimGroupGiftImpl) then,
  ) = __$$ClaimGroupGiftImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String poolId});
}

/// @nodoc
class __$$ClaimGroupGiftImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$ClaimGroupGiftImpl>
    implements _$$ClaimGroupGiftImplCopyWith<$Res> {
  __$$ClaimGroupGiftImplCopyWithImpl(
    _$ClaimGroupGiftImpl _value,
    $Res Function(_$ClaimGroupGiftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? poolId = null}) {
    return _then(
      _$ClaimGroupGiftImpl(
        null == poolId
            ? _value.poolId
            : poolId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ClaimGroupGiftImpl implements _ClaimGroupGift {
  const _$ClaimGroupGiftImpl(this.poolId);

  @override
  final String poolId;

  @override
  String toString() {
    return 'TokenPoolEvent.claimGroupGift(poolId: $poolId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimGroupGiftImpl &&
            (identical(other.poolId, poolId) || other.poolId == poolId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, poolId);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimGroupGiftImplCopyWith<_$ClaimGroupGiftImpl> get copyWith =>
      __$$ClaimGroupGiftImplCopyWithImpl<_$ClaimGroupGiftImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return claimGroupGift(poolId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return claimGroupGift?.call(poolId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (claimGroupGift != null) {
      return claimGroupGift(poolId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return claimGroupGift(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return claimGroupGift?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (claimGroupGift != null) {
      return claimGroupGift(this);
    }
    return orElse();
  }
}

abstract class _ClaimGroupGift implements TokenPoolEvent {
  const factory _ClaimGroupGift(final String poolId) = _$ClaimGroupGiftImpl;

  String get poolId;

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClaimGroupGiftImplCopyWith<_$ClaimGroupGiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchPoolImplCopyWith<$Res> {
  factory _$$WatchPoolImplCopyWith(
    _$WatchPoolImpl value,
    $Res Function(_$WatchPoolImpl) then,
  ) = __$$WatchPoolImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String poolId});
}

/// @nodoc
class __$$WatchPoolImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$WatchPoolImpl>
    implements _$$WatchPoolImplCopyWith<$Res> {
  __$$WatchPoolImplCopyWithImpl(
    _$WatchPoolImpl _value,
    $Res Function(_$WatchPoolImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? poolId = null}) {
    return _then(
      _$WatchPoolImpl(
        null == poolId
            ? _value.poolId
            : poolId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WatchPoolImpl implements _WatchPool {
  const _$WatchPoolImpl(this.poolId);

  @override
  final String poolId;

  @override
  String toString() {
    return 'TokenPoolEvent.watchPool(poolId: $poolId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchPoolImpl &&
            (identical(other.poolId, poolId) || other.poolId == poolId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, poolId);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchPoolImplCopyWith<_$WatchPoolImpl> get copyWith =>
      __$$WatchPoolImplCopyWithImpl<_$WatchPoolImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return watchPool(poolId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return watchPool?.call(poolId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (watchPool != null) {
      return watchPool(poolId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return watchPool(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return watchPool?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (watchPool != null) {
      return watchPool(this);
    }
    return orElse();
  }
}

abstract class _WatchPool implements TokenPoolEvent {
  const factory _WatchPool(final String poolId) = _$WatchPoolImpl;

  String get poolId;

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchPoolImplCopyWith<_$WatchPoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PoolUpdatedImplCopyWith<$Res> {
  factory _$$PoolUpdatedImplCopyWith(
    _$PoolUpdatedImpl value,
    $Res Function(_$PoolUpdatedImpl) then,
  ) = __$$PoolUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TokenPool pool});

  $TokenPoolCopyWith<$Res> get pool;
}

/// @nodoc
class __$$PoolUpdatedImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$PoolUpdatedImpl>
    implements _$$PoolUpdatedImplCopyWith<$Res> {
  __$$PoolUpdatedImplCopyWithImpl(
    _$PoolUpdatedImpl _value,
    $Res Function(_$PoolUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? pool = null}) {
    return _then(
      _$PoolUpdatedImpl(
        null == pool
            ? _value.pool
            : pool // ignore: cast_nullable_to_non_nullable
                  as TokenPool,
      ),
    );
  }

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenPoolCopyWith<$Res> get pool {
    return $TokenPoolCopyWith<$Res>(_value.pool, (value) {
      return _then(_value.copyWith(pool: value));
    });
  }
}

/// @nodoc

class _$PoolUpdatedImpl implements _PoolUpdated {
  const _$PoolUpdatedImpl(this.pool);

  @override
  final TokenPool pool;

  @override
  String toString() {
    return 'TokenPoolEvent.poolUpdated(pool: $pool)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoolUpdatedImpl &&
            (identical(other.pool, pool) || other.pool == pool));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pool);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoolUpdatedImplCopyWith<_$PoolUpdatedImpl> get copyWith =>
      __$$PoolUpdatedImplCopyWithImpl<_$PoolUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return poolUpdated(pool);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return poolUpdated?.call(pool);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (poolUpdated != null) {
      return poolUpdated(pool);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return poolUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return poolUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (poolUpdated != null) {
      return poolUpdated(this);
    }
    return orElse();
  }
}

abstract class _PoolUpdated implements TokenPoolEvent {
  const factory _PoolUpdated(final TokenPool pool) = _$PoolUpdatedImpl;

  TokenPool get pool;

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoolUpdatedImplCopyWith<_$PoolUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMyPoolsImplCopyWith<$Res> {
  factory _$$LoadMyPoolsImplCopyWith(
    _$LoadMyPoolsImpl value,
    $Res Function(_$LoadMyPoolsImpl) then,
  ) = __$$LoadMyPoolsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMyPoolsImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$LoadMyPoolsImpl>
    implements _$$LoadMyPoolsImplCopyWith<$Res> {
  __$$LoadMyPoolsImplCopyWithImpl(
    _$LoadMyPoolsImpl _value,
    $Res Function(_$LoadMyPoolsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMyPoolsImpl implements _LoadMyPools {
  const _$LoadMyPoolsImpl();

  @override
  String toString() {
    return 'TokenPoolEvent.loadMyPools()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMyPoolsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return loadMyPools();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return loadMyPools?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (loadMyPools != null) {
      return loadMyPools();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return loadMyPools(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return loadMyPools?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (loadMyPools != null) {
      return loadMyPools(this);
    }
    return orElse();
  }
}

abstract class _LoadMyPools implements TokenPoolEvent {
  const factory _LoadMyPools() = _$LoadMyPoolsImpl;
}

/// @nodoc
abstract class _$$ClearErrorImplCopyWith<$Res> {
  factory _$$ClearErrorImplCopyWith(
    _$ClearErrorImpl value,
    $Res Function(_$ClearErrorImpl) then,
  ) = __$$ClearErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearErrorImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'TokenPoolEvent.clearError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements TokenPoolEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
abstract class _$$ResetImplCopyWith<$Res> {
  factory _$$ResetImplCopyWith(
    _$ResetImpl value,
    $Res Function(_$ResetImpl) then,
  ) = __$$ResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetImplCopyWithImpl<$Res>
    extends _$TokenPoolEventCopyWithImpl<$Res, _$ResetImpl>
    implements _$$ResetImplCopyWith<$Res> {
  __$$ResetImplCopyWithImpl(
    _$ResetImpl _value,
    $Res Function(_$ResetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetImpl implements _Reset {
  const _$ResetImpl();

  @override
  String toString() {
    return 'TokenPoolEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )
    createPool,
    required TResult Function(String poolId, int amount, bool anonymous)
    contribute,
    required TResult Function(String poolId) sendGroupGift,
    required TResult Function(String poolId, List<Map<String, dynamic>> payouts)
    distributePool,
    required TResult Function(String poolId) cancelPool,
    required TResult Function(String poolId) openGroupGift,
    required TResult Function(String poolId) claimGroupGift,
    required TResult Function(String poolId) watchPool,
    required TResult Function(TokenPool pool) poolUpdated,
    required TResult Function() loadMyPools,
    required TResult Function() clearError,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult? Function(String poolId, int amount, bool anonymous)? contribute,
    TResult? Function(String poolId)? sendGroupGift,
    TResult? Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult? Function(String poolId)? cancelPool,
    TResult? Function(String poolId)? openGroupGift,
    TResult? Function(String poolId)? claimGroupGift,
    TResult? Function(String poolId)? watchPool,
    TResult? Function(TokenPool pool)? poolUpdated,
    TResult? Function()? loadMyPools,
    TResult? Function()? clearError,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      PoolMode mode,
      String title,
      String message,
      GiftStyle style,
      String? recipientId,
      List<String> inviteeIds,
    )?
    createPool,
    TResult Function(String poolId, int amount, bool anonymous)? contribute,
    TResult Function(String poolId)? sendGroupGift,
    TResult Function(String poolId, List<Map<String, dynamic>> payouts)?
    distributePool,
    TResult Function(String poolId)? cancelPool,
    TResult Function(String poolId)? openGroupGift,
    TResult Function(String poolId)? claimGroupGift,
    TResult Function(String poolId)? watchPool,
    TResult Function(TokenPool pool)? poolUpdated,
    TResult Function()? loadMyPools,
    TResult Function()? clearError,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreatePool value) createPool,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_SendGroupGift value) sendGroupGift,
    required TResult Function(_DistributePool value) distributePool,
    required TResult Function(_CancelPool value) cancelPool,
    required TResult Function(_OpenGroupGift value) openGroupGift,
    required TResult Function(_ClaimGroupGift value) claimGroupGift,
    required TResult Function(_WatchPool value) watchPool,
    required TResult Function(_PoolUpdated value) poolUpdated,
    required TResult Function(_LoadMyPools value) loadMyPools,
    required TResult Function(_ClearError value) clearError,
    required TResult Function(_Reset value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreatePool value)? createPool,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_SendGroupGift value)? sendGroupGift,
    TResult? Function(_DistributePool value)? distributePool,
    TResult? Function(_CancelPool value)? cancelPool,
    TResult? Function(_OpenGroupGift value)? openGroupGift,
    TResult? Function(_ClaimGroupGift value)? claimGroupGift,
    TResult? Function(_WatchPool value)? watchPool,
    TResult? Function(_PoolUpdated value)? poolUpdated,
    TResult? Function(_LoadMyPools value)? loadMyPools,
    TResult? Function(_ClearError value)? clearError,
    TResult? Function(_Reset value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePool value)? createPool,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_SendGroupGift value)? sendGroupGift,
    TResult Function(_DistributePool value)? distributePool,
    TResult Function(_CancelPool value)? cancelPool,
    TResult Function(_OpenGroupGift value)? openGroupGift,
    TResult Function(_ClaimGroupGift value)? claimGroupGift,
    TResult Function(_WatchPool value)? watchPool,
    TResult Function(_PoolUpdated value)? poolUpdated,
    TResult Function(_LoadMyPools value)? loadMyPools,
    TResult Function(_ClearError value)? clearError,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class _Reset implements TokenPoolEvent {
  const factory _Reset() = _$ResetImpl;
}

/// @nodoc
mixin _$TokenPoolState {
  List<TokenPool> get myPools => throw _privateConstructorUsedError;
  TokenPool? get activePool => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isCreating => throw _privateConstructorUsedError;
  bool get isContributing => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  bool get isDistributing => throw _privateConstructorUsedError;
  bool get isCancelling => throw _privateConstructorUsedError;
  bool get isClaiming => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of TokenPoolState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenPoolStateCopyWith<TokenPoolState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPoolStateCopyWith<$Res> {
  factory $TokenPoolStateCopyWith(
    TokenPoolState value,
    $Res Function(TokenPoolState) then,
  ) = _$TokenPoolStateCopyWithImpl<$Res, TokenPoolState>;
  @useResult
  $Res call({
    List<TokenPool> myPools,
    TokenPool? activePool,
    bool isLoading,
    bool isCreating,
    bool isContributing,
    bool isSending,
    bool isDistributing,
    bool isCancelling,
    bool isClaiming,
    String? errorMessage,
    String? successMessage,
  });

  $TokenPoolCopyWith<$Res>? get activePool;
}

/// @nodoc
class _$TokenPoolStateCopyWithImpl<$Res, $Val extends TokenPoolState>
    implements $TokenPoolStateCopyWith<$Res> {
  _$TokenPoolStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenPoolState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myPools = null,
    Object? activePool = freezed,
    Object? isLoading = null,
    Object? isCreating = null,
    Object? isContributing = null,
    Object? isSending = null,
    Object? isDistributing = null,
    Object? isCancelling = null,
    Object? isClaiming = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            myPools: null == myPools
                ? _value.myPools
                : myPools // ignore: cast_nullable_to_non_nullable
                      as List<TokenPool>,
            activePool: freezed == activePool
                ? _value.activePool
                : activePool // ignore: cast_nullable_to_non_nullable
                      as TokenPool?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCreating: null == isCreating
                ? _value.isCreating
                : isCreating // ignore: cast_nullable_to_non_nullable
                      as bool,
            isContributing: null == isContributing
                ? _value.isContributing
                : isContributing // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSending: null == isSending
                ? _value.isSending
                : isSending // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDistributing: null == isDistributing
                ? _value.isDistributing
                : isDistributing // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCancelling: null == isCancelling
                ? _value.isCancelling
                : isCancelling // ignore: cast_nullable_to_non_nullable
                      as bool,
            isClaiming: null == isClaiming
                ? _value.isClaiming
                : isClaiming // ignore: cast_nullable_to_non_nullable
                      as bool,
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

  /// Create a copy of TokenPoolState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenPoolCopyWith<$Res>? get activePool {
    if (_value.activePool == null) {
      return null;
    }

    return $TokenPoolCopyWith<$Res>(_value.activePool!, (value) {
      return _then(_value.copyWith(activePool: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokenPoolStateImplCopyWith<$Res>
    implements $TokenPoolStateCopyWith<$Res> {
  factory _$$TokenPoolStateImplCopyWith(
    _$TokenPoolStateImpl value,
    $Res Function(_$TokenPoolStateImpl) then,
  ) = __$$TokenPoolStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<TokenPool> myPools,
    TokenPool? activePool,
    bool isLoading,
    bool isCreating,
    bool isContributing,
    bool isSending,
    bool isDistributing,
    bool isCancelling,
    bool isClaiming,
    String? errorMessage,
    String? successMessage,
  });

  @override
  $TokenPoolCopyWith<$Res>? get activePool;
}

/// @nodoc
class __$$TokenPoolStateImplCopyWithImpl<$Res>
    extends _$TokenPoolStateCopyWithImpl<$Res, _$TokenPoolStateImpl>
    implements _$$TokenPoolStateImplCopyWith<$Res> {
  __$$TokenPoolStateImplCopyWithImpl(
    _$TokenPoolStateImpl _value,
    $Res Function(_$TokenPoolStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPoolState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myPools = null,
    Object? activePool = freezed,
    Object? isLoading = null,
    Object? isCreating = null,
    Object? isContributing = null,
    Object? isSending = null,
    Object? isDistributing = null,
    Object? isCancelling = null,
    Object? isClaiming = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _$TokenPoolStateImpl(
        myPools: null == myPools
            ? _value._myPools
            : myPools // ignore: cast_nullable_to_non_nullable
                  as List<TokenPool>,
        activePool: freezed == activePool
            ? _value.activePool
            : activePool // ignore: cast_nullable_to_non_nullable
                  as TokenPool?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCreating: null == isCreating
            ? _value.isCreating
            : isCreating // ignore: cast_nullable_to_non_nullable
                  as bool,
        isContributing: null == isContributing
            ? _value.isContributing
            : isContributing // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSending: null == isSending
            ? _value.isSending
            : isSending // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDistributing: null == isDistributing
            ? _value.isDistributing
            : isDistributing // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCancelling: null == isCancelling
            ? _value.isCancelling
            : isCancelling // ignore: cast_nullable_to_non_nullable
                  as bool,
        isClaiming: null == isClaiming
            ? _value.isClaiming
            : isClaiming // ignore: cast_nullable_to_non_nullable
                  as bool,
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

class _$TokenPoolStateImpl implements _TokenPoolState {
  const _$TokenPoolStateImpl({
    final List<TokenPool> myPools = const [],
    this.activePool,
    this.isLoading = false,
    this.isCreating = false,
    this.isContributing = false,
    this.isSending = false,
    this.isDistributing = false,
    this.isCancelling = false,
    this.isClaiming = false,
    this.errorMessage,
    this.successMessage,
  }) : _myPools = myPools;

  final List<TokenPool> _myPools;
  @override
  @JsonKey()
  List<TokenPool> get myPools {
    if (_myPools is EqualUnmodifiableListView) return _myPools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myPools);
  }

  @override
  final TokenPool? activePool;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isCreating;
  @override
  @JsonKey()
  final bool isContributing;
  @override
  @JsonKey()
  final bool isSending;
  @override
  @JsonKey()
  final bool isDistributing;
  @override
  @JsonKey()
  final bool isCancelling;
  @override
  @JsonKey()
  final bool isClaiming;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'TokenPoolState(myPools: $myPools, activePool: $activePool, isLoading: $isLoading, isCreating: $isCreating, isContributing: $isContributing, isSending: $isSending, isDistributing: $isDistributing, isCancelling: $isCancelling, isClaiming: $isClaiming, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenPoolStateImpl &&
            const DeepCollectionEquality().equals(other._myPools, _myPools) &&
            (identical(other.activePool, activePool) ||
                other.activePool == activePool) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating) &&
            (identical(other.isContributing, isContributing) ||
                other.isContributing == isContributing) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.isDistributing, isDistributing) ||
                other.isDistributing == isDistributing) &&
            (identical(other.isCancelling, isCancelling) ||
                other.isCancelling == isCancelling) &&
            (identical(other.isClaiming, isClaiming) ||
                other.isClaiming == isClaiming) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_myPools),
    activePool,
    isLoading,
    isCreating,
    isContributing,
    isSending,
    isDistributing,
    isCancelling,
    isClaiming,
    errorMessage,
    successMessage,
  );

  /// Create a copy of TokenPoolState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenPoolStateImplCopyWith<_$TokenPoolStateImpl> get copyWith =>
      __$$TokenPoolStateImplCopyWithImpl<_$TokenPoolStateImpl>(
        this,
        _$identity,
      );
}

abstract class _TokenPoolState implements TokenPoolState {
  const factory _TokenPoolState({
    final List<TokenPool> myPools,
    final TokenPool? activePool,
    final bool isLoading,
    final bool isCreating,
    final bool isContributing,
    final bool isSending,
    final bool isDistributing,
    final bool isCancelling,
    final bool isClaiming,
    final String? errorMessage,
    final String? successMessage,
  }) = _$TokenPoolStateImpl;

  @override
  List<TokenPool> get myPools;
  @override
  TokenPool? get activePool;
  @override
  bool get isLoading;
  @override
  bool get isCreating;
  @override
  bool get isContributing;
  @override
  bool get isSending;
  @override
  bool get isDistributing;
  @override
  bool get isCancelling;
  @override
  bool get isClaiming;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of TokenPoolState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenPoolStateImplCopyWith<_$TokenPoolStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
