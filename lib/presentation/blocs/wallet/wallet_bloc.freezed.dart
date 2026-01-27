// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WalletEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWallet,
    required TResult Function(String walletId) watchWallet,
    required TResult Function(String walletId, int? limit) loadTransactions,
    required TResult Function() loadMoreTransactions,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function(List<Transaction> transactions)
    transactionsUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWallet,
    TResult? Function(String walletId)? watchWallet,
    TResult? Function(String walletId, int? limit)? loadTransactions,
    TResult? Function()? loadMoreTransactions,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function(List<Transaction> transactions)? transactionsUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWallet,
    TResult Function(String walletId)? watchWallet,
    TResult Function(String walletId, int? limit)? loadTransactions,
    TResult Function()? loadMoreTransactions,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function(List<Transaction> transactions)? transactionsUpdated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadWallet value) loadWallet,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadWallet value)? loadWallet,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadWallet value)? loadWallet,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletEventCopyWith<$Res> {
  factory $WalletEventCopyWith(
    WalletEvent value,
    $Res Function(WalletEvent) then,
  ) = _$WalletEventCopyWithImpl<$Res, WalletEvent>;
}

/// @nodoc
class _$WalletEventCopyWithImpl<$Res, $Val extends WalletEvent>
    implements $WalletEventCopyWith<$Res> {
  _$WalletEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadWalletImplCopyWith<$Res> {
  factory _$$LoadWalletImplCopyWith(
    _$LoadWalletImpl value,
    $Res Function(_$LoadWalletImpl) then,
  ) = __$$LoadWalletImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadWalletImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$LoadWalletImpl>
    implements _$$LoadWalletImplCopyWith<$Res> {
  __$$LoadWalletImplCopyWithImpl(
    _$LoadWalletImpl _value,
    $Res Function(_$LoadWalletImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadWalletImpl implements _LoadWallet {
  const _$LoadWalletImpl();

  @override
  String toString() {
    return 'WalletEvent.loadWallet()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadWalletImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWallet,
    required TResult Function(String walletId) watchWallet,
    required TResult Function(String walletId, int? limit) loadTransactions,
    required TResult Function() loadMoreTransactions,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function(List<Transaction> transactions)
    transactionsUpdated,
  }) {
    return loadWallet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWallet,
    TResult? Function(String walletId)? watchWallet,
    TResult? Function(String walletId, int? limit)? loadTransactions,
    TResult? Function()? loadMoreTransactions,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function(List<Transaction> transactions)? transactionsUpdated,
  }) {
    return loadWallet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWallet,
    TResult Function(String walletId)? watchWallet,
    TResult Function(String walletId, int? limit)? loadTransactions,
    TResult Function()? loadMoreTransactions,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function(List<Transaction> transactions)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (loadWallet != null) {
      return loadWallet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadWallet value) loadWallet,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
  }) {
    return loadWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadWallet value)? loadWallet,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
  }) {
    return loadWallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadWallet value)? loadWallet,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (loadWallet != null) {
      return loadWallet(this);
    }
    return orElse();
  }
}

abstract class _LoadWallet implements WalletEvent {
  const factory _LoadWallet() = _$LoadWalletImpl;
}

/// @nodoc
abstract class _$$WatchWalletImplCopyWith<$Res> {
  factory _$$WatchWalletImplCopyWith(
    _$WatchWalletImpl value,
    $Res Function(_$WatchWalletImpl) then,
  ) = __$$WatchWalletImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String walletId});
}

/// @nodoc
class __$$WatchWalletImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$WatchWalletImpl>
    implements _$$WatchWalletImplCopyWith<$Res> {
  __$$WatchWalletImplCopyWithImpl(
    _$WatchWalletImpl _value,
    $Res Function(_$WatchWalletImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? walletId = null}) {
    return _then(
      _$WatchWalletImpl(
        walletId: null == walletId
            ? _value.walletId
            : walletId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WatchWalletImpl implements _WatchWallet {
  const _$WatchWalletImpl({required this.walletId});

  @override
  final String walletId;

  @override
  String toString() {
    return 'WalletEvent.watchWallet(walletId: $walletId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchWalletImpl &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, walletId);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchWalletImplCopyWith<_$WatchWalletImpl> get copyWith =>
      __$$WatchWalletImplCopyWithImpl<_$WatchWalletImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWallet,
    required TResult Function(String walletId) watchWallet,
    required TResult Function(String walletId, int? limit) loadTransactions,
    required TResult Function() loadMoreTransactions,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function(List<Transaction> transactions)
    transactionsUpdated,
  }) {
    return watchWallet(walletId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWallet,
    TResult? Function(String walletId)? watchWallet,
    TResult? Function(String walletId, int? limit)? loadTransactions,
    TResult? Function()? loadMoreTransactions,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function(List<Transaction> transactions)? transactionsUpdated,
  }) {
    return watchWallet?.call(walletId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWallet,
    TResult Function(String walletId)? watchWallet,
    TResult Function(String walletId, int? limit)? loadTransactions,
    TResult Function()? loadMoreTransactions,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function(List<Transaction> transactions)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (watchWallet != null) {
      return watchWallet(walletId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadWallet value) loadWallet,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
  }) {
    return watchWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadWallet value)? loadWallet,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
  }) {
    return watchWallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadWallet value)? loadWallet,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (watchWallet != null) {
      return watchWallet(this);
    }
    return orElse();
  }
}

abstract class _WatchWallet implements WalletEvent {
  const factory _WatchWallet({required final String walletId}) =
      _$WatchWalletImpl;

  String get walletId;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchWalletImplCopyWith<_$WatchWalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadTransactionsImplCopyWith<$Res> {
  factory _$$LoadTransactionsImplCopyWith(
    _$LoadTransactionsImpl value,
    $Res Function(_$LoadTransactionsImpl) then,
  ) = __$$LoadTransactionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String walletId, int? limit});
}

/// @nodoc
class __$$LoadTransactionsImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$LoadTransactionsImpl>
    implements _$$LoadTransactionsImplCopyWith<$Res> {
  __$$LoadTransactionsImplCopyWithImpl(
    _$LoadTransactionsImpl _value,
    $Res Function(_$LoadTransactionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? walletId = null, Object? limit = freezed}) {
    return _then(
      _$LoadTransactionsImpl(
        walletId: null == walletId
            ? _value.walletId
            : walletId // ignore: cast_nullable_to_non_nullable
                  as String,
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$LoadTransactionsImpl implements _LoadTransactions {
  const _$LoadTransactionsImpl({required this.walletId, this.limit});

  @override
  final String walletId;
  @override
  final int? limit;

  @override
  String toString() {
    return 'WalletEvent.loadTransactions(walletId: $walletId, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadTransactionsImpl &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, walletId, limit);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadTransactionsImplCopyWith<_$LoadTransactionsImpl> get copyWith =>
      __$$LoadTransactionsImplCopyWithImpl<_$LoadTransactionsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWallet,
    required TResult Function(String walletId) watchWallet,
    required TResult Function(String walletId, int? limit) loadTransactions,
    required TResult Function() loadMoreTransactions,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function(List<Transaction> transactions)
    transactionsUpdated,
  }) {
    return loadTransactions(walletId, limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWallet,
    TResult? Function(String walletId)? watchWallet,
    TResult? Function(String walletId, int? limit)? loadTransactions,
    TResult? Function()? loadMoreTransactions,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function(List<Transaction> transactions)? transactionsUpdated,
  }) {
    return loadTransactions?.call(walletId, limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWallet,
    TResult Function(String walletId)? watchWallet,
    TResult Function(String walletId, int? limit)? loadTransactions,
    TResult Function()? loadMoreTransactions,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function(List<Transaction> transactions)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (loadTransactions != null) {
      return loadTransactions(walletId, limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadWallet value) loadWallet,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
  }) {
    return loadTransactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadWallet value)? loadWallet,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
  }) {
    return loadTransactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadWallet value)? loadWallet,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (loadTransactions != null) {
      return loadTransactions(this);
    }
    return orElse();
  }
}

abstract class _LoadTransactions implements WalletEvent {
  const factory _LoadTransactions({
    required final String walletId,
    final int? limit,
  }) = _$LoadTransactionsImpl;

  String get walletId;
  int? get limit;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadTransactionsImplCopyWith<_$LoadTransactionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreTransactionsImplCopyWith<$Res> {
  factory _$$LoadMoreTransactionsImplCopyWith(
    _$LoadMoreTransactionsImpl value,
    $Res Function(_$LoadMoreTransactionsImpl) then,
  ) = __$$LoadMoreTransactionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreTransactionsImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$LoadMoreTransactionsImpl>
    implements _$$LoadMoreTransactionsImplCopyWith<$Res> {
  __$$LoadMoreTransactionsImplCopyWithImpl(
    _$LoadMoreTransactionsImpl _value,
    $Res Function(_$LoadMoreTransactionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreTransactionsImpl implements _LoadMoreTransactions {
  const _$LoadMoreTransactionsImpl();

  @override
  String toString() {
    return 'WalletEvent.loadMoreTransactions()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMoreTransactionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWallet,
    required TResult Function(String walletId) watchWallet,
    required TResult Function(String walletId, int? limit) loadTransactions,
    required TResult Function() loadMoreTransactions,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function(List<Transaction> transactions)
    transactionsUpdated,
  }) {
    return loadMoreTransactions();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWallet,
    TResult? Function(String walletId)? watchWallet,
    TResult? Function(String walletId, int? limit)? loadTransactions,
    TResult? Function()? loadMoreTransactions,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function(List<Transaction> transactions)? transactionsUpdated,
  }) {
    return loadMoreTransactions?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWallet,
    TResult Function(String walletId)? watchWallet,
    TResult Function(String walletId, int? limit)? loadTransactions,
    TResult Function()? loadMoreTransactions,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function(List<Transaction> transactions)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (loadMoreTransactions != null) {
      return loadMoreTransactions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadWallet value) loadWallet,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
  }) {
    return loadMoreTransactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadWallet value)? loadWallet,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
  }) {
    return loadMoreTransactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadWallet value)? loadWallet,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (loadMoreTransactions != null) {
      return loadMoreTransactions(this);
    }
    return orElse();
  }
}

abstract class _LoadMoreTransactions implements WalletEvent {
  const factory _LoadMoreTransactions() = _$LoadMoreTransactionsImpl;
}

/// @nodoc
abstract class _$$WalletUpdatedImplCopyWith<$Res> {
  factory _$$WalletUpdatedImplCopyWith(
    _$WalletUpdatedImpl value,
    $Res Function(_$WalletUpdatedImpl) then,
  ) = __$$WalletUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Wallet wallet});

  $WalletCopyWith<$Res> get wallet;
}

/// @nodoc
class __$$WalletUpdatedImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$WalletUpdatedImpl>
    implements _$$WalletUpdatedImplCopyWith<$Res> {
  __$$WalletUpdatedImplCopyWithImpl(
    _$WalletUpdatedImpl _value,
    $Res Function(_$WalletUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? wallet = null}) {
    return _then(
      _$WalletUpdatedImpl(
        null == wallet
            ? _value.wallet
            : wallet // ignore: cast_nullable_to_non_nullable
                  as Wallet,
      ),
    );
  }

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletCopyWith<$Res> get wallet {
    return $WalletCopyWith<$Res>(_value.wallet, (value) {
      return _then(_value.copyWith(wallet: value));
    });
  }
}

/// @nodoc

class _$WalletUpdatedImpl implements _WalletUpdated {
  const _$WalletUpdatedImpl(this.wallet);

  @override
  final Wallet wallet;

  @override
  String toString() {
    return 'WalletEvent.walletUpdated(wallet: $wallet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletUpdatedImpl &&
            (identical(other.wallet, wallet) || other.wallet == wallet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wallet);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletUpdatedImplCopyWith<_$WalletUpdatedImpl> get copyWith =>
      __$$WalletUpdatedImplCopyWithImpl<_$WalletUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWallet,
    required TResult Function(String walletId) watchWallet,
    required TResult Function(String walletId, int? limit) loadTransactions,
    required TResult Function() loadMoreTransactions,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function(List<Transaction> transactions)
    transactionsUpdated,
  }) {
    return walletUpdated(wallet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWallet,
    TResult? Function(String walletId)? watchWallet,
    TResult? Function(String walletId, int? limit)? loadTransactions,
    TResult? Function()? loadMoreTransactions,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function(List<Transaction> transactions)? transactionsUpdated,
  }) {
    return walletUpdated?.call(wallet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWallet,
    TResult Function(String walletId)? watchWallet,
    TResult Function(String walletId, int? limit)? loadTransactions,
    TResult Function()? loadMoreTransactions,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function(List<Transaction> transactions)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (walletUpdated != null) {
      return walletUpdated(wallet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadWallet value) loadWallet,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
  }) {
    return walletUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadWallet value)? loadWallet,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
  }) {
    return walletUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadWallet value)? loadWallet,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (walletUpdated != null) {
      return walletUpdated(this);
    }
    return orElse();
  }
}

abstract class _WalletUpdated implements WalletEvent {
  const factory _WalletUpdated(final Wallet wallet) = _$WalletUpdatedImpl;

  Wallet get wallet;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletUpdatedImplCopyWith<_$WalletUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionsUpdatedImplCopyWith<$Res> {
  factory _$$TransactionsUpdatedImplCopyWith(
    _$TransactionsUpdatedImpl value,
    $Res Function(_$TransactionsUpdatedImpl) then,
  ) = __$$TransactionsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Transaction> transactions});
}

/// @nodoc
class __$$TransactionsUpdatedImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$TransactionsUpdatedImpl>
    implements _$$TransactionsUpdatedImplCopyWith<$Res> {
  __$$TransactionsUpdatedImplCopyWithImpl(
    _$TransactionsUpdatedImpl _value,
    $Res Function(_$TransactionsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transactions = null}) {
    return _then(
      _$TransactionsUpdatedImpl(
        null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<Transaction>,
      ),
    );
  }
}

/// @nodoc

class _$TransactionsUpdatedImpl implements _TransactionsUpdated {
  const _$TransactionsUpdatedImpl(final List<Transaction> transactions)
    : _transactions = transactions;

  final List<Transaction> _transactions;
  @override
  List<Transaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  String toString() {
    return 'WalletEvent.transactionsUpdated(transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsUpdatedImpl &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_transactions),
  );

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsUpdatedImplCopyWith<_$TransactionsUpdatedImpl> get copyWith =>
      __$$TransactionsUpdatedImplCopyWithImpl<_$TransactionsUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWallet,
    required TResult Function(String walletId) watchWallet,
    required TResult Function(String walletId, int? limit) loadTransactions,
    required TResult Function() loadMoreTransactions,
    required TResult Function(Wallet wallet) walletUpdated,
    required TResult Function(List<Transaction> transactions)
    transactionsUpdated,
  }) {
    return transactionsUpdated(transactions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWallet,
    TResult? Function(String walletId)? watchWallet,
    TResult? Function(String walletId, int? limit)? loadTransactions,
    TResult? Function()? loadMoreTransactions,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function(List<Transaction> transactions)? transactionsUpdated,
  }) {
    return transactionsUpdated?.call(transactions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWallet,
    TResult Function(String walletId)? watchWallet,
    TResult Function(String walletId, int? limit)? loadTransactions,
    TResult Function()? loadMoreTransactions,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function(List<Transaction> transactions)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (transactionsUpdated != null) {
      return transactionsUpdated(transactions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadWallet value) loadWallet,
    required TResult Function(_WatchWallet value) watchWallet,
    required TResult Function(_LoadTransactions value) loadTransactions,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
    required TResult Function(_WalletUpdated value) walletUpdated,
    required TResult Function(_TransactionsUpdated value) transactionsUpdated,
  }) {
    return transactionsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadWallet value)? loadWallet,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
  }) {
    return transactionsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadWallet value)? loadWallet,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    required TResult orElse(),
  }) {
    if (transactionsUpdated != null) {
      return transactionsUpdated(this);
    }
    return orElse();
  }
}

abstract class _TransactionsUpdated implements WalletEvent {
  const factory _TransactionsUpdated(final List<Transaction> transactions) =
      _$TransactionsUpdatedImpl;

  List<Transaction> get transactions;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsUpdatedImplCopyWith<_$TransactionsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletState {
  WalletStatus get status => throw _privateConstructorUsedError;
  Wallet? get wallet => throw _privateConstructorUsedError;
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMoreTransactions => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletStateCopyWith<WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
    WalletState value,
    $Res Function(WalletState) then,
  ) = _$WalletStateCopyWithImpl<$Res, WalletState>;
  @useResult
  $Res call({
    WalletStatus status,
    Wallet? wallet,
    List<Transaction> transactions,
    bool isLoadingMore,
    bool hasMoreTransactions,
    String? errorMessage,
  });

  $WalletCopyWith<$Res>? get wallet;
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res, $Val extends WalletState>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? wallet = freezed,
    Object? transactions = null,
    Object? isLoadingMore = null,
    Object? hasMoreTransactions = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as WalletStatus,
            wallet: freezed == wallet
                ? _value.wallet
                : wallet // ignore: cast_nullable_to_non_nullable
                      as Wallet?,
            transactions: null == transactions
                ? _value.transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                      as List<Transaction>,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMoreTransactions: null == hasMoreTransactions
                ? _value.hasMoreTransactions
                : hasMoreTransactions // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletCopyWith<$Res>? get wallet {
    if (_value.wallet == null) {
      return null;
    }

    return $WalletCopyWith<$Res>(_value.wallet!, (value) {
      return _then(_value.copyWith(wallet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WalletStateImplCopyWith<$Res>
    implements $WalletStateCopyWith<$Res> {
  factory _$$WalletStateImplCopyWith(
    _$WalletStateImpl value,
    $Res Function(_$WalletStateImpl) then,
  ) = __$$WalletStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WalletStatus status,
    Wallet? wallet,
    List<Transaction> transactions,
    bool isLoadingMore,
    bool hasMoreTransactions,
    String? errorMessage,
  });

  @override
  $WalletCopyWith<$Res>? get wallet;
}

/// @nodoc
class __$$WalletStateImplCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$WalletStateImpl>
    implements _$$WalletStateImplCopyWith<$Res> {
  __$$WalletStateImplCopyWithImpl(
    _$WalletStateImpl _value,
    $Res Function(_$WalletStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? wallet = freezed,
    Object? transactions = null,
    Object? isLoadingMore = null,
    Object? hasMoreTransactions = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$WalletStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as WalletStatus,
        wallet: freezed == wallet
            ? _value.wallet
            : wallet // ignore: cast_nullable_to_non_nullable
                  as Wallet?,
        transactions: null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<Transaction>,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMoreTransactions: null == hasMoreTransactions
            ? _value.hasMoreTransactions
            : hasMoreTransactions // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$WalletStateImpl extends _WalletState {
  const _$WalletStateImpl({
    this.status = WalletStatus.initial,
    this.wallet,
    final List<Transaction> transactions = const [],
    this.isLoadingMore = false,
    this.hasMoreTransactions = false,
    this.errorMessage,
  }) : _transactions = transactions,
       super._();

  @override
  @JsonKey()
  final WalletStatus status;
  @override
  final Wallet? wallet;
  final List<Transaction> _transactions;
  @override
  @JsonKey()
  List<Transaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasMoreTransactions;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'WalletState(status: $status, wallet: $wallet, transactions: $transactions, isLoadingMore: $isLoadingMore, hasMoreTransactions: $hasMoreTransactions, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMoreTransactions, hasMoreTransactions) ||
                other.hasMoreTransactions == hasMoreTransactions) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    wallet,
    const DeepCollectionEquality().hash(_transactions),
    isLoadingMore,
    hasMoreTransactions,
    errorMessage,
  );

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      __$$WalletStateImplCopyWithImpl<_$WalletStateImpl>(this, _$identity);
}

abstract class _WalletState extends WalletState {
  const factory _WalletState({
    final WalletStatus status,
    final Wallet? wallet,
    final List<Transaction> transactions,
    final bool isLoadingMore,
    final bool hasMoreTransactions,
    final String? errorMessage,
  }) = _$WalletStateImpl;
  const _WalletState._() : super._();

  @override
  WalletStatus get status;
  @override
  Wallet? get wallet;
  @override
  List<Transaction> get transactions;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMoreTransactions;
  @override
  String? get errorMessage;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
