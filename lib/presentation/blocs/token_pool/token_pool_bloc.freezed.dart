// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_pool_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TokenPoolEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenPoolEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TokenPoolEvent()';
}


}

/// @nodoc
class $TokenPoolEventCopyWith<$Res>  {
$TokenPoolEventCopyWith(TokenPoolEvent _, $Res Function(TokenPoolEvent) __);
}


/// Adds pattern-matching-related methods to [TokenPoolEvent].
extension TokenPoolEventPatterns on TokenPoolEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CreatePool value)?  createPool,TResult Function( _Contribute value)?  contribute,TResult Function( _SendGroupGift value)?  sendGroupGift,TResult Function( _DistributePool value)?  distributePool,TResult Function( _CancelPool value)?  cancelPool,TResult Function( _RequestWithdrawal value)?  requestWithdrawal,TResult Function( _OpenGroupGift value)?  openGroupGift,TResult Function( _ClaimGroupGift value)?  claimGroupGift,TResult Function( _WatchPool value)?  watchPool,TResult Function( _PoolUpdated value)?  poolUpdated,TResult Function( _LoadMyPools value)?  loadMyPools,TResult Function( _ClearError value)?  clearError,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePool() when createPool != null:
return createPool(_that);case _Contribute() when contribute != null:
return contribute(_that);case _SendGroupGift() when sendGroupGift != null:
return sendGroupGift(_that);case _DistributePool() when distributePool != null:
return distributePool(_that);case _CancelPool() when cancelPool != null:
return cancelPool(_that);case _RequestWithdrawal() when requestWithdrawal != null:
return requestWithdrawal(_that);case _OpenGroupGift() when openGroupGift != null:
return openGroupGift(_that);case _ClaimGroupGift() when claimGroupGift != null:
return claimGroupGift(_that);case _WatchPool() when watchPool != null:
return watchPool(_that);case _PoolUpdated() when poolUpdated != null:
return poolUpdated(_that);case _LoadMyPools() when loadMyPools != null:
return loadMyPools(_that);case _ClearError() when clearError != null:
return clearError(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CreatePool value)  createPool,required TResult Function( _Contribute value)  contribute,required TResult Function( _SendGroupGift value)  sendGroupGift,required TResult Function( _DistributePool value)  distributePool,required TResult Function( _CancelPool value)  cancelPool,required TResult Function( _RequestWithdrawal value)  requestWithdrawal,required TResult Function( _OpenGroupGift value)  openGroupGift,required TResult Function( _ClaimGroupGift value)  claimGroupGift,required TResult Function( _WatchPool value)  watchPool,required TResult Function( _PoolUpdated value)  poolUpdated,required TResult Function( _LoadMyPools value)  loadMyPools,required TResult Function( _ClearError value)  clearError,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _CreatePool():
return createPool(_that);case _Contribute():
return contribute(_that);case _SendGroupGift():
return sendGroupGift(_that);case _DistributePool():
return distributePool(_that);case _CancelPool():
return cancelPool(_that);case _RequestWithdrawal():
return requestWithdrawal(_that);case _OpenGroupGift():
return openGroupGift(_that);case _ClaimGroupGift():
return claimGroupGift(_that);case _WatchPool():
return watchPool(_that);case _PoolUpdated():
return poolUpdated(_that);case _LoadMyPools():
return loadMyPools(_that);case _ClearError():
return clearError(_that);case _Reset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CreatePool value)?  createPool,TResult? Function( _Contribute value)?  contribute,TResult? Function( _SendGroupGift value)?  sendGroupGift,TResult? Function( _DistributePool value)?  distributePool,TResult? Function( _CancelPool value)?  cancelPool,TResult? Function( _RequestWithdrawal value)?  requestWithdrawal,TResult? Function( _OpenGroupGift value)?  openGroupGift,TResult? Function( _ClaimGroupGift value)?  claimGroupGift,TResult? Function( _WatchPool value)?  watchPool,TResult? Function( _PoolUpdated value)?  poolUpdated,TResult? Function( _LoadMyPools value)?  loadMyPools,TResult? Function( _ClearError value)?  clearError,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _CreatePool() when createPool != null:
return createPool(_that);case _Contribute() when contribute != null:
return contribute(_that);case _SendGroupGift() when sendGroupGift != null:
return sendGroupGift(_that);case _DistributePool() when distributePool != null:
return distributePool(_that);case _CancelPool() when cancelPool != null:
return cancelPool(_that);case _RequestWithdrawal() when requestWithdrawal != null:
return requestWithdrawal(_that);case _OpenGroupGift() when openGroupGift != null:
return openGroupGift(_that);case _ClaimGroupGift() when claimGroupGift != null:
return claimGroupGift(_that);case _WatchPool() when watchPool != null:
return watchPool(_that);case _PoolUpdated() when poolUpdated != null:
return poolUpdated(_that);case _LoadMyPools() when loadMyPools != null:
return loadMyPools(_that);case _ClearError() when clearError != null:
return clearError(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PoolMode mode,  String title,  String? purpose,  String message,  GiftStyle style,  String? recipientId,  List<String> inviteeIds,  String? communityId)?  createPool,TResult Function( String poolId,  int amount,  bool anonymous)?  contribute,TResult Function( String poolId)?  sendGroupGift,TResult Function( String poolId,  List<Map<String, dynamic>> payouts,  bool keepOpen)?  distributePool,TResult Function( String poolId)?  cancelPool,TResult Function( String poolId,  int amount)?  requestWithdrawal,TResult Function( String poolId)?  openGroupGift,TResult Function( String poolId)?  claimGroupGift,TResult Function( String poolId)?  watchPool,TResult Function( TokenPool pool)?  poolUpdated,TResult Function()?  loadMyPools,TResult Function()?  clearError,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePool() when createPool != null:
return createPool(_that.mode,_that.title,_that.purpose,_that.message,_that.style,_that.recipientId,_that.inviteeIds,_that.communityId);case _Contribute() when contribute != null:
return contribute(_that.poolId,_that.amount,_that.anonymous);case _SendGroupGift() when sendGroupGift != null:
return sendGroupGift(_that.poolId);case _DistributePool() when distributePool != null:
return distributePool(_that.poolId,_that.payouts,_that.keepOpen);case _CancelPool() when cancelPool != null:
return cancelPool(_that.poolId);case _RequestWithdrawal() when requestWithdrawal != null:
return requestWithdrawal(_that.poolId,_that.amount);case _OpenGroupGift() when openGroupGift != null:
return openGroupGift(_that.poolId);case _ClaimGroupGift() when claimGroupGift != null:
return claimGroupGift(_that.poolId);case _WatchPool() when watchPool != null:
return watchPool(_that.poolId);case _PoolUpdated() when poolUpdated != null:
return poolUpdated(_that.pool);case _LoadMyPools() when loadMyPools != null:
return loadMyPools();case _ClearError() when clearError != null:
return clearError();case _Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PoolMode mode,  String title,  String? purpose,  String message,  GiftStyle style,  String? recipientId,  List<String> inviteeIds,  String? communityId)  createPool,required TResult Function( String poolId,  int amount,  bool anonymous)  contribute,required TResult Function( String poolId)  sendGroupGift,required TResult Function( String poolId,  List<Map<String, dynamic>> payouts,  bool keepOpen)  distributePool,required TResult Function( String poolId)  cancelPool,required TResult Function( String poolId,  int amount)  requestWithdrawal,required TResult Function( String poolId)  openGroupGift,required TResult Function( String poolId)  claimGroupGift,required TResult Function( String poolId)  watchPool,required TResult Function( TokenPool pool)  poolUpdated,required TResult Function()  loadMyPools,required TResult Function()  clearError,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _CreatePool():
return createPool(_that.mode,_that.title,_that.purpose,_that.message,_that.style,_that.recipientId,_that.inviteeIds,_that.communityId);case _Contribute():
return contribute(_that.poolId,_that.amount,_that.anonymous);case _SendGroupGift():
return sendGroupGift(_that.poolId);case _DistributePool():
return distributePool(_that.poolId,_that.payouts,_that.keepOpen);case _CancelPool():
return cancelPool(_that.poolId);case _RequestWithdrawal():
return requestWithdrawal(_that.poolId,_that.amount);case _OpenGroupGift():
return openGroupGift(_that.poolId);case _ClaimGroupGift():
return claimGroupGift(_that.poolId);case _WatchPool():
return watchPool(_that.poolId);case _PoolUpdated():
return poolUpdated(_that.pool);case _LoadMyPools():
return loadMyPools();case _ClearError():
return clearError();case _Reset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PoolMode mode,  String title,  String? purpose,  String message,  GiftStyle style,  String? recipientId,  List<String> inviteeIds,  String? communityId)?  createPool,TResult? Function( String poolId,  int amount,  bool anonymous)?  contribute,TResult? Function( String poolId)?  sendGroupGift,TResult? Function( String poolId,  List<Map<String, dynamic>> payouts,  bool keepOpen)?  distributePool,TResult? Function( String poolId)?  cancelPool,TResult? Function( String poolId,  int amount)?  requestWithdrawal,TResult? Function( String poolId)?  openGroupGift,TResult? Function( String poolId)?  claimGroupGift,TResult? Function( String poolId)?  watchPool,TResult? Function( TokenPool pool)?  poolUpdated,TResult? Function()?  loadMyPools,TResult? Function()?  clearError,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _CreatePool() when createPool != null:
return createPool(_that.mode,_that.title,_that.purpose,_that.message,_that.style,_that.recipientId,_that.inviteeIds,_that.communityId);case _Contribute() when contribute != null:
return contribute(_that.poolId,_that.amount,_that.anonymous);case _SendGroupGift() when sendGroupGift != null:
return sendGroupGift(_that.poolId);case _DistributePool() when distributePool != null:
return distributePool(_that.poolId,_that.payouts,_that.keepOpen);case _CancelPool() when cancelPool != null:
return cancelPool(_that.poolId);case _RequestWithdrawal() when requestWithdrawal != null:
return requestWithdrawal(_that.poolId,_that.amount);case _OpenGroupGift() when openGroupGift != null:
return openGroupGift(_that.poolId);case _ClaimGroupGift() when claimGroupGift != null:
return claimGroupGift(_that.poolId);case _WatchPool() when watchPool != null:
return watchPool(_that.poolId);case _PoolUpdated() when poolUpdated != null:
return poolUpdated(_that.pool);case _LoadMyPools() when loadMyPools != null:
return loadMyPools();case _ClearError() when clearError != null:
return clearError();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _CreatePool implements TokenPoolEvent {
  const _CreatePool({required this.mode, required this.title, this.purpose, required this.message, required this.style, this.recipientId, required final  List<String> inviteeIds, this.communityId}): _inviteeIds = inviteeIds;
  

 final  PoolMode mode;
 final  String title;
 final  String? purpose;
 final  String message;
 final  GiftStyle style;
 final  String? recipientId;
 final  List<String> _inviteeIds;
 List<String> get inviteeIds {
  if (_inviteeIds is EqualUnmodifiableListView) return _inviteeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inviteeIds);
}

 final  String? communityId;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePoolCopyWith<_CreatePool> get copyWith => __$CreatePoolCopyWithImpl<_CreatePool>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePool&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.title, title) || other.title == title)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&const DeepCollectionEquality().equals(other._inviteeIds, _inviteeIds)&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,mode,title,purpose,message,style,recipientId,const DeepCollectionEquality().hash(_inviteeIds),communityId);

@override
String toString() {
  return 'TokenPoolEvent.createPool(mode: $mode, title: $title, purpose: $purpose, message: $message, style: $style, recipientId: $recipientId, inviteeIds: $inviteeIds, communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$CreatePoolCopyWith<$Res> implements $TokenPoolEventCopyWith<$Res> {
  factory _$CreatePoolCopyWith(_CreatePool value, $Res Function(_CreatePool) _then) = __$CreatePoolCopyWithImpl;
@useResult
$Res call({
 PoolMode mode, String title, String? purpose, String message, GiftStyle style, String? recipientId, List<String> inviteeIds, String? communityId
});




}
/// @nodoc
class __$CreatePoolCopyWithImpl<$Res>
    implements _$CreatePoolCopyWith<$Res> {
  __$CreatePoolCopyWithImpl(this._self, this._then);

  final _CreatePool _self;
  final $Res Function(_CreatePool) _then;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? title = null,Object? purpose = freezed,Object? message = null,Object? style = null,Object? recipientId = freezed,Object? inviteeIds = null,Object? communityId = freezed,}) {
  return _then(_CreatePool(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PoolMode,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,purpose: freezed == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GiftStyle,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,inviteeIds: null == inviteeIds ? _self._inviteeIds : inviteeIds // ignore: cast_nullable_to_non_nullable
as List<String>,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Contribute implements TokenPoolEvent {
  const _Contribute({required this.poolId, required this.amount, required this.anonymous});
  

 final  String poolId;
 final  int amount;
 final  bool anonymous;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContributeCopyWith<_Contribute> get copyWith => __$ContributeCopyWithImpl<_Contribute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Contribute&&(identical(other.poolId, poolId) || other.poolId == poolId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.anonymous, anonymous) || other.anonymous == anonymous));
}


@override
int get hashCode => Object.hash(runtimeType,poolId,amount,anonymous);

@override
String toString() {
  return 'TokenPoolEvent.contribute(poolId: $poolId, amount: $amount, anonymous: $anonymous)';
}


}

/// @nodoc
abstract mixin class _$ContributeCopyWith<$Res> implements $TokenPoolEventCopyWith<$Res> {
  factory _$ContributeCopyWith(_Contribute value, $Res Function(_Contribute) _then) = __$ContributeCopyWithImpl;
@useResult
$Res call({
 String poolId, int amount, bool anonymous
});




}
/// @nodoc
class __$ContributeCopyWithImpl<$Res>
    implements _$ContributeCopyWith<$Res> {
  __$ContributeCopyWithImpl(this._self, this._then);

  final _Contribute _self;
  final $Res Function(_Contribute) _then;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? poolId = null,Object? amount = null,Object? anonymous = null,}) {
  return _then(_Contribute(
poolId: null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,anonymous: null == anonymous ? _self.anonymous : anonymous // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _SendGroupGift implements TokenPoolEvent {
  const _SendGroupGift(this.poolId);
  

 final  String poolId;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendGroupGiftCopyWith<_SendGroupGift> get copyWith => __$SendGroupGiftCopyWithImpl<_SendGroupGift>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendGroupGift&&(identical(other.poolId, poolId) || other.poolId == poolId));
}


@override
int get hashCode => Object.hash(runtimeType,poolId);

@override
String toString() {
  return 'TokenPoolEvent.sendGroupGift(poolId: $poolId)';
}


}

/// @nodoc
abstract mixin class _$SendGroupGiftCopyWith<$Res> implements $TokenPoolEventCopyWith<$Res> {
  factory _$SendGroupGiftCopyWith(_SendGroupGift value, $Res Function(_SendGroupGift) _then) = __$SendGroupGiftCopyWithImpl;
@useResult
$Res call({
 String poolId
});




}
/// @nodoc
class __$SendGroupGiftCopyWithImpl<$Res>
    implements _$SendGroupGiftCopyWith<$Res> {
  __$SendGroupGiftCopyWithImpl(this._self, this._then);

  final _SendGroupGift _self;
  final $Res Function(_SendGroupGift) _then;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? poolId = null,}) {
  return _then(_SendGroupGift(
null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DistributePool implements TokenPoolEvent {
  const _DistributePool({required this.poolId, required final  List<Map<String, dynamic>> payouts, this.keepOpen = false}): _payouts = payouts;
  

 final  String poolId;
 final  List<Map<String, dynamic>> _payouts;
 List<Map<String, dynamic>> get payouts {
  if (_payouts is EqualUnmodifiableListView) return _payouts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payouts);
}

@JsonKey() final  bool keepOpen;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DistributePoolCopyWith<_DistributePool> get copyWith => __$DistributePoolCopyWithImpl<_DistributePool>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DistributePool&&(identical(other.poolId, poolId) || other.poolId == poolId)&&const DeepCollectionEquality().equals(other._payouts, _payouts)&&(identical(other.keepOpen, keepOpen) || other.keepOpen == keepOpen));
}


@override
int get hashCode => Object.hash(runtimeType,poolId,const DeepCollectionEquality().hash(_payouts),keepOpen);

@override
String toString() {
  return 'TokenPoolEvent.distributePool(poolId: $poolId, payouts: $payouts, keepOpen: $keepOpen)';
}


}

/// @nodoc
abstract mixin class _$DistributePoolCopyWith<$Res> implements $TokenPoolEventCopyWith<$Res> {
  factory _$DistributePoolCopyWith(_DistributePool value, $Res Function(_DistributePool) _then) = __$DistributePoolCopyWithImpl;
@useResult
$Res call({
 String poolId, List<Map<String, dynamic>> payouts, bool keepOpen
});




}
/// @nodoc
class __$DistributePoolCopyWithImpl<$Res>
    implements _$DistributePoolCopyWith<$Res> {
  __$DistributePoolCopyWithImpl(this._self, this._then);

  final _DistributePool _self;
  final $Res Function(_DistributePool) _then;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? poolId = null,Object? payouts = null,Object? keepOpen = null,}) {
  return _then(_DistributePool(
poolId: null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,payouts: null == payouts ? _self._payouts : payouts // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,keepOpen: null == keepOpen ? _self.keepOpen : keepOpen // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _CancelPool implements TokenPoolEvent {
  const _CancelPool(this.poolId);
  

 final  String poolId;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelPoolCopyWith<_CancelPool> get copyWith => __$CancelPoolCopyWithImpl<_CancelPool>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelPool&&(identical(other.poolId, poolId) || other.poolId == poolId));
}


@override
int get hashCode => Object.hash(runtimeType,poolId);

@override
String toString() {
  return 'TokenPoolEvent.cancelPool(poolId: $poolId)';
}


}

/// @nodoc
abstract mixin class _$CancelPoolCopyWith<$Res> implements $TokenPoolEventCopyWith<$Res> {
  factory _$CancelPoolCopyWith(_CancelPool value, $Res Function(_CancelPool) _then) = __$CancelPoolCopyWithImpl;
@useResult
$Res call({
 String poolId
});




}
/// @nodoc
class __$CancelPoolCopyWithImpl<$Res>
    implements _$CancelPoolCopyWith<$Res> {
  __$CancelPoolCopyWithImpl(this._self, this._then);

  final _CancelPool _self;
  final $Res Function(_CancelPool) _then;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? poolId = null,}) {
  return _then(_CancelPool(
null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RequestWithdrawal implements TokenPoolEvent {
  const _RequestWithdrawal({required this.poolId, required this.amount});
  

 final  String poolId;
 final  int amount;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestWithdrawalCopyWith<_RequestWithdrawal> get copyWith => __$RequestWithdrawalCopyWithImpl<_RequestWithdrawal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestWithdrawal&&(identical(other.poolId, poolId) || other.poolId == poolId)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,poolId,amount);

@override
String toString() {
  return 'TokenPoolEvent.requestWithdrawal(poolId: $poolId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$RequestWithdrawalCopyWith<$Res> implements $TokenPoolEventCopyWith<$Res> {
  factory _$RequestWithdrawalCopyWith(_RequestWithdrawal value, $Res Function(_RequestWithdrawal) _then) = __$RequestWithdrawalCopyWithImpl;
@useResult
$Res call({
 String poolId, int amount
});




}
/// @nodoc
class __$RequestWithdrawalCopyWithImpl<$Res>
    implements _$RequestWithdrawalCopyWith<$Res> {
  __$RequestWithdrawalCopyWithImpl(this._self, this._then);

  final _RequestWithdrawal _self;
  final $Res Function(_RequestWithdrawal) _then;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? poolId = null,Object? amount = null,}) {
  return _then(_RequestWithdrawal(
poolId: null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _OpenGroupGift implements TokenPoolEvent {
  const _OpenGroupGift(this.poolId);
  

 final  String poolId;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenGroupGiftCopyWith<_OpenGroupGift> get copyWith => __$OpenGroupGiftCopyWithImpl<_OpenGroupGift>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenGroupGift&&(identical(other.poolId, poolId) || other.poolId == poolId));
}


@override
int get hashCode => Object.hash(runtimeType,poolId);

@override
String toString() {
  return 'TokenPoolEvent.openGroupGift(poolId: $poolId)';
}


}

/// @nodoc
abstract mixin class _$OpenGroupGiftCopyWith<$Res> implements $TokenPoolEventCopyWith<$Res> {
  factory _$OpenGroupGiftCopyWith(_OpenGroupGift value, $Res Function(_OpenGroupGift) _then) = __$OpenGroupGiftCopyWithImpl;
@useResult
$Res call({
 String poolId
});




}
/// @nodoc
class __$OpenGroupGiftCopyWithImpl<$Res>
    implements _$OpenGroupGiftCopyWith<$Res> {
  __$OpenGroupGiftCopyWithImpl(this._self, this._then);

  final _OpenGroupGift _self;
  final $Res Function(_OpenGroupGift) _then;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? poolId = null,}) {
  return _then(_OpenGroupGift(
null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClaimGroupGift implements TokenPoolEvent {
  const _ClaimGroupGift(this.poolId);
  

 final  String poolId;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimGroupGiftCopyWith<_ClaimGroupGift> get copyWith => __$ClaimGroupGiftCopyWithImpl<_ClaimGroupGift>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimGroupGift&&(identical(other.poolId, poolId) || other.poolId == poolId));
}


@override
int get hashCode => Object.hash(runtimeType,poolId);

@override
String toString() {
  return 'TokenPoolEvent.claimGroupGift(poolId: $poolId)';
}


}

/// @nodoc
abstract mixin class _$ClaimGroupGiftCopyWith<$Res> implements $TokenPoolEventCopyWith<$Res> {
  factory _$ClaimGroupGiftCopyWith(_ClaimGroupGift value, $Res Function(_ClaimGroupGift) _then) = __$ClaimGroupGiftCopyWithImpl;
@useResult
$Res call({
 String poolId
});




}
/// @nodoc
class __$ClaimGroupGiftCopyWithImpl<$Res>
    implements _$ClaimGroupGiftCopyWith<$Res> {
  __$ClaimGroupGiftCopyWithImpl(this._self, this._then);

  final _ClaimGroupGift _self;
  final $Res Function(_ClaimGroupGift) _then;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? poolId = null,}) {
  return _then(_ClaimGroupGift(
null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WatchPool implements TokenPoolEvent {
  const _WatchPool(this.poolId);
  

 final  String poolId;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchPoolCopyWith<_WatchPool> get copyWith => __$WatchPoolCopyWithImpl<_WatchPool>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchPool&&(identical(other.poolId, poolId) || other.poolId == poolId));
}


@override
int get hashCode => Object.hash(runtimeType,poolId);

@override
String toString() {
  return 'TokenPoolEvent.watchPool(poolId: $poolId)';
}


}

/// @nodoc
abstract mixin class _$WatchPoolCopyWith<$Res> implements $TokenPoolEventCopyWith<$Res> {
  factory _$WatchPoolCopyWith(_WatchPool value, $Res Function(_WatchPool) _then) = __$WatchPoolCopyWithImpl;
@useResult
$Res call({
 String poolId
});




}
/// @nodoc
class __$WatchPoolCopyWithImpl<$Res>
    implements _$WatchPoolCopyWith<$Res> {
  __$WatchPoolCopyWithImpl(this._self, this._then);

  final _WatchPool _self;
  final $Res Function(_WatchPool) _then;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? poolId = null,}) {
  return _then(_WatchPool(
null == poolId ? _self.poolId : poolId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PoolUpdated implements TokenPoolEvent {
  const _PoolUpdated(this.pool);
  

 final  TokenPool pool;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PoolUpdatedCopyWith<_PoolUpdated> get copyWith => __$PoolUpdatedCopyWithImpl<_PoolUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PoolUpdated&&(identical(other.pool, pool) || other.pool == pool));
}


@override
int get hashCode => Object.hash(runtimeType,pool);

@override
String toString() {
  return 'TokenPoolEvent.poolUpdated(pool: $pool)';
}


}

/// @nodoc
abstract mixin class _$PoolUpdatedCopyWith<$Res> implements $TokenPoolEventCopyWith<$Res> {
  factory _$PoolUpdatedCopyWith(_PoolUpdated value, $Res Function(_PoolUpdated) _then) = __$PoolUpdatedCopyWithImpl;
@useResult
$Res call({
 TokenPool pool
});


$TokenPoolCopyWith<$Res> get pool;

}
/// @nodoc
class __$PoolUpdatedCopyWithImpl<$Res>
    implements _$PoolUpdatedCopyWith<$Res> {
  __$PoolUpdatedCopyWithImpl(this._self, this._then);

  final _PoolUpdated _self;
  final $Res Function(_PoolUpdated) _then;

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pool = null,}) {
  return _then(_PoolUpdated(
null == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as TokenPool,
  ));
}

/// Create a copy of TokenPoolEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenPoolCopyWith<$Res> get pool {
  
  return $TokenPoolCopyWith<$Res>(_self.pool, (value) {
    return _then(_self.copyWith(pool: value));
  });
}
}

/// @nodoc


class _LoadMyPools implements TokenPoolEvent {
  const _LoadMyPools();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMyPools);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TokenPoolEvent.loadMyPools()';
}


}




/// @nodoc


class _ClearError implements TokenPoolEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TokenPoolEvent.clearError()';
}


}




/// @nodoc


class _Reset implements TokenPoolEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TokenPoolEvent.reset()';
}


}




/// @nodoc
mixin _$TokenPoolState {

 List<TokenPool> get myPools; TokenPool? get activePool; bool get isLoading; bool get isCreating; bool get isContributing; bool get isSending; bool get isDistributing; bool get isCancelling; bool get isClaiming; bool get isWithdrawing; String? get errorMessage; String? get successMessage;
/// Create a copy of TokenPoolState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenPoolStateCopyWith<TokenPoolState> get copyWith => _$TokenPoolStateCopyWithImpl<TokenPoolState>(this as TokenPoolState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenPoolState&&const DeepCollectionEquality().equals(other.myPools, myPools)&&(identical(other.activePool, activePool) || other.activePool == activePool)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isContributing, isContributing) || other.isContributing == isContributing)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.isDistributing, isDistributing) || other.isDistributing == isDistributing)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&(identical(other.isClaiming, isClaiming) || other.isClaiming == isClaiming)&&(identical(other.isWithdrawing, isWithdrawing) || other.isWithdrawing == isWithdrawing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(myPools),activePool,isLoading,isCreating,isContributing,isSending,isDistributing,isCancelling,isClaiming,isWithdrawing,errorMessage,successMessage);

@override
String toString() {
  return 'TokenPoolState(myPools: $myPools, activePool: $activePool, isLoading: $isLoading, isCreating: $isCreating, isContributing: $isContributing, isSending: $isSending, isDistributing: $isDistributing, isCancelling: $isCancelling, isClaiming: $isClaiming, isWithdrawing: $isWithdrawing, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $TokenPoolStateCopyWith<$Res>  {
  factory $TokenPoolStateCopyWith(TokenPoolState value, $Res Function(TokenPoolState) _then) = _$TokenPoolStateCopyWithImpl;
@useResult
$Res call({
 List<TokenPool> myPools, TokenPool? activePool, bool isLoading, bool isCreating, bool isContributing, bool isSending, bool isDistributing, bool isCancelling, bool isClaiming, bool isWithdrawing, String? errorMessage, String? successMessage
});


$TokenPoolCopyWith<$Res>? get activePool;

}
/// @nodoc
class _$TokenPoolStateCopyWithImpl<$Res>
    implements $TokenPoolStateCopyWith<$Res> {
  _$TokenPoolStateCopyWithImpl(this._self, this._then);

  final TokenPoolState _self;
  final $Res Function(TokenPoolState) _then;

/// Create a copy of TokenPoolState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? myPools = null,Object? activePool = freezed,Object? isLoading = null,Object? isCreating = null,Object? isContributing = null,Object? isSending = null,Object? isDistributing = null,Object? isCancelling = null,Object? isClaiming = null,Object? isWithdrawing = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
myPools: null == myPools ? _self.myPools : myPools // ignore: cast_nullable_to_non_nullable
as List<TokenPool>,activePool: freezed == activePool ? _self.activePool : activePool // ignore: cast_nullable_to_non_nullable
as TokenPool?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,isContributing: null == isContributing ? _self.isContributing : isContributing // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,isDistributing: null == isDistributing ? _self.isDistributing : isDistributing // ignore: cast_nullable_to_non_nullable
as bool,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,isClaiming: null == isClaiming ? _self.isClaiming : isClaiming // ignore: cast_nullable_to_non_nullable
as bool,isWithdrawing: null == isWithdrawing ? _self.isWithdrawing : isWithdrawing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TokenPoolState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenPoolCopyWith<$Res>? get activePool {
    if (_self.activePool == null) {
    return null;
  }

  return $TokenPoolCopyWith<$Res>(_self.activePool!, (value) {
    return _then(_self.copyWith(activePool: value));
  });
}
}


/// Adds pattern-matching-related methods to [TokenPoolState].
extension TokenPoolStatePatterns on TokenPoolState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenPoolState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenPoolState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenPoolState value)  $default,){
final _that = this;
switch (_that) {
case _TokenPoolState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenPoolState value)?  $default,){
final _that = this;
switch (_that) {
case _TokenPoolState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TokenPool> myPools,  TokenPool? activePool,  bool isLoading,  bool isCreating,  bool isContributing,  bool isSending,  bool isDistributing,  bool isCancelling,  bool isClaiming,  bool isWithdrawing,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenPoolState() when $default != null:
return $default(_that.myPools,_that.activePool,_that.isLoading,_that.isCreating,_that.isContributing,_that.isSending,_that.isDistributing,_that.isCancelling,_that.isClaiming,_that.isWithdrawing,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TokenPool> myPools,  TokenPool? activePool,  bool isLoading,  bool isCreating,  bool isContributing,  bool isSending,  bool isDistributing,  bool isCancelling,  bool isClaiming,  bool isWithdrawing,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _TokenPoolState():
return $default(_that.myPools,_that.activePool,_that.isLoading,_that.isCreating,_that.isContributing,_that.isSending,_that.isDistributing,_that.isCancelling,_that.isClaiming,_that.isWithdrawing,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TokenPool> myPools,  TokenPool? activePool,  bool isLoading,  bool isCreating,  bool isContributing,  bool isSending,  bool isDistributing,  bool isCancelling,  bool isClaiming,  bool isWithdrawing,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _TokenPoolState() when $default != null:
return $default(_that.myPools,_that.activePool,_that.isLoading,_that.isCreating,_that.isContributing,_that.isSending,_that.isDistributing,_that.isCancelling,_that.isClaiming,_that.isWithdrawing,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TokenPoolState implements TokenPoolState {
  const _TokenPoolState({final  List<TokenPool> myPools = const [], this.activePool, this.isLoading = false, this.isCreating = false, this.isContributing = false, this.isSending = false, this.isDistributing = false, this.isCancelling = false, this.isClaiming = false, this.isWithdrawing = false, this.errorMessage, this.successMessage}): _myPools = myPools;
  

 final  List<TokenPool> _myPools;
@override@JsonKey() List<TokenPool> get myPools {
  if (_myPools is EqualUnmodifiableListView) return _myPools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_myPools);
}

@override final  TokenPool? activePool;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isCreating;
@override@JsonKey() final  bool isContributing;
@override@JsonKey() final  bool isSending;
@override@JsonKey() final  bool isDistributing;
@override@JsonKey() final  bool isCancelling;
@override@JsonKey() final  bool isClaiming;
@override@JsonKey() final  bool isWithdrawing;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of TokenPoolState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenPoolStateCopyWith<_TokenPoolState> get copyWith => __$TokenPoolStateCopyWithImpl<_TokenPoolState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenPoolState&&const DeepCollectionEquality().equals(other._myPools, _myPools)&&(identical(other.activePool, activePool) || other.activePool == activePool)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isContributing, isContributing) || other.isContributing == isContributing)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.isDistributing, isDistributing) || other.isDistributing == isDistributing)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&(identical(other.isClaiming, isClaiming) || other.isClaiming == isClaiming)&&(identical(other.isWithdrawing, isWithdrawing) || other.isWithdrawing == isWithdrawing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_myPools),activePool,isLoading,isCreating,isContributing,isSending,isDistributing,isCancelling,isClaiming,isWithdrawing,errorMessage,successMessage);

@override
String toString() {
  return 'TokenPoolState(myPools: $myPools, activePool: $activePool, isLoading: $isLoading, isCreating: $isCreating, isContributing: $isContributing, isSending: $isSending, isDistributing: $isDistributing, isCancelling: $isCancelling, isClaiming: $isClaiming, isWithdrawing: $isWithdrawing, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$TokenPoolStateCopyWith<$Res> implements $TokenPoolStateCopyWith<$Res> {
  factory _$TokenPoolStateCopyWith(_TokenPoolState value, $Res Function(_TokenPoolState) _then) = __$TokenPoolStateCopyWithImpl;
@override @useResult
$Res call({
 List<TokenPool> myPools, TokenPool? activePool, bool isLoading, bool isCreating, bool isContributing, bool isSending, bool isDistributing, bool isCancelling, bool isClaiming, bool isWithdrawing, String? errorMessage, String? successMessage
});


@override $TokenPoolCopyWith<$Res>? get activePool;

}
/// @nodoc
class __$TokenPoolStateCopyWithImpl<$Res>
    implements _$TokenPoolStateCopyWith<$Res> {
  __$TokenPoolStateCopyWithImpl(this._self, this._then);

  final _TokenPoolState _self;
  final $Res Function(_TokenPoolState) _then;

/// Create a copy of TokenPoolState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? myPools = null,Object? activePool = freezed,Object? isLoading = null,Object? isCreating = null,Object? isContributing = null,Object? isSending = null,Object? isDistributing = null,Object? isCancelling = null,Object? isClaiming = null,Object? isWithdrawing = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_TokenPoolState(
myPools: null == myPools ? _self._myPools : myPools // ignore: cast_nullable_to_non_nullable
as List<TokenPool>,activePool: freezed == activePool ? _self.activePool : activePool // ignore: cast_nullable_to_non_nullable
as TokenPool?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,isContributing: null == isContributing ? _self.isContributing : isContributing // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,isDistributing: null == isDistributing ? _self.isDistributing : isDistributing // ignore: cast_nullable_to_non_nullable
as bool,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,isClaiming: null == isClaiming ? _self.isClaiming : isClaiming // ignore: cast_nullable_to_non_nullable
as bool,isWithdrawing: null == isWithdrawing ? _self.isWithdrawing : isWithdrawing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TokenPoolState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenPoolCopyWith<$Res>? get activePool {
    if (_self.activePool == null) {
    return null;
  }

  return $TokenPoolCopyWith<$Res>(_self.activePool!, (value) {
    return _then(_self.copyWith(activePool: value));
  });
}
}

// dart format on
