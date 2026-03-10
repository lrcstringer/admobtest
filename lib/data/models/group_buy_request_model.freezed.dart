// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_buy_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GroupBuyRequestModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get brandOrStore => throw _privateConstructorUsedError;
  int? get estimatedPrice => throw _privateConstructorUsedError;
  String? get sourceUrl => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get wantsToJoin => throw _privateConstructorUsedError;
  GroupBuyRequestStatus get status => throw _privateConstructorUsedError;
  String? get adminNotes => throw _privateConstructorUsedError;
  String? get convertedGroupBuyId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of GroupBuyRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupBuyRequestModelCopyWith<GroupBuyRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupBuyRequestModelCopyWith<$Res> {
  factory $GroupBuyRequestModelCopyWith(
    GroupBuyRequestModel value,
    $Res Function(GroupBuyRequestModel) then,
  ) = _$GroupBuyRequestModelCopyWithImpl<$Res, GroupBuyRequestModel>;
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
class _$GroupBuyRequestModelCopyWithImpl<
  $Res,
  $Val extends GroupBuyRequestModel
>
    implements $GroupBuyRequestModelCopyWith<$Res> {
  _$GroupBuyRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupBuyRequestModel
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
abstract class _$$GroupBuyRequestModelImplCopyWith<$Res>
    implements $GroupBuyRequestModelCopyWith<$Res> {
  factory _$$GroupBuyRequestModelImplCopyWith(
    _$GroupBuyRequestModelImpl value,
    $Res Function(_$GroupBuyRequestModelImpl) then,
  ) = __$$GroupBuyRequestModelImplCopyWithImpl<$Res>;
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
class __$$GroupBuyRequestModelImplCopyWithImpl<$Res>
    extends _$GroupBuyRequestModelCopyWithImpl<$Res, _$GroupBuyRequestModelImpl>
    implements _$$GroupBuyRequestModelImplCopyWith<$Res> {
  __$$GroupBuyRequestModelImplCopyWithImpl(
    _$GroupBuyRequestModelImpl _value,
    $Res Function(_$GroupBuyRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupBuyRequestModel
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
      _$GroupBuyRequestModelImpl(
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

class _$GroupBuyRequestModelImpl extends _GroupBuyRequestModel {
  const _$GroupBuyRequestModelImpl({
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

  @override
  final String id;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final String description;
  @override
  final String brandOrStore;
  @override
  final int? estimatedPrice;
  @override
  final String? sourceUrl;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool wantsToJoin;
  @override
  final GroupBuyRequestStatus status;
  @override
  final String? adminNotes;
  @override
  final String? convertedGroupBuyId;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'GroupBuyRequestModel(id: $id, userId: $userId, userName: $userName, description: $description, brandOrStore: $brandOrStore, estimatedPrice: $estimatedPrice, sourceUrl: $sourceUrl, imageUrl: $imageUrl, wantsToJoin: $wantsToJoin, status: $status, adminNotes: $adminNotes, convertedGroupBuyId: $convertedGroupBuyId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupBuyRequestModelImpl &&
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

  /// Create a copy of GroupBuyRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupBuyRequestModelImplCopyWith<_$GroupBuyRequestModelImpl>
  get copyWith =>
      __$$GroupBuyRequestModelImplCopyWithImpl<_$GroupBuyRequestModelImpl>(
        this,
        _$identity,
      );
}

abstract class _GroupBuyRequestModel extends GroupBuyRequestModel {
  const factory _GroupBuyRequestModel({
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
  }) = _$GroupBuyRequestModelImpl;
  const _GroupBuyRequestModel._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String get userName;
  @override
  String get description;
  @override
  String get brandOrStore;
  @override
  int? get estimatedPrice;
  @override
  String? get sourceUrl;
  @override
  String? get imageUrl;
  @override
  bool get wantsToJoin;
  @override
  GroupBuyRequestStatus get status;
  @override
  String? get adminNotes;
  @override
  String? get convertedGroupBuyId;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of GroupBuyRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupBuyRequestModelImplCopyWith<_$GroupBuyRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
