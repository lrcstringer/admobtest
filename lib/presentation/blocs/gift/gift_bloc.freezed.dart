// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GiftEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GiftEvent()';
}


}

/// @nodoc
class $GiftEventCopyWith<$Res>  {
$GiftEventCopyWith(GiftEvent _, $Res Function(GiftEvent) __);
}


/// Adds pattern-matching-related methods to [GiftEvent].
extension GiftEventPatterns on GiftEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SendGift value)?  sendGift,TResult Function( _OpenGift value)?  openGift,TResult Function( _ClaimGift value)?  claimGift,TResult Function( _LoadSentGifts value)?  loadSentGifts,TResult Function( _LoadReceivedGifts value)?  loadReceivedGifts,TResult Function( _WatchGift value)?  watchGift,TResult Function( _GiftUpdated value)?  giftUpdated,TResult Function( _LoadGiftStats value)?  loadGiftStats,TResult Function( _ClearError value)?  clearError,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendGift() when sendGift != null:
return sendGift(_that);case _OpenGift() when openGift != null:
return openGift(_that);case _ClaimGift() when claimGift != null:
return claimGift(_that);case _LoadSentGifts() when loadSentGifts != null:
return loadSentGifts(_that);case _LoadReceivedGifts() when loadReceivedGifts != null:
return loadReceivedGifts(_that);case _WatchGift() when watchGift != null:
return watchGift(_that);case _GiftUpdated() when giftUpdated != null:
return giftUpdated(_that);case _LoadGiftStats() when loadGiftStats != null:
return loadGiftStats(_that);case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SendGift value)  sendGift,required TResult Function( _OpenGift value)  openGift,required TResult Function( _ClaimGift value)  claimGift,required TResult Function( _LoadSentGifts value)  loadSentGifts,required TResult Function( _LoadReceivedGifts value)  loadReceivedGifts,required TResult Function( _WatchGift value)  watchGift,required TResult Function( _GiftUpdated value)  giftUpdated,required TResult Function( _LoadGiftStats value)  loadGiftStats,required TResult Function( _ClearError value)  clearError,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _SendGift():
return sendGift(_that);case _OpenGift():
return openGift(_that);case _ClaimGift():
return claimGift(_that);case _LoadSentGifts():
return loadSentGifts(_that);case _LoadReceivedGifts():
return loadReceivedGifts(_that);case _WatchGift():
return watchGift(_that);case _GiftUpdated():
return giftUpdated(_that);case _LoadGiftStats():
return loadGiftStats(_that);case _ClearError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SendGift value)?  sendGift,TResult? Function( _OpenGift value)?  openGift,TResult? Function( _ClaimGift value)?  claimGift,TResult? Function( _LoadSentGifts value)?  loadSentGifts,TResult? Function( _LoadReceivedGifts value)?  loadReceivedGifts,TResult? Function( _WatchGift value)?  watchGift,TResult? Function( _GiftUpdated value)?  giftUpdated,TResult? Function( _LoadGiftStats value)?  loadGiftStats,TResult? Function( _ClearError value)?  clearError,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _SendGift() when sendGift != null:
return sendGift(_that);case _OpenGift() when openGift != null:
return openGift(_that);case _ClaimGift() when claimGift != null:
return claimGift(_that);case _LoadSentGifts() when loadSentGifts != null:
return loadSentGifts(_that);case _LoadReceivedGifts() when loadReceivedGifts != null:
return loadReceivedGifts(_that);case _WatchGift() when watchGift != null:
return watchGift(_that);case _GiftUpdated() when giftUpdated != null:
return giftUpdated(_that);case _LoadGiftStats() when loadGiftStats != null:
return loadGiftStats(_that);case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String recipientId,  int amount,  String message,  GiftStyle style,  String? conversationId,  String? communityId)?  sendGift,TResult Function( String giftId)?  openGift,TResult Function( String giftId)?  claimGift,TResult Function()?  loadSentGifts,TResult Function()?  loadReceivedGifts,TResult Function( String giftId)?  watchGift,TResult Function( Gift gift)?  giftUpdated,TResult Function()?  loadGiftStats,TResult Function()?  clearError,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendGift() when sendGift != null:
return sendGift(_that.recipientId,_that.amount,_that.message,_that.style,_that.conversationId,_that.communityId);case _OpenGift() when openGift != null:
return openGift(_that.giftId);case _ClaimGift() when claimGift != null:
return claimGift(_that.giftId);case _LoadSentGifts() when loadSentGifts != null:
return loadSentGifts();case _LoadReceivedGifts() when loadReceivedGifts != null:
return loadReceivedGifts();case _WatchGift() when watchGift != null:
return watchGift(_that.giftId);case _GiftUpdated() when giftUpdated != null:
return giftUpdated(_that.gift);case _LoadGiftStats() when loadGiftStats != null:
return loadGiftStats();case _ClearError() when clearError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String recipientId,  int amount,  String message,  GiftStyle style,  String? conversationId,  String? communityId)  sendGift,required TResult Function( String giftId)  openGift,required TResult Function( String giftId)  claimGift,required TResult Function()  loadSentGifts,required TResult Function()  loadReceivedGifts,required TResult Function( String giftId)  watchGift,required TResult Function( Gift gift)  giftUpdated,required TResult Function()  loadGiftStats,required TResult Function()  clearError,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _SendGift():
return sendGift(_that.recipientId,_that.amount,_that.message,_that.style,_that.conversationId,_that.communityId);case _OpenGift():
return openGift(_that.giftId);case _ClaimGift():
return claimGift(_that.giftId);case _LoadSentGifts():
return loadSentGifts();case _LoadReceivedGifts():
return loadReceivedGifts();case _WatchGift():
return watchGift(_that.giftId);case _GiftUpdated():
return giftUpdated(_that.gift);case _LoadGiftStats():
return loadGiftStats();case _ClearError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String recipientId,  int amount,  String message,  GiftStyle style,  String? conversationId,  String? communityId)?  sendGift,TResult? Function( String giftId)?  openGift,TResult? Function( String giftId)?  claimGift,TResult? Function()?  loadSentGifts,TResult? Function()?  loadReceivedGifts,TResult? Function( String giftId)?  watchGift,TResult? Function( Gift gift)?  giftUpdated,TResult? Function()?  loadGiftStats,TResult? Function()?  clearError,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _SendGift() when sendGift != null:
return sendGift(_that.recipientId,_that.amount,_that.message,_that.style,_that.conversationId,_that.communityId);case _OpenGift() when openGift != null:
return openGift(_that.giftId);case _ClaimGift() when claimGift != null:
return claimGift(_that.giftId);case _LoadSentGifts() when loadSentGifts != null:
return loadSentGifts();case _LoadReceivedGifts() when loadReceivedGifts != null:
return loadReceivedGifts();case _WatchGift() when watchGift != null:
return watchGift(_that.giftId);case _GiftUpdated() when giftUpdated != null:
return giftUpdated(_that.gift);case _LoadGiftStats() when loadGiftStats != null:
return loadGiftStats();case _ClearError() when clearError != null:
return clearError();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _SendGift implements GiftEvent {
  const _SendGift({required this.recipientId, required this.amount, required this.message, required this.style, this.conversationId, this.communityId});
  

 final  String recipientId;
 final  int amount;
 final  String message;
 final  GiftStyle style;
 final  String? conversationId;
 final  String? communityId;

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendGiftCopyWith<_SendGift> get copyWith => __$SendGiftCopyWithImpl<_SendGift>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendGift&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.message, message) || other.message == message)&&(identical(other.style, style) || other.style == style)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode => Object.hash(runtimeType,recipientId,amount,message,style,conversationId,communityId);

@override
String toString() {
  return 'GiftEvent.sendGift(recipientId: $recipientId, amount: $amount, message: $message, style: $style, conversationId: $conversationId, communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$SendGiftCopyWith<$Res> implements $GiftEventCopyWith<$Res> {
  factory _$SendGiftCopyWith(_SendGift value, $Res Function(_SendGift) _then) = __$SendGiftCopyWithImpl;
@useResult
$Res call({
 String recipientId, int amount, String message, GiftStyle style, String? conversationId, String? communityId
});




}
/// @nodoc
class __$SendGiftCopyWithImpl<$Res>
    implements _$SendGiftCopyWith<$Res> {
  __$SendGiftCopyWithImpl(this._self, this._then);

  final _SendGift _self;
  final $Res Function(_SendGift) _then;

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recipientId = null,Object? amount = null,Object? message = null,Object? style = null,Object? conversationId = freezed,Object? communityId = freezed,}) {
  return _then(_SendGift(
recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as GiftStyle,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _OpenGift implements GiftEvent {
  const _OpenGift(this.giftId);
  

 final  String giftId;

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenGiftCopyWith<_OpenGift> get copyWith => __$OpenGiftCopyWithImpl<_OpenGift>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenGift&&(identical(other.giftId, giftId) || other.giftId == giftId));
}


@override
int get hashCode => Object.hash(runtimeType,giftId);

@override
String toString() {
  return 'GiftEvent.openGift(giftId: $giftId)';
}


}

/// @nodoc
abstract mixin class _$OpenGiftCopyWith<$Res> implements $GiftEventCopyWith<$Res> {
  factory _$OpenGiftCopyWith(_OpenGift value, $Res Function(_OpenGift) _then) = __$OpenGiftCopyWithImpl;
@useResult
$Res call({
 String giftId
});




}
/// @nodoc
class __$OpenGiftCopyWithImpl<$Res>
    implements _$OpenGiftCopyWith<$Res> {
  __$OpenGiftCopyWithImpl(this._self, this._then);

  final _OpenGift _self;
  final $Res Function(_OpenGift) _then;

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? giftId = null,}) {
  return _then(_OpenGift(
null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClaimGift implements GiftEvent {
  const _ClaimGift(this.giftId);
  

 final  String giftId;

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimGiftCopyWith<_ClaimGift> get copyWith => __$ClaimGiftCopyWithImpl<_ClaimGift>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimGift&&(identical(other.giftId, giftId) || other.giftId == giftId));
}


@override
int get hashCode => Object.hash(runtimeType,giftId);

@override
String toString() {
  return 'GiftEvent.claimGift(giftId: $giftId)';
}


}

/// @nodoc
abstract mixin class _$ClaimGiftCopyWith<$Res> implements $GiftEventCopyWith<$Res> {
  factory _$ClaimGiftCopyWith(_ClaimGift value, $Res Function(_ClaimGift) _then) = __$ClaimGiftCopyWithImpl;
@useResult
$Res call({
 String giftId
});




}
/// @nodoc
class __$ClaimGiftCopyWithImpl<$Res>
    implements _$ClaimGiftCopyWith<$Res> {
  __$ClaimGiftCopyWithImpl(this._self, this._then);

  final _ClaimGift _self;
  final $Res Function(_ClaimGift) _then;

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? giftId = null,}) {
  return _then(_ClaimGift(
null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadSentGifts implements GiftEvent {
  const _LoadSentGifts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadSentGifts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GiftEvent.loadSentGifts()';
}


}




/// @nodoc


class _LoadReceivedGifts implements GiftEvent {
  const _LoadReceivedGifts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadReceivedGifts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GiftEvent.loadReceivedGifts()';
}


}




/// @nodoc


class _WatchGift implements GiftEvent {
  const _WatchGift(this.giftId);
  

 final  String giftId;

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchGiftCopyWith<_WatchGift> get copyWith => __$WatchGiftCopyWithImpl<_WatchGift>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchGift&&(identical(other.giftId, giftId) || other.giftId == giftId));
}


@override
int get hashCode => Object.hash(runtimeType,giftId);

@override
String toString() {
  return 'GiftEvent.watchGift(giftId: $giftId)';
}


}

/// @nodoc
abstract mixin class _$WatchGiftCopyWith<$Res> implements $GiftEventCopyWith<$Res> {
  factory _$WatchGiftCopyWith(_WatchGift value, $Res Function(_WatchGift) _then) = __$WatchGiftCopyWithImpl;
@useResult
$Res call({
 String giftId
});




}
/// @nodoc
class __$WatchGiftCopyWithImpl<$Res>
    implements _$WatchGiftCopyWith<$Res> {
  __$WatchGiftCopyWithImpl(this._self, this._then);

  final _WatchGift _self;
  final $Res Function(_WatchGift) _then;

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? giftId = null,}) {
  return _then(_WatchGift(
null == giftId ? _self.giftId : giftId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GiftUpdated implements GiftEvent {
  const _GiftUpdated(this.gift);
  

 final  Gift gift;

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftUpdatedCopyWith<_GiftUpdated> get copyWith => __$GiftUpdatedCopyWithImpl<_GiftUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftUpdated&&(identical(other.gift, gift) || other.gift == gift));
}


@override
int get hashCode => Object.hash(runtimeType,gift);

@override
String toString() {
  return 'GiftEvent.giftUpdated(gift: $gift)';
}


}

/// @nodoc
abstract mixin class _$GiftUpdatedCopyWith<$Res> implements $GiftEventCopyWith<$Res> {
  factory _$GiftUpdatedCopyWith(_GiftUpdated value, $Res Function(_GiftUpdated) _then) = __$GiftUpdatedCopyWithImpl;
@useResult
$Res call({
 Gift gift
});


$GiftCopyWith<$Res> get gift;

}
/// @nodoc
class __$GiftUpdatedCopyWithImpl<$Res>
    implements _$GiftUpdatedCopyWith<$Res> {
  __$GiftUpdatedCopyWithImpl(this._self, this._then);

  final _GiftUpdated _self;
  final $Res Function(_GiftUpdated) _then;

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? gift = null,}) {
  return _then(_GiftUpdated(
null == gift ? _self.gift : gift // ignore: cast_nullable_to_non_nullable
as Gift,
  ));
}

/// Create a copy of GiftEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftCopyWith<$Res> get gift {
  
  return $GiftCopyWith<$Res>(_self.gift, (value) {
    return _then(_self.copyWith(gift: value));
  });
}
}

/// @nodoc


class _LoadGiftStats implements GiftEvent {
  const _LoadGiftStats();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadGiftStats);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GiftEvent.loadGiftStats()';
}


}




/// @nodoc


class _ClearError implements GiftEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GiftEvent.clearError()';
}


}




/// @nodoc


class _Reset implements GiftEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GiftEvent.reset()';
}


}




/// @nodoc
mixin _$GiftState {

 List<Gift> get sentGifts; List<Gift> get receivedGifts; Gift? get activeGift; GiftStats? get stats; bool get isLoading; bool get isSending; bool get isClaiming; String? get errorMessage;
/// Create a copy of GiftState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftStateCopyWith<GiftState> get copyWith => _$GiftStateCopyWithImpl<GiftState>(this as GiftState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftState&&const DeepCollectionEquality().equals(other.sentGifts, sentGifts)&&const DeepCollectionEquality().equals(other.receivedGifts, receivedGifts)&&(identical(other.activeGift, activeGift) || other.activeGift == activeGift)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.isClaiming, isClaiming) || other.isClaiming == isClaiming)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sentGifts),const DeepCollectionEquality().hash(receivedGifts),activeGift,stats,isLoading,isSending,isClaiming,errorMessage);

@override
String toString() {
  return 'GiftState(sentGifts: $sentGifts, receivedGifts: $receivedGifts, activeGift: $activeGift, stats: $stats, isLoading: $isLoading, isSending: $isSending, isClaiming: $isClaiming, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $GiftStateCopyWith<$Res>  {
  factory $GiftStateCopyWith(GiftState value, $Res Function(GiftState) _then) = _$GiftStateCopyWithImpl;
@useResult
$Res call({
 List<Gift> sentGifts, List<Gift> receivedGifts, Gift? activeGift, GiftStats? stats, bool isLoading, bool isSending, bool isClaiming, String? errorMessage
});


$GiftCopyWith<$Res>? get activeGift;$GiftStatsCopyWith<$Res>? get stats;

}
/// @nodoc
class _$GiftStateCopyWithImpl<$Res>
    implements $GiftStateCopyWith<$Res> {
  _$GiftStateCopyWithImpl(this._self, this._then);

  final GiftState _self;
  final $Res Function(GiftState) _then;

/// Create a copy of GiftState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sentGifts = null,Object? receivedGifts = null,Object? activeGift = freezed,Object? stats = freezed,Object? isLoading = null,Object? isSending = null,Object? isClaiming = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
sentGifts: null == sentGifts ? _self.sentGifts : sentGifts // ignore: cast_nullable_to_non_nullable
as List<Gift>,receivedGifts: null == receivedGifts ? _self.receivedGifts : receivedGifts // ignore: cast_nullable_to_non_nullable
as List<Gift>,activeGift: freezed == activeGift ? _self.activeGift : activeGift // ignore: cast_nullable_to_non_nullable
as Gift?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as GiftStats?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,isClaiming: null == isClaiming ? _self.isClaiming : isClaiming // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GiftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftCopyWith<$Res>? get activeGift {
    if (_self.activeGift == null) {
    return null;
  }

  return $GiftCopyWith<$Res>(_self.activeGift!, (value) {
    return _then(_self.copyWith(activeGift: value));
  });
}/// Create a copy of GiftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $GiftStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// Adds pattern-matching-related methods to [GiftState].
extension GiftStatePatterns on GiftState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftState value)  $default,){
final _that = this;
switch (_that) {
case _GiftState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftState value)?  $default,){
final _that = this;
switch (_that) {
case _GiftState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Gift> sentGifts,  List<Gift> receivedGifts,  Gift? activeGift,  GiftStats? stats,  bool isLoading,  bool isSending,  bool isClaiming,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftState() when $default != null:
return $default(_that.sentGifts,_that.receivedGifts,_that.activeGift,_that.stats,_that.isLoading,_that.isSending,_that.isClaiming,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Gift> sentGifts,  List<Gift> receivedGifts,  Gift? activeGift,  GiftStats? stats,  bool isLoading,  bool isSending,  bool isClaiming,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _GiftState():
return $default(_that.sentGifts,_that.receivedGifts,_that.activeGift,_that.stats,_that.isLoading,_that.isSending,_that.isClaiming,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Gift> sentGifts,  List<Gift> receivedGifts,  Gift? activeGift,  GiftStats? stats,  bool isLoading,  bool isSending,  bool isClaiming,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _GiftState() when $default != null:
return $default(_that.sentGifts,_that.receivedGifts,_that.activeGift,_that.stats,_that.isLoading,_that.isSending,_that.isClaiming,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _GiftState implements GiftState {
  const _GiftState({final  List<Gift> sentGifts = const [], final  List<Gift> receivedGifts = const [], this.activeGift, this.stats, this.isLoading = false, this.isSending = false, this.isClaiming = false, this.errorMessage}): _sentGifts = sentGifts,_receivedGifts = receivedGifts;
  

 final  List<Gift> _sentGifts;
@override@JsonKey() List<Gift> get sentGifts {
  if (_sentGifts is EqualUnmodifiableListView) return _sentGifts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sentGifts);
}

 final  List<Gift> _receivedGifts;
@override@JsonKey() List<Gift> get receivedGifts {
  if (_receivedGifts is EqualUnmodifiableListView) return _receivedGifts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_receivedGifts);
}

@override final  Gift? activeGift;
@override final  GiftStats? stats;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSending;
@override@JsonKey() final  bool isClaiming;
@override final  String? errorMessage;

/// Create a copy of GiftState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftStateCopyWith<_GiftState> get copyWith => __$GiftStateCopyWithImpl<_GiftState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftState&&const DeepCollectionEquality().equals(other._sentGifts, _sentGifts)&&const DeepCollectionEquality().equals(other._receivedGifts, _receivedGifts)&&(identical(other.activeGift, activeGift) || other.activeGift == activeGift)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.isClaiming, isClaiming) || other.isClaiming == isClaiming)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sentGifts),const DeepCollectionEquality().hash(_receivedGifts),activeGift,stats,isLoading,isSending,isClaiming,errorMessage);

@override
String toString() {
  return 'GiftState(sentGifts: $sentGifts, receivedGifts: $receivedGifts, activeGift: $activeGift, stats: $stats, isLoading: $isLoading, isSending: $isSending, isClaiming: $isClaiming, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$GiftStateCopyWith<$Res> implements $GiftStateCopyWith<$Res> {
  factory _$GiftStateCopyWith(_GiftState value, $Res Function(_GiftState) _then) = __$GiftStateCopyWithImpl;
@override @useResult
$Res call({
 List<Gift> sentGifts, List<Gift> receivedGifts, Gift? activeGift, GiftStats? stats, bool isLoading, bool isSending, bool isClaiming, String? errorMessage
});


@override $GiftCopyWith<$Res>? get activeGift;@override $GiftStatsCopyWith<$Res>? get stats;

}
/// @nodoc
class __$GiftStateCopyWithImpl<$Res>
    implements _$GiftStateCopyWith<$Res> {
  __$GiftStateCopyWithImpl(this._self, this._then);

  final _GiftState _self;
  final $Res Function(_GiftState) _then;

/// Create a copy of GiftState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentGifts = null,Object? receivedGifts = null,Object? activeGift = freezed,Object? stats = freezed,Object? isLoading = null,Object? isSending = null,Object? isClaiming = null,Object? errorMessage = freezed,}) {
  return _then(_GiftState(
sentGifts: null == sentGifts ? _self._sentGifts : sentGifts // ignore: cast_nullable_to_non_nullable
as List<Gift>,receivedGifts: null == receivedGifts ? _self._receivedGifts : receivedGifts // ignore: cast_nullable_to_non_nullable
as List<Gift>,activeGift: freezed == activeGift ? _self.activeGift : activeGift // ignore: cast_nullable_to_non_nullable
as Gift?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as GiftStats?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,isClaiming: null == isClaiming ? _self.isClaiming : isClaiming // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GiftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftCopyWith<$Res>? get activeGift {
    if (_self.activeGift == null) {
    return null;
  }

  return $GiftCopyWith<$Res>(_self.activeGift!, (value) {
    return _then(_self.copyWith(activeGift: value));
  });
}/// Create a copy of GiftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GiftStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $GiftStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}

// dart format on
