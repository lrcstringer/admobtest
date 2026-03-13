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
/// The main wallet is the ledger account itself (id='main' in UI).
/// Sub-accounts are optional user-created wallets or brand-restricted wallets.
@freezed
abstract class SubAccount with _$SubAccount {
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
    // Rule flags (populated by getSubAccounts Cloud Function)
    @Default(true) bool allowP2pSend,
    @Default(true) bool allowP2pReceive,
    @Default(true) bool allowCashout,
    @Default(false) bool p2pRestrictToSameAccountType,
    @Default(["*"]) List<String> allowedOfframps,
    // Expiry fields (populated by getSubAccounts Cloud Function)
    int? expiryDays,
    DateTime? lastCreditAt,
  }) = _SubAccount;

  const SubAccount._();

  factory SubAccount.fromJson(Map<String, dynamic> json) =>
      _$SubAccountFromJson(json);

  /// Get balance as TokenAmount
  TokenAmount get tokenBalance => TokenAmount(balance);

  /// Get balance in ZAR
  double get balanceZar => balance * AppConstants.tokenValueZar;

  /// Check if this is a restricted (brand) sub-account
  bool get isRestricted => accountTypeId != null;

  /// Whether this wallet allows purchasing a given category
  bool allowsPurchaseCategory(String category) =>
      allowedOfframps.contains('*') || allowedOfframps.contains(category);
}
