// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gooi_formation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GooiFormationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiFormationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiFormationEvent()';
}


}

/// @nodoc
class $GooiFormationEventCopyWith<$Res>  {
$GooiFormationEventCopyWith(GooiFormationEvent _, $Res Function(GooiFormationEvent) __);
}


/// Adds pattern-matching-related methods to [GooiFormationEvent].
extension GooiFormationEventPatterns on GooiFormationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CreateGroup value)?  createGroup,TResult Function( _LoadFormationGroup value)?  loadGroup,TResult Function( _InviteMember value)?  inviteMember,TResult Function( _RespondInvitation value)?  respondInvitation,TResult Function( _LockRoster value)?  lockRoster,TResult Function( _SubmitBid value)?  submitBid,TResult Function( _ConfirmActivation value)?  confirmActivation,TResult Function( _DissolveGroup value)?  dissolveGroup,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateGroup() when createGroup != null:
return createGroup(_that);case _LoadFormationGroup() when loadGroup != null:
return loadGroup(_that);case _InviteMember() when inviteMember != null:
return inviteMember(_that);case _RespondInvitation() when respondInvitation != null:
return respondInvitation(_that);case _LockRoster() when lockRoster != null:
return lockRoster(_that);case _SubmitBid() when submitBid != null:
return submitBid(_that);case _ConfirmActivation() when confirmActivation != null:
return confirmActivation(_that);case _DissolveGroup() when dissolveGroup != null:
return dissolveGroup(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CreateGroup value)  createGroup,required TResult Function( _LoadFormationGroup value)  loadGroup,required TResult Function( _InviteMember value)  inviteMember,required TResult Function( _RespondInvitation value)  respondInvitation,required TResult Function( _LockRoster value)  lockRoster,required TResult Function( _SubmitBid value)  submitBid,required TResult Function( _ConfirmActivation value)  confirmActivation,required TResult Function( _DissolveGroup value)  dissolveGroup,}){
final _that = this;
switch (_that) {
case _CreateGroup():
return createGroup(_that);case _LoadFormationGroup():
return loadGroup(_that);case _InviteMember():
return inviteMember(_that);case _RespondInvitation():
return respondInvitation(_that);case _LockRoster():
return lockRoster(_that);case _SubmitBid():
return submitBid(_that);case _ConfirmActivation():
return confirmActivation(_that);case _DissolveGroup():
return dissolveGroup(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CreateGroup value)?  createGroup,TResult? Function( _LoadFormationGroup value)?  loadGroup,TResult? Function( _InviteMember value)?  inviteMember,TResult? Function( _RespondInvitation value)?  respondInvitation,TResult? Function( _LockRoster value)?  lockRoster,TResult? Function( _SubmitBid value)?  submitBid,TResult? Function( _ConfirmActivation value)?  confirmActivation,TResult? Function( _DissolveGroup value)?  dissolveGroup,}){
final _that = this;
switch (_that) {
case _CreateGroup() when createGroup != null:
return createGroup(_that);case _LoadFormationGroup() when loadGroup != null:
return loadGroup(_that);case _InviteMember() when inviteMember != null:
return inviteMember(_that);case _RespondInvitation() when respondInvitation != null:
return respondInvitation(_that);case _LockRoster() when lockRoster != null:
return lockRoster(_that);case _SubmitBid() when submitBid != null:
return submitBid(_that);case _ConfirmActivation() when confirmActivation != null:
return confirmActivation(_that);case _DissolveGroup() when dissolveGroup != null:
return dissolveGroup(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  int contributionAmount,  GooiCycleFrequency cycleFrequency,  int totalCycles,  GooiRosterMethod rosterMethod,  int gracePeriodHours,  int lateFeePercent,  bool recipientContributes)?  createGroup,TResult Function( String groupId)?  loadGroup,TResult Function( String inviteeUserId)?  inviteMember,TResult Function( String groupId,  bool accept)?  respondInvitation,TResult Function( List<String>? proposedOrder)?  lockRoster,TResult Function( int targetPosition,  int bidPercent)?  submitBid,TResult Function()?  confirmActivation,TResult Function()?  dissolveGroup,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateGroup() when createGroup != null:
return createGroup(_that.name,_that.contributionAmount,_that.cycleFrequency,_that.totalCycles,_that.rosterMethod,_that.gracePeriodHours,_that.lateFeePercent,_that.recipientContributes);case _LoadFormationGroup() when loadGroup != null:
return loadGroup(_that.groupId);case _InviteMember() when inviteMember != null:
return inviteMember(_that.inviteeUserId);case _RespondInvitation() when respondInvitation != null:
return respondInvitation(_that.groupId,_that.accept);case _LockRoster() when lockRoster != null:
return lockRoster(_that.proposedOrder);case _SubmitBid() when submitBid != null:
return submitBid(_that.targetPosition,_that.bidPercent);case _ConfirmActivation() when confirmActivation != null:
return confirmActivation();case _DissolveGroup() when dissolveGroup != null:
return dissolveGroup();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  int contributionAmount,  GooiCycleFrequency cycleFrequency,  int totalCycles,  GooiRosterMethod rosterMethod,  int gracePeriodHours,  int lateFeePercent,  bool recipientContributes)  createGroup,required TResult Function( String groupId)  loadGroup,required TResult Function( String inviteeUserId)  inviteMember,required TResult Function( String groupId,  bool accept)  respondInvitation,required TResult Function( List<String>? proposedOrder)  lockRoster,required TResult Function( int targetPosition,  int bidPercent)  submitBid,required TResult Function()  confirmActivation,required TResult Function()  dissolveGroup,}) {final _that = this;
switch (_that) {
case _CreateGroup():
return createGroup(_that.name,_that.contributionAmount,_that.cycleFrequency,_that.totalCycles,_that.rosterMethod,_that.gracePeriodHours,_that.lateFeePercent,_that.recipientContributes);case _LoadFormationGroup():
return loadGroup(_that.groupId);case _InviteMember():
return inviteMember(_that.inviteeUserId);case _RespondInvitation():
return respondInvitation(_that.groupId,_that.accept);case _LockRoster():
return lockRoster(_that.proposedOrder);case _SubmitBid():
return submitBid(_that.targetPosition,_that.bidPercent);case _ConfirmActivation():
return confirmActivation();case _DissolveGroup():
return dissolveGroup();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  int contributionAmount,  GooiCycleFrequency cycleFrequency,  int totalCycles,  GooiRosterMethod rosterMethod,  int gracePeriodHours,  int lateFeePercent,  bool recipientContributes)?  createGroup,TResult? Function( String groupId)?  loadGroup,TResult? Function( String inviteeUserId)?  inviteMember,TResult? Function( String groupId,  bool accept)?  respondInvitation,TResult? Function( List<String>? proposedOrder)?  lockRoster,TResult? Function( int targetPosition,  int bidPercent)?  submitBid,TResult? Function()?  confirmActivation,TResult? Function()?  dissolveGroup,}) {final _that = this;
switch (_that) {
case _CreateGroup() when createGroup != null:
return createGroup(_that.name,_that.contributionAmount,_that.cycleFrequency,_that.totalCycles,_that.rosterMethod,_that.gracePeriodHours,_that.lateFeePercent,_that.recipientContributes);case _LoadFormationGroup() when loadGroup != null:
return loadGroup(_that.groupId);case _InviteMember() when inviteMember != null:
return inviteMember(_that.inviteeUserId);case _RespondInvitation() when respondInvitation != null:
return respondInvitation(_that.groupId,_that.accept);case _LockRoster() when lockRoster != null:
return lockRoster(_that.proposedOrder);case _SubmitBid() when submitBid != null:
return submitBid(_that.targetPosition,_that.bidPercent);case _ConfirmActivation() when confirmActivation != null:
return confirmActivation();case _DissolveGroup() when dissolveGroup != null:
return dissolveGroup();case _:
  return null;

}
}

}

/// @nodoc


class _CreateGroup implements GooiFormationEvent {
  const _CreateGroup({required this.name, required this.contributionAmount, required this.cycleFrequency, required this.totalCycles, required this.rosterMethod, this.gracePeriodHours = 48, this.lateFeePercent = 5, this.recipientContributes = true});
  

 final  String name;
 final  int contributionAmount;
 final  GooiCycleFrequency cycleFrequency;
 final  int totalCycles;
 final  GooiRosterMethod rosterMethod;
@JsonKey() final  int gracePeriodHours;
@JsonKey() final  int lateFeePercent;
@JsonKey() final  bool recipientContributes;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateGroupCopyWith<_CreateGroup> get copyWith => __$CreateGroupCopyWithImpl<_CreateGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateGroup&&(identical(other.name, name) || other.name == name)&&(identical(other.contributionAmount, contributionAmount) || other.contributionAmount == contributionAmount)&&(identical(other.cycleFrequency, cycleFrequency) || other.cycleFrequency == cycleFrequency)&&(identical(other.totalCycles, totalCycles) || other.totalCycles == totalCycles)&&(identical(other.rosterMethod, rosterMethod) || other.rosterMethod == rosterMethod)&&(identical(other.gracePeriodHours, gracePeriodHours) || other.gracePeriodHours == gracePeriodHours)&&(identical(other.lateFeePercent, lateFeePercent) || other.lateFeePercent == lateFeePercent)&&(identical(other.recipientContributes, recipientContributes) || other.recipientContributes == recipientContributes));
}


@override
int get hashCode => Object.hash(runtimeType,name,contributionAmount,cycleFrequency,totalCycles,rosterMethod,gracePeriodHours,lateFeePercent,recipientContributes);

@override
String toString() {
  return 'GooiFormationEvent.createGroup(name: $name, contributionAmount: $contributionAmount, cycleFrequency: $cycleFrequency, totalCycles: $totalCycles, rosterMethod: $rosterMethod, gracePeriodHours: $gracePeriodHours, lateFeePercent: $lateFeePercent, recipientContributes: $recipientContributes)';
}


}

/// @nodoc
abstract mixin class _$CreateGroupCopyWith<$Res> implements $GooiFormationEventCopyWith<$Res> {
  factory _$CreateGroupCopyWith(_CreateGroup value, $Res Function(_CreateGroup) _then) = __$CreateGroupCopyWithImpl;
@useResult
$Res call({
 String name, int contributionAmount, GooiCycleFrequency cycleFrequency, int totalCycles, GooiRosterMethod rosterMethod, int gracePeriodHours, int lateFeePercent, bool recipientContributes
});




}
/// @nodoc
class __$CreateGroupCopyWithImpl<$Res>
    implements _$CreateGroupCopyWith<$Res> {
  __$CreateGroupCopyWithImpl(this._self, this._then);

  final _CreateGroup _self;
  final $Res Function(_CreateGroup) _then;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? contributionAmount = null,Object? cycleFrequency = null,Object? totalCycles = null,Object? rosterMethod = null,Object? gracePeriodHours = null,Object? lateFeePercent = null,Object? recipientContributes = null,}) {
  return _then(_CreateGroup(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,contributionAmount: null == contributionAmount ? _self.contributionAmount : contributionAmount // ignore: cast_nullable_to_non_nullable
as int,cycleFrequency: null == cycleFrequency ? _self.cycleFrequency : cycleFrequency // ignore: cast_nullable_to_non_nullable
as GooiCycleFrequency,totalCycles: null == totalCycles ? _self.totalCycles : totalCycles // ignore: cast_nullable_to_non_nullable
as int,rosterMethod: null == rosterMethod ? _self.rosterMethod : rosterMethod // ignore: cast_nullable_to_non_nullable
as GooiRosterMethod,gracePeriodHours: null == gracePeriodHours ? _self.gracePeriodHours : gracePeriodHours // ignore: cast_nullable_to_non_nullable
as int,lateFeePercent: null == lateFeePercent ? _self.lateFeePercent : lateFeePercent // ignore: cast_nullable_to_non_nullable
as int,recipientContributes: null == recipientContributes ? _self.recipientContributes : recipientContributes // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _LoadFormationGroup implements GooiFormationEvent {
  const _LoadFormationGroup(this.groupId);
  

 final  String groupId;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadFormationGroupCopyWith<_LoadFormationGroup> get copyWith => __$LoadFormationGroupCopyWithImpl<_LoadFormationGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadFormationGroup&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,groupId);

@override
String toString() {
  return 'GooiFormationEvent.loadGroup(groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$LoadFormationGroupCopyWith<$Res> implements $GooiFormationEventCopyWith<$Res> {
  factory _$LoadFormationGroupCopyWith(_LoadFormationGroup value, $Res Function(_LoadFormationGroup) _then) = __$LoadFormationGroupCopyWithImpl;
@useResult
$Res call({
 String groupId
});




}
/// @nodoc
class __$LoadFormationGroupCopyWithImpl<$Res>
    implements _$LoadFormationGroupCopyWith<$Res> {
  __$LoadFormationGroupCopyWithImpl(this._self, this._then);

  final _LoadFormationGroup _self;
  final $Res Function(_LoadFormationGroup) _then;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,}) {
  return _then(_LoadFormationGroup(
null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _InviteMember implements GooiFormationEvent {
  const _InviteMember({required this.inviteeUserId});
  

 final  String inviteeUserId;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteMemberCopyWith<_InviteMember> get copyWith => __$InviteMemberCopyWithImpl<_InviteMember>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteMember&&(identical(other.inviteeUserId, inviteeUserId) || other.inviteeUserId == inviteeUserId));
}


@override
int get hashCode => Object.hash(runtimeType,inviteeUserId);

@override
String toString() {
  return 'GooiFormationEvent.inviteMember(inviteeUserId: $inviteeUserId)';
}


}

/// @nodoc
abstract mixin class _$InviteMemberCopyWith<$Res> implements $GooiFormationEventCopyWith<$Res> {
  factory _$InviteMemberCopyWith(_InviteMember value, $Res Function(_InviteMember) _then) = __$InviteMemberCopyWithImpl;
@useResult
$Res call({
 String inviteeUserId
});




}
/// @nodoc
class __$InviteMemberCopyWithImpl<$Res>
    implements _$InviteMemberCopyWith<$Res> {
  __$InviteMemberCopyWithImpl(this._self, this._then);

  final _InviteMember _self;
  final $Res Function(_InviteMember) _then;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inviteeUserId = null,}) {
  return _then(_InviteMember(
inviteeUserId: null == inviteeUserId ? _self.inviteeUserId : inviteeUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RespondInvitation implements GooiFormationEvent {
  const _RespondInvitation({required this.groupId, required this.accept});
  

 final  String groupId;
 final  bool accept;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RespondInvitationCopyWith<_RespondInvitation> get copyWith => __$RespondInvitationCopyWithImpl<_RespondInvitation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RespondInvitation&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accept, accept) || other.accept == accept));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,accept);

@override
String toString() {
  return 'GooiFormationEvent.respondInvitation(groupId: $groupId, accept: $accept)';
}


}

/// @nodoc
abstract mixin class _$RespondInvitationCopyWith<$Res> implements $GooiFormationEventCopyWith<$Res> {
  factory _$RespondInvitationCopyWith(_RespondInvitation value, $Res Function(_RespondInvitation) _then) = __$RespondInvitationCopyWithImpl;
@useResult
$Res call({
 String groupId, bool accept
});




}
/// @nodoc
class __$RespondInvitationCopyWithImpl<$Res>
    implements _$RespondInvitationCopyWith<$Res> {
  __$RespondInvitationCopyWithImpl(this._self, this._then);

  final _RespondInvitation _self;
  final $Res Function(_RespondInvitation) _then;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? accept = null,}) {
  return _then(_RespondInvitation(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,accept: null == accept ? _self.accept : accept // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _LockRoster implements GooiFormationEvent {
  const _LockRoster({final  List<String>? proposedOrder}): _proposedOrder = proposedOrder;
  

 final  List<String>? _proposedOrder;
 List<String>? get proposedOrder {
  final value = _proposedOrder;
  if (value == null) return null;
  if (_proposedOrder is EqualUnmodifiableListView) return _proposedOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LockRosterCopyWith<_LockRoster> get copyWith => __$LockRosterCopyWithImpl<_LockRoster>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LockRoster&&const DeepCollectionEquality().equals(other._proposedOrder, _proposedOrder));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_proposedOrder));

@override
String toString() {
  return 'GooiFormationEvent.lockRoster(proposedOrder: $proposedOrder)';
}


}

/// @nodoc
abstract mixin class _$LockRosterCopyWith<$Res> implements $GooiFormationEventCopyWith<$Res> {
  factory _$LockRosterCopyWith(_LockRoster value, $Res Function(_LockRoster) _then) = __$LockRosterCopyWithImpl;
@useResult
$Res call({
 List<String>? proposedOrder
});




}
/// @nodoc
class __$LockRosterCopyWithImpl<$Res>
    implements _$LockRosterCopyWith<$Res> {
  __$LockRosterCopyWithImpl(this._self, this._then);

  final _LockRoster _self;
  final $Res Function(_LockRoster) _then;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? proposedOrder = freezed,}) {
  return _then(_LockRoster(
proposedOrder: freezed == proposedOrder ? _self._proposedOrder : proposedOrder // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

/// @nodoc


class _SubmitBid implements GooiFormationEvent {
  const _SubmitBid({required this.targetPosition, required this.bidPercent});
  

 final  int targetPosition;
 final  int bidPercent;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitBidCopyWith<_SubmitBid> get copyWith => __$SubmitBidCopyWithImpl<_SubmitBid>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitBid&&(identical(other.targetPosition, targetPosition) || other.targetPosition == targetPosition)&&(identical(other.bidPercent, bidPercent) || other.bidPercent == bidPercent));
}


@override
int get hashCode => Object.hash(runtimeType,targetPosition,bidPercent);

@override
String toString() {
  return 'GooiFormationEvent.submitBid(targetPosition: $targetPosition, bidPercent: $bidPercent)';
}


}

/// @nodoc
abstract mixin class _$SubmitBidCopyWith<$Res> implements $GooiFormationEventCopyWith<$Res> {
  factory _$SubmitBidCopyWith(_SubmitBid value, $Res Function(_SubmitBid) _then) = __$SubmitBidCopyWithImpl;
@useResult
$Res call({
 int targetPosition, int bidPercent
});




}
/// @nodoc
class __$SubmitBidCopyWithImpl<$Res>
    implements _$SubmitBidCopyWith<$Res> {
  __$SubmitBidCopyWithImpl(this._self, this._then);

  final _SubmitBid _self;
  final $Res Function(_SubmitBid) _then;

/// Create a copy of GooiFormationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? targetPosition = null,Object? bidPercent = null,}) {
  return _then(_SubmitBid(
targetPosition: null == targetPosition ? _self.targetPosition : targetPosition // ignore: cast_nullable_to_non_nullable
as int,bidPercent: null == bidPercent ? _self.bidPercent : bidPercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ConfirmActivation implements GooiFormationEvent {
  const _ConfirmActivation();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmActivation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiFormationEvent.confirmActivation()';
}


}




/// @nodoc


class _DissolveGroup implements GooiFormationEvent {
  const _DissolveGroup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DissolveGroup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GooiFormationEvent.dissolveGroup()';
}


}




/// @nodoc
mixin _$GooiFormationState {

 bool get isLoading; bool get isActionInProgress; GooiGroup? get group; List<GooiMember> get members; List<String> get rosterOrder; String? get createdGroupId; String? get errorMessage; String? get actionError; String? get actionSuccess;
/// Create a copy of GooiFormationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooiFormationStateCopyWith<GooiFormationState> get copyWith => _$GooiFormationStateCopyWithImpl<GooiFormationState>(this as GooiFormationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooiFormationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionInProgress, isActionInProgress) || other.isActionInProgress == isActionInProgress)&&(identical(other.group, group) || other.group == group)&&const DeepCollectionEquality().equals(other.members, members)&&const DeepCollectionEquality().equals(other.rosterOrder, rosterOrder)&&(identical(other.createdGroupId, createdGroupId) || other.createdGroupId == createdGroupId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.actionError, actionError) || other.actionError == actionError)&&(identical(other.actionSuccess, actionSuccess) || other.actionSuccess == actionSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isActionInProgress,group,const DeepCollectionEquality().hash(members),const DeepCollectionEquality().hash(rosterOrder),createdGroupId,errorMessage,actionError,actionSuccess);

@override
String toString() {
  return 'GooiFormationState(isLoading: $isLoading, isActionInProgress: $isActionInProgress, group: $group, members: $members, rosterOrder: $rosterOrder, createdGroupId: $createdGroupId, errorMessage: $errorMessage, actionError: $actionError, actionSuccess: $actionSuccess)';
}


}

/// @nodoc
abstract mixin class $GooiFormationStateCopyWith<$Res>  {
  factory $GooiFormationStateCopyWith(GooiFormationState value, $Res Function(GooiFormationState) _then) = _$GooiFormationStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isActionInProgress, GooiGroup? group, List<GooiMember> members, List<String> rosterOrder, String? createdGroupId, String? errorMessage, String? actionError, String? actionSuccess
});


$GooiGroupCopyWith<$Res>? get group;

}
/// @nodoc
class _$GooiFormationStateCopyWithImpl<$Res>
    implements $GooiFormationStateCopyWith<$Res> {
  _$GooiFormationStateCopyWithImpl(this._self, this._then);

  final GooiFormationState _self;
  final $Res Function(GooiFormationState) _then;

/// Create a copy of GooiFormationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isActionInProgress = null,Object? group = freezed,Object? members = null,Object? rosterOrder = null,Object? createdGroupId = freezed,Object? errorMessage = freezed,Object? actionError = freezed,Object? actionSuccess = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionInProgress: null == isActionInProgress ? _self.isActionInProgress : isActionInProgress // ignore: cast_nullable_to_non_nullable
as bool,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as GooiGroup?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<GooiMember>,rosterOrder: null == rosterOrder ? _self.rosterOrder : rosterOrder // ignore: cast_nullable_to_non_nullable
as List<String>,createdGroupId: freezed == createdGroupId ? _self.createdGroupId : createdGroupId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,actionSuccess: freezed == actionSuccess ? _self.actionSuccess : actionSuccess // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GooiFormationState
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
}
}


/// Adds pattern-matching-related methods to [GooiFormationState].
extension GooiFormationStatePatterns on GooiFormationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GooiFormationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GooiFormationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GooiFormationState value)  $default,){
final _that = this;
switch (_that) {
case _GooiFormationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GooiFormationState value)?  $default,){
final _that = this;
switch (_that) {
case _GooiFormationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isActionInProgress,  GooiGroup? group,  List<GooiMember> members,  List<String> rosterOrder,  String? createdGroupId,  String? errorMessage,  String? actionError,  String? actionSuccess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GooiFormationState() when $default != null:
return $default(_that.isLoading,_that.isActionInProgress,_that.group,_that.members,_that.rosterOrder,_that.createdGroupId,_that.errorMessage,_that.actionError,_that.actionSuccess);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isActionInProgress,  GooiGroup? group,  List<GooiMember> members,  List<String> rosterOrder,  String? createdGroupId,  String? errorMessage,  String? actionError,  String? actionSuccess)  $default,) {final _that = this;
switch (_that) {
case _GooiFormationState():
return $default(_that.isLoading,_that.isActionInProgress,_that.group,_that.members,_that.rosterOrder,_that.createdGroupId,_that.errorMessage,_that.actionError,_that.actionSuccess);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isActionInProgress,  GooiGroup? group,  List<GooiMember> members,  List<String> rosterOrder,  String? createdGroupId,  String? errorMessage,  String? actionError,  String? actionSuccess)?  $default,) {final _that = this;
switch (_that) {
case _GooiFormationState() when $default != null:
return $default(_that.isLoading,_that.isActionInProgress,_that.group,_that.members,_that.rosterOrder,_that.createdGroupId,_that.errorMessage,_that.actionError,_that.actionSuccess);case _:
  return null;

}
}

}

/// @nodoc


class _GooiFormationState implements GooiFormationState {
  const _GooiFormationState({this.isLoading = false, this.isActionInProgress = false, this.group, final  List<GooiMember> members = const [], final  List<String> rosterOrder = const [], this.createdGroupId, this.errorMessage, this.actionError, this.actionSuccess}): _members = members,_rosterOrder = rosterOrder;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isActionInProgress;
@override final  GooiGroup? group;
 final  List<GooiMember> _members;
@override@JsonKey() List<GooiMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

 final  List<String> _rosterOrder;
@override@JsonKey() List<String> get rosterOrder {
  if (_rosterOrder is EqualUnmodifiableListView) return _rosterOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rosterOrder);
}

@override final  String? createdGroupId;
@override final  String? errorMessage;
@override final  String? actionError;
@override final  String? actionSuccess;

/// Create a copy of GooiFormationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooiFormationStateCopyWith<_GooiFormationState> get copyWith => __$GooiFormationStateCopyWithImpl<_GooiFormationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooiFormationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isActionInProgress, isActionInProgress) || other.isActionInProgress == isActionInProgress)&&(identical(other.group, group) || other.group == group)&&const DeepCollectionEquality().equals(other._members, _members)&&const DeepCollectionEquality().equals(other._rosterOrder, _rosterOrder)&&(identical(other.createdGroupId, createdGroupId) || other.createdGroupId == createdGroupId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.actionError, actionError) || other.actionError == actionError)&&(identical(other.actionSuccess, actionSuccess) || other.actionSuccess == actionSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isActionInProgress,group,const DeepCollectionEquality().hash(_members),const DeepCollectionEquality().hash(_rosterOrder),createdGroupId,errorMessage,actionError,actionSuccess);

@override
String toString() {
  return 'GooiFormationState(isLoading: $isLoading, isActionInProgress: $isActionInProgress, group: $group, members: $members, rosterOrder: $rosterOrder, createdGroupId: $createdGroupId, errorMessage: $errorMessage, actionError: $actionError, actionSuccess: $actionSuccess)';
}


}

/// @nodoc
abstract mixin class _$GooiFormationStateCopyWith<$Res> implements $GooiFormationStateCopyWith<$Res> {
  factory _$GooiFormationStateCopyWith(_GooiFormationState value, $Res Function(_GooiFormationState) _then) = __$GooiFormationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isActionInProgress, GooiGroup? group, List<GooiMember> members, List<String> rosterOrder, String? createdGroupId, String? errorMessage, String? actionError, String? actionSuccess
});


@override $GooiGroupCopyWith<$Res>? get group;

}
/// @nodoc
class __$GooiFormationStateCopyWithImpl<$Res>
    implements _$GooiFormationStateCopyWith<$Res> {
  __$GooiFormationStateCopyWithImpl(this._self, this._then);

  final _GooiFormationState _self;
  final $Res Function(_GooiFormationState) _then;

/// Create a copy of GooiFormationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isActionInProgress = null,Object? group = freezed,Object? members = null,Object? rosterOrder = null,Object? createdGroupId = freezed,Object? errorMessage = freezed,Object? actionError = freezed,Object? actionSuccess = freezed,}) {
  return _then(_GooiFormationState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isActionInProgress: null == isActionInProgress ? _self.isActionInProgress : isActionInProgress // ignore: cast_nullable_to_non_nullable
as bool,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as GooiGroup?,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<GooiMember>,rosterOrder: null == rosterOrder ? _self._rosterOrder : rosterOrder // ignore: cast_nullable_to_non_nullable
as List<String>,createdGroupId: freezed == createdGroupId ? _self.createdGroupId : createdGroupId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,actionSuccess: freezed == actionSuccess ? _self.actionSuccess : actionSuccess // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GooiFormationState
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
}
}

// dart format on
