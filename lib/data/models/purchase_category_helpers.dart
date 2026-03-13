import '../../domain/entities/purchase.dart';

/// Shared category parser used by both [PurchaseModel] and
/// [ServiceProviderModel] to avoid duplicated switch logic.
PurchaseCategory parsePurchaseCategory(String category) {
  switch (category) {
    case 'airtime':
      return PurchaseCategory.airtime;
    case 'data':
      return PurchaseCategory.data;
    case 'electricity':
      return PurchaseCategory.electricity;
    case 'voucher':
      return PurchaseCategory.voucher;
    case 'marketplace':
      return PurchaseCategory.marketplace;
    case 'school':
      return PurchaseCategory.school;
    case 'municipal':
      return PurchaseCategory.municipal;
    case 'insurance':
      return PurchaseCategory.insurance;
    case 'funeral':
      return PurchaseCategory.funeral;
    case 'stokvel':
      return PurchaseCategory.stokvel;
    case 'gaming':
      return PurchaseCategory.gaming;
    default:
      return PurchaseCategory.other;
  }
}
