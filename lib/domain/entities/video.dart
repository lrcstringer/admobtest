import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

/// Represents a video ad that users can watch to earn tokens
@freezed
class Video with _$Video {
  const factory Video({
    required String id,
    required String campaignId,
    required String title,
    required String videoUrl,
    required int durationSeconds,
    required int requiredWatchSeconds,
    required int tokenReward,
    required VideoStatus status,
    required DateTime createdAt,
    String? thumbnailUrl,
    String? description,
    String? callToActionText,
    String? callToActionUrl,
    int? totalViews,
    int? completedViews,
    double? averageWatchPercentage,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}

/// Status of a video ad
enum VideoStatus {
  @JsonValue('active')
  active,
  @JsonValue('paused')
  paused,
  @JsonValue('expired')
  expired,
  @JsonValue('deleted')
  deleted,
}
