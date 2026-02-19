import 'package:json_annotation/json_annotation.dart';

enum ReportType {
  @JsonValue('message')
  message,

  @JsonValue('user')
  user,

  @JsonValue('community')
  community;
}
