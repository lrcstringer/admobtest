import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../enums/sync_status.dart';

/// Sync repository interface for offline-first functionality
abstract class SyncRepository {
  /// Get current sync status
  Stream<SyncStatus> get syncStatus;

  /// Check if device is online
  Future<bool> isOnline();

  /// Stream network connectivity
  Stream<bool> get connectivityStream;

  /// Sync all pending changes
  Future<Either<Failure, void>> syncAll();

  /// Sync specific entity type
  Future<Either<Failure, void>> syncEntity(String entityType);

  /// Get pending sync count
  Future<Either<Failure, int>> getPendingSyncCount();

  /// Get last sync timestamp
  Future<Either<Failure, DateTime?>> getLastSyncTime();

  /// Force full resync
  Future<Either<Failure, void>> forceFullSync();

  /// Clear local cache
  Future<Either<Failure, void>> clearCache();

  /// Queue action for offline sync
  Future<Either<Failure, void>> queueOfflineAction({
    required String actionType,
    required Map<String, dynamic> payload,
  });

  /// Process offline queue
  Future<Either<Failure, void>> processOfflineQueue();
}
