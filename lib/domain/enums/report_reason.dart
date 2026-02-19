import 'package:json_annotation/json_annotation.dart';

enum ReportReason {
  @JsonValue('spam')
  spam,

  @JsonValue('harassment')
  harassment,

  @JsonValue('inappropriate_content')
  inappropriateContent,

  @JsonValue('scam')
  scam,

  @JsonValue('other')
  other;

  String get displayName => switch (this) {
        ReportReason.spam => 'Spam',
        ReportReason.harassment => 'Harassment',
        ReportReason.inappropriateContent => 'Inappropriate Content',
        ReportReason.scam => 'Scam / Fraud',
        ReportReason.other => 'Other',
      };
}
