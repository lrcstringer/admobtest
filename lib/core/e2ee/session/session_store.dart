import 'double_ratchet_session.dart';

/// Abstract interface for Double Ratchet session persistence.
///
/// Separates session storage from the protocol logic, enabling different
/// backends (secure storage, in-memory for tests, etc.) and making the
/// storage concerns independently testable.
abstract class SessionStore {
  /// Load the session for [userId], or `null` if none exists.
  Future<DoubleRatchetSession?> load(String userId);

  /// Persist the session for [userId].
  Future<void> save(String userId, DoubleRatchetSession session);

  /// Delete the session for [userId].
  Future<void> delete(String userId);

  /// Check whether a session exists for [userId].
  Future<bool> exists(String userId);

  /// Delete all sessions.
  Future<void> deleteAll();

  /// Read a metadata value by [key] (e.g., migration flags).
  Future<String?> readMeta(String key);

  /// Write a metadata value by [key].
  Future<void> writeMeta(String key, String value);

  /// Return the count of stored sessions (for diagnostics).
  Future<int> sessionCount();
}
