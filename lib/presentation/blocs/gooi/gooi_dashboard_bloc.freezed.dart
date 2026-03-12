// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gooi_dashboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GooiDashboardEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiDashboardEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiDashboardEvent()';
}


}

/// @nodoc
class $GooiDashboardEventCopyWith<$Res>  {
$GooiDashboardEventCopyWith(GooiDashboardEvent _, $Res Function(GooiDashboardEvent) __);
}


/// Adds pattern-matching-related methods to [GooiDashboardEvent].
extension GooiDashboardEventPatterns on GooiDashboardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadGroup value)?  loadGroup,TResult Function( _RefreshGroup value)?  refreshGroup,TResult Function( _Contribute value)?  contribute,TResult Function( _TriggerPayout value)?  triggerPayout,TResult Function( _ToggleAutoContribute value)?  toggleAutoContribute,TResult Function( _DelegateTrigger value)?  delegateTrigger,TResult Function( _RevokeDelegation value)?  revokeDelegation,TResult Function( _ExtendGracePeriod value)?  extendGracePeriod,TResult Function( _ApplyLateFee value)?  applyLateFee,TResult Function( _WaiveLateFee value)?  waiveLateFee,TResult Function( _ApplyPenalty value)?  applyPenalty,TResult Function( _RequestWithdrawal value)?  requestWithdrawal,TResult Function( _VoteWithdrawal value)?  voteWithdrawal,TResult Function( _VoteGraceExtension value)?  voteGraceExtension,TResult Function( _DissolveGroup value)?  dissolveGroup,TResult Function( _WriteOffBadDebt value)?  writeOffBadDebt,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadGroup() when loadGroup != null:
return loadGroup(_that);case _RefreshGroup() when refreshGroup != null:
return refreshGroup(_that);case _Contribute() when contribute != null:
return contribute(_that);case _TriggerPayout() when triggerPayout != null:
return triggerPayout(_that);case _ToggleAutoContribute() when toggleAutoContribute != null:
return toggleAutoContribute(_that);case _DelegateTrigger() when delegateTrigger != null:
return delegateTrigger(_that);case _RevokeDelegation() when revokeDelegation != null:
return revokeDelegation(_that);case _ExtendGracePeriod() when extendGracePeriod != null:
return extendGracePeriod(_that);case _ApplyLateFee() when applyLateFee != null:
return applyLateFee(_that);case _WaiveLateFee() when waiveLateFee != null:
return waiveLateFee(_that);case _ApplyPenalty() when applyPenalty != null:
return applyPenalty(_that);case _RequestWithdrawal() when requestWithdrawal != null:
return requestWithdrawal(_that);case _VoteWithdrawal() when voteWithdrawal != null:
return voteWithdrawal(_that);case _VoteGraceExtension() when voteGraceExtension != null:
return voteGraceExtension(_that);case _DissolveGroup() when dissolveGroup != null:
return dissolveGroup(_that);case _WriteOffBadDebt() when writeOffBadDebt != null:
return writeOffBadDebt(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadGroup value)  loadGroup,required TResult Function( _RefreshGroup value)  refreshGroup,required TResult Function( _Contribute value)  contribute,required TResult Function( _TriggerPayout value)  triggerPayout,required TResult Function( _ToggleAutoContribute value)  toggleAutoContribute,required TResult Function( _DelegateTrigger value)  delegateTrigger,required TResult Function( _RevokeDelegation value)  revokeDelegation,required TResult Function( _ExtendGracePeriod value)  extendGracePeriod,required TResult Function( _ApplyLateFee value)  applyLateFee,required TResult Function( _WaiveLateFee value)  waiveLateFee,required TResult Function( _ApplyPenalty value)  applyPenalty,required TResult Function( _RequestWithdrawal value)  requestWithdrawal,required TResult Function( _VoteWithdrawal value)  voteWithdrawal,required TResult Function( _VoteGraceExtension value)  voteGraceExtension,required TResult Function( _DissolveGroup value)  dissolveGroup,required TResult Function( _WriteOffBadDebt value)  writeOffBadDebt,}){
final _that = this;
switch (_that) {
case _LoadGroup():
return loadGroup(_that);case _RefreshGroup():
return refreshGroup(_that);case _Contribute():
return contribute(_that);case _TriggerPayout():
return triggerPayout(_that);case _ToggleAutoContribute():
return toggleAutoContribute(_that);case _DelegateTrigger():
return delegateTrigger(_that);case _RevokeDelegation():
return revokeDelegation(_that);case _ExtendGracePeriod():
return extendGracePeriod(_that);case _ApplyLateFee():
return applyLateFee(_that);case _WaiveLateFee():
return waiveLateFee(_that);case _ApplyPenalty():
return applyPenalty(_that);case _RequestWithdrawal():
return requestWithdrawal(_that);case _VoteWithdrawal():
return voteWithdrawal(_that);case _VoteGraceExtension():
return voteGraceExtension(_that);case _DissolveGroup():
return dissolveGroup(_that);case _WriteOffBadDebt():
return writeOffBadDebt(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadGroup value)?  loadGroup,TResult? Function( _RefreshGroup value)?  refreshGroup,TResult? Function( _Contribute value)?  contribute,TResult? Function( _TriggerPayout value)?  triggerPayout,TResult? Function( _ToggleAutoContribute value)?  toggleAutoContribute,TResult? Function( _DelegateTrigger value)?  delegateTrigger,TResult? Function( _RevokeDelegation value)?  revokeDelegation,TResult? Function( _ExtendGracePeriod value)?  extendGracePeriod,TResult? Function( _ApplyLateFee value)?  applyLateFee,TResult? Function( _WaiveLateFee value)?  waiveLateFee,TResult? Function( _ApplyPenalty value)?  applyPenalty,TResult? Function( _RequestWithdrawal value)?  requestWithdrawal,TResult? Function( _VoteWithdrawal value)?  voteWithdrawal,TResult? Function( _VoteGraceExtension value)?  voteGraceExtension,TResult? Function( _DissolveGroup value)?  dissolveGroup,TResult? Function( _WriteOffBadDebt value)?  writeOffBadDebt,}){
final _that = this;
switch (_that) {
case _LoadGroup() when loadGroup != null:
return loadGroup(_that);case _RefreshGroup() when refreshGroup != null:
return refreshGroup(_that);case _Contribute() when contribute != null:
return contribute(_that);case _TriggerPayout() when triggerPayout != null:
return triggerPayout(_that);case _ToggleAutoContribute() when toggleAutoContribute != null:
return toggleAutoContribute(_that);case _DelegateTrigger() when delegateTrigger != null:
return delegateTrigger(_that);case _RevokeDelegation() when revokeDelegation != null:
return revokeDelegation(_that);case _ExtendGracePeriod() when extendGracePeriod != null:
return extendGracePeriod(_that);case _ApplyLateFee() when applyLateFee != null:
return applyLateFee(_that);case _WaiveLateFee() when waiveLateFee != null:
return waiveLateFee(_that);case _ApplyPenalty() when applyPenalty != null:
return applyPenalty(_that);case _RequestWithdrawal() when requestWithdrawal != null:
return requestWithdrawal(_that);case _VoteWithdrawal() when voteWithdrawal != null:
return voteWithdrawal(_that);case _VoteGraceExtension() when voteGraceExtension != null:
return voteGraceExtension(_that);case _DissolveGroup() when dissolveGroup != null:
return dissolveGroup(_that);case _WriteOffBadDebt() when writeOffBadDebt != null:
return writeOffBadDebt(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String groupId)?  loadGroup,TResult Function()?  refreshGroup,TResult Function( String? subAccountId)?  contribute,TResult Function()?  triggerPayout,TResult Function( bool enabled,  String? walletSubAccountId)?  toggleAutoContribute,TResult Function( String delegateUserId,  int durationDays)?  delegateTrigger,TResult Function()?  revokeDelegation,TResult Function( int extensionHours)?  extendGracePeriod,TResult Function( String contributionId)?  applyLateFee,TResult Function( String contributionId)?  waiveLateFee,TResult Function( String targetUserId,  String action)?  applyPenalty,TResult Function( String? reason)?  requestWithdrawal,TResult Function( String withdrawalId,  bool approve)?  voteWithdrawal,TResult Function( String voteId,  bool approve)?  voteGraceExtension,TResult Function()?  dissolveGroup,TResult Function()?  writeOffBadDebt,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadGroup() when loadGroup != null:
return loadGroup(_that.groupId);case _RefreshGroup() when refreshGroup != null:
return refreshGroup();case _Contribute() when contribute != null:
return contribute(_that.subAccountId);case _TriggerPayout() when triggerPayout != null:
return triggerPayout();case _ToggleAutoContribute() when toggleAutoContribute != null:
return toggleAutoContribute(_that.enabled,_that.walletSubAccountId);case _DelegateTrigger() when delegateTrigger != null:
return delegateTrigger(_that.delegateUserId,_that.durationDays);case _RevokeDelegation() when revokeDelegation != null:
return revokeDelegation();case _ExtendGracePeriod() when extendGracePeriod != null:
return extendGracePeriod(_that.extensionHours);case _ApplyLateFee() when applyLateFee != null:
return applyLateFee(_that.contributionId);case _WaiveLateFee() when waiveLateFee != null:
return waiveLateFee(_that.contributionId);case _ApplyPenalty() when applyPenalty != null:
return applyPenalty(_that.targetUserId,_that.action);case _RequestWithdrawal() when requestWithdrawal != null:
return requestWithdrawal(_that.reason);case _VoteWithdrawal() when voteWithdrawal != null:
return voteWithdrawal(_that.withdrawalId,_that.approve);case _VoteGraceExtension() when voteGraceExtension != null:
return voteGraceExtension(_that.voteId,_that.approve);case _DissolveGroup() when dissolveGroup != null:
return dissolveGroup();case _WriteOffBadDebt() when writeOffBadDebt != null:
return writeOffBadDebt();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String groupId)  loadGroup,required TResult Function()  refreshGroup,required TResult Function( String? subAccountId)  contribute,required TResult Function()  triggerPayout,required TResult Function( bool enabled,  String? walletSubAccountId)  toggleAutoContribute,required TResult Function( String delegateUserId,  int durationDays)  delegateTrigger,required TResult Function()  revokeDelegation,required TResult Function( int extensionHours)  extendGracePeriod,required TResult Function( String contributionId)  applyLateFee,required TResult Function( String contributionId)  waiveLateFee,required TResult Function( String targetUserId,  String action)  applyPenalty,required TResult Function( String? reason)  requestWithdrawal,required TResult Function( String withdrawalId,  bool approve)  voteWithdrawal,required TResult Function( String voteId,  bool approve)  voteGraceExtension,required TResult Function()  dissolveGroup,required TResult Function()  writeOffBadDebt,}) {final _that = this;
switch (_that) {
case _LoadGroup():
return loadGroup(_that.groupId);case _RefreshGroup():
return refreshGroup();case _Contribute():
return contribute(_that.subAccountId);case _TriggerPayout():
return triggerPayout();case _ToggleAutoContribute():
return toggleAutoContribute(_that.enabled,_that.walletSubAccountId);case _DelegateTrigger():
return delegateTrigger(_that.delegateUserId,_that.durationDays);case _RevokeDelegation():
return revokeDelegation();case _ExtendGracePeriod():
return extendGracePeriod(_that.extensionHours);case _ApplyLateFee():
return applyLateFee(_that.contributionId);case _WaiveLateFee():
return waiveLateFee(_that.contributionId);case _ApplyPenalty():
return applyPenalty(_that.targetUserId,_that.action);case _RequestWithdrawal():
return requestWithdrawal(_that.reason);case _VoteWithdrawal():
return voteWithdrawal(_that.withdrawalId,_that.approve);case _VoteGraceExtension():
return voteGraceExtension(_that.voteId,_that.approve);case _DissolveGroup():
return dissolveGroup();case _WriteOffBadDebt():
return writeOffBadDebt();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String groupId)?  loadGroup,TResult? Function()?  refreshGroup,TResult? Function( String? subAccountId)?  contribute,TResult? Function()?  triggerPayout,TResult? Function( bool enabled,  String? walletSubAccountId)?  toggleAutoContribute,TResult? Function( String delegateUserId,  int durationDays)?  delegateTrigger,TResult? Function()?  revokeDelegation,TResult? Function( int extensionHours)?  extendGracePeriod,TResult? Function( String contributionId)?  applyLateFee,TResult? Function( String contributionId)?  waiveLateFee,TResult? Function( String targetUserId,  String action)?  applyPenalty,TResult? Function( String? reason)?  requestWithdrawal,TResult? Function( String withdrawalId,  bool approve)?  voteWithdrawal,TResult? Function( String voteId,  bool approve)?  voteGraceExtension,TResult? Function()?  dissolveGroup,TResult? Function()?  writeOffBadDebt,}) {final _that = this;
switch (_that) {
case _LoadGroup() when loadGroup != null:
return loadGroup(_that.groupId);case _RefreshGroup() when refreshGroup != null:
return refreshGroup();case _Contribute() when contribute != null:
return contribute(_that.subAccountId);case _TriggerPayout() when triggerPayout != null:
return triggerPayout();case _ToggleAutoContribute() when toggleAutoContribute != null:
return toggleAutoContribute(_that.enabled,_that.walletSubAccountId);case _DelegateTrigger() when delegateTrigger != null:
return delegateTrigger(_that.delegateUserId,_that.durationDays);case _RevokeDelegation() when revokeDelegation != null:
return revokeDelegation();case _ExtendGracePeriod() when extendGracePeriod != null:
return extendGracePeriod(_that.extensionHours);case _ApplyLateFee() when applyLateFee != null:
return applyLateFee(_that.contributionId);case _WaiveLateFee() when waiveLateFee != null:
return waiveLateFee(_that.contributionId);case _ApplyPenalty() when applyPenalty != null:
return applyPenalty(_that.targetUserId,_that.action);case _RequestWithdrawal() when requestWithdrawal != null:
return requestWithdrawal(_that.reason);case _VoteWithdrawal() when voteWithdrawal != null:
return voteWithdrawal(_that.withdrawalId,_that.approve);case _VoteGraceExtension() when voteGraceExtension != null:
return voteGraceExtension(_that.voteId,_that.approve);case _DissolveGroup() when dissolveGroup != null:
return dissolveGroup();case _WriteOffBadDebt() when writeOffBadDebt != null:
return writeOffBadDebt();case _:
  return null;

}
}

}

/// @nodoc


class _LoadGroup implements GooiDashboardEvent {
  const _LoadGroup(this.groupId);
  

 final  String groupId;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadGroupCopyWith<_LoadGroup> get copyWith => __$LoadGroupCopyWithImpl<_LoadGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadGroup&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GooiDashboardEvent.loadGroup(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$LoadGroupCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$LoadGroupCopyWith(_LoadGroup value, $Res Function(_LoadGroup) _then) = __$LoadGroupCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$LoadGroupCopyWithImpl<$Res>
    implements _$LoadGroupCopyWith<$Res> {
  __$LoadGroupCopyWithImpl(this._self, this._then);

  final _LoadGroup _self;
  final $Res Function(_LoadGroup) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_LoadGroup(
null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RefreshGroup implements GooiDashboardEvent {
  const _RefreshGroup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshGroup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiDashboardEvent.refreshGroup()';
}


}




/// @nodoc


class _Contribute implements GooiDashboardEvent {
  const _Contribute({this.subAccountId});
  

 final  String? subAccountId;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContributeCopyWith<_Contribute> get copyWith => __$ContributeCopyWithImpl<_Contribute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Contribute&&(identical(other.subAccountId, subAccountId) || other.subAccountId == subAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,subAccountId);

@override
String toString() {
  return 'GooiDashboardEvent.contribute(subAccountId: $subAccountId)';
}


}

/// @nodoc
abstract mixin class _$ContributeCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$ContributeCopyWith(_Contribute value, $Res Function(_Contribute) _then) = __$ContributeCopyWithImpl;
@useResult
$Res call({
 String? subAccountId
});




}
/// @nodoc
class __$ContributeCopyWithImpl<$Res>
    implements _$ContributeCopyWith<$Res> {
  __$ContributeCopyWithImpl(this._self, this._then);

  final _Contribute _self;
  final $Res Function(_Contribute) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? subAccountId = freezed,}) {
  return _then(_Contribute(
subAccountId: freezed == subAccountId ? _self.subAccountId : subAccountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _TriggerPayout implements GooiDashboardEvent {
  const _TriggerPayout();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TriggerPayout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiDashboardEvent.triggerPayout()';
}


}




/// @nodoc


class _ToggleAutoContribute implements GooiDashboardEvent {
  const _ToggleAutoContribute({required this.enabled, this.walletSubAccountId});
  

 final  bool enabled;
 final  String? walletSubAccountId;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleAutoContributeCopyWith<_ToggleAutoContribute> get copyWith => __$ToggleAutoContributeCopyWithImpl<_ToggleAutoContribute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleAutoContribute&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.walletSubAccountId, walletSubAccountId) || other.walletSubAccountId == walletSubAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,walletSubAccountId);

@override
String toString() {
  return 'GooiDashboardEvent.toggleAutoContribute(enabled: $enabled, walletSubAccountId: $walletSubAccountId)';
}


}

/// @nodoc
abstract mixin class _$ToggleAutoContributeCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$ToggleAutoContributeCopyWith(_ToggleAutoContribute value, $Res Function(_ToggleAutoContribute) _then) = __$ToggleAutoContributeCopyWithImpl;
@useResult
$Res call({
 bool enabled, String? walletSubAccountId
});




}
/// @nodoc
class __$ToggleAutoContributeCopyWithImpl<$Res>
    implements _$ToggleAutoContributeCopyWith<$Res> {
  __$ToggleAutoContributeCopyWithImpl(this._self, this._then);

  final _ToggleAutoContribute _self;
  final $Res Function(_ToggleAutoContribute) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? walletSubAccountId = freezed,}) {
  return _then(_ToggleAutoContribute(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,walletSubAccountId: freezed == walletSubAccountId ? _self.walletSubAccountId : walletSubAccountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _DelegateTrigger implements GooiDashboardEvent {
  const _DelegateTrigger({required this.delegateUserId, this.durationDays = 7});
  

 final  String delegateUserId;
@JsonKey() final  int durationDays;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DelegateTriggerCopyWith<_DelegateTrigger> get copyWith => __$DelegateTriggerCopyWithImpl<_DelegateTrigger>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DelegateTrigger&&(identical(other.delegateUserId, delegateUserId) || other.delegateUserId == delegateUserId)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays));
}


@override
int get hashCode => Object.hash(runtimeType,delegateUserId,durationDays);

@override
String toString() {
  return 'GooiDashboardEvent.delegateTrigger(delegateUserId: $delegateUserId, durationDays: $durationDays)';
}


}

/// @nodoc
abstract mixin class _$DelegateTriggerCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$DelegateTriggerCopyWith(_DelegateTrigger value, $Res Function(_DelegateTrigger) _then) = __$DelegateTriggerCopyWithImpl;
@useResult
$Res call({
 String delegateUserId, int durationDays
});




}
/// @nodoc
class __$DelegateTriggerCopyWithImpl<$Res>
    implements _$DelegateTriggerCopyWith<$Res> {
  __$DelegateTriggerCopyWithImpl(this._self, this._then);

  final _DelegateTrigger _self;
  final $Res Function(_DelegateTrigger) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? delegateUserId = null,Object? durationDays = null,}) {
  return _then(_DelegateTrigger(
delegateUserId: null == delegateUserId ? _self.delegateUserId : delegateUserId // ignore: cast_nullable_to_non_nullable
as String,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _RevokeDelegation implements GooiDashboardEvent {
  const _RevokeDelegation();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevokeDelegation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiDashboardEvent.revokeDelegation()';
}


}




/// @nodoc


class _ExtendGracePeriod implements GooiDashboardEvent {
  const _ExtendGracePeriod({required this.extensionHours});
  

 final  int extensionHours;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtendGracePeriodCopyWith<_ExtendGracePeriod> get copyWith => __$ExtendGracePeriodCopyWithImpl<_ExtendGracePeriod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtendGracePeriod&&(identical(other.extensionHours, extensionHours) || other.extensionHours == extensionHours));
}


@override
int get hashCode => Object.hash(runtimeType,extensionHours);

@override
String toString() {
  return 'GooiDashboardEvent.extendGracePeriod(extensionHours: $extensionHours)';
}


}

/// @nodoc
abstract mixin class _$ExtendGracePeriodCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$ExtendGracePeriodCopyWith(_ExtendGracePeriod value, $Res Function(_ExtendGracePeriod) _then) = __$ExtendGracePeriodCopyWithImpl;
@useResult
$Res call({
 int extensionHours
});




}
/// @nodoc
class __$ExtendGracePeriodCopyWithImpl<$Res>
    implements _$ExtendGracePeriodCopyWith<$Res> {
  __$ExtendGracePeriodCopyWithImpl(this._self, this._then);

  final _ExtendGracePeriod _self;
  final $Res Function(_ExtendGracePeriod) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? extensionHours = null,}) {
  return _then(_ExtendGracePeriod(
extensionHours: null == extensionHours ? _self.extensionHours : extensionHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ApplyLateFee implements GooiDashboardEvent {
  const _ApplyLateFee({required this.contributionId});
  

 final  String contributionId;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyLateFeeCopyWith<_ApplyLateFee> get copyWith => __$ApplyLateFeeCopyWithImpl<_ApplyLateFee>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyLateFee&&(identical(other.contributionId, contributionId) || other.contributionId == contributionId));
}


@override
int get hashCode => Object.hash(runtimeType,contributionId);

@override
String toString() {
  return 'GooiDashboardEvent.applyLateFee(contributionId: $contributionId)';
}


}

/// @nodoc
abstract mixin class _$ApplyLateFeeCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$ApplyLateFeeCopyWith(_ApplyLateFee value, $Res Function(_ApplyLateFee) _then) = __$ApplyLateFeeCopyWithImpl;
@useResult
$Res call({
 String contributionId
});




}
/// @nodoc
class __$ApplyLateFeeCopyWithImpl<$Res>
    implements _$ApplyLateFeeCopyWith<$Res> {
  __$ApplyLateFeeCopyWithImpl(this._self, this._then);

  final _ApplyLateFee _self;
  final $Res Function(_ApplyLateFee) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contributionId = null,}) {
  return _then(_ApplyLateFee(
contributionId: null == contributionId ? _self.contributionId : contributionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WaiveLateFee implements GooiDashboardEvent {
  const _WaiveLateFee({required this.contributionId});
  

 final  String contributionId;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaiveLateFeeCopyWith<_WaiveLateFee> get copyWith => __$WaiveLateFeeCopyWithImpl<_WaiveLateFee>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaiveLateFee&&(identical(other.contributionId, contributionId) || other.contributionId == contributionId));
}


@override
int get hashCode => Object.hash(runtimeType,contributionId);

@override
String toString() {
  return 'GooiDashboardEvent.waiveLateFee(contributionId: $contributionId)';
}


}

/// @nodoc
abstract mixin class _$WaiveLateFeeCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$WaiveLateFeeCopyWith(_WaiveLateFee value, $Res Function(_WaiveLateFee) _then) = __$WaiveLateFeeCopyWithImpl;
@useResult
$Res call({
 String contributionId
});




}
/// @nodoc
class __$WaiveLateFeeCopyWithImpl<$Res>
    implements _$WaiveLateFeeCopyWith<$Res> {
  __$WaiveLateFeeCopyWithImpl(this._self, this._then);

  final _WaiveLateFee _self;
  final $Res Function(_WaiveLateFee) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contributionId = null,}) {
  return _then(_WaiveLateFee(
contributionId: null == contributionId ? _self.contributionId : contributionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ApplyPenalty implements GooiDashboardEvent {
  const _ApplyPenalty({required this.targetUserId, required this.action});
  

 final  String targetUserId;
 final  String action;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyPenaltyCopyWith<_ApplyPenalty> get copyWith => __$ApplyPenaltyCopyWithImpl<_ApplyPenalty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyPenalty&&(identical(other.targetUserId, targetUserId) || other.targetUserId == targetUserId)&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,targetUserId,action);

@override
String toString() {
  return 'GooiDashboardEvent.applyPenalty(targetUserId: $targetUserId, action: $action)';
}


}

/// @nodoc
abstract mixin class _$ApplyPenaltyCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$ApplyPenaltyCopyWith(_ApplyPenalty value, $Res Function(_ApplyPenalty) _then) = __$ApplyPenaltyCopyWithImpl;
@useResult
$Res call({
 String targetUserId, String action
});




}
/// @nodoc
class __$ApplyPenaltyCopyWithImpl<$Res>
    implements _$ApplyPenaltyCopyWith<$Res> {
  __$ApplyPenaltyCopyWithImpl(this._self, this._then);

  final _ApplyPenalty _self;
  final $Res Function(_ApplyPenalty) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? targetUserId = null,Object? action = null,}) {
  return _then(_ApplyPenalty(
targetUserId: null == targetUserId ? _self.targetUserId : targetUserId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RequestWithdrawal implements GooiDashboardEvent {
  const _RequestWithdrawal({this.reason});
  

 final  String? reason;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestWithdrawalCopyWith<_RequestWithdrawal> get copyWith => __$RequestWithdrawalCopyWithImpl<_RequestWithdrawal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestWithdrawal&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'GooiDashboardEvent.requestWithdrawal(reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$RequestWithdrawalCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$RequestWithdrawalCopyWith(_RequestWithdrawal value, $Res Function(_RequestWithdrawal) _then) = __$RequestWithdrawalCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class __$RequestWithdrawalCopyWithImpl<$Res>
    implements _$RequestWithdrawalCopyWith<$Res> {
  __$RequestWithdrawalCopyWithImpl(this._self, this._then);

  final _RequestWithdrawal _self;
  final $Res Function(_RequestWithdrawal) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(_RequestWithdrawal(
reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _VoteWithdrawal implements GooiDashboardEvent {
  const _VoteWithdrawal({required this.withdrawalId, required this.approve});
  

 final  String withdrawalId;
 final  bool approve;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteWithdrawalCopyWith<_VoteWithdrawal> get copyWith => __$VoteWithdrawalCopyWithImpl<_VoteWithdrawal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteWithdrawal&&(identical(other.withdrawalId, withdrawalId) || other.withdrawalId == withdrawalId)&&(identical(other.approve, approve) || other.approve == approve));
}


@override
int get hashCode => Object.hash(runtimeType,withdrawalId,approve);

@override
String toString() {
  return 'GooiDashboardEvent.voteWithdrawal(withdrawalId: $withdrawalId, approve: $approve)';
}


}

/// @nodoc
abstract mixin class _$VoteWithdrawalCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$VoteWithdrawalCopyWith(_VoteWithdrawal value, $Res Function(_VoteWithdrawal) _then) = __$VoteWithdrawalCopyWithImpl;
@useResult
$Res call({
 String withdrawalId, bool approve
});




}
/// @nodoc
class __$VoteWithdrawalCopyWithImpl<$Res>
    implements _$VoteWithdrawalCopyWith<$Res> {
  __$VoteWithdrawalCopyWithImpl(this._self, this._then);

  final _VoteWithdrawal _self;
  final $Res Function(_VoteWithdrawal) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? withdrawalId = null,Object? approve = null,}) {
  return _then(_VoteWithdrawal(
withdrawalId: null == withdrawalId ? _self.withdrawalId : withdrawalId // ignore: cast_nullable_to_non_nullable
as String,approve: null == approve ? _self.approve : approve // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _VoteGraceExtension implements GooiDashboardEvent {
  const _VoteGraceExtension({required this.voteId, required this.approve});
  

 final  String voteId;
 final  bool approve;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteGraceExtensionCopyWith<_VoteGraceExtension> get copyWith => __$VoteGraceExtensionCopyWithImpl<_VoteGraceExtension>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteGraceExtension&&(identical(other.voteId, voteId) || other.voteId == voteId)&&(identical(other.approve, approve) || other.approve == approve));
}


@override
int get hashCode => Object.hash(runtimeType,voteId,approve);

@override
String toString() {
  return 'GooiDashboardEvent.voteGraceExtension(voteId: $voteId, approve: $approve)';
}


}

/// @nodoc
abstract mixin class _$VoteGraceExtensionCopyWith<$Res> implements $GooiDashboardEventCopyWith<$Res> {
  factory _$VoteGraceExtensionCopyWith(_VoteGraceExtension value, $Res Function(_VoteGraceExtension) _then) = __$VoteGraceExtensionCopyWithImpl;
@useResult
$Res call({
 String voteId, bool approve
});




}
/// @nodoc
class __$VoteGraceExtensionCopyWithImpl<$Res>
    implements _$VoteGraceExtensionCopyWith<$Res> {
  __$VoteGraceExtensionCopyWithImpl(this._self, this._then);

  final _VoteGraceExtension _self;
  final $Res Function(_VoteGraceExtension) _then;

/// Create a copy of GooiDashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? voteId = null,Object? approve = null,}) {
  return _then(_VoteGraceExtension(
voteId: null == voteId ? _self.voteId : voteId // ignore: cast_nullable_to_non_nullable
as String,approve: null == approve ? _self.approve : approve // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _DissolveGroup implements GooiDashboardEvent {
  const _DissolveGroup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DissolveGroup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiDashboardEvent.dissolveGroup()';
}


}




/// @nodoc


class _WriteOffBadDebt implements GooiDashboardEvent {
  const _WriteOffBadDebt();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WriteOffBadDebt);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiDashboardEvent.writeOffBadDebt()';
}


}




/// @nodoc
mixin _$GooiDashboardState {

 bool get isLoading; bool get isRefreshing; bool get isActionInProgress; GooiGroup? get group; GooiCycle? get currentCycle; List<GooiMember> get members; List<GooiContribution> get contributions; List<GooiPayout> get payouts; List<GooiCycle> get cycles; String? get currentUserId; String? get errorMessage; String? get actionError; String? get actionSuccess;
/// Create a copy of GooiDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiDashboardStateCopyWith<GooiDashboardState> get copyWith => _$GooiDashboardStateCopyWithImpl<GooiDashboardState>(this as GooiDashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiDashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isActionInProgress, isActionInProgress) || other.isActionInProgress == isActionInProgress)&&(identical(other.group, group) || other.group == group)&&(identical(other.currentCycle, currentCycle) || other.currentCycle == currentCycle)&&const DeepCollectionEquality().equals(other.members, members)&&const DeepCollectionEquality().equals(other.contributions, contributions)&&const DeepCollectionEquality().equals(other.payouts, payouts)&&const DeepCollectionEquality().equals(other.cycles, cycles)&&(identical(other.currentUserId, currentUserId) || other.currentUserId == currentUserId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.actionError, actionError) || other.actionError == actionError)&&(identical(other.actionSuccess, actionSuccess) || other.actionSuccess == actionSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,isActionInProgress,group,currentCycle,const DeepCollectionEquality().hash(members),const DeepCollectionEquality().hash(contributions),const DeepCollectionEquality().hash(payouts),const DeepCollectionEquality().hash(cycles),currentUserId,errorMessage,actionError,actionSuccess);

@override
String toString() {
  return 'GooiDashboardState(isLoading: $isLoading, isRefreshing: $isRefreshing, isActionInProgress: $isActionInProgress, group: $group, currentCycle: $currentCycle, members: $members, contributions: $contributions, payouts: $payouts, cycles: $cycles, currentUserId: $currentUserId, errorMessage: $errorMessage, actionError: $actionError, actionSuccess: $actionSuccess)';
}


}

/// @nodoc
abstract mixin class $GooiDashboardStateCopyWith<$Res>  {
  factory $GooiDashboardStateCopyWith(GooiDashboardState value, $Res Function(GooiDashboardState) _then) = _$GooiDashboardStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isRefreshing, bool isActionInProgress, GooiGroup? group, GooiCycle? currentCycle, List<GooiMember> members, List<GooiContribution> contributions, List<GooiPayout> payouts, List<GooiCycle> cycles, String? currentUserId, String? errorMessage, String? actionError, String? actionSuccess
});


$GooiGroupCopyWith<$Res>? get group;$GooiCycleCopyWith<$Res>? get currentCycle;

}
/// @nodoc
class _$GooiDashboardStateCopyWithImpl<$Res>
    implements $GooiDashboardStateCopyWith<$Res> {
  _$GooiDashboardStateCopyWithImpl(this._self, this._then);

  final GooiDashboardState _self;
  final $Res Function(GooiDashboardState) _then;

/// Create a copy of GooiDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? isActionInProgress = null,Object? group = freezed,Object? currentCycle = freezed,Object? members = null,Object? contributions = null,Object? payouts = null,Object? cycles = null,Object? currentUserId = freezed,Object? errorMessage = freezed,Object? actionError = freezed,Object? actionSuccess = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isActionInProgress: null == isActionInProgress ? _self.isActionInProgress : isActionInProgress // ignore: cast_nullable_to_non_nullable
as bool,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as GooiGroup?,currentCycle: freezed == currentCycle ? _self.currentCycle : currentCycle // ignore: cast_nullable_to_non_nullable
as GooiCycle?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<GooiMember>,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as List<GooiContribution>,payouts: null == payouts ? _self.payouts : payouts // ignore: cast_nullable_to_non_nullable
as List<GooiPayout>,cycles: null == cycles ? _self.cycles : cycles // ignore: cast_nullable_to_non_nullable
as List<GooiCycle>,currentUserId: freezed == currentUserId ? _self.currentUserId : currentUserId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,actionSuccess: freezed == actionSuccess ? _self.actionSuccess : actionSuccess // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GooiDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GooiGroupCopyWith<$Res>? get group {
    if (_self.group == null) {
    return null;
  }

  return $GooiGroupCopyWith<$Res>(_self.group!, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of GooiDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GooiCycleCopyWith<$Res>? get currentCycle {
    if (_self.currentCycle == null) {
    return null;
  }

  return $GooiCycleCopyWith<$Res>(_self.currentCycle!, (value) {
    return _then(_self.copyWith(currentCycle: value));
  });
}
}


/// Adds pattern-matching-related methods to [GooiDashboardState].
extension GooiDashboardStatePatterns on GooiDashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiDashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiDashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiDashboardState value)  $default,){
final _that = this;
switch (_that) {
case _GooiDashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiDashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _GooiDashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  bool isActionInProgress,  GooiGroup? group,  GooiCycle? currentCycle,  List<GooiMember> members,  List<GooiContribution> contributions,  List<GooiPayout> payouts,  List<GooiCycle> cycles,  String? currentUserId,  String? errorMessage,  String? actionError,  String? actionSuccess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GooiDashboardState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.isActionInProgress,_that.group,_that.currentCycle,_that.members,_that.contributions,_that.payouts,_that.cycles,_that.currentUserId,_that.errorMessage,_that.actionError,_that.actionSuccess);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  bool isActionInProgress,  GooiGroup? group,  GooiCycle? currentCycle,  List<GooiMember> members,  List<GooiContribution> contributions,  List<GooiPayout> payouts,  List<GooiCycle> cycles,  String? currentUserId,  String? errorMessage,  String? actionError,  String? actionSuccess)  $default,) {final _that = this;
switch (_that) {
case _GooiDashboardState():
return $default(_that.isLoading,_that.isRefreshing,_that.isActionInProgress,_that.group,_that.currentCycle,_that.members,_that.contributions,_that.payouts,_that.cycles,_that.currentUserId,_that.errorMessage,_that.actionError,_that.actionSuccess);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isRefreshing,  bool isActionInProgress,  GooiGroup? group,  GooiCycle? currentCycle,  List<GooiMember> members,  List<GooiContribution> contributions,  List<GooiPayout> payouts,  List<GooiCycle> cycles,  String? currentUserId,  String? errorMessage,  String? actionError,  String? actionSuccess)?  $default,) {final _that = this;
switch (_that) {
case _GooiDashboardState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.isActionInProgress,_that.group,_that.currentCycle,_that.members,_that.contributions,_that.payouts,_that.cycles,_that.currentUserId,_that.errorMessage,_that.actionError,_that.actionSuccess);case _:
  return null;

}
}

}

/// @nodoc


class _GooiDashboardState implements GooiDashboardState {
  const _GooiDashboardState({this.isLoading = false, this.isRefreshing = false, this.isActionInProgress = false, this.group, this.currentCycle, final  List<GooiMember> members = const [], final  List<GooiContribution> contributions = const [], final  List<GooiPayout> payouts = const [], final  List<GooiCycle> cycles = const [], this.currentUserId, this.errorMessage, this.actionError, this.actionSuccess}): _members = members,_contributions = contributions,_payouts = payouts,_cycles = cycles;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool isActionInProgress;
@override final  GooiGroup? group;
@override final  GooiCycle? currentCycle;
 final  List<GooiMember> _members;
@override@JsonKey() List<GooiMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

 final  List<GooiContribution> _contributions;
@override@JsonKey() List<GooiContribution> get contributions {
  if (_contributions is EqualUnmodifiableListView) return _contributions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contributions);
}

 final  List<GooiPayout> _payouts;
@override@JsonKey() List<GooiPayout> get payouts {
  if (_payouts is EqualUnmodifiableListView) return _payouts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payouts);
}

 final  List<GooiCycle> _cycles;
@override@JsonKey() List<GooiCycle> get cycles {
  if (_cycles is EqualUnmodifiableListView) return _cycles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cycles);
}

@override final  String? currentUserId;
@override final  String? errorMessage;
@override final  String? actionError;
@override final  String? actionSuccess;

/// Create a copy of GooiDashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiDashboardStateCopyWith<_GooiDashboardState> get copyWith => __$GooiDashboardStateCopyWithImpl<_GooiDashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiDashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isActionInProgress, isActionInProgress) || other.isActionInProgress == isActionInProgress)&&(identical(other.group, group) || other.group == group)&&(identical(other.currentCycle, currentCycle) || other.currentCycle == currentCycle)&&const DeepCollectionEquality().equals(other._members, _members)&&const DeepCollectionEquality().equals(other._contributions, _contributions)&&const DeepCollectionEquality().equals(other._payouts, _payouts)&&const DeepCollectionEquality().equals(other._cycles, _cycles)&&(identical(other.currentUserId, currentUserId) || other.currentUserId == currentUserId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.actionError, actionError) || other.actionError == actionError)&&(identical(other.actionSuccess, actionSuccess) || other.actionSuccess == actionSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,isActionInProgress,group,currentCycle,const DeepCollectionEquality().hash(_members),const DeepCollectionEquality().hash(_contributions),const DeepCollectionEquality().hash(_payouts),const DeepCollectionEquality().hash(_cycles),currentUserId,errorMessage,actionError,actionSuccess);

@override
String toString() {
  return 'GooiDashboardState(isLoading: $isLoading, isRefreshing: $isRefreshing, isActionInProgress: $isActionInProgress, group: $group, currentCycle: $currentCycle, members: $members, contributions: $contributions, payouts: $payouts, cycles: $cycles, currentUserId: $currentUserId, errorMessage: $errorMessage, actionError: $actionError, actionSuccess: $actionSuccess)';
}


}

/// @nodoc
abstract mixin class _$GooiDashboardStateCopyWith<$Res> implements $GooiDashboardStateCopyWith<$Res> {
  factory _$GooiDashboardStateCopyWith(_GooiDashboardState value, $Res Function(_GooiDashboardState) _then) = __$GooiDashboardStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isRefreshing, bool isActionInProgress, GooiGroup? group, GooiCycle? currentCycle, List<GooiMember> members, List<GooiContribution> contributions, List<GooiPayout> payouts, List<GooiCycle> cycles, String? currentUserId, String? errorMessage, String? actionError, String? actionSuccess
});


@override $GooiGroupCopyWith<$Res>? get group;@override $GooiCycleCopyWith<$Res>? get currentCycle;

}
/// @nodoc
class __$GooiDashboardStateCopyWithImpl<$Res>
    implements _$GooiDashboardStateCopyWith<$Res> {
  __$GooiDashboardStateCopyWithImpl(this._self, this._then);

  final _GooiDashboardState _self;
  final $Res Function(_GooiDashboardState) _then;

/// Create a copy of GooiDashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? isActionInProgress = null,Object? group = freezed,Object? currentCycle = freezed,Object? members = null,Object? contributions = null,Object? payouts = null,Object? cycles = null,Object? currentUserId = freezed,Object? errorMessage = freezed,Object? actionError = freezed,Object? actionSuccess = freezed,}) {
  return _then(_GooiDashboardState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isActionInProgress: null == isActionInProgress ? _self.isActionInProgress : isActionInProgress // ignore: cast_nullable_to_non_nullable
as bool,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as GooiGroup?,currentCycle: freezed == currentCycle ? _self.currentCycle : currentCycle // ignore: cast_nullable_to_non_nullable
as GooiCycle?,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<GooiMember>,contributions: null == contributions ? _self._contributions : contributions // ignore: cast_nullable_to_non_nullable
as List<GooiContribution>,payouts: null == payouts ? _self._payouts : payouts // ignore: cast_nullable_to_non_nullable
as List<GooiPayout>,cycles: null == cycles ? _self._cycles : cycles // ignore: cast_nullable_to_non_nullable
as List<GooiCycle>,currentUserId: freezed == currentUserId ? _self.currentUserId : currentUserId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,actionSuccess: freezed == actionSuccess ? _self.actionSuccess : actionSuccess // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GooiDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GooiGroupCopyWith<$Res>? get group {
    if (_self.group == null) {
    return null;
  }

  return $GooiGroupCopyWith<$Res>(_self.group!, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of GooiDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GooiCycleCopyWith<$Res>? get currentCycle {
    if (_self.currentCycle == null) {
    return null;
  }

  return $GooiCycleCopyWith<$Res>(_self.currentCycle!, (value) {
    return _then(_self.copyWith(currentCycle: value));
  });
}
}

// dart format on
