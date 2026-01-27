// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campaign.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Campaign _$CampaignFromJson(Map<String, dynamic> json) {
  return _Campaign.fromJson(json);
}

/// @nodoc
mixin _$Campaign {
  String get id => throw _privateConstructorUsedError;
  String get brandId => throw _privateConstructorUsedError;
  String get brandName => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  CampaignType get type => throw _privateConstructorUsedError;
  CampaignStatus get status => throw _privateConstructorUsedError;
  int get totalBudgetTokens => throw _privateConstructorUsedError;
  int get remainingBudgetTokens => throw _privateConstructorUsedError;
  int get rewardPerEngagement => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get targetingCriteria =>
      throw _privateConstructorUsedError;
  int? get maxEngagementsPerUser => throw _privateConstructorUsedError;
  int? get totalEngagements => throw _privateConstructorUsedError;
  int? get uniqueUsers => throw _privateConstructorUsedError;
  double? get averageCompletionRate => throw _privateConstructorUsedError;

  /// Serializes this Campaign to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Campaign
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampaignCopyWith<Campaign> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampaignCopyWith<$Res> {
  factory $CampaignCopyWith(Campaign value, $Res Function(Campaign) then) =
      _$CampaignCopyWithImpl<$Res, Campaign>;
  @useResult
  $Res call({
    String id,
    String brandId,
    String brandName,
    String title,
    String description,
    CampaignType type,
    CampaignStatus status,
    int totalBudgetTokens,
    int remainingBudgetTokens,
    int rewardPerEngagement,
    DateTime startDate,
    DateTime endDate,
    DateTime createdAt,
    String? imageUrl,
    String? videoUrl,
    Map<String, dynamic>? targetingCriteria,
    int? maxEngagementsPerUser,
    int? totalEngagements,
    int? uniqueUsers,
    double? averageCompletionRate,
  });
}

/// @nodoc
class _$CampaignCopyWithImpl<$Res, $Val extends Campaign>
    implements $CampaignCopyWith<$Res> {
  _$CampaignCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Campaign
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brandId = null,
    Object? brandName = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? status = null,
    Object? totalBudgetTokens = null,
    Object? remainingBudgetTokens = null,
    Object? rewardPerEngagement = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? createdAt = null,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? targetingCriteria = freezed,
    Object? maxEngagementsPerUser = freezed,
    Object? totalEngagements = freezed,
    Object? uniqueUsers = freezed,
    Object? averageCompletionRate = freezed,
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
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CampaignType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CampaignStatus,
            totalBudgetTokens: null == totalBudgetTokens
                ? _value.totalBudgetTokens
                : totalBudgetTokens // ignore: cast_nullable_to_non_nullable
                      as int,
            remainingBudgetTokens: null == remainingBudgetTokens
                ? _value.remainingBudgetTokens
                : remainingBudgetTokens // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardPerEngagement: null == rewardPerEngagement
                ? _value.rewardPerEngagement
                : rewardPerEngagement // ignore: cast_nullable_to_non_nullable
                      as int,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            videoUrl: freezed == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            targetingCriteria: freezed == targetingCriteria
                ? _value.targetingCriteria
                : targetingCriteria // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            maxEngagementsPerUser: freezed == maxEngagementsPerUser
                ? _value.maxEngagementsPerUser
                : maxEngagementsPerUser // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalEngagements: freezed == totalEngagements
                ? _value.totalEngagements
                : totalEngagements // ignore: cast_nullable_to_non_nullable
                      as int?,
            uniqueUsers: freezed == uniqueUsers
                ? _value.uniqueUsers
                : uniqueUsers // ignore: cast_nullable_to_non_nullable
                      as int?,
            averageCompletionRate: freezed == averageCompletionRate
                ? _value.averageCompletionRate
                : averageCompletionRate // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CampaignImplCopyWith<$Res>
    implements $CampaignCopyWith<$Res> {
  factory _$$CampaignImplCopyWith(
    _$CampaignImpl value,
    $Res Function(_$CampaignImpl) then,
  ) = __$$CampaignImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String brandId,
    String brandName,
    String title,
    String description,
    CampaignType type,
    CampaignStatus status,
    int totalBudgetTokens,
    int remainingBudgetTokens,
    int rewardPerEngagement,
    DateTime startDate,
    DateTime endDate,
    DateTime createdAt,
    String? imageUrl,
    String? videoUrl,
    Map<String, dynamic>? targetingCriteria,
    int? maxEngagementsPerUser,
    int? totalEngagements,
    int? uniqueUsers,
    double? averageCompletionRate,
  });
}

/// @nodoc
class __$$CampaignImplCopyWithImpl<$Res>
    extends _$CampaignCopyWithImpl<$Res, _$CampaignImpl>
    implements _$$CampaignImplCopyWith<$Res> {
  __$$CampaignImplCopyWithImpl(
    _$CampaignImpl _value,
    $Res Function(_$CampaignImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Campaign
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brandId = null,
    Object? brandName = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? status = null,
    Object? totalBudgetTokens = null,
    Object? remainingBudgetTokens = null,
    Object? rewardPerEngagement = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? createdAt = null,
    Object? imageUrl = freezed,
    Object? videoUrl = freezed,
    Object? targetingCriteria = freezed,
    Object? maxEngagementsPerUser = freezed,
    Object? totalEngagements = freezed,
    Object? uniqueUsers = freezed,
    Object? averageCompletionRate = freezed,
  }) {
    return _then(
      _$CampaignImpl(
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
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CampaignType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CampaignStatus,
        totalBudgetTokens: null == totalBudgetTokens
            ? _value.totalBudgetTokens
            : totalBudgetTokens // ignore: cast_nullable_to_non_nullable
                  as int,
        remainingBudgetTokens: null == remainingBudgetTokens
            ? _value.remainingBudgetTokens
            : remainingBudgetTokens // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardPerEngagement: null == rewardPerEngagement
            ? _value.rewardPerEngagement
            : rewardPerEngagement // ignore: cast_nullable_to_non_nullable
                  as int,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        videoUrl: freezed == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        targetingCriteria: freezed == targetingCriteria
            ? _value._targetingCriteria
            : targetingCriteria // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        maxEngagementsPerUser: freezed == maxEngagementsPerUser
            ? _value.maxEngagementsPerUser
            : maxEngagementsPerUser // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalEngagements: freezed == totalEngagements
            ? _value.totalEngagements
            : totalEngagements // ignore: cast_nullable_to_non_nullable
                  as int?,
        uniqueUsers: freezed == uniqueUsers
            ? _value.uniqueUsers
            : uniqueUsers // ignore: cast_nullable_to_non_nullable
                  as int?,
        averageCompletionRate: freezed == averageCompletionRate
            ? _value.averageCompletionRate
            : averageCompletionRate // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CampaignImpl implements _Campaign {
  const _$CampaignImpl({
    required this.id,
    required this.brandId,
    required this.brandName,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.totalBudgetTokens,
    required this.remainingBudgetTokens,
    required this.rewardPerEngagement,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    this.imageUrl,
    this.videoUrl,
    final Map<String, dynamic>? targetingCriteria,
    this.maxEngagementsPerUser,
    this.totalEngagements,
    this.uniqueUsers,
    this.averageCompletionRate,
  }) : _targetingCriteria = targetingCriteria;

  factory _$CampaignImpl.fromJson(Map<String, dynamic> json) =>
      _$$CampaignImplFromJson(json);

  @override
  final String id;
  @override
  final String brandId;
  @override
  final String brandName;
  @override
  final String title;
  @override
  final String description;
  @override
  final CampaignType type;
  @override
  final CampaignStatus status;
  @override
  final int totalBudgetTokens;
  @override
  final int remainingBudgetTokens;
  @override
  final int rewardPerEngagement;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final DateTime createdAt;
  @override
  final String? imageUrl;
  @override
  final String? videoUrl;
  final Map<String, dynamic>? _targetingCriteria;
  @override
  Map<String, dynamic>? get targetingCriteria {
    final value = _targetingCriteria;
    if (value == null) return null;
    if (_targetingCriteria is EqualUnmodifiableMapView)
      return _targetingCriteria;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? maxEngagementsPerUser;
  @override
  final int? totalEngagements;
  @override
  final int? uniqueUsers;
  @override
  final double? averageCompletionRate;

  @override
  String toString() {
    return 'Campaign(id: $id, brandId: $brandId, brandName: $brandName, title: $title, description: $description, type: $type, status: $status, totalBudgetTokens: $totalBudgetTokens, remainingBudgetTokens: $remainingBudgetTokens, rewardPerEngagement: $rewardPerEngagement, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, imageUrl: $imageUrl, videoUrl: $videoUrl, targetingCriteria: $targetingCriteria, maxEngagementsPerUser: $maxEngagementsPerUser, totalEngagements: $totalEngagements, uniqueUsers: $uniqueUsers, averageCompletionRate: $averageCompletionRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampaignImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalBudgetTokens, totalBudgetTokens) ||
                other.totalBudgetTokens == totalBudgetTokens) &&
            (identical(other.remainingBudgetTokens, remainingBudgetTokens) ||
                other.remainingBudgetTokens == remainingBudgetTokens) &&
            (identical(other.rewardPerEngagement, rewardPerEngagement) ||
                other.rewardPerEngagement == rewardPerEngagement) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            const DeepCollectionEquality().equals(
              other._targetingCriteria,
              _targetingCriteria,
            ) &&
            (identical(other.maxEngagementsPerUser, maxEngagementsPerUser) ||
                other.maxEngagementsPerUser == maxEngagementsPerUser) &&
            (identical(other.totalEngagements, totalEngagements) ||
                other.totalEngagements == totalEngagements) &&
            (identical(other.uniqueUsers, uniqueUsers) ||
                other.uniqueUsers == uniqueUsers) &&
            (identical(other.averageCompletionRate, averageCompletionRate) ||
                other.averageCompletionRate == averageCompletionRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    brandId,
    brandName,
    title,
    description,
    type,
    status,
    totalBudgetTokens,
    remainingBudgetTokens,
    rewardPerEngagement,
    startDate,
    endDate,
    createdAt,
    imageUrl,
    videoUrl,
    const DeepCollectionEquality().hash(_targetingCriteria),
    maxEngagementsPerUser,
    totalEngagements,
    uniqueUsers,
    averageCompletionRate,
  ]);

  /// Create a copy of Campaign
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampaignImplCopyWith<_$CampaignImpl> get copyWith =>
      __$$CampaignImplCopyWithImpl<_$CampaignImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CampaignImplToJson(this);
  }
}

abstract class _Campaign implements Campaign {
  const factory _Campaign({
    required final String id,
    required final String brandId,
    required final String brandName,
    required final String title,
    required final String description,
    required final CampaignType type,
    required final CampaignStatus status,
    required final int totalBudgetTokens,
    required final int remainingBudgetTokens,
    required final int rewardPerEngagement,
    required final DateTime startDate,
    required final DateTime endDate,
    required final DateTime createdAt,
    final String? imageUrl,
    final String? videoUrl,
    final Map<String, dynamic>? targetingCriteria,
    final int? maxEngagementsPerUser,
    final int? totalEngagements,
    final int? uniqueUsers,
    final double? averageCompletionRate,
  }) = _$CampaignImpl;

  factory _Campaign.fromJson(Map<String, dynamic> json) =
      _$CampaignImpl.fromJson;

  @override
  String get id;
  @override
  String get brandId;
  @override
  String get brandName;
  @override
  String get title;
  @override
  String get description;
  @override
  CampaignType get type;
  @override
  CampaignStatus get status;
  @override
  int get totalBudgetTokens;
  @override
  int get remainingBudgetTokens;
  @override
  int get rewardPerEngagement;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  DateTime get createdAt;
  @override
  String? get imageUrl;
  @override
  String? get videoUrl;
  @override
  Map<String, dynamic>? get targetingCriteria;
  @override
  int? get maxEngagementsPerUser;
  @override
  int? get totalEngagements;
  @override
  int? get uniqueUsers;
  @override
  double? get averageCompletionRate;

  /// Create a copy of Campaign
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampaignImplCopyWith<_$CampaignImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
