// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WalletEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent()';
}


}

/// @nodoc
class $WalletEventCopyWith<$Res>  {
$WalletEventCopyWith(WalletEvent _, $Res Function(WalletEvent) __);
}


/// Adds pattern-matching-related methods to [WalletEvent].
extension WalletEventPatterns on WalletEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadLedger value)?  loadLedger,TResult Function( _WatchLedgerAccount value)?  watchLedgerAccount,TResult Function( _LedgerAccountUpdated value)?  ledgerAccountUpdated,TResult Function( _LoadLedgerJournals value)?  loadLedgerJournals,TResult Function( _LoadMoreLedgerJournals value)?  loadMoreLedgerJournals,TResult Function( _WatchLedgerJournals value)?  watchLedgerJournals,TResult Function( _LedgerJournalsUpdated value)?  ledgerJournalsUpdated,TResult Function( _RefreshLedger value)?  refreshLedger,TResult Function( _WatchEngagementStats value)?  watchEngagementStats,TResult Function( _EngagementStatsUpdated value)?  engagementStatsUpdated,TResult Function( _LoadSubAccounts value)?  loadSubAccounts,TResult Function( _WatchSubAccounts value)?  watchSubAccounts,TResult Function( _SubAccountsUpdated value)?  subAccountsUpdated,TResult Function( _SelectSubAccount value)?  selectSubAccount,TResult Function( _CreateUserWallet value)?  createUserWallet,TResult Function( _TransferBetweenWallets value)?  transferBetweenWallets,TResult Function( _SendP2PTransfer value)?  sendP2PTransfer,TResult Function( _ClearMessages value)?  clearMessages,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadLedger() when loadLedger != null:
return loadLedger(_that);case _WatchLedgerAccount() when watchLedgerAccount != null:
return watchLedgerAccount(_that);case _LedgerAccountUpdated() when ledgerAccountUpdated != null:
return ledgerAccountUpdated(_that);case _LoadLedgerJournals() when loadLedgerJournals != null:
return loadLedgerJournals(_that);case _LoadMoreLedgerJournals() when loadMoreLedgerJournals != null:
return loadMoreLedgerJournals(_that);case _WatchLedgerJournals() when watchLedgerJournals != null:
return watchLedgerJournals(_that);case _LedgerJournalsUpdated() when ledgerJournalsUpdated != null:
return ledgerJournalsUpdated(_that);case _RefreshLedger() when refreshLedger != null:
return refreshLedger(_that);case _WatchEngagementStats() when watchEngagementStats != null:
return watchEngagementStats(_that);case _EngagementStatsUpdated() when engagementStatsUpdated != null:
return engagementStatsUpdated(_that);case _LoadSubAccounts() when loadSubAccounts != null:
return loadSubAccounts(_that);case _WatchSubAccounts() when watchSubAccounts != null:
return watchSubAccounts(_that);case _SubAccountsUpdated() when subAccountsUpdated != null:
return subAccountsUpdated(_that);case _SelectSubAccount() when selectSubAccount != null:
return selectSubAccount(_that);case _CreateUserWallet() when createUserWallet != null:
return createUserWallet(_that);case _TransferBetweenWallets() when transferBetweenWallets != null:
return transferBetweenWallets(_that);case _SendP2PTransfer() when sendP2PTransfer != null:
return sendP2PTransfer(_that);case _ClearMessages() when clearMessages != null:
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadLedger value)  loadLedger,required TResult Function( _WatchLedgerAccount value)  watchLedgerAccount,required TResult Function( _LedgerAccountUpdated value)  ledgerAccountUpdated,required TResult Function( _LoadLedgerJournals value)  loadLedgerJournals,required TResult Function( _LoadMoreLedgerJournals value)  loadMoreLedgerJournals,required TResult Function( _WatchLedgerJournals value)  watchLedgerJournals,required TResult Function( _LedgerJournalsUpdated value)  ledgerJournalsUpdated,required TResult Function( _RefreshLedger value)  refreshLedger,required TResult Function( _WatchEngagementStats value)  watchEngagementStats,required TResult Function( _EngagementStatsUpdated value)  engagementStatsUpdated,required TResult Function( _LoadSubAccounts value)  loadSubAccounts,required TResult Function( _WatchSubAccounts value)  watchSubAccounts,required TResult Function( _SubAccountsUpdated value)  subAccountsUpdated,required TResult Function( _SelectSubAccount value)  selectSubAccount,required TResult Function( _CreateUserWallet value)  createUserWallet,required TResult Function( _TransferBetweenWallets value)  transferBetweenWallets,required TResult Function( _SendP2PTransfer value)  sendP2PTransfer,required TResult Function( _ClearMessages value)  clearMessages,}){
final _that = this;
switch (_that) {
case _LoadLedger():
return loadLedger(_that);case _WatchLedgerAccount():
return watchLedgerAccount(_that);case _LedgerAccountUpdated():
return ledgerAccountUpdated(_that);case _LoadLedgerJournals():
return loadLedgerJournals(_that);case _LoadMoreLedgerJournals():
return loadMoreLedgerJournals(_that);case _WatchLedgerJournals():
return watchLedgerJournals(_that);case _LedgerJournalsUpdated():
return ledgerJournalsUpdated(_that);case _RefreshLedger():
return refreshLedger(_that);case _WatchEngagementStats():
return watchEngagementStats(_that);case _EngagementStatsUpdated():
return engagementStatsUpdated(_that);case _LoadSubAccounts():
return loadSubAccounts(_that);case _WatchSubAccounts():
return watchSubAccounts(_that);case _SubAccountsUpdated():
return subAccountsUpdated(_that);case _SelectSubAccount():
return selectSubAccount(_that);case _CreateUserWallet():
return createUserWallet(_that);case _TransferBetweenWallets():
return transferBetweenWallets(_that);case _SendP2PTransfer():
return sendP2PTransfer(_that);case _ClearMessages():
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadLedger value)?  loadLedger,TResult? Function( _WatchLedgerAccount value)?  watchLedgerAccount,TResult? Function( _LedgerAccountUpdated value)?  ledgerAccountUpdated,TResult? Function( _LoadLedgerJournals value)?  loadLedgerJournals,TResult? Function( _LoadMoreLedgerJournals value)?  loadMoreLedgerJournals,TResult? Function( _WatchLedgerJournals value)?  watchLedgerJournals,TResult? Function( _LedgerJournalsUpdated value)?  ledgerJournalsUpdated,TResult? Function( _RefreshLedger value)?  refreshLedger,TResult? Function( _WatchEngagementStats value)?  watchEngagementStats,TResult? Function( _EngagementStatsUpdated value)?  engagementStatsUpdated,TResult? Function( _LoadSubAccounts value)?  loadSubAccounts,TResult? Function( _WatchSubAccounts value)?  watchSubAccounts,TResult? Function( _SubAccountsUpdated value)?  subAccountsUpdated,TResult? Function( _SelectSubAccount value)?  selectSubAccount,TResult? Function( _CreateUserWallet value)?  createUserWallet,TResult? Function( _TransferBetweenWallets value)?  transferBetweenWallets,TResult? Function( _SendP2PTransfer value)?  sendP2PTransfer,TResult? Function( _ClearMessages value)?  clearMessages,}){
final _that = this;
switch (_that) {
case _LoadLedger() when loadLedger != null:
return loadLedger(_that);case _WatchLedgerAccount() when watchLedgerAccount != null:
return watchLedgerAccount(_that);case _LedgerAccountUpdated() when ledgerAccountUpdated != null:
return ledgerAccountUpdated(_that);case _LoadLedgerJournals() when loadLedgerJournals != null:
return loadLedgerJournals(_that);case _LoadMoreLedgerJournals() when loadMoreLedgerJournals != null:
return loadMoreLedgerJournals(_that);case _WatchLedgerJournals() when watchLedgerJournals != null:
return watchLedgerJournals(_that);case _LedgerJournalsUpdated() when ledgerJournalsUpdated != null:
return ledgerJournalsUpdated(_that);case _RefreshLedger() when refreshLedger != null:
return refreshLedger(_that);case _WatchEngagementStats() when watchEngagementStats != null:
return watchEngagementStats(_that);case _EngagementStatsUpdated() when engagementStatsUpdated != null:
return engagementStatsUpdated(_that);case _LoadSubAccounts() when loadSubAccounts != null:
return loadSubAccounts(_that);case _WatchSubAccounts() when watchSubAccounts != null:
return watchSubAccounts(_that);case _SubAccountsUpdated() when subAccountsUpdated != null:
return subAccountsUpdated(_that);case _SelectSubAccount() when selectSubAccount != null:
return selectSubAccount(_that);case _CreateUserWallet() when createUserWallet != null:
return createUserWallet(_that);case _TransferBetweenWallets() when transferBetweenWallets != null:
return transferBetweenWallets(_that);case _SendP2PTransfer() when sendP2PTransfer != null:
return sendP2PTransfer(_that);case _ClearMessages() when clearMessages != null:
return clearMessages(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadLedger,TResult Function()?  watchLedgerAccount,TResult Function( LedgerAccount ledgerAccount)?  ledgerAccountUpdated,TResult Function( int? limit)?  loadLedgerJournals,TResult Function()?  loadMoreLedgerJournals,TResult Function( int? limit)?  watchLedgerJournals,TResult Function( List<LedgerJournal> journals)?  ledgerJournalsUpdated,TResult Function()?  refreshLedger,TResult Function()?  watchEngagementStats,TResult Function( UserEngagementStats stats)?  engagementStatsUpdated,TResult Function()?  loadSubAccounts,TResult Function()?  watchSubAccounts,TResult Function( List<SubAccount> subAccounts)?  subAccountsUpdated,TResult Function( String subAccountId)?  selectSubAccount,TResult Function( String name)?  createUserWallet,TResult Function( String fromSubAccountId,  String toSubAccountId,  int amount)?  transferBetweenWallets,TResult Function( String recipientUserId,  int amount,  String subAccountId,  String? note)?  sendP2PTransfer,TResult Function()?  clearMessages,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadLedger() when loadLedger != null:
return loadLedger();case _WatchLedgerAccount() when watchLedgerAccount != null:
return watchLedgerAccount();case _LedgerAccountUpdated() when ledgerAccountUpdated != null:
return ledgerAccountUpdated(_that.ledgerAccount);case _LoadLedgerJournals() when loadLedgerJournals != null:
return loadLedgerJournals(_that.limit);case _LoadMoreLedgerJournals() when loadMoreLedgerJournals != null:
return loadMoreLedgerJournals();case _WatchLedgerJournals() when watchLedgerJournals != null:
return watchLedgerJournals(_that.limit);case _LedgerJournalsUpdated() when ledgerJournalsUpdated != null:
return ledgerJournalsUpdated(_that.journals);case _RefreshLedger() when refreshLedger != null:
return refreshLedger();case _WatchEngagementStats() when watchEngagementStats != null:
return watchEngagementStats();case _EngagementStatsUpdated() when engagementStatsUpdated != null:
return engagementStatsUpdated(_that.stats);case _LoadSubAccounts() when loadSubAccounts != null:
return loadSubAccounts();case _WatchSubAccounts() when watchSubAccounts != null:
return watchSubAccounts();case _SubAccountsUpdated() when subAccountsUpdated != null:
return subAccountsUpdated(_that.subAccounts);case _SelectSubAccount() when selectSubAccount != null:
return selectSubAccount(_that.subAccountId);case _CreateUserWallet() when createUserWallet != null:
return createUserWallet(_that.name);case _TransferBetweenWallets() when transferBetweenWallets != null:
return transferBetweenWallets(_that.fromSubAccountId,_that.toSubAccountId,_that.amount);case _SendP2PTransfer() when sendP2PTransfer != null:
return sendP2PTransfer(_that.recipientUserId,_that.amount,_that.subAccountId,_that.note);case _ClearMessages() when clearMessages != null:
return clearMessages();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadLedger,required TResult Function()  watchLedgerAccount,required TResult Function( LedgerAccount ledgerAccount)  ledgerAccountUpdated,required TResult Function( int? limit)  loadLedgerJournals,required TResult Function()  loadMoreLedgerJournals,required TResult Function( int? limit)  watchLedgerJournals,required TResult Function( List<LedgerJournal> journals)  ledgerJournalsUpdated,required TResult Function()  refreshLedger,required TResult Function()  watchEngagementStats,required TResult Function( UserEngagementStats stats)  engagementStatsUpdated,required TResult Function()  loadSubAccounts,required TResult Function()  watchSubAccounts,required TResult Function( List<SubAccount> subAccounts)  subAccountsUpdated,required TResult Function( String subAccountId)  selectSubAccount,required TResult Function( String name)  createUserWallet,required TResult Function( String fromSubAccountId,  String toSubAccountId,  int amount)  transferBetweenWallets,required TResult Function( String recipientUserId,  int amount,  String subAccountId,  String? note)  sendP2PTransfer,required TResult Function()  clearMessages,}) {final _that = this;
switch (_that) {
case _LoadLedger():
return loadLedger();case _WatchLedgerAccount():
return watchLedgerAccount();case _LedgerAccountUpdated():
return ledgerAccountUpdated(_that.ledgerAccount);case _LoadLedgerJournals():
return loadLedgerJournals(_that.limit);case _LoadMoreLedgerJournals():
return loadMoreLedgerJournals();case _WatchLedgerJournals():
return watchLedgerJournals(_that.limit);case _LedgerJournalsUpdated():
return ledgerJournalsUpdated(_that.journals);case _RefreshLedger():
return refreshLedger();case _WatchEngagementStats():
return watchEngagementStats();case _EngagementStatsUpdated():
return engagementStatsUpdated(_that.stats);case _LoadSubAccounts():
return loadSubAccounts();case _WatchSubAccounts():
return watchSubAccounts();case _SubAccountsUpdated():
return subAccountsUpdated(_that.subAccounts);case _SelectSubAccount():
return selectSubAccount(_that.subAccountId);case _CreateUserWallet():
return createUserWallet(_that.name);case _TransferBetweenWallets():
return transferBetweenWallets(_that.fromSubAccountId,_that.toSubAccountId,_that.amount);case _SendP2PTransfer():
return sendP2PTransfer(_that.recipientUserId,_that.amount,_that.subAccountId,_that.note);case _ClearMessages():
return clearMessages();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadLedger,TResult? Function()?  watchLedgerAccount,TResult? Function( LedgerAccount ledgerAccount)?  ledgerAccountUpdated,TResult? Function( int? limit)?  loadLedgerJournals,TResult? Function()?  loadMoreLedgerJournals,TResult? Function( int? limit)?  watchLedgerJournals,TResult? Function( List<LedgerJournal> journals)?  ledgerJournalsUpdated,TResult? Function()?  refreshLedger,TResult? Function()?  watchEngagementStats,TResult? Function( UserEngagementStats stats)?  engagementStatsUpdated,TResult? Function()?  loadSubAccounts,TResult? Function()?  watchSubAccounts,TResult? Function( List<SubAccount> subAccounts)?  subAccountsUpdated,TResult? Function( String subAccountId)?  selectSubAccount,TResult? Function( String name)?  createUserWallet,TResult? Function( String fromSubAccountId,  String toSubAccountId,  int amount)?  transferBetweenWallets,TResult? Function( String recipientUserId,  int amount,  String subAccountId,  String? note)?  sendP2PTransfer,TResult? Function()?  clearMessages,}) {final _that = this;
switch (_that) {
case _LoadLedger() when loadLedger != null:
return loadLedger();case _WatchLedgerAccount() when watchLedgerAccount != null:
return watchLedgerAccount();case _LedgerAccountUpdated() when ledgerAccountUpdated != null:
return ledgerAccountUpdated(_that.ledgerAccount);case _LoadLedgerJournals() when loadLedgerJournals != null:
return loadLedgerJournals(_that.limit);case _LoadMoreLedgerJournals() when loadMoreLedgerJournals != null:
return loadMoreLedgerJournals();case _WatchLedgerJournals() when watchLedgerJournals != null:
return watchLedgerJournals(_that.limit);case _LedgerJournalsUpdated() when ledgerJournalsUpdated != null:
return ledgerJournalsUpdated(_that.journals);case _RefreshLedger() when refreshLedger != null:
return refreshLedger();case _WatchEngagementStats() when watchEngagementStats != null:
return watchEngagementStats();case _EngagementStatsUpdated() when engagementStatsUpdated != null:
return engagementStatsUpdated(_that.stats);case _LoadSubAccounts() when loadSubAccounts != null:
return loadSubAccounts();case _WatchSubAccounts() when watchSubAccounts != null:
return watchSubAccounts();case _SubAccountsUpdated() when subAccountsUpdated != null:
return subAccountsUpdated(_that.subAccounts);case _SelectSubAccount() when selectSubAccount != null:
return selectSubAccount(_that.subAccountId);case _CreateUserWallet() when createUserWallet != null:
return createUserWallet(_that.name);case _TransferBetweenWallets() when transferBetweenWallets != null:
return transferBetweenWallets(_that.fromSubAccountId,_that.toSubAccountId,_that.amount);case _SendP2PTransfer() when sendP2PTransfer != null:
return sendP2PTransfer(_that.recipientUserId,_that.amount,_that.subAccountId,_that.note);case _ClearMessages() when clearMessages != null:
return clearMessages();case _:
  return null;

}
}

}

/// @nodoc


class _LoadLedger implements WalletEvent {
  const _LoadLedger();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadLedger);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent.loadLedger()';
}


}




/// @nodoc


class _WatchLedgerAccount implements WalletEvent {
  const _WatchLedgerAccount();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchLedgerAccount);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent.watchLedgerAccount()';
}


}




/// @nodoc


class _LedgerAccountUpdated implements WalletEvent {
  const _LedgerAccountUpdated(this.ledgerAccount);
  

 final  LedgerAccount ledgerAccount;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerAccountUpdatedCopyWith<_LedgerAccountUpdated> get copyWith => __$LedgerAccountUpdatedCopyWithImpl<_LedgerAccountUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerAccountUpdated&&(identical(other.ledgerAccount, ledgerAccount) || other.ledgerAccount == ledgerAccount));
}


@override
int get hashCode => Object.hash(runtimeType,ledgerAccount);

@override
String toString() {
  return 'WalletEvent.ledgerAccountUpdated(ledgerAccount: $ledgerAccount)';
}


}

/// @nodoc
abstract mixin class _$LedgerAccountUpdatedCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$LedgerAccountUpdatedCopyWith(_LedgerAccountUpdated value, $Res Function(_LedgerAccountUpdated) _then) = __$LedgerAccountUpdatedCopyWithImpl;
@useResult
$Res call({
 LedgerAccount ledgerAccount
});


$LedgerAccountCopyWith<$Res> get ledgerAccount;

}
/// @nodoc
class __$LedgerAccountUpdatedCopyWithImpl<$Res>
    implements _$LedgerAccountUpdatedCopyWith<$Res> {
  __$LedgerAccountUpdatedCopyWithImpl(this._self, this._then);

  final _LedgerAccountUpdated _self;
  final $Res Function(_LedgerAccountUpdated) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ledgerAccount = null,}) {
  return _then(_LedgerAccountUpdated(
null == ledgerAccount ? _self.ledgerAccount : ledgerAccount // ignore: cast_nullable_to_non_nullable
as LedgerAccount,
  ));
}

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerAccountCopyWith<$Res> get ledgerAccount {
  
  return $LedgerAccountCopyWith<$Res>(_self.ledgerAccount, (value) {
    return _then(_self.copyWith(ledgerAccount: value));
  });
}
}

/// @nodoc


class _LoadLedgerJournals implements WalletEvent {
  const _LoadLedgerJournals({this.limit});
  

 final  int? limit;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadLedgerJournalsCopyWith<_LoadLedgerJournals> get copyWith => __$LoadLedgerJournalsCopyWithImpl<_LoadLedgerJournals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadLedgerJournals&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,limit);

@override
String toString() {
  return 'WalletEvent.loadLedgerJournals(limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$LoadLedgerJournalsCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$LoadLedgerJournalsCopyWith(_LoadLedgerJournals value, $Res Function(_LoadLedgerJournals) _then) = __$LoadLedgerJournalsCopyWithImpl;
@useResult
$Res call({
 int? limit
});




}
/// @nodoc
class __$LoadLedgerJournalsCopyWithImpl<$Res>
    implements _$LoadLedgerJournalsCopyWith<$Res> {
  __$LoadLedgerJournalsCopyWithImpl(this._self, this._then);

  final _LoadLedgerJournals _self;
  final $Res Function(_LoadLedgerJournals) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? limit = freezed,}) {
  return _then(_LoadLedgerJournals(
limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _LoadMoreLedgerJournals implements WalletEvent {
  const _LoadMoreLedgerJournals();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMoreLedgerJournals);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent.loadMoreLedgerJournals()';
}


}




/// @nodoc


class _WatchLedgerJournals implements WalletEvent {
  const _WatchLedgerJournals({this.limit});
  

 final  int? limit;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchLedgerJournalsCopyWith<_WatchLedgerJournals> get copyWith => __$WatchLedgerJournalsCopyWithImpl<_WatchLedgerJournals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchLedgerJournals&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,limit);

@override
String toString() {
  return 'WalletEvent.watchLedgerJournals(limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$WatchLedgerJournalsCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$WatchLedgerJournalsCopyWith(_WatchLedgerJournals value, $Res Function(_WatchLedgerJournals) _then) = __$WatchLedgerJournalsCopyWithImpl;
@useResult
$Res call({
 int? limit
});




}
/// @nodoc
class __$WatchLedgerJournalsCopyWithImpl<$Res>
    implements _$WatchLedgerJournalsCopyWith<$Res> {
  __$WatchLedgerJournalsCopyWithImpl(this._self, this._then);

  final _WatchLedgerJournals _self;
  final $Res Function(_WatchLedgerJournals) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? limit = freezed,}) {
  return _then(_WatchLedgerJournals(
limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _LedgerJournalsUpdated implements WalletEvent {
  const _LedgerJournalsUpdated(final  List<LedgerJournal> journals): _journals = journals;
  

 final  List<LedgerJournal> _journals;
 List<LedgerJournal> get journals {
  if (_journals is EqualUnmodifiableListView) return _journals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_journals);
}


/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerJournalsUpdatedCopyWith<_LedgerJournalsUpdated> get copyWith => __$LedgerJournalsUpdatedCopyWithImpl<_LedgerJournalsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerJournalsUpdated&&const DeepCollectionEquality().equals(other._journals, _journals));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_journals));

@override
String toString() {
  return 'WalletEvent.ledgerJournalsUpdated(journals: $journals)';
}


}

/// @nodoc
abstract mixin class _$LedgerJournalsUpdatedCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$LedgerJournalsUpdatedCopyWith(_LedgerJournalsUpdated value, $Res Function(_LedgerJournalsUpdated) _then) = __$LedgerJournalsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<LedgerJournal> journals
});




}
/// @nodoc
class __$LedgerJournalsUpdatedCopyWithImpl<$Res>
    implements _$LedgerJournalsUpdatedCopyWith<$Res> {
  __$LedgerJournalsUpdatedCopyWithImpl(this._self, this._then);

  final _LedgerJournalsUpdated _self;
  final $Res Function(_LedgerJournalsUpdated) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? journals = null,}) {
  return _then(_LedgerJournalsUpdated(
null == journals ? _self._journals : journals // ignore: cast_nullable_to_non_nullable
as List<LedgerJournal>,
  ));
}


}

/// @nodoc


class _RefreshLedger implements WalletEvent {
  const _RefreshLedger();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshLedger);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent.refreshLedger()';
}


}




/// @nodoc


class _WatchEngagementStats implements WalletEvent {
  const _WatchEngagementStats();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchEngagementStats);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent.watchEngagementStats()';
}


}




/// @nodoc


class _EngagementStatsUpdated implements WalletEvent {
  const _EngagementStatsUpdated(this.stats);
  

 final  UserEngagementStats stats;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EngagementStatsUpdatedCopyWith<_EngagementStatsUpdated> get copyWith => __$EngagementStatsUpdatedCopyWithImpl<_EngagementStatsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EngagementStatsUpdated&&(identical(other.stats, stats) || other.stats == stats));
}


@override
int get hashCode => Object.hash(runtimeType,stats);

@override
String toString() {
  return 'WalletEvent.engagementStatsUpdated(stats: $stats)';
}


}

/// @nodoc
abstract mixin class _$EngagementStatsUpdatedCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$EngagementStatsUpdatedCopyWith(_EngagementStatsUpdated value, $Res Function(_EngagementStatsUpdated) _then) = __$EngagementStatsUpdatedCopyWithImpl;
@useResult
$Res call({
 UserEngagementStats stats
});


$UserEngagementStatsCopyWith<$Res> get stats;

}
/// @nodoc
class __$EngagementStatsUpdatedCopyWithImpl<$Res>
    implements _$EngagementStatsUpdatedCopyWith<$Res> {
  __$EngagementStatsUpdatedCopyWithImpl(this._self, this._then);

  final _EngagementStatsUpdated _self;
  final $Res Function(_EngagementStatsUpdated) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stats = null,}) {
  return _then(_EngagementStatsUpdated(
null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as UserEngagementStats,
  ));
}

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEngagementStatsCopyWith<$Res> get stats {
  
  return $UserEngagementStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}

/// @nodoc


class _LoadSubAccounts implements WalletEvent {
  const _LoadSubAccounts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadSubAccounts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent.loadSubAccounts()';
}


}




/// @nodoc


class _WatchSubAccounts implements WalletEvent {
  const _WatchSubAccounts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchSubAccounts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent.watchSubAccounts()';
}


}




/// @nodoc


class _SubAccountsUpdated implements WalletEvent {
  const _SubAccountsUpdated(final  List<SubAccount> subAccounts): _subAccounts = subAccounts;
  

 final  List<SubAccount> _subAccounts;
 List<SubAccount> get subAccounts {
  if (_subAccounts is EqualUnmodifiableListView) return _subAccounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subAccounts);
}


/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubAccountsUpdatedCopyWith<_SubAccountsUpdated> get copyWith => __$SubAccountsUpdatedCopyWithImpl<_SubAccountsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubAccountsUpdated&&const DeepCollectionEquality().equals(other._subAccounts, _subAccounts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_subAccounts));

@override
String toString() {
  return 'WalletEvent.subAccountsUpdated(subAccounts: $subAccounts)';
}


}

/// @nodoc
abstract mixin class _$SubAccountsUpdatedCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$SubAccountsUpdatedCopyWith(_SubAccountsUpdated value, $Res Function(_SubAccountsUpdated) _then) = __$SubAccountsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<SubAccount> subAccounts
});




}
/// @nodoc
class __$SubAccountsUpdatedCopyWithImpl<$Res>
    implements _$SubAccountsUpdatedCopyWith<$Res> {
  __$SubAccountsUpdatedCopyWithImpl(this._self, this._then);

  final _SubAccountsUpdated _self;
  final $Res Function(_SubAccountsUpdated) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? subAccounts = null,}) {
  return _then(_SubAccountsUpdated(
null == subAccounts ? _self._subAccounts : subAccounts // ignore: cast_nullable_to_non_nullable
as List<SubAccount>,
  ));
}


}

/// @nodoc


class _SelectSubAccount implements WalletEvent {
  const _SelectSubAccount(this.subAccountId);
  

 final  String subAccountId;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectSubAccountCopyWith<_SelectSubAccount> get copyWith => __$SelectSubAccountCopyWithImpl<_SelectSubAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectSubAccount&&(identical(other.subAccountId, subAccountId) || other.subAccountId == subAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,subAccountId);

@override
String toString() {
  return 'WalletEvent.selectSubAccount(subAccountId: $subAccountId)';
}


}

/// @nodoc
abstract mixin class _$SelectSubAccountCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$SelectSubAccountCopyWith(_SelectSubAccount value, $Res Function(_SelectSubAccount) _then) = __$SelectSubAccountCopyWithImpl;
@useResult
$Res call({
 String subAccountId
});




}
/// @nodoc
class __$SelectSubAccountCopyWithImpl<$Res>
    implements _$SelectSubAccountCopyWith<$Res> {
  __$SelectSubAccountCopyWithImpl(this._self, this._then);

  final _SelectSubAccount _self;
  final $Res Function(_SelectSubAccount) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? subAccountId = null,}) {
  return _then(_SelectSubAccount(
null == subAccountId ? _self.subAccountId : subAccountId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CreateUserWallet implements WalletEvent {
  const _CreateUserWallet({required this.name});
  

 final  String name;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateUserWalletCopyWith<_CreateUserWallet> get copyWith => __$CreateUserWalletCopyWithImpl<_CreateUserWallet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateUserWallet&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'WalletEvent.createUserWallet(name: $name)';
}


}

/// @nodoc
abstract mixin class _$CreateUserWalletCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$CreateUserWalletCopyWith(_CreateUserWallet value, $Res Function(_CreateUserWallet) _then) = __$CreateUserWalletCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class __$CreateUserWalletCopyWithImpl<$Res>
    implements _$CreateUserWalletCopyWith<$Res> {
  __$CreateUserWalletCopyWithImpl(this._self, this._then);

  final _CreateUserWallet _self;
  final $Res Function(_CreateUserWallet) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_CreateUserWallet(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TransferBetweenWallets implements WalletEvent {
  const _TransferBetweenWallets({required this.fromSubAccountId, required this.toSubAccountId, required this.amount});
  

 final  String fromSubAccountId;
 final  String toSubAccountId;
 final  int amount;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferBetweenWalletsCopyWith<_TransferBetweenWallets> get copyWith => __$TransferBetweenWalletsCopyWithImpl<_TransferBetweenWallets>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferBetweenWallets&&(identical(other.fromSubAccountId, fromSubAccountId) || other.fromSubAccountId == fromSubAccountId)&&(identical(other.toSubAccountId, toSubAccountId) || other.toSubAccountId == toSubAccountId)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,fromSubAccountId,toSubAccountId,amount);

@override
String toString() {
  return 'WalletEvent.transferBetweenWallets(fromSubAccountId: $fromSubAccountId, toSubAccountId: $toSubAccountId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$TransferBetweenWalletsCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$TransferBetweenWalletsCopyWith(_TransferBetweenWallets value, $Res Function(_TransferBetweenWallets) _then) = __$TransferBetweenWalletsCopyWithImpl;
@useResult
$Res call({
 String fromSubAccountId, String toSubAccountId, int amount
});




}
/// @nodoc
class __$TransferBetweenWalletsCopyWithImpl<$Res>
    implements _$TransferBetweenWalletsCopyWith<$Res> {
  __$TransferBetweenWalletsCopyWithImpl(this._self, this._then);

  final _TransferBetweenWallets _self;
  final $Res Function(_TransferBetweenWallets) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fromSubAccountId = null,Object? toSubAccountId = null,Object? amount = null,}) {
  return _then(_TransferBetweenWallets(
fromSubAccountId: null == fromSubAccountId ? _self.fromSubAccountId : fromSubAccountId // ignore: cast_nullable_to_non_nullable
as String,toSubAccountId: null == toSubAccountId ? _self.toSubAccountId : toSubAccountId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _SendP2PTransfer implements WalletEvent {
  const _SendP2PTransfer({required this.recipientUserId, required this.amount, required this.subAccountId, this.note});
  

 final  String recipientUserId;
 final  int amount;
 final  String subAccountId;
 final  String? note;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendP2PTransferCopyWith<_SendP2PTransfer> get copyWith => __$SendP2PTransferCopyWithImpl<_SendP2PTransfer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendP2PTransfer&&(identical(other.recipientUserId, recipientUserId) || other.recipientUserId == recipientUserId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.subAccountId, subAccountId) || other.subAccountId == subAccountId)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,recipientUserId,amount,subAccountId,note);

@override
String toString() {
  return 'WalletEvent.sendP2PTransfer(recipientUserId: $recipientUserId, amount: $amount, subAccountId: $subAccountId, note: $note)';
}


}

/// @nodoc
abstract mixin class _$SendP2PTransferCopyWith<$Res> implements $WalletEventCopyWith<$Res> {
  factory _$SendP2PTransferCopyWith(_SendP2PTransfer value, $Res Function(_SendP2PTransfer) _then) = __$SendP2PTransferCopyWithImpl;
@useResult
$Res call({
 String recipientUserId, int amount, String subAccountId, String? note
});




}
/// @nodoc
class __$SendP2PTransferCopyWithImpl<$Res>
    implements _$SendP2PTransferCopyWith<$Res> {
  __$SendP2PTransferCopyWithImpl(this._self, this._then);

  final _SendP2PTransfer _self;
  final $Res Function(_SendP2PTransfer) _then;

/// Create a copy of WalletEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recipientUserId = null,Object? amount = null,Object? subAccountId = null,Object? note = freezed,}) {
  return _then(_SendP2PTransfer(
recipientUserId: null == recipientUserId ? _self.recipientUserId : recipientUserId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,subAccountId: null == subAccountId ? _self.subAccountId : subAccountId // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ClearMessages implements WalletEvent {
  const _ClearMessages();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearMessages);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletEvent.clearMessages()';
}


}




/// @nodoc
mixin _$WalletState {

 WalletStatus get status; LedgerAccount? get ledgerAccount; UserEngagementStats? get engagementStats; List<LedgerJournal> get ledgerJournals; bool get isLoadingMore; bool get hasMoreLedgerJournals; List<SubAccount> get subAccounts; String? get selectedSubAccountId; bool get isTransferring; String? get errorMessage; String? get successMessage;
/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletStateCopyWith<WalletState> get copyWith => _$WalletStateCopyWithImpl<WalletState>(this as WalletState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletState&&(identical(other.status, status) || other.status == status)&&(identical(other.ledgerAccount, ledgerAccount) || other.ledgerAccount == ledgerAccount)&&(identical(other.engagementStats, engagementStats) || other.engagementStats == engagementStats)&&const DeepCollectionEquality().equals(other.ledgerJournals, ledgerJournals)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMoreLedgerJournals, hasMoreLedgerJournals) || other.hasMoreLedgerJournals == hasMoreLedgerJournals)&&const DeepCollectionEquality().equals(other.subAccounts, subAccounts)&&(identical(other.selectedSubAccountId, selectedSubAccountId) || other.selectedSubAccountId == selectedSubAccountId)&&(identical(other.isTransferring, isTransferring) || other.isTransferring == isTransferring)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,ledgerAccount,engagementStats,const DeepCollectionEquality().hash(ledgerJournals),isLoadingMore,hasMoreLedgerJournals,const DeepCollectionEquality().hash(subAccounts),selectedSubAccountId,isTransferring,errorMessage,successMessage);

@override
String toString() {
  return 'WalletState(status: $status, ledgerAccount: $ledgerAccount, engagementStats: $engagementStats, ledgerJournals: $ledgerJournals, isLoadingMore: $isLoadingMore, hasMoreLedgerJournals: $hasMoreLedgerJournals, subAccounts: $subAccounts, selectedSubAccountId: $selectedSubAccountId, isTransferring: $isTransferring, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $WalletStateCopyWith<$Res>  {
  factory $WalletStateCopyWith(WalletState value, $Res Function(WalletState) _then) = _$WalletStateCopyWithImpl;
@useResult
$Res call({
 WalletStatus status, LedgerAccount? ledgerAccount, UserEngagementStats? engagementStats, List<LedgerJournal> ledgerJournals, bool isLoadingMore, bool hasMoreLedgerJournals, List<SubAccount> subAccounts, String? selectedSubAccountId, bool isTransferring, String? errorMessage, String? successMessage
});


$LedgerAccountCopyWith<$Res>? get ledgerAccount;$UserEngagementStatsCopyWith<$Res>? get engagementStats;

}
/// @nodoc
class _$WalletStateCopyWithImpl<$Res>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._self, this._then);

  final WalletState _self;
  final $Res Function(WalletState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? ledgerAccount = freezed,Object? engagementStats = freezed,Object? ledgerJournals = null,Object? isLoadingMore = null,Object? hasMoreLedgerJournals = null,Object? subAccounts = null,Object? selectedSubAccountId = freezed,Object? isTransferring = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WalletStatus,ledgerAccount: freezed == ledgerAccount ? _self.ledgerAccount : ledgerAccount // ignore: cast_nullable_to_non_nullable
as LedgerAccount?,engagementStats: freezed == engagementStats ? _self.engagementStats : engagementStats // ignore: cast_nullable_to_non_nullable
as UserEngagementStats?,ledgerJournals: null == ledgerJournals ? _self.ledgerJournals : ledgerJournals // ignore: cast_nullable_to_non_nullable
as List<LedgerJournal>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMoreLedgerJournals: null == hasMoreLedgerJournals ? _self.hasMoreLedgerJournals : hasMoreLedgerJournals // ignore: cast_nullable_to_non_nullable
as bool,subAccounts: null == subAccounts ? _self.subAccounts : subAccounts // ignore: cast_nullable_to_non_nullable
as List<SubAccount>,selectedSubAccountId: freezed == selectedSubAccountId ? _self.selectedSubAccountId : selectedSubAccountId // ignore: cast_nullable_to_non_nullable
as String?,isTransferring: null == isTransferring ? _self.isTransferring : isTransferring // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerAccountCopyWith<$Res>? get ledgerAccount {
    if (_self.ledgerAccount == null) {
    return null;
  }

  return $LedgerAccountCopyWith<$Res>(_self.ledgerAccount!, (value) {
    return _then(_self.copyWith(ledgerAccount: value));
  });
}/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEngagementStatsCopyWith<$Res>? get engagementStats {
    if (_self.engagementStats == null) {
    return null;
  }

  return $UserEngagementStatsCopyWith<$Res>(_self.engagementStats!, (value) {
    return _then(_self.copyWith(engagementStats: value));
  });
}
}


/// Adds pattern-matching-related methods to [WalletState].
extension WalletStatePatterns on WalletState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletState value)  $default,){
final _that = this;
switch (_that) {
case _WalletState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletState value)?  $default,){
final _that = this;
switch (_that) {
case _WalletState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WalletStatus status,  LedgerAccount? ledgerAccount,  UserEngagementStats? engagementStats,  List<LedgerJournal> ledgerJournals,  bool isLoadingMore,  bool hasMoreLedgerJournals,  List<SubAccount> subAccounts,  String? selectedSubAccountId,  bool isTransferring,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletState() when $default != null:
return $default(_that.status,_that.ledgerAccount,_that.engagementStats,_that.ledgerJournals,_that.isLoadingMore,_that.hasMoreLedgerJournals,_that.subAccounts,_that.selectedSubAccountId,_that.isTransferring,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WalletStatus status,  LedgerAccount? ledgerAccount,  UserEngagementStats? engagementStats,  List<LedgerJournal> ledgerJournals,  bool isLoadingMore,  bool hasMoreLedgerJournals,  List<SubAccount> subAccounts,  String? selectedSubAccountId,  bool isTransferring,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _WalletState():
return $default(_that.status,_that.ledgerAccount,_that.engagementStats,_that.ledgerJournals,_that.isLoadingMore,_that.hasMoreLedgerJournals,_that.subAccounts,_that.selectedSubAccountId,_that.isTransferring,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WalletStatus status,  LedgerAccount? ledgerAccount,  UserEngagementStats? engagementStats,  List<LedgerJournal> ledgerJournals,  bool isLoadingMore,  bool hasMoreLedgerJournals,  List<SubAccount> subAccounts,  String? selectedSubAccountId,  bool isTransferring,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _WalletState() when $default != null:
return $default(_that.status,_that.ledgerAccount,_that.engagementStats,_that.ledgerJournals,_that.isLoadingMore,_that.hasMoreLedgerJournals,_that.subAccounts,_that.selectedSubAccountId,_that.isTransferring,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _WalletState extends WalletState {
  const _WalletState({this.status = WalletStatus.initial, this.ledgerAccount, this.engagementStats, final  List<LedgerJournal> ledgerJournals = const [], this.isLoadingMore = false, this.hasMoreLedgerJournals = false, final  List<SubAccount> subAccounts = const [], this.selectedSubAccountId, this.isTransferring = false, this.errorMessage, this.successMessage}): _ledgerJournals = ledgerJournals,_subAccounts = subAccounts,super._();
  

@override@JsonKey() final  WalletStatus status;
@override final  LedgerAccount? ledgerAccount;
@override final  UserEngagementStats? engagementStats;
 final  List<LedgerJournal> _ledgerJournals;
@override@JsonKey() List<LedgerJournal> get ledgerJournals {
  if (_ledgerJournals is EqualUnmodifiableListView) return _ledgerJournals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ledgerJournals);
}

@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasMoreLedgerJournals;
 final  List<SubAccount> _subAccounts;
@override@JsonKey() List<SubAccount> get subAccounts {
  if (_subAccounts is EqualUnmodifiableListView) return _subAccounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subAccounts);
}

@override final  String? selectedSubAccountId;
@override@JsonKey() final  bool isTransferring;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletStateCopyWith<_WalletState> get copyWith => __$WalletStateCopyWithImpl<_WalletState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletState&&(identical(other.status, status) || other.status == status)&&(identical(other.ledgerAccount, ledgerAccount) || other.ledgerAccount == ledgerAccount)&&(identical(other.engagementStats, engagementStats) || other.engagementStats == engagementStats)&&const DeepCollectionEquality().equals(other._ledgerJournals, _ledgerJournals)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMoreLedgerJournals, hasMoreLedgerJournals) || other.hasMoreLedgerJournals == hasMoreLedgerJournals)&&const DeepCollectionEquality().equals(other._subAccounts, _subAccounts)&&(identical(other.selectedSubAccountId, selectedSubAccountId) || other.selectedSubAccountId == selectedSubAccountId)&&(identical(other.isTransferring, isTransferring) || other.isTransferring == isTransferring)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,ledgerAccount,engagementStats,const DeepCollectionEquality().hash(_ledgerJournals),isLoadingMore,hasMoreLedgerJournals,const DeepCollectionEquality().hash(_subAccounts),selectedSubAccountId,isTransferring,errorMessage,successMessage);

@override
String toString() {
  return 'WalletState(status: $status, ledgerAccount: $ledgerAccount, engagementStats: $engagementStats, ledgerJournals: $ledgerJournals, isLoadingMore: $isLoadingMore, hasMoreLedgerJournals: $hasMoreLedgerJournals, subAccounts: $subAccounts, selectedSubAccountId: $selectedSubAccountId, isTransferring: $isTransferring, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$WalletStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$WalletStateCopyWith(_WalletState value, $Res Function(_WalletState) _then) = __$WalletStateCopyWithImpl;
@override @useResult
$Res call({
 WalletStatus status, LedgerAccount? ledgerAccount, UserEngagementStats? engagementStats, List<LedgerJournal> ledgerJournals, bool isLoadingMore, bool hasMoreLedgerJournals, List<SubAccount> subAccounts, String? selectedSubAccountId, bool isTransferring, String? errorMessage, String? successMessage
});


@override $LedgerAccountCopyWith<$Res>? get ledgerAccount;@override $UserEngagementStatsCopyWith<$Res>? get engagementStats;

}
/// @nodoc
class __$WalletStateCopyWithImpl<$Res>
    implements _$WalletStateCopyWith<$Res> {
  __$WalletStateCopyWithImpl(this._self, this._then);

  final _WalletState _self;
  final $Res Function(_WalletState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? ledgerAccount = freezed,Object? engagementStats = freezed,Object? ledgerJournals = null,Object? isLoadingMore = null,Object? hasMoreLedgerJournals = null,Object? subAccounts = null,Object? selectedSubAccountId = freezed,Object? isTransferring = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_WalletState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WalletStatus,ledgerAccount: freezed == ledgerAccount ? _self.ledgerAccount : ledgerAccount // ignore: cast_nullable_to_non_nullable
as LedgerAccount?,engagementStats: freezed == engagementStats ? _self.engagementStats : engagementStats // ignore: cast_nullable_to_non_nullable
as UserEngagementStats?,ledgerJournals: null == ledgerJournals ? _self._ledgerJournals : ledgerJournals // ignore: cast_nullable_to_non_nullable
as List<LedgerJournal>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMoreLedgerJournals: null == hasMoreLedgerJournals ? _self.hasMoreLedgerJournals : hasMoreLedgerJournals // ignore: cast_nullable_to_non_nullable
as bool,subAccounts: null == subAccounts ? _self._subAccounts : subAccounts // ignore: cast_nullable_to_non_nullable
as List<SubAccount>,selectedSubAccountId: freezed == selectedSubAccountId ? _self.selectedSubAccountId : selectedSubAccountId // ignore: cast_nullable_to_non_nullable
as String?,isTransferring: null == isTransferring ? _self.isTransferring : isTransferring // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerAccountCopyWith<$Res>? get ledgerAccount {
    if (_self.ledgerAccount == null) {
    return null;
  }

  return $LedgerAccountCopyWith<$Res>(_self.ledgerAccount!, (value) {
    return _then(_self.copyWith(ledgerAccount: value));
  });
}/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEngagementStatsCopyWith<$Res>? get engagementStats {
    if (_self.engagementStats == null) {
    return null;
  }

  return $UserEngagementStatsCopyWith<$Res>(_self.engagementStats!, (value) {
    return _then(_self.copyWith(engagementStats: value));
  });
}
}

// dart format on
