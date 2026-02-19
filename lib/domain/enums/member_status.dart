import 'package:freezed_annotation/freezed_annotation.dart';

/// Status of a community member
enum MemberStatus {
  @JsonValue('active')
  active,
  @JsonValue('invited')
  invited,
  @JsonValue('blocked')
  blocked,
}
