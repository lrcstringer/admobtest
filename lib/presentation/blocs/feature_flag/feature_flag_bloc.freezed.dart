// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_flag_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FeatureFlagEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeatureFlags,
    required TResult Function(String featureKey, String? communityId)
    checkFeature,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeatureFlags,
    TResult? Function(String featureKey, String? communityId)? checkFeature,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeatureFlags,
    TResult Function(String featureKey, String? communityId)? checkFeature,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeatureFlags value) loadFeatureFlags,
    required TResult Function(_CheckFeature value) checkFeature,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeatureFlags value)? loadFeatureFlags,
    TResult? Function(_CheckFeature value)? checkFeature,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeatureFlags value)? loadFeatureFlags,
    TResult Function(_CheckFeature value)? checkFeature,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureFlagEventCopyWith<$Res> {
  factory $FeatureFlagEventCopyWith(
    FeatureFlagEvent value,
    $Res Function(FeatureFlagEvent) then,
  ) = _$FeatureFlagEventCopyWithImpl<$Res, FeatureFlagEvent>;
}

/// @nodoc
class _$FeatureFlagEventCopyWithImpl<$Res, $Val extends FeatureFlagEvent>
    implements $FeatureFlagEventCopyWith<$Res> {
  _$FeatureFlagEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeatureFlagEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadFeatureFlagsImplCopyWith<$Res> {
  factory _$$LoadFeatureFlagsImplCopyWith(
    _$LoadFeatureFlagsImpl value,
    $Res Function(_$LoadFeatureFlagsImpl) then,
  ) = __$$LoadFeatureFlagsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadFeatureFlagsImplCopyWithImpl<$Res>
    extends _$FeatureFlagEventCopyWithImpl<$Res, _$LoadFeatureFlagsImpl>
    implements _$$LoadFeatureFlagsImplCopyWith<$Res> {
  __$$LoadFeatureFlagsImplCopyWithImpl(
    _$LoadFeatureFlagsImpl _value,
    $Res Function(_$LoadFeatureFlagsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeatureFlagEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadFeatureFlagsImpl implements _LoadFeatureFlags {
  const _$LoadFeatureFlagsImpl();

  @override
  String toString() {
    return 'FeatureFlagEvent.loadFeatureFlags()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadFeatureFlagsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeatureFlags,
    required TResult Function(String featureKey, String? communityId)
    checkFeature,
  }) {
    return loadFeatureFlags();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeatureFlags,
    TResult? Function(String featureKey, String? communityId)? checkFeature,
  }) {
    return loadFeatureFlags?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeatureFlags,
    TResult Function(String featureKey, String? communityId)? checkFeature,
    required TResult orElse(),
  }) {
    if (loadFeatureFlags != null) {
      return loadFeatureFlags();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeatureFlags value) loadFeatureFlags,
    required TResult Function(_CheckFeature value) checkFeature,
  }) {
    return loadFeatureFlags(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeatureFlags value)? loadFeatureFlags,
    TResult? Function(_CheckFeature value)? checkFeature,
  }) {
    return loadFeatureFlags?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeatureFlags value)? loadFeatureFlags,
    TResult Function(_CheckFeature value)? checkFeature,
    required TResult orElse(),
  }) {
    if (loadFeatureFlags != null) {
      return loadFeatureFlags(this);
    }
    return orElse();
  }
}

abstract class _LoadFeatureFlags implements FeatureFlagEvent {
  const factory _LoadFeatureFlags() = _$LoadFeatureFlagsImpl;
}

/// @nodoc
abstract class _$$CheckFeatureImplCopyWith<$Res> {
  factory _$$CheckFeatureImplCopyWith(
    _$CheckFeatureImpl value,
    $Res Function(_$CheckFeatureImpl) then,
  ) = __$$CheckFeatureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String featureKey, String? communityId});
}

/// @nodoc
class __$$CheckFeatureImplCopyWithImpl<$Res>
    extends _$FeatureFlagEventCopyWithImpl<$Res, _$CheckFeatureImpl>
    implements _$$CheckFeatureImplCopyWith<$Res> {
  __$$CheckFeatureImplCopyWithImpl(
    _$CheckFeatureImpl _value,
    $Res Function(_$CheckFeatureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeatureFlagEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? featureKey = null, Object? communityId = freezed}) {
    return _then(
      _$CheckFeatureImpl(
        featureKey: null == featureKey
            ? _value.featureKey
            : featureKey // ignore: cast_nullable_to_non_nullable
                  as String,
        communityId: freezed == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CheckFeatureImpl implements _CheckFeature {
  const _$CheckFeatureImpl({required this.featureKey, this.communityId});

  @override
  final String featureKey;
  @override
  final String? communityId;

  @override
  String toString() {
    return 'FeatureFlagEvent.checkFeature(featureKey: $featureKey, communityId: $communityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckFeatureImpl &&
            (identical(other.featureKey, featureKey) ||
                other.featureKey == featureKey) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, featureKey, communityId);

  /// Create a copy of FeatureFlagEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckFeatureImplCopyWith<_$CheckFeatureImpl> get copyWith =>
      __$$CheckFeatureImplCopyWithImpl<_$CheckFeatureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFeatureFlags,
    required TResult Function(String featureKey, String? communityId)
    checkFeature,
  }) {
    return checkFeature(featureKey, communityId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFeatureFlags,
    TResult? Function(String featureKey, String? communityId)? checkFeature,
  }) {
    return checkFeature?.call(featureKey, communityId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFeatureFlags,
    TResult Function(String featureKey, String? communityId)? checkFeature,
    required TResult orElse(),
  }) {
    if (checkFeature != null) {
      return checkFeature(featureKey, communityId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFeatureFlags value) loadFeatureFlags,
    required TResult Function(_CheckFeature value) checkFeature,
  }) {
    return checkFeature(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFeatureFlags value)? loadFeatureFlags,
    TResult? Function(_CheckFeature value)? checkFeature,
  }) {
    return checkFeature?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFeatureFlags value)? loadFeatureFlags,
    TResult Function(_CheckFeature value)? checkFeature,
    required TResult orElse(),
  }) {
    if (checkFeature != null) {
      return checkFeature(this);
    }
    return orElse();
  }
}

abstract class _CheckFeature implements FeatureFlagEvent {
  const factory _CheckFeature({
    required final String featureKey,
    final String? communityId,
  }) = _$CheckFeatureImpl;

  String get featureKey;
  String? get communityId;

  /// Create a copy of FeatureFlagEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckFeatureImplCopyWith<_$CheckFeatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FeatureFlagState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<FeatureFlag> get flags => throw _privateConstructorUsedError;
  Map<String, FeatureFlag> get flagMap => throw _privateConstructorUsedError;
  Map<String, bool> get featureChecks => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of FeatureFlagState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeatureFlagStateCopyWith<FeatureFlagState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureFlagStateCopyWith<$Res> {
  factory $FeatureFlagStateCopyWith(
    FeatureFlagState value,
    $Res Function(FeatureFlagState) then,
  ) = _$FeatureFlagStateCopyWithImpl<$Res, FeatureFlagState>;
  @useResult
  $Res call({
    bool isLoading,
    List<FeatureFlag> flags,
    Map<String, FeatureFlag> flagMap,
    Map<String, bool> featureChecks,
    String? errorMessage,
  });
}

/// @nodoc
class _$FeatureFlagStateCopyWithImpl<$Res, $Val extends FeatureFlagState>
    implements $FeatureFlagStateCopyWith<$Res> {
  _$FeatureFlagStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeatureFlagState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? flags = null,
    Object? flagMap = null,
    Object? featureChecks = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            flags: null == flags
                ? _value.flags
                : flags // ignore: cast_nullable_to_non_nullable
                      as List<FeatureFlag>,
            flagMap: null == flagMap
                ? _value.flagMap
                : flagMap // ignore: cast_nullable_to_non_nullable
                      as Map<String, FeatureFlag>,
            featureChecks: null == featureChecks
                ? _value.featureChecks
                : featureChecks // ignore: cast_nullable_to_non_nullable
                      as Map<String, bool>,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeatureFlagStateImplCopyWith<$Res>
    implements $FeatureFlagStateCopyWith<$Res> {
  factory _$$FeatureFlagStateImplCopyWith(
    _$FeatureFlagStateImpl value,
    $Res Function(_$FeatureFlagStateImpl) then,
  ) = __$$FeatureFlagStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    List<FeatureFlag> flags,
    Map<String, FeatureFlag> flagMap,
    Map<String, bool> featureChecks,
    String? errorMessage,
  });
}

/// @nodoc
class __$$FeatureFlagStateImplCopyWithImpl<$Res>
    extends _$FeatureFlagStateCopyWithImpl<$Res, _$FeatureFlagStateImpl>
    implements _$$FeatureFlagStateImplCopyWith<$Res> {
  __$$FeatureFlagStateImplCopyWithImpl(
    _$FeatureFlagStateImpl _value,
    $Res Function(_$FeatureFlagStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeatureFlagState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? flags = null,
    Object? flagMap = null,
    Object? featureChecks = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$FeatureFlagStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        flags: null == flags
            ? _value._flags
            : flags // ignore: cast_nullable_to_non_nullable
                  as List<FeatureFlag>,
        flagMap: null == flagMap
            ? _value._flagMap
            : flagMap // ignore: cast_nullable_to_non_nullable
                  as Map<String, FeatureFlag>,
        featureChecks: null == featureChecks
            ? _value._featureChecks
            : featureChecks // ignore: cast_nullable_to_non_nullable
                  as Map<String, bool>,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FeatureFlagStateImpl implements _FeatureFlagState {
  const _$FeatureFlagStateImpl({
    this.isLoading = false,
    final List<FeatureFlag> flags = const [],
    final Map<String, FeatureFlag> flagMap = const {},
    final Map<String, bool> featureChecks = const {},
    this.errorMessage,
  }) : _flags = flags,
       _flagMap = flagMap,
       _featureChecks = featureChecks;

  @override
  @JsonKey()
  final bool isLoading;
  final List<FeatureFlag> _flags;
  @override
  @JsonKey()
  List<FeatureFlag> get flags {
    if (_flags is EqualUnmodifiableListView) return _flags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_flags);
  }

  final Map<String, FeatureFlag> _flagMap;
  @override
  @JsonKey()
  Map<String, FeatureFlag> get flagMap {
    if (_flagMap is EqualUnmodifiableMapView) return _flagMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_flagMap);
  }

  final Map<String, bool> _featureChecks;
  @override
  @JsonKey()
  Map<String, bool> get featureChecks {
    if (_featureChecks is EqualUnmodifiableMapView) return _featureChecks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_featureChecks);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'FeatureFlagState(isLoading: $isLoading, flags: $flags, flagMap: $flagMap, featureChecks: $featureChecks, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeatureFlagStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._flags, _flags) &&
            const DeepCollectionEquality().equals(other._flagMap, _flagMap) &&
            const DeepCollectionEquality().equals(
              other._featureChecks,
              _featureChecks,
            ) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    const DeepCollectionEquality().hash(_flags),
    const DeepCollectionEquality().hash(_flagMap),
    const DeepCollectionEquality().hash(_featureChecks),
    errorMessage,
  );

  /// Create a copy of FeatureFlagState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeatureFlagStateImplCopyWith<_$FeatureFlagStateImpl> get copyWith =>
      __$$FeatureFlagStateImplCopyWithImpl<_$FeatureFlagStateImpl>(
        this,
        _$identity,
      );
}

abstract class _FeatureFlagState implements FeatureFlagState {
  const factory _FeatureFlagState({
    final bool isLoading,
    final List<FeatureFlag> flags,
    final Map<String, FeatureFlag> flagMap,
    final Map<String, bool> featureChecks,
    final String? errorMessage,
  }) = _$FeatureFlagStateImpl;

  @override
  bool get isLoading;
  @override
  List<FeatureFlag> get flags;
  @override
  Map<String, FeatureFlag> get flagMap;
  @override
  Map<String, bool> get featureChecks;
  @override
  String? get errorMessage;

  /// Create a copy of FeatureFlagState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeatureFlagStateImplCopyWith<_$FeatureFlagStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
