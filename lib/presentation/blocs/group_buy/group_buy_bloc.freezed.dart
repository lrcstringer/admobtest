// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_buy_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupBuyEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupBuyEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupBuyEvent()';
}


}

/// @nodoc
class $GroupBuyEventCopyWith<$Res>  {
$GroupBuyEventCopyWith(GroupBuyEvent _, $Res Function(GroupBuyEvent) __);
}


/// Adds pattern-matching-related methods to [GroupBuyEvent].
extension GroupBuyEventPatterns on GroupBuyEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadActiveGroupBuys value)?  loadActiveGroupBuys,TResult Function( _LoadGroupBuy value)?  loadGroupBuy,TResult Function( _LoadMyGroupBuys value)?  loadMyGroupBuys,TResult Function( _CreateGroupBuy value)?  createGroupBuy,TResult Function( _JoinGroupBuy value)?  joinGroupBuy,TResult Function( _LoadHubGroupBuys value)?  loadHubGroupBuys,TResult Function( _LeaveGroupBuy value)?  leaveGroupBuy,TResult Function( _SuggestDeal value)?  suggestDeal,TResult Function( _ClearMessages value)?  clearMessages,TResult Function( _ConfirmCollection value)?  confirmCollection,TResult Function( _CancelGroupBuy value)?  cancelGroupBuy,TResult Function( _UpdateDeliveryStatus value)?  updateDeliveryStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadActiveGroupBuys() when loadActiveGroupBuys != null:
return loadActiveGroupBuys(_that);case _LoadGroupBuy() when loadGroupBuy != null:
return loadGroupBuy(_that);case _LoadMyGroupBuys() when loadMyGroupBuys != null:
return loadMyGroupBuys(_that);case _CreateGroupBuy() when createGroupBuy != null:
return createGroupBuy(_that);case _JoinGroupBuy() when joinGroupBuy != null:
return joinGroupBuy(_that);case _LoadHubGroupBuys() when loadHubGroupBuys != null:
return loadHubGroupBuys(_that);case _LeaveGroupBuy() when leaveGroupBuy != null:
return leaveGroupBuy(_that);case _SuggestDeal() when suggestDeal != null:
return suggestDeal(_that);case _ClearMessages() when clearMessages != null:
return clearMessages(_that);case _ConfirmCollection() when confirmCollection != null:
return confirmCollection(_that);case _CancelGroupBuy() when cancelGroupBuy != null:
return cancelGroupBuy(_that);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadActiveGroupBuys value)  loadActiveGroupBuys,required TResult Function( _LoadGroupBuy value)  loadGroupBuy,required TResult Function( _LoadMyGroupBuys value)  loadMyGroupBuys,required TResult Function( _CreateGroupBuy value)  createGroupBuy,required TResult Function( _JoinGroupBuy value)  joinGroupBuy,required TResult Function( _LoadHubGroupBuys value)  loadHubGroupBuys,required TResult Function( _LeaveGroupBuy value)  leaveGroupBuy,required TResult Function( _SuggestDeal value)  suggestDeal,required TResult Function( _ClearMessages value)  clearMessages,required TResult Function( _ConfirmCollection value)  confirmCollection,required TResult Function( _CancelGroupBuy value)  cancelGroupBuy,required TResult Function( _UpdateDeliveryStatus value)  updateDeliveryStatus,}){
final _that = this;
switch (_that) {
case _LoadActiveGroupBuys():
return loadActiveGroupBuys(_that);case _LoadGroupBuy():
return loadGroupBuy(_that);case _LoadMyGroupBuys():
return loadMyGroupBuys(_that);case _CreateGroupBuy():
return createGroupBuy(_that);case _JoinGroupBuy():
return joinGroupBuy(_that);case _LoadHubGroupBuys():
return loadHubGroupBuys(_that);case _LeaveGroupBuy():
return leaveGroupBuy(_that);case _SuggestDeal():
return suggestDeal(_that);case _ClearMessages():
return clearMessages(_that);case _ConfirmCollection():
return confirmCollection(_that);case _CancelGroupBuy():
return cancelGroupBuy(_that);case _UpdateDeliveryStatus():
return updateDeliveryStatus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadActiveGroupBuys value)?  loadActiveGroupBuys,TResult? Function( _LoadGroupBuy value)?  loadGroupBuy,TResult? Function( _LoadMyGroupBuys value)?  loadMyGroupBuys,TResult? Function( _CreateGroupBuy value)?  createGroupBuy,TResult? Function( _JoinGroupBuy value)?  joinGroupBuy,TResult? Function( _LoadHubGroupBuys value)?  loadHubGroupBuys,TResult? Function( _LeaveGroupBuy value)?  leaveGroupBuy,TResult? Function( _SuggestDeal value)?  suggestDeal,TResult? Function( _ClearMessages value)?  clearMessages,TResult? Function( _ConfirmCollection value)?  confirmCollection,TResult? Function( _CancelGroupBuy value)?  cancelGroupBuy,TResult? Function( _UpdateDeliveryStatus value)?  updateDeliveryStatus,}){
final _that = this;
switch (_that) {
case _LoadActiveGroupBuys() when loadActiveGroupBuys != null:
return loadActiveGroupBuys(_that);case _LoadGroupBuy() when loadGroupBuy != null:
return loadGroupBuy(_that);case _LoadMyGroupBuys() when loadMyGroupBuys != null:
return loadMyGroupBuys(_that);case _CreateGroupBuy() when createGroupBuy != null:
return createGroupBuy(_that);case _JoinGroupBuy() when joinGroupBuy != null:
return joinGroupBuy(_that);case _LoadHubGroupBuys() when loadHubGroupBuys != null:
return loadHubGroupBuys(_that);case _LeaveGroupBuy() when leaveGroupBuy != null:
return leaveGroupBuy(_that);case _SuggestDeal() when suggestDeal != null:
return suggestDeal(_that);case _ClearMessages() when clearMessages != null:
return clearMessages(_that);case _ConfirmCollection() when confirmCollection != null:
return confirmCollection(_that);case _CancelGroupBuy() when cancelGroupBuy != null:
return cancelGroupBuy(_that);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? communityId)?  loadActiveGroupBuys,TResult Function( String id)?  loadGroupBuy,TResult Function()?  loadMyGroupBuys,TResult Function( String title,  String description,  int targetAmount,  DateTime deadline,  String? linkedListingId,  int minParticipants,  int? maxParticipants)?  createGroupBuy,TResult Function( String groupBuyId,  int amount,  String walletId)?  joinGroupBuy,TResult Function( List<String> userClusters)?  loadHubGroupBuys,TResult Function( String groupBuyId)?  leaveGroupBuy,TResult Function( String description,  String brandOrStore,  int? estimatedPrice,  String? sourceUrl,  String? imageUrl,  bool wantsToJoin)?  suggestDeal,TResult Function()?  clearMessages,TResult Function( String groupBuyId,  String contributionId)?  confirmCollection,TResult Function( String groupBuyId,  String? reason)?  cancelGroupBuy,TResult Function( String groupBuyId,  String deliveryStatus,  String? trackingInfo)?  updateDeliveryStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadActiveGroupBuys() when loadActiveGroupBuys != null:
return loadActiveGroupBuys(_that.communityId);case _LoadGroupBuy() when loadGroupBuy != null:
return loadGroupBuy(_that.id);case _LoadMyGroupBuys() when loadMyGroupBuys != null:
return loadMyGroupBuys();case _CreateGroupBuy() when createGroupBuy != null:
return createGroupBuy(_that.title,_that.description,_that.targetAmount,_that.deadline,_that.linkedListingId,_that.minParticipants,_that.maxParticipants);case _JoinGroupBuy() when joinGroupBuy != null:
return joinGroupBuy(_that.groupBuyId,_that.amount,_that.walletId);case _LoadHubGroupBuys() when loadHubGroupBuys != null:
return loadHubGroupBuys(_that.userClusters);case _LeaveGroupBuy() when leaveGroupBuy != null:
return leaveGroupBuy(_that.groupBuyId);case _SuggestDeal() when suggestDeal != null:
return suggestDeal(_that.description,_that.brandOrStore,_that.estimatedPrice,_that.sourceUrl,_that.imageUrl,_that.wantsToJoin);case _ClearMessages() when clearMessages != null:
return clearMessages();case _ConfirmCollection() when confirmCollection != null:
return confirmCollection(_that.groupBuyId,_that.contributionId);case _CancelGroupBuy() when cancelGroupBuy != null:
return cancelGroupBuy(_that.groupBuyId,_that.reason);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that.groupBuyId,_that.deliveryStatus,_that.trackingInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? communityId)  loadActiveGroupBuys,required TResult Function( String id)  loadGroupBuy,required TResult Function()  loadMyGroupBuys,required TResult Function( String title,  String description,  int targetAmount,  DateTime deadline,  String? linkedListingId,  int minParticipants,  int? maxParticipants)  createGroupBuy,required TResult Function( String groupBuyId,  int amount,  String walletId)  joinGroupBuy,required TResult Function( List<String> userClusters)  loadHubGroupBuys,required TResult Function( String groupBuyId)  leaveGroupBuy,required TResult Function( String description,  String brandOrStore,  int? estimatedPrice,  String? sourceUrl,  String? imageUrl,  bool wantsToJoin)  suggestDeal,required TResult Function()  clearMessages,required TResult Function( String groupBuyId,  String contributionId)  confirmCollection,required TResult Function( String groupBuyId,  String? reason)  cancelGroupBuy,required TResult Function( String groupBuyId,  String deliveryStatus,  String? trackingInfo)  updateDeliveryStatus,}) {final _that = this;
switch (_that) {
case _LoadActiveGroupBuys():
return loadActiveGroupBuys(_that.communityId);case _LoadGroupBuy():
return loadGroupBuy(_that.id);case _LoadMyGroupBuys():
return loadMyGroupBuys();case _CreateGroupBuy():
return createGroupBuy(_that.title,_that.description,_that.targetAmount,_that.deadline,_that.linkedListingId,_that.minParticipants,_that.maxParticipants);case _JoinGroupBuy():
return joinGroupBuy(_that.groupBuyId,_that.amount,_that.walletId);case _LoadHubGroupBuys():
return loadHubGroupBuys(_that.userClusters);case _LeaveGroupBuy():
return leaveGroupBuy(_that.groupBuyId);case _SuggestDeal():
return suggestDeal(_that.description,_that.brandOrStore,_that.estimatedPrice,_that.sourceUrl,_that.imageUrl,_that.wantsToJoin);case _ClearMessages():
return clearMessages();case _ConfirmCollection():
return confirmCollection(_that.groupBuyId,_that.contributionId);case _CancelGroupBuy():
return cancelGroupBuy(_that.groupBuyId,_that.reason);case _UpdateDeliveryStatus():
return updateDeliveryStatus(_that.groupBuyId,_that.deliveryStatus,_that.trackingInfo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? communityId)?  loadActiveGroupBuys,TResult? Function( String id)?  loadGroupBuy,TResult? Function()?  loadMyGroupBuys,TResult? Function( String title,  String description,  int targetAmount,  DateTime deadline,  String? linkedListingId,  int minParticipants,  int? maxParticipants)?  createGroupBuy,TResult? Function( String groupBuyId,  int amount,  String walletId)?  joinGroupBuy,TResult? Function( List<String> userClusters)?  loadHubGroupBuys,TResult? Function( String groupBuyId)?  leaveGroupBuy,TResult? Function( String description,  String brandOrStore,  int? estimatedPrice,  String? sourceUrl,  String? imageUrl,  bool wantsToJoin)?  suggestDeal,TResult? Function()?  clearMessages,TResult? Function( String groupBuyId,  String contributionId)?  confirmCollection,TResult? Function( String groupBuyId,  String? reason)?  cancelGroupBuy,TResult? Function( String groupBuyId,  String deliveryStatus,  String? trackingInfo)?  updateDeliveryStatus,}) {final _that = this;
switch (_that) {
case _LoadActiveGroupBuys() when loadActiveGroupBuys != null:
return loadActiveGroupBuys(_that.communityId);case _LoadGroupBuy() when loadGroupBuy != null:
return loadGroupBuy(_that.id);case _LoadMyGroupBuys() when loadMyGroupBuys != null:
return loadMyGroupBuys();case _CreateGroupBuy() when createGroupBuy != null:
return createGroupBuy(_that.title,_that.description,_that.targetAmount,_that.deadline,_that.linkedListingId,_that.minParticipants,_that.maxParticipants);case _JoinGroupBuy() when joinGroupBuy != null:
return joinGroupBuy(_that.groupBuyId,_that.amount,_that.walletId);case _LoadHubGroupBuys() when loadHubGroupBuys != null:
return loadHubGroupBuys(_that.userClusters);case _LeaveGroupBuy() when leaveGroupBuy != null:
return leaveGroupBuy(_that.groupBuyId);case _SuggestDeal() when suggestDeal != null:
return suggestDeal(_that.description,_that.brandOrStore,_that.estimatedPrice,_that.sourceUrl,_that.imageUrl,_that.wantsToJoin);case _ClearMessages() when clearMessages != null:
return clearMessages();case _ConfirmCollection() when confirmCollection != null:
return confirmCollection(_that.groupBuyId,_that.contributionId);case _CancelGroupBuy() when cancelGroupBuy != null:
return cancelGroupBuy(_that.groupBuyId,_that.reason);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that.groupBuyId,_that.deliveryStatus,_that.trackingInfo);case _:
  return null;

}
}

}

/// @nodoc


class _LoadActiveGroupBuys implements GroupBuyEvent {
  const _LoadActiveGroupBuys({this.communityId});
  

 final  String? communityId;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadActiveGroupBuysCopyWith<_LoadActiveGroupBuys> get copyWith => __$LoadActiveGroupBuysCopyWithImpl<_LoadActiveGroupBuys>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadActiveGroupBuys&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,communityId);

@override
String toString() {
  return 'GroupBuyEvent.loadActiveGroupBuys(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$LoadActiveGroupBuysCopyWith<$Res> implements $GroupBuyEventCopyWith<$Res> {
  factory _$LoadActiveGroupBuysCopyWith(_LoadActiveGroupBuys value, $Res Function(_LoadActiveGroupBuys) _then) = __$LoadActiveGroupBuysCopyWithImpl;
@useResult
$Res call({
 String? communityId
});




}
/// @nodoc
class __$LoadActiveGroupBuysCopyWithImpl<$Res>
    implements _$LoadActiveGroupBuysCopyWith<$Res> {
  __$LoadActiveGroupBuysCopyWithImpl(this._self, this._then);

  final _LoadActiveGroupBuys _self;
  final $Res Function(_LoadActiveGroupBuys) _then;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = freezed,}) {
  return _then(_LoadActiveGroupBuys(
communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadGroupBuy implements GroupBuyEvent {
  const _LoadGroupBuy(this.id);
  

 final  String id;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadGroupBuyCopyWith<_LoadGroupBuy> get copyWith => __$LoadGroupBuyCopyWithImpl<_LoadGroupBuy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadGroupBuy&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'GroupBuyEvent.loadGroupBuy(id: $id)';
}


}

/// @nodoc
abstract mixin class _$LoadGroupBuyCopyWith<$Res> implements $GroupBuyEventCopyWith<$Res> {
  factory _$LoadGroupBuyCopyWith(_LoadGroupBuy value, $Res Function(_LoadGroupBuy) _then) = __$LoadGroupBuyCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$LoadGroupBuyCopyWithImpl<$Res>
    implements _$LoadGroupBuyCopyWith<$Res> {
  __$LoadGroupBuyCopyWithImpl(this._self, this._then);

  final _LoadGroupBuy _self;
  final $Res Function(_LoadGroupBuy) _then;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_LoadGroupBuy(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadMyGroupBuys implements GroupBuyEvent {
  const _LoadMyGroupBuys();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMyGroupBuys);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupBuyEvent.loadMyGroupBuys()';
}


}




/// @nodoc


class _CreateGroupBuy implements GroupBuyEvent {
  const _CreateGroupBuy({required this.title, required this.description, required this.targetAmount, required this.deadline, this.linkedListingId, this.minParticipants = 2, this.maxParticipants});
  

 final  String title;
 final  String description;
 final  int targetAmount;
 final  DateTime deadline;
 final  String? linkedListingId;
@JsonKey() final  int minParticipants;
 final  int? maxParticipants;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateGroupBuyCopyWith<_CreateGroupBuy> get copyWith => __$CreateGroupBuyCopyWithImpl<_CreateGroupBuy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateGroupBuy&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.linkedListingId, linkedListingId) || other.linkedListingId == linkedListingId)&&(identical(other.minParticipants, minParticipants) || other.minParticipants == minParticipants)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,targetAmount,deadline,linkedListingId,minParticipants,maxParticipants);

@override
String toString() {
  return 'GroupBuyEvent.createGroupBuy(title: $title, description: $description, targetAmount: $targetAmount, deadline: $deadline, linkedListingId: $linkedListingId, minParticipants: $minParticipants, maxParticipants: $maxParticipants)';
}


}

/// @nodoc
abstract mixin class _$CreateGroupBuyCopyWith<$Res> implements $GroupBuyEventCopyWith<$Res> {
  factory _$CreateGroupBuyCopyWith(_CreateGroupBuy value, $Res Function(_CreateGroupBuy) _then) = __$CreateGroupBuyCopyWithImpl;
@useResult
$Res call({
 String title, String description, int targetAmount, DateTime deadline, String? linkedListingId, int minParticipants, int? maxParticipants
});




}
/// @nodoc
class __$CreateGroupBuyCopyWithImpl<$Res>
    implements _$CreateGroupBuyCopyWith<$Res> {
  __$CreateGroupBuyCopyWithImpl(this._self, this._then);

  final _CreateGroupBuy _self;
  final $Res Function(_CreateGroupBuy) _then;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? targetAmount = null,Object? deadline = null,Object? linkedListingId = freezed,Object? minParticipants = null,Object? maxParticipants = freezed,}) {
  return _then(_CreateGroupBuy(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,targetAmount: null == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as int,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime,linkedListingId: freezed == linkedListingId ? _self.linkedListingId : linkedListingId // ignore: cast_nullable_to_non_nullable
as String?,minParticipants: null == minParticipants ? _self.minParticipants : minParticipants // ignore: cast_nullable_to_non_nullable
as int,maxParticipants: freezed == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _JoinGroupBuy implements GroupBuyEvent {
  const _JoinGroupBuy({required this.groupBuyId, required this.amount, required this.walletId});
  

 final  String groupBuyId;
 final  int amount;
 final  String walletId;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinGroupBuyCopyWith<_JoinGroupBuy> get copyWith => __$JoinGroupBuyCopyWithImpl<_JoinGroupBuy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinGroupBuy&&(identical(other.groupBuyId, groupBuyId) || other.groupBuyId == groupBuyId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.walletId, walletId) || other.walletId == walletId));
}


@override
int get hashCode => Object.hash(runtimeType,groupBuyId,amount,walletId);

@override
String toString() {
  return 'GroupBuyEvent.joinGroupBuy(groupBuyId: $groupBuyId, amount: $amount, walletId: $walletId)';
}


}

/// @nodoc
abstract mixin class _$JoinGroupBuyCopyWith<$Res> implements $GroupBuyEventCopyWith<$Res> {
  factory _$JoinGroupBuyCopyWith(_JoinGroupBuy value, $Res Function(_JoinGroupBuy) _then) = __$JoinGroupBuyCopyWithImpl;
@useResult
$Res call({
 String groupBuyId, int amount, String walletId
});




}
/// @nodoc
class __$JoinGroupBuyCopyWithImpl<$Res>
    implements _$JoinGroupBuyCopyWith<$Res> {
  __$JoinGroupBuyCopyWithImpl(this._self, this._then);

  final _JoinGroupBuy _self;
  final $Res Function(_JoinGroupBuy) _then;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupBuyId = null,Object? amount = null,Object? walletId = null,}) {
  return _then(_JoinGroupBuy(
groupBuyId: null == groupBuyId ? _self.groupBuyId : groupBuyId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,walletId: null == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadHubGroupBuys implements GroupBuyEvent {
  const _LoadHubGroupBuys({final  List<String> userClusters = const []}): _userClusters = userClusters;
  

 final  List<String> _userClusters;
@JsonKey() List<String> get userClusters {
  if (_userClusters is EqualUnmodifiableListView) return _userClusters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userClusters);
}


/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadHubGroupBuysCopyWith<_LoadHubGroupBuys> get copyWith => __$LoadHubGroupBuysCopyWithImpl<_LoadHubGroupBuys>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadHubGroupBuys&&const DeepCollectionEquality().equals(other._userClusters, _userClusters));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_userClusters));

@override
String toString() {
  return 'GroupBuyEvent.loadHubGroupBuys(userClusters: $userClusters)';
}


}

/// @nodoc
abstract mixin class _$LoadHubGroupBuysCopyWith<$Res> implements $GroupBuyEventCopyWith<$Res> {
  factory _$LoadHubGroupBuysCopyWith(_LoadHubGroupBuys value, $Res Function(_LoadHubGroupBuys) _then) = __$LoadHubGroupBuysCopyWithImpl;
@useResult
$Res call({
 List<String> userClusters
});




}
/// @nodoc
class __$LoadHubGroupBuysCopyWithImpl<$Res>
    implements _$LoadHubGroupBuysCopyWith<$Res> {
  __$LoadHubGroupBuysCopyWithImpl(this._self, this._then);

  final _LoadHubGroupBuys _self;
  final $Res Function(_LoadHubGroupBuys) _then;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userClusters = null,}) {
  return _then(_LoadHubGroupBuys(
userClusters: null == userClusters ? _self._userClusters : userClusters // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _LeaveGroupBuy implements GroupBuyEvent {
  const _LeaveGroupBuy({required this.groupBuyId});
  

 final  String groupBuyId;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveGroupBuyCopyWith<_LeaveGroupBuy> get copyWith => __$LeaveGroupBuyCopyWithImpl<_LeaveGroupBuy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveGroupBuy&&(identical(other.groupBuyId, groupBuyId) || other.groupBuyId == groupBuyId));
}


@override
int get hashCode => Object.hash(runtimeType,groupBuyId);

@override
String toString() {
  return 'GroupBuyEvent.leaveGroupBuy(groupBuyId: $groupBuyId)';
}


}

/// @nodoc
abstract mixin class _$LeaveGroupBuyCopyWith<$Res> implements $GroupBuyEventCopyWith<$Res> {
  factory _$LeaveGroupBuyCopyWith(_LeaveGroupBuy value, $Res Function(_LeaveGroupBuy) _then) = __$LeaveGroupBuyCopyWithImpl;
@useResult
$Res call({
 String groupBuyId
});




}
/// @nodoc
class __$LeaveGroupBuyCopyWithImpl<$Res>
    implements _$LeaveGroupBuyCopyWith<$Res> {
  __$LeaveGroupBuyCopyWithImpl(this._self, this._then);

  final _LeaveGroupBuy _self;
  final $Res Function(_LeaveGroupBuy) _then;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupBuyId = null,}) {
  return _then(_LeaveGroupBuy(
groupBuyId: null == groupBuyId ? _self.groupBuyId : groupBuyId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SuggestDeal implements GroupBuyEvent {
  const _SuggestDeal({required this.description, required this.brandOrStore, this.estimatedPrice, this.sourceUrl, this.imageUrl, this.wantsToJoin = true});
  

 final  String description;
 final  String brandOrStore;
 final  int? estimatedPrice;
 final  String? sourceUrl;
 final  String? imageUrl;
@JsonKey() final  bool wantsToJoin;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuggestDealCopyWith<_SuggestDeal> get copyWith => __$SuggestDealCopyWithImpl<_SuggestDeal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuggestDeal&&(identical(other.description, description) || other.description == description)&&(identical(other.brandOrStore, brandOrStore) || other.brandOrStore == brandOrStore)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.wantsToJoin, wantsToJoin) || other.wantsToJoin == wantsToJoin));
}


@override
int get hashCode => Object.hash(runtimeType,description,brandOrStore,estimatedPrice,sourceUrl,imageUrl,wantsToJoin);

@override
String toString() {
  return 'GroupBuyEvent.suggestDeal(description: $description, brandOrStore: $brandOrStore, estimatedPrice: $estimatedPrice, sourceUrl: $sourceUrl, imageUrl: $imageUrl, wantsToJoin: $wantsToJoin)';
}


}

/// @nodoc
abstract mixin class _$SuggestDealCopyWith<$Res> implements $GroupBuyEventCopyWith<$Res> {
  factory _$SuggestDealCopyWith(_SuggestDeal value, $Res Function(_SuggestDeal) _then) = __$SuggestDealCopyWithImpl;
@useResult
$Res call({
 String description, String brandOrStore, int? estimatedPrice, String? sourceUrl, String? imageUrl, bool wantsToJoin
});




}
/// @nodoc
class __$SuggestDealCopyWithImpl<$Res>
    implements _$SuggestDealCopyWith<$Res> {
  __$SuggestDealCopyWithImpl(this._self, this._then);

  final _SuggestDeal _self;
  final $Res Function(_SuggestDeal) _then;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? description = null,Object? brandOrStore = null,Object? estimatedPrice = freezed,Object? sourceUrl = freezed,Object? imageUrl = freezed,Object? wantsToJoin = null,}) {
  return _then(_SuggestDeal(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,brandOrStore: null == brandOrStore ? _self.brandOrStore : brandOrStore // ignore: cast_nullable_to_non_nullable
as String,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as int?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,wantsToJoin: null == wantsToJoin ? _self.wantsToJoin : wantsToJoin // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ClearMessages implements GroupBuyEvent {
  const _ClearMessages();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearMessages);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupBuyEvent.clearMessages()';
}


}




/// @nodoc


class _ConfirmCollection implements GroupBuyEvent {
  const _ConfirmCollection({required this.groupBuyId, required this.contributionId});
  

 final  String groupBuyId;
 final  String contributionId;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmCollectionCopyWith<_ConfirmCollection> get copyWith => __$ConfirmCollectionCopyWithImpl<_ConfirmCollection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmCollection&&(identical(other.groupBuyId, groupBuyId) || other.groupBuyId == groupBuyId)&&(identical(other.contributionId, contributionId) || other.contributionId == contributionId));
}


@override
int get hashCode => Object.hash(runtimeType,groupBuyId,contributionId);

@override
String toString() {
  return 'GroupBuyEvent.confirmCollection(groupBuyId: $groupBuyId, contributionId: $contributionId)';
}


}

/// @nodoc
abstract mixin class _$ConfirmCollectionCopyWith<$Res> implements $GroupBuyEventCopyWith<$Res> {
  factory _$ConfirmCollectionCopyWith(_ConfirmCollection value, $Res Function(_ConfirmCollection) _then) = __$ConfirmCollectionCopyWithImpl;
@useResult
$Res call({
 String groupBuyId, String contributionId
});




}
/// @nodoc
class __$ConfirmCollectionCopyWithImpl<$Res>
    implements _$ConfirmCollectionCopyWith<$Res> {
  __$ConfirmCollectionCopyWithImpl(this._self, this._then);

  final _ConfirmCollection _self;
  final $Res Function(_ConfirmCollection) _then;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupBuyId = null,Object? contributionId = null,}) {
  return _then(_ConfirmCollection(
groupBuyId: null == groupBuyId ? _self.groupBuyId : groupBuyId // ignore: cast_nullable_to_non_nullable
as String,contributionId: null == contributionId ? _self.contributionId : contributionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CancelGroupBuy implements GroupBuyEvent {
  const _CancelGroupBuy({required this.groupBuyId, this.reason});
  

 final  String groupBuyId;
 final  String? reason;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelGroupBuyCopyWith<_CancelGroupBuy> get copyWith => __$CancelGroupBuyCopyWithImpl<_CancelGroupBuy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelGroupBuy&&(identical(other.groupBuyId, groupBuyId) || other.groupBuyId == groupBuyId)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,groupBuyId,reason);

@override
String toString() {
  return 'GroupBuyEvent.cancelGroupBuy(groupBuyId: $groupBuyId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CancelGroupBuyCopyWith<$Res> implements $GroupBuyEventCopyWith<$Res> {
  factory _$CancelGroupBuyCopyWith(_CancelGroupBuy value, $Res Function(_CancelGroupBuy) _then) = __$CancelGroupBuyCopyWithImpl;
@useResult
$Res call({
 String groupBuyId, String? reason
});




}
/// @nodoc
class __$CancelGroupBuyCopyWithImpl<$Res>
    implements _$CancelGroupBuyCopyWith<$Res> {
  __$CancelGroupBuyCopyWithImpl(this._self, this._then);

  final _CancelGroupBuy _self;
  final $Res Function(_CancelGroupBuy) _then;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupBuyId = null,Object? reason = freezed,}) {
  return _then(_CancelGroupBuy(
groupBuyId: null == groupBuyId ? _self.groupBuyId : groupBuyId // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _UpdateDeliveryStatus implements GroupBuyEvent {
  const _UpdateDeliveryStatus({required this.groupBuyId, required this.deliveryStatus, this.trackingInfo});
  

 final  String groupBuyId;
 final  String deliveryStatus;
 final  String? trackingInfo;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDeliveryStatusCopyWith<_UpdateDeliveryStatus> get copyWith => __$UpdateDeliveryStatusCopyWithImpl<_UpdateDeliveryStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateDeliveryStatus&&(identical(other.groupBuyId, groupBuyId) || other.groupBuyId == groupBuyId)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&(identical(other.trackingInfo, trackingInfo) || other.trackingInfo == trackingInfo));
}


@override
int get hashCode => Object.hash(runtimeType,groupBuyId,deliveryStatus,trackingInfo);

@override
String toString() {
  return 'GroupBuyEvent.updateDeliveryStatus(groupBuyId: $groupBuyId, deliveryStatus: $deliveryStatus, trackingInfo: $trackingInfo)';
}


}

/// @nodoc
abstract mixin class _$UpdateDeliveryStatusCopyWith<$Res> implements $GroupBuyEventCopyWith<$Res> {
  factory _$UpdateDeliveryStatusCopyWith(_UpdateDeliveryStatus value, $Res Function(_UpdateDeliveryStatus) _then) = __$UpdateDeliveryStatusCopyWithImpl;
@useResult
$Res call({
 String groupBuyId, String deliveryStatus, String? trackingInfo
});




}
/// @nodoc
class __$UpdateDeliveryStatusCopyWithImpl<$Res>
    implements _$UpdateDeliveryStatusCopyWith<$Res> {
  __$UpdateDeliveryStatusCopyWithImpl(this._self, this._then);

  final _UpdateDeliveryStatus _self;
  final $Res Function(_UpdateDeliveryStatus) _then;

/// Create a copy of GroupBuyEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupBuyId = null,Object? deliveryStatus = null,Object? trackingInfo = freezed,}) {
  return _then(_UpdateDeliveryStatus(
groupBuyId: null == groupBuyId ? _self.groupBuyId : groupBuyId // ignore: cast_nullable_to_non_nullable
as String,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as String,trackingInfo: freezed == trackingInfo ? _self.trackingInfo : trackingInfo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$GroupBuyState {

 bool get isLoading; List<GroupBuy> get activeGroupBuys; List<GroupBuy> get myGroupBuys; List<GroupBuy> get hubGroupBuys; GroupBuy? get selectedGroupBuy; List<GroupBuyContribution> get contributions; bool get isCreating; bool get isJoining; bool get isLeaving; bool get isSuggestingDeal; bool get isConfirmingCollection; bool get isCancelling; bool get isUpdatingDelivery; String? get successId; String? get successMessage; bool get shouldPopOnSuccess; String? get errorMessage;
/// Create a copy of GroupBuyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupBuyStateCopyWith<GroupBuyState> get copyWith => _$GroupBuyStateCopyWithImpl<GroupBuyState>(this as GroupBuyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupBuyState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.activeGroupBuys, activeGroupBuys)&&const DeepCollectionEquality().equals(other.myGroupBuys, myGroupBuys)&&const DeepCollectionEquality().equals(other.hubGroupBuys, hubGroupBuys)&&(identical(other.selectedGroupBuy, selectedGroupBuy) || other.selectedGroupBuy == selectedGroupBuy)&&const DeepCollectionEquality().equals(other.contributions, contributions)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isJoining, isJoining) || other.isJoining == isJoining)&&(identical(other.isLeaving, isLeaving) || other.isLeaving == isLeaving)&&(identical(other.isSuggestingDeal, isSuggestingDeal) || other.isSuggestingDeal == isSuggestingDeal)&&(identical(other.isConfirmingCollection, isConfirmingCollection) || other.isConfirmingCollection == isConfirmingCollection)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&(identical(other.isUpdatingDelivery, isUpdatingDelivery) || other.isUpdatingDelivery == isUpdatingDelivery)&&(identical(other.successId, successId) || other.successId == successId)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.shouldPopOnSuccess, shouldPopOnSuccess) || other.shouldPopOnSuccess == shouldPopOnSuccess)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(activeGroupBuys),const DeepCollectionEquality().hash(myGroupBuys),const DeepCollectionEquality().hash(hubGroupBuys),selectedGroupBuy,const DeepCollectionEquality().hash(contributions),isCreating,isJoining,isLeaving,isSuggestingDeal,isConfirmingCollection,isCancelling,isUpdatingDelivery,successId,successMessage,shouldPopOnSuccess,errorMessage);

@override
String toString() {
  return 'GroupBuyState(isLoading: $isLoading, activeGroupBuys: $activeGroupBuys, myGroupBuys: $myGroupBuys, hubGroupBuys: $hubGroupBuys, selectedGroupBuy: $selectedGroupBuy, contributions: $contributions, isCreating: $isCreating, isJoining: $isJoining, isLeaving: $isLeaving, isSuggestingDeal: $isSuggestingDeal, isConfirmingCollection: $isConfirmingCollection, isCancelling: $isCancelling, isUpdatingDelivery: $isUpdatingDelivery, successId: $successId, successMessage: $successMessage, shouldPopOnSuccess: $shouldPopOnSuccess, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $GroupBuyStateCopyWith<$Res>  {
  factory $GroupBuyStateCopyWith(GroupBuyState value, $Res Function(GroupBuyState) _then) = _$GroupBuyStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<GroupBuy> activeGroupBuys, List<GroupBuy> myGroupBuys, List<GroupBuy> hubGroupBuys, GroupBuy? selectedGroupBuy, List<GroupBuyContribution> contributions, bool isCreating, bool isJoining, bool isLeaving, bool isSuggestingDeal, bool isConfirmingCollection, bool isCancelling, bool isUpdatingDelivery, String? successId, String? successMessage, bool shouldPopOnSuccess, String? errorMessage
});


$GroupBuyCopyWith<$Res>? get selectedGroupBuy;

}
/// @nodoc
class _$GroupBuyStateCopyWithImpl<$Res>
    implements $GroupBuyStateCopyWith<$Res> {
  _$GroupBuyStateCopyWithImpl(this._self, this._then);

  final GroupBuyState _self;
  final $Res Function(GroupBuyState) _then;

/// Create a copy of GroupBuyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? activeGroupBuys = null,Object? myGroupBuys = null,Object? hubGroupBuys = null,Object? selectedGroupBuy = freezed,Object? contributions = null,Object? isCreating = null,Object? isJoining = null,Object? isLeaving = null,Object? isSuggestingDeal = null,Object? isConfirmingCollection = null,Object? isCancelling = null,Object? isUpdatingDelivery = null,Object? successId = freezed,Object? successMessage = freezed,Object? shouldPopOnSuccess = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,activeGroupBuys: null == activeGroupBuys ? _self.activeGroupBuys : activeGroupBuys // ignore: cast_nullable_to_non_nullable
as List<GroupBuy>,myGroupBuys: null == myGroupBuys ? _self.myGroupBuys : myGroupBuys // ignore: cast_nullable_to_non_nullable
as List<GroupBuy>,hubGroupBuys: null == hubGroupBuys ? _self.hubGroupBuys : hubGroupBuys // ignore: cast_nullable_to_non_nullable
as List<GroupBuy>,selectedGroupBuy: freezed == selectedGroupBuy ? _self.selectedGroupBuy : selectedGroupBuy // ignore: cast_nullable_to_non_nullable
as GroupBuy?,contributions: null == contributions ? _self.contributions : contributions // ignore: cast_nullable_to_non_nullable
as List<GroupBuyContribution>,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,isJoining: null == isJoining ? _self.isJoining : isJoining // ignore: cast_nullable_to_non_nullable
as bool,isLeaving: null == isLeaving ? _self.isLeaving : isLeaving // ignore: cast_nullable_to_non_nullable
as bool,isSuggestingDeal: null == isSuggestingDeal ? _self.isSuggestingDeal : isSuggestingDeal // ignore: cast_nullable_to_non_nullable
as bool,isConfirmingCollection: null == isConfirmingCollection ? _self.isConfirmingCollection : isConfirmingCollection // ignore: cast_nullable_to_non_nullable
as bool,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,isUpdatingDelivery: null == isUpdatingDelivery ? _self.isUpdatingDelivery : isUpdatingDelivery // ignore: cast_nullable_to_non_nullable
as bool,successId: freezed == successId ? _self.successId : successId // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,shouldPopOnSuccess: null == shouldPopOnSuccess ? _self.shouldPopOnSuccess : shouldPopOnSuccess // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GroupBuyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupBuyCopyWith<$Res>? get selectedGroupBuy {
    if (_self.selectedGroupBuy == null) {
    return null;
  }

  return $GroupBuyCopyWith<$Res>(_self.selectedGroupBuy!, (value) {
    return _then(_self.copyWith(selectedGroupBuy: value));
  });
}
}


/// Adds pattern-matching-related methods to [GroupBuyState].
extension GroupBuyStatePatterns on GroupBuyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupBuyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupBuyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupBuyState value)  $default,){
final _that = this;
switch (_that) {
case _GroupBuyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupBuyState value)?  $default,){
final _that = this;
switch (_that) {
case _GroupBuyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<GroupBuy> activeGroupBuys,  List<GroupBuy> myGroupBuys,  List<GroupBuy> hubGroupBuys,  GroupBuy? selectedGroupBuy,  List<GroupBuyContribution> contributions,  bool isCreating,  bool isJoining,  bool isLeaving,  bool isSuggestingDeal,  bool isConfirmingCollection,  bool isCancelling,  bool isUpdatingDelivery,  String? successId,  String? successMessage,  bool shouldPopOnSuccess,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupBuyState() when $default != null:
return $default(_that.isLoading,_that.activeGroupBuys,_that.myGroupBuys,_that.hubGroupBuys,_that.selectedGroupBuy,_that.contributions,_that.isCreating,_that.isJoining,_that.isLeaving,_that.isSuggestingDeal,_that.isConfirmingCollection,_that.isCancelling,_that.isUpdatingDelivery,_that.successId,_that.successMessage,_that.shouldPopOnSuccess,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<GroupBuy> activeGroupBuys,  List<GroupBuy> myGroupBuys,  List<GroupBuy> hubGroupBuys,  GroupBuy? selectedGroupBuy,  List<GroupBuyContribution> contributions,  bool isCreating,  bool isJoining,  bool isLeaving,  bool isSuggestingDeal,  bool isConfirmingCollection,  bool isCancelling,  bool isUpdatingDelivery,  String? successId,  String? successMessage,  bool shouldPopOnSuccess,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _GroupBuyState():
return $default(_that.isLoading,_that.activeGroupBuys,_that.myGroupBuys,_that.hubGroupBuys,_that.selectedGroupBuy,_that.contributions,_that.isCreating,_that.isJoining,_that.isLeaving,_that.isSuggestingDeal,_that.isConfirmingCollection,_that.isCancelling,_that.isUpdatingDelivery,_that.successId,_that.successMessage,_that.shouldPopOnSuccess,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<GroupBuy> activeGroupBuys,  List<GroupBuy> myGroupBuys,  List<GroupBuy> hubGroupBuys,  GroupBuy? selectedGroupBuy,  List<GroupBuyContribution> contributions,  bool isCreating,  bool isJoining,  bool isLeaving,  bool isSuggestingDeal,  bool isConfirmingCollection,  bool isCancelling,  bool isUpdatingDelivery,  String? successId,  String? successMessage,  bool shouldPopOnSuccess,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _GroupBuyState() when $default != null:
return $default(_that.isLoading,_that.activeGroupBuys,_that.myGroupBuys,_that.hubGroupBuys,_that.selectedGroupBuy,_that.contributions,_that.isCreating,_that.isJoining,_that.isLeaving,_that.isSuggestingDeal,_that.isConfirmingCollection,_that.isCancelling,_that.isUpdatingDelivery,_that.successId,_that.successMessage,_that.shouldPopOnSuccess,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _GroupBuyState implements GroupBuyState {
  const _GroupBuyState({this.isLoading = false, final  List<GroupBuy> activeGroupBuys = const [], final  List<GroupBuy> myGroupBuys = const [], final  List<GroupBuy> hubGroupBuys = const [], this.selectedGroupBuy, final  List<GroupBuyContribution> contributions = const [], this.isCreating = false, this.isJoining = false, this.isLeaving = false, this.isSuggestingDeal = false, this.isConfirmingCollection = false, this.isCancelling = false, this.isUpdatingDelivery = false, this.successId, this.successMessage, this.shouldPopOnSuccess = false, this.errorMessage}): _activeGroupBuys = activeGroupBuys,_myGroupBuys = myGroupBuys,_hubGroupBuys = hubGroupBuys,_contributions = contributions;
  

@override@JsonKey() final  bool isLoading;
 final  List<GroupBuy> _activeGroupBuys;
@override@JsonKey() List<GroupBuy> get activeGroupBuys {
  if (_activeGroupBuys is EqualUnmodifiableListView) return _activeGroupBuys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeGroupBuys);
}

 final  List<GroupBuy> _myGroupBuys;
@override@JsonKey() List<GroupBuy> get myGroupBuys {
  if (_myGroupBuys is EqualUnmodifiableListView) return _myGroupBuys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_myGroupBuys);
}

 final  List<GroupBuy> _hubGroupBuys;
@override@JsonKey() List<GroupBuy> get hubGroupBuys {
  if (_hubGroupBuys is EqualUnmodifiableListView) return _hubGroupBuys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hubGroupBuys);
}

@override final  GroupBuy? selectedGroupBuy;
 final  List<GroupBuyContribution> _contributions;
@override@JsonKey() List<GroupBuyContribution> get contributions {
  if (_contributions is EqualUnmodifiableListView) return _contributions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contributions);
}

@override@JsonKey() final  bool isCreating;
@override@JsonKey() final  bool isJoining;
@override@JsonKey() final  bool isLeaving;
@override@JsonKey() final  bool isSuggestingDeal;
@override@JsonKey() final  bool isConfirmingCollection;
@override@JsonKey() final  bool isCancelling;
@override@JsonKey() final  bool isUpdatingDelivery;
@override final  String? successId;
@override final  String? successMessage;
@override@JsonKey() final  bool shouldPopOnSuccess;
@override final  String? errorMessage;

/// Create a copy of GroupBuyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupBuyStateCopyWith<_GroupBuyState> get copyWith => __$GroupBuyStateCopyWithImpl<_GroupBuyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupBuyState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._activeGroupBuys, _activeGroupBuys)&&const DeepCollectionEquality().equals(other._myGroupBuys, _myGroupBuys)&&const DeepCollectionEquality().equals(other._hubGroupBuys, _hubGroupBuys)&&(identical(other.selectedGroupBuy, selectedGroupBuy) || other.selectedGroupBuy == selectedGroupBuy)&&const DeepCollectionEquality().equals(other._contributions, _contributions)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isJoining, isJoining) || other.isJoining == isJoining)&&(identical(other.isLeaving, isLeaving) || other.isLeaving == isLeaving)&&(identical(other.isSuggestingDeal, isSuggestingDeal) || other.isSuggestingDeal == isSuggestingDeal)&&(identical(other.isConfirmingCollection, isConfirmingCollection) || other.isConfirmingCollection == isConfirmingCollection)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&(identical(other.isUpdatingDelivery, isUpdatingDelivery) || other.isUpdatingDelivery == isUpdatingDelivery)&&(identical(other.successId, successId) || other.successId == successId)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.shouldPopOnSuccess, shouldPopOnSuccess) || other.shouldPopOnSuccess == shouldPopOnSuccess)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_activeGroupBuys),const DeepCollectionEquality().hash(_myGroupBuys),const DeepCollectionEquality().hash(_hubGroupBuys),selectedGroupBuy,const DeepCollectionEquality().hash(_contributions),isCreating,isJoining,isLeaving,isSuggestingDeal,isConfirmingCollection,isCancelling,isUpdatingDelivery,successId,successMessage,shouldPopOnSuccess,errorMessage);

@override
String toString() {
  return 'GroupBuyState(isLoading: $isLoading, activeGroupBuys: $activeGroupBuys, myGroupBuys: $myGroupBuys, hubGroupBuys: $hubGroupBuys, selectedGroupBuy: $selectedGroupBuy, contributions: $contributions, isCreating: $isCreating, isJoining: $isJoining, isLeaving: $isLeaving, isSuggestingDeal: $isSuggestingDeal, isConfirmingCollection: $isConfirmingCollection, isCancelling: $isCancelling, isUpdatingDelivery: $isUpdatingDelivery, successId: $successId, successMessage: $successMessage, shouldPopOnSuccess: $shouldPopOnSuccess, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$GroupBuyStateCopyWith<$Res> implements $GroupBuyStateCopyWith<$Res> {
  factory _$GroupBuyStateCopyWith(_GroupBuyState value, $Res Function(_GroupBuyState) _then) = __$GroupBuyStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<GroupBuy> activeGroupBuys, List<GroupBuy> myGroupBuys, List<GroupBuy> hubGroupBuys, GroupBuy? selectedGroupBuy, List<GroupBuyContribution> contributions, bool isCreating, bool isJoining, bool isLeaving, bool isSuggestingDeal, bool isConfirmingCollection, bool isCancelling, bool isUpdatingDelivery, String? successId, String? successMessage, bool shouldPopOnSuccess, String? errorMessage
});


@override $GroupBuyCopyWith<$Res>? get selectedGroupBuy;

}
/// @nodoc
class __$GroupBuyStateCopyWithImpl<$Res>
    implements _$GroupBuyStateCopyWith<$Res> {
  __$GroupBuyStateCopyWithImpl(this._self, this._then);

  final _GroupBuyState _self;
  final $Res Function(_GroupBuyState) _then;

/// Create a copy of GroupBuyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? activeGroupBuys = null,Object? myGroupBuys = null,Object? hubGroupBuys = null,Object? selectedGroupBuy = freezed,Object? contributions = null,Object? isCreating = null,Object? isJoining = null,Object? isLeaving = null,Object? isSuggestingDeal = null,Object? isConfirmingCollection = null,Object? isCancelling = null,Object? isUpdatingDelivery = null,Object? successId = freezed,Object? successMessage = freezed,Object? shouldPopOnSuccess = null,Object? errorMessage = freezed,}) {
  return _then(_GroupBuyState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,activeGroupBuys: null == activeGroupBuys ? _self._activeGroupBuys : activeGroupBuys // ignore: cast_nullable_to_non_nullable
as List<GroupBuy>,myGroupBuys: null == myGroupBuys ? _self._myGroupBuys : myGroupBuys // ignore: cast_nullable_to_non_nullable
as List<GroupBuy>,hubGroupBuys: null == hubGroupBuys ? _self._hubGroupBuys : hubGroupBuys // ignore: cast_nullable_to_non_nullable
as List<GroupBuy>,selectedGroupBuy: freezed == selectedGroupBuy ? _self.selectedGroupBuy : selectedGroupBuy // ignore: cast_nullable_to_non_nullable
as GroupBuy?,contributions: null == contributions ? _self._contributions : contributions // ignore: cast_nullable_to_non_nullable
as List<GroupBuyContribution>,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,isJoining: null == isJoining ? _self.isJoining : isJoining // ignore: cast_nullable_to_non_nullable
as bool,isLeaving: null == isLeaving ? _self.isLeaving : isLeaving // ignore: cast_nullable_to_non_nullable
as bool,isSuggestingDeal: null == isSuggestingDeal ? _self.isSuggestingDeal : isSuggestingDeal // ignore: cast_nullable_to_non_nullable
as bool,isConfirmingCollection: null == isConfirmingCollection ? _self.isConfirmingCollection : isConfirmingCollection // ignore: cast_nullable_to_non_nullable
as bool,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,isUpdatingDelivery: null == isUpdatingDelivery ? _self.isUpdatingDelivery : isUpdatingDelivery // ignore: cast_nullable_to_non_nullable
as bool,successId: freezed == successId ? _self.successId : successId // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,shouldPopOnSuccess: null == shouldPopOnSuccess ? _self.shouldPopOnSuccess : shouldPopOnSuccess // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GroupBuyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupBuyCopyWith<$Res>? get selectedGroupBuy {
    if (_self.selectedGroupBuy == null) {
    return null;
  }

  return $GroupBuyCopyWith<$Res>(_self.selectedGroupBuy!, (value) {
    return _then(_self.copyWith(selectedGroupBuy: value));
  });
}
}

// dart format on
