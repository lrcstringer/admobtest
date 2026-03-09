import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/vouch.dart';

part 'vouch_model.freezed.dart';

@freezed
class VouchModel with _$VouchModel {
  const factory VouchModel({
    required String id,
    required String voucherId,
    required String voucherName,
    String? voucherPhotoUrl,
    required String providerId,
    String? orderId,
    required int rating,
    String? comment,
    required DateTime createdAt,
  }) = _VouchModel;

  const VouchModel._();

  factory VouchModel.fromJson(Map<String, dynamic> json) {
    return VouchModel(
      id: json['id'] as String? ?? '',
      voucherId: json['voucherId'] as String? ?? '',
      voucherName: json['voucherName'] as String? ?? '',
      voucherPhotoUrl: json['voucherPhotoUrl'] as String?,
      providerId: json['providerId'] as String? ?? '',
      orderId: json['orderId'] as String?,
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'voucherId': voucherId,
      'voucherName': voucherName,
      if (voucherPhotoUrl != null) 'voucherPhotoUrl': voucherPhotoUrl,
      'providerId': providerId,
      if (orderId != null) 'orderId': orderId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Vouch toEntity() {
    return Vouch(
      id: id,
      voucherId: voucherId,
      voucherName: voucherName,
      voucherPhotoUrl: voucherPhotoUrl,
      providerId: providerId,
      orderId: orderId,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
    );
  }

  factory VouchModel.fromEntity(Vouch entity) {
    return VouchModel(
      id: entity.id,
      voucherId: entity.voucherId,
      voucherName: entity.voucherName,
      voucherPhotoUrl: entity.voucherPhotoUrl,
      providerId: entity.providerId,
      orderId: entity.orderId,
      rating: entity.rating,
      comment: entity.comment,
      createdAt: entity.createdAt,
    );
  }
}
