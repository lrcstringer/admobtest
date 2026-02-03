import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase.freezed.dart';
part 'purchase.g.dart';

/// Purchase status
enum PurchaseStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

/// Purchase category
enum PurchaseCategory {
  airtime,
  data,
  electricity,
  voucher,
  other,
}

/// Purchase entity representing a service purchase
@freezed
class Purchase with _$Purchase {
  const factory Purchase({
    required String id,
    required String walletId,
    required String userId,
    required String providerId,
    required String providerName,
    required PurchaseCategory category,
    required int tokenAmount,
    required double zarAmount,
    required PurchaseStatus status,
    required String productCode,
    required String productName,
    String? recipientNumber,
    String? voucherCode,
    String? voucherPin,
    String? reference,
    String? failureReason,
    Map<String, dynamic>? metadata,
    required DateTime createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
  }) = _Purchase;

  const Purchase._();

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);

  /// Check if purchase is pending
  bool get isPending => status == PurchaseStatus.pending;

  /// Check if purchase is complete
  bool get isComplete => status == PurchaseStatus.completed;

  /// Check if purchase failed
  bool get isFailed => status == PurchaseStatus.failed;

  /// Get formatted ZAR amount
  String get formattedZarAmount => 'R${zarAmount.toStringAsFixed(2)}';

  /// Get category display name
  String get categoryDisplayName {
    switch (category) {
      case PurchaseCategory.airtime:
        return 'Airtime';
      case PurchaseCategory.data:
        return 'Data';
      case PurchaseCategory.electricity:
        return 'Electricity';
      case PurchaseCategory.voucher:
        return 'Voucher';
      case PurchaseCategory.other:
        return 'Other';
    }
  }

  /// Get status display name
  String get statusDisplayName {
    switch (status) {
      case PurchaseStatus.pending:
        return 'Pending';
      case PurchaseStatus.processing:
        return 'Processing';
      case PurchaseStatus.completed:
        return 'Completed';
      case PurchaseStatus.failed:
        return 'Failed';
      case PurchaseStatus.refunded:
        return 'Refunded';
    }
  }
}
