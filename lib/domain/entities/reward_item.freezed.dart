// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RewardItem _$RewardItemFromJson(Map<String, dynamic> json) {
  return _RewardItem.fromJson(json);
}

/// @nodoc
mixin _$RewardItem {
  String get id => throw _privateConstructorUsedError;
  String get campaignId =>
      throw _privateConstructorUsedError; // Denormalized campaign info (for list display without extra reads)
  String? get campaignName => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  String? get clientAvatarImage => throw _privateConstructorUsedError;
  String? get clientAvatarColor => throw _privateConstructorUsedError;
  RewardType? get rewardType => throw _privateConstructorUsedError;
  RewardItemStatus get status =>
      throw _privateConstructorUsedError; // Only populated on detail fetch (decrypted server-side)
  String? get codeValue => throw _privateConstructorUsedError;
  DateTime? get allocatedAt => throw _privateConstructorUsedError;
  DateTime? get redeemedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  String? get redemptionLocation =>
      throw _privateConstructorUsedError; // Campaign-level metadata (instructions, terms, etc.)
  Map<String, dynamic> get campaignMetadata =>
      throw _privateConstructorUsedError; // Item-level metadata (batch, face value, etc.)
  Map<String, dynamic> get itemMetadata => throw _privateConstructorUsedError;

  /// Serializes this RewardItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RewardItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RewardItemCopyWith<RewardItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardItemCopyWith<$Res> {
  factory $RewardItemCopyWith(
    RewardItem value,
    $Res Function(RewardItem) then,
  ) = _$RewardItemCopyWithImpl<$Res, RewardItem>;
  @useResult
  $Res call({
    String id,
    String campaignId,
    String? campaignName,
    String? clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    RewardType? rewardType,
    RewardItemStatus status,
    String? codeValue,
    DateTime? allocatedAt,
    DateTime? redeemedAt,
    DateTime? expiresAt,
    String? redemptionLocation,
    Map<String, dynamic> campaignMetadata,
    Map<String, dynamic> itemMetadata,
  });
}

/// @nodoc
class _$RewardItemCopyWithImpl<$Res, $Val extends RewardItem>
    implements $RewardItemCopyWith<$Res> {
  _$RewardItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RewardItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? campaignName = freezed,
    Object? clientName = freezed,
    Object? clientAvatarImage = freezed,
    Object? clientAvatarColor = freezed,
    Object? rewardType = freezed,
    Object? status = null,
    Object? codeValue = freezed,
    Object? allocatedAt = freezed,
    Object? redeemedAt = freezed,
    Object? expiresAt = freezed,
    Object? redemptionLocation = freezed,
    Object? campaignMetadata = null,
    Object? itemMetadata = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            campaignId: null == campaignId
                ? _value.campaignId
                : campaignId // ignore: cast_nullable_to_non_nullable
                      as String,
            campaignName: freezed == campaignName
                ? _value.campaignName
                : campaignName // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            rewardType: freezed == rewardType
                ? _value.rewardType
                : rewardType // ignore: cast_nullable_to_non_nullable
                      as RewardType?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RewardItemStatus,
            codeValue: freezed == codeValue
                ? _value.codeValue
                : codeValue // ignore: cast_nullable_to_non_nullable
                      as String?,
            allocatedAt: freezed == allocatedAt
                ? _value.allocatedAt
                : allocatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            redeemedAt: freezed == redeemedAt
                ? _value.redeemedAt
                : redeemedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            redemptionLocation: freezed == redemptionLocation
                ? _value.redemptionLocation
                : redemptionLocation // ignore: cast_nullable_to_non_nullable
                      as String?,
            campaignMetadata: null == campaignMetadata
                ? _value.campaignMetadata
                : campaignMetadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            itemMetadata: null == itemMetadata
                ? _value.itemMetadata
                : itemMetadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RewardItemImplCopyWith<$Res>
    implements $RewardItemCopyWith<$Res> {
  factory _$$RewardItemImplCopyWith(
    _$RewardItemImpl value,
    $Res Function(_$RewardItemImpl) then,
  ) = __$$RewardItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String campaignId,
    String? campaignName,
    String? clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    RewardType? rewardType,
    RewardItemStatus status,
    String? codeValue,
    DateTime? allocatedAt,
    DateTime? redeemedAt,
    DateTime? expiresAt,
    String? redemptionLocation,
    Map<String, dynamic> campaignMetadata,
    Map<String, dynamic> itemMetadata,
  });
}

/// @nodoc
class __$$RewardItemImplCopyWithImpl<$Res>
    extends _$RewardItemCopyWithImpl<$Res, _$RewardItemImpl>
    implements _$$RewardItemImplCopyWith<$Res> {
  __$$RewardItemImplCopyWithImpl(
    _$RewardItemImpl _value,
    $Res Function(_$RewardItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RewardItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? campaignName = freezed,
    Object? clientName = freezed,
    Object? clientAvatarImage = freezed,
    Object? clientAvatarColor = freezed,
    Object? rewardType = freezed,
    Object? status = null,
    Object? codeValue = freezed,
    Object? allocatedAt = freezed,
    Object? redeemedAt = freezed,
    Object? expiresAt = freezed,
    Object? redemptionLocation = freezed,
    Object? campaignMetadata = null,
    Object? itemMetadata = null,
  }) {
    return _then(
      _$RewardItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        campaignId: null == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String,
        campaignName: freezed == campaignName
            ? _value.campaignName
            : campaignName // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        rewardType: freezed == rewardType
            ? _value.rewardType
            : rewardType // ignore: cast_nullable_to_non_nullable
                  as RewardType?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RewardItemStatus,
        codeValue: freezed == codeValue
            ? _value.codeValue
            : codeValue // ignore: cast_nullable_to_non_nullable
                  as String?,
        allocatedAt: freezed == allocatedAt
            ? _value.allocatedAt
            : allocatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        redeemedAt: freezed == redeemedAt
            ? _value.redeemedAt
            : redeemedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        redemptionLocation: freezed == redemptionLocation
            ? _value.redemptionLocation
            : redemptionLocation // ignore: cast_nullable_to_non_nullable
                  as String?,
        campaignMetadata: null == campaignMetadata
            ? _value._campaignMetadata
            : campaignMetadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        itemMetadata: null == itemMetadata
            ? _value._itemMetadata
            : itemMetadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RewardItemImpl extends _RewardItem {
  const _$RewardItemImpl({
    required this.id,
    required this.campaignId,
    this.campaignName,
    this.clientName,
    this.clientAvatarImage,
    this.clientAvatarColor,
    this.rewardType,
    required this.status,
    this.codeValue,
    this.allocatedAt,
    this.redeemedAt,
    this.expiresAt,
    this.redemptionLocation,
    final Map<String, dynamic> campaignMetadata = const {},
    final Map<String, dynamic> itemMetadata = const {},
  }) : _campaignMetadata = campaignMetadata,
       _itemMetadata = itemMetadata,
       super._();

  factory _$RewardItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$RewardItemImplFromJson(json);

  @override
  final String id;
  @override
  final String campaignId;
  // Denormalized campaign info (for list display without extra reads)
  @override
  final String? campaignName;
  @override
  final String? clientName;
  @override
  final String? clientAvatarImage;
  @override
  final String? clientAvatarColor;
  @override
  final RewardType? rewardType;
  @override
  final RewardItemStatus status;
  // Only populated on detail fetch (decrypted server-side)
  @override
  final String? codeValue;
  @override
  final DateTime? allocatedAt;
  @override
  final DateTime? redeemedAt;
  @override
  final DateTime? expiresAt;
  @override
  final String? redemptionLocation;
  // Campaign-level metadata (instructions, terms, etc.)
  final Map<String, dynamic> _campaignMetadata;
  // Campaign-level metadata (instructions, terms, etc.)
  @override
  @JsonKey()
  Map<String, dynamic> get campaignMetadata {
    if (_campaignMetadata is EqualUnmodifiableMapView) return _campaignMetadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_campaignMetadata);
  }

  // Item-level metadata (batch, face value, etc.)
  final Map<String, dynamic> _itemMetadata;
  // Item-level metadata (batch, face value, etc.)
  @override
  @JsonKey()
  Map<String, dynamic> get itemMetadata {
    if (_itemMetadata is EqualUnmodifiableMapView) return _itemMetadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_itemMetadata);
  }

  @override
  String toString() {
    return 'RewardItem(id: $id, campaignId: $campaignId, campaignName: $campaignName, clientName: $clientName, clientAvatarImage: $clientAvatarImage, clientAvatarColor: $clientAvatarColor, rewardType: $rewardType, status: $status, codeValue: $codeValue, allocatedAt: $allocatedAt, redeemedAt: $redeemedAt, expiresAt: $expiresAt, redemptionLocation: $redemptionLocation, campaignMetadata: $campaignMetadata, itemMetadata: $itemMetadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RewardItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.campaignName, campaignName) ||
                other.campaignName == campaignName) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.clientAvatarImage, clientAvatarImage) ||
                other.clientAvatarImage == clientAvatarImage) &&
            (identical(other.clientAvatarColor, clientAvatarColor) ||
                other.clientAvatarColor == clientAvatarColor) &&
            (identical(other.rewardType, rewardType) ||
                other.rewardType == rewardType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.codeValue, codeValue) ||
                other.codeValue == codeValue) &&
            (identical(other.allocatedAt, allocatedAt) ||
                other.allocatedAt == allocatedAt) &&
            (identical(other.redeemedAt, redeemedAt) ||
                other.redeemedAt == redeemedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.redemptionLocation, redemptionLocation) ||
                other.redemptionLocation == redemptionLocation) &&
            const DeepCollectionEquality().equals(
              other._campaignMetadata,
              _campaignMetadata,
            ) &&
            const DeepCollectionEquality().equals(
              other._itemMetadata,
              _itemMetadata,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    campaignId,
    campaignName,
    clientName,
    clientAvatarImage,
    clientAvatarColor,
    rewardType,
    status,
    codeValue,
    allocatedAt,
    redeemedAt,
    expiresAt,
    redemptionLocation,
    const DeepCollectionEquality().hash(_campaignMetadata),
    const DeepCollectionEquality().hash(_itemMetadata),
  );

  /// Create a copy of RewardItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RewardItemImplCopyWith<_$RewardItemImpl> get copyWith =>
      __$$RewardItemImplCopyWithImpl<_$RewardItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RewardItemImplToJson(this);
  }
}

abstract class _RewardItem extends RewardItem {
  const factory _RewardItem({
    required final String id,
    required final String campaignId,
    final String? campaignName,
    final String? clientName,
    final String? clientAvatarImage,
    final String? clientAvatarColor,
    final RewardType? rewardType,
    required final RewardItemStatus status,
    final String? codeValue,
    final DateTime? allocatedAt,
    final DateTime? redeemedAt,
    final DateTime? expiresAt,
    final String? redemptionLocation,
    final Map<String, dynamic> campaignMetadata,
    final Map<String, dynamic> itemMetadata,
  }) = _$RewardItemImpl;
  const _RewardItem._() : super._();

  factory _RewardItem.fromJson(Map<String, dynamic> json) =
      _$RewardItemImpl.fromJson;

  @override
  String get id;
  @override
  String get campaignId; // Denormalized campaign info (for list display without extra reads)
  @override
  String? get campaignName;
  @override
  String? get clientName;
  @override
  String? get clientAvatarImage;
  @override
  String? get clientAvatarColor;
  @override
  RewardType? get rewardType;
  @override
  RewardItemStatus get status; // Only populated on detail fetch (decrypted server-side)
  @override
  String? get codeValue;
  @override
  DateTime? get allocatedAt;
  @override
  DateTime? get redeemedAt;
  @override
  DateTime? get expiresAt;
  @override
  String? get redemptionLocation; // Campaign-level metadata (instructions, terms, etc.)
  @override
  Map<String, dynamic> get campaignMetadata; // Item-level metadata (batch, face value, etc.)
  @override
  Map<String, dynamic> get itemMetadata;

  /// Create a copy of RewardItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RewardItemImplCopyWith<_$RewardItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
