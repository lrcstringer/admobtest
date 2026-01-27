// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earn_thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EarnThread _$EarnThreadFromJson(Map<String, dynamic> json) {
  return _EarnThread.fromJson(json);
}

/// @nodoc
mixin _$EarnThread {
  String get id => throw _privateConstructorUsedError;
  String get brandId => throw _privateConstructorUsedError;
  String get brandName => throw _privateConstructorUsedError;
  String? get avatarColor => throw _privateConstructorUsedError;
  String? get avatarImage => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get availableOpportunities => throw _privateConstructorUsedError;
  int get completedOpportunities => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastActivityAt => throw _privateConstructorUsedError;

  /// Serializes this EarnThread to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarnThreadCopyWith<EarnThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarnThreadCopyWith<$Res> {
  factory $EarnThreadCopyWith(
    EarnThread value,
    $Res Function(EarnThread) then,
  ) = _$EarnThreadCopyWithImpl<$Res, EarnThread>;
  @useResult
  $Res call({
    String id,
    String brandId,
    String brandName,
    String? avatarColor,
    String? avatarImage,
    bool isPinned,
    bool isActive,
    int availableOpportunities,
    int completedOpportunities,
    DateTime createdAt,
    DateTime? lastActivityAt,
  });
}

/// @nodoc
class _$EarnThreadCopyWithImpl<$Res, $Val extends EarnThread>
    implements $EarnThreadCopyWith<$Res> {
  _$EarnThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brandId = null,
    Object? brandName = null,
    Object? avatarColor = freezed,
    Object? avatarImage = freezed,
    Object? isPinned = null,
    Object? isActive = null,
    Object? availableOpportunities = null,
    Object? completedOpportunities = null,
    Object? createdAt = null,
    Object? lastActivityAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            brandId: null == brandId
                ? _value.brandId
                : brandId // ignore: cast_nullable_to_non_nullable
                      as String,
            brandName: null == brandName
                ? _value.brandName
                : brandName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarColor: freezed == avatarColor
                ? _value.avatarColor
                : avatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarImage: freezed == avatarImage
                ? _value.avatarImage
                : avatarImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            availableOpportunities: null == availableOpportunities
                ? _value.availableOpportunities
                : availableOpportunities // ignore: cast_nullable_to_non_nullable
                      as int,
            completedOpportunities: null == completedOpportunities
                ? _value.completedOpportunities
                : completedOpportunities // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastActivityAt: freezed == lastActivityAt
                ? _value.lastActivityAt
                : lastActivityAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EarnThreadImplCopyWith<$Res>
    implements $EarnThreadCopyWith<$Res> {
  factory _$$EarnThreadImplCopyWith(
    _$EarnThreadImpl value,
    $Res Function(_$EarnThreadImpl) then,
  ) = __$$EarnThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String brandId,
    String brandName,
    String? avatarColor,
    String? avatarImage,
    bool isPinned,
    bool isActive,
    int availableOpportunities,
    int completedOpportunities,
    DateTime createdAt,
    DateTime? lastActivityAt,
  });
}

/// @nodoc
class __$$EarnThreadImplCopyWithImpl<$Res>
    extends _$EarnThreadCopyWithImpl<$Res, _$EarnThreadImpl>
    implements _$$EarnThreadImplCopyWith<$Res> {
  __$$EarnThreadImplCopyWithImpl(
    _$EarnThreadImpl _value,
    $Res Function(_$EarnThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brandId = null,
    Object? brandName = null,
    Object? avatarColor = freezed,
    Object? avatarImage = freezed,
    Object? isPinned = null,
    Object? isActive = null,
    Object? availableOpportunities = null,
    Object? completedOpportunities = null,
    Object? createdAt = null,
    Object? lastActivityAt = freezed,
  }) {
    return _then(
      _$EarnThreadImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        brandId: null == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String,
        brandName: null == brandName
            ? _value.brandName
            : brandName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarColor: freezed == avatarColor
            ? _value.avatarColor
            : avatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarImage: freezed == avatarImage
            ? _value.avatarImage
            : avatarImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        availableOpportunities: null == availableOpportunities
            ? _value.availableOpportunities
            : availableOpportunities // ignore: cast_nullable_to_non_nullable
                  as int,
        completedOpportunities: null == completedOpportunities
            ? _value.completedOpportunities
            : completedOpportunities // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastActivityAt: freezed == lastActivityAt
            ? _value.lastActivityAt
            : lastActivityAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EarnThreadImpl extends _EarnThread {
  const _$EarnThreadImpl({
    required this.id,
    required this.brandId,
    required this.brandName,
    this.avatarColor,
    this.avatarImage,
    required this.isPinned,
    required this.isActive,
    required this.availableOpportunities,
    required this.completedOpportunities,
    required this.createdAt,
    this.lastActivityAt,
  }) : super._();

  factory _$EarnThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarnThreadImplFromJson(json);

  @override
  final String id;
  @override
  final String brandId;
  @override
  final String brandName;
  @override
  final String? avatarColor;
  @override
  final String? avatarImage;
  @override
  final bool isPinned;
  @override
  final bool isActive;
  @override
  final int availableOpportunities;
  @override
  final int completedOpportunities;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastActivityAt;

  @override
  String toString() {
    return 'EarnThread(id: $id, brandId: $brandId, brandName: $brandName, avatarColor: $avatarColor, avatarImage: $avatarImage, isPinned: $isPinned, isActive: $isActive, availableOpportunities: $availableOpportunities, completedOpportunities: $completedOpportunities, createdAt: $createdAt, lastActivityAt: $lastActivityAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarnThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.avatarImage, avatarImage) ||
                other.avatarImage == avatarImage) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.availableOpportunities, availableOpportunities) ||
                other.availableOpportunities == availableOpportunities) &&
            (identical(other.completedOpportunities, completedOpportunities) ||
                other.completedOpportunities == completedOpportunities) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    brandId,
    brandName,
    avatarColor,
    avatarImage,
    isPinned,
    isActive,
    availableOpportunities,
    completedOpportunities,
    createdAt,
    lastActivityAt,
  );

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarnThreadImplCopyWith<_$EarnThreadImpl> get copyWith =>
      __$$EarnThreadImplCopyWithImpl<_$EarnThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarnThreadImplToJson(this);
  }
}

abstract class _EarnThread extends EarnThread {
  const factory _EarnThread({
    required final String id,
    required final String brandId,
    required final String brandName,
    final String? avatarColor,
    final String? avatarImage,
    required final bool isPinned,
    required final bool isActive,
    required final int availableOpportunities,
    required final int completedOpportunities,
    required final DateTime createdAt,
    final DateTime? lastActivityAt,
  }) = _$EarnThreadImpl;
  const _EarnThread._() : super._();

  factory _EarnThread.fromJson(Map<String, dynamic> json) =
      _$EarnThreadImpl.fromJson;

  @override
  String get id;
  @override
  String get brandId;
  @override
  String get brandName;
  @override
  String? get avatarColor;
  @override
  String? get avatarImage;
  @override
  bool get isPinned;
  @override
  bool get isActive;
  @override
  int get availableOpportunities;
  @override
  int get completedOpportunities;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastActivityAt;

  /// Create a copy of EarnThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarnThreadImplCopyWith<_$EarnThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
