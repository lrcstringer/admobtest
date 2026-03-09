import 'package:freezed_annotation/freezed_annotation.dart';

part 'vouch.freezed.dart';
part 'vouch.g.dart';

@freezed
class Vouch with _$Vouch {
  const factory Vouch({
    required String id,
    required String voucherId,
    required String voucherName,
    String? voucherPhotoUrl,
    required String providerId,
    String? orderId,
    required int rating,
    String? comment,
    required DateTime createdAt,
  }) = _Vouch;

  const Vouch._();

  factory Vouch.fromJson(Map<String, dynamic> json) => _$VouchFromJson(json);
}
