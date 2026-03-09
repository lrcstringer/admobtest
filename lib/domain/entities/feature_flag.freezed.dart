// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_flag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FeatureFlag _$FeatureFlagFromJson(Map<String, dynamic> json) {
  return _FeatureFlag.fromJson(json);
}

/// @nodoc
mixin _$FeatureFlag {
  String get id => throw _privateConstructorUsedError;
  String get featureKey => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;
  bool get isGlobal => throw _privateConstructorUsedError;
  List<String> get enabledCommunityIds => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this FeatureFlag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeatureFlag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeatureFlagCopyWith<FeatureFlag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureFlagCopyWith<$Res> {
  factory $FeatureFlagCopyWith(
    FeatureFlag value,
    $Res Function(FeatureFlag) then,
  ) = _$FeatureFlagCopyWithImpl<$Res, FeatureFlag>;
  @useResult
  $Res call({
    String id,
    String featureKey,
    bool isEnabled,
    bool isGlobal,
    List<String> enabledCommunityIds,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$FeatureFlagCopyWithImpl<$Res, $Val extends FeatureFlag>
    implements $FeatureFlagCopyWith<$Res> {
  _$FeatureFlagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeatureFlag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? featureKey = null,
    Object? isEnabled = null,
    Object? isGlobal = null,
    Object? enabledCommunityIds = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            featureKey: null == featureKey
                ? _value.featureKey
                : featureKey // ignore: cast_nullable_to_non_nullable
                      as String,
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isGlobal: null == isGlobal
                ? _value.isGlobal
                : isGlobal // ignore: cast_nullable_to_non_nullable
                      as bool,
            enabledCommunityIds: null == enabledCommunityIds
                ? _value.enabledCommunityIds
                : enabledCommunityIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeatureFlagImplCopyWith<$Res>
    implements $FeatureFlagCopyWith<$Res> {
  factory _$$FeatureFlagImplCopyWith(
    _$FeatureFlagImpl value,
    $Res Function(_$FeatureFlagImpl) then,
  ) = __$$FeatureFlagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String featureKey,
    bool isEnabled,
    bool isGlobal,
    List<String> enabledCommunityIds,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$FeatureFlagImplCopyWithImpl<$Res>
    extends _$FeatureFlagCopyWithImpl<$Res, _$FeatureFlagImpl>
    implements _$$FeatureFlagImplCopyWith<$Res> {
  __$$FeatureFlagImplCopyWithImpl(
    _$FeatureFlagImpl _value,
    $Res Function(_$FeatureFlagImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeatureFlag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? featureKey = null,
    Object? isEnabled = null,
    Object? isGlobal = null,
    Object? enabledCommunityIds = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$FeatureFlagImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        featureKey: null == featureKey
            ? _value.featureKey
            : featureKey // ignore: cast_nullable_to_non_nullable
                  as String,
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isGlobal: null == isGlobal
            ? _value.isGlobal
            : isGlobal // ignore: cast_nullable_to_non_nullable
                  as bool,
        enabledCommunityIds: null == enabledCommunityIds
            ? _value._enabledCommunityIds
            : enabledCommunityIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeatureFlagImpl extends _FeatureFlag {
  const _$FeatureFlagImpl({
    required this.id,
    required this.featureKey,
    required this.isEnabled,
    required this.isGlobal,
    final List<String> enabledCommunityIds = const [],
    this.updatedAt,
  }) : _enabledCommunityIds = enabledCommunityIds,
       super._();

  factory _$FeatureFlagImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeatureFlagImplFromJson(json);

  @override
  final String id;
  @override
  final String featureKey;
  @override
  final bool isEnabled;
  @override
  final bool isGlobal;
  final List<String> _enabledCommunityIds;
  @override
  @JsonKey()
  List<String> get enabledCommunityIds {
    if (_enabledCommunityIds is EqualUnmodifiableListView)
      return _enabledCommunityIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enabledCommunityIds);
  }

  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'FeatureFlag(id: $id, featureKey: $featureKey, isEnabled: $isEnabled, isGlobal: $isGlobal, enabledCommunityIds: $enabledCommunityIds, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeatureFlagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.featureKey, featureKey) ||
                other.featureKey == featureKey) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.isGlobal, isGlobal) ||
                other.isGlobal == isGlobal) &&
            const DeepCollectionEquality().equals(
              other._enabledCommunityIds,
              _enabledCommunityIds,
            ) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    featureKey,
    isEnabled,
    isGlobal,
    const DeepCollectionEquality().hash(_enabledCommunityIds),
    updatedAt,
  );

  /// Create a copy of FeatureFlag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeatureFlagImplCopyWith<_$FeatureFlagImpl> get copyWith =>
      __$$FeatureFlagImplCopyWithImpl<_$FeatureFlagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeatureFlagImplToJson(this);
  }
}

abstract class _FeatureFlag extends FeatureFlag {
  const factory _FeatureFlag({
    required final String id,
    required final String featureKey,
    required final bool isEnabled,
    required final bool isGlobal,
    final List<String> enabledCommunityIds,
    final DateTime? updatedAt,
  }) = _$FeatureFlagImpl;
  const _FeatureFlag._() : super._();

  factory _FeatureFlag.fromJson(Map<String, dynamic> json) =
      _$FeatureFlagImpl.fromJson;

  @override
  String get id;
  @override
  String get featureKey;
  @override
  bool get isEnabled;
  @override
  bool get isGlobal;
  @override
  List<String> get enabledCommunityIds;
  @override
  DateTime? get updatedAt;

  /// Create a copy of FeatureFlag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeatureFlagImplCopyWith<_$FeatureFlagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
