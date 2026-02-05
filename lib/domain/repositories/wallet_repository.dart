import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/cashout.dart';
import '../entities/ledger_account.dart';
import '../entities/ledger_journal.dart';
import '../entities/sub_account.dart';
import '../entities/user_engagement_stats.dart';

/// Repository for ledger, cashout, and engagement stats operations
/// Note: Legacy wallet methods have been removed. Balance and transactions
/// are now managed through the Trust Ledger system.
abstract class WalletRepository {
  // ============================================================
  // Ledger Account Methods
  // ============================================================

  /// Get user's ledger account (Trust Ledger)
  Future<Either<Failure, LedgerAccount>> getLedgerAccount();

  /// Stream ledger account updates
  Stream<Either<Failure, LedgerAccount>> watchLedgerAccount();

  /// Get ledger balance (convenience method)
  Future<Either<Failure, int>> getLedgerBalance();

  // ============================================================
  // Ledger Journal Methods (Transaction History)
  // ============================================================

  /// Get ledger journals (Trust Ledger transaction history)
  Future<Either<Failure, List<LedgerJournal>>> getLedgerJournals({
    int? limit,
    DateTime? startAfter,
  });

  /// Stream ledger journals
  Stream<Either<Failure, List<LedgerJournal>>> watchLedgerJournals({int? limit});

  // ============================================================
  // Engagement Stats Methods
  // ============================================================

  /// Get user's engagement stats (streak tracking)
  Future<Either<Failure, UserEngagementStats>> getEngagementStats();

  /// Stream engagement stats updates
  Stream<Either<Failure, UserEngagementStats>> watchEngagementStats();

  // ============================================================
  // Sub-Account Methods (Multi-Wallet)
  // ============================================================

  /// Get all sub-accounts (wallets) for the current user
  Future<Either<Failure, List<SubAccount>>> getSubAccounts();

  /// Stream sub-account updates
  Stream<Either<Failure, List<SubAccount>>> watchSubAccounts();

  /// Transfer tokens between the user's own wallets
  Future<Either<Failure, void>> transferBetweenWallets({
    required String fromSubAccountId,
    required String toSubAccountId,
    required int amount,
  });

  /// Send tokens to another user (P2P transfer)
  Future<Either<Failure, void>> sendP2PTransfer({
    required String recipientUserId,
    required int amount,
    required String subAccountId,
    String? note,
  });

  // ============================================================
  // Cashout Methods
  // ============================================================

  /// Request cashout from ledger account
  Future<Either<Failure, Cashout>> requestCashout({
    required int tokenAmount,
    required CashoutMethod method,
    required String destinationDetails,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? mobileNumber,
  });

  /// Get cashout history
  Future<Either<Failure, List<Cashout>>> getCashoutHistory({
    int? limit,
    DateTime? startAfter,
  });

  /// Get cashout by ID
  Future<Either<Failure, Cashout>> getCashoutById(String cashoutId);

  /// Cancel pending cashout
  Future<Either<Failure, void>> cancelCashout(String cashoutId);
}
