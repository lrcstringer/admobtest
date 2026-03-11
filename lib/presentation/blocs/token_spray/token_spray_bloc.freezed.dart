// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_spray_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TokenSprayEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenSprayEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TokenSprayEvent()';
}


}

/// @nodoc
class $TokenSprayEventCopyWith<$Res>  {
$TokenSprayEventCopyWith(TokenSprayEvent _, $Res Function(TokenSprayEvent) __);
}


/// Adds pattern-matching-related methods to [TokenSprayEvent].
extension TokenSprayEventPatterns on TokenSprayEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CreateSpray value)?  createSpray,TResult Function( _Contribute value)?  contribute,TResult Function( _CloseSpray value)?  closeSpray,TResult Function( _ClaimSpray value)?  claimSpray,TResult Function( _WatchSpray value)?  watchSpray,TResult Function( _SprayUpdated value)?  sprayUpdated,TResult Function( _LoadHistory value)?  loadHistory,TResult Function( _ClearError value)?  clearError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateSpray() when createSpray != null:
return createSpray(_that);case _Contribute() when contribute != null:
return contribute(_that);case _CloseSpray() when closeSpray != null:
return closeSpray(_that);case _ClaimSpray() when claimSpray != null:
return claimSpray(_that);case _WatchSpray() when watchSpray != null:
return watchSpray(_that);case _SprayUpdated() when sprayUpdated != null:
return sprayUpdated(_that);case _LoadHistory() when loadHistory != null:
return loadHistory(_that);case _ClearError() when clearError != null:
return clearError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CreateSpray value)  createSpray,required TResult Function( _Contribute value)  contribute,required TResult Function( _CloseSpray value)  closeSpray,required TResult Function( _ClaimSpray value)  claimSpray,required TResult Function( _WatchSpray value)  watchSpray,required TResult Function( _SprayUpdated value)  sprayUpdated,required TResult Function( _LoadHistory value)  loadHistory,required TResult Function( _ClearError value)  clearError,}){
final _that = this;
switch (_that) {
case _CreateSpray():
return createSpray(_that);case _Contribute():
return contribute(_that);case _CloseSpray():
return closeSpray(_that);case _ClaimSpray():
return claimSpray(_that);case _WatchSpray():
return watchSpray(_that);case _SprayUpdated():
return sprayUpdated(_that);case _LoadHistory():
return loadHistory(_that);case _ClearError():
return clearError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CreateSpray value)?  createSpray,TResult? Function( _Contribute value)?  contribute,TResult? Function( _CloseSpray value)?  closeSpray,TResult? Function( _ClaimSpray value)?  claimSpray,TResult? Function( _WatchSpray value)?  watchSpray,TResult? Function( _SprayUpdated value)?  sprayUpdated,TResult? Function( _LoadHistory value)?  loadHistory,TResult? Function( _ClearError value)?  clearError,}){
final _that = this;
switch (_that) {
case _CreateSpray() when createSpray != null:
return createSpray(_that);case _Contribute() when contribute != null:
return contribute(_that);case _CloseSpray() when closeSpray != null:
return closeSpray(_that);case _ClaimSpray() when claimSpray != null:
return claimSpray(_that);case _WatchSpray() when watchSpray != null:
return watchSpray(_that);case _SprayUpdated() when sprayUpdated != null:
return sprayUpdated(_that);case _LoadHistory() when loadHistory != null:
return loadHistory(_that);case _ClearError() when clearError != null:
return clearError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String recipientId,  SprayOccasion occasion,  String message,  int? targetAmount)?  createSpray,TResult Function( String sprayId,  int amount,  String? message)?  contribute,TResult Function( String sprayId)?  closeSpray,TResult Function( String sprayId)?  claimSpray,TResult Function( String sprayId)?  watchSpray,TResult Function( TokenSpray spray)?  sprayUpdated,TResult Function()?  loadHistory,TResult Function()?  clearError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateSpray() when createSpray != null:
return createSpray(_that.recipientId,_that.occasion,_that.message,_that.targetAmount);case _Contribute() when contribute != null:
return contribute(_that.sprayId,_that.amount,_that.message);case _CloseSpray() when closeSpray != null:
return closeSpray(_that.sprayId);case _ClaimSpray() when claimSpray != null:
return claimSpray(_that.sprayId);case _WatchSpray() when watchSpray != null:
return watchSpray(_that.sprayId);case _SprayUpdated() when sprayUpdated != null:
return sprayUpdated(_that.spray);case _LoadHistory() when loadHistory != null:
return loadHistory();case _ClearError() when clearError != null:
return clearError();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String recipientId,  SprayOccasion occasion,  String message,  int? targetAmount)  createSpray,required TResult Function( String sprayId,  int amount,  String? message)  contribute,required TResult Function( String sprayId)  closeSpray,required TResult Function( String sprayId)  claimSpray,required TResult Function( String sprayId)  watchSpray,required TResult Function( TokenSpray spray)  sprayUpdated,required TResult Function()  loadHistory,required TResult Function()  clearError,}) {final _that = this;
switch (_that) {
case _CreateSpray():
return createSpray(_that.recipientId,_that.occasion,_that.message,_that.targetAmount);case _Contribute():
return contribute(_that.sprayId,_that.amount,_that.message);case _CloseSpray():
return closeSpray(_that.sprayId);case _ClaimSpray():
return claimSpray(_that.sprayId);case _WatchSpray():
return watchSpray(_that.sprayId);case _SprayUpdated():
return sprayUpdated(_that.spray);case _LoadHistory():
return loadHistory();case _ClearError():
return clearError();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String recipientId,  SprayOccasion occasion,  String message,  int? targetAmount)?  createSpray,TResult? Function( String sprayId,  int amount,  String? message)?  contribute,TResult? Function( String sprayId)?  closeSpray,TResult? Function( String sprayId)?  claimSpray,TResult? Function( String sprayId)?  watchSpray,TResult? Function( TokenSpray spray)?  sprayUpdated,TResult? Function()?  loadHistory,TResult? Function()?  clearError,}) {final _that = this;
switch (_that) {
case _CreateSpray() when createSpray != null:
return createSpray(_that.recipientId,_that.occasion,_that.message,_that.targetAmount);case _Contribute() when contribute != null:
return contribute(_that.sprayId,_that.amount,_that.message);case _CloseSpray() when closeSpray != null:
return closeSpray(_that.sprayId);case _ClaimSpray() when claimSpray != null:
return claimSpray(_that.sprayId);case _WatchSpray() when watchSpray != null:
return watchSpray(_that.sprayId);case _SprayUpdated() when sprayUpdated != null:
return sprayUpdated(_that.spray);case _LoadHistory() when loadHistory != null:
return loadHistory();case _ClearError() when clearError != null:
return clearError();case _:
  return null;

}
}

}

/// @nodoc


class _CreateSpray implements TokenSprayEvent {
  const _CreateSpray({required this.recipientId, required this.occasion, required this.message, this.targetAmount});
  

 final  String recipientId;
 final  SprayOccasion occasion;
 final  String message;
 final  int? targetAmount;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateSprayCopyWith<_CreateSpray> get copyWith => __$CreateSprayCopyWithImpl<_CreateSpray>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateSpray&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.occasion, occasion) || other.occasion == occasion)&&(identical(other.message, message) || other.message == message)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount));
}


@override
int get hashCode => Object.hash(runtimeType,recipientId,occasion,message,targetAmount);

@override
String toString() {
  return 'TokenSprayEvent.createSpray(recipientId: $recipientId, occasion: $occasion, message: $message, targetAmount: $targetAmount)';
}


}

/// @nodoc
abstract mixin class _$CreateSprayCopyWith<$Res> implements $TokenSprayEventCopyWith<$Res> {
  factory _$CreateSprayCopyWith(_CreateSpray value, $Res Function(_CreateSpray) _then) = __$CreateSprayCopyWithImpl;
@useResult
$Res call({
 String recipientId, SprayOccasion occasion, String message, int? targetAmount
});




}
/// @nodoc
class __$CreateSprayCopyWithImpl<$Res>
    implements _$CreateSprayCopyWith<$Res> {
  __$CreateSprayCopyWithImpl(this._self, this._then);

  final _CreateSpray _self;
  final $Res Function(_CreateSpray) _then;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? recipientId = null,Object? occasion = null,Object? message = null,Object? targetAmount = freezed,}) {
  return _then(_CreateSpray(
recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,occasion: null == occasion ? _self.occasion : occasion // ignore: cast_nullable_to_non_nullable
as SprayOccasion,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _Contribute implements TokenSprayEvent {
  const _Contribute({required this.sprayId, required this.amount, this.message});
  

 final  String sprayId;
 final  int amount;
 final  String? message;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContributeCopyWith<_Contribute> get copyWith => __$ContributeCopyWithImpl<_Contribute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Contribute&&(identical(other.sprayId, sprayId) || other.sprayId == sprayId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,sprayId,amount,message);

@override
String toString() {
  return 'TokenSprayEvent.contribute(sprayId: $sprayId, amount: $amount, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ContributeCopyWith<$Res> implements $TokenSprayEventCopyWith<$Res> {
  factory _$ContributeCopyWith(_Contribute value, $Res Function(_Contribute) _then) = __$ContributeCopyWithImpl;
@useResult
$Res call({
 String sprayId, int amount, String? message
});




}
/// @nodoc
class __$ContributeCopyWithImpl<$Res>
    implements _$ContributeCopyWith<$Res> {
  __$ContributeCopyWithImpl(this._self, this._then);

  final _Contribute _self;
  final $Res Function(_Contribute) _then;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sprayId = null,Object? amount = null,Object? message = freezed,}) {
  return _then(_Contribute(
sprayId: null == sprayId ? _self.sprayId : sprayId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _CloseSpray implements TokenSprayEvent {
  const _CloseSpray(this.sprayId);
  

 final  String sprayId;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CloseSprayCopyWith<_CloseSpray> get copyWith => __$CloseSprayCopyWithImpl<_CloseSpray>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CloseSpray&&(identical(other.sprayId, sprayId) || other.sprayId == sprayId));
}


@override
int get hashCode => Object.hash(runtimeType,sprayId);

@override
String toString() {
  return 'TokenSprayEvent.closeSpray(sprayId: $sprayId)';
}


}

/// @nodoc
abstract mixin class _$CloseSprayCopyWith<$Res> implements $TokenSprayEventCopyWith<$Res> {
  factory _$CloseSprayCopyWith(_CloseSpray value, $Res Function(_CloseSpray) _then) = __$CloseSprayCopyWithImpl;
@useResult
$Res call({
 String sprayId
});




}
/// @nodoc
class __$CloseSprayCopyWithImpl<$Res>
    implements _$CloseSprayCopyWith<$Res> {
  __$CloseSprayCopyWithImpl(this._self, this._then);

  final _CloseSpray _self;
  final $Res Function(_CloseSpray) _then;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sprayId = null,}) {
  return _then(_CloseSpray(
null == sprayId ? _self.sprayId : sprayId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClaimSpray implements TokenSprayEvent {
  const _ClaimSpray(this.sprayId);
  

 final  String sprayId;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimSprayCopyWith<_ClaimSpray> get copyWith => __$ClaimSprayCopyWithImpl<_ClaimSpray>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimSpray&&(identical(other.sprayId, sprayId) || other.sprayId == sprayId));
}


@override
int get hashCode => Object.hash(runtimeType,sprayId);

@override
String toString() {
  return 'TokenSprayEvent.claimSpray(sprayId: $sprayId)';
}


}

/// @nodoc
abstract mixin class _$ClaimSprayCopyWith<$Res> implements $TokenSprayEventCopyWith<$Res> {
  factory _$ClaimSprayCopyWith(_ClaimSpray value, $Res Function(_ClaimSpray) _then) = __$ClaimSprayCopyWithImpl;
@useResult
$Res call({
 String sprayId
});




}
/// @nodoc
class __$ClaimSprayCopyWithImpl<$Res>
    implements _$ClaimSprayCopyWith<$Res> {
  __$ClaimSprayCopyWithImpl(this._self, this._then);

  final _ClaimSpray _self;
  final $Res Function(_ClaimSpray) _then;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sprayId = null,}) {
  return _then(_ClaimSpray(
null == sprayId ? _self.sprayId : sprayId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WatchSpray implements TokenSprayEvent {
  const _WatchSpray(this.sprayId);
  

 final  String sprayId;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchSprayCopyWith<_WatchSpray> get copyWith => __$WatchSprayCopyWithImpl<_WatchSpray>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchSpray&&(identical(other.sprayId, sprayId) || other.sprayId == sprayId));
}


@override
int get hashCode => Object.hash(runtimeType,sprayId);

@override
String toString() {
  return 'TokenSprayEvent.watchSpray(sprayId: $sprayId)';
}


}

/// @nodoc
abstract mixin class _$WatchSprayCopyWith<$Res> implements $TokenSprayEventCopyWith<$Res> {
  factory _$WatchSprayCopyWith(_WatchSpray value, $Res Function(_WatchSpray) _then) = __$WatchSprayCopyWithImpl;
@useResult
$Res call({
 String sprayId
});




}
/// @nodoc
class __$WatchSprayCopyWithImpl<$Res>
    implements _$WatchSprayCopyWith<$Res> {
  __$WatchSprayCopyWithImpl(this._self, this._then);

  final _WatchSpray _self;
  final $Res Function(_WatchSpray) _then;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sprayId = null,}) {
  return _then(_WatchSpray(
null == sprayId ? _self.sprayId : sprayId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SprayUpdated implements TokenSprayEvent {
  const _SprayUpdated(this.spray);
  

 final  TokenSpray spray;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SprayUpdatedCopyWith<_SprayUpdated> get copyWith => __$SprayUpdatedCopyWithImpl<_SprayUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SprayUpdated&&(identical(other.spray, spray) || other.spray == spray));
}


@override
int get hashCode => Object.hash(runtimeType,spray);

@override
String toString() {
  return 'TokenSprayEvent.sprayUpdated(spray: $spray)';
}


}

/// @nodoc
abstract mixin class _$SprayUpdatedCopyWith<$Res> implements $TokenSprayEventCopyWith<$Res> {
  factory _$SprayUpdatedCopyWith(_SprayUpdated value, $Res Function(_SprayUpdated) _then) = __$SprayUpdatedCopyWithImpl;
@useResult
$Res call({
 TokenSpray spray
});


$TokenSprayCopyWith<$Res> get spray;

}
/// @nodoc
class __$SprayUpdatedCopyWithImpl<$Res>
    implements _$SprayUpdatedCopyWith<$Res> {
  __$SprayUpdatedCopyWithImpl(this._self, this._then);

  final _SprayUpdated _self;
  final $Res Function(_SprayUpdated) _then;

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? spray = null,}) {
  return _then(_SprayUpdated(
null == spray ? _self.spray : spray // ignore: cast_nullable_to_non_nullable
as TokenSpray,
  ));
}

/// Create a copy of TokenSprayEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenSprayCopyWith<$Res> get spray {
  
  return $TokenSprayCopyWith<$Res>(_self.spray, (value) {
    return _then(_self.copyWith(spray: value));
  });
}
}

/// @nodoc


class _LoadHistory implements TokenSprayEvent {
  const _LoadHistory();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadHistory);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TokenSprayEvent.loadHistory()';
}


}




/// @nodoc


class _ClearError implements TokenSprayEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TokenSprayEvent.clearError()';
}


}




/// @nodoc
mixin _$TokenSprayState {

 String get communityId; TokenSpray? get activeSpray; List<TokenSpray> get history; bool get isLoading; bool get isContributing; String? get errorMessage;
/// Create a copy of TokenSprayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenSprayStateCopyWith<TokenSprayState> get copyWith => _$TokenSprayStateCopyWithImpl<TokenSprayState>(this as TokenSprayState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenSprayState&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.activeSpray, activeSpray) || other.activeSpray == activeSpray)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isContributing, isContributing) || other.isContributing == isContributing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,activeSpray,const DeepCollectionEquality().hash(history),isLoading,isContributing,errorMessage);

@override
String toString() {
  return 'TokenSprayState(communityId: $communityId, activeSpray: $activeSpray, history: $history, isLoading: $isLoading, isContributing: $isContributing, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TokenSprayStateCopyWith<$Res>  {
  factory $TokenSprayStateCopyWith(TokenSprayState value, $Res Function(TokenSprayState) _then) = _$TokenSprayStateCopyWithImpl;
@useResult
$Res call({
 String communityId, TokenSpray? activeSpray, List<TokenSpray> history, bool isLoading, bool isContributing, String? errorMessage
});


$TokenSprayCopyWith<$Res>? get activeSpray;

}
/// @nodoc
class _$TokenSprayStateCopyWithImpl<$Res>
    implements $TokenSprayStateCopyWith<$Res> {
  _$TokenSprayStateCopyWithImpl(this._self, this._then);

  final TokenSprayState _self;
  final $Res Function(TokenSprayState) _then;

/// Create a copy of TokenSprayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? communityId = null,Object? activeSpray = freezed,Object? history = null,Object? isLoading = null,Object? isContributing = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,activeSpray: freezed == activeSpray ? _self.activeSpray : activeSpray // ignore: cast_nullable_to_non_nullable
as TokenSpray?,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<TokenSpray>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isContributing: null == isContributing ? _self.isContributing : isContributing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TokenSprayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenSprayCopyWith<$Res>? get activeSpray {
    if (_self.activeSpray == null) {
    return null;
  }

  return $TokenSprayCopyWith<$Res>(_self.activeSpray!, (value) {
    return _then(_self.copyWith(activeSpray: value));
  });
}
}


/// Adds pattern-matching-related methods to [TokenSprayState].
extension TokenSprayStatePatterns on TokenSprayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenSprayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenSprayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenSprayState value)  $default,){
final _that = this;
switch (_that) {
case _TokenSprayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenSprayState value)?  $default,){
final _that = this;
switch (_that) {
case _TokenSprayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String communityId,  TokenSpray? activeSpray,  List<TokenSpray> history,  bool isLoading,  bool isContributing,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenSprayState() when $default != null:
return $default(_that.communityId,_that.activeSpray,_that.history,_that.isLoading,_that.isContributing,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String communityId,  TokenSpray? activeSpray,  List<TokenSpray> history,  bool isLoading,  bool isContributing,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TokenSprayState():
return $default(_that.communityId,_that.activeSpray,_that.history,_that.isLoading,_that.isContributing,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String communityId,  TokenSpray? activeSpray,  List<TokenSpray> history,  bool isLoading,  bool isContributing,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TokenSprayState() when $default != null:
return $default(_that.communityId,_that.activeSpray,_that.history,_that.isLoading,_that.isContributing,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TokenSprayState implements TokenSprayState {
  const _TokenSprayState({required this.communityId, this.activeSpray, final  List<TokenSpray> history = const [], this.isLoading = false, this.isContributing = false, this.errorMessage}): _history = history;
  

@override final  String communityId;
@override final  TokenSpray? activeSpray;
 final  List<TokenSpray> _history;
@override@JsonKey() List<TokenSpray> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isContributing;
@override final  String? errorMessage;

/// Create a copy of TokenSprayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenSprayStateCopyWith<_TokenSprayState> get copyWith => __$TokenSprayStateCopyWithImpl<_TokenSprayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenSprayState&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.activeSpray, activeSpray) || other.activeSpray == activeSpray)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isContributing, isContributing) || other.isContributing == isContributing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,communityId,activeSpray,const DeepCollectionEquality().hash(_history),isLoading,isContributing,errorMessage);

@override
String toString() {
  return 'TokenSprayState(communityId: $communityId, activeSpray: $activeSpray, history: $history, isLoading: $isLoading, isContributing: $isContributing, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TokenSprayStateCopyWith<$Res> implements $TokenSprayStateCopyWith<$Res> {
  factory _$TokenSprayStateCopyWith(_TokenSprayState value, $Res Function(_TokenSprayState) _then) = __$TokenSprayStateCopyWithImpl;
@override @useResult
$Res call({
 String communityId, TokenSpray? activeSpray, List<TokenSpray> history, bool isLoading, bool isContributing, String? errorMessage
});


@override $TokenSprayCopyWith<$Res>? get activeSpray;

}
/// @nodoc
class __$TokenSprayStateCopyWithImpl<$Res>
    implements _$TokenSprayStateCopyWith<$Res> {
  __$TokenSprayStateCopyWithImpl(this._self, this._then);

  final _TokenSprayState _self;
  final $Res Function(_TokenSprayState) _then;

/// Create a copy of TokenSprayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? activeSpray = freezed,Object? history = null,Object? isLoading = null,Object? isContributing = null,Object? errorMessage = freezed,}) {
  return _then(_TokenSprayState(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,activeSpray: freezed == activeSpray ? _self.activeSpray : activeSpray // ignore: cast_nullable_to_non_nullable
as TokenSpray?,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<TokenSpray>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isContributing: null == isContributing ? _self.isContributing : isContributing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TokenSprayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenSprayCopyWith<$Res>? get activeSpray {
    if (_self.activeSpray == null) {
    return null;
  }

  return $TokenSprayCopyWith<$Res>(_self.activeSpray!, (value) {
    return _then(_self.copyWith(activeSpray: value));
  });
}
}

// dart format on
