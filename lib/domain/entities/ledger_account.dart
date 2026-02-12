import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/constants/app_constants.dart';

part 'ledger_account.freezed.dart';
part 'ledger_account.g.dart';

/// Account type in the Trust Ledger system
///
/// Asset accounts (debit-normal): cbook — debit increases balance, credit decreases.
/// All other accounts are credit-normal: credit increases balance, debit decreases.
enum LedgerAccountType {
  system,       // iMali system accounts (cashout_pending)
  pot,          // Daily and weekly pot accounts
  user,         // Individual user wallet accounts
  supplier,     // Service providers (Vodacom, MTN, Eskom, etc.)
  cbook,        // Cash Book accounts (business, trust) — asset/debit-normal
  clientSubacc, // Client sub-accounts (on-ledger budgets)
  client,       // Brand partners (advertisers, campaign sponsors)
  group,        // Group accounts (stokvels, family, organizations, clubs)
}

/// Account status
enum LedgerAccountStatus {
  active,
  frozen,
  closed,
}

/// Ledger account entity
/// Represents an account in the Trust Ledger double-entry bookkeeping system
@freezed
class LedgerAccount with _$LedgerAccount {
  const factory LedgerAccount({
    required String id,
    required LedgerAccountType type,
    required String name,
    String? ownerId,
    required int balance,
    @Default('TOKEN') String currency,
    required LedgerAccountStatus status,
    @Default({}) Map<String, dynamic> metadata,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(1) int version,
  }) = _LedgerAccount;

  const LedgerAccount._();

  factory LedgerAccount.fromJson(Map<String, dynamic> json) =>
      _$LedgerAccountFromJson(json);

  /// Check if this is a user account
  bool get isUserAccount => type == LedgerAccountType.user;

  /// Check if account is active
  bool get isActive => status == LedgerAccountStatus.active;

  /// Get balance in ZAR (100 tokens = R1)
  double get balanceZar => AppConstants.tokensToZar(balance);

  /// Extract user ID from account ID (format: "user:userId")
  String? get userId {
    if (id.startsWith('user:')) {
      return id.substring(5);
    }
    return null;
  }
}
