/// WebRTC connection quality classification based on RTT, packet loss, and jitter.
enum ConnectionQuality {
  /// RTT < 100ms, loss < 1%, jitter < 20ms.
  excellent,

  /// RTT < 200ms, loss < 3%, jitter < 40ms.
  good,

  /// RTT < 400ms, loss < 5%, jitter < 60ms.
  fair,

  /// RTT >= 400ms or loss >= 5% or jitter >= 60ms.
  poor,
}
