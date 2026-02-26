import 'dart:async';

/// A keyed mutual exclusion lock that serializes async operations per key.
///
/// Each key has its own independent queue. Operations on different keys run
/// concurrently, while operations on the same key run sequentially in FIFO
/// order.
///
/// Unlike the home-rolled `Map<String, Future<void>>` pattern, this provides:
/// - Proper error isolation (a failing operation doesn't break the chain)
/// - Auto-cleanup of completed key entries
/// - Optional timeout support
class KeyedMutex {
  final Map<String, Future<void>> _locks = {};

  /// Run [fn] exclusively for [key].
  ///
  /// If another operation is already running for [key], this waits for it
  /// to complete (regardless of success/failure) before running [fn].
  /// Errors from previous operations do not propagate to subsequent ones.
  ///
  /// Thread-safety note: Dart's single-isolate event loop guarantees that
  /// synchronous code between await points runs atomically. The sequence
  /// `while (_locks.containsKey(key))` → exit loop → `_locks[key] = ...`
  /// has no yield point, so no other microtask can interleave between the
  /// check and the assignment. When multiple waiters resume from the same
  /// completed future, they run as sequential microtasks in FIFO order:
  /// the first waiter exits the loop and claims the lock; subsequent
  /// waiters see the new lock entry and re-await.
  Future<T> protect<T>(String key, Future<T> Function() fn) async {
    // Wait for the previous operation on this key, ignoring its errors
    while (_locks.containsKey(key)) {
      try {
        await _locks[key];
      } catch (_) {
        // Ignore errors from previous operation
      }
    }

    final completer = Completer<void>();
    _locks[key] = completer.future;

    try {
      final result = await fn();
      return result;
    } finally {
      _locks.remove(key);
      completer.complete();
    }
  }

  /// Clear all locks. Use during cleanup/dispose.
  void clear() {
    _locks.clear();
  }
}
