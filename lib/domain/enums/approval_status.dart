import 'package:json_annotation/json_annotation.dart';

/// Status of a community approval workflow.
enum ApprovalStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
  @JsonValue('expired')
  expired;

  String get displayName => switch (this) {
        pending => 'Pending',
        approved => 'Approved',
        rejected => 'Rejected',
        expired => 'Expired',
      };
}
