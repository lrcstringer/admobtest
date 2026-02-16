import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/ledger_account.dart';

/// Model for LedgerAccount that handles Firestore serialization
class LedgerAccountModel {
  final String id;
  final LedgerAccountType type;
  final String name;
  final String? ownerId;
  final int balance;
  final int allocatedBalance;
  final String currency;
  final LedgerAccountStatus status;
  final Map<String, dynamic> metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  const LedgerAccountModel({
    required this.id,
    required this.type,
    required this.name,
    this.ownerId,
    required this.balance,
    this.allocatedBalance = 0,
    this.currency = 'TOKEN',
    required this.status,
    this.metadata = const {},
    required this.createdAt,
    required this.updatedAt,
    this.version = 1,
  });

  factory LedgerAccountModel.fromJson(Map<String, dynamic> json) {
    return LedgerAccountModel(
      id: json['id'] as String,
      type: _parseAccountType(json['type'] as String?),
      name: json['name'] as String? ?? '',
      ownerId: json['ownerId'] as String?,
      balance: (json['balance'] as num?)?.toInt() ?? 0,
      allocatedBalance: (json['allocatedBalance'] as num?)?.toInt()
          ?? (json['totalBalance'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? 'TOKEN',
      status: _parseAccountStatus(json['status'] as String?),
      metadata: (json['metadata'] as Map<String, dynamic>?) ?? {},
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
      version: (json['version'] as num?)?.toInt() ?? 1,
    );
  }

  factory LedgerAccountModel.fromEntity(LedgerAccount entity) {
    return LedgerAccountModel(
      id: entity.id,
      type: entity.type,
      name: entity.name,
      ownerId: entity.ownerId,
      balance: entity.balance,
      allocatedBalance: entity.allocatedBalance,
      currency: entity.currency,
      status: entity.status,
      metadata: entity.metadata,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      version: entity.version,
    );
  }

  LedgerAccount toEntity() {
    return LedgerAccount(
      id: id,
      type: type,
      name: name,
      ownerId: ownerId,
      balance: balance,
      allocatedBalance: allocatedBalance,
      currency: currency,
      status: status,
      metadata: metadata,
      createdAt: createdAt,
      updatedAt: updatedAt,
      version: version,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'name': name,
      'ownerId': ownerId,
      'balance': balance,
      'allocatedBalance': allocatedBalance,
      'currency': currency,
      'status': status.name,
      'metadata': metadata,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'version': version,
    };
  }

  static LedgerAccountType _parseAccountType(String? type) {
    switch (type) {
      case 'system':
        return LedgerAccountType.system;
      case 'pot':
        return LedgerAccountType.pot;
      case 'user':
        return LedgerAccountType.user;
      case 'supplier':
        return LedgerAccountType.supplier;
      case 'cbook':
        return LedgerAccountType.cbook;
      case 'client_subacc':
        return LedgerAccountType.clientSubacc;
      case 'client':
        return LedgerAccountType.client;
      case 'group':
        return LedgerAccountType.group;
      default:
        return LedgerAccountType.user;
    }
  }

  static LedgerAccountStatus _parseAccountStatus(String? status) {
    switch (status) {
      case 'active':
        return LedgerAccountStatus.active;
      case 'frozen':
        return LedgerAccountStatus.frozen;
      case 'closed':
        return LedgerAccountStatus.closed;
      default:
        return LedgerAccountStatus.active;
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
