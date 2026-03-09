// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_flag_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FeatureFlagModel {
  String get id => throw _privateConstructorUsedError;
  String get featureKey => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;
  bool get isGlobal => throw _privateConstructorUsedError;
  List<String> get enabledCommunityIds => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of FeatureFlagModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeatureFlagModelCopyWith<FeatureFlagModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureFlagModelCopyWith<$Res> {
  factory $FeatureFlagModelCopyWith(
    FeatureFlagModel value,
    $Res Function(FeatureFlagModel) then,
  ) = _$FeatureFlagModelCopyWithImpl<$Res, FeatureFlagModel>;
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
class _$FeatureFlagModelCopyWithImpl<$Res, $Val extends FeatureFlagModel>
    implements $FeatureFlagModelCopyWith<$Res> {
  _$FeatureFlagModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeatureFlagModel
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
abstract class _$$FeatureFlagModelImplCopyWith<$Res>
    implements $FeatureFlagModelCopyWith<$Res> {
  factory _$$FeatureFlagModelImplCopyWith(
    _$FeatureFlagModelImpl value,
    $Res Function(_$FeatureFlagModelImpl) then,
  ) = __$$FeatureFlagModelImplCopyWithImpl<$Res>;
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
class __$$FeatureFlagModelImplCopyWithImpl<$Res>
    extends _$FeatureFlagModelCopyWithImpl<$Res, _$FeatureFlagModelImpl>
    implements _$$FeatureFlagModelImplCopyWith<$Res> {
  __$$FeatureFlagModelImplCopyWithImpl(
    _$FeatureFlagModelImpl _value,
    $Res Function(_$FeatureFlagModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeatureFlagModel
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
      _$FeatureFlagModelImpl(
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

class _$FeatureFlagModelImpl extends _FeatureFlagModel {
  const _$FeatureFlagModelImpl({
    required this.id,
    required this.featureKey,
    required this.isEnabled,
    required this.isGlobal,
    final List<String> enabledCommunityIds = const [],
    this.updatedAt,
  }) : _enabledCommunityIds = enabledCommunityIds,
       super._();

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
    return 'FeatureFlagModel(id: $id, featureKey: $featureKey, isEnabled: $isEnabled, isGlobal: $isGlobal, enabledCommunityIds: $enabledCommunityIds, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeatureFlagModelImpl &&
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

  /// Create a copy of FeatureFlagModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeatureFlagModelImplCopyWith<_$FeatureFlagModelImpl> get copyWith =>
      __$$FeatureFlagModelImplCopyWithImpl<_$FeatureFlagModelImpl>(
        this,
        _$identity,
      );
}

abstract class _FeatureFlagModel extends FeatureFlagModel {
  const factory _FeatureFlagModel({
    required final String id,
    required final String featureKey,
    required final bool isEnabled,
    required final bool isGlobal,
    final List<String> enabledCommunityIds,
    final DateTime? updatedAt,
  }) = _$FeatureFlagModelImpl;
  const _FeatureFlagModel._() : super._();

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

  /// Create a copy of FeatureFlagModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeatureFlagModelImplCopyWith<_$FeatureFlagModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
