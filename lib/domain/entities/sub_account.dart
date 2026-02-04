import 'package:freezed_annotation/freezed_annotation.dart';
import '../value_objects/token_amount.dart';
import '../../core/constants/app_constants.dart';

part 'sub_account.freezed.dart';
part 'sub_account.g.dart';

/// Sub-account entity
///
/// Represents a subdivision within a user's ledger account.
/// Displayed as "wallet" in the UI but internally called sub-account.
///
/// Each user has:
/// - One default (unrestricted) sub-account for general use
/// - Zero or more brand-specific (restricted) sub-accounts
@freezed
class SubAccount with _$SubAccount {
  const factory SubAccount({
    required String id,
    required String userId,
    /// null = unrestricted default account
    String? accountTypeId,
    required String name,
    required int balance,
    required int lifetimeCredits,
    required int lifetimeDebits,
    required bool isActive,
    required bool isDefault,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SubAccount;

  const SubAccount._();

  factory SubAccount.fromJson(Map<String, dynamic> json) =>
      _$SubAccountFromJson(json);

  /// Get balance as TokenAmount
  TokenAmount get tokenBalance => TokenAmount(balance);

  /// Get balance in ZAR
  double get balanceZar => balance * AppConstants.tokenValueZar;

  /// Check if balance meets cashout minimum
  bool get canCashout =>
      isDefault && // Only default account can cashout
      accountTypeId == null && // Only unrestricted accounts
      balance >= AppConstants.cashoutMinTokens;

  /// Check if this is a restricted (brand) sub-account
  bool get isRestricted => accountTypeId != null;

  /// Check if this is the default (unrestricted) sub-account
  bool get isUnrestricted => accountTypeId == null && isDefault;
}
