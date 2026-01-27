// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String phoneNumber) sendOtp,
    required TResult Function(String verificationId, String otp) verifyOtp,
    required TResult Function(String phoneNumber) resendOtp,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
    required TResult Function() acceptTerms,
    required TResult Function() completeOnboarding,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String phoneNumber)? sendOtp,
    TResult? Function(String verificationId, String otp)? verifyOtp,
    TResult? Function(String phoneNumber)? resendOtp,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
    TResult? Function()? acceptTerms,
    TResult? Function()? completeOnboarding,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String phoneNumber)? sendOtp,
    TResult Function(String verificationId, String otp)? verifyOtp,
    TResult Function(String phoneNumber)? resendOtp,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    TResult Function()? acceptTerms,
    TResult Function()? completeOnboarding,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_SendOtp value) sendOtp,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_AcceptTerms value) acceptTerms,
    required TResult Function(_CompleteOnboarding value) completeOnboarding,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_AcceptTerms value)? acceptTerms,
    TResult? Function(_CompleteOnboarding value)? completeOnboarding,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_SendOtp value)? sendOtp,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_AcceptTerms value)? acceptTerms,
    TResult Function(_CompleteOnboarding value)? completeOnboarding,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CheckAuthStatusImplCopyWith<$Res> {
  factory _$$CheckAuthStatusImplCopyWith(
    _$CheckAuthStatusImpl value,
    $Res Function(_$CheckAuthStatusImpl) then,
  ) = __$$CheckAuthStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckAuthStatusImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$CheckAuthStatusImpl>
    implements _$$CheckAuthStatusImplCopyWith<$Res> {
  __$$CheckAuthStatusImplCopyWithImpl(
    _$CheckAuthStatusImpl _value,
    $Res Function(_$CheckAuthStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckAuthStatusImpl implements _CheckAuthStatus {
  const _$CheckAuthStatusImpl();

  @override
  String toString() {
    return 'AuthEvent.checkAuthStatus()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckAuthStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String phoneNumber) sendOtp,
    required TResult Function(String verificationId, String otp) verifyOtp,
    required TResult Function(String phoneNumber) resendOtp,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
    required TResult Function() acceptTerms,
    required TResult Function() completeOnboarding,
  }) {
    return checkAuthStatus();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String phoneNumber)? sendOtp,
    TResult? Function(String verificationId, String otp)? verifyOtp,
    TResult? Function(String phoneNumber)? resendOtp,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
    TResult? Function()? acceptTerms,
    TResult? Function()? completeOnboarding,
  }) {
    return checkAuthStatus?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String phoneNumber)? sendOtp,
    TResult Function(String verificationId, String otp)? verifyOtp,
    TResult Function(String phoneNumber)? resendOtp,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    TResult Function()? acceptTerms,
    TResult Function()? completeOnboarding,
    required TResult orElse(),
  }) {
    if (checkAuthStatus != null) {
      return checkAuthStatus();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_SendOtp value) sendOtp,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_AcceptTerms value) acceptTerms,
    required TResult Function(_CompleteOnboarding value) completeOnboarding,
  }) {
    return checkAuthStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_AcceptTerms value)? acceptTerms,
    TResult? Function(_CompleteOnboarding value)? completeOnboarding,
  }) {
    return checkAuthStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_SendOtp value)? sendOtp,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_AcceptTerms value)? acceptTerms,
    TResult Function(_CompleteOnboarding value)? completeOnboarding,
    required TResult orElse(),
  }) {
    if (checkAuthStatus != null) {
      return checkAuthStatus(this);
    }
    return orElse();
  }
}

abstract class _CheckAuthStatus implements AuthEvent {
  const factory _CheckAuthStatus() = _$CheckAuthStatusImpl;
}

/// @nodoc
abstract class _$$SendOtpImplCopyWith<$Res> {
  factory _$$SendOtpImplCopyWith(
    _$SendOtpImpl value,
    $Res Function(_$SendOtpImpl) then,
  ) = __$$SendOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class __$$SendOtpImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SendOtpImpl>
    implements _$$SendOtpImplCopyWith<$Res> {
  __$$SendOtpImplCopyWithImpl(
    _$SendOtpImpl _value,
    $Res Function(_$SendOtpImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? phoneNumber = null}) {
    return _then(
      _$SendOtpImpl(
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SendOtpImpl implements _SendOtp {
  const _$SendOtpImpl({required this.phoneNumber});

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'AuthEvent.sendOtp(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendOtpImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendOtpImplCopyWith<_$SendOtpImpl> get copyWith =>
      __$$SendOtpImplCopyWithImpl<_$SendOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String phoneNumber) sendOtp,
    required TResult Function(String verificationId, String otp) verifyOtp,
    required TResult Function(String phoneNumber) resendOtp,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
    required TResult Function() acceptTerms,
    required TResult Function() completeOnboarding,
  }) {
    return sendOtp(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String phoneNumber)? sendOtp,
    TResult? Function(String verificationId, String otp)? verifyOtp,
    TResult? Function(String phoneNumber)? resendOtp,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
    TResult? Function()? acceptTerms,
    TResult? Function()? completeOnboarding,
  }) {
    return sendOtp?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String phoneNumber)? sendOtp,
    TResult Function(String verificationId, String otp)? verifyOtp,
    TResult Function(String phoneNumber)? resendOtp,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    TResult Function()? acceptTerms,
    TResult Function()? completeOnboarding,
    required TResult orElse(),
  }) {
    if (sendOtp != null) {
      return sendOtp(phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_SendOtp value) sendOtp,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_AcceptTerms value) acceptTerms,
    required TResult Function(_CompleteOnboarding value) completeOnboarding,
  }) {
    return sendOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_AcceptTerms value)? acceptTerms,
    TResult? Function(_CompleteOnboarding value)? completeOnboarding,
  }) {
    return sendOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_SendOtp value)? sendOtp,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_AcceptTerms value)? acceptTerms,
    TResult Function(_CompleteOnboarding value)? completeOnboarding,
    required TResult orElse(),
  }) {
    if (sendOtp != null) {
      return sendOtp(this);
    }
    return orElse();
  }
}

abstract class _SendOtp implements AuthEvent {
  const factory _SendOtp({required final String phoneNumber}) = _$SendOtpImpl;

  String get phoneNumber;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendOtpImplCopyWith<_$SendOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyOtpImplCopyWith<$Res> {
  factory _$$VerifyOtpImplCopyWith(
    _$VerifyOtpImpl value,
    $Res Function(_$VerifyOtpImpl) then,
  ) = __$$VerifyOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String verificationId, String otp});
}

/// @nodoc
class __$$VerifyOtpImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$VerifyOtpImpl>
    implements _$$VerifyOtpImplCopyWith<$Res> {
  __$$VerifyOtpImplCopyWithImpl(
    _$VerifyOtpImpl _value,
    $Res Function(_$VerifyOtpImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? verificationId = null, Object? otp = null}) {
    return _then(
      _$VerifyOtpImpl(
        verificationId: null == verificationId
            ? _value.verificationId
            : verificationId // ignore: cast_nullable_to_non_nullable
                  as String,
        otp: null == otp
            ? _value.otp
            : otp // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$VerifyOtpImpl implements _VerifyOtp {
  const _$VerifyOtpImpl({required this.verificationId, required this.otp});

  @override
  final String verificationId;
  @override
  final String otp;

  @override
  String toString() {
    return 'AuthEvent.verifyOtp(verificationId: $verificationId, otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpImpl &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, verificationId, otp);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpImplCopyWith<_$VerifyOtpImpl> get copyWith =>
      __$$VerifyOtpImplCopyWithImpl<_$VerifyOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String phoneNumber) sendOtp,
    required TResult Function(String verificationId, String otp) verifyOtp,
    required TResult Function(String phoneNumber) resendOtp,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
    required TResult Function() acceptTerms,
    required TResult Function() completeOnboarding,
  }) {
    return verifyOtp(verificationId, otp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String phoneNumber)? sendOtp,
    TResult? Function(String verificationId, String otp)? verifyOtp,
    TResult? Function(String phoneNumber)? resendOtp,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
    TResult? Function()? acceptTerms,
    TResult? Function()? completeOnboarding,
  }) {
    return verifyOtp?.call(verificationId, otp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String phoneNumber)? sendOtp,
    TResult Function(String verificationId, String otp)? verifyOtp,
    TResult Function(String phoneNumber)? resendOtp,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    TResult Function()? acceptTerms,
    TResult Function()? completeOnboarding,
    required TResult orElse(),
  }) {
    if (verifyOtp != null) {
      return verifyOtp(verificationId, otp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_SendOtp value) sendOtp,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_AcceptTerms value) acceptTerms,
    required TResult Function(_CompleteOnboarding value) completeOnboarding,
  }) {
    return verifyOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_AcceptTerms value)? acceptTerms,
    TResult? Function(_CompleteOnboarding value)? completeOnboarding,
  }) {
    return verifyOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_SendOtp value)? sendOtp,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_AcceptTerms value)? acceptTerms,
    TResult Function(_CompleteOnboarding value)? completeOnboarding,
    required TResult orElse(),
  }) {
    if (verifyOtp != null) {
      return verifyOtp(this);
    }
    return orElse();
  }
}

abstract class _VerifyOtp implements AuthEvent {
  const factory _VerifyOtp({
    required final String verificationId,
    required final String otp,
  }) = _$VerifyOtpImpl;

  String get verificationId;
  String get otp;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyOtpImplCopyWith<_$VerifyOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResendOtpImplCopyWith<$Res> {
  factory _$$ResendOtpImplCopyWith(
    _$ResendOtpImpl value,
    $Res Function(_$ResendOtpImpl) then,
  ) = __$$ResendOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class __$$ResendOtpImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ResendOtpImpl>
    implements _$$ResendOtpImplCopyWith<$Res> {
  __$$ResendOtpImplCopyWithImpl(
    _$ResendOtpImpl _value,
    $Res Function(_$ResendOtpImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? phoneNumber = null}) {
    return _then(
      _$ResendOtpImpl(
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ResendOtpImpl implements _ResendOtp {
  const _$ResendOtpImpl({required this.phoneNumber});

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'AuthEvent.resendOtp(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendOtpImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResendOtpImplCopyWith<_$ResendOtpImpl> get copyWith =>
      __$$ResendOtpImplCopyWithImpl<_$ResendOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String phoneNumber) sendOtp,
    required TResult Function(String verificationId, String otp) verifyOtp,
    required TResult Function(String phoneNumber) resendOtp,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
    required TResult Function() acceptTerms,
    required TResult Function() completeOnboarding,
  }) {
    return resendOtp(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String phoneNumber)? sendOtp,
    TResult? Function(String verificationId, String otp)? verifyOtp,
    TResult? Function(String phoneNumber)? resendOtp,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
    TResult? Function()? acceptTerms,
    TResult? Function()? completeOnboarding,
  }) {
    return resendOtp?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String phoneNumber)? sendOtp,
    TResult Function(String verificationId, String otp)? verifyOtp,
    TResult Function(String phoneNumber)? resendOtp,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    TResult Function()? acceptTerms,
    TResult Function()? completeOnboarding,
    required TResult orElse(),
  }) {
    if (resendOtp != null) {
      return resendOtp(phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_SendOtp value) sendOtp,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_AcceptTerms value) acceptTerms,
    required TResult Function(_CompleteOnboarding value) completeOnboarding,
  }) {
    return resendOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_AcceptTerms value)? acceptTerms,
    TResult? Function(_CompleteOnboarding value)? completeOnboarding,
  }) {
    return resendOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_SendOtp value)? sendOtp,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_AcceptTerms value)? acceptTerms,
    TResult Function(_CompleteOnboarding value)? completeOnboarding,
    required TResult orElse(),
  }) {
    if (resendOtp != null) {
      return resendOtp(this);
    }
    return orElse();
  }
}

abstract class _ResendOtp implements AuthEvent {
  const factory _ResendOtp({required final String phoneNumber}) =
      _$ResendOtpImpl;

  String get phoneNumber;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResendOtpImplCopyWith<_$ResendOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignOutImplCopyWith<$Res> {
  factory _$$SignOutImplCopyWith(
    _$SignOutImpl value,
    $Res Function(_$SignOutImpl) then,
  ) = __$$SignOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignOutImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignOutImpl>
    implements _$$SignOutImplCopyWith<$Res> {
  __$$SignOutImplCopyWithImpl(
    _$SignOutImpl _value,
    $Res Function(_$SignOutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignOutImpl implements _SignOut {
  const _$SignOutImpl();

  @override
  String toString() {
    return 'AuthEvent.signOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String phoneNumber) sendOtp,
    required TResult Function(String verificationId, String otp) verifyOtp,
    required TResult Function(String phoneNumber) resendOtp,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
    required TResult Function() acceptTerms,
    required TResult Function() completeOnboarding,
  }) {
    return signOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String phoneNumber)? sendOtp,
    TResult? Function(String verificationId, String otp)? verifyOtp,
    TResult? Function(String phoneNumber)? resendOtp,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
    TResult? Function()? acceptTerms,
    TResult? Function()? completeOnboarding,
  }) {
    return signOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String phoneNumber)? sendOtp,
    TResult Function(String verificationId, String otp)? verifyOtp,
    TResult Function(String phoneNumber)? resendOtp,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    TResult Function()? acceptTerms,
    TResult Function()? completeOnboarding,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_SendOtp value) sendOtp,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_AcceptTerms value) acceptTerms,
    required TResult Function(_CompleteOnboarding value) completeOnboarding,
  }) {
    return signOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_AcceptTerms value)? acceptTerms,
    TResult? Function(_CompleteOnboarding value)? completeOnboarding,
  }) {
    return signOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_SendOtp value)? sendOtp,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_AcceptTerms value)? acceptTerms,
    TResult Function(_CompleteOnboarding value)? completeOnboarding,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut(this);
    }
    return orElse();
  }
}

abstract class _SignOut implements AuthEvent {
  const factory _SignOut() = _$SignOutImpl;
}

/// @nodoc
abstract class _$$DeleteAccountImplCopyWith<$Res> {
  factory _$$DeleteAccountImplCopyWith(
    _$DeleteAccountImpl value,
    $Res Function(_$DeleteAccountImpl) then,
  ) = __$$DeleteAccountImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeleteAccountImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$DeleteAccountImpl>
    implements _$$DeleteAccountImplCopyWith<$Res> {
  __$$DeleteAccountImplCopyWithImpl(
    _$DeleteAccountImpl _value,
    $Res Function(_$DeleteAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeleteAccountImpl implements _DeleteAccount {
  const _$DeleteAccountImpl();

  @override
  String toString() {
    return 'AuthEvent.deleteAccount()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeleteAccountImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String phoneNumber) sendOtp,
    required TResult Function(String verificationId, String otp) verifyOtp,
    required TResult Function(String phoneNumber) resendOtp,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
    required TResult Function() acceptTerms,
    required TResult Function() completeOnboarding,
  }) {
    return deleteAccount();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String phoneNumber)? sendOtp,
    TResult? Function(String verificationId, String otp)? verifyOtp,
    TResult? Function(String phoneNumber)? resendOtp,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
    TResult? Function()? acceptTerms,
    TResult? Function()? completeOnboarding,
  }) {
    return deleteAccount?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String phoneNumber)? sendOtp,
    TResult Function(String verificationId, String otp)? verifyOtp,
    TResult Function(String phoneNumber)? resendOtp,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    TResult Function()? acceptTerms,
    TResult Function()? completeOnboarding,
    required TResult orElse(),
  }) {
    if (deleteAccount != null) {
      return deleteAccount();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_SendOtp value) sendOtp,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_AcceptTerms value) acceptTerms,
    required TResult Function(_CompleteOnboarding value) completeOnboarding,
  }) {
    return deleteAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_AcceptTerms value)? acceptTerms,
    TResult? Function(_CompleteOnboarding value)? completeOnboarding,
  }) {
    return deleteAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_SendOtp value)? sendOtp,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_AcceptTerms value)? acceptTerms,
    TResult Function(_CompleteOnboarding value)? completeOnboarding,
    required TResult orElse(),
  }) {
    if (deleteAccount != null) {
      return deleteAccount(this);
    }
    return orElse();
  }
}

abstract class _DeleteAccount implements AuthEvent {
  const factory _DeleteAccount() = _$DeleteAccountImpl;
}

/// @nodoc
abstract class _$$AcceptTermsImplCopyWith<$Res> {
  factory _$$AcceptTermsImplCopyWith(
    _$AcceptTermsImpl value,
    $Res Function(_$AcceptTermsImpl) then,
  ) = __$$AcceptTermsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AcceptTermsImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AcceptTermsImpl>
    implements _$$AcceptTermsImplCopyWith<$Res> {
  __$$AcceptTermsImplCopyWithImpl(
    _$AcceptTermsImpl _value,
    $Res Function(_$AcceptTermsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AcceptTermsImpl implements _AcceptTerms {
  const _$AcceptTermsImpl();

  @override
  String toString() {
    return 'AuthEvent.acceptTerms()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AcceptTermsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String phoneNumber) sendOtp,
    required TResult Function(String verificationId, String otp) verifyOtp,
    required TResult Function(String phoneNumber) resendOtp,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
    required TResult Function() acceptTerms,
    required TResult Function() completeOnboarding,
  }) {
    return acceptTerms();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String phoneNumber)? sendOtp,
    TResult? Function(String verificationId, String otp)? verifyOtp,
    TResult? Function(String phoneNumber)? resendOtp,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
    TResult? Function()? acceptTerms,
    TResult? Function()? completeOnboarding,
  }) {
    return acceptTerms?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String phoneNumber)? sendOtp,
    TResult Function(String verificationId, String otp)? verifyOtp,
    TResult Function(String phoneNumber)? resendOtp,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    TResult Function()? acceptTerms,
    TResult Function()? completeOnboarding,
    required TResult orElse(),
  }) {
    if (acceptTerms != null) {
      return acceptTerms();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_SendOtp value) sendOtp,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_AcceptTerms value) acceptTerms,
    required TResult Function(_CompleteOnboarding value) completeOnboarding,
  }) {
    return acceptTerms(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_AcceptTerms value)? acceptTerms,
    TResult? Function(_CompleteOnboarding value)? completeOnboarding,
  }) {
    return acceptTerms?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_SendOtp value)? sendOtp,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_AcceptTerms value)? acceptTerms,
    TResult Function(_CompleteOnboarding value)? completeOnboarding,
    required TResult orElse(),
  }) {
    if (acceptTerms != null) {
      return acceptTerms(this);
    }
    return orElse();
  }
}

abstract class _AcceptTerms implements AuthEvent {
  const factory _AcceptTerms() = _$AcceptTermsImpl;
}

/// @nodoc
abstract class _$$CompleteOnboardingImplCopyWith<$Res> {
  factory _$$CompleteOnboardingImplCopyWith(
    _$CompleteOnboardingImpl value,
    $Res Function(_$CompleteOnboardingImpl) then,
  ) = __$$CompleteOnboardingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompleteOnboardingImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$CompleteOnboardingImpl>
    implements _$$CompleteOnboardingImplCopyWith<$Res> {
  __$$CompleteOnboardingImplCopyWithImpl(
    _$CompleteOnboardingImpl _value,
    $Res Function(_$CompleteOnboardingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CompleteOnboardingImpl implements _CompleteOnboarding {
  const _$CompleteOnboardingImpl();

  @override
  String toString() {
    return 'AuthEvent.completeOnboarding()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompleteOnboardingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(String phoneNumber) sendOtp,
    required TResult Function(String verificationId, String otp) verifyOtp,
    required TResult Function(String phoneNumber) resendOtp,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
    required TResult Function() acceptTerms,
    required TResult Function() completeOnboarding,
  }) {
    return completeOnboarding();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String phoneNumber)? sendOtp,
    TResult? Function(String verificationId, String otp)? verifyOtp,
    TResult? Function(String phoneNumber)? resendOtp,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
    TResult? Function()? acceptTerms,
    TResult? Function()? completeOnboarding,
  }) {
    return completeOnboarding?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String phoneNumber)? sendOtp,
    TResult Function(String verificationId, String otp)? verifyOtp,
    TResult Function(String phoneNumber)? resendOtp,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    TResult Function()? acceptTerms,
    TResult Function()? completeOnboarding,
    required TResult orElse(),
  }) {
    if (completeOnboarding != null) {
      return completeOnboarding();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_SendOtp value) sendOtp,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
    required TResult Function(_AcceptTerms value) acceptTerms,
    required TResult Function(_CompleteOnboarding value) completeOnboarding,
  }) {
    return completeOnboarding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
    TResult? Function(_AcceptTerms value)? acceptTerms,
    TResult? Function(_CompleteOnboarding value)? completeOnboarding,
  }) {
    return completeOnboarding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_SendOtp value)? sendOtp,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    TResult Function(_AcceptTerms value)? acceptTerms,
    TResult Function(_CompleteOnboarding value)? completeOnboarding,
    required TResult orElse(),
  }) {
    if (completeOnboarding != null) {
      return completeOnboarding(this);
    }
    return orElse();
  }
}

abstract class _CompleteOnboarding implements AuthEvent {
  const factory _CompleteOnboarding() = _$CompleteOnboardingImpl;
}

/// @nodoc
mixin _$AuthState {
  AuthStatus get status => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  String? get verificationId => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  int get resendCountdown => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({
    AuthStatus status,
    User? user,
    String? verificationId,
    String? phoneNumber,
    String? errorMessage,
    bool isLoading,
    int resendCountdown,
  });

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? user = freezed,
    Object? verificationId = freezed,
    Object? phoneNumber = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = null,
    Object? resendCountdown = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AuthStatus,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as User?,
            verificationId: freezed == verificationId
                ? _value.verificationId
                : verificationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            resendCountdown: null == resendCountdown
                ? _value.resendCountdown
                : resendCountdown // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
    _$AuthStateImpl value,
    $Res Function(_$AuthStateImpl) then,
  ) = __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AuthStatus status,
    User? user,
    String? verificationId,
    String? phoneNumber,
    String? errorMessage,
    bool isLoading,
    int resendCountdown,
  });

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
    _$AuthStateImpl _value,
    $Res Function(_$AuthStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? user = freezed,
    Object? verificationId = freezed,
    Object? phoneNumber = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = null,
    Object? resendCountdown = null,
  }) {
    return _then(
      _$AuthStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AuthStatus,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as User?,
        verificationId: freezed == verificationId
            ? _value.verificationId
            : verificationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        resendCountdown: null == resendCountdown
            ? _value.resendCountdown
            : resendCountdown // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateImpl extends _AuthState {
  const _$AuthStateImpl({
    this.status = AuthStatus.initial,
    this.user,
    this.verificationId,
    this.phoneNumber,
    this.errorMessage,
    this.isLoading = false,
    this.resendCountdown = 0,
  }) : super._();

  @override
  @JsonKey()
  final AuthStatus status;
  @override
  final User? user;
  @override
  final String? verificationId;
  @override
  final String? phoneNumber;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final int resendCountdown;

  @override
  String toString() {
    return 'AuthState(status: $status, user: $user, verificationId: $verificationId, phoneNumber: $phoneNumber, errorMessage: $errorMessage, isLoading: $isLoading, resendCountdown: $resendCountdown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.resendCountdown, resendCountdown) ||
                other.resendCountdown == resendCountdown));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    user,
    verificationId,
    phoneNumber,
    errorMessage,
    isLoading,
    resendCountdown,
  );

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState extends AuthState {
  const factory _AuthState({
    final AuthStatus status,
    final User? user,
    final String? verificationId,
    final String? phoneNumber,
    final String? errorMessage,
    final bool isLoading,
    final int resendCountdown,
  }) = _$AuthStateImpl;
  const _AuthState._() : super._();

  @override
  AuthStatus get status;
  @override
  User? get user;
  @override
  String? get verificationId;
  @override
  String? get phoneNumber;
  @override
  String? get errorMessage;
  @override
  bool get isLoading;
  @override
  int get resendCountdown;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
