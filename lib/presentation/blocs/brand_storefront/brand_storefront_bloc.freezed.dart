// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_storefront_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BrandStorefrontEvent {
  String get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) loadStorefront,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? loadStorefront,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? loadStorefront,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStorefront value) loadStorefront,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStorefront value)? loadStorefront,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStorefront value)? loadStorefront,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandStorefrontEventCopyWith<BrandStorefrontEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandStorefrontEventCopyWith<$Res> {
  factory $BrandStorefrontEventCopyWith(
    BrandStorefrontEvent value,
    $Res Function(BrandStorefrontEvent) then,
  ) = _$BrandStorefrontEventCopyWithImpl<$Res, BrandStorefrontEvent>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$BrandStorefrontEventCopyWithImpl<
  $Res,
  $Val extends BrandStorefrontEvent
>
    implements $BrandStorefrontEventCopyWith<$Res> {
  _$BrandStorefrontEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoadStorefrontImplCopyWith<$Res>
    implements $BrandStorefrontEventCopyWith<$Res> {
  factory _$$LoadStorefrontImplCopyWith(
    _$LoadStorefrontImpl value,
    $Res Function(_$LoadStorefrontImpl) then,
  ) = __$$LoadStorefrontImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$LoadStorefrontImplCopyWithImpl<$Res>
    extends _$BrandStorefrontEventCopyWithImpl<$Res, _$LoadStorefrontImpl>
    implements _$$LoadStorefrontImplCopyWith<$Res> {
  __$$LoadStorefrontImplCopyWithImpl(
    _$LoadStorefrontImpl _value,
    $Res Function(_$LoadStorefrontImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$LoadStorefrontImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadStorefrontImpl implements _LoadStorefront {
  const _$LoadStorefrontImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'BrandStorefrontEvent.loadStorefront(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadStorefrontImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadStorefrontImplCopyWith<_$LoadStorefrontImpl> get copyWith =>
      __$$LoadStorefrontImplCopyWithImpl<_$LoadStorefrontImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) loadStorefront,
  }) {
    return loadStorefront(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? loadStorefront,
  }) {
    return loadStorefront?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? loadStorefront,
    required TResult orElse(),
  }) {
    if (loadStorefront != null) {
      return loadStorefront(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStorefront value) loadStorefront,
  }) {
    return loadStorefront(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStorefront value)? loadStorefront,
  }) {
    return loadStorefront?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStorefront value)? loadStorefront,
    required TResult orElse(),
  }) {
    if (loadStorefront != null) {
      return loadStorefront(this);
    }
    return orElse();
  }
}

abstract class _LoadStorefront implements BrandStorefrontEvent {
  const factory _LoadStorefront(final String id) = _$LoadStorefrontImpl;

  @override
  String get id;

  /// Create a copy of BrandStorefrontEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadStorefrontImplCopyWith<_$LoadStorefrontImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BrandStorefrontState {
  bool get isLoading => throw _privateConstructorUsedError;
  BrandStorefront? get storefront => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandStorefrontStateCopyWith<BrandStorefrontState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandStorefrontStateCopyWith<$Res> {
  factory $BrandStorefrontStateCopyWith(
    BrandStorefrontState value,
    $Res Function(BrandStorefrontState) then,
  ) = _$BrandStorefrontStateCopyWithImpl<$Res, BrandStorefrontState>;
  @useResult
  $Res call({
    bool isLoading,
    BrandStorefront? storefront,
    String? errorMessage,
  });

  $BrandStorefrontCopyWith<$Res>? get storefront;
}

/// @nodoc
class _$BrandStorefrontStateCopyWithImpl<
  $Res,
  $Val extends BrandStorefrontState
>
    implements $BrandStorefrontStateCopyWith<$Res> {
  _$BrandStorefrontStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? storefront = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            storefront: freezed == storefront
                ? _value.storefront
                : storefront // ignore: cast_nullable_to_non_nullable
                      as BrandStorefront?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BrandStorefrontCopyWith<$Res>? get storefront {
    if (_value.storefront == null) {
      return null;
    }

    return $BrandStorefrontCopyWith<$Res>(_value.storefront!, (value) {
      return _then(_value.copyWith(storefront: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BrandStorefrontStateImplCopyWith<$Res>
    implements $BrandStorefrontStateCopyWith<$Res> {
  factory _$$BrandStorefrontStateImplCopyWith(
    _$BrandStorefrontStateImpl value,
    $Res Function(_$BrandStorefrontStateImpl) then,
  ) = __$$BrandStorefrontStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    BrandStorefront? storefront,
    String? errorMessage,
  });

  @override
  $BrandStorefrontCopyWith<$Res>? get storefront;
}

/// @nodoc
class __$$BrandStorefrontStateImplCopyWithImpl<$Res>
    extends _$BrandStorefrontStateCopyWithImpl<$Res, _$BrandStorefrontStateImpl>
    implements _$$BrandStorefrontStateImplCopyWith<$Res> {
  __$$BrandStorefrontStateImplCopyWithImpl(
    _$BrandStorefrontStateImpl _value,
    $Res Function(_$BrandStorefrontStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? storefront = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$BrandStorefrontStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        storefront: freezed == storefront
            ? _value.storefront
            : storefront // ignore: cast_nullable_to_non_nullable
                  as BrandStorefront?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$BrandStorefrontStateImpl implements _BrandStorefrontState {
  const _$BrandStorefrontStateImpl({
    this.isLoading = false,
    this.storefront,
    this.errorMessage,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final BrandStorefront? storefront;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'BrandStorefrontState(isLoading: $isLoading, storefront: $storefront, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandStorefrontStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.storefront, storefront) ||
                other.storefront == storefront) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, storefront, errorMessage);

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandStorefrontStateImplCopyWith<_$BrandStorefrontStateImpl>
  get copyWith =>
      __$$BrandStorefrontStateImplCopyWithImpl<_$BrandStorefrontStateImpl>(
        this,
        _$identity,
      );
}

abstract class _BrandStorefrontState implements BrandStorefrontState {
  const factory _BrandStorefrontState({
    final bool isLoading,
    final BrandStorefront? storefront,
    final String? errorMessage,
  }) = _$BrandStorefrontStateImpl;

  @override
  bool get isLoading;
  @override
  BrandStorefront? get storefront;
  @override
  String? get errorMessage;

  /// Create a copy of BrandStorefrontState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandStorefrontStateImplCopyWith<_$BrandStorefrontStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
