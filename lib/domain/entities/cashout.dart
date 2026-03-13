import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/cashout_status.dart';

part 'cashout.freezed.dart';
part 'cashout.g.dart';

/// Cashout method type
enum CashoutMethod {
  bankTransfer,
  ewallet,
  airtime,
  voucher,
}

/// Cashout entity representing a withdrawal request
@freezed
abstract class Cashout with _$Cashout {
  const factory Cashout({
    required String id,
    required String walletId,
    required String userId,
    required int tokenAmount,
    required double zarAmount,
    required CashoutMethod method,
    required CashoutStatus status,
    required String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
    String? reference,
    String? failureReason,
    required DateTime createdAt,
    DateTime? processedAt,
    DateTime? completedAt,
    DateTime? failedAt,
  }) = _Cashout;

  const Cashout._();

  factory Cashout.fromJson(Map<String, dynamic> json) =>
      _$CashoutFromJson(json);

  /// Check if cashout is pending
  bool get isPending => status == CashoutStatus.pending;

  /// Check if cashout is processing
  bool get isProcessing => status == CashoutStatus.processing;

  /// Check if cashout is complete
  bool get isComplete => status == CashoutStatus.completed;

  /// Check if cashout failed
  bool get isFailed => status == CashoutStatus.failed;

  /// Get formatted ZAR amount
  String get formattedZarAmount => 'R${zarAmount.toStringAsFixed(2)}';

  /// Get method display name
  String get methodDisplayName {
    switch (method) {
      case CashoutMethod.bankTransfer:
        return 'Bank Transfer';
      case CashoutMethod.ewallet:
        return 'E-Wallet';
      case CashoutMethod.airtime:
        return 'Airtime';
      case CashoutMethod.voucher:
        return 'Voucher';
    }
  }

  /// Get status display name
  String get statusDisplayName {
    switch (status) {
      case CashoutStatus.pending:
        return 'Pending';
      case CashoutStatus.onHold:
        return 'On Hold';
      case CashoutStatus.processing:
        return 'Processing';
      case CashoutStatus.completed:
        return 'Completed';
      case CashoutStatus.failed:
        return 'Failed';
      case CashoutStatus.cancelled:
        return 'Cancelled';
    }
  }
}
