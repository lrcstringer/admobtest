enum RefundType {
  buyerDispute,
  sellerInitiated,
  deliveryTimeout,
  adminAction,
  confirmationTimeout,
}

extension RefundTypeX on RefundType {
  String get displayName {
    switch (this) {
      case RefundType.buyerDispute:
        return 'Buyer Dispute';
      case RefundType.sellerInitiated:
        return 'Seller Initiated';
      case RefundType.deliveryTimeout:
        return 'Delivery Timeout';
      case RefundType.adminAction:
        return 'Admin Action';
      case RefundType.confirmationTimeout:
        return 'Confirmation Timeout';
    }
  }
}
