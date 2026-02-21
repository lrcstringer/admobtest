import 'dart:io';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/open.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';

part 'app_database.g.dart';

// ============ TABLE DEFINITIONS ============

/// Local wallet cache
class LocalWallets extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get tokenBalance => integer().withDefault(const Constant(0))();
  IntColumn get pendingBalance => integer().withDefault(const Constant(0))();
  IntColumn get lifetimeEarned => integer().withDefault(const Constant(0))();
  IntColumn get lifetimeWithdrawn => integer().withDefault(const Constant(0))();
  IntColumn get todayEarned => integer().withDefault(const Constant(0))();
  IntColumn get pendingWithdrawal => integer().withDefault(const Constant(0))();
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
  TextColumn get userId => text()();
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
  TextColumn get userId => text()();
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
  TextColumn get userId => text()();
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

/// Persistent cache of decrypted E2EE message plaintext.
/// Prevents "Encrypted message" / "Cannot decrypt" after app restart.
class DecryptedMessageCache extends Table {
  TextColumn get messageId => text()();
  TextColumn get plaintext => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {messageId};
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
  DecryptedMessageCache,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for testing
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(decryptedMessageCache);
        }
      },
    );
  }

  // ============ WALLET OPERATIONS ============

  Future<LocalWallet?> getWallet(String userId) {
    return (select(localWallets)
          ..where((w) => w.userId.equals(userId)))
        .getSingleOrNull();
  }

  Future<void> upsertWallet(LocalWalletsCompanion wallet) {
    return into(localWallets).insertOnConflictUpdate(wallet);
  }

  Stream<LocalWallet?> watchWallet(String userId) {
    return (select(localWallets)
          ..where((w) => w.userId.equals(userId)))
        .watchSingleOrNull();
  }

  Future<void> deleteWallet(String userId) {
    return (delete(localWallets)
          ..where((w) => w.userId.equals(userId)))
        .go();
  }

  // ============ TRANSACTION OPERATIONS ============

  Future<List<LocalTransaction>> getTransactions(
    String userId, {
    int limit = 50,
    int offset = 0,
  }) {
    return (select(localTransactions)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit, offset: offset))
        .get();
  }

  Future<void> upsertTransaction(LocalTransactionsCompanion transaction) {
    return into(localTransactions).insertOnConflictUpdate(transaction);
  }

  Stream<List<LocalTransaction>> watchTransactions(String userId) {
    return (select(localTransactions)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(50))
        .watch();
  }

  Future<void> deleteTransactions(String userId) {
    return (delete(localTransactions)
          ..where((t) => t.userId.equals(userId)))
        .go();
  }

  // ============ EARN THREAD OPERATIONS ============

  Future<List<LocalEarnThread>> getEarnThreads(String userId) {
    return (select(localEarnThreads)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  Future<void> upsertEarnThread(LocalEarnThreadsCompanion thread) {
    return into(localEarnThreads).insertOnConflictUpdate(thread);
  }

  Stream<List<LocalEarnThread>> watchEarnThreads(String userId) {
    return (select(localEarnThreads)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<void> deleteEarnThreads(String userId) {
    return (delete(localEarnThreads)
          ..where((t) => t.userId.equals(userId)))
        .go();
  }

  // ============ CHAT THREAD OPERATIONS ============

  Future<List<LocalChatThread>> getChatThreads(String userId) {
    return (select(localChatThreads)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.lastMessageAt)]))
        .get();
  }

  Future<void> upsertChatThread(LocalChatThreadsCompanion thread) {
    return into(localChatThreads).insertOnConflictUpdate(thread);
  }

  Stream<List<LocalChatThread>> watchChatThreads(String userId) {
    return (select(localChatThreads)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.isArchived.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.lastMessageAt)]))
        .watch();
  }

  Future<void> deleteChatThreads(String userId) {
    return (delete(localChatThreads)
          ..where((t) => t.userId.equals(userId)))
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

  // ============ DECRYPTED MESSAGE CACHE ============

  Future<String?> getDecryptedPlaintext(String messageId) async {
    final result = await (select(decryptedMessageCache)
          ..where((m) => m.messageId.equals(messageId)))
        .getSingleOrNull();
    return result?.plaintext;
  }

  Future<void> cacheDecryptedPlaintext(String messageId, String plaintext) {
    return into(decryptedMessageCache).insertOnConflictUpdate(
      DecryptedMessageCacheCompanion.insert(
        messageId: messageId,
        plaintext: plaintext,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> clearDecryptedMessages() {
    return delete(decryptedMessageCache).go();
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
    await clearDecryptedMessages();
  }

  Future<void> clearUserData(String userId) async {
    await deleteWallet(userId);
    await deleteTransactions(userId);
    await deleteEarnThreads(userId);
    await deleteChatThreads(userId);
    await deleteContacts(userId);
    await clearDecryptedMessages();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Load sqlcipher native library on Android
    open.overrideFor(OperatingSystem.android, openCipherOnAndroid);

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'imali_local_encrypted.db'));

    // Retrieve or generate encryption key from secure storage
    const storage = FlutterSecureStorage();
    String? key = await storage.read(key: 'imali_db_encryption_key');
    if (key == null) {
      final random = Random.secure();
      final bytes = List.generate(32, (_) => random.nextInt(256));
      key = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
      await storage.write(key: 'imali_db_encryption_key', value: key);
    }

    // Delete old unencrypted database if it exists (cache only — syncs from Firestore)
    final oldFile = File(p.join(dbFolder.path, 'imali_local.db'));
    if (await oldFile.exists()) {
      await oldFile.delete();
    }

    return NativeDatabase.createInBackground(
      file,
      setup: (db) {
        db.execute("PRAGMA key = '$key'");
      },
    );
  });
}
