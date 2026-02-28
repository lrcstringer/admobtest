import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/call_session.dart';
import '../../domain/enums/call_status.dart';
import '../../domain/enums/call_type.dart';

part 'call_session_model.g.dart';

/// Firestore-serializable model for a call session.
@JsonSerializable()
class CallSessionModel {
  final String callId;
  final String conversationId;
  final String callerId;
  final String calleeId;
  final String callerName;
  final String? callerAvatarUrl;
  final String callType;
  final String status;
  final Map<String, dynamic>? offer;
  final Map<String, dynamic>? answer;
  final String? videoUpgradeRequest;
  final String? videoUpgradeRequesterId;

  @JsonKey(fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
  final DateTime? createdAt;

  @JsonKey(fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
  final DateTime? answeredAt;

  @JsonKey(fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
  final DateTime? endedAt;

  final String? endReason;
  final int? durationSeconds;

  const CallSessionModel({
    required this.callId,
    required this.conversationId,
    required this.callerId,
    required this.calleeId,
    required this.callerName,
    this.callerAvatarUrl,
    required this.callType,
    required this.status,
    this.offer,
    this.answer,
    this.videoUpgradeRequest,
    this.videoUpgradeRequesterId,
    this.createdAt,
    this.answeredAt,
    this.endedAt,
    this.endReason,
    this.durationSeconds,
  });

  factory CallSessionModel.fromJson(Map<String, dynamic> json) =>
      _$CallSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CallSessionModelToJson(this);

  /// Convert to domain entity.
  CallSession toEntity() => CallSession(
        callId: callId,
        conversationId: conversationId,
        callerId: callerId,
        calleeId: calleeId,
        callerName: callerName,
        callerAvatarUrl: callerAvatarUrl,
        callType: callType == 'video' ? CallType.video : CallType.voice,
        status: CallStatus.values.firstWhere(
          (s) => s.name == status,
          orElse: () => CallStatus.idle,
        ),
        offer: offer?.map((k, v) => MapEntry(k, v.toString())),
        answer: answer?.map((k, v) => MapEntry(k, v.toString())),
        videoUpgradeRequest: videoUpgradeRequest,
        videoUpgradeRequesterId: videoUpgradeRequesterId,
        createdAt: createdAt,
        answeredAt: answeredAt,
        endedAt: endedAt,
        endReason: endReason,
        durationSeconds: durationSeconds,
      );

  static DateTime? _timestampToDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static dynamic _dateTimeToTimestamp(DateTime? value) {
    if (value == null) return null;
    return Timestamp.fromDate(value);
  }
}
