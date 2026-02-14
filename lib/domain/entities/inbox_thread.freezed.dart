// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InboxThread _$InboxThreadFromJson(Map<String, dynamic> json) {
  return _InboxThread.fromJson(json);
}

/// @nodoc
mixin _$InboxThread {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get threadImage => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  DateTime? get activeTo => throw _privateConstructorUsedError;
  int get availableOpportunities => throw _privateConstructorUsedError;
  int get totalTokenReward => throw _privateConstructorUsedError;
  List<String> get rewardTypes => throw _privateConstructorUsedError;
  List<String> get earningTypes => throw _privateConstructorUsedError;
  int get estimatedDurationSeconds => throw _privateConstructorUsedError;
  List<String> get opportunityIds => throw _privateConstructorUsedError;
  bool get hasRewardCampaign => throw _privateConstructorUsedError;
  DateTime? get soonestExpiry => throw _privateConstructorUsedError;

  /// Serializes this InboxThread to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InboxThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InboxThreadCopyWith<InboxThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxThreadCopyWith<$Res> {
  factory $InboxThreadCopyWith(
    InboxThread value,
    $Res Function(InboxThread) then,
  ) = _$InboxThreadCopyWithImpl<$Res, InboxThread>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String? threadImage,
    bool isPinned,
    bool isFeatured,
    DateTime? activeTo,
    int availableOpportunities,
    int totalTokenReward,
    List<String> rewardTypes,
    List<String> earningTypes,
    int estimatedDurationSeconds,
    List<String> opportunityIds,
    bool hasRewardCampaign,
    DateTime? soonestExpiry,
  });
}

/// @nodoc
class _$InboxThreadCopyWithImpl<$Res, $Val extends InboxThread>
    implements $InboxThreadCopyWith<$Res> {
  _$InboxThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InboxThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? threadImage = freezed,
    Object? isPinned = null,
    Object? isFeatured = null,
    Object? activeTo = freezed,
    Object? availableOpportunities = null,
    Object? totalTokenReward = null,
    Object? rewardTypes = null,
    Object? earningTypes = null,
    Object? estimatedDurationSeconds = null,
    Object? opportunityIds = null,
    Object? hasRewardCampaign = null,
    Object? soonestExpiry = freezed,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            threadImage: freezed == threadImage
                ? _value.threadImage
                : threadImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            activeTo: freezed == activeTo
                ? _value.activeTo
                : activeTo // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            availableOpportunities: null == availableOpportunities
                ? _value.availableOpportunities
                : availableOpportunities // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTokenReward: null == totalTokenReward
                ? _value.totalTokenReward
                : totalTokenReward // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardTypes: null == rewardTypes
                ? _value.rewardTypes
                : rewardTypes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            earningTypes: null == earningTypes
                ? _value.earningTypes
                : earningTypes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            estimatedDurationSeconds: null == estimatedDurationSeconds
                ? _value.estimatedDurationSeconds
                : estimatedDurationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            opportunityIds: null == opportunityIds
                ? _value.opportunityIds
                : opportunityIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            hasRewardCampaign: null == hasRewardCampaign
                ? _value.hasRewardCampaign
                : hasRewardCampaign // ignore: cast_nullable_to_non_nullable
                      as bool,
            soonestExpiry: freezed == soonestExpiry
                ? _value.soonestExpiry
                : soonestExpiry // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InboxThreadImplCopyWith<$Res>
    implements $InboxThreadCopyWith<$Res> {
  factory _$$InboxThreadImplCopyWith(
    _$InboxThreadImpl value,
    $Res Function(_$InboxThreadImpl) then,
  ) = __$$InboxThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String? threadImage,
    bool isPinned,
    bool isFeatured,
    DateTime? activeTo,
    int availableOpportunities,
    int totalTokenReward,
    List<String> rewardTypes,
    List<String> earningTypes,
    int estimatedDurationSeconds,
    List<String> opportunityIds,
    bool hasRewardCampaign,
    DateTime? soonestExpiry,
  });
}

/// @nodoc
class __$$InboxThreadImplCopyWithImpl<$Res>
    extends _$InboxThreadCopyWithImpl<$Res, _$InboxThreadImpl>
    implements _$$InboxThreadImplCopyWith<$Res> {
  __$$InboxThreadImplCopyWithImpl(
    _$InboxThreadImpl _value,
    $Res Function(_$InboxThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InboxThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? threadImage = freezed,
    Object? isPinned = null,
    Object? isFeatured = null,
    Object? activeTo = freezed,
    Object? availableOpportunities = null,
    Object? totalTokenReward = null,
    Object? rewardTypes = null,
    Object? earningTypes = null,
    Object? estimatedDurationSeconds = null,
    Object? opportunityIds = null,
    Object? hasRewardCampaign = null,
    Object? soonestExpiry = freezed,
  }) {
    return _then(
      _$InboxThreadImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        threadImage: freezed == threadImage
            ? _value.threadImage
            : threadImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        activeTo: freezed == activeTo
            ? _value.activeTo
            : activeTo // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        availableOpportunities: null == availableOpportunities
            ? _value.availableOpportunities
            : availableOpportunities // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTokenReward: null == totalTokenReward
            ? _value.totalTokenReward
            : totalTokenReward // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardTypes: null == rewardTypes
            ? _value._rewardTypes
            : rewardTypes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        earningTypes: null == earningTypes
            ? _value._earningTypes
            : earningTypes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        estimatedDurationSeconds: null == estimatedDurationSeconds
            ? _value.estimatedDurationSeconds
            : estimatedDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        opportunityIds: null == opportunityIds
            ? _value._opportunityIds
            : opportunityIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        hasRewardCampaign: null == hasRewardCampaign
            ? _value.hasRewardCampaign
            : hasRewardCampaign // ignore: cast_nullable_to_non_nullable
                  as bool,
        soonestExpiry: freezed == soonestExpiry
            ? _value.soonestExpiry
            : soonestExpiry // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InboxThreadImpl extends _InboxThread {
  const _$InboxThreadImpl({
    required this.id,
    required this.title,
    this.description,
    this.threadImage,
    required this.isPinned,
    required this.isFeatured,
    this.activeTo,
    required this.availableOpportunities,
    required this.totalTokenReward,
    final List<String> rewardTypes = const [],
    final List<String> earningTypes = const [],
    this.estimatedDurationSeconds = 0,
    final List<String> opportunityIds = const [],
    this.hasRewardCampaign = false,
    this.soonestExpiry,
  }) : _rewardTypes = rewardTypes,
       _earningTypes = earningTypes,
       _opportunityIds = opportunityIds,
       super._();

  factory _$InboxThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$InboxThreadImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? threadImage;
  @override
  final bool isPinned;
  @override
  final bool isFeatured;
  @override
  final DateTime? activeTo;
  @override
  final int availableOpportunities;
  @override
  final int totalTokenReward;
  final List<String> _rewardTypes;
  @override
  @JsonKey()
  List<String> get rewardTypes {
    if (_rewardTypes is EqualUnmodifiableListView) return _rewardTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rewardTypes);
  }

  final List<String> _earningTypes;
  @override
  @JsonKey()
  List<String> get earningTypes {
    if (_earningTypes is EqualUnmodifiableListView) return _earningTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earningTypes);
  }

  @override
  @JsonKey()
  final int estimatedDurationSeconds;
  final List<String> _opportunityIds;
  @override
  @JsonKey()
  List<String> get opportunityIds {
    if (_opportunityIds is EqualUnmodifiableListView) return _opportunityIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opportunityIds);
  }

  @override
  @JsonKey()
  final bool hasRewardCampaign;
  @override
  final DateTime? soonestExpiry;

  @override
  String toString() {
    return 'InboxThread(id: $id, title: $title, description: $description, threadImage: $threadImage, isPinned: $isPinned, isFeatured: $isFeatured, activeTo: $activeTo, availableOpportunities: $availableOpportunities, totalTokenReward: $totalTokenReward, rewardTypes: $rewardTypes, earningTypes: $earningTypes, estimatedDurationSeconds: $estimatedDurationSeconds, opportunityIds: $opportunityIds, hasRewardCampaign: $hasRewardCampaign, soonestExpiry: $soonestExpiry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.threadImage, threadImage) ||
                other.threadImage == threadImage) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.activeTo, activeTo) ||
                other.activeTo == activeTo) &&
            (identical(other.availableOpportunities, availableOpportunities) ||
                other.availableOpportunities == availableOpportunities) &&
            (identical(other.totalTokenReward, totalTokenReward) ||
                other.totalTokenReward == totalTokenReward) &&
            const DeepCollectionEquality().equals(
              other._rewardTypes,
              _rewardTypes,
            ) &&
            const DeepCollectionEquality().equals(
              other._earningTypes,
              _earningTypes,
            ) &&
            (identical(
                  other.estimatedDurationSeconds,
                  estimatedDurationSeconds,
                ) ||
                other.estimatedDurationSeconds == estimatedDurationSeconds) &&
            const DeepCollectionEquality().equals(
              other._opportunityIds,
              _opportunityIds,
            ) &&
            (identical(other.hasRewardCampaign, hasRewardCampaign) ||
                other.hasRewardCampaign == hasRewardCampaign) &&
            (identical(other.soonestExpiry, soonestExpiry) ||
                other.soonestExpiry == soonestExpiry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    threadImage,
    isPinned,
    isFeatured,
    activeTo,
    availableOpportunities,
    totalTokenReward,
    const DeepCollectionEquality().hash(_rewardTypes),
    const DeepCollectionEquality().hash(_earningTypes),
    estimatedDurationSeconds,
    const DeepCollectionEquality().hash(_opportunityIds),
    hasRewardCampaign,
    soonestExpiry,
  );

  /// Create a copy of InboxThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxThreadImplCopyWith<_$InboxThreadImpl> get copyWith =>
      __$$InboxThreadImplCopyWithImpl<_$InboxThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InboxThreadImplToJson(this);
  }
}

abstract class _InboxThread extends InboxThread {
  const factory _InboxThread({
    required final String id,
    required final String title,
    final String? description,
    final String? threadImage,
    required final bool isPinned,
    required final bool isFeatured,
    final DateTime? activeTo,
    required final int availableOpportunities,
    required final int totalTokenReward,
    final List<String> rewardTypes,
    final List<String> earningTypes,
    final int estimatedDurationSeconds,
    final List<String> opportunityIds,
    final bool hasRewardCampaign,
    final DateTime? soonestExpiry,
  }) = _$InboxThreadImpl;
  const _InboxThread._() : super._();

  factory _InboxThread.fromJson(Map<String, dynamic> json) =
      _$InboxThreadImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get threadImage;
  @override
  bool get isPinned;
  @override
  bool get isFeatured;
  @override
  DateTime? get activeTo;
  @override
  int get availableOpportunities;
  @override
  int get totalTokenReward;
  @override
  List<String> get rewardTypes;
  @override
  List<String> get earningTypes;
  @override
  int get estimatedDurationSeconds;
  @override
  List<String> get opportunityIds;
  @override
  bool get hasRewardCampaign;
  @override
  DateTime? get soonestExpiry;

  /// Create a copy of InboxThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InboxThreadImplCopyWith<_$InboxThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
