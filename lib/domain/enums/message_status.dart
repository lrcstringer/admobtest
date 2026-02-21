/// Delivery status of a message
enum MessageStatus {
  /// Message is being sent (optimistic UI)
  sending,

  /// Message delivered to server
  sent,

  /// Token request awaiting recipient action
  pending,

  /// Message failed to send
  failed,

  /// Token request was paid/accepted
  paid,

  /// Token request was declined
  declined,
}
