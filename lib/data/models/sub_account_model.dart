import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/sub_account.dart';
import '../../core/utils/firestore_helpers.dart';

part 'sub_account_model.freezed.dart';
part 'sub_account_model.g.dart';

/// Data model for SubAccount
///
/// Maps between Firestore document and SubAccount entity.
/// Collection: ledgerAccounts/{userId}/subAccounts/{subAccountId}
@freezed
abstract class SubAccountModel with _$SubAccountModel {
  const factory SubAccountModel({
    required String id,
    required String userId,
    String? accountTypeId,
    required String name,
    required int balance,
    required int lifetimeCredits,
    required int lifetimeDebits,
    required bool isActive,
    required bool isDefault,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @Default(true) bool allowP2pSend,
    @Default(true) bool allowP2pReceive,
    @Default(true) bool allowCashout,
    @Default(false) bool p2pRestrictToSameAccountType,
    @Default(["*"]) List<String> allowedOfframps,
    int? expiryDays,
    @NullableTimestampConverter() DateTime? lastCreditAt,
  }) = _SubAccountModel;

  const SubAccountModel._();

  factory SubAccountModel.fromJson(Map<String, dynamic> json) =>
      _$SubAccountModelFromJson(json);

  /// Create from Firestore document
  factory SubAccountModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null for ${doc.id}');
    }
    return SubAccountModel.fromJson({
      ...data,
      'id': doc.id,
    });
  }

  /// Convert to domain entity
  SubAccount toEntity() => SubAccount(
        id: id,
        userId: userId,
        accountTypeId: accountTypeId,
        name: name,
        balance: balance,
        lifetimeCredits: lifetimeCredits,
        lifetimeDebits: lifetimeDebits,
        isActive: isActive,
        isDefault: isDefault,
        createdAt: createdAt,
        updatedAt: updatedAt,
        allowP2pSend: allowP2pSend,
        allowP2pReceive: allowP2pReceive,
        allowCashout: allowCashout,
        p2pRestrictToSameAccountType: p2pRestrictToSameAccountType,
        allowedOfframps: allowedOfframps,
        expiryDays: expiryDays,
        lastCreditAt: lastCreditAt,
      );

  /// Create from domain entity
  factory SubAccountModel.fromEntity(SubAccount entity) => SubAccountModel(
        id: entity.id,
        userId: entity.userId,
        accountTypeId: entity.accountTypeId,
        name: entity.name,
        balance: entity.balance,
        lifetimeCredits: entity.lifetimeCredits,
        lifetimeDebits: entity.lifetimeDebits,
        isActive: entity.isActive,
        isDefault: entity.isDefault,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        allowP2pSend: entity.allowP2pSend,
        allowP2pReceive: entity.allowP2pReceive,
        allowCashout: entity.allowCashout,
        p2pRestrictToSameAccountType: entity.p2pRestrictToSameAccountType,
        allowedOfframps: entity.allowedOfframps,
        expiryDays: entity.expiryDays,
        lastCreditAt: entity.lastCreditAt,
      );
}
