// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MarketplaceListing _$MarketplaceListingFromJson(Map<String, dynamic> json) {
  return _MarketplaceListing.fromJson(json);
}

/// @nodoc
mixin _$MarketplaceListing {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  MarketplaceCategory get category => throw _privateConstructorUsedError;
  String? get subCategory => throw _privateConstructorUsedError;
  int get priceTokens => throw _privateConstructorUsedError;
  double get priceZar => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String get providerId => throw _privateConstructorUsedError;
  String get providerName => throw _privateConstructorUsedError;
  String? get providerPhotoUrl => throw _privateConstructorUsedError;
  double? get providerTrustScore => throw _privateConstructorUsedError;
  bool? get providerIsVerified => throw _privateConstructorUsedError;
  String? get communityId => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  ListingStatus get status => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get reportCount => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MarketplaceListing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarketplaceListing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketplaceListingCopyWith<MarketplaceListing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketplaceListingCopyWith<$Res> {
  factory $MarketplaceListingCopyWith(
    MarketplaceListing value,
    $Res Function(MarketplaceListing) then,
  ) = _$MarketplaceListingCopyWithImpl<$Res, MarketplaceListing>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    MarketplaceCategory category,
    String? subCategory,
    int priceTokens,
    double priceZar,
    List<String> images,
    String? thumbnailUrl,
    String providerId,
    String providerName,
    String? providerPhotoUrl,
    double? providerTrustScore,
    bool? providerIsVerified,
    String? communityId,
    String? location,
    ListingStatus status,
    int viewCount,
    int reportCount,
    DateTime? expiresAt,
    DateTime createdAt,
  });
}

/// @nodoc
class _$MarketplaceListingCopyWithImpl<$Res, $Val extends MarketplaceListing>
    implements $MarketplaceListingCopyWith<$Res> {
  _$MarketplaceListingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketplaceListing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? subCategory = freezed,
    Object? priceTokens = null,
    Object? priceZar = null,
    Object? images = null,
    Object? thumbnailUrl = freezed,
    Object? providerId = null,
    Object? providerName = null,
    Object? providerPhotoUrl = freezed,
    Object? providerTrustScore = freezed,
    Object? providerIsVerified = freezed,
    Object? communityId = freezed,
    Object? location = freezed,
    Object? status = null,
    Object? viewCount = null,
    Object? reportCount = null,
    Object? expiresAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as MarketplaceCategory,
            subCategory: freezed == subCategory
                ? _value.subCategory
                : subCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            priceTokens: null == priceTokens
                ? _value.priceTokens
                : priceTokens // ignore: cast_nullable_to_non_nullable
                      as int,
            priceZar: null == priceZar
                ? _value.priceZar
                : priceZar // ignore: cast_nullable_to_non_nullable
                      as double,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            providerId: null == providerId
                ? _value.providerId
                : providerId // ignore: cast_nullable_to_non_nullable
                      as String,
            providerName: null == providerName
                ? _value.providerName
                : providerName // ignore: cast_nullable_to_non_nullable
                      as String,
            providerPhotoUrl: freezed == providerPhotoUrl
                ? _value.providerPhotoUrl
                : providerPhotoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            providerTrustScore: freezed == providerTrustScore
                ? _value.providerTrustScore
                : providerTrustScore // ignore: cast_nullable_to_non_nullable
                      as double?,
            providerIsVerified: freezed == providerIsVerified
                ? _value.providerIsVerified
                : providerIsVerified // ignore: cast_nullable_to_non_nullable
                      as bool?,
            communityId: freezed == communityId
                ? _value.communityId
                : communityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ListingStatus,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            reportCount: null == reportCount
                ? _value.reportCount
                : reportCount // ignore: cast_nullable_to_non_nullable
                      as int,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarketplaceListingImplCopyWith<$Res>
    implements $MarketplaceListingCopyWith<$Res> {
  factory _$$MarketplaceListingImplCopyWith(
    _$MarketplaceListingImpl value,
    $Res Function(_$MarketplaceListingImpl) then,
  ) = __$$MarketplaceListingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    MarketplaceCategory category,
    String? subCategory,
    int priceTokens,
    double priceZar,
    List<String> images,
    String? thumbnailUrl,
    String providerId,
    String providerName,
    String? providerPhotoUrl,
    double? providerTrustScore,
    bool? providerIsVerified,
    String? communityId,
    String? location,
    ListingStatus status,
    int viewCount,
    int reportCount,
    DateTime? expiresAt,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$MarketplaceListingImplCopyWithImpl<$Res>
    extends _$MarketplaceListingCopyWithImpl<$Res, _$MarketplaceListingImpl>
    implements _$$MarketplaceListingImplCopyWith<$Res> {
  __$$MarketplaceListingImplCopyWithImpl(
    _$MarketplaceListingImpl _value,
    $Res Function(_$MarketplaceListingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceListing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? subCategory = freezed,
    Object? priceTokens = null,
    Object? priceZar = null,
    Object? images = null,
    Object? thumbnailUrl = freezed,
    Object? providerId = null,
    Object? providerName = null,
    Object? providerPhotoUrl = freezed,
    Object? providerTrustScore = freezed,
    Object? providerIsVerified = freezed,
    Object? communityId = freezed,
    Object? location = freezed,
    Object? status = null,
    Object? viewCount = null,
    Object? reportCount = null,
    Object? expiresAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$MarketplaceListingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as MarketplaceCategory,
        subCategory: freezed == subCategory
            ? _value.subCategory
            : subCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        priceTokens: null == priceTokens
            ? _value.priceTokens
            : priceTokens // ignore: cast_nullable_to_non_nullable
                  as int,
        priceZar: null == priceZar
            ? _value.priceZar
            : priceZar // ignore: cast_nullable_to_non_nullable
                  as double,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        providerId: null == providerId
            ? _value.providerId
            : providerId // ignore: cast_nullable_to_non_nullable
                  as String,
        providerName: null == providerName
            ? _value.providerName
            : providerName // ignore: cast_nullable_to_non_nullable
                  as String,
        providerPhotoUrl: freezed == providerPhotoUrl
            ? _value.providerPhotoUrl
            : providerPhotoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        providerTrustScore: freezed == providerTrustScore
            ? _value.providerTrustScore
            : providerTrustScore // ignore: cast_nullable_to_non_nullable
                  as double?,
        providerIsVerified: freezed == providerIsVerified
            ? _value.providerIsVerified
            : providerIsVerified // ignore: cast_nullable_to_non_nullable
                  as bool?,
        communityId: freezed == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ListingStatus,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        reportCount: null == reportCount
            ? _value.reportCount
            : reportCount // ignore: cast_nullable_to_non_nullable
                  as int,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketplaceListingImpl extends _MarketplaceListing {
  const _$MarketplaceListingImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.subCategory,
    required this.priceTokens,
    required this.priceZar,
    final List<String> images = const [],
    this.thumbnailUrl,
    required this.providerId,
    required this.providerName,
    this.providerPhotoUrl,
    this.providerTrustScore,
    this.providerIsVerified,
    this.communityId,
    this.location,
    required this.status,
    this.viewCount = 0,
    this.reportCount = 0,
    this.expiresAt,
    required this.createdAt,
  }) : _images = images,
       super._();

  factory _$MarketplaceListingImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketplaceListingImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final MarketplaceCategory category;
  @override
  final String? subCategory;
  @override
  final int priceTokens;
  @override
  final double priceZar;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final String? thumbnailUrl;
  @override
  final String providerId;
  @override
  final String providerName;
  @override
  final String? providerPhotoUrl;
  @override
  final double? providerTrustScore;
  @override
  final bool? providerIsVerified;
  @override
  final String? communityId;
  @override
  final String? location;
  @override
  final ListingStatus status;
  @override
  @JsonKey()
  final int viewCount;
  @override
  @JsonKey()
  final int reportCount;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'MarketplaceListing(id: $id, title: $title, description: $description, category: $category, subCategory: $subCategory, priceTokens: $priceTokens, priceZar: $priceZar, images: $images, thumbnailUrl: $thumbnailUrl, providerId: $providerId, providerName: $providerName, providerPhotoUrl: $providerPhotoUrl, providerTrustScore: $providerTrustScore, providerIsVerified: $providerIsVerified, communityId: $communityId, location: $location, status: $status, viewCount: $viewCount, reportCount: $reportCount, expiresAt: $expiresAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketplaceListingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subCategory, subCategory) ||
                other.subCategory == subCategory) &&
            (identical(other.priceTokens, priceTokens) ||
                other.priceTokens == priceTokens) &&
            (identical(other.priceZar, priceZar) ||
                other.priceZar == priceZar) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.providerName, providerName) ||
                other.providerName == providerName) &&
            (identical(other.providerPhotoUrl, providerPhotoUrl) ||
                other.providerPhotoUrl == providerPhotoUrl) &&
            (identical(other.providerTrustScore, providerTrustScore) ||
                other.providerTrustScore == providerTrustScore) &&
            (identical(other.providerIsVerified, providerIsVerified) ||
                other.providerIsVerified == providerIsVerified) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.reportCount, reportCount) ||
                other.reportCount == reportCount) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    description,
    category,
    subCategory,
    priceTokens,
    priceZar,
    const DeepCollectionEquality().hash(_images),
    thumbnailUrl,
    providerId,
    providerName,
    providerPhotoUrl,
    providerTrustScore,
    providerIsVerified,
    communityId,
    location,
    status,
    viewCount,
    reportCount,
    expiresAt,
    createdAt,
  ]);

  /// Create a copy of MarketplaceListing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketplaceListingImplCopyWith<_$MarketplaceListingImpl> get copyWith =>
      __$$MarketplaceListingImplCopyWithImpl<_$MarketplaceListingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketplaceListingImplToJson(this);
  }
}

abstract class _MarketplaceListing extends MarketplaceListing {
  const factory _MarketplaceListing({
    required final String id,
    required final String title,
    required final String description,
    required final MarketplaceCategory category,
    final String? subCategory,
    required final int priceTokens,
    required final double priceZar,
    final List<String> images,
    final String? thumbnailUrl,
    required final String providerId,
    required final String providerName,
    final String? providerPhotoUrl,
    final double? providerTrustScore,
    final bool? providerIsVerified,
    final String? communityId,
    final String? location,
    required final ListingStatus status,
    final int viewCount,
    final int reportCount,
    final DateTime? expiresAt,
    required final DateTime createdAt,
  }) = _$MarketplaceListingImpl;
  const _MarketplaceListing._() : super._();

  factory _MarketplaceListing.fromJson(Map<String, dynamic> json) =
      _$MarketplaceListingImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  MarketplaceCategory get category;
  @override
  String? get subCategory;
  @override
  int get priceTokens;
  @override
  double get priceZar;
  @override
  List<String> get images;
  @override
  String? get thumbnailUrl;
  @override
  String get providerId;
  @override
  String get providerName;
  @override
  String? get providerPhotoUrl;
  @override
  double? get providerTrustScore;
  @override
  bool? get providerIsVerified;
  @override
  String? get communityId;
  @override
  String? get location;
  @override
  ListingStatus get status;
  @override
  int get viewCount;
  @override
  int get reportCount;
  @override
  DateTime? get expiresAt;
  @override
  DateTime get createdAt;

  /// Create a copy of MarketplaceListing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketplaceListingImplCopyWith<_$MarketplaceListingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
