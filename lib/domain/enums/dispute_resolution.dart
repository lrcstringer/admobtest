enum DisputeResolution {
  refundBuyer,
  releaseToSeller,
  partialRefund,
  requireReturn,
  split,
}

extension DisputeResolutionX on DisputeResolution {
  String get displayName {
    switch (this) {
      case DisputeResolution.refundBuyer:
        return 'Refund Buyer';
      case DisputeResolution.releaseToSeller:
        return 'Release to Seller';
      case DisputeResolution.partialRefund:
        return 'Partial Refund';
      case DisputeResolution.requireReturn:
        return 'Require Return';
      case DisputeResolution.split:
        return 'Split 50/50';
    }
  }
}
