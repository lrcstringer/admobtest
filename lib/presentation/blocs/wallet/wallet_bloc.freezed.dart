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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
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
abstract class _$$LoadSubAccountsImplCopyWith<$Res> {
  factory _$$LoadSubAccountsImplCopyWith(
    _$LoadSubAccountsImpl value,
    $Res Function(_$LoadSubAccountsImpl) then,
  ) = __$$LoadSubAccountsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadSubAccountsImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$LoadSubAccountsImpl>
    implements _$$LoadSubAccountsImplCopyWith<$Res> {
  __$$LoadSubAccountsImplCopyWithImpl(
    _$LoadSubAccountsImpl _value,
    $Res Function(_$LoadSubAccountsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadSubAccountsImpl implements _LoadSubAccounts {
  const _$LoadSubAccountsImpl();

  @override
  String toString() {
    return 'WalletEvent.loadSubAccounts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadSubAccountsImpl);
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
  }) {
    return loadSubAccounts();
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
  }) {
    return loadSubAccounts?.call();
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (loadSubAccounts != null) {
      return loadSubAccounts();
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return loadSubAccounts(this);
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return loadSubAccounts?.call(this);
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (loadSubAccounts != null) {
      return loadSubAccounts(this);
    }
    return orElse();
  }
}

abstract class _LoadSubAccounts implements WalletEvent {
  const factory _LoadSubAccounts() = _$LoadSubAccountsImpl;
}

/// @nodoc
abstract class _$$WatchSubAccountsImplCopyWith<$Res> {
  factory _$$WatchSubAccountsImplCopyWith(
    _$WatchSubAccountsImpl value,
    $Res Function(_$WatchSubAccountsImpl) then,
  ) = __$$WatchSubAccountsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WatchSubAccountsImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$WatchSubAccountsImpl>
    implements _$$WatchSubAccountsImplCopyWith<$Res> {
  __$$WatchSubAccountsImplCopyWithImpl(
    _$WatchSubAccountsImpl _value,
    $Res Function(_$WatchSubAccountsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$WatchSubAccountsImpl implements _WatchSubAccounts {
  const _$WatchSubAccountsImpl();

  @override
  String toString() {
    return 'WalletEvent.watchSubAccounts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WatchSubAccountsImpl);
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
  }) {
    return watchSubAccounts();
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
  }) {
    return watchSubAccounts?.call();
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (watchSubAccounts != null) {
      return watchSubAccounts();
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return watchSubAccounts(this);
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return watchSubAccounts?.call(this);
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (watchSubAccounts != null) {
      return watchSubAccounts(this);
    }
    return orElse();
  }
}

abstract class _WatchSubAccounts implements WalletEvent {
  const factory _WatchSubAccounts() = _$WatchSubAccountsImpl;
}

/// @nodoc
abstract class _$$SubAccountsUpdatedImplCopyWith<$Res> {
  factory _$$SubAccountsUpdatedImplCopyWith(
    _$SubAccountsUpdatedImpl value,
    $Res Function(_$SubAccountsUpdatedImpl) then,
  ) = __$$SubAccountsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<SubAccount> subAccounts});
}

/// @nodoc
class __$$SubAccountsUpdatedImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$SubAccountsUpdatedImpl>
    implements _$$SubAccountsUpdatedImplCopyWith<$Res> {
  __$$SubAccountsUpdatedImplCopyWithImpl(
    _$SubAccountsUpdatedImpl _value,
    $Res Function(_$SubAccountsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? subAccounts = null}) {
    return _then(
      _$SubAccountsUpdatedImpl(
        null == subAccounts
            ? _value._subAccounts
            : subAccounts // ignore: cast_nullable_to_non_nullable
                  as List<SubAccount>,
      ),
    );
  }
}

/// @nodoc

class _$SubAccountsUpdatedImpl implements _SubAccountsUpdated {
  const _$SubAccountsUpdatedImpl(final List<SubAccount> subAccounts)
    : _subAccounts = subAccounts;

  final List<SubAccount> _subAccounts;
  @override
  List<SubAccount> get subAccounts {
    if (_subAccounts is EqualUnmodifiableListView) return _subAccounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subAccounts);
  }

  @override
  String toString() {
    return 'WalletEvent.subAccountsUpdated(subAccounts: $subAccounts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubAccountsUpdatedImpl &&
            const DeepCollectionEquality().equals(
              other._subAccounts,
              _subAccounts,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_subAccounts),
  );

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubAccountsUpdatedImplCopyWith<_$SubAccountsUpdatedImpl> get copyWith =>
      __$$SubAccountsUpdatedImplCopyWithImpl<_$SubAccountsUpdatedImpl>(
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
  }) {
    return subAccountsUpdated(subAccounts);
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
  }) {
    return subAccountsUpdated?.call(subAccounts);
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (subAccountsUpdated != null) {
      return subAccountsUpdated(subAccounts);
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return subAccountsUpdated(this);
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return subAccountsUpdated?.call(this);
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (subAccountsUpdated != null) {
      return subAccountsUpdated(this);
    }
    return orElse();
  }
}

abstract class _SubAccountsUpdated implements WalletEvent {
  const factory _SubAccountsUpdated(final List<SubAccount> subAccounts) =
      _$SubAccountsUpdatedImpl;

  List<SubAccount> get subAccounts;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubAccountsUpdatedImplCopyWith<_$SubAccountsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectSubAccountImplCopyWith<$Res> {
  factory _$$SelectSubAccountImplCopyWith(
    _$SelectSubAccountImpl value,
    $Res Function(_$SelectSubAccountImpl) then,
  ) = __$$SelectSubAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String subAccountId});
}

/// @nodoc
class __$$SelectSubAccountImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$SelectSubAccountImpl>
    implements _$$SelectSubAccountImplCopyWith<$Res> {
  __$$SelectSubAccountImplCopyWithImpl(
    _$SelectSubAccountImpl _value,
    $Res Function(_$SelectSubAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? subAccountId = null}) {
    return _then(
      _$SelectSubAccountImpl(
        null == subAccountId
            ? _value.subAccountId
            : subAccountId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SelectSubAccountImpl implements _SelectSubAccount {
  const _$SelectSubAccountImpl(this.subAccountId);

  @override
  final String subAccountId;

  @override
  String toString() {
    return 'WalletEvent.selectSubAccount(subAccountId: $subAccountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectSubAccountImpl &&
            (identical(other.subAccountId, subAccountId) ||
                other.subAccountId == subAccountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, subAccountId);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectSubAccountImplCopyWith<_$SelectSubAccountImpl> get copyWith =>
      __$$SelectSubAccountImplCopyWithImpl<_$SelectSubAccountImpl>(
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
  }) {
    return selectSubAccount(subAccountId);
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
  }) {
    return selectSubAccount?.call(subAccountId);
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (selectSubAccount != null) {
      return selectSubAccount(subAccountId);
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return selectSubAccount(this);
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return selectSubAccount?.call(this);
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (selectSubAccount != null) {
      return selectSubAccount(this);
    }
    return orElse();
  }
}

abstract class _SelectSubAccount implements WalletEvent {
  const factory _SelectSubAccount(final String subAccountId) =
      _$SelectSubAccountImpl;

  String get subAccountId;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectSubAccountImplCopyWith<_$SelectSubAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateUserWalletImplCopyWith<$Res> {
  factory _$$CreateUserWalletImplCopyWith(
    _$CreateUserWalletImpl value,
    $Res Function(_$CreateUserWalletImpl) then,
  ) = __$$CreateUserWalletImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$CreateUserWalletImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$CreateUserWalletImpl>
    implements _$$CreateUserWalletImplCopyWith<$Res> {
  __$$CreateUserWalletImplCopyWithImpl(
    _$CreateUserWalletImpl _value,
    $Res Function(_$CreateUserWalletImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$CreateUserWalletImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CreateUserWalletImpl implements _CreateUserWallet {
  const _$CreateUserWalletImpl({required this.name});

  @override
  final String name;

  @override
  String toString() {
    return 'WalletEvent.createUserWallet(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateUserWalletImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateUserWalletImplCopyWith<_$CreateUserWalletImpl> get copyWith =>
      __$$CreateUserWalletImplCopyWithImpl<_$CreateUserWalletImpl>(
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
  }) {
    return createUserWallet(name);
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
  }) {
    return createUserWallet?.call(name);
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (createUserWallet != null) {
      return createUserWallet(name);
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return createUserWallet(this);
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return createUserWallet?.call(this);
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (createUserWallet != null) {
      return createUserWallet(this);
    }
    return orElse();
  }
}

abstract class _CreateUserWallet implements WalletEvent {
  const factory _CreateUserWallet({required final String name}) =
      _$CreateUserWalletImpl;

  String get name;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateUserWalletImplCopyWith<_$CreateUserWalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferBetweenWalletsImplCopyWith<$Res> {
  factory _$$TransferBetweenWalletsImplCopyWith(
    _$TransferBetweenWalletsImpl value,
    $Res Function(_$TransferBetweenWalletsImpl) then,
  ) = __$$TransferBetweenWalletsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String fromSubAccountId, String toSubAccountId, int amount});
}

/// @nodoc
class __$$TransferBetweenWalletsImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$TransferBetweenWalletsImpl>
    implements _$$TransferBetweenWalletsImplCopyWith<$Res> {
  __$$TransferBetweenWalletsImplCopyWithImpl(
    _$TransferBetweenWalletsImpl _value,
    $Res Function(_$TransferBetweenWalletsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromSubAccountId = null,
    Object? toSubAccountId = null,
    Object? amount = null,
  }) {
    return _then(
      _$TransferBetweenWalletsImpl(
        fromSubAccountId: null == fromSubAccountId
            ? _value.fromSubAccountId
            : fromSubAccountId // ignore: cast_nullable_to_non_nullable
                  as String,
        toSubAccountId: null == toSubAccountId
            ? _value.toSubAccountId
            : toSubAccountId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$TransferBetweenWalletsImpl implements _TransferBetweenWallets {
  const _$TransferBetweenWalletsImpl({
    required this.fromSubAccountId,
    required this.toSubAccountId,
    required this.amount,
  });

  @override
  final String fromSubAccountId;
  @override
  final String toSubAccountId;
  @override
  final int amount;

  @override
  String toString() {
    return 'WalletEvent.transferBetweenWallets(fromSubAccountId: $fromSubAccountId, toSubAccountId: $toSubAccountId, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferBetweenWalletsImpl &&
            (identical(other.fromSubAccountId, fromSubAccountId) ||
                other.fromSubAccountId == fromSubAccountId) &&
            (identical(other.toSubAccountId, toSubAccountId) ||
                other.toSubAccountId == toSubAccountId) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fromSubAccountId, toSubAccountId, amount);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferBetweenWalletsImplCopyWith<_$TransferBetweenWalletsImpl>
  get copyWith =>
      __$$TransferBetweenWalletsImplCopyWithImpl<_$TransferBetweenWalletsImpl>(
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
  }) {
    return transferBetweenWallets(fromSubAccountId, toSubAccountId, amount);
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
  }) {
    return transferBetweenWallets?.call(
      fromSubAccountId,
      toSubAccountId,
      amount,
    );
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (transferBetweenWallets != null) {
      return transferBetweenWallets(fromSubAccountId, toSubAccountId, amount);
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return transferBetweenWallets(this);
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return transferBetweenWallets?.call(this);
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (transferBetweenWallets != null) {
      return transferBetweenWallets(this);
    }
    return orElse();
  }
}

abstract class _TransferBetweenWallets implements WalletEvent {
  const factory _TransferBetweenWallets({
    required final String fromSubAccountId,
    required final String toSubAccountId,
    required final int amount,
  }) = _$TransferBetweenWalletsImpl;

  String get fromSubAccountId;
  String get toSubAccountId;
  int get amount;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferBetweenWalletsImplCopyWith<_$TransferBetweenWalletsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendP2PTransferImplCopyWith<$Res> {
  factory _$$SendP2PTransferImplCopyWith(
    _$SendP2PTransferImpl value,
    $Res Function(_$SendP2PTransferImpl) then,
  ) = __$$SendP2PTransferImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String recipientUserId,
    int amount,
    String subAccountId,
    String? note,
  });
}

/// @nodoc
class __$$SendP2PTransferImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$SendP2PTransferImpl>
    implements _$$SendP2PTransferImplCopyWith<$Res> {
  __$$SendP2PTransferImplCopyWithImpl(
    _$SendP2PTransferImpl _value,
    $Res Function(_$SendP2PTransferImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipientUserId = null,
    Object? amount = null,
    Object? subAccountId = null,
    Object? note = freezed,
  }) {
    return _then(
      _$SendP2PTransferImpl(
        recipientUserId: null == recipientUserId
            ? _value.recipientUserId
            : recipientUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        subAccountId: null == subAccountId
            ? _value.subAccountId
            : subAccountId // ignore: cast_nullable_to_non_nullable
                  as String,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SendP2PTransferImpl implements _SendP2PTransfer {
  const _$SendP2PTransferImpl({
    required this.recipientUserId,
    required this.amount,
    required this.subAccountId,
    this.note,
  });

  @override
  final String recipientUserId;
  @override
  final int amount;
  @override
  final String subAccountId;
  @override
  final String? note;

  @override
  String toString() {
    return 'WalletEvent.sendP2PTransfer(recipientUserId: $recipientUserId, amount: $amount, subAccountId: $subAccountId, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendP2PTransferImpl &&
            (identical(other.recipientUserId, recipientUserId) ||
                other.recipientUserId == recipientUserId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.subAccountId, subAccountId) ||
                other.subAccountId == subAccountId) &&
            (identical(other.note, note) || other.note == note));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, recipientUserId, amount, subAccountId, note);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendP2PTransferImplCopyWith<_$SendP2PTransferImpl> get copyWith =>
      __$$SendP2PTransferImplCopyWithImpl<_$SendP2PTransferImpl>(
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
  }) {
    return sendP2PTransfer(recipientUserId, amount, subAccountId, note);
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
  }) {
    return sendP2PTransfer?.call(recipientUserId, amount, subAccountId, note);
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult Function()? clearMessages,
    required TResult orElse(),
  }) {
    if (sendP2PTransfer != null) {
      return sendP2PTransfer(recipientUserId, amount, subAccountId, note);
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return sendP2PTransfer(this);
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return sendP2PTransfer?.call(this);
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (sendP2PTransfer != null) {
      return sendP2PTransfer(this);
    }
    return orElse();
  }
}

abstract class _SendP2PTransfer implements WalletEvent {
  const factory _SendP2PTransfer({
    required final String recipientUserId,
    required final int amount,
    required final String subAccountId,
    final String? note,
  }) = _$SendP2PTransferImpl;

  String get recipientUserId;
  int get amount;
  String get subAccountId;
  String? get note;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendP2PTransferImplCopyWith<_$SendP2PTransferImpl> get copyWith =>
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
    extends _$WalletEventCopyWithImpl<$Res, _$ClearMessagesImpl>
    implements _$$ClearMessagesImplCopyWith<$Res> {
  __$$ClearMessagesImplCopyWithImpl(
    _$ClearMessagesImpl _value,
    $Res Function(_$ClearMessagesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearMessagesImpl implements _ClearMessages {
  const _$ClearMessagesImpl();

  @override
  String toString() {
    return 'WalletEvent.clearMessages()';
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
    required TResult Function() loadSubAccounts,
    required TResult Function() watchSubAccounts,
    required TResult Function(List<SubAccount> subAccounts) subAccountsUpdated,
    required TResult Function(String subAccountId) selectSubAccount,
    required TResult Function(String name) createUserWallet,
    required TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )
    transferBetweenWallets,
    required TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )
    sendP2PTransfer,
    required TResult Function() clearMessages,
  }) {
    return clearMessages();
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
    TResult? Function()? loadSubAccounts,
    TResult? Function()? watchSubAccounts,
    TResult? Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult? Function(String subAccountId)? selectSubAccount,
    TResult? Function(String name)? createUserWallet,
    TResult? Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult? Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
    TResult? Function()? clearMessages,
  }) {
    return clearMessages?.call();
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
    TResult Function()? loadSubAccounts,
    TResult Function()? watchSubAccounts,
    TResult Function(List<SubAccount> subAccounts)? subAccountsUpdated,
    TResult Function(String subAccountId)? selectSubAccount,
    TResult Function(String name)? createUserWallet,
    TResult Function(
      String fromSubAccountId,
      String toSubAccountId,
      int amount,
    )?
    transferBetweenWallets,
    TResult Function(
      String recipientUserId,
      int amount,
      String subAccountId,
      String? note,
    )?
    sendP2PTransfer,
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
    required TResult Function(_LoadSubAccounts value) loadSubAccounts,
    required TResult Function(_WatchSubAccounts value) watchSubAccounts,
    required TResult Function(_SubAccountsUpdated value) subAccountsUpdated,
    required TResult Function(_SelectSubAccount value) selectSubAccount,
    required TResult Function(_CreateUserWallet value) createUserWallet,
    required TResult Function(_TransferBetweenWallets value)
    transferBetweenWallets,
    required TResult Function(_SendP2PTransfer value) sendP2PTransfer,
    required TResult Function(_ClearMessages value) clearMessages,
  }) {
    return clearMessages(this);
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
    TResult? Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult? Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult? Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult? Function(_SelectSubAccount value)? selectSubAccount,
    TResult? Function(_CreateUserWallet value)? createUserWallet,
    TResult? Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult? Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult? Function(_ClearMessages value)? clearMessages,
  }) {
    return clearMessages?.call(this);
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
    TResult Function(_LoadSubAccounts value)? loadSubAccounts,
    TResult Function(_WatchSubAccounts value)? watchSubAccounts,
    TResult Function(_SubAccountsUpdated value)? subAccountsUpdated,
    TResult Function(_SelectSubAccount value)? selectSubAccount,
    TResult Function(_CreateUserWallet value)? createUserWallet,
    TResult Function(_TransferBetweenWallets value)? transferBetweenWallets,
    TResult Function(_SendP2PTransfer value)? sendP2PTransfer,
    TResult Function(_ClearMessages value)? clearMessages,
    required TResult orElse(),
  }) {
    if (clearMessages != null) {
      return clearMessages(this);
    }
    return orElse();
  }
}

abstract class _ClearMessages implements WalletEvent {
  const factory _ClearMessages() = _$ClearMessagesImpl;
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
  List<SubAccount> get subAccounts => throw _privateConstructorUsedError;
  String? get selectedSubAccountId => throw _privateConstructorUsedError;
  bool get isTransferring => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

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
    List<SubAccount> subAccounts,
    String? selectedSubAccountId,
    bool isTransferring,
    String? errorMessage,
    String? successMessage,
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
    Object? subAccounts = null,
    Object? selectedSubAccountId = freezed,
    Object? isTransferring = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
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
            subAccounts: null == subAccounts
                ? _value.subAccounts
                : subAccounts // ignore: cast_nullable_to_non_nullable
                      as List<SubAccount>,
            selectedSubAccountId: freezed == selectedSubAccountId
                ? _value.selectedSubAccountId
                : selectedSubAccountId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isTransferring: null == isTransferring
                ? _value.isTransferring
                : isTransferring // ignore: cast_nullable_to_non_nullable
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
    List<SubAccount> subAccounts,
    String? selectedSubAccountId,
    bool isTransferring,
    String? errorMessage,
    String? successMessage,
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
    Object? subAccounts = null,
    Object? selectedSubAccountId = freezed,
    Object? isTransferring = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
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
        subAccounts: null == subAccounts
            ? _value._subAccounts
            : subAccounts // ignore: cast_nullable_to_non_nullable
                  as List<SubAccount>,
        selectedSubAccountId: freezed == selectedSubAccountId
            ? _value.selectedSubAccountId
            : selectedSubAccountId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isTransferring: null == isTransferring
            ? _value.isTransferring
            : isTransferring // ignore: cast_nullable_to_non_nullable
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

class _$WalletStateImpl extends _WalletState {
  const _$WalletStateImpl({
    this.status = WalletStatus.initial,
    this.ledgerAccount,
    this.engagementStats,
    final List<LedgerJournal> ledgerJournals = const [],
    this.isLoadingMore = false,
    this.hasMoreLedgerJournals = false,
    final List<SubAccount> subAccounts = const [],
    this.selectedSubAccountId,
    this.isTransferring = false,
    this.errorMessage,
    this.successMessage,
  }) : _ledgerJournals = ledgerJournals,
       _subAccounts = subAccounts,
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
  final List<SubAccount> _subAccounts;
  @override
  @JsonKey()
  List<SubAccount> get subAccounts {
    if (_subAccounts is EqualUnmodifiableListView) return _subAccounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subAccounts);
  }

  @override
  final String? selectedSubAccountId;
  @override
  @JsonKey()
  final bool isTransferring;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'WalletState(status: $status, ledgerAccount: $ledgerAccount, engagementStats: $engagementStats, ledgerJournals: $ledgerJournals, isLoadingMore: $isLoadingMore, hasMoreLedgerJournals: $hasMoreLedgerJournals, subAccounts: $subAccounts, selectedSubAccountId: $selectedSubAccountId, isTransferring: $isTransferring, errorMessage: $errorMessage, successMessage: $successMessage)';
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
            const DeepCollectionEquality().equals(
              other._subAccounts,
              _subAccounts,
            ) &&
            (identical(other.selectedSubAccountId, selectedSubAccountId) ||
                other.selectedSubAccountId == selectedSubAccountId) &&
            (identical(other.isTransferring, isTransferring) ||
                other.isTransferring == isTransferring) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
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
    const DeepCollectionEquality().hash(_subAccounts),
    selectedSubAccountId,
    isTransferring,
    errorMessage,
    successMessage,
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
    final List<SubAccount> subAccounts,
    final String? selectedSubAccountId,
    final bool isTransferring,
    final String? errorMessage,
    final String? successMessage,
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
  List<SubAccount> get subAccounts;
  @override
  String? get selectedSubAccountId;
  @override
  bool get isTransferring;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of WalletState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletStateImplCopyWith<_$WalletStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
