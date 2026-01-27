/// Rate Limiter
/// Prevents abuse by limiting action frequency
library;

class RateLimiter {
  final Map<String, List<DateTime>> _actionTimestamps = {};

  /// Default rate limits for different actions
  static const Map<String, RateLimit> defaultLimits = {
    'earn_ad': RateLimit(maxAttempts: 50, windowMinutes: 60), // 50 ads per hour
    'earn_survey': RateLimit(maxAttempts: 20, windowMinutes: 60), // 20 surveys per hour
    'transfer': RateLimit(maxAttempts: 10, windowMinutes: 5), // 10 transfers per 5 min
    'cashout': RateLimit(maxAttempts: 3, windowMinutes: 60), // 3 cashouts per hour
    'purchase': RateLimit(maxAttempts: 10, windowMinutes: 5), // 10 purchases per 5 min
    'login': RateLimit(maxAttempts: 5, windowMinutes: 15), // 5 login attempts per 15 min
    'otp_request': RateLimit(maxAttempts: 3, windowMinutes: 10), // 3 OTP requests per 10 min
    'referral_apply': RateLimit(maxAttempts: 5, windowMinutes: 60), // 5 referral attempts per hour
  };

  /// Check if action is allowed and record it if so
  bool checkAndRecord(String userId, String action) {
    final key = '$userId:$action';
    final limit = defaultLimits[action];

    if (limit == null) {
      // No limit defined, allow action
      return true;
    }

    final now = DateTime.now();
    final windowStart = now.subtract(Duration(minutes: limit.windowMinutes));

    // Get or create timestamp list
    final timestamps = _actionTimestamps[key] ?? [];

    // Remove old timestamps outside the window
    timestamps.removeWhere((t) => t.isBefore(windowStart));

    // Check if under limit
    if (timestamps.length >= limit.maxAttempts) {
      return false;
    }

    // Record this action
    timestamps.add(now);
    _actionTimestamps[key] = timestamps;

    return true;
  }

  /// Get remaining attempts for an action
  int getRemainingAttempts(String userId, String action) {
    final key = '$userId:$action';
    final limit = defaultLimits[action];

    if (limit == null) {
      return 999; // Unlimited
    }

    final now = DateTime.now();
    final windowStart = now.subtract(Duration(minutes: limit.windowMinutes));

    final timestamps = _actionTimestamps[key] ?? [];
    final validTimestamps = timestamps.where((t) => t.isAfter(windowStart));

    return limit.maxAttempts - validTimestamps.length;
  }

  /// Get time until rate limit resets
  Duration? getTimeUntilReset(String userId, String action) {
    final key = '$userId:$action';
    final limit = defaultLimits[action];

    if (limit == null) {
      return null;
    }

    final timestamps = _actionTimestamps[key] ?? [];
    if (timestamps.isEmpty) {
      return null;
    }

    final oldestTimestamp = timestamps.first;
    final resetTime =
        oldestTimestamp.add(Duration(minutes: limit.windowMinutes));
    final now = DateTime.now();

    if (resetTime.isAfter(now)) {
      return resetTime.difference(now);
    }

    return null;
  }

  /// Clear rate limit data for a user
  void clearUserData(String userId) {
    _actionTimestamps.removeWhere((key, _) => key.startsWith('$userId:'));
  }

  /// Clear all rate limit data
  void clearAll() {
    _actionTimestamps.clear();
  }
}

/// Rate limit configuration
class RateLimit {
  final int maxAttempts;
  final int windowMinutes;

  const RateLimit({
    required this.maxAttempts,
    required this.windowMinutes,
  });
}

/// Rate limit exception
class RateLimitExceededException implements Exception {
  final String action;
  final Duration? timeUntilReset;

  const RateLimitExceededException(this.action, [this.timeUntilReset]);

  @override
  String toString() {
    if (timeUntilReset != null) {
      final minutes = timeUntilReset!.inMinutes;
      return 'Rate limit exceeded for $action. Try again in $minutes minutes.';
    }
    return 'Rate limit exceeded for $action. Please try again later.';
  }
}
