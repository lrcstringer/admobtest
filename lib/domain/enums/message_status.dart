/// Delivery status of a message
enum MessageStatus {
  /// Message is being sent (optimistic UI)
  sending,

  /// Message delivered to server
  sent,

  /// Message delivered to recipient device
  delivered,

  /// Message read by recipient
  read,

  /// Token request awaiting recipient action
  pending,

  /// Message failed to send
  failed,

  /// Token request was paid/accepted
  paid,

  /// Token request was declined
  declined,

  /// Token request has expired (7-day TTL elapsed)
  expired,
}
