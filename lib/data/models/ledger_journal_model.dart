import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/ledger_journal.dart';

/// Model for LedgerEntry that handles Firestore serialization
class LedgerEntryModel {
  final String id;
  final String accountId;
  final LedgerEntryType entryType;
  final int amount;
  final int balanceAfter;
  final String? description;

  const LedgerEntryModel({
    required this.id,
    required this.accountId,
    required this.entryType,
    required this.amount,
    required this.balanceAfter,
    this.description,
  });

  factory LedgerEntryModel.fromJson(Map<String, dynamic> json) {
    return LedgerEntryModel(
      id: json['id'] as String? ?? '',
      accountId: json['accountId'] as String? ?? '',
      entryType: _parseEntryType(json['entryType'] as String?),
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      balanceAfter: (json['balanceAfter'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
    );
  }

  LedgerEntry toEntity() {
    return LedgerEntry(
      id: id,
      accountId: accountId,
      entryType: entryType,
      amount: amount,
      balanceAfter: balanceAfter,
      description: description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'entryType': entryType.name,
      'amount': amount,
      'balanceAfter': balanceAfter,
      'description': description,
    };
  }

  static LedgerEntryType _parseEntryType(String? type) {
    switch (type) {
      case 'debit':
        return LedgerEntryType.debit;
      case 'credit':
        return LedgerEntryType.credit;
      default:
        return LedgerEntryType.debit;
    }
  }
}

/// Model for LedgerJournal that handles Firestore serialization
class LedgerJournalModel {
  final String id;
  final String idempotencyKey;
  final LedgerJournalType type;
  final LedgerJournalStatus status;
  final String description;
  final List<LedgerEntryModel> entries;
  final int totalDebits;
  final int totalCredits;
  final LedgerReferenceType? referenceType;
  final String? referenceId;
  final String initiatedBy;
  final String? approvedBy;
  final DateTime createdAt;
  final DateTime? postedAt;
  final DateTime? reversedAt;
  final String? reversedBy;
  final String? reversalJournalId;
  final String? originalJournalId;
  final Map<String, dynamic> metadata;

  const LedgerJournalModel({
    required this.id,
    required this.idempotencyKey,
    required this.type,
    required this.status,
    required this.description,
    required this.entries,
    required this.totalDebits,
    required this.totalCredits,
    this.referenceType,
    this.referenceId,
    required this.initiatedBy,
    this.approvedBy,
    required this.createdAt,
    this.postedAt,
    this.reversedAt,
    this.reversedBy,
    this.reversalJournalId,
    this.originalJournalId,
    this.metadata = const {},
  });

  factory LedgerJournalModel.fromJson(Map<String, dynamic> json) {
    final entriesJson = json['entries'] as List<dynamic>? ?? [];
    return LedgerJournalModel(
      id: json['id'] as String? ?? '',
      idempotencyKey: json['idempotencyKey'] as String? ?? '',
      type: _parseJournalType(json['type'] as String?),
      status: _parseJournalStatus(json['status'] as String?),
      description: json['description'] as String? ?? '',
      entries: entriesJson
          .map((e) => LedgerEntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDebits: (json['totalDebits'] as num?)?.toInt() ?? 0,
      totalCredits: (json['totalCredits'] as num?)?.toInt() ?? 0,
      referenceType: _parseReferenceType(json['referenceType'] as String?),
      referenceId: json['referenceId'] as String?,
      initiatedBy: json['initiatedBy'] as String? ?? 'system',
      approvedBy: json['approvedBy'] as String?,
      createdAt: _parseDateTime(json['createdAt']),
      postedAt: json['postedAt'] != null ? _parseDateTime(json['postedAt']) : null,
      reversedAt: json['reversedAt'] != null ? _parseDateTime(json['reversedAt']) : null,
      reversedBy: json['reversedBy'] as String?,
      reversalJournalId: json['reversalJournalId'] as String?,
      originalJournalId: json['originalJournalId'] as String?,
      metadata: (json['metadata'] as Map<String, dynamic>?) ?? {},
    );
  }

  LedgerJournal toEntity() {
    return LedgerJournal(
      id: id,
      idempotencyKey: idempotencyKey,
      type: type,
      status: status,
      description: description,
      entries: entries.map((e) => e.toEntity()).toList(),
      totalDebits: totalDebits,
      totalCredits: totalCredits,
      referenceType: referenceType,
      referenceId: referenceId,
      initiatedBy: initiatedBy,
      approvedBy: approvedBy,
      createdAt: createdAt,
      postedAt: postedAt,
      reversedAt: reversedAt,
      reversedBy: reversedBy,
      reversalJournalId: reversalJournalId,
      originalJournalId: originalJournalId,
      metadata: metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idempotencyKey': idempotencyKey,
      'type': type.name,
      'status': status.name,
      'description': description,
      'entries': entries.map((e) => e.toJson()).toList(),
      'totalDebits': totalDebits,
      'totalCredits': totalCredits,
      'referenceType': referenceType?.name,
      'referenceId': referenceId,
      'initiatedBy': initiatedBy,
      'approvedBy': approvedBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'postedAt': postedAt != null ? Timestamp.fromDate(postedAt!) : null,
      'reversedAt': reversedAt != null ? Timestamp.fromDate(reversedAt!) : null,
      'reversedBy': reversedBy,
      'reversalJournalId': reversalJournalId,
      'originalJournalId': originalJournalId,
      'metadata': metadata,
    };
  }

  static LedgerJournalType _parseJournalType(String? type) {
    switch (type) {
      case 'earn':
        return LedgerJournalType.earn;
      case 'potContribution':
        return LedgerJournalType.potContribution;
      case 'potWin':
        return LedgerJournalType.potWin;
      case 'purchase':
        return LedgerJournalType.purchase;
      case 'referralReward':
        return LedgerJournalType.referralReward;
      case 'p2pTransfer':
        return LedgerJournalType.p2pTransfer;
      case 'cashoutInitiate':
        return LedgerJournalType.cashoutInitiate;
      case 'cashoutComplete':
        return LedgerJournalType.cashoutComplete;
      case 'cashoutFailed':
        return LedgerJournalType.cashoutFailed;
      case 'reversal':
        return LedgerJournalType.reversal;
      case 'adjustment':
        return LedgerJournalType.adjustment;
      case 'clientFund':
        return LedgerJournalType.clientFund;
      case 'clientRefund':
        return LedgerJournalType.clientRefund;
      case 'subaccFund':
        return LedgerJournalType.subaccFund;
      default:
        return LedgerJournalType.earn;
    }
  }

  static LedgerJournalStatus _parseJournalStatus(String? status) {
    switch (status) {
      case 'pending':
        return LedgerJournalStatus.pending;
      case 'posted':
        return LedgerJournalStatus.posted;
      case 'failed':
        return LedgerJournalStatus.failed;
      case 'reversed':
        return LedgerJournalStatus.reversed;
      default:
        return LedgerJournalStatus.pending;
    }
  }

  static LedgerReferenceType? _parseReferenceType(String? type) {
    switch (type) {
      case 'engagement':
        return LedgerReferenceType.engagement;
      case 'purchase':
        return LedgerReferenceType.purchase;
      case 'referral':
        return LedgerReferenceType.referral;
      case 'transfer':
        return LedgerReferenceType.transfer;
      case 'cashout':
        return LedgerReferenceType.cashout;
      case 'potDraw':
        return LedgerReferenceType.potDraw;
      case 'potEntry':
        return LedgerReferenceType.potEntry;
      case 'client_fund':
        return LedgerReferenceType.clientFund;
      default:
        return null;
    }
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }
}
