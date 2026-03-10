// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_buy_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroupBuyRequest _$GroupBuyRequestFromJson(Map<String, dynamic> json) {
  return _GroupBuyRequest.fromJson(json);
}

/// @nodoc
mixin _$GroupBuyRequest {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;

  /// Freetext description of the desired deal
  String get description => throw _privateConstructorUsedError;

  /// Brand or store name
  String get brandOrStore => throw _privateConstructorUsedError;

  /// Estimated price in tokens (optional)
  int? get estimatedPrice => throw _privateConstructorUsedError;

  /// Link to the product/deal online
  String? get sourceUrl => throw _privateConstructorUsedError;

  /// Optional image URL for the product
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Whether the suggester wants to be first to join
  bool get wantsToJoin => throw _privateConstructorUsedError;
  GroupBuyRequestStatus get status => throw _privateConstructorUsedError;

  /// Admin notes (reason for approval/decline)
  String? get adminNotes => throw _privateConstructorUsedError;

  /// If approved, the ID of the created group buy
  String? get convertedGroupBuyId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupBuyRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupBuyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupBuyRequestCopyWith<GroupBuyRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupBuyRequestCopyWith<$Res> {
  factory $GroupBuyRequestCopyWith(
    GroupBuyRequest value,
    $Res Function(GroupBuyRequest) then,
  ) = _$GroupBuyRequestCopyWithImpl<$Res, GroupBuyRequest>;
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    String description,
    String brandOrStore,
    int? estimatedPrice,
    String? sourceUrl,
    String? imageUrl,
    bool wantsToJoin,
    GroupBuyRequestStatus status,
    String? adminNotes,
    String? convertedGroupBuyId,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$GroupBuyRequestCopyWithImpl<$Res, $Val extends GroupBuyRequest>
    implements $GroupBuyRequestCopyWith<$Res> {
  _$GroupBuyRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupBuyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? description = null,
    Object? brandOrStore = null,
    Object? estimatedPrice = freezed,
    Object? sourceUrl = freezed,
    Object? imageUrl = freezed,
    Object? wantsToJoin = null,
    Object? status = null,
    Object? adminNotes = freezed,
    Object? convertedGroupBuyId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            brandOrStore: null == brandOrStore
                ? _value.brandOrStore
                : brandOrStore // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedPrice: freezed == estimatedPrice
                ? _value.estimatedPrice
                : estimatedPrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            sourceUrl: freezed == sourceUrl
                ? _value.sourceUrl
                : sourceUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            wantsToJoin: null == wantsToJoin
                ? _value.wantsToJoin
                : wantsToJoin // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GroupBuyRequestStatus,
            adminNotes: freezed == adminNotes
                ? _value.adminNotes
                : adminNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            convertedGroupBuyId: freezed == convertedGroupBuyId
                ? _value.convertedGroupBuyId
                : convertedGroupBuyId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$GroupBuyRequestImplCopyWith<$Res>
    implements $GroupBuyRequestCopyWith<$Res> {
  factory _$$GroupBuyRequestImplCopyWith(
    _$GroupBuyRequestImpl value,
    $Res Function(_$GroupBuyRequestImpl) then,
  ) = __$$GroupBuyRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String userName,
    String description,
    String brandOrStore,
    int? estimatedPrice,
    String? sourceUrl,
    String? imageUrl,
    bool wantsToJoin,
    GroupBuyRequestStatus status,
    String? adminNotes,
    String? convertedGroupBuyId,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$GroupBuyRequestImplCopyWithImpl<$Res>
    extends _$GroupBuyRequestCopyWithImpl<$Res, _$GroupBuyRequestImpl>
    implements _$$GroupBuyRequestImplCopyWith<$Res> {
  __$$GroupBuyRequestImplCopyWithImpl(
    _$GroupBuyRequestImpl _value,
    $Res Function(_$GroupBuyRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userName = null,
    Object? description = null,
    Object? brandOrStore = null,
    Object? estimatedPrice = freezed,
    Object? sourceUrl = freezed,
    Object? imageUrl = freezed,
    Object? wantsToJoin = null,
    Object? status = null,
    Object? adminNotes = freezed,
    Object? convertedGroupBuyId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$GroupBuyRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        brandOrStore: null == brandOrStore
            ? _value.brandOrStore
            : brandOrStore // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedPrice: freezed == estimatedPrice
            ? _value.estimatedPrice
            : estimatedPrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        sourceUrl: freezed == sourceUrl
            ? _value.sourceUrl
            : sourceUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        wantsToJoin: null == wantsToJoin
            ? _value.wantsToJoin
            : wantsToJoin // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GroupBuyRequestStatus,
        adminNotes: freezed == adminNotes
            ? _value.adminNotes
            : adminNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        convertedGroupBuyId: freezed == convertedGroupBuyId
            ? _value.convertedGroupBuyId
            : convertedGroupBuyId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$GroupBuyRequestImpl extends _GroupBuyRequest {
  const _$GroupBuyRequestImpl({
    required this.id,
    required this.userId,
    required this.userName,
    required this.description,
    required this.brandOrStore,
    this.estimatedPrice,
    this.sourceUrl,
    this.imageUrl,
    this.wantsToJoin = true,
    required this.status,
    this.adminNotes,
    this.convertedGroupBuyId,
    required this.createdAt,
    this.updatedAt,
  }) : super._();

  factory _$GroupBuyRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupBuyRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String userName;

  /// Freetext description of the desired deal
  @override
  final String description;

  /// Brand or store name
  @override
  final String brandOrStore;

  /// Estimated price in tokens (optional)
  @override
  final int? estimatedPrice;

  /// Link to the product/deal online
  @override
  final String? sourceUrl;

  /// Optional image URL for the product
  @override
  final String? imageUrl;

  /// Whether the suggester wants to be first to join
  @override
  @JsonKey()
  final bool wantsToJoin;
  @override
  final GroupBuyRequestStatus status;

  /// Admin notes (reason for approval/decline)
  @override
  final String? adminNotes;

  /// If approved, the ID of the created group buy
  @override
  final String? convertedGroupBuyId;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'GroupBuyRequest(id: $id, userId: $userId, userName: $userName, description: $description, brandOrStore: $brandOrStore, estimatedPrice: $estimatedPrice, sourceUrl: $sourceUrl, imageUrl: $imageUrl, wantsToJoin: $wantsToJoin, status: $status, adminNotes: $adminNotes, convertedGroupBuyId: $convertedGroupBuyId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupBuyRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.brandOrStore, brandOrStore) ||
                other.brandOrStore == brandOrStore) &&
            (identical(other.estimatedPrice, estimatedPrice) ||
                other.estimatedPrice == estimatedPrice) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.wantsToJoin, wantsToJoin) ||
                other.wantsToJoin == wantsToJoin) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.adminNotes, adminNotes) ||
                other.adminNotes == adminNotes) &&
            (identical(other.convertedGroupBuyId, convertedGroupBuyId) ||
                other.convertedGroupBuyId == convertedGroupBuyId) &&
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
    userId,
    userName,
    description,
    brandOrStore,
    estimatedPrice,
    sourceUrl,
    imageUrl,
    wantsToJoin,
    status,
    adminNotes,
    convertedGroupBuyId,
    createdAt,
    updatedAt,
  );

  /// Create a copy of GroupBuyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupBuyRequestImplCopyWith<_$GroupBuyRequestImpl> get copyWith =>
      __$$GroupBuyRequestImplCopyWithImpl<_$GroupBuyRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupBuyRequestImplToJson(this);
  }
}

abstract class _GroupBuyRequest extends GroupBuyRequest {
  const factory _GroupBuyRequest({
    required final String id,
    required final String userId,
    required final String userName,
    required final String description,
    required final String brandOrStore,
    final int? estimatedPrice,
    final String? sourceUrl,
    final String? imageUrl,
    final bool wantsToJoin,
    required final GroupBuyRequestStatus status,
    final String? adminNotes,
    final String? convertedGroupBuyId,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$GroupBuyRequestImpl;
  const _GroupBuyRequest._() : super._();

  factory _GroupBuyRequest.fromJson(Map<String, dynamic> json) =
      _$GroupBuyRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get userName;

  /// Freetext description of the desired deal
  @override
  String get description;

  /// Brand or store name
  @override
  String get brandOrStore;

  /// Estimated price in tokens (optional)
  @override
  int? get estimatedPrice;

  /// Link to the product/deal online
  @override
  String? get sourceUrl;

  /// Optional image URL for the product
  @override
  String? get imageUrl;

  /// Whether the suggester wants to be first to join
  @override
  bool get wantsToJoin;
  @override
  GroupBuyRequestStatus get status;

  /// Admin notes (reason for approval/decline)
  @override
  String? get adminNotes;

  /// If approved, the ID of the created group buy
  @override
  String? get convertedGroupBuyId;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of GroupBuyRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupBuyRequestImplCopyWith<_$GroupBuyRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
