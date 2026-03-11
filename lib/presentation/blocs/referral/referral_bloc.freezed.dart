// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReferralEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferralEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReferralEvent()';
}


}

/// @nodoc
class $ReferralEventCopyWith<$Res>  {
$ReferralEventCopyWith(ReferralEvent _, $Res Function(ReferralEvent) __);
}


/// Adds pattern-matching-related methods to [ReferralEvent].
extension ReferralEventPatterns on ReferralEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadStats value)?  loadStats,TResult Function( _LoadReferrals value)?  loadReferrals,TResult Function( _WatchReferrals value)?  watchReferrals,TResult Function( _ReferralsUpdated value)?  referralsUpdated,TResult Function( _ApplyCode value)?  applyCode,TResult Function( _ShareReferral value)?  shareReferral,TResult Function( _CopyCode value)?  copyCode,TResult Function( _ValidateCode value)?  validateCode,TResult Function( _LoadLeaderboard value)?  loadLeaderboard,TResult Function( _ClearError value)?  clearError,TResult Function( _ClearSuccess value)?  clearSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadStats() when loadStats != null:
return loadStats(_that);case _LoadReferrals() when loadReferrals != null:
return loadReferrals(_that);case _WatchReferrals() when watchReferrals != null:
return watchReferrals(_that);case _ReferralsUpdated() when referralsUpdated != null:
return referralsUpdated(_that);case _ApplyCode() when applyCode != null:
return applyCode(_that);case _ShareReferral() when shareReferral != null:
return shareReferral(_that);case _CopyCode() when copyCode != null:
return copyCode(_that);case _ValidateCode() when validateCode != null:
return validateCode(_that);case _LoadLeaderboard() when loadLeaderboard != null:
return loadLeaderboard(_that);case _ClearError() when clearError != null:
return clearError(_that);case _ClearSuccess() when clearSuccess != null:
return clearSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadStats value)  loadStats,required TResult Function( _LoadReferrals value)  loadReferrals,required TResult Function( _WatchReferrals value)  watchReferrals,required TResult Function( _ReferralsUpdated value)  referralsUpdated,required TResult Function( _ApplyCode value)  applyCode,required TResult Function( _ShareReferral value)  shareReferral,required TResult Function( _CopyCode value)  copyCode,required TResult Function( _ValidateCode value)  validateCode,required TResult Function( _LoadLeaderboard value)  loadLeaderboard,required TResult Function( _ClearError value)  clearError,required TResult Function( _ClearSuccess value)  clearSuccess,}){
final _that = this;
switch (_that) {
case _LoadStats():
return loadStats(_that);case _LoadReferrals():
return loadReferrals(_that);case _WatchReferrals():
return watchReferrals(_that);case _ReferralsUpdated():
return referralsUpdated(_that);case _ApplyCode():
return applyCode(_that);case _ShareReferral():
return shareReferral(_that);case _CopyCode():
return copyCode(_that);case _ValidateCode():
return validateCode(_that);case _LoadLeaderboard():
return loadLeaderboard(_that);case _ClearError():
return clearError(_that);case _ClearSuccess():
return clearSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadStats value)?  loadStats,TResult? Function( _LoadReferrals value)?  loadReferrals,TResult? Function( _WatchReferrals value)?  watchReferrals,TResult? Function( _ReferralsUpdated value)?  referralsUpdated,TResult? Function( _ApplyCode value)?  applyCode,TResult? Function( _ShareReferral value)?  shareReferral,TResult? Function( _CopyCode value)?  copyCode,TResult? Function( _ValidateCode value)?  validateCode,TResult? Function( _LoadLeaderboard value)?  loadLeaderboard,TResult? Function( _ClearError value)?  clearError,TResult? Function( _ClearSuccess value)?  clearSuccess,}){
final _that = this;
switch (_that) {
case _LoadStats() when loadStats != null:
return loadStats(_that);case _LoadReferrals() when loadReferrals != null:
return loadReferrals(_that);case _WatchReferrals() when watchReferrals != null:
return watchReferrals(_that);case _ReferralsUpdated() when referralsUpdated != null:
return referralsUpdated(_that);case _ApplyCode() when applyCode != null:
return applyCode(_that);case _ShareReferral() when shareReferral != null:
return shareReferral(_that);case _CopyCode() when copyCode != null:
return copyCode(_that);case _ValidateCode() when validateCode != null:
return validateCode(_that);case _LoadLeaderboard() when loadLeaderboard != null:
return loadLeaderboard(_that);case _ClearError() when clearError != null:
return clearError(_that);case _ClearSuccess() when clearSuccess != null:
return clearSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadStats,TResult Function( ReferralStatus? status,  int? limit,  DateTime? startAfter)?  loadReferrals,TResult Function()?  watchReferrals,TResult Function( List<Referral> referrals)?  referralsUpdated,TResult Function( String code)?  applyCode,TResult Function( String platform,  String? customMessage)?  shareReferral,TResult Function()?  copyCode,TResult Function( String code)?  validateCode,TResult Function( int? limit)?  loadLeaderboard,TResult Function()?  clearError,TResult Function()?  clearSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadStats() when loadStats != null:
return loadStats();case _LoadReferrals() when loadReferrals != null:
return loadReferrals(_that.status,_that.limit,_that.startAfter);case _WatchReferrals() when watchReferrals != null:
return watchReferrals();case _ReferralsUpdated() when referralsUpdated != null:
return referralsUpdated(_that.referrals);case _ApplyCode() when applyCode != null:
return applyCode(_that.code);case _ShareReferral() when shareReferral != null:
return shareReferral(_that.platform,_that.customMessage);case _CopyCode() when copyCode != null:
return copyCode();case _ValidateCode() when validateCode != null:
return validateCode(_that.code);case _LoadLeaderboard() when loadLeaderboard != null:
return loadLeaderboard(_that.limit);case _ClearError() when clearError != null:
return clearError();case _ClearSuccess() when clearSuccess != null:
return clearSuccess();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadStats,required TResult Function( ReferralStatus? status,  int? limit,  DateTime? startAfter)  loadReferrals,required TResult Function()  watchReferrals,required TResult Function( List<Referral> referrals)  referralsUpdated,required TResult Function( String code)  applyCode,required TResult Function( String platform,  String? customMessage)  shareReferral,required TResult Function()  copyCode,required TResult Function( String code)  validateCode,required TResult Function( int? limit)  loadLeaderboard,required TResult Function()  clearError,required TResult Function()  clearSuccess,}) {final _that = this;
switch (_that) {
case _LoadStats():
return loadStats();case _LoadReferrals():
return loadReferrals(_that.status,_that.limit,_that.startAfter);case _WatchReferrals():
return watchReferrals();case _ReferralsUpdated():
return referralsUpdated(_that.referrals);case _ApplyCode():
return applyCode(_that.code);case _ShareReferral():
return shareReferral(_that.platform,_that.customMessage);case _CopyCode():
return copyCode();case _ValidateCode():
return validateCode(_that.code);case _LoadLeaderboard():
return loadLeaderboard(_that.limit);case _ClearError():
return clearError();case _ClearSuccess():
return clearSuccess();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadStats,TResult? Function( ReferralStatus? status,  int? limit,  DateTime? startAfter)?  loadReferrals,TResult? Function()?  watchReferrals,TResult? Function( List<Referral> referrals)?  referralsUpdated,TResult? Function( String code)?  applyCode,TResult? Function( String platform,  String? customMessage)?  shareReferral,TResult? Function()?  copyCode,TResult? Function( String code)?  validateCode,TResult? Function( int? limit)?  loadLeaderboard,TResult? Function()?  clearError,TResult? Function()?  clearSuccess,}) {final _that = this;
switch (_that) {
case _LoadStats() when loadStats != null:
return loadStats();case _LoadReferrals() when loadReferrals != null:
return loadReferrals(_that.status,_that.limit,_that.startAfter);case _WatchReferrals() when watchReferrals != null:
return watchReferrals();case _ReferralsUpdated() when referralsUpdated != null:
return referralsUpdated(_that.referrals);case _ApplyCode() when applyCode != null:
return applyCode(_that.code);case _ShareReferral() when shareReferral != null:
return shareReferral(_that.platform,_that.customMessage);case _CopyCode() when copyCode != null:
return copyCode();case _ValidateCode() when validateCode != null:
return validateCode(_that.code);case _LoadLeaderboard() when loadLeaderboard != null:
return loadLeaderboard(_that.limit);case _ClearError() when clearError != null:
return clearError();case _ClearSuccess() when clearSuccess != null:
return clearSuccess();case _:
  return null;

}
}

}

/// @nodoc


class _LoadStats implements ReferralEvent {
  const _LoadStats();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadStats);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReferralEvent.loadStats()';
}


}




/// @nodoc


class _LoadReferrals implements ReferralEvent {
  const _LoadReferrals({this.status, this.limit, this.startAfter});
  

 final  ReferralStatus? status;
 final  int? limit;
 final  DateTime? startAfter;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadReferralsCopyWith<_LoadReferrals> get copyWith => __$LoadReferralsCopyWithImpl<_LoadReferrals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadReferrals&&(identical(other.status, status) || other.status == status)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.startAfter, startAfter) || other.startAfter == startAfter));
}


@override
int get hashCode => Object.hash(runtimeType,status,limit,startAfter);

@override
String toString() {
  return 'ReferralEvent.loadReferrals(status: $status, limit: $limit, startAfter: $startAfter)';
}


}

/// @nodoc
abstract mixin class _$LoadReferralsCopyWith<$Res> implements $ReferralEventCopyWith<$Res> {
  factory _$LoadReferralsCopyWith(_LoadReferrals value, $Res Function(_LoadReferrals) _then) = __$LoadReferralsCopyWithImpl;
@useResult
$Res call({
 ReferralStatus? status, int? limit, DateTime? startAfter
});




}
/// @nodoc
class __$LoadReferralsCopyWithImpl<$Res>
    implements _$LoadReferralsCopyWith<$Res> {
  __$LoadReferralsCopyWithImpl(this._self, this._then);

  final _LoadReferrals _self;
  final $Res Function(_LoadReferrals) _then;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? limit = freezed,Object? startAfter = freezed,}) {
  return _then(_LoadReferrals(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReferralStatus?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,startAfter: freezed == startAfter ? _self.startAfter : startAfter // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _WatchReferrals implements ReferralEvent {
  const _WatchReferrals();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchReferrals);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReferralEvent.watchReferrals()';
}


}




/// @nodoc


class _ReferralsUpdated implements ReferralEvent {
  const _ReferralsUpdated(final  List<Referral> referrals): _referrals = referrals;
  

 final  List<Referral> _referrals;
 List<Referral> get referrals {
  if (_referrals is EqualUnmodifiableListView) return _referrals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_referrals);
}


/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferralsUpdatedCopyWith<_ReferralsUpdated> get copyWith => __$ReferralsUpdatedCopyWithImpl<_ReferralsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferralsUpdated&&const DeepCollectionEquality().equals(other._referrals, _referrals));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_referrals));

@override
String toString() {
  return 'ReferralEvent.referralsUpdated(referrals: $referrals)';
}


}

/// @nodoc
abstract mixin class _$ReferralsUpdatedCopyWith<$Res> implements $ReferralEventCopyWith<$Res> {
  factory _$ReferralsUpdatedCopyWith(_ReferralsUpdated value, $Res Function(_ReferralsUpdated) _then) = __$ReferralsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<Referral> referrals
});




}
/// @nodoc
class __$ReferralsUpdatedCopyWithImpl<$Res>
    implements _$ReferralsUpdatedCopyWith<$Res> {
  __$ReferralsUpdatedCopyWithImpl(this._self, this._then);

  final _ReferralsUpdated _self;
  final $Res Function(_ReferralsUpdated) _then;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? referrals = null,}) {
  return _then(_ReferralsUpdated(
null == referrals ? _self._referrals : referrals // ignore: cast_nullable_to_non_nullable
as List<Referral>,
  ));
}


}

/// @nodoc


class _ApplyCode implements ReferralEvent {
  const _ApplyCode(this.code);
  

 final  String code;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyCodeCopyWith<_ApplyCode> get copyWith => __$ApplyCodeCopyWithImpl<_ApplyCode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyCode&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'ReferralEvent.applyCode(code: $code)';
}


}

/// @nodoc
abstract mixin class _$ApplyCodeCopyWith<$Res> implements $ReferralEventCopyWith<$Res> {
  factory _$ApplyCodeCopyWith(_ApplyCode value, $Res Function(_ApplyCode) _then) = __$ApplyCodeCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class __$ApplyCodeCopyWithImpl<$Res>
    implements _$ApplyCodeCopyWith<$Res> {
  __$ApplyCodeCopyWithImpl(this._self, this._then);

  final _ApplyCode _self;
  final $Res Function(_ApplyCode) _then;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_ApplyCode(
null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ShareReferral implements ReferralEvent {
  const _ShareReferral({required this.platform, this.customMessage});
  

 final  String platform;
 final  String? customMessage;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShareReferralCopyWith<_ShareReferral> get copyWith => __$ShareReferralCopyWithImpl<_ShareReferral>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareReferral&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.customMessage, customMessage) || other.customMessage == customMessage));
}


@override
int get hashCode => Object.hash(runtimeType,platform,customMessage);

@override
String toString() {
  return 'ReferralEvent.shareReferral(platform: $platform, customMessage: $customMessage)';
}


}

/// @nodoc
abstract mixin class _$ShareReferralCopyWith<$Res> implements $ReferralEventCopyWith<$Res> {
  factory _$ShareReferralCopyWith(_ShareReferral value, $Res Function(_ShareReferral) _then) = __$ShareReferralCopyWithImpl;
@useResult
$Res call({
 String platform, String? customMessage
});




}
/// @nodoc
class __$ShareReferralCopyWithImpl<$Res>
    implements _$ShareReferralCopyWith<$Res> {
  __$ShareReferralCopyWithImpl(this._self, this._then);

  final _ShareReferral _self;
  final $Res Function(_ShareReferral) _then;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? platform = null,Object? customMessage = freezed,}) {
  return _then(_ShareReferral(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,customMessage: freezed == customMessage ? _self.customMessage : customMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _CopyCode implements ReferralEvent {
  const _CopyCode();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CopyCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReferralEvent.copyCode()';
}


}




/// @nodoc


class _ValidateCode implements ReferralEvent {
  const _ValidateCode(this.code);
  

 final  String code;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidateCodeCopyWith<_ValidateCode> get copyWith => __$ValidateCodeCopyWithImpl<_ValidateCode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidateCode&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'ReferralEvent.validateCode(code: $code)';
}


}

/// @nodoc
abstract mixin class _$ValidateCodeCopyWith<$Res> implements $ReferralEventCopyWith<$Res> {
  factory _$ValidateCodeCopyWith(_ValidateCode value, $Res Function(_ValidateCode) _then) = __$ValidateCodeCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class __$ValidateCodeCopyWithImpl<$Res>
    implements _$ValidateCodeCopyWith<$Res> {
  __$ValidateCodeCopyWithImpl(this._self, this._then);

  final _ValidateCode _self;
  final $Res Function(_ValidateCode) _then;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_ValidateCode(
null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadLeaderboard implements ReferralEvent {
  const _LoadLeaderboard({this.limit});
  

 final  int? limit;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadLeaderboardCopyWith<_LoadLeaderboard> get copyWith => __$LoadLeaderboardCopyWithImpl<_LoadLeaderboard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadLeaderboard&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,limit);

@override
String toString() {
  return 'ReferralEvent.loadLeaderboard(limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$LoadLeaderboardCopyWith<$Res> implements $ReferralEventCopyWith<$Res> {
  factory _$LoadLeaderboardCopyWith(_LoadLeaderboard value, $Res Function(_LoadLeaderboard) _then) = __$LoadLeaderboardCopyWithImpl;
@useResult
$Res call({
 int? limit
});




}
/// @nodoc
class __$LoadLeaderboardCopyWithImpl<$Res>
    implements _$LoadLeaderboardCopyWith<$Res> {
  __$LoadLeaderboardCopyWithImpl(this._self, this._then);

  final _LoadLeaderboard _self;
  final $Res Function(_LoadLeaderboard) _then;

/// Create a copy of ReferralEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? limit = freezed,}) {
  return _then(_LoadLeaderboard(
limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _ClearError implements ReferralEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReferralEvent.clearError()';
}


}




/// @nodoc


class _ClearSuccess implements ReferralEvent {
  const _ClearSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReferralEvent.clearSuccess()';
}


}




/// @nodoc
mixin _$ReferralState {

 bool get isLoading; bool get isLoadingReferrals; bool get isLoadingLeaderboard; bool get isApplying; bool get isSharing; bool get isValidating; ReferralStats? get stats; List<Referral> get referrals; List<ReferralStats> get leaderboard; bool get hasMoreReferrals; Referral? get appliedReferral; bool? get isCodeValid; String? get errorMessage; String? get successMessage;
/// Create a copy of ReferralState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferralStateCopyWith<ReferralState> get copyWith => _$ReferralStateCopyWithImpl<ReferralState>(this as ReferralState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferralState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingReferrals, isLoadingReferrals) || other.isLoadingReferrals == isLoadingReferrals)&&(identical(other.isLoadingLeaderboard, isLoadingLeaderboard) || other.isLoadingLeaderboard == isLoadingLeaderboard)&&(identical(other.isApplying, isApplying) || other.isApplying == isApplying)&&(identical(other.isSharing, isSharing) || other.isSharing == isSharing)&&(identical(other.isValidating, isValidating) || other.isValidating == isValidating)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other.referrals, referrals)&&const DeepCollectionEquality().equals(other.leaderboard, leaderboard)&&(identical(other.hasMoreReferrals, hasMoreReferrals) || other.hasMoreReferrals == hasMoreReferrals)&&(identical(other.appliedReferral, appliedReferral) || other.appliedReferral == appliedReferral)&&(identical(other.isCodeValid, isCodeValid) || other.isCodeValid == isCodeValid)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingReferrals,isLoadingLeaderboard,isApplying,isSharing,isValidating,stats,const DeepCollectionEquality().hash(referrals),const DeepCollectionEquality().hash(leaderboard),hasMoreReferrals,appliedReferral,isCodeValid,errorMessage,successMessage);

@override
String toString() {
  return 'ReferralState(isLoading: $isLoading, isLoadingReferrals: $isLoadingReferrals, isLoadingLeaderboard: $isLoadingLeaderboard, isApplying: $isApplying, isSharing: $isSharing, isValidating: $isValidating, stats: $stats, referrals: $referrals, leaderboard: $leaderboard, hasMoreReferrals: $hasMoreReferrals, appliedReferral: $appliedReferral, isCodeValid: $isCodeValid, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $ReferralStateCopyWith<$Res>  {
  factory $ReferralStateCopyWith(ReferralState value, $Res Function(ReferralState) _then) = _$ReferralStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingReferrals, bool isLoadingLeaderboard, bool isApplying, bool isSharing, bool isValidating, ReferralStats? stats, List<Referral> referrals, List<ReferralStats> leaderboard, bool hasMoreReferrals, Referral? appliedReferral, bool? isCodeValid, String? errorMessage, String? successMessage
});


$ReferralStatsCopyWith<$Res>? get stats;$ReferralCopyWith<$Res>? get appliedReferral;

}
/// @nodoc
class _$ReferralStateCopyWithImpl<$Res>
    implements $ReferralStateCopyWith<$Res> {
  _$ReferralStateCopyWithImpl(this._self, this._then);

  final ReferralState _self;
  final $Res Function(ReferralState) _then;

/// Create a copy of ReferralState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingReferrals = null,Object? isLoadingLeaderboard = null,Object? isApplying = null,Object? isSharing = null,Object? isValidating = null,Object? stats = freezed,Object? referrals = null,Object? leaderboard = null,Object? hasMoreReferrals = null,Object? appliedReferral = freezed,Object? isCodeValid = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingReferrals: null == isLoadingReferrals ? _self.isLoadingReferrals : isLoadingReferrals // ignore: cast_nullable_to_non_nullable
as bool,isLoadingLeaderboard: null == isLoadingLeaderboard ? _self.isLoadingLeaderboard : isLoadingLeaderboard // ignore: cast_nullable_to_non_nullable
as bool,isApplying: null == isApplying ? _self.isApplying : isApplying // ignore: cast_nullable_to_non_nullable
as bool,isSharing: null == isSharing ? _self.isSharing : isSharing // ignore: cast_nullable_to_non_nullable
as bool,isValidating: null == isValidating ? _self.isValidating : isValidating // ignore: cast_nullable_to_non_nullable
as bool,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ReferralStats?,referrals: null == referrals ? _self.referrals : referrals // ignore: cast_nullable_to_non_nullable
as List<Referral>,leaderboard: null == leaderboard ? _self.leaderboard : leaderboard // ignore: cast_nullable_to_non_nullable
as List<ReferralStats>,hasMoreReferrals: null == hasMoreReferrals ? _self.hasMoreReferrals : hasMoreReferrals // ignore: cast_nullable_to_non_nullable
as bool,appliedReferral: freezed == appliedReferral ? _self.appliedReferral : appliedReferral // ignore: cast_nullable_to_non_nullable
as Referral?,isCodeValid: freezed == isCodeValid ? _self.isCodeValid : isCodeValid // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ReferralState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReferralStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $ReferralStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of ReferralState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReferralCopyWith<$Res>? get appliedReferral {
    if (_self.appliedReferral == null) {
    return null;
  }

  return $ReferralCopyWith<$Res>(_self.appliedReferral!, (value) {
    return _then(_self.copyWith(appliedReferral: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReferralState].
extension ReferralStatePatterns on ReferralState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReferralState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReferralState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReferralState value)  $default,){
final _that = this;
switch (_that) {
case _ReferralState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReferralState value)?  $default,){
final _that = this;
switch (_that) {
case _ReferralState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingReferrals,  bool isLoadingLeaderboard,  bool isApplying,  bool isSharing,  bool isValidating,  ReferralStats? stats,  List<Referral> referrals,  List<ReferralStats> leaderboard,  bool hasMoreReferrals,  Referral? appliedReferral,  bool? isCodeValid,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReferralState() when $default != null:
return $default(_that.isLoading,_that.isLoadingReferrals,_that.isLoadingLeaderboard,_that.isApplying,_that.isSharing,_that.isValidating,_that.stats,_that.referrals,_that.leaderboard,_that.hasMoreReferrals,_that.appliedReferral,_that.isCodeValid,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingReferrals,  bool isLoadingLeaderboard,  bool isApplying,  bool isSharing,  bool isValidating,  ReferralStats? stats,  List<Referral> referrals,  List<ReferralStats> leaderboard,  bool hasMoreReferrals,  Referral? appliedReferral,  bool? isCodeValid,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _ReferralState():
return $default(_that.isLoading,_that.isLoadingReferrals,_that.isLoadingLeaderboard,_that.isApplying,_that.isSharing,_that.isValidating,_that.stats,_that.referrals,_that.leaderboard,_that.hasMoreReferrals,_that.appliedReferral,_that.isCodeValid,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isLoadingReferrals,  bool isLoadingLeaderboard,  bool isApplying,  bool isSharing,  bool isValidating,  ReferralStats? stats,  List<Referral> referrals,  List<ReferralStats> leaderboard,  bool hasMoreReferrals,  Referral? appliedReferral,  bool? isCodeValid,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _ReferralState() when $default != null:
return $default(_that.isLoading,_that.isLoadingReferrals,_that.isLoadingLeaderboard,_that.isApplying,_that.isSharing,_that.isValidating,_that.stats,_that.referrals,_that.leaderboard,_that.hasMoreReferrals,_that.appliedReferral,_that.isCodeValid,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ReferralState implements ReferralState {
  const _ReferralState({this.isLoading = false, this.isLoadingReferrals = false, this.isLoadingLeaderboard = false, this.isApplying = false, this.isSharing = false, this.isValidating = false, this.stats, final  List<Referral> referrals = const [], final  List<ReferralStats> leaderboard = const [], this.hasMoreReferrals = false, this.appliedReferral, this.isCodeValid, this.errorMessage, this.successMessage}): _referrals = referrals,_leaderboard = leaderboard;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingReferrals;
@override@JsonKey() final  bool isLoadingLeaderboard;
@override@JsonKey() final  bool isApplying;
@override@JsonKey() final  bool isSharing;
@override@JsonKey() final  bool isValidating;
@override final  ReferralStats? stats;
 final  List<Referral> _referrals;
@override@JsonKey() List<Referral> get referrals {
  if (_referrals is EqualUnmodifiableListView) return _referrals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_referrals);
}

 final  List<ReferralStats> _leaderboard;
@override@JsonKey() List<ReferralStats> get leaderboard {
  if (_leaderboard is EqualUnmodifiableListView) return _leaderboard;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leaderboard);
}

@override@JsonKey() final  bool hasMoreReferrals;
@override final  Referral? appliedReferral;
@override final  bool? isCodeValid;
@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of ReferralState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferralStateCopyWith<_ReferralState> get copyWith => __$ReferralStateCopyWithImpl<_ReferralState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferralState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingReferrals, isLoadingReferrals) || other.isLoadingReferrals == isLoadingReferrals)&&(identical(other.isLoadingLeaderboard, isLoadingLeaderboard) || other.isLoadingLeaderboard == isLoadingLeaderboard)&&(identical(other.isApplying, isApplying) || other.isApplying == isApplying)&&(identical(other.isSharing, isSharing) || other.isSharing == isSharing)&&(identical(other.isValidating, isValidating) || other.isValidating == isValidating)&&(identical(other.stats, stats) || other.stats == stats)&&const DeepCollectionEquality().equals(other._referrals, _referrals)&&const DeepCollectionEquality().equals(other._leaderboard, _leaderboard)&&(identical(other.hasMoreReferrals, hasMoreReferrals) || other.hasMoreReferrals == hasMoreReferrals)&&(identical(other.appliedReferral, appliedReferral) || other.appliedReferral == appliedReferral)&&(identical(other.isCodeValid, isCodeValid) || other.isCodeValid == isCodeValid)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingReferrals,isLoadingLeaderboard,isApplying,isSharing,isValidating,stats,const DeepCollectionEquality().hash(_referrals),const DeepCollectionEquality().hash(_leaderboard),hasMoreReferrals,appliedReferral,isCodeValid,errorMessage,successMessage);

@override
String toString() {
  return 'ReferralState(isLoading: $isLoading, isLoadingReferrals: $isLoadingReferrals, isLoadingLeaderboard: $isLoadingLeaderboard, isApplying: $isApplying, isSharing: $isSharing, isValidating: $isValidating, stats: $stats, referrals: $referrals, leaderboard: $leaderboard, hasMoreReferrals: $hasMoreReferrals, appliedReferral: $appliedReferral, isCodeValid: $isCodeValid, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$ReferralStateCopyWith<$Res> implements $ReferralStateCopyWith<$Res> {
  factory _$ReferralStateCopyWith(_ReferralState value, $Res Function(_ReferralState) _then) = __$ReferralStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingReferrals, bool isLoadingLeaderboard, bool isApplying, bool isSharing, bool isValidating, ReferralStats? stats, List<Referral> referrals, List<ReferralStats> leaderboard, bool hasMoreReferrals, Referral? appliedReferral, bool? isCodeValid, String? errorMessage, String? successMessage
});


@override $ReferralStatsCopyWith<$Res>? get stats;@override $ReferralCopyWith<$Res>? get appliedReferral;

}
/// @nodoc
class __$ReferralStateCopyWithImpl<$Res>
    implements _$ReferralStateCopyWith<$Res> {
  __$ReferralStateCopyWithImpl(this._self, this._then);

  final _ReferralState _self;
  final $Res Function(_ReferralState) _then;

/// Create a copy of ReferralState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingReferrals = null,Object? isLoadingLeaderboard = null,Object? isApplying = null,Object? isSharing = null,Object? isValidating = null,Object? stats = freezed,Object? referrals = null,Object? leaderboard = null,Object? hasMoreReferrals = null,Object? appliedReferral = freezed,Object? isCodeValid = freezed,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_ReferralState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingReferrals: null == isLoadingReferrals ? _self.isLoadingReferrals : isLoadingReferrals // ignore: cast_nullable_to_non_nullable
as bool,isLoadingLeaderboard: null == isLoadingLeaderboard ? _self.isLoadingLeaderboard : isLoadingLeaderboard // ignore: cast_nullable_to_non_nullable
as bool,isApplying: null == isApplying ? _self.isApplying : isApplying // ignore: cast_nullable_to_non_nullable
as bool,isSharing: null == isSharing ? _self.isSharing : isSharing // ignore: cast_nullable_to_non_nullable
as bool,isValidating: null == isValidating ? _self.isValidating : isValidating // ignore: cast_nullable_to_non_nullable
as bool,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ReferralStats?,referrals: null == referrals ? _self._referrals : referrals // ignore: cast_nullable_to_non_nullable
as List<Referral>,leaderboard: null == leaderboard ? _self._leaderboard : leaderboard // ignore: cast_nullable_to_non_nullable
as List<ReferralStats>,hasMoreReferrals: null == hasMoreReferrals ? _self.hasMoreReferrals : hasMoreReferrals // ignore: cast_nullable_to_non_nullable
as bool,appliedReferral: freezed == appliedReferral ? _self.appliedReferral : appliedReferral // ignore: cast_nullable_to_non_nullable
as Referral?,isCodeValid: freezed == isCodeValid ? _self.isCodeValid : isCodeValid // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ReferralState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReferralStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $ReferralStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of ReferralState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReferralCopyWith<$Res>? get appliedReferral {
    if (_self.appliedReferral == null) {
    return null;
  }

  return $ReferralCopyWith<$Res>(_self.appliedReferral!, (value) {
    return _then(_self.copyWith(appliedReferral: value));
  });
}
}

// dart format on
