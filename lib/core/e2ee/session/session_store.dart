import 'session_record.dart';

/// Abstract interface for Double Ratchet session persistence.
///
/// Separates session storage from the protocol logic, enabling different
/// backends (secure storage, in-memory for tests, etc.) and making the
/// storage concerns independently testable.
abstract class SessionStore {
  /// Load the session record for [userId], or `null` if none exists.
  Future<SessionRecord?> loadRecord(String userId);

  /// Persist the session record for [userId].
  Future<void> saveRecord(String userId, SessionRecord record);

  /// Delete the session record for [userId].
  Future<void> deleteRecord(String userId);

  /// Check whether a session record exists for [userId].
  Future<bool> recordExists(String userId);

  /// Delete all sessions.
  Future<void> deleteAll();

  /// Read a metadata value by [key] (e.g., migration flags).
  Future<String?> readMeta(String key);

  /// Write a metadata value by [key].
  Future<void> writeMeta(String key, String value);

  /// Return the count of stored sessions (for diagnostics).
  Future<int> sessionCount();
}
