// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_buy_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupBuyRequestImpl _$$GroupBuyRequestImplFromJson(
  Map<String, dynamic> json,
) => _$GroupBuyRequestImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  description: json['description'] as String,
  brandOrStore: json['brandOrStore'] as String,
  estimatedPrice: (json['estimatedPrice'] as num?)?.toInt(),
  sourceUrl: json['sourceUrl'] as String?,
  imageUrl: json['imageUrl'] as String?,
  wantsToJoin: json['wantsToJoin'] as bool? ?? true,
  status: $enumDecode(_$GroupBuyRequestStatusEnumMap, json['status']),
  adminNotes: json['adminNotes'] as String?,
  convertedGroupBuyId: json['convertedGroupBuyId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$GroupBuyRequestImplToJson(
  _$GroupBuyRequestImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userName': instance.userName,
  'description': instance.description,
  'brandOrStore': instance.brandOrStore,
  'estimatedPrice': instance.estimatedPrice,
  'sourceUrl': instance.sourceUrl,
  'imageUrl': instance.imageUrl,
  'wantsToJoin': instance.wantsToJoin,
  'status': _$GroupBuyRequestStatusEnumMap[instance.status]!,
  'adminNotes': instance.adminNotes,
  'convertedGroupBuyId': instance.convertedGroupBuyId,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$GroupBuyRequestStatusEnumMap = {
  GroupBuyRequestStatus.pending: 'pending',
  GroupBuyRequestStatus.approved: 'approved',
  GroupBuyRequestStatus.declined: 'declined',
};
