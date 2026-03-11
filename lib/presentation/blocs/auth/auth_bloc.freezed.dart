// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CheckAuthStatus value)?  checkAuthStatus,TResult Function( _SendOtp value)?  sendOtp,TResult Function( _VerifyOtp value)?  verifyOtp,TResult Function( _ResendOtp value)?  resendOtp,TResult Function( _SignOut value)?  signOut,TResult Function( _DeleteAccount value)?  deleteAccount,TResult Function( _AcceptTerms value)?  acceptTerms,TResult Function( _CompleteOnboarding value)?  completeOnboarding,TResult Function( _BindDevice value)?  bindDevice,TResult Function( _LockSession value)?  lockSession,TResult Function( _UnlockSession value)?  unlockSession,TResult Function( _ForceReauth value)?  forceReauth,TResult Function( _AuthenticateWithPushToken value)?  authenticateWithPushToken,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus(_that);case _SendOtp() when sendOtp != null:
return sendOtp(_that);case _VerifyOtp() when verifyOtp != null:
return verifyOtp(_that);case _ResendOtp() when resendOtp != null:
return resendOtp(_that);case _SignOut() when signOut != null:
return signOut(_that);case _DeleteAccount() when deleteAccount != null:
return deleteAccount(_that);case _AcceptTerms() when acceptTerms != null:
return acceptTerms(_that);case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding(_that);case _BindDevice() when bindDevice != null:
return bindDevice(_that);case _LockSession() when lockSession != null:
return lockSession(_that);case _UnlockSession() when unlockSession != null:
return unlockSession(_that);case _ForceReauth() when forceReauth != null:
return forceReauth(_that);case _AuthenticateWithPushToken() when authenticateWithPushToken != null:
return authenticateWithPushToken(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CheckAuthStatus value)  checkAuthStatus,required TResult Function( _SendOtp value)  sendOtp,required TResult Function( _VerifyOtp value)  verifyOtp,required TResult Function( _ResendOtp value)  resendOtp,required TResult Function( _SignOut value)  signOut,required TResult Function( _DeleteAccount value)  deleteAccount,required TResult Function( _AcceptTerms value)  acceptTerms,required TResult Function( _CompleteOnboarding value)  completeOnboarding,required TResult Function( _BindDevice value)  bindDevice,required TResult Function( _LockSession value)  lockSession,required TResult Function( _UnlockSession value)  unlockSession,required TResult Function( _ForceReauth value)  forceReauth,required TResult Function( _AuthenticateWithPushToken value)  authenticateWithPushToken,}){
final _that = this;
switch (_that) {
case _CheckAuthStatus():
return checkAuthStatus(_that);case _SendOtp():
return sendOtp(_that);case _VerifyOtp():
return verifyOtp(_that);case _ResendOtp():
return resendOtp(_that);case _SignOut():
return signOut(_that);case _DeleteAccount():
return deleteAccount(_that);case _AcceptTerms():
return acceptTerms(_that);case _CompleteOnboarding():
return completeOnboarding(_that);case _BindDevice():
return bindDevice(_that);case _LockSession():
return lockSession(_that);case _UnlockSession():
return unlockSession(_that);case _ForceReauth():
return forceReauth(_that);case _AuthenticateWithPushToken():
return authenticateWithPushToken(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CheckAuthStatus value)?  checkAuthStatus,TResult? Function( _SendOtp value)?  sendOtp,TResult? Function( _VerifyOtp value)?  verifyOtp,TResult? Function( _ResendOtp value)?  resendOtp,TResult? Function( _SignOut value)?  signOut,TResult? Function( _DeleteAccount value)?  deleteAccount,TResult? Function( _AcceptTerms value)?  acceptTerms,TResult? Function( _CompleteOnboarding value)?  completeOnboarding,TResult? Function( _BindDevice value)?  bindDevice,TResult? Function( _LockSession value)?  lockSession,TResult? Function( _UnlockSession value)?  unlockSession,TResult? Function( _ForceReauth value)?  forceReauth,TResult? Function( _AuthenticateWithPushToken value)?  authenticateWithPushToken,}){
final _that = this;
switch (_that) {
case _CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus(_that);case _SendOtp() when sendOtp != null:
return sendOtp(_that);case _VerifyOtp() when verifyOtp != null:
return verifyOtp(_that);case _ResendOtp() when resendOtp != null:
return resendOtp(_that);case _SignOut() when signOut != null:
return signOut(_that);case _DeleteAccount() when deleteAccount != null:
return deleteAccount(_that);case _AcceptTerms() when acceptTerms != null:
return acceptTerms(_that);case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding(_that);case _BindDevice() when bindDevice != null:
return bindDevice(_that);case _LockSession() when lockSession != null:
return lockSession(_that);case _UnlockSession() when unlockSession != null:
return unlockSession(_that);case _ForceReauth() when forceReauth != null:
return forceReauth(_that);case _AuthenticateWithPushToken() when authenticateWithPushToken != null:
return authenticateWithPushToken(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  checkAuthStatus,TResult Function( String phoneNumber)?  sendOtp,TResult Function( String verificationId,  String otp)?  verifyOtp,TResult Function( String phoneNumber)?  resendOtp,TResult Function()?  signOut,TResult Function()?  deleteAccount,TResult Function()?  acceptTerms,TResult Function()?  completeOnboarding,TResult Function()?  bindDevice,TResult Function()?  lockSession,TResult Function()?  unlockSession,TResult Function()?  forceReauth,TResult Function( String customToken)?  authenticateWithPushToken,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus();case _SendOtp() when sendOtp != null:
return sendOtp(_that.phoneNumber);case _VerifyOtp() when verifyOtp != null:
return verifyOtp(_that.verificationId,_that.otp);case _ResendOtp() when resendOtp != null:
return resendOtp(_that.phoneNumber);case _SignOut() when signOut != null:
return signOut();case _DeleteAccount() when deleteAccount != null:
return deleteAccount();case _AcceptTerms() when acceptTerms != null:
return acceptTerms();case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding();case _BindDevice() when bindDevice != null:
return bindDevice();case _LockSession() when lockSession != null:
return lockSession();case _UnlockSession() when unlockSession != null:
return unlockSession();case _ForceReauth() when forceReauth != null:
return forceReauth();case _AuthenticateWithPushToken() when authenticateWithPushToken != null:
return authenticateWithPushToken(_that.customToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  checkAuthStatus,required TResult Function( String phoneNumber)  sendOtp,required TResult Function( String verificationId,  String otp)  verifyOtp,required TResult Function( String phoneNumber)  resendOtp,required TResult Function()  signOut,required TResult Function()  deleteAccount,required TResult Function()  acceptTerms,required TResult Function()  completeOnboarding,required TResult Function()  bindDevice,required TResult Function()  lockSession,required TResult Function()  unlockSession,required TResult Function()  forceReauth,required TResult Function( String customToken)  authenticateWithPushToken,}) {final _that = this;
switch (_that) {
case _CheckAuthStatus():
return checkAuthStatus();case _SendOtp():
return sendOtp(_that.phoneNumber);case _VerifyOtp():
return verifyOtp(_that.verificationId,_that.otp);case _ResendOtp():
return resendOtp(_that.phoneNumber);case _SignOut():
return signOut();case _DeleteAccount():
return deleteAccount();case _AcceptTerms():
return acceptTerms();case _CompleteOnboarding():
return completeOnboarding();case _BindDevice():
return bindDevice();case _LockSession():
return lockSession();case _UnlockSession():
return unlockSession();case _ForceReauth():
return forceReauth();case _AuthenticateWithPushToken():
return authenticateWithPushToken(_that.customToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  checkAuthStatus,TResult? Function( String phoneNumber)?  sendOtp,TResult? Function( String verificationId,  String otp)?  verifyOtp,TResult? Function( String phoneNumber)?  resendOtp,TResult? Function()?  signOut,TResult? Function()?  deleteAccount,TResult? Function()?  acceptTerms,TResult? Function()?  completeOnboarding,TResult? Function()?  bindDevice,TResult? Function()?  lockSession,TResult? Function()?  unlockSession,TResult? Function()?  forceReauth,TResult? Function( String customToken)?  authenticateWithPushToken,}) {final _that = this;
switch (_that) {
case _CheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus();case _SendOtp() when sendOtp != null:
return sendOtp(_that.phoneNumber);case _VerifyOtp() when verifyOtp != null:
return verifyOtp(_that.verificationId,_that.otp);case _ResendOtp() when resendOtp != null:
return resendOtp(_that.phoneNumber);case _SignOut() when signOut != null:
return signOut();case _DeleteAccount() when deleteAccount != null:
return deleteAccount();case _AcceptTerms() when acceptTerms != null:
return acceptTerms();case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding();case _BindDevice() when bindDevice != null:
return bindDevice();case _LockSession() when lockSession != null:
return lockSession();case _UnlockSession() when unlockSession != null:
return unlockSession();case _ForceReauth() when forceReauth != null:
return forceReauth();case _AuthenticateWithPushToken() when authenticateWithPushToken != null:
return authenticateWithPushToken(_that.customToken);case _:
  return null;

}
}

}

/// @nodoc


class _CheckAuthStatus with DiagnosticableTreeMixin implements AuthEvent {
  const _CheckAuthStatus();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.checkAuthStatus'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckAuthStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.checkAuthStatus()';
}


}




/// @nodoc


class _SendOtp with DiagnosticableTreeMixin implements AuthEvent {
  const _SendOtp({required this.phoneNumber});
  

 final  String phoneNumber;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendOtpCopyWith<_SendOtp> get copyWith => __$SendOtpCopyWithImpl<_SendOtp>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.sendOtp'))
    ..add(DiagnosticsProperty('phoneNumber', phoneNumber));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendOtp&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.sendOtp(phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$SendOtpCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$SendOtpCopyWith(_SendOtp value, $Res Function(_SendOtp) _then) = __$SendOtpCopyWithImpl;
@useResult
$Res call({
 String phoneNumber
});




}
/// @nodoc
class __$SendOtpCopyWithImpl<$Res>
    implements _$SendOtpCopyWith<$Res> {
  __$SendOtpCopyWithImpl(this._self, this._then);

  final _SendOtp _self;
  final $Res Function(_SendOtp) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,}) {
  return _then(_SendOtp(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifyOtp with DiagnosticableTreeMixin implements AuthEvent {
  const _VerifyOtp({required this.verificationId, required this.otp});
  

 final  String verificationId;
 final  String otp;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpCopyWith<_VerifyOtp> get copyWith => __$VerifyOtpCopyWithImpl<_VerifyOtp>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.verifyOtp'))
    ..add(DiagnosticsProperty('verificationId', verificationId))..add(DiagnosticsProperty('otp', otp));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtp&&(identical(other.verificationId, verificationId) || other.verificationId == verificationId)&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,verificationId,otp);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.verifyOtp(verificationId: $verificationId, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$VerifyOtpCopyWith(_VerifyOtp value, $Res Function(_VerifyOtp) _then) = __$VerifyOtpCopyWithImpl;
@useResult
$Res call({
 String verificationId, String otp
});




}
/// @nodoc
class __$VerifyOtpCopyWithImpl<$Res>
    implements _$VerifyOtpCopyWith<$Res> {
  __$VerifyOtpCopyWithImpl(this._self, this._then);

  final _VerifyOtp _self;
  final $Res Function(_VerifyOtp) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? verificationId = null,Object? otp = null,}) {
  return _then(_VerifyOtp(
verificationId: null == verificationId ? _self.verificationId : verificationId // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResendOtp with DiagnosticableTreeMixin implements AuthEvent {
  const _ResendOtp({required this.phoneNumber});
  

 final  String phoneNumber;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResendOtpCopyWith<_ResendOtp> get copyWith => __$ResendOtpCopyWithImpl<_ResendOtp>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.resendOtp'))
    ..add(DiagnosticsProperty('phoneNumber', phoneNumber));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendOtp&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.resendOtp(phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$ResendOtpCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$ResendOtpCopyWith(_ResendOtp value, $Res Function(_ResendOtp) _then) = __$ResendOtpCopyWithImpl;
@useResult
$Res call({
 String phoneNumber
});




}
/// @nodoc
class __$ResendOtpCopyWithImpl<$Res>
    implements _$ResendOtpCopyWith<$Res> {
  __$ResendOtpCopyWithImpl(this._self, this._then);

  final _ResendOtp _self;
  final $Res Function(_ResendOtp) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,}) {
  return _then(_ResendOtp(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SignOut with DiagnosticableTreeMixin implements AuthEvent {
  const _SignOut();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.signOut'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.signOut()';
}


}




/// @nodoc


class _DeleteAccount with DiagnosticableTreeMixin implements AuthEvent {
  const _DeleteAccount();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.deleteAccount'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteAccount);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.deleteAccount()';
}


}




/// @nodoc


class _AcceptTerms with DiagnosticableTreeMixin implements AuthEvent {
  const _AcceptTerms();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.acceptTerms'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptTerms);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.acceptTerms()';
}


}




/// @nodoc


class _CompleteOnboarding with DiagnosticableTreeMixin implements AuthEvent {
  const _CompleteOnboarding();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.completeOnboarding'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteOnboarding);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.completeOnboarding()';
}


}




/// @nodoc


class _BindDevice with DiagnosticableTreeMixin implements AuthEvent {
  const _BindDevice();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.bindDevice'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BindDevice);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.bindDevice()';
}


}




/// @nodoc


class _LockSession with DiagnosticableTreeMixin implements AuthEvent {
  const _LockSession();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.lockSession'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LockSession);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.lockSession()';
}


}




/// @nodoc


class _UnlockSession with DiagnosticableTreeMixin implements AuthEvent {
  const _UnlockSession();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.unlockSession'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnlockSession);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.unlockSession()';
}


}




/// @nodoc


class _ForceReauth with DiagnosticableTreeMixin implements AuthEvent {
  const _ForceReauth();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.forceReauth'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForceReauth);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.forceReauth()';
}


}




/// @nodoc


class _AuthenticateWithPushToken with DiagnosticableTreeMixin implements AuthEvent {
  const _AuthenticateWithPushToken({required this.customToken});
  

 final  String customToken;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticateWithPushTokenCopyWith<_AuthenticateWithPushToken> get copyWith => __$AuthenticateWithPushTokenCopyWithImpl<_AuthenticateWithPushToken>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.authenticateWithPushToken'))
    ..add(DiagnosticsProperty('customToken', customToken));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthenticateWithPushToken&&(identical(other.customToken, customToken) || other.customToken == customToken));
}


@override
int get hashCode => Object.hash(runtimeType,customToken);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.authenticateWithPushToken(customToken: $customToken)';
}


}

/// @nodoc
abstract mixin class _$AuthenticateWithPushTokenCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$AuthenticateWithPushTokenCopyWith(_AuthenticateWithPushToken value, $Res Function(_AuthenticateWithPushToken) _then) = __$AuthenticateWithPushTokenCopyWithImpl;
@useResult
$Res call({
 String customToken
});




}
/// @nodoc
class __$AuthenticateWithPushTokenCopyWithImpl<$Res>
    implements _$AuthenticateWithPushTokenCopyWith<$Res> {
  __$AuthenticateWithPushTokenCopyWithImpl(this._self, this._then);

  final _AuthenticateWithPushToken _self;
  final $Res Function(_AuthenticateWithPushToken) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customToken = null,}) {
  return _then(_AuthenticateWithPushToken(
customToken: null == customToken ? _self.customToken : customToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AuthState implements DiagnosticableTreeMixin {

 AuthStatus get status; User? get user; String? get verificationId; String? get phoneNumber; String? get errorMessage; bool get isLoading; int get resendCountdown; bool get isDeviceBound; String? get deviceId;/// True when E2EE key restore from backup failed and fresh keys were
/// generated. Some older messages may not be decryptable.
 bool get keyRestoreFailed;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthState'))
    ..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('user', user))..add(DiagnosticsProperty('verificationId', verificationId))..add(DiagnosticsProperty('phoneNumber', phoneNumber))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('resendCountdown', resendCountdown))..add(DiagnosticsProperty('isDeviceBound', isDeviceBound))..add(DiagnosticsProperty('deviceId', deviceId))..add(DiagnosticsProperty('keyRestoreFailed', keyRestoreFailed));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.verificationId, verificationId) || other.verificationId == verificationId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.resendCountdown, resendCountdown) || other.resendCountdown == resendCountdown)&&(identical(other.isDeviceBound, isDeviceBound) || other.isDeviceBound == isDeviceBound)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.keyRestoreFailed, keyRestoreFailed) || other.keyRestoreFailed == keyRestoreFailed));
}


@override
int get hashCode => Object.hash(runtimeType,status,user,verificationId,phoneNumber,errorMessage,isLoading,resendCountdown,isDeviceBound,deviceId,keyRestoreFailed);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthState(status: $status, user: $user, verificationId: $verificationId, phoneNumber: $phoneNumber, errorMessage: $errorMessage, isLoading: $isLoading, resendCountdown: $resendCountdown, isDeviceBound: $isDeviceBound, deviceId: $deviceId, keyRestoreFailed: $keyRestoreFailed)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 AuthStatus status, User? user, String? verificationId, String? phoneNumber, String? errorMessage, bool isLoading, int resendCountdown, bool isDeviceBound, String? deviceId, bool keyRestoreFailed
});


$UserCopyWith<$Res>? get user;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? user = freezed,Object? verificationId = freezed,Object? phoneNumber = freezed,Object? errorMessage = freezed,Object? isLoading = null,Object? resendCountdown = null,Object? isDeviceBound = null,Object? deviceId = freezed,Object? keyRestoreFailed = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,verificationId: freezed == verificationId ? _self.verificationId : verificationId // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,resendCountdown: null == resendCountdown ? _self.resendCountdown : resendCountdown // ignore: cast_nullable_to_non_nullable
as int,isDeviceBound: null == isDeviceBound ? _self.isDeviceBound : isDeviceBound // ignore: cast_nullable_to_non_nullable
as bool,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,keyRestoreFailed: null == keyRestoreFailed ? _self.keyRestoreFailed : keyRestoreFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthStatus status,  User? user,  String? verificationId,  String? phoneNumber,  String? errorMessage,  bool isLoading,  int resendCountdown,  bool isDeviceBound,  String? deviceId,  bool keyRestoreFailed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.status,_that.user,_that.verificationId,_that.phoneNumber,_that.errorMessage,_that.isLoading,_that.resendCountdown,_that.isDeviceBound,_that.deviceId,_that.keyRestoreFailed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthStatus status,  User? user,  String? verificationId,  String? phoneNumber,  String? errorMessage,  bool isLoading,  int resendCountdown,  bool isDeviceBound,  String? deviceId,  bool keyRestoreFailed)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.status,_that.user,_that.verificationId,_that.phoneNumber,_that.errorMessage,_that.isLoading,_that.resendCountdown,_that.isDeviceBound,_that.deviceId,_that.keyRestoreFailed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthStatus status,  User? user,  String? verificationId,  String? phoneNumber,  String? errorMessage,  bool isLoading,  int resendCountdown,  bool isDeviceBound,  String? deviceId,  bool keyRestoreFailed)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.status,_that.user,_that.verificationId,_that.phoneNumber,_that.errorMessage,_that.isLoading,_that.resendCountdown,_that.isDeviceBound,_that.deviceId,_that.keyRestoreFailed);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState extends AuthState with DiagnosticableTreeMixin {
  const _AuthState({this.status = AuthStatus.initial, this.user, this.verificationId, this.phoneNumber, this.errorMessage, this.isLoading = false, this.resendCountdown = 0, this.isDeviceBound = false, this.deviceId, this.keyRestoreFailed = false}): super._();
  

@override@JsonKey() final  AuthStatus status;
@override final  User? user;
@override final  String? verificationId;
@override final  String? phoneNumber;
@override final  String? errorMessage;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  int resendCountdown;
@override@JsonKey() final  bool isDeviceBound;
@override final  String? deviceId;
/// True when E2EE key restore from backup failed and fresh keys were
/// generated. Some older messages may not be decryptable.
@override@JsonKey() final  bool keyRestoreFailed;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthState'))
    ..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('user', user))..add(DiagnosticsProperty('verificationId', verificationId))..add(DiagnosticsProperty('phoneNumber', phoneNumber))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('resendCountdown', resendCountdown))..add(DiagnosticsProperty('isDeviceBound', isDeviceBound))..add(DiagnosticsProperty('deviceId', deviceId))..add(DiagnosticsProperty('keyRestoreFailed', keyRestoreFailed));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.verificationId, verificationId) || other.verificationId == verificationId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.resendCountdown, resendCountdown) || other.resendCountdown == resendCountdown)&&(identical(other.isDeviceBound, isDeviceBound) || other.isDeviceBound == isDeviceBound)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.keyRestoreFailed, keyRestoreFailed) || other.keyRestoreFailed == keyRestoreFailed));
}


@override
int get hashCode => Object.hash(runtimeType,status,user,verificationId,phoneNumber,errorMessage,isLoading,resendCountdown,isDeviceBound,deviceId,keyRestoreFailed);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthState(status: $status, user: $user, verificationId: $verificationId, phoneNumber: $phoneNumber, errorMessage: $errorMessage, isLoading: $isLoading, resendCountdown: $resendCountdown, isDeviceBound: $isDeviceBound, deviceId: $deviceId, keyRestoreFailed: $keyRestoreFailed)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 AuthStatus status, User? user, String? verificationId, String? phoneNumber, String? errorMessage, bool isLoading, int resendCountdown, bool isDeviceBound, String? deviceId, bool keyRestoreFailed
});


@override $UserCopyWith<$Res>? get user;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? user = freezed,Object? verificationId = freezed,Object? phoneNumber = freezed,Object? errorMessage = freezed,Object? isLoading = null,Object? resendCountdown = null,Object? isDeviceBound = null,Object? deviceId = freezed,Object? keyRestoreFailed = null,}) {
  return _then(_AuthState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,verificationId: freezed == verificationId ? _self.verificationId : verificationId // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,resendCountdown: null == resendCountdown ? _self.resendCountdown : resendCountdown // ignore: cast_nullable_to_non_nullable
as int,isDeviceBound: null == isDeviceBound ? _self.isDeviceBound : isDeviceBound // ignore: cast_nullable_to_non_nullable
as bool,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,keyRestoreFailed: null == keyRestoreFailed ? _self.keyRestoreFailed : keyRestoreFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
