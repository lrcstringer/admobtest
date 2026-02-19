import 'package:json_annotation/json_annotation.dart';

/// Status of a community financial transaction.
enum CommunityTransactionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('completed')
  completed,
  @JsonValue('rejected')
  rejected;

  String get displayName => switch (this) {
        pending => 'Pending',
        approved => 'Approved',
        completed => 'Completed',
        rejected => 'Rejected',
      };
}
