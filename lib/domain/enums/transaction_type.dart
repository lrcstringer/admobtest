/// Types of wallet transactions
enum TransactionType {
  /// Earned from watching ads/surveys
  earn,

  /// Won from daily/weekly pot
  potWin,

  /// Sent to another user
  p2pSend,

  /// Received from another user
  p2pReceive,

  /// Cashed out to external account
  cashout,

  /// Refund from failed transaction
  refund,

  /// Referral bonus
  referral,

  /// Purchase (airtime, electricity, etc.)
  purchase,

  /// Manual adjustment by admin
  adjustment,

  /// Reversal of previous transaction
  reversal,
}

extension TransactionTypeX on TransactionType {
  bool get isCredit =>
      this == TransactionType.earn ||
      this == TransactionType.potWin ||
      this == TransactionType.p2pReceive ||
      this == TransactionType.refund ||
      this == TransactionType.referral ||
      this == TransactionType.adjustment;

  bool get isDebit =>
      this == TransactionType.p2pSend ||
      this == TransactionType.cashout ||
      this == TransactionType.purchase ||
      this == TransactionType.reversal;

  String get displayName {
    switch (this) {
      case TransactionType.earn:
        return 'Earned';
      case TransactionType.potWin:
        return 'Pot Win';
      case TransactionType.p2pSend:
        return 'Sent';
      case TransactionType.p2pReceive:
        return 'Received';
      case TransactionType.cashout:
        return 'Cashout';
      case TransactionType.refund:
        return 'Refund';
      case TransactionType.referral:
        return 'Referral Bonus';
      case TransactionType.purchase:
        return 'Purchase';
      case TransactionType.adjustment:
        return 'Adjustment';
      case TransactionType.reversal:
        return 'Reversal';
    }
  }
}
