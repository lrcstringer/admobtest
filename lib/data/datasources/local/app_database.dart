import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ============ TABLE DEFINITIONS ============

/// Local wallet cache
class LocalWallets extends Table {
  TextColumn get id => text()();
  TextColumn get oddienceUserId => text()();
  IntColumn get tokenBalance => integer().withDefault(const Constant(0))();
  IntColumn get pendingBalance => integer().withDefault(const Constant(0))();
  IntColumn get lifetimeEarned => integer().withDefault(const Constant(0))();
  IntColumn get lifetimeCashout => integer().withDefault(const Constant(0))();
  IntColumn get todayEarned => integer().withDefault(const Constant(0))();
  IntColumn get pendingCashout => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastEarnedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local transaction cache
class LocalTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get walletId => text()();
  TextColumn get oddienceUserId => text()();
  TextColumn get type => text()(); // earn, cashout, transfer, purchase, pot_win
  TextColumn get subType => text().nullable()();
  IntColumn get tokenAmount => integer()();
  RealColumn get zarAmount => real()();
  TextColumn get description => text()();
  TextColumn get status => text()(); // pending, completed, failed
  TextColumn get referenceId => text().nullable()();
  TextColumn get referenceType => text().nullable()();
  TextColumn get metadata => text().nullable()(); // JSON string
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local earn thread cache
class LocalEarnThreads extends Table {
  TextColumn get id => text()();
  TextColumn get oddienceUserId => text()();
  TextColumn get campaignId => text()();
  TextColumn get campaignName => text()();
  TextColumn get type => text()(); // video, survey, poll
  TextColumn get status => text()(); // available, in_progress, completed
  IntColumn get rewardAmount => integer()();
  TextColumn get thumbnailUrl => text().nullable()();
  IntColumn get progress => integer().withDefault(const Constant(0))();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local chat thread cache
class LocalChatThreads extends Table {
  TextColumn get id => text()();
  TextColumn get oddienceUserId => text()();
  TextColumn get otherUserId => text()();
  TextColumn get otherUserName => text()();
  TextColumn get otherUserAvatar => text().nullable()();
  TextColumn get lastMessage => text().nullable()();
  DateTimeColumn get lastMessageAt => dateTime().nullable()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local chat message cache
class LocalChatMessages extends Table {
  TextColumn get id => text()();
  TextColumn get threadId => text()();
  TextColumn get senderId => text()();
  TextColumn get recipientId => text()();
  TextColumn get content => text()();
  TextColumn get type => text()(); // text, transfer, request
  TextColumn get status => text()(); // sent, delivered, read
  TextColumn get metadata => text().nullable()(); // JSON string
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local contact cache
class LocalContacts extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get contactUserId => text()();
  TextColumn get displayName => text()();
  TextColumn get username => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get status => text()(); // pending, accepted, blocked
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  TextColumn get nickname => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Pending changes queue for offline sync
class LocalPendingChanges extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityTable => text()();
  TextColumn get recordId => text()();
  TextColumn get changeType => text()(); // insert, update, delete
  TextColumn get changeData => text()(); // JSON string
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

/// Sync metadata storage
class LocalSyncMetadata extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

// ============ DATABASE CLASS ============

@lazySingleton
@DriftDatabase(tables: [
  LocalWallets,
  LocalTransactions,
  LocalEarnThreads,
  LocalChatThreads,
  LocalChatMessages,
  LocalContacts,
  LocalPendingChanges,
  LocalSyncMetadata,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for testing
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future migrations
      },
    );
  }

  // ============ WALLET OPERATIONS ============

  Future<LocalWallet?> getWallet(String oddienceUserId) {
    return (select(localWallets)
          ..where((w) => w.oddienceUserId.equals(oddienceUserId)))
        .getSingleOrNull();
  }

  Future<void> upsertWallet(LocalWalletsCompanion wallet) {
    return into(localWallets).insertOnConflictUpdate(wallet);
  }

  Stream<LocalWallet?> watchWallet(String oddienceUserId) {
    return (select(localWallets)
          ..where((w) => w.oddienceUserId.equals(oddienceUserId)))
        .watchSingleOrNull();
  }

  Future<void> deleteWallet(String oddienceUserId) {
    return (delete(localWallets)
          ..where((w) => w.oddienceUserId.equals(oddienceUserId)))
        .go();
  }

  // ============ TRANSACTION OPERATIONS ============

  Future<List<LocalTransaction>> getTransactions(
    String oddienceUserId, {
    int limit = 50,
    int offset = 0,
  }) {
    return (select(localTransactions)
          ..where((t) => t.oddienceUserId.equals(oddienceUserId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit, offset: offset))
        .get();
  }

  Future<void> upsertTransaction(LocalTransactionsCompanion transaction) {
    return into(localTransactions).insertOnConflictUpdate(transaction);
  }

  Stream<List<LocalTransaction>> watchTransactions(String oddienceUserId) {
    return (select(localTransactions)
          ..where((t) => t.oddienceUserId.equals(oddienceUserId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(50))
        .watch();
  }

  Future<void> deleteTransactions(String oddienceUserId) {
    return (delete(localTransactions)
          ..where((t) => t.oddienceUserId.equals(oddienceUserId)))
        .go();
  }

  // ============ EARN THREAD OPERATIONS ============

  Future<List<LocalEarnThread>> getEarnThreads(String oddienceUserId) {
    return (select(localEarnThreads)
          ..where((t) => t.oddienceUserId.equals(oddienceUserId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<void> upsertEarnThread(LocalEarnThreadsCompanion thread) {
    return into(localEarnThreads).insertOnConflictUpdate(thread);
  }

  Stream<List<LocalEarnThread>> watchEarnThreads(String oddienceUserId) {
    return (select(localEarnThreads)
          ..where((t) => t.oddienceUserId.equals(oddienceUserId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<void> deleteEarnThreads(String oddienceUserId) {
    return (delete(localEarnThreads)
          ..where((t) => t.oddienceUserId.equals(oddienceUserId)))
        .go();
  }

  // ============ CHAT THREAD OPERATIONS ============

  Future<List<LocalChatThread>> getChatThreads(String oddienceUserId) {
    return (select(localChatThreads)
          ..where((t) => t.oddienceUserId.equals(oddienceUserId))
          ..orderBy([(t) => OrderingTerm.desc(t.lastMessageAt)]))
        .get();
  }

  Future<void> upsertChatThread(LocalChatThreadsCompanion thread) {
    return into(localChatThreads).insertOnConflictUpdate(thread);
  }

  Stream<List<LocalChatThread>> watchChatThreads(String oddienceUserId) {
    return (select(localChatThreads)
          ..where((t) => t.oddienceUserId.equals(oddienceUserId))
          ..where((t) => t.isArchived.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.lastMessageAt)]))
        .watch();
  }

  Future<void> deleteChatThreads(String oddienceUserId) {
    return (delete(localChatThreads)
          ..where((t) => t.oddienceUserId.equals(oddienceUserId)))
        .go();
  }

  // ============ CHAT MESSAGE OPERATIONS ============

  Future<List<LocalChatMessage>> getChatMessages(
    String threadId, {
    int limit = 50,
    int offset = 0,
  }) {
    return (select(localChatMessages)
          ..where((m) => m.threadId.equals(threadId))
          ..orderBy([(m) => OrderingTerm.desc(m.createdAt)])
          ..limit(limit, offset: offset))
        .get();
  }

  Future<void> upsertChatMessage(LocalChatMessagesCompanion message) {
    return into(localChatMessages).insertOnConflictUpdate(message);
  }

  Stream<List<LocalChatMessage>> watchChatMessages(String threadId) {
    return (select(localChatMessages)
          ..where((m) => m.threadId.equals(threadId))
          ..orderBy([(m) => OrderingTerm.desc(m.createdAt)])
          ..limit(100))
        .watch();
  }

  Future<void> deleteChatMessages(String threadId) {
    return (delete(localChatMessages)
          ..where((m) => m.threadId.equals(threadId)))
        .go();
  }

  // ============ CONTACT OPERATIONS ============

  Future<List<LocalContact>> getContacts(String userId) {
    return (select(localContacts)
          ..where((c) => c.userId.equals(userId))
          ..orderBy([(c) => OrderingTerm.asc(c.displayName)]))
        .get();
  }

  Future<void> upsertContact(LocalContactsCompanion contact) {
    return into(localContacts).insertOnConflictUpdate(contact);
  }

  Stream<List<LocalContact>> watchContacts(String userId) {
    return (select(localContacts)
          ..where((c) => c.userId.equals(userId))
          ..where((c) => c.status.equals('accepted'))
          ..orderBy([(c) => OrderingTerm.asc(c.displayName)]))
        .watch();
  }

  Future<void> deleteContacts(String userId) {
    return (delete(localContacts)..where((c) => c.userId.equals(userId))).go();
  }

  // ============ SYNC OPERATIONS ============

  Future<DateTime?> getLastSyncTimestamp() async {
    final result = await (select(localSyncMetadata)
          ..where((m) => m.key.equals('lastSyncTimestamp')))
        .getSingleOrNull();
    return result != null ? DateTime.parse(result.value) : null;
  }

  Future<void> updateLastSyncTimestamp(DateTime timestamp) {
    return into(localSyncMetadata).insertOnConflictUpdate(
      LocalSyncMetadataCompanion.insert(
        key: 'lastSyncTimestamp',
        value: timestamp.toIso8601String(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<String?> getSyncMetadata(String key) async {
    final result = await (select(localSyncMetadata)
          ..where((m) => m.key.equals(key)))
        .getSingleOrNull();
    return result?.value;
  }

  Future<void> setSyncMetadata(String key, String value) {
    return into(localSyncMetadata).insertOnConflictUpdate(
      LocalSyncMetadataCompanion.insert(
        key: key,
        value: value,
        updatedAt: DateTime.now(),
      ),
    );
  }

  // ============ PENDING CHANGES OPERATIONS ============

  Future<int> getPendingChangesCount() async {
    final result = await (select(localPendingChanges)
          ..where((c) => c.isSynced.equals(false)))
        .get();
    return result.length;
  }

  Future<List<LocalPendingChange>> getPendingChanges() {
    return (select(localPendingChanges)
          ..where((c) => c.isSynced.equals(false))
          ..orderBy([(c) => OrderingTerm.asc(c.createdAt)]))
        .get();
  }

  Future<void> addPendingChange({
    required String entityTable,
    required String recordId,
    required String changeType,
    required String changeData,
  }) {
    return into(localPendingChanges).insert(
      LocalPendingChangesCompanion.insert(
        entityTable: entityTable,
        recordId: recordId,
        changeType: changeType,
        changeData: changeData,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> markChangeAsSynced(int changeId) {
    return (update(localPendingChanges)
          ..where((c) => c.id.equals(changeId)))
        .write(const LocalPendingChangesCompanion(isSynced: Value(true)));
  }

  Future<void> clearSyncedChanges() {
    return (delete(localPendingChanges)
          ..where((c) => c.isSynced.equals(true)))
        .go();
  }

  // ============ CLEAR ALL DATA ============

  Future<void> clearAllData() async {
    await delete(localWallets).go();
    await delete(localTransactions).go();
    await delete(localEarnThreads).go();
    await delete(localChatThreads).go();
    await delete(localChatMessages).go();
    await delete(localContacts).go();
    await delete(localPendingChanges).go();
    await delete(localSyncMetadata).go();
  }

  Future<void> clearUserData(String userId) async {
    await deleteWallet(userId);
    await deleteTransactions(userId);
    await deleteEarnThreads(userId);
    await deleteChatThreads(userId);
    await deleteContacts(userId);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'imali_local.db'));
    return NativeDatabase.createInBackground(file);
  });
}
