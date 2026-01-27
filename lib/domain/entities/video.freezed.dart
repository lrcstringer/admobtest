// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Video _$VideoFromJson(Map<String, dynamic> json) {
  return _Video.fromJson(json);
}

/// @nodoc
mixin _$Video {
  String get id => throw _privateConstructorUsedError;
  String get campaignId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get videoUrl => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  int get requiredWatchSeconds => throw _privateConstructorUsedError;
  int get tokenReward => throw _privateConstructorUsedError;
  VideoStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get callToActionText => throw _privateConstructorUsedError;
  String? get callToActionUrl => throw _privateConstructorUsedError;
  int? get totalViews => throw _privateConstructorUsedError;
  int? get completedViews => throw _privateConstructorUsedError;
  double? get averageWatchPercentage => throw _privateConstructorUsedError;

  /// Serializes this Video to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoCopyWith<Video> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCopyWith<$Res> {
  factory $VideoCopyWith(Video value, $Res Function(Video) then) =
      _$VideoCopyWithImpl<$Res, Video>;
  @useResult
  $Res call({
    String id,
    String campaignId,
    String title,
    String videoUrl,
    int durationSeconds,
    int requiredWatchSeconds,
    int tokenReward,
    VideoStatus status,
    DateTime createdAt,
    String? thumbnailUrl,
    String? description,
    String? callToActionText,
    String? callToActionUrl,
    int? totalViews,
    int? completedViews,
    double? averageWatchPercentage,
  });
}

/// @nodoc
class _$VideoCopyWithImpl<$Res, $Val extends Video>
    implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? title = null,
    Object? videoUrl = null,
    Object? durationSeconds = null,
    Object? requiredWatchSeconds = null,
    Object? tokenReward = null,
    Object? status = null,
    Object? createdAt = null,
    Object? thumbnailUrl = freezed,
    Object? description = freezed,
    Object? callToActionText = freezed,
    Object? callToActionUrl = freezed,
    Object? totalViews = freezed,
    Object? completedViews = freezed,
    Object? averageWatchPercentage = freezed,
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
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            videoUrl: null == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            durationSeconds: null == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            requiredWatchSeconds: null == requiredWatchSeconds
                ? _value.requiredWatchSeconds
                : requiredWatchSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            tokenReward: null == tokenReward
                ? _value.tokenReward
                : tokenReward // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as VideoStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            callToActionText: freezed == callToActionText
                ? _value.callToActionText
                : callToActionText // ignore: cast_nullable_to_non_nullable
                      as String?,
            callToActionUrl: freezed == callToActionUrl
                ? _value.callToActionUrl
                : callToActionUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalViews: freezed == totalViews
                ? _value.totalViews
                : totalViews // ignore: cast_nullable_to_non_nullable
                      as int?,
            completedViews: freezed == completedViews
                ? _value.completedViews
                : completedViews // ignore: cast_nullable_to_non_nullable
                      as int?,
            averageWatchPercentage: freezed == averageWatchPercentage
                ? _value.averageWatchPercentage
                : averageWatchPercentage // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VideoImplCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$$VideoImplCopyWith(
    _$VideoImpl value,
    $Res Function(_$VideoImpl) then,
  ) = __$$VideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String campaignId,
    String title,
    String videoUrl,
    int durationSeconds,
    int requiredWatchSeconds,
    int tokenReward,
    VideoStatus status,
    DateTime createdAt,
    String? thumbnailUrl,
    String? description,
    String? callToActionText,
    String? callToActionUrl,
    int? totalViews,
    int? completedViews,
    double? averageWatchPercentage,
  });
}

/// @nodoc
class __$$VideoImplCopyWithImpl<$Res>
    extends _$VideoCopyWithImpl<$Res, _$VideoImpl>
    implements _$$VideoImplCopyWith<$Res> {
  __$$VideoImplCopyWithImpl(
    _$VideoImpl _value,
    $Res Function(_$VideoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campaignId = null,
    Object? title = null,
    Object? videoUrl = null,
    Object? durationSeconds = null,
    Object? requiredWatchSeconds = null,
    Object? tokenReward = null,
    Object? status = null,
    Object? createdAt = null,
    Object? thumbnailUrl = freezed,
    Object? description = freezed,
    Object? callToActionText = freezed,
    Object? callToActionUrl = freezed,
    Object? totalViews = freezed,
    Object? completedViews = freezed,
    Object? averageWatchPercentage = freezed,
  }) {
    return _then(
      _$VideoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        campaignId: null == campaignId
            ? _value.campaignId
            : campaignId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        videoUrl: null == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        durationSeconds: null == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        requiredWatchSeconds: null == requiredWatchSeconds
            ? _value.requiredWatchSeconds
            : requiredWatchSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        tokenReward: null == tokenReward
            ? _value.tokenReward
            : tokenReward // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as VideoStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        callToActionText: freezed == callToActionText
            ? _value.callToActionText
            : callToActionText // ignore: cast_nullable_to_non_nullable
                  as String?,
        callToActionUrl: freezed == callToActionUrl
            ? _value.callToActionUrl
            : callToActionUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalViews: freezed == totalViews
            ? _value.totalViews
            : totalViews // ignore: cast_nullable_to_non_nullable
                  as int?,
        completedViews: freezed == completedViews
            ? _value.completedViews
            : completedViews // ignore: cast_nullable_to_non_nullable
                  as int?,
        averageWatchPercentage: freezed == averageWatchPercentage
            ? _value.averageWatchPercentage
            : averageWatchPercentage // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoImpl implements _Video {
  const _$VideoImpl({
    required this.id,
    required this.campaignId,
    required this.title,
    required this.videoUrl,
    required this.durationSeconds,
    required this.requiredWatchSeconds,
    required this.tokenReward,
    required this.status,
    required this.createdAt,
    this.thumbnailUrl,
    this.description,
    this.callToActionText,
    this.callToActionUrl,
    this.totalViews,
    this.completedViews,
    this.averageWatchPercentage,
  });

  factory _$VideoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoImplFromJson(json);

  @override
  final String id;
  @override
  final String campaignId;
  @override
  final String title;
  @override
  final String videoUrl;
  @override
  final int durationSeconds;
  @override
  final int requiredWatchSeconds;
  @override
  final int tokenReward;
  @override
  final VideoStatus status;
  @override
  final DateTime createdAt;
  @override
  final String? thumbnailUrl;
  @override
  final String? description;
  @override
  final String? callToActionText;
  @override
  final String? callToActionUrl;
  @override
  final int? totalViews;
  @override
  final int? completedViews;
  @override
  final double? averageWatchPercentage;

  @override
  String toString() {
    return 'Video(id: $id, campaignId: $campaignId, title: $title, videoUrl: $videoUrl, durationSeconds: $durationSeconds, requiredWatchSeconds: $requiredWatchSeconds, tokenReward: $tokenReward, status: $status, createdAt: $createdAt, thumbnailUrl: $thumbnailUrl, description: $description, callToActionText: $callToActionText, callToActionUrl: $callToActionUrl, totalViews: $totalViews, completedViews: $completedViews, averageWatchPercentage: $averageWatchPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.requiredWatchSeconds, requiredWatchSeconds) ||
                other.requiredWatchSeconds == requiredWatchSeconds) &&
            (identical(other.tokenReward, tokenReward) ||
                other.tokenReward == tokenReward) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.callToActionText, callToActionText) ||
                other.callToActionText == callToActionText) &&
            (identical(other.callToActionUrl, callToActionUrl) ||
                other.callToActionUrl == callToActionUrl) &&
            (identical(other.totalViews, totalViews) ||
                other.totalViews == totalViews) &&
            (identical(other.completedViews, completedViews) ||
                other.completedViews == completedViews) &&
            (identical(other.averageWatchPercentage, averageWatchPercentage) ||
                other.averageWatchPercentage == averageWatchPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    campaignId,
    title,
    videoUrl,
    durationSeconds,
    requiredWatchSeconds,
    tokenReward,
    status,
    createdAt,
    thumbnailUrl,
    description,
    callToActionText,
    callToActionUrl,
    totalViews,
    completedViews,
    averageWatchPercentage,
  );

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoImplCopyWith<_$VideoImpl> get copyWith =>
      __$$VideoImplCopyWithImpl<_$VideoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoImplToJson(this);
  }
}

abstract class _Video implements Video {
  const factory _Video({
    required final String id,
    required final String campaignId,
    required final String title,
    required final String videoUrl,
    required final int durationSeconds,
    required final int requiredWatchSeconds,
    required final int tokenReward,
    required final VideoStatus status,
    required final DateTime createdAt,
    final String? thumbnailUrl,
    final String? description,
    final String? callToActionText,
    final String? callToActionUrl,
    final int? totalViews,
    final int? completedViews,
    final double? averageWatchPercentage,
  }) = _$VideoImpl;

  factory _Video.fromJson(Map<String, dynamic> json) = _$VideoImpl.fromJson;

  @override
  String get id;
  @override
  String get campaignId;
  @override
  String get title;
  @override
  String get videoUrl;
  @override
  int get durationSeconds;
  @override
  int get requiredWatchSeconds;
  @override
  int get tokenReward;
  @override
  VideoStatus get status;
  @override
  DateTime get createdAt;
  @override
  String? get thumbnailUrl;
  @override
  String? get description;
  @override
  String? get callToActionText;
  @override
  String? get callToActionUrl;
  @override
  int? get totalViews;
  @override
  int? get completedViews;
  @override
  double? get averageWatchPercentage;

  /// Create a copy of Video
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoImplCopyWith<_$VideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
