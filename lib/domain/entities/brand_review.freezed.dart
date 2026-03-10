// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BrandReview _$BrandReviewFromJson(Map<String, dynamic> json) {
  return _BrandReview.fromJson(json);
}

/// @nodoc
mixin _$BrandReview {
  String get id => throw _privateConstructorUsedError;
  String get brandId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;

  /// Purchase that qualifies this review (uniqueness key)
  String get orderId => throw _privateConstructorUsedError;

  /// 1-5 stars
  int get qualityRating => throw _privateConstructorUsedError;
  int get valueRating => throw _privateConstructorUsedError;
  int get serviceRating => throw _privateConstructorUsedError;

  /// Computed average of the three dimensions
  double get overallRating => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  /// Auto-filter flagged this (hidden from carousel)
  bool get isFiltered => throw _privateConstructorUsedError;

  /// Admin manually removed
  bool get isRemovedByAdmin => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this BrandReview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrandReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrandReviewCopyWith<BrandReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandReviewCopyWith<$Res> {
  factory $BrandReviewCopyWith(
    BrandReview value,
    $Res Function(BrandReview) then,
  ) = _$BrandReviewCopyWithImpl<$Res, BrandReview>;
  @useResult
  $Res call({
    String id,
    String brandId,
    String userId,
    String userName,
    String orderId,
    int qualityRating,
    int valueRating,
    int serviceRating,
    double overallRating,
    String? comment,
    bool isFiltered,
    bool isRemovedByAdmin,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$BrandReviewCopyWithImpl<$Res, $Val extends BrandReview>
    implements $BrandReviewCopyWith<$Res> {
  _$BrandReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrandReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brandId = null,
    Object? userId = null,
    Object? userName = null,
    Object? orderId = null,
    Object? qualityRating = null,
    Object? valueRating = null,
    Object? serviceRating = null,
    Object? overallRating = null,
    Object? comment = freezed,
    Object? isFiltered = null,
    Object? isRemovedByAdmin = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            orderId: null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String,
            qualityRating: null == qualityRating
                ? _value.qualityRating
                : qualityRating // ignore: cast_nullable_to_non_nullable
                      as int,
            valueRating: null == valueRating
                ? _value.valueRating
                : valueRating // ignore: cast_nullable_to_non_nullable
                      as int,
            serviceRating: null == serviceRating
                ? _value.serviceRating
                : serviceRating // ignore: cast_nullable_to_non_nullable
                      as int,
            overallRating: null == overallRating
                ? _value.overallRating
                : overallRating // ignore: cast_nullable_to_non_nullable
                      as double,
            comment: freezed == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String?,
            isFiltered: null == isFiltered
                ? _value.isFiltered
                : isFiltered // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRemovedByAdmin: null == isRemovedByAdmin
                ? _value.isRemovedByAdmin
                : isRemovedByAdmin // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$BrandReviewImplCopyWith<$Res>
    implements $BrandReviewCopyWith<$Res> {
  factory _$$BrandReviewImplCopyWith(
    _$BrandReviewImpl value,
    $Res Function(_$BrandReviewImpl) then,
  ) = __$$BrandReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String brandId,
    String userId,
    String userName,
    String orderId,
    int qualityRating,
    int valueRating,
    int serviceRating,
    double overallRating,
    String? comment,
    bool isFiltered,
    bool isRemovedByAdmin,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$BrandReviewImplCopyWithImpl<$Res>
    extends _$BrandReviewCopyWithImpl<$Res, _$BrandReviewImpl>
    implements _$$BrandReviewImplCopyWith<$Res> {
  __$$BrandReviewImplCopyWithImpl(
    _$BrandReviewImpl _value,
    $Res Function(_$BrandReviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrandReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brandId = null,
    Object? userId = null,
    Object? userName = null,
    Object? orderId = null,
    Object? qualityRating = null,
    Object? valueRating = null,
    Object? serviceRating = null,
    Object? overallRating = null,
    Object? comment = freezed,
    Object? isFiltered = null,
    Object? isRemovedByAdmin = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$BrandReviewImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        brandId: null == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        qualityRating: null == qualityRating
            ? _value.qualityRating
            : qualityRating // ignore: cast_nullable_to_non_nullable
                  as int,
        valueRating: null == valueRating
            ? _value.valueRating
            : valueRating // ignore: cast_nullable_to_non_nullable
                  as int,
        serviceRating: null == serviceRating
            ? _value.serviceRating
            : serviceRating // ignore: cast_nullable_to_non_nullable
                  as int,
        overallRating: null == overallRating
            ? _value.overallRating
            : overallRating // ignore: cast_nullable_to_non_nullable
                  as double,
        comment: freezed == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String?,
        isFiltered: null == isFiltered
            ? _value.isFiltered
            : isFiltered // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRemovedByAdmin: null == isRemovedByAdmin
            ? _value.isRemovedByAdmin
            : isRemovedByAdmin // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$BrandReviewImpl extends _BrandReview {
  const _$BrandReviewImpl({
    required this.id,
    required this.brandId,
    required this.userId,
    required this.userName,
    required this.orderId,
    required this.qualityRating,
    required this.valueRating,
    required this.serviceRating,
    required this.overallRating,
    this.comment,
    this.isFiltered = false,
    this.isRemovedByAdmin = false,
    required this.createdAt,
    this.updatedAt,
  }) : super._();

  factory _$BrandReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrandReviewImplFromJson(json);

  @override
  final String id;
  @override
  final String brandId;
  @override
  final String userId;
  @override
  final String userName;

  /// Purchase that qualifies this review (uniqueness key)
  @override
  final String orderId;

  /// 1-5 stars
  @override
  final int qualityRating;
  @override
  final int valueRating;
  @override
  final int serviceRating;

  /// Computed average of the three dimensions
  @override
  final double overallRating;
  @override
  final String? comment;

  /// Auto-filter flagged this (hidden from carousel)
  @override
  @JsonKey()
  final bool isFiltered;

  /// Admin manually removed
  @override
  @JsonKey()
  final bool isRemovedByAdmin;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'BrandReview(id: $id, brandId: $brandId, userId: $userId, userName: $userName, orderId: $orderId, qualityRating: $qualityRating, valueRating: $valueRating, serviceRating: $serviceRating, overallRating: $overallRating, comment: $comment, isFiltered: $isFiltered, isRemovedByAdmin: $isRemovedByAdmin, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandReviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.qualityRating, qualityRating) ||
                other.qualityRating == qualityRating) &&
            (identical(other.valueRating, valueRating) ||
                other.valueRating == valueRating) &&
            (identical(other.serviceRating, serviceRating) ||
                other.serviceRating == serviceRating) &&
            (identical(other.overallRating, overallRating) ||
                other.overallRating == overallRating) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.isFiltered, isFiltered) ||
                other.isFiltered == isFiltered) &&
            (identical(other.isRemovedByAdmin, isRemovedByAdmin) ||
                other.isRemovedByAdmin == isRemovedByAdmin) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    brandId,
    userId,
    userName,
    orderId,
    qualityRating,
    valueRating,
    serviceRating,
    overallRating,
    comment,
    isFiltered,
    isRemovedByAdmin,
    createdAt,
    updatedAt,
  );

  /// Create a copy of BrandReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandReviewImplCopyWith<_$BrandReviewImpl> get copyWith =>
      __$$BrandReviewImplCopyWithImpl<_$BrandReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrandReviewImplToJson(this);
  }
}

abstract class _BrandReview extends BrandReview {
  const factory _BrandReview({
    required final String id,
    required final String brandId,
    required final String userId,
    required final String userName,
    required final String orderId,
    required final int qualityRating,
    required final int valueRating,
    required final int serviceRating,
    required final double overallRating,
    final String? comment,
    final bool isFiltered,
    final bool isRemovedByAdmin,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$BrandReviewImpl;
  const _BrandReview._() : super._();

  factory _BrandReview.fromJson(Map<String, dynamic> json) =
      _$BrandReviewImpl.fromJson;

  @override
  String get id;
  @override
  String get brandId;
  @override
  String get userId;
  @override
  String get userName;

  /// Purchase that qualifies this review (uniqueness key)
  @override
  String get orderId;

  /// 1-5 stars
  @override
  int get qualityRating;
  @override
  int get valueRating;
  @override
  int get serviceRating;

  /// Computed average of the three dimensions
  @override
  double get overallRating;
  @override
  String? get comment;

  /// Auto-filter flagged this (hidden from carousel)
  @override
  bool get isFiltered;

  /// Admin manually removed
  @override
  bool get isRemovedByAdmin;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of BrandReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrandReviewImplCopyWith<_$BrandReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
