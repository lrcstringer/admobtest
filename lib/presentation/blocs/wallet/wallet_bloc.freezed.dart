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
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
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
abstract class _$$LoadLedgerImplCopyWith<$Res> {
  factory _$$LoadLedgerImplCopyWith(
    _$LoadLedgerImpl value,
    $Res Function(_$LoadLedgerImpl) then,
  ) = __$$LoadLedgerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadLedgerImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$LoadLedgerImpl>
    implements _$$LoadLedgerImplCopyWith<$Res> {
  __$$LoadLedgerImplCopyWithImpl(
    _$LoadLedgerImpl _value,
    $Res Function(_$LoadLedgerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadLedgerImpl implements _LoadLedger {
  const _$LoadLedgerImpl();

  @override
  String toString() {
    return 'WalletEvent.loadLedger()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadLedgerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) {
    return loadLedger();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) {
    return loadLedger?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
    required TResult orElse(),
  }) {
    if (loadLedger != null) {
      return loadLedger();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) {
    return loadLedger(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) {
    return loadLedger?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
    required TResult orElse(),
  }) {
    if (loadLedger != null) {
      return loadLedger(this);
    }
    return orElse();
  }
}

abstract class _LoadLedger implements WalletEvent {
  const factory _LoadLedger() = _$LoadLedgerImpl;
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
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) {
    return watchLedgerAccount();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) {
    return watchLedgerAccount?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
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
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) {
    return watchLedgerAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) {
    return watchLedgerAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
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
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) {
    return ledgerAccountUpdated(ledgerAccount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) {
    return ledgerAccountUpdated?.call(ledgerAccount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
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
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) {
    return ledgerAccountUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) {
    return ledgerAccountUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
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
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) {
    return loadLedgerJournals(limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) {
    return loadLedgerJournals?.call(limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
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
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) {
    return loadLedgerJournals(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) {
    return loadLedgerJournals?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
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
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) {
    return loadMoreLedgerJournals();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) {
    return loadMoreLedgerJournals?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
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
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) {
    return loadMoreLedgerJournals(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) {
    return loadMoreLedgerJournals?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
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
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) {
    return watchLedgerJournals(limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) {
    return watchLedgerJournals?.call(limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
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
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) {
    return watchLedgerJournals(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) {
    return watchLedgerJournals?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
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
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) {
    return ledgerJournalsUpdated(journals);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) {
    return ledgerJournalsUpdated?.call(journals);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
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
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) {
    return ledgerJournalsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) {
    return ledgerJournalsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
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
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) {
    return refreshLedger();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) {
    return refreshLedger?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
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
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) {
    return refreshLedger(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) {
    return refreshLedger?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
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
abstract class _$$WatchEngagementStatsImplCopyWith<$Res> {
  factory _$$WatchEngagementStatsImplCopyWith(
    _$WatchEngagementStatsImpl value,
    $Res Function(_$WatchEngagementStatsImpl) then,
  ) = __$$WatchEngagementStatsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchEngagementStatsImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$WatchEngagementStatsImpl>
    implements _$$WatchEngagementStatsImplCopyWith<$Res> {
  __$$WatchEngagementStatsImplCopyWithImpl(
    _$WatchEngagementStatsImpl _value,
    $Res Function(_$WatchEngagementStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchEngagementStatsImpl implements _WatchEngagementStats {
  const _$WatchEngagementStatsImpl();

  @override
  String toString() {
    return 'WalletEvent.watchEngagementStats()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchEngagementStatsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) {
    return watchEngagementStats();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) {
    return watchEngagementStats?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
    required TResult orElse(),
  }) {
    if (watchEngagementStats != null) {
      return watchEngagementStats();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) {
    return watchEngagementStats(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) {
    return watchEngagementStats?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
    required TResult orElse(),
  }) {
    if (watchEngagementStats != null) {
      return watchEngagementStats(this);
    }
    return orElse();
  }
}

abstract class _WatchEngagementStats implements WalletEvent {
  const factory _WatchEngagementStats() = _$WatchEngagementStatsImpl;
}

/// @nodoc
abstract class _$$EngagementStatsUpdatedImplCopyWith<$Res> {
  factory _$$EngagementStatsUpdatedImplCopyWith(
    _$EngagementStatsUpdatedImpl value,
    $Res Function(_$EngagementStatsUpdatedImpl) then,
  ) = __$$EngagementStatsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserEngagementStats stats});

  $UserEngagementStatsCopyWith<$Res> get stats;
}

/// @nodoc
class __$$EngagementStatsUpdatedImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$EngagementStatsUpdatedImpl>
    implements _$$EngagementStatsUpdatedImplCopyWith<$Res> {
  __$$EngagementStatsUpdatedImplCopyWithImpl(
    _$EngagementStatsUpdatedImpl _value,
    $Res Function(_$EngagementStatsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? stats = null}) {
    return _then(
      _$EngagementStatsUpdatedImpl(
        null == stats
            ? _value.stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as UserEngagementStats,
      ),
    );
  }

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEngagementStatsCopyWith<$Res> get stats {
    return $UserEngagementStatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value));
    });
  }
}

/// @nodoc

class _$EngagementStatsUpdatedImpl implements _EngagementStatsUpdated {
  const _$EngagementStatsUpdatedImpl(this.stats);

  @override
  final UserEngagementStats stats;

  @override
  String toString() {
    return 'WalletEvent.engagementStatsUpdated(stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EngagementStatsUpdatedImpl &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stats);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EngagementStatsUpdatedImplCopyWith<_$EngagementStatsUpdatedImpl>
  get copyWith =>
      __$$EngagementStatsUpdatedImplCopyWithImpl<_$EngagementStatsUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadLedger,
    required TResult Function() watchLedgerAccount,
    required TResult Function(LedgerAccount ledgerAccount) ledgerAccountUpdated,
    required TResult Function(int? limit) loadLedgerJournals,
    required TResult Function() loadMoreLedgerJournals,
    required TResult Function(int? limit) watchLedgerJournals,
    required TResult Function(List<LedgerJournal> journals)
    ledgerJournalsUpdated,
    required TResult Function() refreshLedger,
    required TResult Function() watchEngagementStats,
    required TResult Function(UserEngagementStats stats) engagementStatsUpdated,
  }) {
    return engagementStatsUpdated(stats);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadLedger,
    TResult? Function()? watchLedgerAccount,
    TResult? Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult? Function(int? limit)? loadLedgerJournals,
    TResult? Function()? loadMoreLedgerJournals,
    TResult? Function(int? limit)? watchLedgerJournals,
    TResult? Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult? Function()? refreshLedger,
    TResult? Function()? watchEngagementStats,
    TResult? Function(UserEngagementStats stats)? engagementStatsUpdated,
  }) {
    return engagementStatsUpdated?.call(stats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadLedger,
    TResult Function()? watchLedgerAccount,
    TResult Function(LedgerAccount ledgerAccount)? ledgerAccountUpdated,
    TResult Function(int? limit)? loadLedgerJournals,
    TResult Function()? loadMoreLedgerJournals,
    TResult Function(int? limit)? watchLedgerJournals,
    TResult Function(List<LedgerJournal> journals)? ledgerJournalsUpdated,
    TResult Function()? refreshLedger,
    TResult Function()? watchEngagementStats,
    TResult Function(UserEngagementStats stats)? engagementStatsUpdated,
    required TResult orElse(),
  }) {
    if (engagementStatsUpdated != null) {
      return engagementStatsUpdated(stats);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLedger value) loadLedger,
    required TResult Function(_WatchLedgerAccount value) watchLedgerAccount,
    required TResult Function(_LedgerAccountUpdated value) ledgerAccountUpdated,
    required TResult Function(_LoadLedgerJournals value) loadLedgerJournals,
    required TResult Function(_LoadMoreLedgerJournals value)
    loadMoreLedgerJournals,
    required TResult Function(_WatchLedgerJournals value) watchLedgerJournals,
    required TResult Function(_LedgerJournalsUpdated value)
    ledgerJournalsUpdated,
    required TResult Function(_RefreshLedger value) refreshLedger,
    required TResult Function(_WatchEngagementStats value) watchEngagementStats,
    required TResult Function(_EngagementStatsUpdated value)
    engagementStatsUpdated,
  }) {
    return engagementStatsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLedger value)? loadLedger,
    TResult? Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult? Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult? Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult? Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult? Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult? Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult? Function(_RefreshLedger value)? refreshLedger,
    TResult? Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult? Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
  }) {
    return engagementStatsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLedger value)? loadLedger,
    TResult Function(_WatchLedgerAccount value)? watchLedgerAccount,
    TResult Function(_LedgerAccountUpdated value)? ledgerAccountUpdated,
    TResult Function(_LoadLedgerJournals value)? loadLedgerJournals,
    TResult Function(_LoadMoreLedgerJournals value)? loadMoreLedgerJournals,
    TResult Function(_WatchLedgerJournals value)? watchLedgerJournals,
    TResult Function(_LedgerJournalsUpdated value)? ledgerJournalsUpdated,
    TResult Function(_RefreshLedger value)? refreshLedger,
    TResult Function(_WatchEngagementStats value)? watchEngagementStats,
    TResult Function(_EngagementStatsUpdated value)? engagementStatsUpdated,
    required TResult orElse(),
  }) {
    if (engagementStatsUpdated != null) {
      return engagementStatsUpdated(this);
    }
    return orElse();
  }
}

abstract class _EngagementStatsUpdated implements WalletEvent {
  const factory _EngagementStatsUpdated(final UserEngagementStats stats) =
      _$EngagementStatsUpdatedImpl;

  UserEngagementStats get stats;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EngagementStatsUpdatedImplCopyWith<_$EngagementStatsUpdatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletState {
  WalletStatus get status => throw _privateConstructorUsedError;
  LedgerAccount? get ledgerAccount => throw _privateConstructorUsedError;
  UserEngagementStats? get engagementStats =>
      throw _privateConstructorUsedError;
  List<LedgerJournal> get ledgerJournals => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
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
    LedgerAccount? ledgerAccount,
    UserEngagementStats? engagementStats,
    List<LedgerJournal> ledgerJournals,
    bool isLoadingMore,
    bool hasMoreLedgerJournals,
    String? errorMessage,
  });

  $LedgerAccountCopyWith<$Res>? get ledgerAccount;
  $UserEngagementStatsCopyWith<$Res>? get engagementStats;
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
    Object? ledgerAccount = freezed,
    Object? engagementStats = freezed,
    Object? ledgerJournals = null,
    Object? isLoadingMore = null,
    Object? hasMoreLedgerJournals = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as WalletStatus,
            ledgerAccount: freezed == ledgerAccount
                ? _value.ledgerAccount
                : ledgerAccount // ignore: cast_nullable_to_non_nullable
                      as LedgerAccount?,
            engagementStats: freezed == engagementStats
                ? _value.engagementStats
                : engagementStats // ignore: cast_nullable_to_non_nullable
                      as UserEngagementStats?,
            ledgerJournals: null == ledgerJournals
                ? _value.ledgerJournals
                : ledgerJournals // ignore: cast_nullable_to_non_nullable
                      as List<LedgerJournal>,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
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
  $LedgerAccountCopyWith<$Res>? get ledgerAccount {
    if (_value.ledgerAccount == null) {
      return null;
    }

    return $LedgerAccountCopyWith<$Res>(_value.ledgerAccount!, (value) {
      return _then(_value.copyWith(ledgerAccount: value) as $Val);
    });
  }

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEngagementStatsCopyWith<$Res>? get engagementStats {
    if (_value.engagementStats == null) {
      return null;
    }

    return $UserEngagementStatsCopyWith<$Res>(_value.engagementStats!, (value) {
      return _then(_value.copyWith(engagementStats: value) as $Val);
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
    LedgerAccount? ledgerAccount,
    UserEngagementStats? engagementStats,
    List<LedgerJournal> ledgerJournals,
    bool isLoadingMore,
    bool hasMoreLedgerJournals,
    String? errorMessage,
  });

  @override
  $LedgerAccountCopyWith<$Res>? get ledgerAccount;
  @override
  $UserEngagementStatsCopyWith<$Res>? get engagementStats;
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
    Object? ledgerAccount = freezed,
    Object? engagementStats = freezed,
    Object? ledgerJournals = null,
    Object? isLoadingMore = null,
    Object? hasMoreLedgerJournals = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$WalletStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as WalletStatus,
        ledgerAccount: freezed == ledgerAccount
            ? _value.ledgerAccount
            : ledgerAccount // ignore: cast_nullable_to_non_nullable
                  as LedgerAccount?,
        engagementStats: freezed == engagementStats
            ? _value.engagementStats
            : engagementStats // ignore: cast_nullable_to_non_nullable
                  as UserEngagementStats?,
        ledgerJournals: null == ledgerJournals
            ? _value._ledgerJournals
            : ledgerJournals // ignore: cast_nullable_to_non_nullable
                  as List<LedgerJournal>,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
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
    this.ledgerAccount,
    this.engagementStats,
    final List<LedgerJournal> ledgerJournals = const [],
    this.isLoadingMore = false,
    this.hasMoreLedgerJournals = false,
    this.errorMessage,
  }) : _ledgerJournals = ledgerJournals,
       super._();

  @override
  @JsonKey()
  final WalletStatus status;
  @override
  final LedgerAccount? ledgerAccount;
  @override
  final UserEngagementStats? engagementStats;
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
  final bool hasMoreLedgerJournals;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'WalletState(status: $status, ledgerAccount: $ledgerAccount, engagementStats: $engagementStats, ledgerJournals: $ledgerJournals, isLoadingMore: $isLoadingMore, hasMoreLedgerJournals: $hasMoreLedgerJournals, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.ledgerAccount, ledgerAccount) ||
                other.ledgerAccount == ledgerAccount) &&
            (identical(other.engagementStats, engagementStats) ||
                other.engagementStats == engagementStats) &&
            const DeepCollectionEquality().equals(
              other._ledgerJournals,
              _ledgerJournals,
            ) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMoreLedgerJournals, hasMoreLedgerJournals) ||
                other.hasMoreLedgerJournals == hasMoreLedgerJournals) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    ledgerAccount,
    engagementStats,
    const DeepCollectionEquality().hash(_ledgerJournals),
    isLoadingMore,
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
    final LedgerAccount? ledgerAccount,
    final UserEngagementStats? engagementStats,
    final List<LedgerJournal> ledgerJournals,
    final bool isLoadingMore,
    final bool hasMoreLedgerJournals,
    final String? errorMessage,
  }) = _$WalletStateImpl;
  const _WalletState._() : super._();

  @override
  WalletStatus get status;
  @override
  LedgerAccount? get ledgerAccount;
  @override
  UserEngagementStats? get engagementStats;
  @override
  List<LedgerJournal> get ledgerJournals;
  @override
  bool get isLoadingMore;
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
