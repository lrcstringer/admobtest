// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallSessionModel _$CallSessionModelFromJson(Map<String, dynamic> json) =>
    CallSessionModel(
      callId: json['callId'] as String,
      conversationId: json['conversationId'] as String,
      callerId: json['callerId'] as String,
      calleeId: json['calleeId'] as String,
      callerName: json['callerName'] as String,
      callerAvatarUrl: json['callerAvatarUrl'] as String?,
      callType: json['callType'] as String,
      status: json['status'] as String,
      offer: json['offer'] as Map<String, dynamic>?,
      answer: json['answer'] as Map<String, dynamic>?,
      videoUpgradeRequest: json['videoUpgradeRequest'] as String?,
      videoUpgradeRequesterId: json['videoUpgradeRequesterId'] as String?,
      createdAt: CallSessionModel._timestampToDateTime(json['createdAt']),
      answeredAt: CallSessionModel._timestampToDateTime(json['answeredAt']),
      endedAt: CallSessionModel._timestampToDateTime(json['endedAt']),
      endReason: json['endReason'] as String?,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CallSessionModelToJson(CallSessionModel instance) =>
    <String, dynamic>{
      'callId': instance.callId,
      'conversationId': instance.conversationId,
      'callerId': instance.callerId,
      'calleeId': instance.calleeId,
      'callerName': instance.callerName,
      'callerAvatarUrl': instance.callerAvatarUrl,
      'callType': instance.callType,
      'status': instance.status,
      'offer': instance.offer,
      'answer': instance.answer,
      'videoUpgradeRequest': instance.videoUpgradeRequest,
      'videoUpgradeRequesterId': instance.videoUpgradeRequesterId,
      'createdAt': CallSessionModel._dateTimeToTimestamp(instance.createdAt),
      'answeredAt': CallSessionModel._dateTimeToTimestamp(instance.answeredAt),
      'endedAt': CallSessionModel._dateTimeToTimestamp(instance.endedAt),
      'endReason': instance.endReason,
      'durationSeconds': instance.durationSeconds,
    };
