import 'dart:io';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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

/// Pending outgoing messages queue for offline-first sends.
/// Messages are persisted here before network send, surviving app kills.
class LocalPendingMessages extends Table {
  TextColumn get id => text()(); // optimistic ID (uuid)
  TextColumn get conversationId => text()(); // P2P conversationId or communityId
  TextColumn get type =>
      text()(); // text, media, forward, community_text, community_media,
  //              token_send, token_request
  TextColumn get plaintext => text().nullable()(); // message text
  TextColumn get recipientId => text().nullable()(); // for P2P E2EE
  TextColumn get replyToMessageId => text().nullable()();
  TextColumn get payloadJson =>
      text().nullable()(); // serialized extra params (media URL, amount, etc.)
  TextColumn get status =>
      text()(); // pending, encrypting, sending, sent, failed
  TextColumn get errorMessage => text().nullable()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local community cache for offline-first architecture.
class LocalCommunities extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // CommunityType enum name
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get ownerId => text()();
  TextColumn get memberIdsJson => text()(); // JSON List<String>
  TextColumn get adminIdsJson => text()(); // JSON List<String>
  IntColumn get memberCount => integer()();
  IntColumn get totalBalance => integer().withDefault(const Constant(0))();
  TextColumn get status => text()();
  TextColumn get settingsJson => text()(); // JSON CommunitySettings
  TextColumn get stokvelSettingsJson => text().nullable()();
  TextColumn get lastMessageText => text().nullable()();
  TextColumn get lastMessageSenderId => text().nullable()();
  TextColumn get lastMessageSenderName => text().nullable()();
  TextColumn get lastMessageType => text().nullable()();
  DateTimeColumn get lastMessageAt => dateTime().nullable()();
  TextColumn get unreadCountsJson =>
      text().withDefault(const Constant('{}'))();
  TextColumn get mutedJson => text().withDefault(const Constant('{}'))();
  TextColumn get encryptedPreviewsJson =>
      text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local community member cache for offline-first architecture.
class LocalCommunityMembers extends Table {
  TextColumn get id => text()(); // communityId_userId
  TextColumn get communityId => text()();
  TextColumn get userId => text()();
  TextColumn get displayName => text()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get role => text()(); // MemberRole enum name
  TextColumn get status => text()(); // MemberStatus enum name
  IntColumn get contributionBalance =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get joinedAt => dateTime().nullable()();
  TextColumn get invitedBy => text().withDefault(const Constant(''))();
  DateTimeColumn get invitedAt => dateTime().nullable()();
  DateTimeColumn get lastReadAt => dateTime().nullable()();
  TextColumn get communityName => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
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

/// Full message entity stored locally for offline-first architecture.
/// Stores decrypted plaintext — messages are decrypted once on receipt
/// by MessageSyncService and never re-decrypted.
class LocalFullMessages extends Table {
  TextColumn get id => text()();
  TextColumn get conversationId => text()();
  TextColumn get senderId => text()();
  TextColumn get senderName => text()();
  TextColumn get senderAvatarUrl => text().nullable()();
  TextColumn get type => text()(); // MessageType enum name
  TextColumn get status => text()(); // MessageStatus enum name
  TextColumn get textContent => text().nullable()(); // DECRYPTED plaintext
  IntColumn get tokenAmount => integer().nullable()();
  TextColumn get recipientId => text().nullable()();
  TextColumn get ledgerJournalId => text().nullable()();
  TextColumn get mediaJson => text().nullable()(); // JSON MessageMedia
  TextColumn get reactionsJson => text().nullable()(); // JSON Map<String, List<String>>
  TextColumn get replyToJson => text().nullable()(); // JSON MessageReply
  TextColumn get giftJson => text().nullable()(); // JSON GiftMessageData
  TextColumn get groupGiftJson => text().nullable()(); // JSON GroupGiftMessageData
  TextColumn get tokenSprayJson => text().nullable()(); // JSON TokenSprayMessageData
  TextColumn get communityId => text().nullable()();
  TextColumn get systemEventType => text().nullable()();
  TextColumn get systemEventDataJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  DateTimeColumn get actionedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get deletedForJson => text().withDefault(const Constant('[]'))();
  BoolColumn get deletedForEveryone =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isDecrypted =>
      boolean().withDefault(const Constant(false))();

  // Read receipts & forwarding (Feature 1 & 4)
  TextColumn get readByJson =>
      text().withDefault(const Constant('{}'))();
  TextColumn get forwardedFromJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Full conversation entity stored locally for offline-first architecture.
/// Stores decrypted last message preview — no on-the-fly decryption needed.
class LocalFullConversations extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // ConversationType enum name
  TextColumn get participantIdsJson => text()(); // JSON List<String>
  TextColumn get participantsJson => text()(); // JSON Map<String, ParticipantInfo>
  TextColumn get lastMessageId => text().nullable()();
  TextColumn get lastMessageText => text().nullable()(); // DECRYPTED preview
  TextColumn get lastMessageSenderId => text().nullable()();
  TextColumn get lastMessageSenderName => text().nullable()();
  TextColumn get lastMessageType => text().nullable()();
  DateTimeColumn get lastMessageAt => dateTime().nullable()();
  TextColumn get unreadCountsJson =>
      text().withDefault(const Constant('{}'))();
  TextColumn get archivedJson => text().withDefault(const Constant('{}'))();
  TextColumn get pinnedJson => text().withDefault(const Constant('{}'))();
  TextColumn get mutedJson => text().withDefault(const Constant('{}'))();
  TextColumn get chatClearedAtJson =>
      text().withDefault(const Constant('{}'))();
  TextColumn get acceptedJson => text().withDefault(const Constant('{}'))();
  IntColumn get disappearingMessagesDurationMs => integer().nullable()();
  /// Persisted chat wallpaper theme (ChatThemeStyle enum name).
  TextColumn get chatTheme => text().withDefault(const Constant('defaultDoodle'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local buy category cache (offline-first)
class LocalBuyCategories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get iconEmoji => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isComingSoon => boolean().withDefault(const Constant(false))();
  TextColumn get purchaseCategoryMapping => text().nullable()();
  TextColumn get featureFlagKey => text().nullable()();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get backgroundColor => text().nullable()();
  /// JSON-encoded list of subcategory objects: [{"id":"...","name":"...","iconEmoji":"..."}]
  TextColumn get subcategoriesJson => text().withDefault(const Constant('[]'))();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local buy regulars cache (offline-first)
class LocalBuyRegulars extends Table {
  TextColumn get id => text()();
  TextColumn get providerId => text()();
  TextColumn get productId => text()();
  TextColumn get providerName => text()();
  TextColumn get productName => text()();
  TextColumn get recipientNumber => text()();
  TextColumn get recipientLabel => text().nullable()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  IntColumn get usageCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUsedAt => dateTime()();
  TextColumn get categoryEmoji => text().nullable()();
  TextColumn get purchaseCategoryMapping => text().nullable()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Local featured items cache (offline-first)
class LocalFeaturedItems extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get subtitle => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get videoUrl => text().nullable()();
  TextColumn get type => text().withDefault(const Constant('campaign'))();
  TextColumn get deepLinkRoute => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get bgGradientType =>
      text().withDefault(const Constant('goldOrange'))();
  // Fields added in schema v12 for full entity parity
  TextColumn get brandId => text().nullable()();
  TextColumn get communityIdsJson => text().withDefault(const Constant('[]'))();
  DateTimeColumn get scheduledStart => dateTime().nullable()();
  DateTimeColumn get scheduledEnd => dateTime().nullable()();
  TextColumn get brandName => text().nullable()();
  TextColumn get ctaText => text().nullable()();
  TextColumn get bgColorHex => text().nullable()();
  RealColumn get colorIntensity =>
      real().withDefault(const Constant(0.4))();
  RealColumn get imageOpacity =>
      real().withDefault(const Constant(1.0))();
  TextColumn get imageLayout =>
      text().withDefault(const Constant('right'))();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// ============ BUY TAB CACHE TABLES (Spec §12.1) ============

/// Offline brand storefront cache, TTL 1hr
class LocalBrandStorefronts extends Table {
  TextColumn get id => text()();
  TextColumn get brandId => text()();
  TextColumn get brandName => text()();
  TextColumn get dataJson => text()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline brand products cache, TTL 30min
class LocalBrandProducts extends Table {
  TextColumn get id => text()();
  TextColumn get storefrontId => text()();
  TextColumn get dataJson => text()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline brand reviews cache, top 20 per brand, TTL 30min
class LocalBrandReviews extends Table {
  TextColumn get id => text()();
  TextColumn get brandId => text()();
  TextColumn get dataJson => text()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline group buys cache, active only, TTL 15min
class LocalGroupBuys extends Table {
  TextColumn get id => text()();
  TextColumn get dataJson => text()();
  TextColumn get status => text()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline group buy requests cache, user's own, TTL 1hr
class LocalGroupBuyRequests extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get dataJson => text()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline marketplace listings cache, top 50 recent, TTL 30min
class LocalMarketplaceListings extends Table {
  TextColumn get id => text()();
  TextColumn get dataJson => text()();
  TextColumn get category => text().nullable()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline marketplace orders cache, user's own, TTL 15min
class LocalMarketplaceOrders extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get dataJson => text()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Shipped SA location database (~22K rows)
class LocalSaLocations extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()(); // province, city, suburb
  TextColumn get parentId => text().nullable()();
  TextColumn get province => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get postalCode => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline favourites/saved listings cache
class LocalSavedListings extends Table {
  TextColumn get listingId => text()();
  DateTimeColumn get savedAt => dateTime()();
  TextColumn get listingTitle => text().nullable()();
  IntColumn get listingPrice => integer().nullable()();
  TextColumn get listingThumbnailUrl => text().nullable()();
  TextColumn get listingStatus => text().nullable()();
  TextColumn get sellerName => text().nullable()();

  @override
  Set<Column> get primaryKey => {listingId};
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
  LocalFullMessages,
  LocalFullConversations,
  LocalPendingMessages,
  LocalCommunities,
  LocalCommunityMembers,
  LocalBuyCategories,
  LocalBuyRegulars,
  LocalFeaturedItems,
  // New Buy tab cache tables (Phase 0.9)
  LocalBrandStorefronts,
  LocalBrandProducts,
  LocalBrandReviews,
  LocalGroupBuys,
  LocalGroupBuyRequests,
  LocalMarketplaceListings,
  LocalMarketplaceOrders,
  LocalSaLocations,
  LocalSavedListings,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for testing
  AppDatabase.forTesting(super.e);

  /// Force the LazyDatabase connection to open eagerly.
  ///
  /// The encrypted DB setup (FlutterSecureStorage key read + SQLCipher open)
  /// can take 1-3s on some devices. Call this during app startup so the
  /// conversation list reads are instant when the messaging screen mounts.
  Future<void> warmUp() async {
    await customSelect('SELECT 1').get();
  }

  @override
  int get schemaVersion => 17;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // FTS5 virtual table for fast message search (not managed by Drift)
        await customStatement(
          'CREATE VIRTUAL TABLE IF NOT EXISTS message_fts '
          'USING fts5(text_content, rowid_ref UNINDEXED)',
        );
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(decryptedMessageCache);
        }
        if (from < 3) {
          await m.createTable(localFullMessages);
          await m.createTable(localFullConversations);
        }
        if (from < 4) {
          await m.addColumn(
              localFullConversations, localFullConversations.acceptedJson);
        }
        if (from < 5) {
          await m.addColumn(
              localFullMessages, localFullMessages.readByJson);
          await m.addColumn(
              localFullMessages, localFullMessages.forwardedFromJson);
        }
        if (from < 6) {
          await m.addColumn(
              localFullConversations,
              localFullConversations.disappearingMessagesDurationMs);
        }
        if (from < 7) {
          await m.createTable(localPendingMessages);
          await m.createTable(localCommunities);
          await m.createTable(localCommunityMembers);
        }
        if (from < 8) {
          await m.addColumn(
              localCommunityMembers, localCommunityMembers.communityName);
        }
        if (from < 9) {
          await m.addColumn(
              localFullMessages, localFullMessages.groupGiftJson);
        }
        if (from < 10) {
          await m.createTable(localBuyCategories);
        }
        if (from < 11) {
          await m.createTable(localBuyRegulars);
          await m.createTable(localFeaturedItems);
        }
        if (from < 12) {
          // Add missing featured item fields for full entity parity
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.brandId);
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.communityIdsJson);
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.scheduledStart);
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.scheduledEnd);
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.brandName);
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.ctaText);
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.bgColorHex);
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.colorIntensity);
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.imageOpacity);
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.imageLayout);
        }
        if (from < 13) {
          await m.addColumn(
              localBuyCategories, localBuyCategories.subcategoriesJson);
        }
        if (from < 14) {
          await m.addColumn(
              localFeaturedItems, localFeaturedItems.videoUrl);
        }
        if (from < 15) {
          // Phase 0.9: Add 9 new Buy tab cache tables + drop LocalBuyRegulars
          await m.deleteTable('local_buy_regulars');
          await m.createTable(localBrandStorefronts);
          await m.createTable(localBrandProducts);
          await m.createTable(localBrandReviews);
          await m.createTable(localGroupBuys);
          await m.createTable(localGroupBuyRequests);
          await m.createTable(localMarketplaceListings);
          await m.createTable(localMarketplaceOrders);
          await m.createTable(localSaLocations);
          await m.createTable(localSavedListings);
        }
        if (from < 16) {
          // FTS5 virtual table for fast in-conversation message search.
          // rowid_ref maps to local_full_messages.id (text PK, stored as-is).
          // content is NOT synced — we use a content-less (external content)
          // approach: FTS stores its own copy of text_content, indexed by
          // rowid_ref. This avoids triggers and keeps the FTS table small.
          await customStatement(
            'CREATE VIRTUAL TABLE IF NOT EXISTS message_fts '
            'USING fts5(text_content, rowid_ref UNINDEXED)',
          );
          // Backfill existing messages into the FTS index
          await customStatement(
            'INSERT OR IGNORE INTO message_fts (rowid_ref, text_content) '
            'SELECT id, text_content FROM local_full_messages '
            'WHERE text_content IS NOT NULL AND text_content != \'\'',
          );
        }
        if (from < 17) {
          await m.addColumn(
              localFullConversations, localFullConversations.chatTheme);
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

  // ============ LOCAL FULL MESSAGE OPERATIONS ============

  Stream<List<LocalFullMessage>> watchLocalMessages(
    String conversationId, {
    int limit = 50,
  }) {
    return (select(localFullMessages)
          ..where((m) => m.conversationId.equals(conversationId))
          ..orderBy([(m) => OrderingTerm.desc(m.createdAt)])
          ..limit(limit))
        .watch();
  }

  Future<List<LocalFullMessage>> getLocalMessages(
    String conversationId, {
    int limit = 50,
    DateTime? before,
  }) {
    return (select(localFullMessages)
          ..where((m) {
            final conv = m.conversationId.equals(conversationId);
            if (before != null) {
              return conv & m.createdAt.isSmallerThanValue(before);
            }
            return conv;
          })
          ..orderBy([(m) => OrderingTerm.desc(m.createdAt)])
          ..limit(limit))
        .get();
  }

  /// Fetch ALL messages for a conversation in ascending (chronological) order.
  /// Excludes soft-deleted messages. Used by conversation export.
  Future<List<LocalFullMessage>> getAllLocalMessagesAsc(
      String conversationId) {
    return (select(localFullMessages)
          ..where((m) =>
              m.conversationId.equals(conversationId) &
              m.deletedForEveryone.equals(false))
          ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]))
        .get();
  }

  Future<void> upsertLocalMessage(LocalFullMessagesCompanion message) {
    return into(localFullMessages).insertOnConflictUpdate(message);
  }

  Future<void> upsertLocalMessages(
      List<LocalFullMessagesCompanion> messages) async {
    await batch((b) {
      for (final msg in messages) {
        b.insert(localFullMessages, msg, onConflict: DoUpdate((_) => msg));
      }
    });
  }

  Future<void> deleteLocalMessage(String messageId) {
    return (delete(localFullMessages)..where((m) => m.id.equals(messageId)))
        .go();
  }

  Future<void> deleteLocalMessagesForConversation(String conversationId) {
    return (delete(localFullMessages)
          ..where((m) => m.conversationId.equals(conversationId)))
        .go();
  }

  /// Delete all locally-stored messages whose [expiresAt] is in the past.
  ///
  /// Called periodically by [MessageSyncService] to enforce the client-side
  /// half of disappearing messages (server-side cleanup runs via a scheduled CF).
  Future<int> deleteExpiredMessages() {
    final now = DateTime.now();
    return (delete(localFullMessages)
          ..where(
            (m) => m.expiresAt.isNotNull() & m.expiresAt.isSmallerThanValue(now),
          ))
        .go();
  }

  /// Delete messages with temporary decryption failure sentinels so the sync
  /// service will re-fetch them from Firestore and retry with restored keys.
  ///
  /// Only purges `[Cannot decrypt]` (temporary, retryable). Does NOT purge:
  /// - `[Sent by you]` — permanent fallback for own messages after reinstall;
  ///   purging these removes them permanently (backfill won't re-fetch).
  /// - `[Session expired …]` — permanent; re-fetching won't help because the
  ///   E2EE session keys are gone.
  Future<int> purgeUndecryptableMessages() {
    return (delete(localFullMessages)
          ..where((m) => m.textContent.equals('[Cannot decrypt]')))
        .go();
  }

  Future<LocalFullMessage?> getLatestLocalMessage(String conversationId) {
    return (select(localFullMessages)
          ..where((m) => m.conversationId.equals(conversationId))
          ..orderBy([(m) => OrderingTerm.desc(m.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<LocalFullMessage?> getLocalMessageById(String messageId) {
    return (select(localFullMessages)..where((m) => m.id.equals(messageId)))
        .getSingleOrNull();
  }

  /// Count messages in a conversation. Used to decide whether historical
  /// backfill is needed (0 = fresh install, skip backfill otherwise).
  Future<int> getMessageCount(String conversationId) async {
    final count = countAll();
    final query = selectOnly(localFullMessages)
      ..addColumns([count])
      ..where(localFullMessages.conversationId.equals(conversationId));
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  /// Get undecrypted messages from a specific sender in a conversation.
  ///
  /// Used to retry decryption after a session is established with the sender.
  Future<List<LocalFullMessage>> getUndecryptedMessages(
    String conversationId,
    String senderId,
  ) {
    return (select(localFullMessages)
          ..where((m) =>
              m.conversationId.equals(conversationId) &
              m.senderId.equals(senderId) &
              m.isDecrypted.equals(false))
          ..orderBy([(m) => OrderingTerm.asc(m.createdAt)])
          ..limit(50))
        .get();
  }

  /// Clear the permanent failure sentinel for undecrypted messages from
  /// [senderId] in [conversationId], allowing them to be retried.
  ///
  /// Called when a valid E2EE session is established with the sender.
  /// Changes `[Session expired — message cannot be recovered]` back to
  /// `[Cannot decrypt]` so the next Firestore snapshot triggers a retry.
  Future<int> clearPermanentSentinel(
    String conversationId,
    String senderId,
  ) {
    const sentinel = '[Session expired — message cannot be recovered]';
    return (update(localFullMessages)
          ..where((m) =>
              m.conversationId.equals(conversationId) &
              m.senderId.equals(senderId) &
              m.isDecrypted.equals(false) &
              m.textContent.equals(sentinel)))
        .write(const LocalFullMessagesCompanion(
      textContent: Value('[Cannot decrypt]'),
    ));
  }

  Future<void> updateLocalMessageStatus(String messageId, String status) {
    return (update(localFullMessages)..where((m) => m.id.equals(messageId)))
        .write(LocalFullMessagesCompanion(status: Value(status)));
  }

  // ============ LOCAL FULL CONVERSATION OPERATIONS ============

  Stream<List<LocalFullConversation>> watchLocalConversations() {
    return (select(localFullConversations)
          ..orderBy([(c) => OrderingTerm.desc(c.lastMessageAt)]))
        .watch();
  }

  /// Watch conversations excluding archived ones for a specific user.
  /// Reduces stream throughput — archived conversations don't trigger UI rebuilds.
  Stream<List<LocalFullConversation>> watchActiveConversations(String userId) {
    // SQLite json_extract is available since SQLite 3.9.0 (Android 7+, iOS 16+).
    // The archivedJson column stores a JSON object like {"userId": true}.
    // We exclude rows where json_extract(archived_json, '$.<userId>') = 1.
    // Fall back to full list if json_extract is unavailable (shouldn't happen
    // on any supported device).
    final archivedPath = '\$.${userId.replaceAll("'", "''")}';
    return customSelect(
      'SELECT * FROM local_full_conversations '
      'WHERE IFNULL(json_extract(archived_json, ?), 0) != 1 '
      'ORDER BY last_message_at DESC',
      variables: [Variable.withString(archivedPath)],
      readsFrom: {localFullConversations},
    ).watch().map((rows) {
      return rows
          .map((row) => localFullConversations.map(row.data))
          .toList();
    });
  }

  /// Compute total unread count at the SQL level. Only selects the
  /// unread_counts_json column — avoids materializing full conversation objects.
  Stream<int> watchTotalUnreadCountSql(String userId) {
    // json_extract pulls the integer unread count for the specific user
    // directly in SQL, then SUM aggregates across all conversations.
    final unreadPath = '\$.${userId.replaceAll("'", "''")}';
    return customSelect(
      'SELECT IFNULL(SUM(IFNULL(json_extract(unread_counts_json, ?), 0)), 0) '
      'AS total FROM local_full_conversations',
      variables: [Variable.withString(unreadPath)],
      readsFrom: {localFullConversations},
    ).watch().map((rows) {
      if (rows.isEmpty) return 0;
      return rows.first.read<int>('total');
    });
  }

  Future<List<LocalFullConversation>> getLocalConversations() {
    return (select(localFullConversations)
          ..orderBy([(c) => OrderingTerm.desc(c.lastMessageAt)]))
        .get();
  }

  Future<void> upsertLocalConversation(
      LocalFullConversationsCompanion conversation) {
    return into(localFullConversations).insertOnConflictUpdate(conversation);
  }

  /// Batch upsert multiple conversations in a single DB transaction.
  /// Much faster than N sequential upserts for the initial sync.
  Future<void> upsertLocalConversationsBatch(
      List<LocalFullConversationsCompanion> conversations) {
    return batch((b) {
      for (final conv in conversations) {
        b.insert(localFullConversations, conv,
            onConflict: DoUpdate((_) => conv));
      }
    });
  }

  Future<LocalFullConversation?> getLocalConversation(String id) {
    return (select(localFullConversations)
          ..where((c) => c.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> deleteLocalConversation(String id) {
    return (delete(localFullConversations)..where((c) => c.id.equals(id)))
        .go();
  }

  /// Get the persisted chat wallpaper theme for a conversation.
  /// Returns `null` when no per-conversation theme has been set,
  /// so the caller can fall back to the global tab wallpaper.
  Future<String?> getChatTheme(String conversationId) async {
    final row = await (select(localFullConversations)
          ..where((c) => c.id.equals(conversationId)))
        .getSingleOrNull();
    return row?.chatTheme;
  }

  /// Persist the user's wallpaper choice for a conversation.
  Future<void> setChatTheme(String conversationId, String theme) {
    return (update(localFullConversations)
          ..where((c) => c.id.equals(conversationId)))
        .write(LocalFullConversationsCompanion(chatTheme: Value(theme)));
  }

  /// Update only the last-message preview fields of a conversation.
  Future<void> updateLocalConversationPreview({
    required String conversationId,
    required String lastMessageText,
    required String lastMessageSenderId,
    required DateTime lastMessageAt,
    String? lastMessageType,
  }) {
    return (update(localFullConversations)
          ..where((c) => c.id.equals(conversationId)))
        .write(LocalFullConversationsCompanion(
      lastMessageText: Value(lastMessageText),
      lastMessageSenderId: Value(lastMessageSenderId),
      lastMessageAt: Value(lastMessageAt),
      lastMessageType: Value(lastMessageType),
    ));
  }

  /// Search messages in a conversation using FTS5 full-text index (fast)
  /// with fallback to LIKE for devices where the FTS table doesn't exist.
  Future<List<LocalFullMessage>> searchLocalMessages(
    String conversationId,
    String query, {
    int limit = 50,
  }) async {
    // Sanitize query for FTS5: escape double quotes and wrap each term
    final sanitized = query.replaceAll('"', '""').trim();
    if (sanitized.isEmpty) return [];

    try {
      // Try FTS5 first — much faster than LIKE '%query%' for large tables.
      // FTS5 match uses implicit prefix matching with *.
      final ftsQuery = '"$sanitized"*';
      final rows = await customSelect(
        'SELECT m.* FROM local_full_messages m '
        'INNER JOIN message_fts f ON m.id = f.rowid_ref '
        'WHERE f.message_fts MATCH ? '
        'AND m.conversation_id = ? '
        'AND m.deleted_for_everyone = 0 '
        'ORDER BY m.created_at DESC '
        'LIMIT ?',
        variables: [
          Variable.withString(ftsQuery),
          Variable.withString(conversationId),
          Variable.withInt(limit),
        ],
        readsFrom: {localFullMessages},
      ).get();

      return rows
          .map((row) => localFullMessages.map(row.data))
          .toList();
    } catch (_) {
      // FTS table doesn't exist yet (pre-v16) — fall back to LIKE
      return (select(localFullMessages)
            ..where((m) =>
                m.conversationId.equals(conversationId) &
                m.textContent.like('%$sanitized%') &
                m.deletedForEveryone.equals(false))
            ..orderBy([(m) => OrderingTerm.desc(m.createdAt)])
            ..limit(limit))
          .get();
    }
  }

  /// Populate the FTS5 index for a single message. Called by MessageSyncService
  /// after storing a decrypted message. Fire-and-forget — FTS is an optimization,
  /// not a correctness requirement.
  Future<void> indexMessageForSearch(String messageId, String? textContent) {
    if (textContent == null || textContent.isEmpty) return Future.value();
    return customStatement(
      'INSERT OR REPLACE INTO message_fts (rowid_ref, text_content) VALUES (?, ?)',
      [messageId, textContent],
    );
  }

  /// Remove a message from the FTS5 index (on deletion).
  Future<void> removeMessageFromSearchIndex(String messageId) {
    return customStatement(
      'DELETE FROM message_fts WHERE rowid_ref = ?',
      [messageId],
    );
  }

  Future<void> clearLocalFullMessages() {
    return delete(localFullMessages).go();
  }

  Future<void> clearLocalFullConversations() {
    return delete(localFullConversations).go();
  }

  // ============ PENDING MESSAGES QUEUE ============

  Future<void> insertPendingMessage(LocalPendingMessagesCompanion message) {
    return into(localPendingMessages).insertOnConflictUpdate(message);
  }

  Future<List<LocalPendingMessage>> getPendingMessages() {
    return (select(localPendingMessages)
          ..where((m) =>
              m.status.isIn(['pending', 'encrypting', 'sending', 'failed']))
          ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]))
        .get();
  }

  Future<List<LocalPendingMessage>> getPendingMessagesForConversation(
      String conversationId) {
    return (select(localPendingMessages)
          ..where((m) =>
              m.conversationId.equals(conversationId) &
              m.status.isIn(['pending', 'encrypting', 'sending', 'failed']))
          ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]))
        .get();
  }

  Future<void> updatePendingMessageStatus(
    String id,
    String status, {
    String? error,
    DateTime? lastAttemptAt,
  }) {
    return (update(localPendingMessages)..where((m) => m.id.equals(id))).write(
      LocalPendingMessagesCompanion(
        status: Value(status),
        errorMessage: Value(error),
        lastAttemptAt: Value(lastAttemptAt ?? DateTime.now()),
      ),
    );
  }

  // M5: Atomic increment — no read-modify-write race
  Future<void> incrementPendingMessageRetry(String id) async {
    await customStatement(
      'UPDATE local_pending_messages '
      'SET retry_count = retry_count + 1, '
      'last_attempt_at = ? '
      'WHERE id = ?',
      [DateTime.now().millisecondsSinceEpoch ~/ 1000, id],
    );
  }

  Future<void> deletePendingMessage(String id) {
    return (delete(localPendingMessages)..where((m) => m.id.equals(id))).go();
  }

  Future<LocalPendingMessage?> getPendingMessageById(String id) {
    return (select(localPendingMessages)..where((m) => m.id.equals(id)))
        .getSingleOrNull();
  }

  // ============ LOCAL COMMUNITY OPERATIONS ============

  Future<List<LocalCommunity>> getLocalCommunities() {
    return (select(localCommunities)
          ..where((c) => c.status.equals('closed').not())
          ..orderBy([(c) => OrderingTerm.desc(c.lastMessageAt)]))
        .get();
  }

  Stream<List<LocalCommunity>> watchLocalCommunities() {
    return (select(localCommunities)
          ..where((c) => c.status.equals('closed').not())
          ..orderBy([(c) => OrderingTerm.desc(c.lastMessageAt)]))
        .watch();
  }

  Future<LocalCommunity?> getLocalCommunity(String id) {
    return (select(localCommunities)..where((c) => c.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> upsertLocalCommunity(LocalCommunitiesCompanion community) {
    return into(localCommunities).insertOnConflictUpdate(community);
  }

  /// Atomic partial update of community preview fields only.
  /// Avoids read-modify-write race with sync service.
  Future<void> updateLocalCommunityPreview({
    required String communityId,
    required String lastMessageText,
    required String lastMessageSenderId,
    required DateTime lastMessageAt,
    String? lastMessageSenderName,
    String? lastMessageType,
  }) {
    return (update(localCommunities)
          ..where((c) => c.id.equals(communityId)))
        .write(LocalCommunitiesCompanion(
      lastMessageText: Value(lastMessageText),
      lastMessageSenderId: Value(lastMessageSenderId),
      lastMessageSenderName: Value(lastMessageSenderName),
      lastMessageAt: Value(lastMessageAt),
      lastMessageType: Value(lastMessageType),
      updatedAt: Value(lastMessageAt),
    ));
  }

  /// Atomic update of community memberCount from actual member list.
  Future<void> updateLocalCommunityMemberCount({
    required String communityId,
    required int memberCount,
  }) {
    return (update(localCommunities)
          ..where((c) => c.id.equals(communityId)))
        .write(LocalCommunitiesCompanion(
      memberCount: Value(memberCount),
    ));
  }

  Future<void> deleteLocalCommunity(String id) {
    return (delete(localCommunities)..where((c) => c.id.equals(id))).go();
  }

  Future<void> clearLocalCommunities() {
    return delete(localCommunities).go();
  }

  // ============ LOCAL COMMUNITY MEMBER OPERATIONS ============

  Future<List<LocalCommunityMember>> getLocalCommunityMembers(
      String communityId) {
    return (select(localCommunityMembers)
          ..where((m) => m.communityId.equals(communityId))
          ..orderBy([(m) => OrderingTerm.asc(m.displayName)]))
        .get();
  }

  Stream<List<LocalCommunityMember>> watchLocalCommunityMembers(
      String communityId) {
    return (select(localCommunityMembers)
          ..where((m) => m.communityId.equals(communityId))
          ..orderBy([(m) => OrderingTerm.asc(m.displayName)]))
        .watch();
  }

  Future<LocalCommunityMember?> getLocalCommunityMember(String id) {
    return (select(localCommunityMembers)
          ..where((m) => m.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> upsertLocalCommunityMember(
      LocalCommunityMembersCompanion member) {
    return into(localCommunityMembers).insertOnConflictUpdate(member);
  }

  Future<void> deleteLocalCommunityMember(String id) {
    return (delete(localCommunityMembers)..where((m) => m.id.equals(id))).go();
  }

  Future<void> deleteLocalCommunityMembersForCommunity(String communityId) {
    return (delete(localCommunityMembers)
          ..where((m) => m.communityId.equals(communityId)))
        .go();
  }

  Future<void> clearLocalCommunityMembers() {
    return delete(localCommunityMembers).go();
  }

  // ============ CONTACT SEARCH (offline fallback) ============

  Future<List<LocalContact>> searchLocalContacts(String query) {
    final pattern = '%${query.toLowerCase()}%';
    return (select(localContacts)
          ..where((c) =>
              c.displayName.lower().like(pattern) |
              (c.username.isNotNull() & c.username.lower().like(pattern)))
          ..orderBy([(c) => OrderingTerm.asc(c.displayName)])
          ..limit(20))
        .get();
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
    // Preserve localSyncMetadata (contains messageCacheUserId for
    // different-user detection) and conversation + message cache so the same
    // user sees their inbox instantly on re-login. The cache is refreshed
    // from Firestore on next sync. clearMessageCache() wipes these when
    // a different user logs in.
    await delete(localPendingMessages).go();
    await clearLocalCommunities();
    await clearLocalCommunityMembers();
  }

  /// Clear the messaging display cache (conversations, messages, decrypted
  /// plaintext). Called when a different user logs in to prevent data leakage.
  Future<void> clearMessageCache() async {
    await clearDecryptedMessages();
    await clearLocalFullMessages();
    await clearLocalFullConversations();
  }

  /// Check if the message cache belongs to a different user and clear it
  /// if so. Returns true if the cache was cleared (new user detected).
  ///
  /// Call this on login before starting conversation sync. Preserves the
  /// cache for the same user so conversations appear instantly on re-login.
  Future<bool> clearMessageCacheIfUserChanged(String userId) async {
    final cachedUserId = await getSyncMetadata('messageCacheUserId');
    if (cachedUserId != null && cachedUserId != userId) {
      await clearMessageCache();
      await setSyncMetadata('messageCacheUserId', userId);
      return true;
    }
    if (cachedUserId == null) {
      await setSyncMetadata('messageCacheUserId', userId);
    }
    return false;
  }

  Future<void> clearUserData(String userId) async {
    await deleteWallet(userId);
    await deleteTransactions(userId);
    await deleteEarnThreads(userId);
    await deleteChatThreads(userId);
    await deleteContacts(userId);
    // Preserve conversation + message cache (same as clearAllData)
    await delete(localPendingMessages).go();
    await clearLocalCommunities();
    await clearLocalCommunityMembers();
    await clearBuyCategories();
    await clearBuyRegulars();
    await clearFeaturedItems();
  }

  // ============ BUY CATEGORY OPERATIONS ============

  Future<List<LocalBuyCategory>> getBuyCategories() {
    return (select(localBuyCategories)
          ..where((c) => c.isActive.equals(true))
          ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
        .get();
  }

  Future<List<LocalBuyCategory>> getAllBuyCategories() {
    return (select(localBuyCategories)
          ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
        .get();
  }

  Future<void> upsertBuyCategory(LocalBuyCategoriesCompanion category) {
    return into(localBuyCategories).insertOnConflictUpdate(category);
  }

  Future<void> upsertBuyCategories(
      List<LocalBuyCategoriesCompanion> categories) async {
    await batch((b) {
      for (final cat in categories) {
        b.insert(localBuyCategories, cat, onConflict: DoUpdate((_) => cat));
      }
    });
  }

  Future<void> clearBuyCategories() {
    return delete(localBuyCategories).go();
  }

  // ============ BUY REGULARS OPERATIONS ============

  Future<List<LocalBuyRegular>> getBuyRegulars() {
    return (select(localBuyRegulars)
          ..orderBy([
            (r) => OrderingTerm.desc(r.isPinned),
            (r) => OrderingTerm.desc(r.lastUsedAt),
          ]))
        .get();
  }

  Future<void> upsertBuyRegulars(
      List<LocalBuyRegularsCompanion> regulars) async {
    await batch((b) {
      for (final reg in regulars) {
        b.insert(localBuyRegulars, reg, onConflict: DoUpdate((_) => reg));
      }
    });
  }

  Future<void> clearBuyRegulars() {
    return delete(localBuyRegulars).go();
  }

  // ============ FEATURED ITEMS OPERATIONS ============

  static const _featuredItemsTtl = Duration(minutes: 30);

  Future<List<LocalFeaturedItem>> getFeaturedItems() async {
    final items = await (select(localFeaturedItems)
          ..where((f) => f.isActive.equals(true))
          ..orderBy([(f) => OrderingTerm.asc(f.sortOrder)]))
        .get();

    if (items.isEmpty) return [];

    // TTL check: if the most recent syncedAt is older than 30 minutes,
    // return empty list to force a refresh from the remote source.
    final latestSync = items
        .map((i) => i.syncedAt)
        .reduce((a, b) => a.isAfter(b) ? a : b);
    if (DateTime.now().difference(latestSync) > _featuredItemsTtl) {
      return [];
    }

    return items;
  }

  Future<void> upsertFeaturedItems(
      List<LocalFeaturedItemsCompanion> items) async {
    await batch((b) {
      for (final item in items) {
        b.insert(localFeaturedItems, item, onConflict: DoUpdate((_) => item));
      }
    });
  }

  Future<void> clearFeaturedItems() {
    return delete(localFeaturedItems).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'imali_local_encrypted.db'));

    // Retrieve or generate encryption key from secure storage.
    // Must use matching AndroidOptions to match the DI-registered
    // FlutterSecureStorage instance used by the rest of the app.
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(),
    );
    String? key = await storage.read(key: 'imali_db_encryption_key');
    if (key == null) {
      final random = Random.secure();
      final bytes = List.generate(32, (_) => random.nextInt(256));
      key = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
      await storage.write(key: 'imali_db_encryption_key', value: key);
      // Key was regenerated (FlutterSecureStorage lost it) — old DB can't
      // be decrypted. Delete it; data re-syncs from Firestore.
      if (await file.exists()) {
        debugPrint('AppDatabase: Encryption key regenerated — deleting stale DB');
        await file.delete();
      }
    }

    // NOTE: The pre-emptive validation block that used to live here
    // (raw sqlite3.open → PRAGMA key → SELECT count(*)) was removed.
    // On Android, an unclean process kill leaves WAL files that caused
    // the raw validation open to throw spuriously — deleting a perfectly
    // intact DB and wiping all cached plaintext.  Drift's NativeDatabase
    // handles WAL recovery correctly on its own; the validation was
    // redundant and destructive.

    // Delete old unencrypted database if it exists (cache only — syncs from Firestore)
    final oldFile = File(p.join(dbFolder.path, 'imali_local.db'));
    if (await oldFile.exists()) {
      await oldFile.delete();
    }

    return NativeDatabase(
      file,
      setup: (db) {
        db.execute("PRAGMA key = '$key'");
      },
    );
  });
}
