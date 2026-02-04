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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWallet,
    TResult? Function(String walletId)? watchWallet,
    TResult? Function(String walletId, int? limit)? loadTransactions,
    TResult? Function()? loadMoreTransactions,
    TResult? Function(Wallet wallet)? walletUpdated,
    TResult? Function(List<Transaction> transactions)? transactionsUpdated,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWallet,
    TResult Function(String walletId)? watchWallet,
    TResult Function(String walletId, int? limit)? loadTransactions,
    TResult Function()? loadMoreTransactions,
    TResult Function(Wallet wallet)? walletUpdated,
    TResult Function(List<Transaction> transactions)? transactionsUpdated,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadWallet value)? loadWallet,
    TResult? Function(_WatchWallet value)? watchWallet,
    TResult? Function(_LoadTransactions value)? loadTransactions,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult? Function(_WalletUpdated value)? walletUpdated,
    TResult? Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadWallet value)? loadWallet,
    TResult Function(_WatchWallet value)? watchWallet,
    TResult Function(_LoadTransactions value)? loadTransactions,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    TResult Function(_WalletUpdated value)? walletUpdated,
    TResult Function(_TransactionsUpdated value)? transactionsUpdated,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
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
abstract class _$$WatchLedgerAccountImplCopyWith<$Res> {
  factory _$$WatchLedgerAccountImplCopyWith(
    _$WatchLedgerAccountImpl value,
    $Res Function(_$WatchLedgerAccountImpl) then,
  ) = __$$WatchLedgerAccountImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchLedgerAccountImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$WatchLedgerAccountImpl>
    implements _$$WatchLedgerAccountImplCopyWith<$Res> {
  __$$WatchLedgerAccountImplCopyWithImpl(
    _$WatchLedgerAccountImpl _value,
    $Res Function(_$WatchLedgerAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchLedgerAccountImpl implements _WatchLedgerAccount {
  const _$WatchLedgerAccountImpl();

  @override
  String toString() {
    return 'WalletEvent.watchLedgerAccount()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WatchLedgerAccountImpl);
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
  }) {
    return watchLedgerAccount();
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
  }) {
    return watchLedgerAccount?.call();
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    required TResult orElse(),
  }) {
    if (watchLedgerAccount != null) {
      return watchLedgerAccount();
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
  }) {
    return watchLedgerAccount(this);
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
  }) {
    return watchLedgerAccount?.call(this);
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    required TResult orElse(),
  }) {
    if (watchLedgerAccount != null) {
      return watchLedgerAccount(this);
    }
    return orElse();
  }
}

abstract class _WatchLedgerAccount implements WalletEvent {
  const factory _WatchLedgerAccount() = _$WatchLedgerAccountImpl;
}

/// @nodoc
abstract class _$$LedgerAccountUpdatedImplCopyWith<$Res> {
  factory _$$LedgerAccountUpdatedImplCopyWith(
    _$LedgerAccountUpdatedImpl value,
    $Res Function(_$LedgerAccountUpdatedImpl) then,
  ) = __$$LedgerAccountUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LedgerAccount ledgerAccount});

  $LedgerAccountCopyWith<$Res> get ledgerAccount;
}

/// @nodoc
class __$$LedgerAccountUpdatedImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$LedgerAccountUpdatedImpl>
    implements _$$LedgerAccountUpdatedImplCopyWith<$Res> {
  __$$LedgerAccountUpdatedImplCopyWithImpl(
    _$LedgerAccountUpdatedImpl _value,
    $Res Function(_$LedgerAccountUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ledgerAccount = null}) {
    return _then(
      _$LedgerAccountUpdatedImpl(
        null == ledgerAccount
            ? _value.ledgerAccount
            : ledgerAccount // ignore: cast_nullable_to_non_nullable
                  as LedgerAccount,
      ),
    );
  }

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LedgerAccountCopyWith<$Res> get ledgerAccount {
    return $LedgerAccountCopyWith<$Res>(_value.ledgerAccount, (value) {
      return _then(_value.copyWith(ledgerAccount: value));
    });
  }
}

/// @nodoc

class _$LedgerAccountUpdatedImpl implements _LedgerAccountUpdated {
  const _$LedgerAccountUpdatedImpl(this.ledgerAccount);

  @override
  final LedgerAccount ledgerAccount;

  @override
  String toString() {
    return 'WalletEvent.ledgerAccountUpdated(ledgerAccount: $ledgerAccount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerAccountUpdatedImpl &&
            (identical(other.ledgerAccount, ledgerAccount) ||
                other.ledgerAccount == ledgerAccount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ledgerAccount);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerAccountUpdatedImplCopyWith<_$LedgerAccountUpdatedImpl>
  get copyWith =>
      __$$LedgerAccountUpdatedImplCopyWithImpl<_$LedgerAccountUpdatedImpl>(
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
  }) {
    return ledgerAccountUpdated(ledgerAccount);
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
  }) {
    return ledgerAccountUpdated?.call(ledgerAccount);
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    required TResult orElse(),
  }) {
    if (ledgerAccountUpdated != null) {
      return ledgerAccountUpdated(ledgerAccount);
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
  }) {
    return ledgerAccountUpdated(this);
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
  }) {
    return ledgerAccountUpdated?.call(this);
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    required TResult orElse(),
  }) {
    if (ledgerAccountUpdated != null) {
      return ledgerAccountUpdated(this);
    }
    return orElse();
  }
}

abstract class _LedgerAccountUpdated implements WalletEvent {
  const factory _LedgerAccountUpdated(final LedgerAccount ledgerAccount) =
      _$LedgerAccountUpdatedImpl;

  LedgerAccount get ledgerAccount;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerAccountUpdatedImplCopyWith<_$LedgerAccountUpdatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadLedgerJournalsImplCopyWith<$Res> {
  factory _$$LoadLedgerJournalsImplCopyWith(
    _$LoadLedgerJournalsImpl value,
    $Res Function(_$LoadLedgerJournalsImpl) then,
  ) = __$$LoadLedgerJournalsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? limit});
}

/// @nodoc
class __$$LoadLedgerJournalsImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$LoadLedgerJournalsImpl>
    implements _$$LoadLedgerJournalsImplCopyWith<$Res> {
  __$$LoadLedgerJournalsImplCopyWithImpl(
    _$LoadLedgerJournalsImpl _value,
    $Res Function(_$LoadLedgerJournalsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? limit = freezed}) {
    return _then(
      _$LoadLedgerJournalsImpl(
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$LoadLedgerJournalsImpl implements _LoadLedgerJournals {
  const _$LoadLedgerJournalsImpl({this.limit});

  @override
  final int? limit;

  @override
  String toString() {
    return 'WalletEvent.loadLedgerJournals(limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadLedgerJournalsImpl &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, limit);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadLedgerJournalsImplCopyWith<_$LoadLedgerJournalsImpl> get copyWith =>
      __$$LoadLedgerJournalsImplCopyWithImpl<_$LoadLedgerJournalsImpl>(
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
  }) {
    return loadLedgerJournals(limit);
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
  }) {
    return loadLedgerJournals?.call(limit);
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    required TResult orElse(),
  }) {
    if (loadLedgerJournals != null) {
      return loadLedgerJournals(limit);
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
  }) {
    return loadLedgerJournals(this);
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
  }) {
    return loadLedgerJournals?.call(this);
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    required TResult orElse(),
  }) {
    if (loadLedgerJournals != null) {
      return loadLedgerJournals(this);
    }
    return orElse();
  }
}

abstract class _LoadLedgerJournals implements WalletEvent {
  const factory _LoadLedgerJournals({final int? limit}) =
      _$LoadLedgerJournalsImpl;

  int? get limit;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadLedgerJournalsImplCopyWith<_$LoadLedgerJournalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreLedgerJournalsImplCopyWith<$Res> {
  factory _$$LoadMoreLedgerJournalsImplCopyWith(
    _$LoadMoreLedgerJournalsImpl value,
    $Res Function(_$LoadMoreLedgerJournalsImpl) then,
  ) = __$$LoadMoreLedgerJournalsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreLedgerJournalsImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$LoadMoreLedgerJournalsImpl>
    implements _$$LoadMoreLedgerJournalsImplCopyWith<$Res> {
  __$$LoadMoreLedgerJournalsImplCopyWithImpl(
    _$LoadMoreLedgerJournalsImpl _value,
    $Res Function(_$LoadMoreLedgerJournalsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreLedgerJournalsImpl implements _LoadMoreLedgerJournals {
  const _$LoadMoreLedgerJournalsImpl();

  @override
  String toString() {
    return 'WalletEvent.loadMoreLedgerJournals()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMoreLedgerJournalsImpl);
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
  }) {
    return loadMoreLedgerJournals();
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
  }) {
    return loadMoreLedgerJournals?.call();
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    required TResult orElse(),
  }) {
    if (loadMoreLedgerJournals != null) {
      return loadMoreLedgerJournals();
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
  }) {
    return loadMoreLedgerJournals(this);
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
  }) {
    return loadMoreLedgerJournals?.call(this);
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    required TResult orElse(),
  }) {
    if (loadMoreLedgerJournals != null) {
      return loadMoreLedgerJournals(this);
    }
    return orElse();
  }
}

abstract class _LoadMoreLedgerJournals implements WalletEvent {
  const factory _LoadMoreLedgerJournals() = _$LoadMoreLedgerJournalsImpl;
}

/// @nodoc
abstract class _$$WatchLedgerJournalsImplCopyWith<$Res> {
  factory _$$WatchLedgerJournalsImplCopyWith(
    _$WatchLedgerJournalsImpl value,
    $Res Function(_$WatchLedgerJournalsImpl) then,
  ) = __$$WatchLedgerJournalsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? limit});
}

/// @nodoc
class __$$WatchLedgerJournalsImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$WatchLedgerJournalsImpl>
    implements _$$WatchLedgerJournalsImplCopyWith<$Res> {
  __$$WatchLedgerJournalsImplCopyWithImpl(
    _$WatchLedgerJournalsImpl _value,
    $Res Function(_$WatchLedgerJournalsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? limit = freezed}) {
    return _then(
      _$WatchLedgerJournalsImpl(
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$WatchLedgerJournalsImpl implements _WatchLedgerJournals {
  const _$WatchLedgerJournalsImpl({this.limit});

  @override
  final int? limit;

  @override
  String toString() {
    return 'WalletEvent.watchLedgerJournals(limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchLedgerJournalsImpl &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, limit);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchLedgerJournalsImplCopyWith<_$WatchLedgerJournalsImpl> get copyWith =>
      __$$WatchLedgerJournalsImplCopyWithImpl<_$WatchLedgerJournalsImpl>(
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
  }) {
    return watchLedgerJournals(limit);
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
  }) {
    return watchLedgerJournals?.call(limit);
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    required TResult orElse(),
  }) {
    if (watchLedgerJournals != null) {
      return watchLedgerJournals(limit);
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
  }) {
    return watchLedgerJournals(this);
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
  }) {
    return watchLedgerJournals?.call(this);
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    required TResult orElse(),
  }) {
    if (watchLedgerJournals != null) {
      return watchLedgerJournals(this);
    }
    return orElse();
  }
}

abstract class _WatchLedgerJournals implements WalletEvent {
  const factory _WatchLedgerJournals({final int? limit}) =
      _$WatchLedgerJournalsImpl;

  int? get limit;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchLedgerJournalsImplCopyWith<_$WatchLedgerJournalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LedgerJournalsUpdatedImplCopyWith<$Res> {
  factory _$$LedgerJournalsUpdatedImplCopyWith(
    _$LedgerJournalsUpdatedImpl value,
    $Res Function(_$LedgerJournalsUpdatedImpl) then,
  ) = __$$LedgerJournalsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<LedgerJournal> journals});
}

/// @nodoc
class __$$LedgerJournalsUpdatedImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$LedgerJournalsUpdatedImpl>
    implements _$$LedgerJournalsUpdatedImplCopyWith<$Res> {
  __$$LedgerJournalsUpdatedImplCopyWithImpl(
    _$LedgerJournalsUpdatedImpl _value,
    $Res Function(_$LedgerJournalsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? journals = null}) {
    return _then(
      _$LedgerJournalsUpdatedImpl(
        null == journals
            ? _value._journals
            : journals // ignore: cast_nullable_to_non_nullable
                  as List<LedgerJournal>,
      ),
    );
  }
}

/// @nodoc

class _$LedgerJournalsUpdatedImpl implements _LedgerJournalsUpdated {
  const _$LedgerJournalsUpdatedImpl(final List<LedgerJournal> journals)
    : _journals = journals;

  final List<LedgerJournal> _journals;
  @override
  List<LedgerJournal> get journals {
    if (_journals is EqualUnmodifiableListView) return _journals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_journals);
  }

  @override
  String toString() {
    return 'WalletEvent.ledgerJournalsUpdated(journals: $journals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerJournalsUpdatedImpl &&
            const DeepCollectionEquality().equals(other._journals, _journals));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_journals));

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerJournalsUpdatedImplCopyWith<_$LedgerJournalsUpdatedImpl>
  get copyWith =>
      __$$LedgerJournalsUpdatedImplCopyWithImpl<_$LedgerJournalsUpdatedImpl>(
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
  }) {
    return ledgerJournalsUpdated(journals);
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
  }) {
    return ledgerJournalsUpdated?.call(journals);
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    required TResult orElse(),
  }) {
    if (ledgerJournalsUpdated != null) {
      return ledgerJournalsUpdated(journals);
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
  }) {
    return ledgerJournalsUpdated(this);
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
  }) {
    return ledgerJournalsUpdated?.call(this);
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    required TResult orElse(),
  }) {
    if (ledgerJournalsUpdated != null) {
      return ledgerJournalsUpdated(this);
    }
    return orElse();
  }
}

abstract class _LedgerJournalsUpdated implements WalletEvent {
  const factory _LedgerJournalsUpdated(final List<LedgerJournal> journals) =
      _$LedgerJournalsUpdatedImpl;

  List<LedgerJournal> get journals;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerJournalsUpdatedImplCopyWith<_$LedgerJournalsUpdatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshLedgerImplCopyWith<$Res> {
  factory _$$RefreshLedgerImplCopyWith(
    _$RefreshLedgerImpl value,
    $Res Function(_$RefreshLedgerImpl) then,
  ) = __$$RefreshLedgerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshLedgerImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$RefreshLedgerImpl>
    implements _$$RefreshLedgerImplCopyWith<$Res> {
  __$$RefreshLedgerImplCopyWithImpl(
    _$RefreshLedgerImpl _value,
    $Res Function(_$RefreshLedgerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshLedgerImpl implements _RefreshLedger {
  const _$RefreshLedgerImpl();

  @override
  String toString() {
    return 'WalletEvent.refreshLedger()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshLedgerImpl);
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
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
  }) {
    return refreshLedger();
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
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
  }) {
    return refreshLedger?.call();
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
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    required TResult orElse(),
  }) {
    if (refreshLedger != null) {
      return refreshLedger();
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
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
  }) {
    return refreshLedger(this);
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
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
  }) {
    return refreshLedger?.call(this);
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
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    required TResult orElse(),
  }) {
    if (refreshLedger != null) {
      return refreshLedger(this);
    }
    return orElse();
  }
}

abstract class _RefreshLedger implements WalletEvent {
  const factory _RefreshLedger() = _$RefreshLedgerImpl;
}

/// @nodoc
mixin _$WalletState {
  WalletStatus get status => throw _privateConstructorUsedError;
  Wallet? get wallet => throw _privateConstructorUsedError;
  LedgerAccount? get ledgerAccount => throw _privateConstructorUsedError;
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  List<LedgerJournal> get ledgerJournals => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMoreTransactions => throw _privateConstructorUsedError;
  bool get hasMoreLedgerJournals => throw _privateConstructorUsedError;
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
    LedgerAccount? ledgerAccount,
    List<Transaction> transactions,
    List<LedgerJournal> ledgerJournals,
    bool isLoadingMore,
    bool hasMoreTransactions,
    bool hasMoreLedgerJournals,
    String? errorMessage,
  });

  $WalletCopyWith<$Res>? get wallet;
  $LedgerAccountCopyWith<$Res>? get ledgerAccount;
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
    Object? ledgerAccount = freezed,
    Object? transactions = null,
    Object? ledgerJournals = null,
    Object? isLoadingMore = null,
    Object? hasMoreTransactions = null,
    Object? hasMoreLedgerJournals = null,
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
            ledgerAccount: freezed == ledgerAccount
                ? _value.ledgerAccount
                : ledgerAccount // ignore: cast_nullable_to_non_nullable
                      as LedgerAccount?,
            transactions: null == transactions
                ? _value.transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                      as List<Transaction>,
            ledgerJournals: null == ledgerJournals
                ? _value.ledgerJournals
                : ledgerJournals // ignore: cast_nullable_to_non_nullable
                      as List<LedgerJournal>,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMoreTransactions: null == hasMoreTransactions
                ? _value.hasMoreTransactions
                : hasMoreTransactions // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMoreLedgerJournals: null == hasMoreLedgerJournals
                ? _value.hasMoreLedgerJournals
                : hasMoreLedgerJournals // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LedgerAccountCopyWith<$Res>? get ledgerAccount {
    if (_value.ledgerAccount == null) {
      return null;
    }

    return $LedgerAccountCopyWith<$Res>(_value.ledgerAccount!, (value) {
      return _then(_value.copyWith(ledgerAccount: value) as $Val);
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
    LedgerAccount? ledgerAccount,
    List<Transaction> transactions,
    List<LedgerJournal> ledgerJournals,
    bool isLoadingMore,
    bool hasMoreTransactions,
    bool hasMoreLedgerJournals,
    String? errorMessage,
  });

  @override
  $WalletCopyWith<$Res>? get wallet;
  @override
  $LedgerAccountCopyWith<$Res>? get ledgerAccount;
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
    Object? ledgerAccount = freezed,
    Object? transactions = null,
    Object? ledgerJournals = null,
    Object? isLoadingMore = null,
    Object? hasMoreTransactions = null,
    Object? hasMoreLedgerJournals = null,
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
        ledgerAccount: freezed == ledgerAccount
            ? _value.ledgerAccount
            : ledgerAccount // ignore: cast_nullable_to_non_nullable
                  as LedgerAccount?,
        transactions: null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<Transaction>,
        ledgerJournals: null == ledgerJournals
            ? _value._ledgerJournals
            : ledgerJournals // ignore: cast_nullable_to_non_nullable
                  as List<LedgerJournal>,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMoreTransactions: null == hasMoreTransactions
            ? _value.hasMoreTransactions
            : hasMoreTransactions // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMoreLedgerJournals: null == hasMoreLedgerJournals
            ? _value.hasMoreLedgerJournals
            : hasMoreLedgerJournals // ignore: cast_nullable_to_non_nullable
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
    this.ledgerAccount,
    final List<Transaction> transactions = const [],
    final List<LedgerJournal> ledgerJournals = const [],
    this.isLoadingMore = false,
    this.hasMoreTransactions = false,
    this.hasMoreLedgerJournals = false,
    this.errorMessage,
  }) : _transactions = transactions,
       _ledgerJournals = ledgerJournals,
       super._();

  @override
  @JsonKey()
  final WalletStatus status;
  @override
  final Wallet? wallet;
  @override
  final LedgerAccount? ledgerAccount;
  final List<Transaction> _transactions;
  @override
  @JsonKey()
  List<Transaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  final List<LedgerJournal> _ledgerJournals;
  @override
  @JsonKey()
  List<LedgerJournal> get ledgerJournals {
    if (_ledgerJournals is EqualUnmodifiableListView) return _ledgerJournals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ledgerJournals);
  }

  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasMoreTransactions;
  @override
  @JsonKey()
  final bool hasMoreLedgerJournals;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'WalletState(status: $status, wallet: $wallet, ledgerAccount: $ledgerAccount, transactions: $transactions, ledgerJournals: $ledgerJournals, isLoadingMore: $isLoadingMore, hasMoreTransactions: $hasMoreTransactions, hasMoreLedgerJournals: $hasMoreLedgerJournals, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            (identical(other.ledgerAccount, ledgerAccount) ||
                other.ledgerAccount == ledgerAccount) &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ) &&
            const DeepCollectionEquality().equals(
              other._ledgerJournals,
              _ledgerJournals,
            ) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMoreTransactions, hasMoreTransactions) ||
                other.hasMoreTransactions == hasMoreTransactions) &&
            (identical(other.hasMoreLedgerJournals, hasMoreLedgerJournals) ||
                other.hasMoreLedgerJournals == hasMoreLedgerJournals) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    wallet,
    ledgerAccount,
    const DeepCollectionEquality().hash(_transactions),
    const DeepCollectionEquality().hash(_ledgerJournals),
    isLoadingMore,
    hasMoreTransactions,
    hasMoreLedgerJournals,
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
    final LedgerAccount? ledgerAccount,
    final List<Transaction> transactions,
    final List<LedgerJournal> ledgerJournals,
    final bool isLoadingMore,
    final bool hasMoreTransactions,
    final bool hasMoreLedgerJournals,
    final String? errorMessage,
  }) = _$WalletStateImpl;
  const _WalletState._() : super._();

  @override
  WalletStatus get status;
  @override
  Wallet? get wallet;
  @override
  LedgerAccount? get ledgerAccount;
  @override
  List<Transaction> get transactions;
  @override
  List<LedgerJournal> get ledgerJournals;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMoreTransactions;
  @override
  bool get hasMoreLedgerJournals;
  @override
  String? get errorMessage;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
