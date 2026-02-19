import 'package:json_annotation/json_annotation.dart';

/// Status of a community.
enum CommunityStatus {
  @JsonValue('active')
  active,
  @JsonValue('suspended')
  suspended,
  @JsonValue('closed')
  closed;

  String get displayName => switch (this) {
        active => 'Active',
        suspended => 'Suspended',
        closed => 'Closed',
      };
}
