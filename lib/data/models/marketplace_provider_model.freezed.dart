// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_provider_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MarketplaceProviderModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  String? get communityId => throw _privateConstructorUsedError;
  String? get servicesDescription => throw _privateConstructorUsedError;
  ProviderStatus get status => throw _privateConstructorUsedError;
  double get trustScore => throw _privateConstructorUsedError;
  int get vouchCount => throw _privateConstructorUsedError;
  int get completedOrders => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  bool? get isVerifiedOverride => throw _privateConstructorUsedError;
  List<String> get customerIds => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of MarketplaceProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketplaceProviderModelCopyWith<MarketplaceProviderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketplaceProviderModelCopyWith<$Res> {
  factory $MarketplaceProviderModelCopyWith(
    MarketplaceProviderModel value,
    $Res Function(MarketplaceProviderModel) then,
  ) = _$MarketplaceProviderModelCopyWithImpl<$Res, MarketplaceProviderModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    String displayName,
    String? bio,
    String? photoUrl,
    String? communityId,
    String? servicesDescription,
    ProviderStatus status,
    double trustScore,
    int vouchCount,
    int completedOrders,
    bool isVerified,
    bool? isVerifiedOverride,
    List<String> customerIds,
    DateTime createdAt,
  });
}

/// @nodoc
class _$MarketplaceProviderModelCopyWithImpl<
  $Res,
  $Val extends MarketplaceProviderModel
>
    implements $MarketplaceProviderModelCopyWith<$Res> {
  _$MarketplaceProviderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketplaceProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? displayName = null,
    Object? bio = freezed,
    Object? photoUrl = freezed,
    Object? communityId = freezed,
    Object? servicesDescription = freezed,
    Object? status = null,
    Object? trustScore = null,
    Object? vouchCount = null,
    Object? completedOrders = null,
    Object? isVerified = null,
    Object? isVerifiedOverride = freezed,
    Object? customerIds = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            photoUrl: freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            communityId: freezed == communityId
                ? _value.communityId
                : communityId // ignore: cast_nullable_to_non_nullable
                      as String?,
            servicesDescription: freezed == servicesDescription
                ? _value.servicesDescription
                : servicesDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ProviderStatus,
            trustScore: null == trustScore
                ? _value.trustScore
                : trustScore // ignore: cast_nullable_to_non_nullable
                      as double,
            vouchCount: null == vouchCount
                ? _value.vouchCount
                : vouchCount // ignore: cast_nullable_to_non_nullable
                      as int,
            completedOrders: null == completedOrders
                ? _value.completedOrders
                : completedOrders // ignore: cast_nullable_to_non_nullable
                      as int,
            isVerified: null == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            isVerifiedOverride: freezed == isVerifiedOverride
                ? _value.isVerifiedOverride
                : isVerifiedOverride // ignore: cast_nullable_to_non_nullable
                      as bool?,
            customerIds: null == customerIds
                ? _value.customerIds
                : customerIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
abstract class _$$MarketplaceProviderModelImplCopyWith<$Res>
    implements $MarketplaceProviderModelCopyWith<$Res> {
  factory _$$MarketplaceProviderModelImplCopyWith(
    _$MarketplaceProviderModelImpl value,
    $Res Function(_$MarketplaceProviderModelImpl) then,
  ) = __$$MarketplaceProviderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String displayName,
    String? bio,
    String? photoUrl,
    String? communityId,
    String? servicesDescription,
    ProviderStatus status,
    double trustScore,
    int vouchCount,
    int completedOrders,
    bool isVerified,
    bool? isVerifiedOverride,
    List<String> customerIds,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$MarketplaceProviderModelImplCopyWithImpl<$Res>
    extends
        _$MarketplaceProviderModelCopyWithImpl<
          $Res,
          _$MarketplaceProviderModelImpl
        >
    implements _$$MarketplaceProviderModelImplCopyWith<$Res> {
  __$$MarketplaceProviderModelImplCopyWithImpl(
    _$MarketplaceProviderModelImpl _value,
    $Res Function(_$MarketplaceProviderModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? displayName = null,
    Object? bio = freezed,
    Object? photoUrl = freezed,
    Object? communityId = freezed,
    Object? servicesDescription = freezed,
    Object? status = null,
    Object? trustScore = null,
    Object? vouchCount = null,
    Object? completedOrders = null,
    Object? isVerified = null,
    Object? isVerifiedOverride = freezed,
    Object? customerIds = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$MarketplaceProviderModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        photoUrl: freezed == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        communityId: freezed == communityId
            ? _value.communityId
            : communityId // ignore: cast_nullable_to_non_nullable
                  as String?,
        servicesDescription: freezed == servicesDescription
            ? _value.servicesDescription
            : servicesDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ProviderStatus,
        trustScore: null == trustScore
            ? _value.trustScore
            : trustScore // ignore: cast_nullable_to_non_nullable
                  as double,
        vouchCount: null == vouchCount
            ? _value.vouchCount
            : vouchCount // ignore: cast_nullable_to_non_nullable
                  as int,
        completedOrders: null == completedOrders
            ? _value.completedOrders
            : completedOrders // ignore: cast_nullable_to_non_nullable
                  as int,
        isVerified: null == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        isVerifiedOverride: freezed == isVerifiedOverride
            ? _value.isVerifiedOverride
            : isVerifiedOverride // ignore: cast_nullable_to_non_nullable
                  as bool?,
        customerIds: null == customerIds
            ? _value._customerIds
            : customerIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$MarketplaceProviderModelImpl extends _MarketplaceProviderModel {
  const _$MarketplaceProviderModelImpl({
    required this.id,
    required this.userId,
    required this.displayName,
    this.bio,
    this.photoUrl,
    this.communityId,
    this.servicesDescription,
    required this.status,
    this.trustScore = 0.0,
    this.vouchCount = 0,
    this.completedOrders = 0,
    this.isVerified = false,
    this.isVerifiedOverride,
    final List<String> customerIds = const [],
    required this.createdAt,
  }) : _customerIds = customerIds,
       super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? bio;
  @override
  final String? photoUrl;
  @override
  final String? communityId;
  @override
  final String? servicesDescription;
  @override
  final ProviderStatus status;
  @override
  @JsonKey()
  final double trustScore;
  @override
  @JsonKey()
  final int vouchCount;
  @override
  @JsonKey()
  final int completedOrders;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  final bool? isVerifiedOverride;
  final List<String> _customerIds;
  @override
  @JsonKey()
  List<String> get customerIds {
    if (_customerIds is EqualUnmodifiableListView) return _customerIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customerIds);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'MarketplaceProviderModel(id: $id, userId: $userId, displayName: $displayName, bio: $bio, photoUrl: $photoUrl, communityId: $communityId, servicesDescription: $servicesDescription, status: $status, trustScore: $trustScore, vouchCount: $vouchCount, completedOrders: $completedOrders, isVerified: $isVerified, isVerifiedOverride: $isVerifiedOverride, customerIds: $customerIds, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketplaceProviderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.communityId, communityId) ||
                other.communityId == communityId) &&
            (identical(other.servicesDescription, servicesDescription) ||
                other.servicesDescription == servicesDescription) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.trustScore, trustScore) ||
                other.trustScore == trustScore) &&
            (identical(other.vouchCount, vouchCount) ||
                other.vouchCount == vouchCount) &&
            (identical(other.completedOrders, completedOrders) ||
                other.completedOrders == completedOrders) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isVerifiedOverride, isVerifiedOverride) ||
                other.isVerifiedOverride == isVerifiedOverride) &&
            const DeepCollectionEquality().equals(
              other._customerIds,
              _customerIds,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    displayName,
    bio,
    photoUrl,
    communityId,
    servicesDescription,
    status,
    trustScore,
    vouchCount,
    completedOrders,
    isVerified,
    isVerifiedOverride,
    const DeepCollectionEquality().hash(_customerIds),
    createdAt,
  );

  /// Create a copy of MarketplaceProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketplaceProviderModelImplCopyWith<_$MarketplaceProviderModelImpl>
  get copyWith =>
      __$$MarketplaceProviderModelImplCopyWithImpl<
        _$MarketplaceProviderModelImpl
      >(this, _$identity);
}

abstract class _MarketplaceProviderModel extends MarketplaceProviderModel {
  const factory _MarketplaceProviderModel({
    required final String id,
    required final String userId,
    required final String displayName,
    final String? bio,
    final String? photoUrl,
    final String? communityId,
    final String? servicesDescription,
    required final ProviderStatus status,
    final double trustScore,
    final int vouchCount,
    final int completedOrders,
    final bool isVerified,
    final bool? isVerifiedOverride,
    final List<String> customerIds,
    required final DateTime createdAt,
  }) = _$MarketplaceProviderModelImpl;
  const _MarketplaceProviderModel._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get bio;
  @override
  String? get photoUrl;
  @override
  String? get communityId;
  @override
  String? get servicesDescription;
  @override
  ProviderStatus get status;
  @override
  double get trustScore;
  @override
  int get vouchCount;
  @override
  int get completedOrders;
  @override
  bool get isVerified;
  @override
  bool? get isVerifiedOverride;
  @override
  List<String> get customerIds;
  @override
  DateTime get createdAt;

  /// Create a copy of MarketplaceProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketplaceProviderModelImplCopyWith<_$MarketplaceProviderModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
