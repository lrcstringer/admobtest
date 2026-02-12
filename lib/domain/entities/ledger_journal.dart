import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_journal.freezed.dart';
part 'ledger_journal.g.dart';

/// Journal transaction types
enum LedgerJournalType {
  earn,             // User earned tokens (from engagement)
  potContribution,  // Automatic pot contribution from earnings
  potWin,           // User won a pot draw
  purchase,         // User purchased goods/services
  referralReward,   // Referral bonus paid
  p2pTransfer,      // User-to-user transfer
  cashoutInitiate,  // Cashout started (user -> pending)
  cashoutComplete,  // Cashout completed (pending -> supplier)
  cashoutFailed,    // Cashout failed (pending -> user refund)
  reversal,         // Reversal of a previous journal
  adjustment,       // Manual admin adjustment
  clientFund,       // CBook -> Client funding (also seeds cbook as asset debit)
  clientRefund,     // Client -> CBook refund
  subaccFund,       // Client -> Sub-Account funding
}

/// Journal status
enum LedgerJournalStatus {
  pending,
  posted,
  failed,
  reversed,
}

/// Entry type (debit/credit)
enum LedgerEntryType {
  debit,
  credit,
}

/// Individual ledger entry within a journal
@freezed
class LedgerEntry with _$LedgerEntry {
  const factory LedgerEntry({
    required String id,
    required String accountId,
    required LedgerEntryType entryType,
    required int amount,
    required int balanceAfter,
    String? description,
  }) = _LedgerEntry;

  factory LedgerEntry.fromJson(Map<String, dynamic> json) =>
      _$LedgerEntryFromJson(json);
}

/// Reference type for journal
enum LedgerReferenceType {
  engagement,
  purchase,
  referral,
  transfer,
  cashout,
  potDraw,
  potEntry,
  clientFund,
}

/// Ledger journal entity
/// Represents an immutable double-entry bookkeeping record
@freezed
class LedgerJournal with _$LedgerJournal {
  const factory LedgerJournal({
    required String id,
    required String idempotencyKey,
    required LedgerJournalType type,
    required LedgerJournalStatus status,
    required String description,
    required List<LedgerEntry> entries,
    required int totalDebits,
    required int totalCredits,
    LedgerReferenceType? referenceType,
    String? referenceId,
    required String initiatedBy,
    String? approvedBy,
    required DateTime createdAt,
    DateTime? postedAt,
    DateTime? reversedAt,
    String? reversedBy,
    String? reversalJournalId,
    String? originalJournalId,
    @Default({}) Map<String, dynamic> metadata,
  }) = _LedgerJournal;

  const LedgerJournal._();

  factory LedgerJournal.fromJson(Map<String, dynamic> json) =>
      _$LedgerJournalFromJson(json);

  /// Check if journal is balanced (debits = credits)
  bool get isBalanced => totalDebits == totalCredits;

  /// Check if journal has been reversed
  bool get isReversed => status == LedgerJournalStatus.reversed;

  /// Check if journal is posted
  bool get isPosted => status == LedgerJournalStatus.posted;
}
