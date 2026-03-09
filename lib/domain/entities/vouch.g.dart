// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vouch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VouchImpl _$$VouchImplFromJson(Map<String, dynamic> json) => _$VouchImpl(
  id: json['id'] as String,
  voucherId: json['voucherId'] as String,
  voucherName: json['voucherName'] as String,
  voucherPhotoUrl: json['voucherPhotoUrl'] as String?,
  providerId: json['providerId'] as String,
  orderId: json['orderId'] as String?,
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$VouchImplToJson(_$VouchImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'voucherId': instance.voucherId,
      'voucherName': instance.voucherName,
      'voucherPhotoUrl': instance.voucherPhotoUrl,
      'providerId': instance.providerId,
      'orderId': instance.orderId,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
    };
