// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkFailure value)?  network,TResult Function( TimeoutFailure value)?  timeout,TResult Function( NoInternetFailure value)?  noInternet,TResult Function( AuthFailure value)?  auth,TResult Function( UnauthenticatedFailure value)?  unauthenticated,TResult Function( InvalidOtpFailure value)?  invalidOtp,TResult Function( OtpExpiredFailure value)?  otpExpired,TResult Function( TooManyAttemptsFailure value)?  tooManyAttempts,TResult Function( DailyCapReachedFailure value)?  dailyCapReached,TResult Function( InsufficientBalanceFailure value)?  insufficientBalance,TResult Function( CashoutNotEligibleFailure value)?  cashoutNotEligible,TResult Function( PotNotEligibleFailure value)?  potNotEligible,TResult Function( UserSuspendedFailure value)?  userSuspended,TResult Function( InvalidPhoneFailure value)?  invalidPhone,TResult Function( InvalidUsernameFailure value)?  invalidUsername,TResult Function( InvalidAmountFailure value)?  invalidAmount,TResult Function( ServerFailure value)?  serverError,TResult Function( UnknownFailure value)?  unknown,TResult Function( StepUpRequiredFailure value)?  stepUpRequired,TResult Function( DeviceNotTrustedFailure value)?  deviceNotTrusted,TResult Function( SimChangedFailure value)?  simChanged,TResult Function( DeviceBindingFailedFailure value)?  deviceBindingFailed,TResult Function( SessionLockedFailure value)?  sessionLocked,TResult Function( CacheFailure value)?  cacheError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case NoInternetFailure() when noInternet != null:
return noInternet(_that);case AuthFailure() when auth != null:
return auth(_that);case UnauthenticatedFailure() when unauthenticated != null:
return unauthenticated(_that);case InvalidOtpFailure() when invalidOtp != null:
return invalidOtp(_that);case OtpExpiredFailure() when otpExpired != null:
return otpExpired(_that);case TooManyAttemptsFailure() when tooManyAttempts != null:
return tooManyAttempts(_that);case DailyCapReachedFailure() when dailyCapReached != null:
return dailyCapReached(_that);case InsufficientBalanceFailure() when insufficientBalance != null:
return insufficientBalance(_that);case CashoutNotEligibleFailure() when cashoutNotEligible != null:
return cashoutNotEligible(_that);case PotNotEligibleFailure() when potNotEligible != null:
return potNotEligible(_that);case UserSuspendedFailure() when userSuspended != null:
return userSuspended(_that);case InvalidPhoneFailure() when invalidPhone != null:
return invalidPhone(_that);case InvalidUsernameFailure() when invalidUsername != null:
return invalidUsername(_that);case InvalidAmountFailure() when invalidAmount != null:
return invalidAmount(_that);case ServerFailure() when serverError != null:
return serverError(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case StepUpRequiredFailure() when stepUpRequired != null:
return stepUpRequired(_that);case DeviceNotTrustedFailure() when deviceNotTrusted != null:
return deviceNotTrusted(_that);case SimChangedFailure() when simChanged != null:
return simChanged(_that);case DeviceBindingFailedFailure() when deviceBindingFailed != null:
return deviceBindingFailed(_that);case SessionLockedFailure() when sessionLocked != null:
return sessionLocked(_that);case CacheFailure() when cacheError != null:
return cacheError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkFailure value)  network,required TResult Function( TimeoutFailure value)  timeout,required TResult Function( NoInternetFailure value)  noInternet,required TResult Function( AuthFailure value)  auth,required TResult Function( UnauthenticatedFailure value)  unauthenticated,required TResult Function( InvalidOtpFailure value)  invalidOtp,required TResult Function( OtpExpiredFailure value)  otpExpired,required TResult Function( TooManyAttemptsFailure value)  tooManyAttempts,required TResult Function( DailyCapReachedFailure value)  dailyCapReached,required TResult Function( InsufficientBalanceFailure value)  insufficientBalance,required TResult Function( CashoutNotEligibleFailure value)  cashoutNotEligible,required TResult Function( PotNotEligibleFailure value)  potNotEligible,required TResult Function( UserSuspendedFailure value)  userSuspended,required TResult Function( InvalidPhoneFailure value)  invalidPhone,required TResult Function( InvalidUsernameFailure value)  invalidUsername,required TResult Function( InvalidAmountFailure value)  invalidAmount,required TResult Function( ServerFailure value)  serverError,required TResult Function( UnknownFailure value)  unknown,required TResult Function( StepUpRequiredFailure value)  stepUpRequired,required TResult Function( DeviceNotTrustedFailure value)  deviceNotTrusted,required TResult Function( SimChangedFailure value)  simChanged,required TResult Function( DeviceBindingFailedFailure value)  deviceBindingFailed,required TResult Function( SessionLockedFailure value)  sessionLocked,required TResult Function( CacheFailure value)  cacheError,}){
final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that);case TimeoutFailure():
return timeout(_that);case NoInternetFailure():
return noInternet(_that);case AuthFailure():
return auth(_that);case UnauthenticatedFailure():
return unauthenticated(_that);case InvalidOtpFailure():
return invalidOtp(_that);case OtpExpiredFailure():
return otpExpired(_that);case TooManyAttemptsFailure():
return tooManyAttempts(_that);case DailyCapReachedFailure():
return dailyCapReached(_that);case InsufficientBalanceFailure():
return insufficientBalance(_that);case CashoutNotEligibleFailure():
return cashoutNotEligible(_that);case PotNotEligibleFailure():
return potNotEligible(_that);case UserSuspendedFailure():
return userSuspended(_that);case InvalidPhoneFailure():
return invalidPhone(_that);case InvalidUsernameFailure():
return invalidUsername(_that);case InvalidAmountFailure():
return invalidAmount(_that);case ServerFailure():
return serverError(_that);case UnknownFailure():
return unknown(_that);case StepUpRequiredFailure():
return stepUpRequired(_that);case DeviceNotTrustedFailure():
return deviceNotTrusted(_that);case SimChangedFailure():
return simChanged(_that);case DeviceBindingFailedFailure():
return deviceBindingFailed(_that);case SessionLockedFailure():
return sessionLocked(_that);case CacheFailure():
return cacheError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkFailure value)?  network,TResult? Function( TimeoutFailure value)?  timeout,TResult? Function( NoInternetFailure value)?  noInternet,TResult? Function( AuthFailure value)?  auth,TResult? Function( UnauthenticatedFailure value)?  unauthenticated,TResult? Function( InvalidOtpFailure value)?  invalidOtp,TResult? Function( OtpExpiredFailure value)?  otpExpired,TResult? Function( TooManyAttemptsFailure value)?  tooManyAttempts,TResult? Function( DailyCapReachedFailure value)?  dailyCapReached,TResult? Function( InsufficientBalanceFailure value)?  insufficientBalance,TResult? Function( CashoutNotEligibleFailure value)?  cashoutNotEligible,TResult? Function( PotNotEligibleFailure value)?  potNotEligible,TResult? Function( UserSuspendedFailure value)?  userSuspended,TResult? Function( InvalidPhoneFailure value)?  invalidPhone,TResult? Function( InvalidUsernameFailure value)?  invalidUsername,TResult? Function( InvalidAmountFailure value)?  invalidAmount,TResult? Function( ServerFailure value)?  serverError,TResult? Function( UnknownFailure value)?  unknown,TResult? Function( StepUpRequiredFailure value)?  stepUpRequired,TResult? Function( DeviceNotTrustedFailure value)?  deviceNotTrusted,TResult? Function( SimChangedFailure value)?  simChanged,TResult? Function( DeviceBindingFailedFailure value)?  deviceBindingFailed,TResult? Function( SessionLockedFailure value)?  sessionLocked,TResult? Function( CacheFailure value)?  cacheError,}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case NoInternetFailure() when noInternet != null:
return noInternet(_that);case AuthFailure() when auth != null:
return auth(_that);case UnauthenticatedFailure() when unauthenticated != null:
return unauthenticated(_that);case InvalidOtpFailure() when invalidOtp != null:
return invalidOtp(_that);case OtpExpiredFailure() when otpExpired != null:
return otpExpired(_that);case TooManyAttemptsFailure() when tooManyAttempts != null:
return tooManyAttempts(_that);case DailyCapReachedFailure() when dailyCapReached != null:
return dailyCapReached(_that);case InsufficientBalanceFailure() when insufficientBalance != null:
return insufficientBalance(_that);case CashoutNotEligibleFailure() when cashoutNotEligible != null:
return cashoutNotEligible(_that);case PotNotEligibleFailure() when potNotEligible != null:
return potNotEligible(_that);case UserSuspendedFailure() when userSuspended != null:
return userSuspended(_that);case InvalidPhoneFailure() when invalidPhone != null:
return invalidPhone(_that);case InvalidUsernameFailure() when invalidUsername != null:
return invalidUsername(_that);case InvalidAmountFailure() when invalidAmount != null:
return invalidAmount(_that);case ServerFailure() when serverError != null:
return serverError(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case StepUpRequiredFailure() when stepUpRequired != null:
return stepUpRequired(_that);case DeviceNotTrustedFailure() when deviceNotTrusted != null:
return deviceNotTrusted(_that);case SimChangedFailure() when simChanged != null:
return simChanged(_that);case DeviceBindingFailedFailure() when deviceBindingFailed != null:
return deviceBindingFailed(_that);case SessionLockedFailure() when sessionLocked != null:
return sessionLocked(_that);case CacheFailure() when cacheError != null:
return cacheError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message)?  network,TResult Function()?  timeout,TResult Function()?  noInternet,TResult Function( String? message)?  auth,TResult Function()?  unauthenticated,TResult Function()?  invalidOtp,TResult Function()?  otpExpired,TResult Function()?  tooManyAttempts,TResult Function()?  dailyCapReached,TResult Function()?  insufficientBalance,TResult Function()?  cashoutNotEligible,TResult Function()?  potNotEligible,TResult Function()?  userSuspended,TResult Function()?  invalidPhone,TResult Function()?  invalidUsername,TResult Function()?  invalidAmount,TResult Function( String? code,  String? message)?  serverError,TResult Function( String? message)?  unknown,TResult Function( String? reason)?  stepUpRequired,TResult Function()?  deviceNotTrusted,TResult Function()?  simChanged,TResult Function( String? message)?  deviceBindingFailed,TResult Function()?  sessionLocked,TResult Function( String? message)?  cacheError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that.message);case TimeoutFailure() when timeout != null:
return timeout();case NoInternetFailure() when noInternet != null:
return noInternet();case AuthFailure() when auth != null:
return auth(_that.message);case UnauthenticatedFailure() when unauthenticated != null:
return unauthenticated();case InvalidOtpFailure() when invalidOtp != null:
return invalidOtp();case OtpExpiredFailure() when otpExpired != null:
return otpExpired();case TooManyAttemptsFailure() when tooManyAttempts != null:
return tooManyAttempts();case DailyCapReachedFailure() when dailyCapReached != null:
return dailyCapReached();case InsufficientBalanceFailure() when insufficientBalance != null:
return insufficientBalance();case CashoutNotEligibleFailure() when cashoutNotEligible != null:
return cashoutNotEligible();case PotNotEligibleFailure() when potNotEligible != null:
return potNotEligible();case UserSuspendedFailure() when userSuspended != null:
return userSuspended();case InvalidPhoneFailure() when invalidPhone != null:
return invalidPhone();case InvalidUsernameFailure() when invalidUsername != null:
return invalidUsername();case InvalidAmountFailure() when invalidAmount != null:
return invalidAmount();case ServerFailure() when serverError != null:
return serverError(_that.code,_that.message);case UnknownFailure() when unknown != null:
return unknown(_that.message);case StepUpRequiredFailure() when stepUpRequired != null:
return stepUpRequired(_that.reason);case DeviceNotTrustedFailure() when deviceNotTrusted != null:
return deviceNotTrusted();case SimChangedFailure() when simChanged != null:
return simChanged();case DeviceBindingFailedFailure() when deviceBindingFailed != null:
return deviceBindingFailed(_that.message);case SessionLockedFailure() when sessionLocked != null:
return sessionLocked();case CacheFailure() when cacheError != null:
return cacheError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message)  network,required TResult Function()  timeout,required TResult Function()  noInternet,required TResult Function( String? message)  auth,required TResult Function()  unauthenticated,required TResult Function()  invalidOtp,required TResult Function()  otpExpired,required TResult Function()  tooManyAttempts,required TResult Function()  dailyCapReached,required TResult Function()  insufficientBalance,required TResult Function()  cashoutNotEligible,required TResult Function()  potNotEligible,required TResult Function()  userSuspended,required TResult Function()  invalidPhone,required TResult Function()  invalidUsername,required TResult Function()  invalidAmount,required TResult Function( String? code,  String? message)  serverError,required TResult Function( String? message)  unknown,required TResult Function( String? reason)  stepUpRequired,required TResult Function()  deviceNotTrusted,required TResult Function()  simChanged,required TResult Function( String? message)  deviceBindingFailed,required TResult Function()  sessionLocked,required TResult Function( String? message)  cacheError,}) {final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that.message);case TimeoutFailure():
return timeout();case NoInternetFailure():
return noInternet();case AuthFailure():
return auth(_that.message);case UnauthenticatedFailure():
return unauthenticated();case InvalidOtpFailure():
return invalidOtp();case OtpExpiredFailure():
return otpExpired();case TooManyAttemptsFailure():
return tooManyAttempts();case DailyCapReachedFailure():
return dailyCapReached();case InsufficientBalanceFailure():
return insufficientBalance();case CashoutNotEligibleFailure():
return cashoutNotEligible();case PotNotEligibleFailure():
return potNotEligible();case UserSuspendedFailure():
return userSuspended();case InvalidPhoneFailure():
return invalidPhone();case InvalidUsernameFailure():
return invalidUsername();case InvalidAmountFailure():
return invalidAmount();case ServerFailure():
return serverError(_that.code,_that.message);case UnknownFailure():
return unknown(_that.message);case StepUpRequiredFailure():
return stepUpRequired(_that.reason);case DeviceNotTrustedFailure():
return deviceNotTrusted();case SimChangedFailure():
return simChanged();case DeviceBindingFailedFailure():
return deviceBindingFailed(_that.message);case SessionLockedFailure():
return sessionLocked();case CacheFailure():
return cacheError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message)?  network,TResult? Function()?  timeout,TResult? Function()?  noInternet,TResult? Function( String? message)?  auth,TResult? Function()?  unauthenticated,TResult? Function()?  invalidOtp,TResult? Function()?  otpExpired,TResult? Function()?  tooManyAttempts,TResult? Function()?  dailyCapReached,TResult? Function()?  insufficientBalance,TResult? Function()?  cashoutNotEligible,TResult? Function()?  potNotEligible,TResult? Function()?  userSuspended,TResult? Function()?  invalidPhone,TResult? Function()?  invalidUsername,TResult? Function()?  invalidAmount,TResult? Function( String? code,  String? message)?  serverError,TResult? Function( String? message)?  unknown,TResult? Function( String? reason)?  stepUpRequired,TResult? Function()?  deviceNotTrusted,TResult? Function()?  simChanged,TResult? Function( String? message)?  deviceBindingFailed,TResult? Function()?  sessionLocked,TResult? Function( String? message)?  cacheError,}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that.message);case TimeoutFailure() when timeout != null:
return timeout();case NoInternetFailure() when noInternet != null:
return noInternet();case AuthFailure() when auth != null:
return auth(_that.message);case UnauthenticatedFailure() when unauthenticated != null:
return unauthenticated();case InvalidOtpFailure() when invalidOtp != null:
return invalidOtp();case OtpExpiredFailure() when otpExpired != null:
return otpExpired();case TooManyAttemptsFailure() when tooManyAttempts != null:
return tooManyAttempts();case DailyCapReachedFailure() when dailyCapReached != null:
return dailyCapReached();case InsufficientBalanceFailure() when insufficientBalance != null:
return insufficientBalance();case CashoutNotEligibleFailure() when cashoutNotEligible != null:
return cashoutNotEligible();case PotNotEligibleFailure() when potNotEligible != null:
return potNotEligible();case UserSuspendedFailure() when userSuspended != null:
return userSuspended();case InvalidPhoneFailure() when invalidPhone != null:
return invalidPhone();case InvalidUsernameFailure() when invalidUsername != null:
return invalidUsername();case InvalidAmountFailure() when invalidAmount != null:
return invalidAmount();case ServerFailure() when serverError != null:
return serverError(_that.code,_that.message);case UnknownFailure() when unknown != null:
return unknown(_that.message);case StepUpRequiredFailure() when stepUpRequired != null:
return stepUpRequired(_that.reason);case DeviceNotTrustedFailure() when deviceNotTrusted != null:
return deviceNotTrusted();case SimChangedFailure() when simChanged != null:
return simChanged();case DeviceBindingFailedFailure() when deviceBindingFailed != null:
return deviceBindingFailed(_that.message);case SessionLockedFailure() when sessionLocked != null:
return sessionLocked();case CacheFailure() when cacheError != null:
return cacheError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class NetworkFailure implements Failure {
  const NetworkFailure({this.message});
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<NetworkFailure> get copyWith => _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.network(message: $message)';
}


}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(NetworkFailure value, $Res Function(NetworkFailure) _then) = _$NetworkFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(NetworkFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class TimeoutFailure implements Failure {
  const TimeoutFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeoutFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.timeout()';
}


}




/// @nodoc


class NoInternetFailure implements Failure {
  const NoInternetFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoInternetFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.noInternet()';
}


}




/// @nodoc


class AuthFailure implements Failure {
  const AuthFailure({this.message});
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<AuthFailure> get copyWith => _$AuthFailureCopyWithImpl<AuthFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.auth(message: $message)';
}


}

/// @nodoc
abstract mixin class $AuthFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(AuthFailure value, $Res Function(AuthFailure) _then) = _$AuthFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$AuthFailureCopyWithImpl<$Res>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._self, this._then);

  final AuthFailure _self;
  final $Res Function(AuthFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(AuthFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UnauthenticatedFailure implements Failure {
  const UnauthenticatedFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthenticatedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.unauthenticated()';
}


}




/// @nodoc


class InvalidOtpFailure implements Failure {
  const InvalidOtpFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidOtpFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.invalidOtp()';
}


}




/// @nodoc


class OtpExpiredFailure implements Failure {
  const OtpExpiredFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpExpiredFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.otpExpired()';
}


}




/// @nodoc


class TooManyAttemptsFailure implements Failure {
  const TooManyAttemptsFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TooManyAttemptsFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.tooManyAttempts()';
}


}




/// @nodoc


class DailyCapReachedFailure implements Failure {
  const DailyCapReachedFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyCapReachedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.dailyCapReached()';
}


}




/// @nodoc


class InsufficientBalanceFailure implements Failure {
  const InsufficientBalanceFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsufficientBalanceFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.insufficientBalance()';
}


}




/// @nodoc


class CashoutNotEligibleFailure implements Failure {
  const CashoutNotEligibleFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashoutNotEligibleFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.cashoutNotEligible()';
}


}




/// @nodoc


class PotNotEligibleFailure implements Failure {
  const PotNotEligibleFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PotNotEligibleFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.potNotEligible()';
}


}




/// @nodoc


class UserSuspendedFailure implements Failure {
  const UserSuspendedFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSuspendedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.userSuspended()';
}


}




/// @nodoc


class InvalidPhoneFailure implements Failure {
  const InvalidPhoneFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidPhoneFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.invalidPhone()';
}


}




/// @nodoc


class InvalidUsernameFailure implements Failure {
  const InvalidUsernameFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidUsernameFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.invalidUsername()';
}


}




/// @nodoc


class InvalidAmountFailure implements Failure {
  const InvalidAmountFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidAmountFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.invalidAmount()';
}


}




/// @nodoc


class ServerFailure implements Failure {
  const ServerFailure({this.code, this.message});
  

 final  String? code;
 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'Failure.serverError(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 String? code, String? message
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? message = freezed,}) {
  return _then(ServerFailure(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UnknownFailure implements Failure {
  const UnknownFailure({this.message});
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownFailureCopyWith<UnknownFailure> get copyWith => _$UnknownFailureCopyWithImpl<UnknownFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.unknown(message: $message)';
}


}

/// @nodoc
abstract mixin class $UnknownFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnknownFailureCopyWith(UnknownFailure value, $Res Function(UnknownFailure) _then) = _$UnknownFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$UnknownFailureCopyWithImpl<$Res>
    implements $UnknownFailureCopyWith<$Res> {
  _$UnknownFailureCopyWithImpl(this._self, this._then);

  final UnknownFailure _self;
  final $Res Function(UnknownFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(UnknownFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class StepUpRequiredFailure implements Failure {
  const StepUpRequiredFailure({this.reason});
  

 final  String? reason;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepUpRequiredFailureCopyWith<StepUpRequiredFailure> get copyWith => _$StepUpRequiredFailureCopyWithImpl<StepUpRequiredFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepUpRequiredFailure&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'Failure.stepUpRequired(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $StepUpRequiredFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $StepUpRequiredFailureCopyWith(StepUpRequiredFailure value, $Res Function(StepUpRequiredFailure) _then) = _$StepUpRequiredFailureCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class _$StepUpRequiredFailureCopyWithImpl<$Res>
    implements $StepUpRequiredFailureCopyWith<$Res> {
  _$StepUpRequiredFailureCopyWithImpl(this._self, this._then);

  final StepUpRequiredFailure _self;
  final $Res Function(StepUpRequiredFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(StepUpRequiredFailure(
reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class DeviceNotTrustedFailure implements Failure {
  const DeviceNotTrustedFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceNotTrustedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.deviceNotTrusted()';
}


}




/// @nodoc


class SimChangedFailure implements Failure {
  const SimChangedFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimChangedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.simChanged()';
}


}




/// @nodoc


class DeviceBindingFailedFailure implements Failure {
  const DeviceBindingFailedFailure({this.message});
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceBindingFailedFailureCopyWith<DeviceBindingFailedFailure> get copyWith => _$DeviceBindingFailedFailureCopyWithImpl<DeviceBindingFailedFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceBindingFailedFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.deviceBindingFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class $DeviceBindingFailedFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $DeviceBindingFailedFailureCopyWith(DeviceBindingFailedFailure value, $Res Function(DeviceBindingFailedFailure) _then) = _$DeviceBindingFailedFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$DeviceBindingFailedFailureCopyWithImpl<$Res>
    implements $DeviceBindingFailedFailureCopyWith<$Res> {
  _$DeviceBindingFailedFailureCopyWithImpl(this._self, this._then);

  final DeviceBindingFailedFailure _self;
  final $Res Function(DeviceBindingFailedFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(DeviceBindingFailedFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SessionLockedFailure implements Failure {
  const SessionLockedFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionLockedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.sessionLocked()';
}


}




/// @nodoc


class CacheFailure implements Failure {
  const CacheFailure({this.message});
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacheFailureCopyWith<CacheFailure> get copyWith => _$CacheFailureCopyWithImpl<CacheFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.cacheError(message: $message)';
}


}

/// @nodoc
abstract mixin class $CacheFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $CacheFailureCopyWith(CacheFailure value, $Res Function(CacheFailure) _then) = _$CacheFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$CacheFailureCopyWithImpl<$Res>
    implements $CacheFailureCopyWith<$Res> {
  _$CacheFailureCopyWithImpl(this._self, this._then);

  final CacheFailure _self;
  final $Res Function(CacheFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(CacheFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
