// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_spray_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TokenSprayEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )
    createSpray,
    required TResult Function(String sprayId, int amount, String? message)
    contribute,
    required TResult Function(String sprayId) closeSpray,
    required TResult Function(String sprayId) claimSpray,
    required TResult Function(String sprayId) watchSpray,
    required TResult Function(TokenSpray spray) sprayUpdated,
    required TResult Function() loadHistory,
    required TResult Function() clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult? Function(String sprayId, int amount, String? message)? contribute,
    TResult? Function(String sprayId)? closeSpray,
    TResult? Function(String sprayId)? claimSpray,
    TResult? Function(String sprayId)? watchSpray,
    TResult? Function(TokenSpray spray)? sprayUpdated,
    TResult? Function()? loadHistory,
    TResult? Function()? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult Function(String sprayId, int amount, String? message)? contribute,
    TResult Function(String sprayId)? closeSpray,
    TResult Function(String sprayId)? claimSpray,
    TResult Function(String sprayId)? watchSpray,
    TResult Function(TokenSpray spray)? sprayUpdated,
    TResult Function()? loadHistory,
    TResult Function()? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateSpray value) createSpray,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_CloseSpray value) closeSpray,
    required TResult Function(_ClaimSpray value) claimSpray,
    required TResult Function(_WatchSpray value) watchSpray,
    required TResult Function(_SprayUpdated value) sprayUpdated,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_ClearError value) clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateSpray value)? createSpray,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_CloseSpray value)? closeSpray,
    TResult? Function(_ClaimSpray value)? claimSpray,
    TResult? Function(_WatchSpray value)? watchSpray,
    TResult? Function(_SprayUpdated value)? sprayUpdated,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_ClearError value)? clearError,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateSpray value)? createSpray,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_CloseSpray value)? closeSpray,
    TResult Function(_ClaimSpray value)? claimSpray,
    TResult Function(_WatchSpray value)? watchSpray,
    TResult Function(_SprayUpdated value)? sprayUpdated,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenSprayEventCopyWith<$Res> {
  factory $TokenSprayEventCopyWith(
    TokenSprayEvent value,
    $Res Function(TokenSprayEvent) then,
  ) = _$TokenSprayEventCopyWithImpl<$Res, TokenSprayEvent>;
}

/// @nodoc
class _$TokenSprayEventCopyWithImpl<$Res, $Val extends TokenSprayEvent>
    implements $TokenSprayEventCopyWith<$Res> {
  _$TokenSprayEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CreateSprayImplCopyWith<$Res> {
  factory _$$CreateSprayImplCopyWith(
    _$CreateSprayImpl value,
    $Res Function(_$CreateSprayImpl) then,
  ) = __$$CreateSprayImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String recipientId,
    SprayOccasion occasion,
    String message,
    int? targetAmount,
  });
}

/// @nodoc
class __$$CreateSprayImplCopyWithImpl<$Res>
    extends _$TokenSprayEventCopyWithImpl<$Res, _$CreateSprayImpl>
    implements _$$CreateSprayImplCopyWith<$Res> {
  __$$CreateSprayImplCopyWithImpl(
    _$CreateSprayImpl _value,
    $Res Function(_$CreateSprayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipientId = null,
    Object? occasion = null,
    Object? message = null,
    Object? targetAmount = freezed,
  }) {
    return _then(
      _$CreateSprayImpl(
        recipientId: null == recipientId
            ? _value.recipientId
            : recipientId // ignore: cast_nullable_to_non_nullable
                  as String,
        occasion: null == occasion
            ? _value.occasion
            : occasion // ignore: cast_nullable_to_non_nullable
                  as SprayOccasion,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        targetAmount: freezed == targetAmount
            ? _value.targetAmount
            : targetAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$CreateSprayImpl implements _CreateSpray {
  const _$CreateSprayImpl({
    required this.recipientId,
    required this.occasion,
    required this.message,
    this.targetAmount,
  });

  @override
  final String recipientId;
  @override
  final SprayOccasion occasion;
  @override
  final String message;
  @override
  final int? targetAmount;

  @override
  String toString() {
    return 'TokenSprayEvent.createSpray(recipientId: $recipientId, occasion: $occasion, message: $message, targetAmount: $targetAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSprayImpl &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.occasion, occasion) ||
                other.occasion == occasion) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, recipientId, occasion, message, targetAmount);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSprayImplCopyWith<_$CreateSprayImpl> get copyWith =>
      __$$CreateSprayImplCopyWithImpl<_$CreateSprayImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )
    createSpray,
    required TResult Function(String sprayId, int amount, String? message)
    contribute,
    required TResult Function(String sprayId) closeSpray,
    required TResult Function(String sprayId) claimSpray,
    required TResult Function(String sprayId) watchSpray,
    required TResult Function(TokenSpray spray) sprayUpdated,
    required TResult Function() loadHistory,
    required TResult Function() clearError,
  }) {
    return createSpray(recipientId, occasion, message, targetAmount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult? Function(String sprayId, int amount, String? message)? contribute,
    TResult? Function(String sprayId)? closeSpray,
    TResult? Function(String sprayId)? claimSpray,
    TResult? Function(String sprayId)? watchSpray,
    TResult? Function(TokenSpray spray)? sprayUpdated,
    TResult? Function()? loadHistory,
    TResult? Function()? clearError,
  }) {
    return createSpray?.call(recipientId, occasion, message, targetAmount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult Function(String sprayId, int amount, String? message)? contribute,
    TResult Function(String sprayId)? closeSpray,
    TResult Function(String sprayId)? claimSpray,
    TResult Function(String sprayId)? watchSpray,
    TResult Function(TokenSpray spray)? sprayUpdated,
    TResult Function()? loadHistory,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (createSpray != null) {
      return createSpray(recipientId, occasion, message, targetAmount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateSpray value) createSpray,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_CloseSpray value) closeSpray,
    required TResult Function(_ClaimSpray value) claimSpray,
    required TResult Function(_WatchSpray value) watchSpray,
    required TResult Function(_SprayUpdated value) sprayUpdated,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_ClearError value) clearError,
  }) {
    return createSpray(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateSpray value)? createSpray,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_CloseSpray value)? closeSpray,
    TResult? Function(_ClaimSpray value)? claimSpray,
    TResult? Function(_WatchSpray value)? watchSpray,
    TResult? Function(_SprayUpdated value)? sprayUpdated,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return createSpray?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateSpray value)? createSpray,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_CloseSpray value)? closeSpray,
    TResult Function(_ClaimSpray value)? claimSpray,
    TResult Function(_WatchSpray value)? watchSpray,
    TResult Function(_SprayUpdated value)? sprayUpdated,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (createSpray != null) {
      return createSpray(this);
    }
    return orElse();
  }
}

abstract class _CreateSpray implements TokenSprayEvent {
  const factory _CreateSpray({
    required final String recipientId,
    required final SprayOccasion occasion,
    required final String message,
    final int? targetAmount,
  }) = _$CreateSprayImpl;

  String get recipientId;
  SprayOccasion get occasion;
  String get message;
  int? get targetAmount;

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateSprayImplCopyWith<_$CreateSprayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContributeImplCopyWith<$Res> {
  factory _$$ContributeImplCopyWith(
    _$ContributeImpl value,
    $Res Function(_$ContributeImpl) then,
  ) = __$$ContributeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sprayId, int amount, String? message});
}

/// @nodoc
class __$$ContributeImplCopyWithImpl<$Res>
    extends _$TokenSprayEventCopyWithImpl<$Res, _$ContributeImpl>
    implements _$$ContributeImplCopyWith<$Res> {
  __$$ContributeImplCopyWithImpl(
    _$ContributeImpl _value,
    $Res Function(_$ContributeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sprayId = null,
    Object? amount = null,
    Object? message = freezed,
  }) {
    return _then(
      _$ContributeImpl(
        sprayId: null == sprayId
            ? _value.sprayId
            : sprayId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ContributeImpl implements _Contribute {
  const _$ContributeImpl({
    required this.sprayId,
    required this.amount,
    this.message,
  });

  @override
  final String sprayId;
  @override
  final int amount;
  @override
  final String? message;

  @override
  String toString() {
    return 'TokenSprayEvent.contribute(sprayId: $sprayId, amount: $amount, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContributeImpl &&
            (identical(other.sprayId, sprayId) || other.sprayId == sprayId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sprayId, amount, message);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContributeImplCopyWith<_$ContributeImpl> get copyWith =>
      __$$ContributeImplCopyWithImpl<_$ContributeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )
    createSpray,
    required TResult Function(String sprayId, int amount, String? message)
    contribute,
    required TResult Function(String sprayId) closeSpray,
    required TResult Function(String sprayId) claimSpray,
    required TResult Function(String sprayId) watchSpray,
    required TResult Function(TokenSpray spray) sprayUpdated,
    required TResult Function() loadHistory,
    required TResult Function() clearError,
  }) {
    return contribute(sprayId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult? Function(String sprayId, int amount, String? message)? contribute,
    TResult? Function(String sprayId)? closeSpray,
    TResult? Function(String sprayId)? claimSpray,
    TResult? Function(String sprayId)? watchSpray,
    TResult? Function(TokenSpray spray)? sprayUpdated,
    TResult? Function()? loadHistory,
    TResult? Function()? clearError,
  }) {
    return contribute?.call(sprayId, amount, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult Function(String sprayId, int amount, String? message)? contribute,
    TResult Function(String sprayId)? closeSpray,
    TResult Function(String sprayId)? claimSpray,
    TResult Function(String sprayId)? watchSpray,
    TResult Function(TokenSpray spray)? sprayUpdated,
    TResult Function()? loadHistory,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (contribute != null) {
      return contribute(sprayId, amount, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateSpray value) createSpray,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_CloseSpray value) closeSpray,
    required TResult Function(_ClaimSpray value) claimSpray,
    required TResult Function(_WatchSpray value) watchSpray,
    required TResult Function(_SprayUpdated value) sprayUpdated,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_ClearError value) clearError,
  }) {
    return contribute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateSpray value)? createSpray,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_CloseSpray value)? closeSpray,
    TResult? Function(_ClaimSpray value)? claimSpray,
    TResult? Function(_WatchSpray value)? watchSpray,
    TResult? Function(_SprayUpdated value)? sprayUpdated,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return contribute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateSpray value)? createSpray,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_CloseSpray value)? closeSpray,
    TResult Function(_ClaimSpray value)? claimSpray,
    TResult Function(_WatchSpray value)? watchSpray,
    TResult Function(_SprayUpdated value)? sprayUpdated,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (contribute != null) {
      return contribute(this);
    }
    return orElse();
  }
}

abstract class _Contribute implements TokenSprayEvent {
  const factory _Contribute({
    required final String sprayId,
    required final int amount,
    final String? message,
  }) = _$ContributeImpl;

  String get sprayId;
  int get amount;
  String? get message;

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContributeImplCopyWith<_$ContributeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CloseSprayImplCopyWith<$Res> {
  factory _$$CloseSprayImplCopyWith(
    _$CloseSprayImpl value,
    $Res Function(_$CloseSprayImpl) then,
  ) = __$$CloseSprayImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sprayId});
}

/// @nodoc
class __$$CloseSprayImplCopyWithImpl<$Res>
    extends _$TokenSprayEventCopyWithImpl<$Res, _$CloseSprayImpl>
    implements _$$CloseSprayImplCopyWith<$Res> {
  __$$CloseSprayImplCopyWithImpl(
    _$CloseSprayImpl _value,
    $Res Function(_$CloseSprayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sprayId = null}) {
    return _then(
      _$CloseSprayImpl(
        null == sprayId
            ? _value.sprayId
            : sprayId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CloseSprayImpl implements _CloseSpray {
  const _$CloseSprayImpl(this.sprayId);

  @override
  final String sprayId;

  @override
  String toString() {
    return 'TokenSprayEvent.closeSpray(sprayId: $sprayId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CloseSprayImpl &&
            (identical(other.sprayId, sprayId) || other.sprayId == sprayId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sprayId);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CloseSprayImplCopyWith<_$CloseSprayImpl> get copyWith =>
      __$$CloseSprayImplCopyWithImpl<_$CloseSprayImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )
    createSpray,
    required TResult Function(String sprayId, int amount, String? message)
    contribute,
    required TResult Function(String sprayId) closeSpray,
    required TResult Function(String sprayId) claimSpray,
    required TResult Function(String sprayId) watchSpray,
    required TResult Function(TokenSpray spray) sprayUpdated,
    required TResult Function() loadHistory,
    required TResult Function() clearError,
  }) {
    return closeSpray(sprayId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult? Function(String sprayId, int amount, String? message)? contribute,
    TResult? Function(String sprayId)? closeSpray,
    TResult? Function(String sprayId)? claimSpray,
    TResult? Function(String sprayId)? watchSpray,
    TResult? Function(TokenSpray spray)? sprayUpdated,
    TResult? Function()? loadHistory,
    TResult? Function()? clearError,
  }) {
    return closeSpray?.call(sprayId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult Function(String sprayId, int amount, String? message)? contribute,
    TResult Function(String sprayId)? closeSpray,
    TResult Function(String sprayId)? claimSpray,
    TResult Function(String sprayId)? watchSpray,
    TResult Function(TokenSpray spray)? sprayUpdated,
    TResult Function()? loadHistory,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (closeSpray != null) {
      return closeSpray(sprayId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateSpray value) createSpray,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_CloseSpray value) closeSpray,
    required TResult Function(_ClaimSpray value) claimSpray,
    required TResult Function(_WatchSpray value) watchSpray,
    required TResult Function(_SprayUpdated value) sprayUpdated,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_ClearError value) clearError,
  }) {
    return closeSpray(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateSpray value)? createSpray,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_CloseSpray value)? closeSpray,
    TResult? Function(_ClaimSpray value)? claimSpray,
    TResult? Function(_WatchSpray value)? watchSpray,
    TResult? Function(_SprayUpdated value)? sprayUpdated,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return closeSpray?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateSpray value)? createSpray,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_CloseSpray value)? closeSpray,
    TResult Function(_ClaimSpray value)? claimSpray,
    TResult Function(_WatchSpray value)? watchSpray,
    TResult Function(_SprayUpdated value)? sprayUpdated,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (closeSpray != null) {
      return closeSpray(this);
    }
    return orElse();
  }
}

abstract class _CloseSpray implements TokenSprayEvent {
  const factory _CloseSpray(final String sprayId) = _$CloseSprayImpl;

  String get sprayId;

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CloseSprayImplCopyWith<_$CloseSprayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClaimSprayImplCopyWith<$Res> {
  factory _$$ClaimSprayImplCopyWith(
    _$ClaimSprayImpl value,
    $Res Function(_$ClaimSprayImpl) then,
  ) = __$$ClaimSprayImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sprayId});
}

/// @nodoc
class __$$ClaimSprayImplCopyWithImpl<$Res>
    extends _$TokenSprayEventCopyWithImpl<$Res, _$ClaimSprayImpl>
    implements _$$ClaimSprayImplCopyWith<$Res> {
  __$$ClaimSprayImplCopyWithImpl(
    _$ClaimSprayImpl _value,
    $Res Function(_$ClaimSprayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sprayId = null}) {
    return _then(
      _$ClaimSprayImpl(
        null == sprayId
            ? _value.sprayId
            : sprayId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ClaimSprayImpl implements _ClaimSpray {
  const _$ClaimSprayImpl(this.sprayId);

  @override
  final String sprayId;

  @override
  String toString() {
    return 'TokenSprayEvent.claimSpray(sprayId: $sprayId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimSprayImpl &&
            (identical(other.sprayId, sprayId) || other.sprayId == sprayId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sprayId);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimSprayImplCopyWith<_$ClaimSprayImpl> get copyWith =>
      __$$ClaimSprayImplCopyWithImpl<_$ClaimSprayImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )
    createSpray,
    required TResult Function(String sprayId, int amount, String? message)
    contribute,
    required TResult Function(String sprayId) closeSpray,
    required TResult Function(String sprayId) claimSpray,
    required TResult Function(String sprayId) watchSpray,
    required TResult Function(TokenSpray spray) sprayUpdated,
    required TResult Function() loadHistory,
    required TResult Function() clearError,
  }) {
    return claimSpray(sprayId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult? Function(String sprayId, int amount, String? message)? contribute,
    TResult? Function(String sprayId)? closeSpray,
    TResult? Function(String sprayId)? claimSpray,
    TResult? Function(String sprayId)? watchSpray,
    TResult? Function(TokenSpray spray)? sprayUpdated,
    TResult? Function()? loadHistory,
    TResult? Function()? clearError,
  }) {
    return claimSpray?.call(sprayId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult Function(String sprayId, int amount, String? message)? contribute,
    TResult Function(String sprayId)? closeSpray,
    TResult Function(String sprayId)? claimSpray,
    TResult Function(String sprayId)? watchSpray,
    TResult Function(TokenSpray spray)? sprayUpdated,
    TResult Function()? loadHistory,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (claimSpray != null) {
      return claimSpray(sprayId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateSpray value) createSpray,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_CloseSpray value) closeSpray,
    required TResult Function(_ClaimSpray value) claimSpray,
    required TResult Function(_WatchSpray value) watchSpray,
    required TResult Function(_SprayUpdated value) sprayUpdated,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_ClearError value) clearError,
  }) {
    return claimSpray(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateSpray value)? createSpray,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_CloseSpray value)? closeSpray,
    TResult? Function(_ClaimSpray value)? claimSpray,
    TResult? Function(_WatchSpray value)? watchSpray,
    TResult? Function(_SprayUpdated value)? sprayUpdated,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return claimSpray?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateSpray value)? createSpray,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_CloseSpray value)? closeSpray,
    TResult Function(_ClaimSpray value)? claimSpray,
    TResult Function(_WatchSpray value)? watchSpray,
    TResult Function(_SprayUpdated value)? sprayUpdated,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (claimSpray != null) {
      return claimSpray(this);
    }
    return orElse();
  }
}

abstract class _ClaimSpray implements TokenSprayEvent {
  const factory _ClaimSpray(final String sprayId) = _$ClaimSprayImpl;

  String get sprayId;

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClaimSprayImplCopyWith<_$ClaimSprayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WatchSprayImplCopyWith<$Res> {
  factory _$$WatchSprayImplCopyWith(
    _$WatchSprayImpl value,
    $Res Function(_$WatchSprayImpl) then,
  ) = __$$WatchSprayImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sprayId});
}

/// @nodoc
class __$$WatchSprayImplCopyWithImpl<$Res>
    extends _$TokenSprayEventCopyWithImpl<$Res, _$WatchSprayImpl>
    implements _$$WatchSprayImplCopyWith<$Res> {
  __$$WatchSprayImplCopyWithImpl(
    _$WatchSprayImpl _value,
    $Res Function(_$WatchSprayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sprayId = null}) {
    return _then(
      _$WatchSprayImpl(
        null == sprayId
            ? _value.sprayId
            : sprayId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WatchSprayImpl implements _WatchSpray {
  const _$WatchSprayImpl(this.sprayId);

  @override
  final String sprayId;

  @override
  String toString() {
    return 'TokenSprayEvent.watchSpray(sprayId: $sprayId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchSprayImpl &&
            (identical(other.sprayId, sprayId) || other.sprayId == sprayId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sprayId);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchSprayImplCopyWith<_$WatchSprayImpl> get copyWith =>
      __$$WatchSprayImplCopyWithImpl<_$WatchSprayImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )
    createSpray,
    required TResult Function(String sprayId, int amount, String? message)
    contribute,
    required TResult Function(String sprayId) closeSpray,
    required TResult Function(String sprayId) claimSpray,
    required TResult Function(String sprayId) watchSpray,
    required TResult Function(TokenSpray spray) sprayUpdated,
    required TResult Function() loadHistory,
    required TResult Function() clearError,
  }) {
    return watchSpray(sprayId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult? Function(String sprayId, int amount, String? message)? contribute,
    TResult? Function(String sprayId)? closeSpray,
    TResult? Function(String sprayId)? claimSpray,
    TResult? Function(String sprayId)? watchSpray,
    TResult? Function(TokenSpray spray)? sprayUpdated,
    TResult? Function()? loadHistory,
    TResult? Function()? clearError,
  }) {
    return watchSpray?.call(sprayId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult Function(String sprayId, int amount, String? message)? contribute,
    TResult Function(String sprayId)? closeSpray,
    TResult Function(String sprayId)? claimSpray,
    TResult Function(String sprayId)? watchSpray,
    TResult Function(TokenSpray spray)? sprayUpdated,
    TResult Function()? loadHistory,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (watchSpray != null) {
      return watchSpray(sprayId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateSpray value) createSpray,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_CloseSpray value) closeSpray,
    required TResult Function(_ClaimSpray value) claimSpray,
    required TResult Function(_WatchSpray value) watchSpray,
    required TResult Function(_SprayUpdated value) sprayUpdated,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_ClearError value) clearError,
  }) {
    return watchSpray(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateSpray value)? createSpray,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_CloseSpray value)? closeSpray,
    TResult? Function(_ClaimSpray value)? claimSpray,
    TResult? Function(_WatchSpray value)? watchSpray,
    TResult? Function(_SprayUpdated value)? sprayUpdated,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return watchSpray?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateSpray value)? createSpray,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_CloseSpray value)? closeSpray,
    TResult Function(_ClaimSpray value)? claimSpray,
    TResult Function(_WatchSpray value)? watchSpray,
    TResult Function(_SprayUpdated value)? sprayUpdated,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (watchSpray != null) {
      return watchSpray(this);
    }
    return orElse();
  }
}

abstract class _WatchSpray implements TokenSprayEvent {
  const factory _WatchSpray(final String sprayId) = _$WatchSprayImpl;

  String get sprayId;

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchSprayImplCopyWith<_$WatchSprayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SprayUpdatedImplCopyWith<$Res> {
  factory _$$SprayUpdatedImplCopyWith(
    _$SprayUpdatedImpl value,
    $Res Function(_$SprayUpdatedImpl) then,
  ) = __$$SprayUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TokenSpray spray});

  $TokenSprayCopyWith<$Res> get spray;
}

/// @nodoc
class __$$SprayUpdatedImplCopyWithImpl<$Res>
    extends _$TokenSprayEventCopyWithImpl<$Res, _$SprayUpdatedImpl>
    implements _$$SprayUpdatedImplCopyWith<$Res> {
  __$$SprayUpdatedImplCopyWithImpl(
    _$SprayUpdatedImpl _value,
    $Res Function(_$SprayUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? spray = null}) {
    return _then(
      _$SprayUpdatedImpl(
        null == spray
            ? _value.spray
            : spray // ignore: cast_nullable_to_non_nullable
                  as TokenSpray,
      ),
    );
  }

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenSprayCopyWith<$Res> get spray {
    return $TokenSprayCopyWith<$Res>(_value.spray, (value) {
      return _then(_value.copyWith(spray: value));
    });
  }
}

/// @nodoc

class _$SprayUpdatedImpl implements _SprayUpdated {
  const _$SprayUpdatedImpl(this.spray);

  @override
  final TokenSpray spray;

  @override
  String toString() {
    return 'TokenSprayEvent.sprayUpdated(spray: $spray)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SprayUpdatedImpl &&
            (identical(other.spray, spray) || other.spray == spray));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spray);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SprayUpdatedImplCopyWith<_$SprayUpdatedImpl> get copyWith =>
      __$$SprayUpdatedImplCopyWithImpl<_$SprayUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )
    createSpray,
    required TResult Function(String sprayId, int amount, String? message)
    contribute,
    required TResult Function(String sprayId) closeSpray,
    required TResult Function(String sprayId) claimSpray,
    required TResult Function(String sprayId) watchSpray,
    required TResult Function(TokenSpray spray) sprayUpdated,
    required TResult Function() loadHistory,
    required TResult Function() clearError,
  }) {
    return sprayUpdated(spray);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult? Function(String sprayId, int amount, String? message)? contribute,
    TResult? Function(String sprayId)? closeSpray,
    TResult? Function(String sprayId)? claimSpray,
    TResult? Function(String sprayId)? watchSpray,
    TResult? Function(TokenSpray spray)? sprayUpdated,
    TResult? Function()? loadHistory,
    TResult? Function()? clearError,
  }) {
    return sprayUpdated?.call(spray);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult Function(String sprayId, int amount, String? message)? contribute,
    TResult Function(String sprayId)? closeSpray,
    TResult Function(String sprayId)? claimSpray,
    TResult Function(String sprayId)? watchSpray,
    TResult Function(TokenSpray spray)? sprayUpdated,
    TResult Function()? loadHistory,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (sprayUpdated != null) {
      return sprayUpdated(spray);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateSpray value) createSpray,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_CloseSpray value) closeSpray,
    required TResult Function(_ClaimSpray value) claimSpray,
    required TResult Function(_WatchSpray value) watchSpray,
    required TResult Function(_SprayUpdated value) sprayUpdated,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_ClearError value) clearError,
  }) {
    return sprayUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateSpray value)? createSpray,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_CloseSpray value)? closeSpray,
    TResult? Function(_ClaimSpray value)? claimSpray,
    TResult? Function(_WatchSpray value)? watchSpray,
    TResult? Function(_SprayUpdated value)? sprayUpdated,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return sprayUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateSpray value)? createSpray,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_CloseSpray value)? closeSpray,
    TResult Function(_ClaimSpray value)? claimSpray,
    TResult Function(_WatchSpray value)? watchSpray,
    TResult Function(_SprayUpdated value)? sprayUpdated,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (sprayUpdated != null) {
      return sprayUpdated(this);
    }
    return orElse();
  }
}

abstract class _SprayUpdated implements TokenSprayEvent {
  const factory _SprayUpdated(final TokenSpray spray) = _$SprayUpdatedImpl;

  TokenSpray get spray;

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SprayUpdatedImplCopyWith<_$SprayUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadHistoryImplCopyWith<$Res> {
  factory _$$LoadHistoryImplCopyWith(
    _$LoadHistoryImpl value,
    $Res Function(_$LoadHistoryImpl) then,
  ) = __$$LoadHistoryImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadHistoryImplCopyWithImpl<$Res>
    extends _$TokenSprayEventCopyWithImpl<$Res, _$LoadHistoryImpl>
    implements _$$LoadHistoryImplCopyWith<$Res> {
  __$$LoadHistoryImplCopyWithImpl(
    _$LoadHistoryImpl _value,
    $Res Function(_$LoadHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadHistoryImpl implements _LoadHistory {
  const _$LoadHistoryImpl();

  @override
  String toString() {
    return 'TokenSprayEvent.loadHistory()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadHistoryImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )
    createSpray,
    required TResult Function(String sprayId, int amount, String? message)
    contribute,
    required TResult Function(String sprayId) closeSpray,
    required TResult Function(String sprayId) claimSpray,
    required TResult Function(String sprayId) watchSpray,
    required TResult Function(TokenSpray spray) sprayUpdated,
    required TResult Function() loadHistory,
    required TResult Function() clearError,
  }) {
    return loadHistory();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult? Function(String sprayId, int amount, String? message)? contribute,
    TResult? Function(String sprayId)? closeSpray,
    TResult? Function(String sprayId)? claimSpray,
    TResult? Function(String sprayId)? watchSpray,
    TResult? Function(TokenSpray spray)? sprayUpdated,
    TResult? Function()? loadHistory,
    TResult? Function()? clearError,
  }) {
    return loadHistory?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult Function(String sprayId, int amount, String? message)? contribute,
    TResult Function(String sprayId)? closeSpray,
    TResult Function(String sprayId)? claimSpray,
    TResult Function(String sprayId)? watchSpray,
    TResult Function(TokenSpray spray)? sprayUpdated,
    TResult Function()? loadHistory,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (loadHistory != null) {
      return loadHistory();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateSpray value) createSpray,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_CloseSpray value) closeSpray,
    required TResult Function(_ClaimSpray value) claimSpray,
    required TResult Function(_WatchSpray value) watchSpray,
    required TResult Function(_SprayUpdated value) sprayUpdated,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_ClearError value) clearError,
  }) {
    return loadHistory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateSpray value)? createSpray,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_CloseSpray value)? closeSpray,
    TResult? Function(_ClaimSpray value)? claimSpray,
    TResult? Function(_WatchSpray value)? watchSpray,
    TResult? Function(_SprayUpdated value)? sprayUpdated,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return loadHistory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateSpray value)? createSpray,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_CloseSpray value)? closeSpray,
    TResult Function(_ClaimSpray value)? claimSpray,
    TResult Function(_WatchSpray value)? watchSpray,
    TResult Function(_SprayUpdated value)? sprayUpdated,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (loadHistory != null) {
      return loadHistory(this);
    }
    return orElse();
  }
}

abstract class _LoadHistory implements TokenSprayEvent {
  const factory _LoadHistory() = _$LoadHistoryImpl;
}

/// @nodoc
abstract class _$$ClearErrorImplCopyWith<$Res> {
  factory _$$ClearErrorImplCopyWith(
    _$ClearErrorImpl value,
    $Res Function(_$ClearErrorImpl) then,
  ) = __$$ClearErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearErrorImplCopyWithImpl<$Res>
    extends _$TokenSprayEventCopyWithImpl<$Res, _$ClearErrorImpl>
    implements _$$ClearErrorImplCopyWith<$Res> {
  __$$ClearErrorImplCopyWithImpl(
    _$ClearErrorImpl _value,
    $Res Function(_$ClearErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearErrorImpl implements _ClearError {
  const _$ClearErrorImpl();

  @override
  String toString() {
    return 'TokenSprayEvent.clearError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )
    createSpray,
    required TResult Function(String sprayId, int amount, String? message)
    contribute,
    required TResult Function(String sprayId) closeSpray,
    required TResult Function(String sprayId) claimSpray,
    required TResult Function(String sprayId) watchSpray,
    required TResult Function(TokenSpray spray) sprayUpdated,
    required TResult Function() loadHistory,
    required TResult Function() clearError,
  }) {
    return clearError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult? Function(String sprayId, int amount, String? message)? contribute,
    TResult? Function(String sprayId)? closeSpray,
    TResult? Function(String sprayId)? claimSpray,
    TResult? Function(String sprayId)? watchSpray,
    TResult? Function(TokenSpray spray)? sprayUpdated,
    TResult? Function()? loadHistory,
    TResult? Function()? clearError,
  }) {
    return clearError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String recipientId,
      SprayOccasion occasion,
      String message,
      int? targetAmount,
    )?
    createSpray,
    TResult Function(String sprayId, int amount, String? message)? contribute,
    TResult Function(String sprayId)? closeSpray,
    TResult Function(String sprayId)? claimSpray,
    TResult Function(String sprayId)? watchSpray,
    TResult Function(TokenSpray spray)? sprayUpdated,
    TResult Function()? loadHistory,
    TResult Function()? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreateSpray value) createSpray,
    required TResult Function(_Contribute value) contribute,
    required TResult Function(_CloseSpray value) closeSpray,
    required TResult Function(_ClaimSpray value) claimSpray,
    required TResult Function(_WatchSpray value) watchSpray,
    required TResult Function(_SprayUpdated value) sprayUpdated,
    required TResult Function(_LoadHistory value) loadHistory,
    required TResult Function(_ClearError value) clearError,
  }) {
    return clearError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreateSpray value)? createSpray,
    TResult? Function(_Contribute value)? contribute,
    TResult? Function(_CloseSpray value)? closeSpray,
    TResult? Function(_ClaimSpray value)? claimSpray,
    TResult? Function(_WatchSpray value)? watchSpray,
    TResult? Function(_SprayUpdated value)? sprayUpdated,
    TResult? Function(_LoadHistory value)? loadHistory,
    TResult? Function(_ClearError value)? clearError,
  }) {
    return clearError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreateSpray value)? createSpray,
    TResult Function(_Contribute value)? contribute,
    TResult Function(_CloseSpray value)? closeSpray,
    TResult Function(_ClaimSpray value)? claimSpray,
    TResult Function(_WatchSpray value)? watchSpray,
    TResult Function(_SprayUpdated value)? sprayUpdated,
    TResult Function(_LoadHistory value)? loadHistory,
    TResult Function(_ClearError value)? clearError,
    required TResult orElse(),
  }) {
    if (clearError != null) {
      return clearError(this);
    }
    return orElse();
  }
}

abstract class _ClearError implements TokenSprayEvent {
  const factory _ClearError() = _$ClearErrorImpl;
}

/// @nodoc
mixin _$TokenSprayState {
  String get communityId => throw _privateConstructorUsedError;
  TokenSpray? get activeSpray => throw _privateConstructorUsedError;
  List<TokenSpray> get history => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isContributing => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of TokenSprayState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenSprayStateCopyWith<TokenSprayState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenSprayStateCopyWith<$Res> {
  factory $TokenSprayStateCopyWith(
    TokenSprayState value,
    $Res Function(TokenSprayState) then,
  ) = _$TokenSprayStateCopyWithImpl<$Res, TokenSprayState>;
  @useResult
  $Res call({
    String communityId,
    TokenSpray? activeSpray,
    List<TokenSpray> history,
    bool isLoading,
    bool isContributing,
    String? errorMessage,
  });

  $TokenSprayCopyWith<$Res>? get activeSpray;
}

/// @nodoc
class _$TokenSprayStateCopyWithImpl<$Res, $Val extends TokenSprayState>
    implements $TokenSprayStateCopyWith<$Res> {
  _$TokenSprayStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenSprayState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = null,
    Object? activeSpray = freezed,
    Object? history = null,
    Object? isLoading = null,
    Object? isContributing = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            communityId: null == communityId
                ? _value.communityId
                : communityId // ignore: cast_nullable_to_non_nullable
                      as String,
            activeSpray: freezed == activeSpray
                ? _value.activeSpray
                : activeSpray // ignore: cast_nullable_to_non_nullable
                      as TokenSpray?,
            history: null == history
                ? _value.history
                : history // ignore: cast_nullable_to_non_nullable
                      as List<TokenSpray>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isContributing: null == isContributing
                ? _value.isContributing
                : isContributing // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of TokenSprayState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenSprayCopyWith<$Res>? get activeSpray {
    if (_value.activeSpray == null) {
      return null;
    }

    return $TokenSprayCopyWith<$Res>(_value.activeSpray!, (value) {
      return _then(_value.copyWith(activeSpray: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokenSprayStateImplCopyWith<$Res>
    implements $TokenSprayStateCopyWith<$Res> {
  factory _$$TokenSprayStateImplCopyWith(
    _$TokenSprayStateImpl value,
    $Res Function(_$TokenSprayStateImpl) then,
  ) = __$$TokenSprayStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String communityId,
    TokenSpray? activeSpray,
    List<TokenSpray> history,
    bool isLoading,
    bool isContributing,
    String? errorMessage,
  });

  @override
  $TokenSprayCopyWith<$Res>? get activeSpray;
}

/// @nodoc
class __$$TokenSprayStateImplCopyWithImpl<$Res>
    extends _$TokenSprayStateCopyWithImpl<$Res, _$TokenSprayStateImpl>
    implements _$$TokenSprayStateImplCopyWith<$Res> {
  __$$TokenSprayStateImplCopyWithImpl(
    _$TokenSprayStateImpl _value,
    $Res Function(_$TokenSprayStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenSprayState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? communityId = null,
    Object? activeSpray = freezed,
    Object? history = null,
    Object? isLoading = null,
    Object? isContributing = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$TokenSprayStateImpl(
        communityId: null == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String,
        activeSpray: freezed == activeSpray
            ? _value.activeSpray
            : activeSpray // ignore: cast_nullable_to_non_nullable
                  as TokenSpray?,
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<TokenSpray>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isContributing: null == isContributing
            ? _value.isContributing
            : isContributing // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TokenSprayStateImpl implements _TokenSprayState {
  const _$TokenSprayStateImpl({
    required this.communityId,
    this.activeSpray,
    final List<TokenSpray> history = const [],
    this.isLoading = false,
    this.isContributing = false,
    this.errorMessage,
  }) : _history = history;

  @override
  final String communityId;
  @override
  final TokenSpray? activeSpray;
  final List<TokenSpray> _history;
  @override
  @JsonKey()
  List<TokenSpray> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isContributing;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'TokenSprayState(communityId: $communityId, activeSpray: $activeSpray, history: $history, isLoading: $isLoading, isContributing: $isContributing, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenSprayStateImpl &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.activeSpray, activeSpray) ||
                other.activeSpray == activeSpray) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isContributing, isContributing) ||
                other.isContributing == isContributing) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    communityId,
    activeSpray,
    const DeepCollectionEquality().hash(_history),
    isLoading,
    isContributing,
    errorMessage,
  );

  /// Create a copy of TokenSprayState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenSprayStateImplCopyWith<_$TokenSprayStateImpl> get copyWith =>
      __$$TokenSprayStateImplCopyWithImpl<_$TokenSprayStateImpl>(
        this,
        _$identity,
      );
}

abstract class _TokenSprayState implements TokenSprayState {
  const factory _TokenSprayState({
    required final String communityId,
    final TokenSpray? activeSpray,
    final List<TokenSpray> history,
    final bool isLoading,
    final bool isContributing,
    final String? errorMessage,
  }) = _$TokenSprayStateImpl;

  @override
  String get communityId;
  @override
  TokenSpray? get activeSpray;
  @override
  List<TokenSpray> get history;
  @override
  bool get isLoading;
  @override
  bool get isContributing;
  @override
  String? get errorMessage;

  /// Create a copy of TokenSprayState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenSprayStateImplCopyWith<_$TokenSprayStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
