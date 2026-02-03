// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashoutImpl _$$CashoutImplFromJson(Map<String, dynamic> json) =>
    _$CashoutImpl(
      id: json['id'] as String,
      walletId: json['walletId'] as String,
      userId: json['userId'] as String,
      tokenAmount: (json['tokenAmount'] as num).toInt(),
      zarAmount: (json['zarAmount'] as num).toDouble(),
      method: $enumDecode(_$CashoutMethodEnumMap, json['method']),
      status: $enumDecode(_$CashoutStatusEnumMap, json['status']),
      destinationDetails: json['destinationDetails'] as String,
      bankName: json['bankName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      reference: json['reference'] as String?,
      failureReason: json['failureReason'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      failedAt: json['failedAt'] == null
          ? null
          : DateTime.parse(json['failedAt'] as String),
    );

Map<String, dynamic> _$$CashoutImplToJson(_$CashoutImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'walletId': instance.walletId,
      'userId': instance.userId,
      'tokenAmount': instance.tokenAmount,
      'zarAmount': instance.zarAmount,
      'method': _$CashoutMethodEnumMap[instance.method]!,
      'status': _$CashoutStatusEnumMap[instance.status]!,
      'destinationDetails': instance.destinationDetails,
      'bankName': instance.bankName,
      'accountNumber': instance.accountNumber,
      'accountHolderName': instance.accountHolderName,
      'mobileNumber': instance.mobileNumber,
      'reference': instance.reference,
      'failureReason': instance.failureReason,
      'createdAt': instance.createdAt.toIso8601String(),
      'processedAt': instance.processedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'failedAt': instance.failedAt?.toIso8601String(),
    };

const _$CashoutMethodEnumMap = {
  CashoutMethod.bankTransfer: 'bankTransfer',
  CashoutMethod.ewallet: 'ewallet',
  CashoutMethod.airtime: 'airtime',
  CashoutMethod.voucher: 'voucher',
};

const _$CashoutStatusEnumMap = {
  CashoutStatus.pending: 'pending',
  CashoutStatus.onHold: 'onHold',
  CashoutStatus.processing: 'processing',
  CashoutStatus.completed: 'completed',
  CashoutStatus.failed: 'failed',
  CashoutStatus.cancelled: 'cancelled',
};
