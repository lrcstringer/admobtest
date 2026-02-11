// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_campaign_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RewardCampaignModel {
  String get id => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  String? get clientAvatarImage => throw _privateConstructorUsedError;
  String? get clientAvatarColor => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get rewardType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get totalQuantity => throw _privateConstructorUsedError;
  int get remainingQuantity => throw _privateConstructorUsedError;
  int get allocatedQuantity => throw _privateConstructorUsedError;
  int get redeemedQuantity => throw _privateConstructorUsedError;
  int get maxPerUser => throw _privateConstructorUsedError;
  DateTime get startsAt => throw _privateConstructorUsedError;
  DateTime get endsAt => throw _privateConstructorUsedError;
  DateTime? get itemExpiresAt => throw _privateConstructorUsedError;
  String? get displayImageUrl => throw _privateConstructorUsedError;
  int get displayPriority => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  List<String> get linkedOpportunityIds => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of RewardCampaignModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RewardCampaignModelCopyWith<RewardCampaignModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardCampaignModelCopyWith<$Res> {
  factory $RewardCampaignModelCopyWith(
    RewardCampaignModel value,
    $Res Function(RewardCampaignModel) then,
  ) = _$RewardCampaignModelCopyWithImpl<$Res, RewardCampaignModel>;
  @useResult
  $Res call({
    String id,
    String clientId,
    String? clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    String name,
    String? description,
    String rewardType,
    String status,
    int totalQuantity,
    int remainingQuantity,
    int allocatedQuantity,
    int redeemedQuantity,
    int maxPerUser,
    DateTime startsAt,
    DateTime endsAt,
    DateTime? itemExpiresAt,
    String? displayImageUrl,
    int displayPriority,
    Map<String, dynamic> metadata,
    List<String> linkedOpportunityIds,
    DateTime createdAt,
  });
}

/// @nodoc
class _$RewardCampaignModelCopyWithImpl<$Res, $Val extends RewardCampaignModel>
    implements $RewardCampaignModelCopyWith<$Res> {
  _$RewardCampaignModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RewardCampaignModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? clientName = freezed,
    Object? clientAvatarImage = freezed,
    Object? clientAvatarColor = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? rewardType = null,
    Object? status = null,
    Object? totalQuantity = null,
    Object? remainingQuantity = null,
    Object? allocatedQuantity = null,
    Object? redeemedQuantity = null,
    Object? maxPerUser = null,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? itemExpiresAt = freezed,
    Object? displayImageUrl = freezed,
    Object? displayPriority = null,
    Object? metadata = null,
    Object? linkedOpportunityIds = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String,
            clientName: freezed == clientName
                ? _value.clientName
                : clientName // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientAvatarImage: freezed == clientAvatarImage
                ? _value.clientAvatarImage
                : clientAvatarImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            clientAvatarColor: freezed == clientAvatarColor
                ? _value.clientAvatarColor
                : clientAvatarColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            rewardType: null == rewardType
                ? _value.rewardType
                : rewardType // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            totalQuantity: null == totalQuantity
                ? _value.totalQuantity
                : totalQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            remainingQuantity: null == remainingQuantity
                ? _value.remainingQuantity
                : remainingQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            allocatedQuantity: null == allocatedQuantity
                ? _value.allocatedQuantity
                : allocatedQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            redeemedQuantity: null == redeemedQuantity
                ? _value.redeemedQuantity
                : redeemedQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            maxPerUser: null == maxPerUser
                ? _value.maxPerUser
                : maxPerUser // ignore: cast_nullable_to_non_nullable
                      as int,
            startsAt: null == startsAt
                ? _value.startsAt
                : startsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endsAt: null == endsAt
                ? _value.endsAt
                : endsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            itemExpiresAt: freezed == itemExpiresAt
                ? _value.itemExpiresAt
                : itemExpiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            displayImageUrl: freezed == displayImageUrl
                ? _value.displayImageUrl
                : displayImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayPriority: null == displayPriority
                ? _value.displayPriority
                : displayPriority // ignore: cast_nullable_to_non_nullable
                      as int,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            linkedOpportunityIds: null == linkedOpportunityIds
                ? _value.linkedOpportunityIds
                : linkedOpportunityIds // ignore: cast_nullable_to_non_nullable
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
abstract class _$$RewardCampaignModelImplCopyWith<$Res>
    implements $RewardCampaignModelCopyWith<$Res> {
  factory _$$RewardCampaignModelImplCopyWith(
    _$RewardCampaignModelImpl value,
    $Res Function(_$RewardCampaignModelImpl) then,
  ) = __$$RewardCampaignModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String clientId,
    String? clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    String name,
    String? description,
    String rewardType,
    String status,
    int totalQuantity,
    int remainingQuantity,
    int allocatedQuantity,
    int redeemedQuantity,
    int maxPerUser,
    DateTime startsAt,
    DateTime endsAt,
    DateTime? itemExpiresAt,
    String? displayImageUrl,
    int displayPriority,
    Map<String, dynamic> metadata,
    List<String> linkedOpportunityIds,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$RewardCampaignModelImplCopyWithImpl<$Res>
    extends _$RewardCampaignModelCopyWithImpl<$Res, _$RewardCampaignModelImpl>
    implements _$$RewardCampaignModelImplCopyWith<$Res> {
  __$$RewardCampaignModelImplCopyWithImpl(
    _$RewardCampaignModelImpl _value,
    $Res Function(_$RewardCampaignModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardCampaignModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? clientName = freezed,
    Object? clientAvatarImage = freezed,
    Object? clientAvatarColor = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? rewardType = null,
    Object? status = null,
    Object? totalQuantity = null,
    Object? remainingQuantity = null,
    Object? allocatedQuantity = null,
    Object? redeemedQuantity = null,
    Object? maxPerUser = null,
    Object? startsAt = null,
    Object? endsAt = null,
    Object? itemExpiresAt = freezed,
    Object? displayImageUrl = freezed,
    Object? displayPriority = null,
    Object? metadata = null,
    Object? linkedOpportunityIds = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$RewardCampaignModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        clientName: freezed == clientName
            ? _value.clientName
            : clientName // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientAvatarImage: freezed == clientAvatarImage
            ? _value.clientAvatarImage
            : clientAvatarImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        clientAvatarColor: freezed == clientAvatarColor
            ? _value.clientAvatarColor
            : clientAvatarColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        rewardType: null == rewardType
            ? _value.rewardType
            : rewardType // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        totalQuantity: null == totalQuantity
            ? _value.totalQuantity
            : totalQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        remainingQuantity: null == remainingQuantity
            ? _value.remainingQuantity
            : remainingQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        allocatedQuantity: null == allocatedQuantity
            ? _value.allocatedQuantity
            : allocatedQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        redeemedQuantity: null == redeemedQuantity
            ? _value.redeemedQuantity
            : redeemedQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        maxPerUser: null == maxPerUser
            ? _value.maxPerUser
            : maxPerUser // ignore: cast_nullable_to_non_nullable
                  as int,
        startsAt: null == startsAt
            ? _value.startsAt
            : startsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endsAt: null == endsAt
            ? _value.endsAt
            : endsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        itemExpiresAt: freezed == itemExpiresAt
            ? _value.itemExpiresAt
            : itemExpiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        displayImageUrl: freezed == displayImageUrl
            ? _value.displayImageUrl
            : displayImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayPriority: null == displayPriority
            ? _value.displayPriority
            : displayPriority // ignore: cast_nullable_to_non_nullable
                  as int,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        linkedOpportunityIds: null == linkedOpportunityIds
            ? _value._linkedOpportunityIds
            : linkedOpportunityIds // ignore: cast_nullable_to_non_nullable
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

class _$RewardCampaignModelImpl extends _RewardCampaignModel {
  const _$RewardCampaignModelImpl({
    required this.id,
    required this.clientId,
    this.clientName,
    this.clientAvatarImage,
    this.clientAvatarColor,
    required this.name,
    this.description,
    required this.rewardType,
    required this.status,
    required this.totalQuantity,
    required this.remainingQuantity,
    this.allocatedQuantity = 0,
    this.redeemedQuantity = 0,
    this.maxPerUser = 1,
    required this.startsAt,
    required this.endsAt,
    this.itemExpiresAt,
    this.displayImageUrl,
    this.displayPriority = 0,
    final Map<String, dynamic> metadata = const {},
    final List<String> linkedOpportunityIds = const [],
    required this.createdAt,
  }) : _metadata = metadata,
       _linkedOpportunityIds = linkedOpportunityIds,
       super._();

  @override
  final String id;
  @override
  final String clientId;
  @override
  final String? clientName;
  @override
  final String? clientAvatarImage;
  @override
  final String? clientAvatarColor;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String rewardType;
  @override
  final String status;
  @override
  final int totalQuantity;
  @override
  final int remainingQuantity;
  @override
  @JsonKey()
  final int allocatedQuantity;
  @override
  @JsonKey()
  final int redeemedQuantity;
  @override
  @JsonKey()
  final int maxPerUser;
  @override
  final DateTime startsAt;
  @override
  final DateTime endsAt;
  @override
  final DateTime? itemExpiresAt;
  @override
  final String? displayImageUrl;
  @override
  @JsonKey()
  final int displayPriority;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  final List<String> _linkedOpportunityIds;
  @override
  @JsonKey()
  List<String> get linkedOpportunityIds {
    if (_linkedOpportunityIds is EqualUnmodifiableListView)
      return _linkedOpportunityIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_linkedOpportunityIds);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'RewardCampaignModel(id: $id, clientId: $clientId, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, name: $name, description: $description, rewardType: $rewardType, status: $status, totalQuantity: $totalQuantity, remainingQuantity: $remainingQuantity, allocatedQuantity: $allocatedQuantity, redeemedQuantity: $redeemedQuantity, maxPerUser: $maxPerUser, startsAt: $startsAt, endsAt: $endsAt, itemExpiresAt: $itemExpiresAt, displayImageUrl: $displayImageUrl, displayPriority: $displayPriority, metadata: $metadata, linkedOpportunityIds: $linkedOpportunityIds, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RewardCampaignModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clientAvatarImage, clientAvatarImage) ||
                other.clientAvatarImage == clientAvatarImage) &&
            (identical(other.clientAvatarColor, clientAvatarColor) ||
                other.clientAvatarColor == clientAvatarColor) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rewardType, rewardType) ||
                other.rewardType == rewardType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.remainingQuantity, remainingQuantity) ||
                other.remainingQuantity == remainingQuantity) &&
            (identical(other.allocatedQuantity, allocatedQuantity) ||
                other.allocatedQuantity == allocatedQuantity) &&
            (identical(other.redeemedQuantity, redeemedQuantity) ||
                other.redeemedQuantity == redeemedQuantity) &&
            (identical(other.maxPerUser, maxPerUser) ||
                other.maxPerUser == maxPerUser) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.itemExpiresAt, itemExpiresAt) ||
                other.itemExpiresAt == itemExpiresAt) &&
            (identical(other.displayImageUrl, displayImageUrl) ||
                other.displayImageUrl == displayImageUrl) &&
            (identical(other.displayPriority, displayPriority) ||
                other.displayPriority == displayPriority) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality().equals(
              other._linkedOpportunityIds,
              _linkedOpportunityIds,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    clientId,
    clientName,
    clientAvatarImage,
    clientAvatarColor,
    name,
    description,
    rewardType,
    status,
    totalQuantity,
    remainingQuantity,
    allocatedQuantity,
    redeemedQuantity,
    maxPerUser,
    startsAt,
    endsAt,
    itemExpiresAt,
    displayImageUrl,
    displayPriority,
    const DeepCollectionEquality().hash(_metadata),
    const DeepCollectionEquality().hash(_linkedOpportunityIds),
    createdAt,
  ]);

  /// Create a copy of RewardCampaignModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RewardCampaignModelImplCopyWith<_$RewardCampaignModelImpl> get copyWith =>
      __$$RewardCampaignModelImplCopyWithImpl<_$RewardCampaignModelImpl>(
        this,
        _$identity,
      );
}

abstract class _RewardCampaignModel extends RewardCampaignModel {
  const factory _RewardCampaignModel({
    required final String id,
    required final String clientId,
    final String? clientName,
    final String? clientAvatarImage,
    final String? clientAvatarColor,
    required final String name,
    final String? description,
    required final String rewardType,
    required final String status,
    required final int totalQuantity,
    required final int remainingQuantity,
    final int allocatedQuantity,
    final int redeemedQuantity,
    final int maxPerUser,
    required final DateTime startsAt,
    required final DateTime endsAt,
    final DateTime? itemExpiresAt,
    final String? displayImageUrl,
    final int displayPriority,
    final Map<String, dynamic> metadata,
    final List<String> linkedOpportunityIds,
    required final DateTime createdAt,
  }) = _$RewardCampaignModelImpl;
  const _RewardCampaignModel._() : super._();

  @override
  String get id;
  @override
  String get clientId;
  @override
  String? get clientName;
  @override
  String? get clientAvatarImage;
  @override
  String? get clientAvatarColor;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get rewardType;
  @override
  String get status;
  @override
  int get totalQuantity;
  @override
  int get remainingQuantity;
  @override
  int get allocatedQuantity;
  @override
  int get redeemedQuantity;
  @override
  int get maxPerUser;
  @override
  DateTime get startsAt;
  @override
  DateTime get endsAt;
  @override
  DateTime? get itemExpiresAt;
  @override
  String? get displayImageUrl;
  @override
  int get displayPriority;
  @override
  Map<String, dynamic> get metadata;
  @override
  List<String> get linkedOpportunityIds;
  @override
  DateTime get createdAt;

  /// Create a copy of RewardCampaignModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RewardCampaignModelImplCopyWith<_$RewardCampaignModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
