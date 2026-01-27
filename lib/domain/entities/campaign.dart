import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign.freezed.dart';
part 'campaign.g.dart';

/// Represents an advertising/earning campaign from brands
@freezed
class Campaign with _$Campaign {
  const factory Campaign({
    required String id,
    required String brandId,
    required String brandName,
    required String title,
    required String description,
    required CampaignType type,
    required CampaignStatus status,
    required int totalBudgetTokens,
    required int remainingBudgetTokens,
    required int rewardPerEngagement,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime createdAt,
    String? imageUrl,
    String? videoUrl,
    Map<String, dynamic>? targetingCriteria,
    int? maxEngagementsPerUser,
    int? totalEngagements,
    int? uniqueUsers,
    double? averageCompletionRate,
  }) = _Campaign;

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);
}

/// Type of campaign
enum CampaignType {
  @JsonValue('video_ad')
  videoAd,
  @JsonValue('survey')
  survey,
  @JsonValue('poll_question')
  pollQuestion,
  @JsonValue('branded_content')
  brandedContent,
  @JsonValue('app_install')
  appInstall,
  @JsonValue('website_visit')
  websiteVisit,
}

/// Status of a campaign
enum CampaignStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('pending_approval')
  pendingApproval,
  @JsonValue('active')
  active,
  @JsonValue('paused')
  paused,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('expired')
  expired,
}
