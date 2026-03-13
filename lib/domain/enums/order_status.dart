/// Status of a marketplace order
enum OrderStatus {
  pending,
  escrowed,
  fulfilled,
  completed,
  disputed,
  refunding,
  refunded,
  cancelled,
}

extension OrderStatusX on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.escrowed:
        return 'In Escrow';
      case OrderStatus.fulfilled:
        return 'Fulfilled';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.disputed:
        return 'Disputed';
      case OrderStatus.refunding:
        return 'Refunding';
      case OrderStatus.refunded:
        return 'Refunded';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive =>
      this == OrderStatus.pending ||
      this == OrderStatus.escrowed ||
      this == OrderStatus.fulfilled ||
      this == OrderStatus.disputed ||
      this == OrderStatus.refunding;

  bool get isTerminal =>
      this == OrderStatus.completed ||
      this == OrderStatus.refunded ||
      this == OrderStatus.cancelled;
}
