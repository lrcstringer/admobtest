/// Sync status for offline-first data
enum SyncStatus {
  /// Data is synced with server
  synced,

  /// Data is pending sync
  pending,

  /// Data failed to sync
  failed,
}

extension SyncStatusX on SyncStatus {
  bool get isSynced => this == SyncStatus.synced;
  bool get isPending => this == SyncStatus.pending;
  bool get isFailed => this == SyncStatus.failed;
}
