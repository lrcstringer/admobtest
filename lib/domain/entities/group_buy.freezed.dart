// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_buy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroupBuy _$GroupBuyFromJson(Map<String, dynamic> json) {
  return _GroupBuy.fromJson(json);
}

/// @nodoc
mixin _$GroupBuy {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get linkedListingId => throw _privateConstructorUsedError;

  /// Made optional — admin-curated group buys have no user organizer.
  String? get organizerId => throw _privateConstructorUsedError;
  String? get organizerName => throw _privateConstructorUsedError;

  /// Made optional — admin-curated group buys are not community-bound.
  String? get communityId => throw _privateConstructorUsedError;
  int get targetAmount => throw _privateConstructorUsedError;
  int get currentAmount => throw _privateConstructorUsedError;
  int get minParticipants => throw _privateConstructorUsedError;
  int? get maxParticipants => throw _privateConstructorUsedError;
  DateTime get deadline => throw _privateConstructorUsedError;
  GroupBuyStatus get status => throw _privateConstructorUsedError;
  int get participantCount => throw _privateConstructorUsedError;

  /// 'community' or 'brand'
  String get sponsorType => throw _privateConstructorUsedError;
  String? get brandId => throw _privateConstructorUsedError;
  String? get brandName => throw _privateConstructorUsedError;
  String? get brandLogoUrl => throw _privateConstructorUsedError;
  int? get discountPercent =>
      throw _privateConstructorUsedError; // ── New fields for admin-curated group buys ──
  /// Whether this group buy was created by admin
  bool get createdByAdmin => throw _privateConstructorUsedError;

  /// digital = shown to all, physical = cluster-matched
  GroupBuyType get type => throw _privateConstructorUsedError;

  /// How the deal is fulfilled after target is met
  GroupBuyFulfilmentType get fulfilmentType =>
      throw _privateConstructorUsedError;

  /// Regional clusters this deal targets (physical only)
  List<String> get clusters => throw _privateConstructorUsedError;

  /// Freetext pickup/collection addresses for display (physical only)
  List<String> get addresses => throw _privateConstructorUsedError;

  /// Voucher codes uploaded by admin at completion (digital fulfilment)
  List<String> get voucherCodes => throw _privateConstructorUsedError;

  /// Product image URL
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Original price before group buy discount (for strikethrough display)
  int? get originalPrice => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupBuy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupBuy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupBuyCopyWith<GroupBuy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupBuyCopyWith<$Res> {
  factory $GroupBuyCopyWith(GroupBuy value, $Res Function(GroupBuy) then) =
      _$GroupBuyCopyWithImpl<$Res, GroupBuy>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String? linkedListingId,
    String? organizerId,
    String? organizerName,
    String? communityId,
    int targetAmount,
    int currentAmount,
    int minParticipants,
    int? maxParticipants,
    DateTime deadline,
    GroupBuyStatus status,
    int participantCount,
    String sponsorType,
    String? brandId,
    String? brandName,
    String? brandLogoUrl,
    int? discountPercent,
    bool createdByAdmin,
    GroupBuyType type,
    GroupBuyFulfilmentType fulfilmentType,
    List<String> clusters,
    List<String> addresses,
    List<String> voucherCodes,
    String? imageUrl,
    int? originalPrice,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$GroupBuyCopyWithImpl<$Res, $Val extends GroupBuy>
    implements $GroupBuyCopyWith<$Res> {
  _$GroupBuyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupBuy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? linkedListingId = freezed,
    Object? organizerId = freezed,
    Object? organizerName = freezed,
    Object? communityId = freezed,
    Object? targetAmount = null,
    Object? currentAmount = null,
    Object? minParticipants = null,
    Object? maxParticipants = freezed,
    Object? deadline = null,
    Object? status = null,
    Object? participantCount = null,
    Object? sponsorType = null,
    Object? brandId = freezed,
    Object? brandName = freezed,
    Object? brandLogoUrl = freezed,
    Object? discountPercent = freezed,
    Object? createdByAdmin = null,
    Object? type = null,
    Object? fulfilmentType = null,
    Object? clusters = null,
    Object? addresses = null,
    Object? voucherCodes = null,
    Object? imageUrl = freezed,
    Object? originalPrice = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
            linkedListingId: freezed == linkedListingId
                ? _value.linkedListingId
                : linkedListingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            organizerId: freezed == organizerId
                ? _value.organizerId
                : organizerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            organizerName: freezed == organizerName
                ? _value.organizerName
                : organizerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            communityId: freezed == communityId
                ? _value.communityId
                : communityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            targetAmount: null == targetAmount
                ? _value.targetAmount
                : targetAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            currentAmount: null == currentAmount
                ? _value.currentAmount
                : currentAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            minParticipants: null == minParticipants
                ? _value.minParticipants
                : minParticipants // ignore: cast_nullable_to_non_nullable
                      as int,
            maxParticipants: freezed == maxParticipants
                ? _value.maxParticipants
                : maxParticipants // ignore: cast_nullable_to_non_nullable
                      as int?,
            deadline: null == deadline
                ? _value.deadline
                : deadline // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GroupBuyStatus,
            participantCount: null == participantCount
                ? _value.participantCount
                : participantCount // ignore: cast_nullable_to_non_nullable
                      as int,
            sponsorType: null == sponsorType
                ? _value.sponsorType
                : sponsorType // ignore: cast_nullable_to_non_nullable
                      as String,
            brandId: freezed == brandId
                ? _value.brandId
                : brandId // ignore: cast_nullable_to_non_nullable
                      as String?,
            brandName: freezed == brandName
                ? _value.brandName
                : brandName // ignore: cast_nullable_to_non_nullable
                      as String?,
            brandLogoUrl: freezed == brandLogoUrl
                ? _value.brandLogoUrl
                : brandLogoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            discountPercent: freezed == discountPercent
                ? _value.discountPercent
                : discountPercent // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdByAdmin: null == createdByAdmin
                ? _value.createdByAdmin
                : createdByAdmin // ignore: cast_nullable_to_non_nullable
                      as bool,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as GroupBuyType,
            fulfilmentType: null == fulfilmentType
                ? _value.fulfilmentType
                : fulfilmentType // ignore: cast_nullable_to_non_nullable
                      as GroupBuyFulfilmentType,
            clusters: null == clusters
                ? _value.clusters
                : clusters // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            addresses: null == addresses
                ? _value.addresses
                : addresses // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            voucherCodes: null == voucherCodes
                ? _value.voucherCodes
                : voucherCodes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            originalPrice: freezed == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$GroupBuyImplCopyWith<$Res>
    implements $GroupBuyCopyWith<$Res> {
  factory _$$GroupBuyImplCopyWith(
    _$GroupBuyImpl value,
    $Res Function(_$GroupBuyImpl) then,
  ) = __$$GroupBuyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String? linkedListingId,
    String? organizerId,
    String? organizerName,
    String? communityId,
    int targetAmount,
    int currentAmount,
    int minParticipants,
    int? maxParticipants,
    DateTime deadline,
    GroupBuyStatus status,
    int participantCount,
    String sponsorType,
    String? brandId,
    String? brandName,
    String? brandLogoUrl,
    int? discountPercent,
    bool createdByAdmin,
    GroupBuyType type,
    GroupBuyFulfilmentType fulfilmentType,
    List<String> clusters,
    List<String> addresses,
    List<String> voucherCodes,
    String? imageUrl,
    int? originalPrice,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$GroupBuyImplCopyWithImpl<$Res>
    extends _$GroupBuyCopyWithImpl<$Res, _$GroupBuyImpl>
    implements _$$GroupBuyImplCopyWith<$Res> {
  __$$GroupBuyImplCopyWithImpl(
    _$GroupBuyImpl _value,
    $Res Function(_$GroupBuyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? linkedListingId = freezed,
    Object? organizerId = freezed,
    Object? organizerName = freezed,
    Object? communityId = freezed,
    Object? targetAmount = null,
    Object? currentAmount = null,
    Object? minParticipants = null,
    Object? maxParticipants = freezed,
    Object? deadline = null,
    Object? status = null,
    Object? participantCount = null,
    Object? sponsorType = null,
    Object? brandId = freezed,
    Object? brandName = freezed,
    Object? brandLogoUrl = freezed,
    Object? discountPercent = freezed,
    Object? createdByAdmin = null,
    Object? type = null,
    Object? fulfilmentType = null,
    Object? clusters = null,
    Object? addresses = null,
    Object? voucherCodes = null,
    Object? imageUrl = freezed,
    Object? originalPrice = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$GroupBuyImpl(
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
        linkedListingId: freezed == linkedListingId
            ? _value.linkedListingId
            : linkedListingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        organizerId: freezed == organizerId
            ? _value.organizerId
            : organizerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        organizerName: freezed == organizerName
            ? _value.organizerName
            : organizerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        communityId: freezed == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        targetAmount: null == targetAmount
            ? _value.targetAmount
            : targetAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        currentAmount: null == currentAmount
            ? _value.currentAmount
            : currentAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        minParticipants: null == minParticipants
            ? _value.minParticipants
            : minParticipants // ignore: cast_nullable_to_non_nullable
                  as int,
        maxParticipants: freezed == maxParticipants
            ? _value.maxParticipants
            : maxParticipants // ignore: cast_nullable_to_non_nullable
                  as int?,
        deadline: null == deadline
            ? _value.deadline
            : deadline // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GroupBuyStatus,
        participantCount: null == participantCount
            ? _value.participantCount
            : participantCount // ignore: cast_nullable_to_non_nullable
                  as int,
        sponsorType: null == sponsorType
            ? _value.sponsorType
            : sponsorType // ignore: cast_nullable_to_non_nullable
                  as String,
        brandId: freezed == brandId
            ? _value.brandId
            : brandId // ignore: cast_nullable_to_non_nullable
                  as String?,
        brandName: freezed == brandName
            ? _value.brandName
            : brandName // ignore: cast_nullable_to_non_nullable
                  as String?,
        brandLogoUrl: freezed == brandLogoUrl
            ? _value.brandLogoUrl
            : brandLogoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        discountPercent: freezed == discountPercent
            ? _value.discountPercent
            : discountPercent // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdByAdmin: null == createdByAdmin
            ? _value.createdByAdmin
            : createdByAdmin // ignore: cast_nullable_to_non_nullable
                  as bool,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as GroupBuyType,
        fulfilmentType: null == fulfilmentType
            ? _value.fulfilmentType
            : fulfilmentType // ignore: cast_nullable_to_non_nullable
                  as GroupBuyFulfilmentType,
        clusters: null == clusters
            ? _value._clusters
            : clusters // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        addresses: null == addresses
            ? _value._addresses
            : addresses // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        voucherCodes: null == voucherCodes
            ? _value._voucherCodes
            : voucherCodes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        originalPrice: freezed == originalPrice
            ? _value.originalPrice
            : originalPrice // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$GroupBuyImpl extends _GroupBuy {
  const _$GroupBuyImpl({
    required this.id,
    required this.title,
    required this.description,
    this.linkedListingId,
    this.organizerId,
    this.organizerName,
    this.communityId,
    required this.targetAmount,
    this.currentAmount = 0,
    this.minParticipants = 1,
    this.maxParticipants,
    required this.deadline,
    required this.status,
    this.participantCount = 0,
    this.sponsorType = 'community',
    this.brandId,
    this.brandName,
    this.brandLogoUrl,
    this.discountPercent,
    this.createdByAdmin = false,
    this.type = GroupBuyType.digital,
    this.fulfilmentType = GroupBuyFulfilmentType.digital,
    final List<String> clusters = const [],
    final List<String> addresses = const [],
    final List<String> voucherCodes = const [],
    this.imageUrl,
    this.originalPrice,
    required this.createdAt,
    this.updatedAt,
  }) : _clusters = clusters,
       _addresses = addresses,
       _voucherCodes = voucherCodes,
       super._();

  factory _$GroupBuyImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupBuyImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String? linkedListingId;

  /// Made optional — admin-curated group buys have no user organizer.
  @override
  final String? organizerId;
  @override
  final String? organizerName;

  /// Made optional — admin-curated group buys are not community-bound.
  @override
  final String? communityId;
  @override
  final int targetAmount;
  @override
  @JsonKey()
  final int currentAmount;
  @override
  @JsonKey()
  final int minParticipants;
  @override
  final int? maxParticipants;
  @override
  final DateTime deadline;
  @override
  final GroupBuyStatus status;
  @override
  @JsonKey()
  final int participantCount;

  /// 'community' or 'brand'
  @override
  @JsonKey()
  final String sponsorType;
  @override
  final String? brandId;
  @override
  final String? brandName;
  @override
  final String? brandLogoUrl;
  @override
  final int? discountPercent;
  // ── New fields for admin-curated group buys ──
  /// Whether this group buy was created by admin
  @override
  @JsonKey()
  final bool createdByAdmin;

  /// digital = shown to all, physical = cluster-matched
  @override
  @JsonKey()
  final GroupBuyType type;

  /// How the deal is fulfilled after target is met
  @override
  @JsonKey()
  final GroupBuyFulfilmentType fulfilmentType;

  /// Regional clusters this deal targets (physical only)
  final List<String> _clusters;

  /// Regional clusters this deal targets (physical only)
  @override
  @JsonKey()
  List<String> get clusters {
    if (_clusters is EqualUnmodifiableListView) return _clusters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clusters);
  }

  /// Freetext pickup/collection addresses for display (physical only)
  final List<String> _addresses;

  /// Freetext pickup/collection addresses for display (physical only)
  @override
  @JsonKey()
  List<String> get addresses {
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  /// Voucher codes uploaded by admin at completion (digital fulfilment)
  final List<String> _voucherCodes;

  /// Voucher codes uploaded by admin at completion (digital fulfilment)
  @override
  @JsonKey()
  List<String> get voucherCodes {
    if (_voucherCodes is EqualUnmodifiableListView) return _voucherCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_voucherCodes);
  }

  /// Product image URL
  @override
  final String? imageUrl;

  /// Original price before group buy discount (for strikethrough display)
  @override
  final int? originalPrice;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'GroupBuy(id: $id, title: $title, description: $description, linkedListingId: $linkedListingId, organizerId: $organizerId, organizerName: $organizerName, communityId: $communityId, targetAmount: $targetAmount, currentAmount: $currentAmount, minParticipants: $minParticipants, maxParticipants: $maxParticipants, deadline: $deadline, status: $status, participantCount: $participantCount, sponsorType: $sponsorType, brandId: $brandId, brandName: $brandName, brandLogoUrl: $brandLogoUrl, discountPercent: $discountPercent, createdByAdmin: $createdByAdmin, type: $type, fulfilmentType: $fulfilmentType, clusters: $clusters, addresses: $addresses, voucherCodes: $voucherCodes, imageUrl: $imageUrl, originalPrice: $originalPrice, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupBuyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.linkedListingId, linkedListingId) ||
                other.linkedListingId == linkedListingId) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.organizerName, organizerName) ||
                other.organizerName == organizerName) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.targetAmount, targetAmount) ||
                other.targetAmount == targetAmount) &&
            (identical(other.currentAmount, currentAmount) ||
                other.currentAmount == currentAmount) &&
            (identical(other.minParticipants, minParticipants) ||
                other.minParticipants == minParticipants) &&
            (identical(other.maxParticipants, maxParticipants) ||
                other.maxParticipants == maxParticipants) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.participantCount, participantCount) ||
                other.participantCount == participantCount) &&
            (identical(other.sponsorType, sponsorType) ||
                other.sponsorType == sponsorType) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.brandLogoUrl, brandLogoUrl) ||
                other.brandLogoUrl == brandLogoUrl) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            (identical(other.createdByAdmin, createdByAdmin) ||
                other.createdByAdmin == createdByAdmin) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.fulfilmentType, fulfilmentType) ||
                other.fulfilmentType == fulfilmentType) &&
            const DeepCollectionEquality().equals(other._clusters, _clusters) &&
            const DeepCollectionEquality().equals(
              other._addresses,
              _addresses,
            ) &&
            const DeepCollectionEquality().equals(
              other._voucherCodes,
              _voucherCodes,
            ) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    description,
    linkedListingId,
    organizerId,
    organizerName,
    communityId,
    targetAmount,
    currentAmount,
    minParticipants,
    maxParticipants,
    deadline,
    status,
    participantCount,
    sponsorType,
    brandId,
    brandName,
    brandLogoUrl,
    discountPercent,
    createdByAdmin,
    type,
    fulfilmentType,
    const DeepCollectionEquality().hash(_clusters),
    const DeepCollectionEquality().hash(_addresses),
    const DeepCollectionEquality().hash(_voucherCodes),
    imageUrl,
    originalPrice,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of GroupBuy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupBuyImplCopyWith<_$GroupBuyImpl> get copyWith =>
      __$$GroupBuyImplCopyWithImpl<_$GroupBuyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupBuyImplToJson(this);
  }
}

abstract class _GroupBuy extends GroupBuy {
  const factory _GroupBuy({
    required final String id,
    required final String title,
    required final String description,
    final String? linkedListingId,
    final String? organizerId,
    final String? organizerName,
    final String? communityId,
    required final int targetAmount,
    final int currentAmount,
    final int minParticipants,
    final int? maxParticipants,
    required final DateTime deadline,
    required final GroupBuyStatus status,
    final int participantCount,
    final String sponsorType,
    final String? brandId,
    final String? brandName,
    final String? brandLogoUrl,
    final int? discountPercent,
    final bool createdByAdmin,
    final GroupBuyType type,
    final GroupBuyFulfilmentType fulfilmentType,
    final List<String> clusters,
    final List<String> addresses,
    final List<String> voucherCodes,
    final String? imageUrl,
    final int? originalPrice,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$GroupBuyImpl;
  const _GroupBuy._() : super._();

  factory _GroupBuy.fromJson(Map<String, dynamic> json) =
      _$GroupBuyImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String? get linkedListingId;

  /// Made optional — admin-curated group buys have no user organizer.
  @override
  String? get organizerId;
  @override
  String? get organizerName;

  /// Made optional — admin-curated group buys are not community-bound.
  @override
  String? get communityId;
  @override
  int get targetAmount;
  @override
  int get currentAmount;
  @override
  int get minParticipants;
  @override
  int? get maxParticipants;
  @override
  DateTime get deadline;
  @override
  GroupBuyStatus get status;
  @override
  int get participantCount;

  /// 'community' or 'brand'
  @override
  String get sponsorType;
  @override
  String? get brandId;
  @override
  String? get brandName;
  @override
  String? get brandLogoUrl;
  @override
  int? get discountPercent; // ── New fields for admin-curated group buys ──
  /// Whether this group buy was created by admin
  @override
  bool get createdByAdmin;

  /// digital = shown to all, physical = cluster-matched
  @override
  GroupBuyType get type;

  /// How the deal is fulfilled after target is met
  @override
  GroupBuyFulfilmentType get fulfilmentType;

  /// Regional clusters this deal targets (physical only)
  @override
  List<String> get clusters;

  /// Freetext pickup/collection addresses for display (physical only)
  @override
  List<String> get addresses;

  /// Voucher codes uploaded by admin at completion (digital fulfilment)
  @override
  List<String> get voucherCodes;

  /// Product image URL
  @override
  String? get imageUrl;

  /// Original price before group buy discount (for strikethrough display)
  @override
  int? get originalPrice;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of GroupBuy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupBuyImplCopyWith<_$GroupBuyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
