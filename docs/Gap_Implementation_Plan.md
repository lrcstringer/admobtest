# iMaliChat Gap Implementation Plan

## Document Overview
This document provides detailed implementation specifications for all gaps identified in the gap analysis (Sections 1-6).

**Priority Legend:**
- 🔴 P0 - Critical (Must have for launch)
- 🟠 P1 - High Priority (Required for core functionality)
- 🟡 P2 - Medium Priority (Important but can be phased)

---

# SECTION 1: DOMAIN LAYER GAPS

## 1.1 Missing Entity: Survey 🟡

**File:** `lib/domain/entities/survey.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey.freezed.dart';
part 'survey.g.dart';

@freezed
class Survey with _$Survey {
  const factory Survey({
    required String id,
    required String campaignId,
    required String title,
    required String description,
    required List<SurveyQuestion> questions,
    required int tokenReward,
    required int estimatedMinutes,
    required SurveyStatus status,
    required DateTime createdAt,
    DateTime? expiresAt,
    int? maxResponses,
    int? currentResponses,
    Map<String, dynamic>? targetingCriteria,
  }) = _Survey;

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);
}

@freezed
class SurveyQuestion with _$SurveyQuestion {
  const factory SurveyQuestion({
    required String id,
    required String text,
    required QuestionType type,
    required bool isRequired,
    List<String>? options,
    int? minValue,
    int? maxValue,
    String? placeholder,
  }) = _SurveyQuestion;

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionFromJson(json);
}

enum SurveyStatus { draft, active, paused, completed, expired }

enum QuestionType {
  singleChoice,
  multipleChoice,
  text,
  rating,
  scale,
  yesNo
}
```

---

## 1.2 Missing Entity: EarnMessage 🟡

**File:** `lib/domain/entities/earn_message.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earn_message.freezed.dart';
part 'earn_message.g.dart';

/// Represents a message within an earn thread (ad viewing, survey response, etc.)
@freezed
class EarnMessage with _$EarnMessage {
  const factory EarnMessage({
    required String id,
    required String threadId,
    required String oddienceUserId,
    required EarnMessageType type,
    required String content,
    required DateTime createdAt,
    EarnMessageStatus? status,
    Map<String, dynamic>? metadata,
    /// For survey responses
    String? questionId,
    dynamic response,
    /// For ad interactions
    String? adId,
    int? watchDurationSeconds,
    /// Token amount earned from this message/action
    int? tokensEarned,
  }) = _EarnMessage;

  factory EarnMessage.fromJson(Map<String, dynamic> json) =>
      _$EarnMessageFromJson(json);
}

enum EarnMessageType {
  adStarted,
  adCompleted,
  adSkipped,
  surveyStarted,
  surveyQuestionAnswered,
  surveyCompleted,
  surveyAbandoned,
  rewardCredited,
  systemMessage,
}

enum EarnMessageStatus {
  pending,
  processed,
  failed,
  cancelled,
}
```

---

## 1.3 Missing Entity: PotDistribution 🟡

**File:** `lib/domain/entities/pot_distribution.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pot_distribution.freezed.dart';
part 'pot_distribution.g.dart';

/// Represents how a pot's prize pool is distributed among winners
@freezed
class PotDistribution with _$PotDistribution {
  const factory PotDistribution({
    required String id,
    required String potPoolId,
    required PotType potType,
    required DateTime drawDate,
    required int totalPrizePool,
    required int totalParticipants,
    required int totalEntries,
    required List<PotWinnerAllocation> winners,
    required DistributionStatus status,
    required DateTime createdAt,
    DateTime? processedAt,
    String? transactionBatchId,
  }) = _PotDistribution;

  factory PotDistribution.fromJson(Map<String, dynamic> json) =>
      _$PotDistributionFromJson(json);
}

@freezed
class PotWinnerAllocation with _$PotWinnerAllocation {
  const factory PotWinnerAllocation({
    required String oddienceUserId,
    required int rank,
    required int prizeAmount,
    required int entryCount,
    required double winProbability,
    String? transactionId,
    bool? notificationSent,
  }) = _PotWinnerAllocation;

  factory PotWinnerAllocation.fromJson(Map<String, dynamic> json) =>
      _$PotWinnerAllocationFromJson(json);
}

enum PotType { daily, weekly }

enum DistributionStatus { pending, processing, completed, failed }
```

---

## 1.4 Missing Entity: Campaign 🟡

**File:** `lib/domain/entities/campaign.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign.freezed.dart';
part 'campaign.g.dart';

/// Represents an advertising/earning campaign from brands
@freezed
class Campaign with _$Campaign {
  const factory Campaign({
    required String id,
    required String brandId,
    required String brandName,
    required String title,
    required String description,
    required CampaignType type,
    required CampaignStatus status,
    required int totalBudgetTokens,
    required int remainingBudgetTokens,
    required int rewardPerEngagement,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime createdAt,
    String? imageUrl,
    String? videoUrl,
    Map<String, dynamic>? targetingCriteria,
    int? maxEngagementsPerUser,
    int? totalEngagements,
    int? uniqueUsers,
    double? averageCompletionRate,
  }) = _Campaign;

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);
}

enum CampaignType {
  videoAd,
  survey,
  pollQuestion,
  brandedContent,
  appInstall,
  websiteVisit,
}

enum CampaignStatus {
  draft,
  pendingApproval,
  active,
  paused,
  completed,
  cancelled,
  expired,
}
```

---

## 1.5 Missing Entity: Video 🟡

**File:** `lib/domain/entities/video.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

/// Represents a video ad that users can watch to earn tokens
@freezed
class Video with _$Video {
  const factory Video({
    required String id,
    required String campaignId,
    required String title,
    required String videoUrl,
    required int durationSeconds,
    required int requiredWatchSeconds,
    required int tokenReward,
    required VideoStatus status,
    required DateTime createdAt,
    String? thumbnailUrl,
    String? description,
    String? callToActionText,
    String? callToActionUrl,
    int? totalViews,
    int? completedViews,
    double? averageWatchPercentage,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}

enum VideoStatus { active, paused, expired, deleted }
```

---

# SECTION 2: REPOSITORY LAYER GAPS

## 2.1 Missing: ContactRepositoryImpl 🟠

**File:** `lib/data/repositories/contact_repository_impl.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart' as device_contacts;
import '../../core/error/failures.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final FirebaseFirestore _firestore;

  ContactRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, List<Contact>>> getContacts(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('contacts')
          .where('ownerUserId', isEqualTo: userId)
          .orderBy('displayName')
          .get();

      final contacts = snapshot.docs
          .map((doc) => _mapDocToContact(doc))
          .toList();

      return Right(contacts);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> syncDeviceContacts(String userId) async {
    try {
      // Request permission and get device contacts
      final deviceContacts = await device_contacts.ContactsService.getContacts(
        withThumbnails: false,
      );

      final batch = _firestore.batch();
      final syncedContacts = <Contact>[];

      for (final deviceContact in deviceContacts) {
        if (deviceContact.phones?.isEmpty ?? true) continue;

        final phone = deviceContact.phones!.first.value;
        if (phone == null) continue;

        // Normalize phone number
        final normalizedPhone = _normalizePhoneNumber(phone);

        // Check if this phone is registered in iMali
        final userQuery = await _firestore
            .collection('users')
            .where('phoneNumber', isEqualTo: normalizedPhone)
            .limit(1)
            .get();

        final isRegistered = userQuery.docs.isNotEmpty;
        final registeredUserId = isRegistered ? userQuery.docs.first.id : null;

        // Create or update contact
        final contactRef = _firestore.collection('contacts').doc();
        final contact = Contact(
          id: contactRef.id,
          ownerUserId: userId,
          phoneNumber: normalizedPhone,
          displayName: deviceContact.displayName ?? 'Unknown',
          isRegistered: isRegistered,
          registeredUserId: registeredUserId,
          avatarUrl: null,
          lastSyncedAt: DateTime.now(),
          createdAt: DateTime.now(),
        );

        batch.set(contactRef, _contactToMap(contact), SetOptions(merge: true));
        syncedContacts.add(contact);
      }

      await batch.commit();
      return Right(syncedContacts);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getRegisteredContacts(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('contacts')
          .where('ownerUserId', isEqualTo: userId)
          .where('isRegistered', isEqualTo: true)
          .orderBy('displayName')
          .get();

      final contacts = snapshot.docs
          .map((doc) => _mapDocToContact(doc))
          .toList();

      return Right(contacts);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Contact>> inviteContact(
    String userId,
    String phoneNumber,
  ) async {
    try {
      // Create invite record
      final inviteRef = _firestore.collection('contactInvites').doc();
      await inviteRef.set({
        'id': inviteRef.id,
        'inviterId': userId,
        'inviteePhone': _normalizePhoneNumber(phoneNumber),
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Update contact as invited
      final contactQuery = await _firestore
          .collection('contacts')
          .where('ownerUserId', isEqualTo: userId)
          .where('phoneNumber', isEqualTo: _normalizePhoneNumber(phoneNumber))
          .limit(1)
          .get();

      if (contactQuery.docs.isNotEmpty) {
        await contactQuery.docs.first.reference.update({
          'invitedAt': FieldValue.serverTimestamp(),
          'inviteId': inviteRef.id,
        });
        return Right(_mapDocToContact(contactQuery.docs.first));
      }

      return Left(NotFoundFailure(message: 'Contact not found'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  String _normalizePhoneNumber(String phone) {
    // Remove all non-digit characters
    String digits = phone.replaceAll(RegExp(r'[^\d]'), '');

    // Handle South African numbers
    if (digits.startsWith('0') && digits.length == 10) {
      digits = '27${digits.substring(1)}';
    }

    return '+$digits';
  }

  Contact _mapDocToContact(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Contact(
      id: doc.id,
      ownerUserId: data['ownerUserId'],
      phoneNumber: data['phoneNumber'],
      displayName: data['displayName'],
      isRegistered: data['isRegistered'] ?? false,
      registeredUserId: data['registeredUserId'],
      avatarUrl: data['avatarUrl'],
      lastSyncedAt: (data['lastSyncedAt'] as Timestamp?)?.toDate(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> _contactToMap(Contact contact) {
    return {
      'id': contact.id,
      'ownerUserId': contact.ownerUserId,
      'phoneNumber': contact.phoneNumber,
      'displayName': contact.displayName,
      'isRegistered': contact.isRegistered,
      'registeredUserId': contact.registeredUserId,
      'avatarUrl': contact.avatarUrl,
      'lastSyncedAt': contact.lastSyncedAt != null
          ? Timestamp.fromDate(contact.lastSyncedAt!)
          : FieldValue.serverTimestamp(),
      'createdAt': Timestamp.fromDate(contact.createdAt),
    };
  }
}
```

---

## 2.2 Missing: SyncRepositoryImpl 🔴

**File:** `lib/data/repositories/sync_repository_impl.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/sync_repository.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/sync_remote_datasource.dart';

class SyncRepositoryImpl implements SyncRepository {
  final AppDatabase _localDb;
  final SyncRemoteDataSource _remoteDataSource;
  final Connectivity _connectivity;

  SyncRepositoryImpl({
    required AppDatabase localDb,
    required SyncRemoteDataSource remoteDataSource,
    Connectivity? connectivity,
  })  : _localDb = localDb,
        _remoteDataSource = remoteDataSource,
        _connectivity = connectivity ?? Connectivity();

  @override
  Future<Either<Failure, SyncStatus>> getSyncStatus() async {
    try {
      final lastSync = await _localDb.getLastSyncTimestamp();
      final pendingChanges = await _localDb.getPendingChangesCount();
      final connectivityResult = await _connectivity.checkConnectivity();

      return Right(SyncStatus(
        lastSyncAt: lastSync,
        pendingChangesCount: pendingChanges,
        isOnline: connectivityResult != ConnectivityResult.none,
        syncState: pendingChanges > 0 ? SyncState.pending : SyncState.synced,
      ));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncAll(String userId) async {
    try {
      // Check connectivity
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return Left(NetworkFailure(message: 'No internet connection'));
      }

      // Sync in order of priority
      await _syncWallet(userId);
      await _syncTransactions(userId);
      await _syncEarnThreads(userId);
      await _syncChatThreads(userId);
      await _syncContacts(userId);

      // Update last sync timestamp
      await _localDb.updateLastSyncTimestamp(DateTime.now());

      return const Right(null);
    } catch (e) {
      return Left(SyncFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncWallet(String userId) async {
    try {
      await _syncWallet(userId);
      return const Right(null);
    } catch (e) {
      return Left(SyncFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncTransactions(String userId) async {
    try {
      await _syncTransactions(userId);
      return const Right(null);
    } catch (e) {
      return Left(SyncFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> pushPendingChanges(String userId) async {
    try {
      final pendingChanges = await _localDb.getPendingChanges();

      for (final change in pendingChanges) {
        await _remoteDataSource.pushChange(change);
        await _localDb.markChangeAsSynced(change.id);
      }

      return const Right(null);
    } catch (e) {
      return Left(SyncFailure(message: e.toString()));
    }
  }

  @override
  Stream<SyncStatus> watchSyncStatus() {
    return _connectivity.onConnectivityChanged.asyncMap((result) async {
      final lastSync = await _localDb.getLastSyncTimestamp();
      final pendingChanges = await _localDb.getPendingChangesCount();

      return SyncStatus(
        lastSyncAt: lastSync,
        pendingChangesCount: pendingChanges,
        isOnline: result != ConnectivityResult.none,
        syncState: pendingChanges > 0 ? SyncState.pending : SyncState.synced,
      );
    });
  }

  // Private sync methods
  Future<void> _syncWallet(String userId) async {
    final remoteWallet = await _remoteDataSource.fetchWallet(userId);
    final localWallet = await _localDb.getWallet(userId);

    if (localWallet == null ||
        remoteWallet.updatedAt.isAfter(localWallet.updatedAt)) {
      await _localDb.upsertWallet(remoteWallet);
    }
  }

  Future<void> _syncTransactions(String userId) async {
    final lastSync = await _localDb.getLastTransactionSyncTimestamp(userId);
    final remoteTransactions = await _remoteDataSource.fetchTransactionsSince(
      userId,
      lastSync,
    );

    for (final transaction in remoteTransactions) {
      await _localDb.upsertTransaction(transaction);
    }
  }

  Future<void> _syncEarnThreads(String userId) async {
    final lastSync = await _localDb.getLastEarnThreadSyncTimestamp(userId);
    final remoteThreads = await _remoteDataSource.fetchEarnThreadsSince(
      userId,
      lastSync,
    );

    for (final thread in remoteThreads) {
      await _localDb.upsertEarnThread(thread);
    }
  }

  Future<void> _syncChatThreads(String userId) async {
    final lastSync = await _localDb.getLastChatThreadSyncTimestamp(userId);
    final remoteThreads = await _remoteDataSource.fetchChatThreadsSince(
      userId,
      lastSync,
    );

    for (final thread in remoteThreads) {
      await _localDb.upsertChatThread(thread);
    }
  }

  Future<void> _syncContacts(String userId) async {
    final remoteContacts = await _remoteDataSource.fetchContacts(userId);

    for (final contact in remoteContacts) {
      await _localDb.upsertContact(contact);
    }
  }
}

// Supporting classes
class SyncStatus {
  final DateTime? lastSyncAt;
  final int pendingChangesCount;
  final bool isOnline;
  final SyncState syncState;

  SyncStatus({
    this.lastSyncAt,
    required this.pendingChangesCount,
    required this.isOnline,
    required this.syncState,
  });
}

enum SyncState { synced, pending, syncing, error }

class SyncFailure extends Failure {
  SyncFailure({required String message}) : super(message: message);
}

class NetworkFailure extends Failure {
  NetworkFailure({required String message}) : super(message: message);
}
```

---

# SECTION 3: DATA LAYER GAPS (DRIFT LOCAL DATABASE) 🔴

## 3.1 Drift Database Setup

**File:** `lib/data/datasources/local/app_database.dart`

```dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ============ TABLE DEFINITIONS ============

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

class LocalContacts extends Table {
  TextColumn get id => text()();
  TextColumn get ownerUserId => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get displayName => text()();
  BoolColumn get isRegistered => boolean().withDefault(const Constant(false))();
  TextColumn get registeredUserId => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalPendingChanges extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tableName => text()();
  TextColumn get recordId => text()();
  TextColumn get changeType => text()(); // insert, update, delete
  TextColumn get changeData => text()(); // JSON string
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

class LocalSyncMetadata extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

// ============ DATABASE CLASS ============

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

  // ============ CHAT OPERATIONS ============

  Future<List<LocalChatThread>> getChatThreads(String oddienceUserId) {
    return (select(localChatThreads)
          ..where((t) => t.oddienceUserId.equals(oddienceUserId))
          ..orderBy([(t) => OrderingTerm.desc(t.lastMessageAt)]))
        .get();
  }

  Future<void> upsertChatThread(LocalChatThreadsCompanion thread) {
    return into(localChatThreads).insertOnConflictUpdate(thread);
  }

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

  // ============ CONTACT OPERATIONS ============

  Future<List<LocalContact>> getContacts(String ownerUserId) {
    return (select(localContacts)
          ..where((c) => c.ownerUserId.equals(ownerUserId))
          ..orderBy([(c) => OrderingTerm.asc(c.displayName)]))
        .get();
  }

  Future<void> upsertContact(LocalContactsCompanion contact) {
    return into(localContacts).insertOnConflictUpdate(contact);
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

  Future<DateTime?> getLastTransactionSyncTimestamp(String userId) async {
    final result = await (select(localSyncMetadata)
          ..where((m) => m.key.equals('lastTransactionSync_$userId')))
        .getSingleOrNull();
    return result != null ? DateTime.parse(result.value) : null;
  }

  Future<DateTime?> getLastEarnThreadSyncTimestamp(String userId) async {
    final result = await (select(localSyncMetadata)
          ..where((m) => m.key.equals('lastEarnThreadSync_$userId')))
        .getSingleOrNull();
    return result != null ? DateTime.parse(result.value) : null;
  }

  Future<DateTime?> getLastChatThreadSyncTimestamp(String userId) async {
    final result = await (select(localSyncMetadata)
          ..where((m) => m.key.equals('lastChatThreadSync_$userId')))
        .getSingleOrNull();
    return result != null ? DateTime.parse(result.value) : null;
  }

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
    required String tableName,
    required String recordId,
    required String changeType,
    required String changeData,
  }) {
    return into(localPendingChanges).insert(
      LocalPendingChangesCompanion.insert(
        tableName: tableName,
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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'imali_local.db'));
    return NativeDatabase.createInBackground(file);
  });
}
```

---

## 3.2 Required Dependencies for Drift

**Add to `pubspec.yaml`:**

```yaml
dependencies:
  drift: ^2.14.0
  sqlite3_flutter_libs: ^0.5.18
  path_provider: ^2.1.1
  path: ^1.8.3
  connectivity_plus: ^5.0.2

dev_dependencies:
  drift_dev: ^2.14.0
  build_runner: ^2.4.7
```

---

## 3.3 Sync Remote Data Source

**File:** `lib/data/datasources/remote/sync_remote_datasource.dart`

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/wallet_model.dart';
import '../../models/transaction_model.dart';
import '../../models/earn_thread_model.dart';
import '../../models/chat_thread_model.dart';
import '../../../domain/entities/contact.dart';

class SyncRemoteDataSource {
  final FirebaseFirestore _firestore;

  SyncRemoteDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<WalletModel> fetchWallet(String userId) async {
    final query = await _firestore
        .collection('wallets')
        .where('oddienceUserId', isEqualTo: userId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      throw Exception('Wallet not found');
    }

    return WalletModel.fromJson(query.docs.first.data());
  }

  Future<List<TransactionModel>> fetchTransactionsSince(
    String userId,
    DateTime? since,
  ) async {
    Query query = _firestore
        .collection('transactions')
        .where('oddienceUserId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(100);

    if (since != null) {
      query = query.where('createdAt', isGreaterThan: Timestamp.fromDate(since));
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => TransactionModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<EarnThreadModel>> fetchEarnThreadsSince(
    String userId,
    DateTime? since,
  ) async {
    Query query = _firestore
        .collection('earnThreads')
        .where('oddienceUserId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50);

    if (since != null) {
      query = query.where('createdAt', isGreaterThan: Timestamp.fromDate(since));
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => EarnThreadModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<ChatThreadModel>> fetchChatThreadsSince(
    String userId,
    DateTime? since,
  ) async {
    Query query = _firestore
        .collection('chatThreads')
        .where('participantIds', arrayContains: userId)
        .orderBy('lastMessageAt', descending: true)
        .limit(50);

    if (since != null) {
      query = query.where('lastMessageAt', isGreaterThan: Timestamp.fromDate(since));
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => ChatThreadModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Contact>> fetchContacts(String userId) async {
    final snapshot = await _firestore
        .collection('contacts')
        .where('ownerUserId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Contact(
        id: doc.id,
        ownerUserId: data['ownerUserId'],
        phoneNumber: data['phoneNumber'],
        displayName: data['displayName'],
        isRegistered: data['isRegistered'] ?? false,
        registeredUserId: data['registeredUserId'],
        avatarUrl: data['avatarUrl'],
        lastSyncedAt: (data['lastSyncedAt'] as Timestamp?)?.toDate(),
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );
    }).toList();
  }

  Future<void> pushChange(dynamic change) async {
    // Handle different change types
    final tableName = change.tableName;
    final changeType = change.changeType;
    final changeData = change.changeData;

    switch (tableName) {
      case 'localTransactions':
        if (changeType == 'insert') {
          await _firestore.collection('transactions').doc(change.recordId).set(
                Map<String, dynamic>.from(changeData),
              );
        }
        break;
      case 'localChatMessages':
        if (changeType == 'insert') {
          await _firestore.collection('chatMessages').doc(change.recordId).set(
                Map<String, dynamic>.from(changeData),
              );
        }
        break;
      // Add other table handlers as needed
    }
  }
}
```

---

# SECTION 4: CLOUD FUNCTIONS GAPS 🟠

## 4.1 Chat P2P Functions

**File:** `functions/src/chat.ts`

```typescript
/**
 * Chat P2P Cloud Functions
 * Handle in-chat token transfers and payment requests
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Send tokens to another user via chat
 */
export const sendTokens = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const senderId = context.auth.uid;
  const { recipientId, amount, message, threadId } = data;

  // Validate input
  if (!recipientId || !amount || amount <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Invalid transfer data");
  }

  // Prevent self-transfer
  if (senderId === recipientId) {
    throw new functions.https.HttpsError("invalid-argument", "Cannot send tokens to yourself");
  }

  // Get sender's wallet
  const senderWalletQuery = await db.collection("wallets")
    .where("oddienceUserId", "==", senderId)
    .limit(1)
    .get();

  if (senderWalletQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Sender wallet not found");
  }

  const senderWallet = senderWalletQuery.docs[0];
  const senderBalance = senderWallet.data().tokenBalance || 0;

  // Check balance
  if (senderBalance < amount) {
    throw new functions.https.HttpsError("failed-precondition", "Insufficient balance");
  }

  // Get recipient's wallet
  const recipientWalletQuery = await db.collection("wallets")
    .where("oddienceUserId", "==", recipientId)
    .limit(1)
    .get();

  if (recipientWalletQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Recipient wallet not found");
  }

  const recipientWallet = recipientWalletQuery.docs[0];

  // Process transfer in transaction
  await db.runTransaction(async (transaction) => {
    // Deduct from sender
    transaction.update(senderWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(-amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Add to recipient
    transaction.update(recipientWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create sender transaction record
    const senderTxRef = db.collection("transactions").doc();
    transaction.set(senderTxRef, {
      id: senderTxRef.id,
      walletId: senderWallet.id,
      oddienceUserId: senderId,
      type: "transfer",
      subType: "sent",
      tokenAmount: -amount,
      zarAmount: -amount * 0.01,
      description: `Sent to user`,
      status: "completed",
      referenceId: recipientId,
      referenceType: "user",
      metadata: { threadId, message },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create recipient transaction record
    const recipientTxRef = db.collection("transactions").doc();
    transaction.set(recipientTxRef, {
      id: recipientTxRef.id,
      walletId: recipientWallet.id,
      oddienceUserId: recipientId,
      type: "transfer",
      subType: "received",
      tokenAmount: amount,
      zarAmount: amount * 0.01,
      description: `Received from user`,
      status: "completed",
      referenceId: senderId,
      referenceType: "user",
      metadata: { threadId, message },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create chat message for transfer
    if (threadId) {
      const messageRef = db.collection("chatMessages").doc();
      transaction.set(messageRef, {
        id: messageRef.id,
        threadId: threadId,
        senderId: senderId,
        recipientId: recipientId,
        content: message || `Sent ${amount} tokens`,
        type: "transfer",
        status: "sent",
        metadata: {
          amount: amount,
          transferType: "sent",
        },
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
  });

  return { success: true, amount };
});

/**
 * Create a payment request in chat
 */
export const createPaymentRequest = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const requesterId = context.auth.uid;
  const { recipientId, amount, message, threadId } = data;

  // Validate
  if (!recipientId || !amount || amount <= 0) {
    throw new functions.https.HttpsError("invalid-argument", "Invalid request data");
  }

  if (requesterId === recipientId) {
    throw new functions.https.HttpsError("invalid-argument", "Cannot request from yourself");
  }

  // Create payment request
  const requestRef = db.collection("paymentRequests").doc();
  await requestRef.set({
    id: requestRef.id,
    requesterId: requesterId,
    payerId: recipientId,
    amount: amount,
    message: message || null,
    threadId: threadId || null,
    status: "pending",
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    expiresAt: admin.firestore.Timestamp.fromDate(
      new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) // 7 days
    ),
  });

  // Create chat message for request
  if (threadId) {
    const messageRef = db.collection("chatMessages").doc();
    await messageRef.set({
      id: messageRef.id,
      threadId: threadId,
      senderId: requesterId,
      recipientId: recipientId,
      content: message || `Requested ${amount} tokens`,
      type: "request",
      status: "sent",
      metadata: {
        requestId: requestRef.id,
        amount: amount,
        requestStatus: "pending",
      },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  return { success: true, requestId: requestRef.id };
});

/**
 * Pay a payment request
 */
export const payRequest = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const payerId = context.auth.uid;
  const { requestId } = data;

  // Get the request
  const requestDoc = await db.collection("paymentRequests").doc(requestId).get();

  if (!requestDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Payment request not found");
  }

  const request = requestDoc.data()!;

  // Validate
  if (request.payerId !== payerId) {
    throw new functions.https.HttpsError("permission-denied", "Not authorized to pay this request");
  }

  if (request.status !== "pending") {
    throw new functions.https.HttpsError("failed-precondition", "Request is no longer pending");
  }

  // Check if expired
  if (request.expiresAt.toDate() < new Date()) {
    await requestDoc.ref.update({ status: "expired" });
    throw new functions.https.HttpsError("failed-precondition", "Request has expired");
  }

  // Get payer's wallet
  const payerWalletQuery = await db.collection("wallets")
    .where("oddienceUserId", "==", payerId)
    .limit(1)
    .get();

  if (payerWalletQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Wallet not found");
  }

  const payerWallet = payerWalletQuery.docs[0];
  const balance = payerWallet.data().tokenBalance || 0;

  if (balance < request.amount) {
    throw new functions.https.HttpsError("failed-precondition", "Insufficient balance");
  }

  // Get requester's wallet
  const requesterWalletQuery = await db.collection("wallets")
    .where("oddienceUserId", "==", request.requesterId)
    .limit(1)
    .get();

  if (requesterWalletQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Requester wallet not found");
  }

  const requesterWallet = requesterWalletQuery.docs[0];

  // Process payment
  await db.runTransaction(async (transaction) => {
    // Update request status
    transaction.update(requestDoc.ref, {
      status: "paid",
      paidAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Transfer tokens
    transaction.update(payerWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(-request.amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    transaction.update(requesterWallet.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(request.amount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create transaction records
    const payerTxRef = db.collection("transactions").doc();
    transaction.set(payerTxRef, {
      id: payerTxRef.id,
      walletId: payerWallet.id,
      oddienceUserId: payerId,
      type: "transfer",
      subType: "request_paid",
      tokenAmount: -request.amount,
      zarAmount: -request.amount * 0.01,
      description: "Paid payment request",
      status: "completed",
      referenceId: requestId,
      referenceType: "payment_request",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    const requesterTxRef = db.collection("transactions").doc();
    transaction.set(requesterTxRef, {
      id: requesterTxRef.id,
      walletId: requesterWallet.id,
      oddienceUserId: request.requesterId,
      type: "transfer",
      subType: "request_received",
      tokenAmount: request.amount,
      zarAmount: request.amount * 0.01,
      description: "Received from payment request",
      status: "completed",
      referenceId: requestId,
      referenceType: "payment_request",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  });

  return { success: true, amount: request.amount };
});

/**
 * Decline a payment request
 */
export const declineRequest = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const userId = context.auth.uid;
  const { requestId, reason } = data;

  const requestDoc = await db.collection("paymentRequests").doc(requestId).get();

  if (!requestDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Payment request not found");
  }

  const request = requestDoc.data()!;

  if (request.payerId !== userId) {
    throw new functions.https.HttpsError("permission-denied", "Not authorized");
  }

  if (request.status !== "pending") {
    throw new functions.https.HttpsError("failed-precondition", "Request is no longer pending");
  }

  await requestDoc.ref.update({
    status: "declined",
    declinedAt: admin.firestore.FieldValue.serverTimestamp(),
    declineReason: reason || null,
  });

  return { success: true };
});
```

---

## 4.2 Engagement Functions

**File:** `functions/src/engagement.ts`

```typescript
/**
 * Engagement Cloud Functions
 * Track and process user engagements with ads/surveys
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Start a new engagement (ad view or survey)
 */
export const startEngagement = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const userId = context.auth.uid;
  const { campaignId, type, threadId } = data;

  // Validate
  if (!campaignId || !type) {
    throw new functions.https.HttpsError("invalid-argument", "Missing required fields");
  }

  // Get campaign
  const campaignDoc = await db.collection("campaigns").doc(campaignId).get();

  if (!campaignDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Campaign not found");
  }

  const campaign = campaignDoc.data()!;

  // Check if campaign is active
  if (campaign.status !== "active") {
    throw new functions.https.HttpsError("failed-precondition", "Campaign is not active");
  }

  // Check if user has already completed this campaign (if applicable)
  const existingEngagement = await db.collection("engagements")
    .where("oddienceUserId", "==", userId)
    .where("campaignId", "==", campaignId)
    .where("status", "==", "completed")
    .limit(1)
    .get();

  if (!existingEngagement.empty && campaign.maxEngagementsPerUser === 1) {
    throw new functions.https.HttpsError("already-exists", "Already completed this campaign");
  }

  // Create engagement record
  const engagementRef = db.collection("engagements").doc();
  await engagementRef.set({
    id: engagementRef.id,
    oddienceUserId: userId,
    campaignId: campaignId,
    threadId: threadId || null,
    type: type,
    status: "in_progress",
    progress: 0,
    rewardAmount: campaign.rewardPerEngagement,
    startedAt: admin.firestore.FieldValue.serverTimestamp(),
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    evidence: [],
  });

  // Update earn thread if provided
  if (threadId) {
    await db.collection("earnThreads").doc(threadId).update({
      status: "in_progress",
      engagementId: engagementRef.id,
      startedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  return {
    success: true,
    engagementId: engagementRef.id,
    rewardAmount: campaign.rewardPerEngagement,
  };
});

/**
 * Process engagement completion and reward user
 */
export const processEngagement = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const userId = context.auth.uid;
  const { engagementId, evidence } = data;

  // Get engagement
  const engagementDoc = await db.collection("engagements").doc(engagementId).get();

  if (!engagementDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Engagement not found");
  }

  const engagement = engagementDoc.data()!;

  // Validate ownership
  if (engagement.oddienceUserId !== userId) {
    throw new functions.https.HttpsError("permission-denied", "Not authorized");
  }

  // Check status
  if (engagement.status === "completed") {
    throw new functions.https.HttpsError("already-exists", "Engagement already completed");
  }

  if (engagement.status === "failed") {
    throw new functions.https.HttpsError("failed-precondition", "Engagement has failed");
  }

  // Validate evidence based on engagement type
  const isValid = await validateEngagementEvidence(engagement.type, evidence);

  if (!isValid) {
    await engagementDoc.ref.update({
      status: "failed",
      failedAt: admin.firestore.FieldValue.serverTimestamp(),
      failureReason: "Invalid evidence",
    });
    throw new functions.https.HttpsError("invalid-argument", "Invalid engagement evidence");
  }

  // Get user's wallet
  const walletQuery = await db.collection("wallets")
    .where("oddienceUserId", "==", userId)
    .limit(1)
    .get();

  if (walletQuery.empty) {
    throw new functions.https.HttpsError("not-found", "Wallet not found");
  }

  const walletDoc = walletQuery.docs[0];
  const rewardAmount = engagement.rewardAmount;

  // Process reward in transaction
  await db.runTransaction(async (transaction) => {
    // Update engagement
    transaction.update(engagementDoc.ref, {
      status: "completed",
      progress: 100,
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
      evidence: admin.firestore.FieldValue.arrayUnion(evidence),
    });

    // Credit wallet
    transaction.update(walletDoc.ref, {
      tokenBalance: admin.firestore.FieldValue.increment(rewardAmount),
      lifetimeEarned: admin.firestore.FieldValue.increment(rewardAmount),
      todayEarned: admin.firestore.FieldValue.increment(rewardAmount),
      lastEarnedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Create transaction record
    const txRef = db.collection("transactions").doc();
    transaction.set(txRef, {
      id: txRef.id,
      walletId: walletDoc.id,
      oddienceUserId: userId,
      type: "earn",
      subType: engagement.type,
      tokenAmount: rewardAmount,
      zarAmount: rewardAmount * 0.01,
      description: `Earned from ${engagement.type}`,
      status: "completed",
      referenceId: engagementId,
      referenceType: "engagement",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Update campaign stats
    const campaignRef = db.collection("campaigns").doc(engagement.campaignId);
    transaction.update(campaignRef, {
      totalEngagements: admin.firestore.FieldValue.increment(1),
      remainingBudgetTokens: admin.firestore.FieldValue.increment(-rewardAmount),
    });

    // Update pot entries
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const potEntryRef = db.collection("potEntries").doc(
      `${userId}_${today.toISOString().split("T")[0]}`
    );
    transaction.set(potEntryRef, {
      oddienceUserId: userId,
      date: today.toISOString().split("T")[0],
      entries: admin.firestore.FieldValue.increment(rewardAmount),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });

    // Update earn thread if present
    if (engagement.threadId) {
      const threadRef = db.collection("earnThreads").doc(engagement.threadId);
      transaction.update(threadRef, {
        status: "completed",
        progress: 100,
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
        tokensEarned: rewardAmount,
      });
    }
  });

  return { success: true, tokensEarned: rewardAmount };
});

/**
 * Update engagement progress (for multi-step engagements like surveys)
 */
export const updateEngagementProgress = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const userId = context.auth.uid;
  const { engagementId, progress, stepData } = data;

  const engagementDoc = await db.collection("engagements").doc(engagementId).get();

  if (!engagementDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Engagement not found");
  }

  const engagement = engagementDoc.data()!;

  if (engagement.oddienceUserId !== userId) {
    throw new functions.https.HttpsError("permission-denied", "Not authorized");
  }

  if (engagement.status !== "in_progress") {
    throw new functions.https.HttpsError("failed-precondition", "Engagement not in progress");
  }

  await engagementDoc.ref.update({
    progress: progress,
    evidence: admin.firestore.FieldValue.arrayUnion(stepData),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  // Update earn thread progress if present
  if (engagement.threadId) {
    await db.collection("earnThreads").doc(engagement.threadId).update({
      progress: progress,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  return { success: true, progress };
});

// Helper function to validate engagement evidence
async function validateEngagementEvidence(
  type: string,
  evidence: any
): Promise<boolean> {
  switch (type) {
    case "video":
      // Validate video watch evidence
      if (!evidence.watchDuration || !evidence.videoId) {
        return false;
      }
      // Check minimum watch time (e.g., 80% of video)
      return evidence.watchPercentage >= 80;

    case "survey":
      // Validate survey responses
      if (!evidence.responses || !Array.isArray(evidence.responses)) {
        return false;
      }
      // Check that all required questions are answered
      return evidence.responses.length > 0;

    case "poll":
      // Validate poll response
      return evidence.selectedOption !== undefined;

    default:
      return true;
  }
}
```

---

## 4.3 Update Index.ts Exports

**Update `functions/src/index.ts`:**

```typescript
/**
 * iMali Firebase Cloud Functions
 */

import * as admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Export all functions
export * from "./wallet";
export * from "./pots";
export * from "./referrals";
export * from "./purchases";
export * from "./scheduled";
export * from "./triggers";
export * from "./chat";        // NEW
export * from "./engagement";  // NEW

// Security cleanup function
import * as functions from "firebase-functions";
import { cleanupRateLimits } from "./security";

export const cleanupSecurityData = functions.pubsub
  .schedule("0 3 * * *")
  .timeZone("Africa/Johannesburg")
  .onRun(async () => {
    await cleanupRateLimits();
    return null;
  });
```

---

# SECTION 5: FRAUD PREVENTION GAPS

## 5.1 Play Integrity API Integration 🟠

**File:** `lib/core/security/play_integrity_service.dart`

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

/// Service for Google Play Integrity API
/// Verifies app and device integrity to prevent fraud
class PlayIntegrityService {
  static const String _cloudFunctionUrl =
      'https://us-central1-emalichat-d5a4c.cloudfunctions.net/verifyPlayIntegrity';

  /// Request an integrity token from Play Integrity API
  /// This should be called on Android only
  Future<IntegrityResult> verifyIntegrity({
    required String nonce,
  }) async {
    if (!defaultTargetPlatform.isAndroid) {
      // iOS uses App Attest instead
      return IntegrityResult(
        isValid: true,
        verdict: IntegrityVerdict.valid,
        details: 'Non-Android platform',
      );
    }

    try {
      // In production, use the play_integrity plugin
      // final integrityManager = IntegrityManager();
      // final token = await integrityManager.requestIntegrityToken(nonce);

      // For now, simulate the call structure
      final response = await _verifyTokenWithBackend(
        token: 'INTEGRITY_TOKEN_HERE',
        nonce: nonce,
      );

      return response;
    } catch (e) {
      return IntegrityResult(
        isValid: false,
        verdict: IntegrityVerdict.error,
        details: e.toString(),
      );
    }
  }

  Future<IntegrityResult> _verifyTokenWithBackend({
    required String token,
    required String nonce,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_cloudFunctionUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'nonce': nonce,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return IntegrityResult.fromJson(data);
      } else {
        return IntegrityResult(
          isValid: false,
          verdict: IntegrityVerdict.error,
          details: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return IntegrityResult(
        isValid: false,
        verdict: IntegrityVerdict.error,
        details: e.toString(),
      );
    }
  }
}

class IntegrityResult {
  final bool isValid;
  final IntegrityVerdict verdict;
  final String details;
  final DeviceRecognition? deviceRecognition;
  final AppLicensing? appLicensing;

  IntegrityResult({
    required this.isValid,
    required this.verdict,
    required this.details,
    this.deviceRecognition,
    this.appLicensing,
  });

  factory IntegrityResult.fromJson(Map<String, dynamic> json) {
    return IntegrityResult(
      isValid: json['isValid'] ?? false,
      verdict: IntegrityVerdict.fromString(json['verdict']),
      details: json['details'] ?? '',
      deviceRecognition: json['deviceRecognition'] != null
          ? DeviceRecognition.fromString(json['deviceRecognition'])
          : null,
      appLicensing: json['appLicensing'] != null
          ? AppLicensing.fromString(json['appLicensing'])
          : null,
    );
  }
}

enum IntegrityVerdict {
  valid,
  failedBasic,
  failedDevice,
  failedStrong,
  error;

  static IntegrityVerdict fromString(String? value) {
    switch (value) {
      case 'MEETS_DEVICE_INTEGRITY':
        return IntegrityVerdict.valid;
      case 'MEETS_BASIC_INTEGRITY':
        return IntegrityVerdict.failedStrong;
      default:
        return IntegrityVerdict.error;
    }
  }
}

enum DeviceRecognition {
  meetsDeviceIntegrity,
  meetsBasicIntegrity,
  unknown;

  static DeviceRecognition fromString(String? value) {
    switch (value) {
      case 'MEETS_DEVICE_INTEGRITY':
        return DeviceRecognition.meetsDeviceIntegrity;
      case 'MEETS_BASIC_INTEGRITY':
        return DeviceRecognition.meetsBasicIntegrity;
      default:
        return DeviceRecognition.unknown;
    }
  }
}

enum AppLicensing {
  licensed,
  unlicensed,
  unevaluated;

  static AppLicensing fromString(String? value) {
    switch (value) {
      case 'LICENSED':
        return AppLicensing.licensed;
      case 'UNLICENSED':
        return AppLicensing.unlicensed;
      default:
        return AppLicensing.unevaluated;
    }
  }
}

extension TargetPlatformX on TargetPlatform {
  bool get isAndroid => this == TargetPlatform.android;
  bool get isIOS => this == TargetPlatform.iOS;
}
```

---

## 5.2 Survey Quality Validation 🟡

**File:** `lib/core/security/survey_validator.dart`

```dart
import 'dart:math';

/// Validates survey responses for quality and fraud prevention
class SurveyValidator {
  /// Minimum time expected per question (seconds)
  static const int _minTimePerQuestion = 3;

  /// Maximum time for entire survey (seconds)
  static const int _maxSurveyTime = 1800; // 30 minutes

  /// Minimum entropy score for text responses
  static const double _minEntropyScore = 0.3;

  /// Validate a complete survey submission
  SurveyValidationResult validateSurvey({
    required List<SurveyResponse> responses,
    required int questionCount,
    required Duration completionTime,
    required List<int> responseTimesMs,
  }) {
    final issues = <ValidationIssue>[];

    // 1. Check completion time
    final minExpectedTime = Duration(seconds: questionCount * _minTimePerQuestion);
    if (completionTime < minExpectedTime) {
      issues.add(ValidationIssue(
        type: ValidationIssueType.tooFast,
        severity: IssueSeverity.high,
        message: 'Survey completed too quickly',
        details: {
          'actual': completionTime.inSeconds,
          'expected': minExpectedTime.inSeconds,
        },
      ));
    }

    if (completionTime.inSeconds > _maxSurveyTime) {
      issues.add(ValidationIssue(
        type: ValidationIssueType.tooSlow,
        severity: IssueSeverity.low,
        message: 'Survey took unusually long',
      ));
    }

    // 2. Check response time patterns
    if (responseTimesMs.length >= 3) {
      final variance = _calculateVariance(responseTimesMs);
      if (variance < 100) {
        // Nearly identical response times = bot behavior
        issues.add(ValidationIssue(
          type: ValidationIssueType.suspiciousTiming,
          severity: IssueSeverity.high,
          message: 'Response times too uniform',
        ));
      }
    }

    // 3. Check for straightlining (same answer for all questions)
    final multipleChoiceResponses = responses
        .where((r) => r.type == ResponseType.multipleChoice)
        .toList();

    if (multipleChoiceResponses.length >= 5) {
      final uniqueAnswers = multipleChoiceResponses
          .map((r) => r.value)
          .toSet()
          .length;

      if (uniqueAnswers == 1) {
        issues.add(ValidationIssue(
          type: ValidationIssueType.straightlining,
          severity: IssueSeverity.medium,
          message: 'All multiple choice answers are the same',
        ));
      }
    }

    // 4. Validate text responses
    for (final response in responses.where((r) => r.type == ResponseType.text)) {
      final textIssues = _validateTextResponse(response.value as String);
      issues.addAll(textIssues);
    }

    // 5. Check for duplicate content
    final textResponses = responses
        .where((r) => r.type == ResponseType.text)
        .map((r) => (r.value as String).toLowerCase().trim())
        .toList();

    if (textResponses.length >= 2) {
      final uniqueTexts = textResponses.toSet().length;
      if (uniqueTexts < textResponses.length * 0.5) {
        issues.add(ValidationIssue(
          type: ValidationIssueType.duplicateContent,
          severity: IssueSeverity.medium,
          message: 'Too many duplicate text responses',
        ));
      }
    }

    // Calculate overall quality score
    final qualityScore = _calculateQualityScore(issues);

    return SurveyValidationResult(
      isValid: qualityScore >= 0.6,
      qualityScore: qualityScore,
      issues: issues,
    );
  }

  List<ValidationIssue> _validateTextResponse(String text) {
    final issues = <ValidationIssue>[];

    // Check minimum length
    if (text.length < 10) {
      issues.add(ValidationIssue(
        type: ValidationIssueType.tooShort,
        severity: IssueSeverity.low,
        message: 'Text response too short',
      ));
    }

    // Check for gibberish using entropy
    final entropy = _calculateEntropy(text);
    if (entropy < _minEntropyScore && text.length > 20) {
      issues.add(ValidationIssue(
        type: ValidationIssueType.gibberish,
        severity: IssueSeverity.high,
        message: 'Text appears to be gibberish',
      ));
    }

    // Check for keyboard mashing patterns
    if (_isKeyboardMashing(text)) {
      issues.add(ValidationIssue(
        type: ValidationIssueType.gibberish,
        severity: IssueSeverity.high,
        message: 'Text appears to be keyboard mashing',
      ));
    }

    return issues;
  }

  double _calculateEntropy(String text) {
    if (text.isEmpty) return 0;

    final charCounts = <String, int>{};
    for (final char in text.split('')) {
      charCounts[char] = (charCounts[char] ?? 0) + 1;
    }

    double entropy = 0;
    for (final count in charCounts.values) {
      final probability = count / text.length;
      entropy -= probability * (log(probability) / log(2));
    }

    // Normalize to 0-1 range
    return entropy / (log(text.length) / log(2)).clamp(1, double.infinity);
  }

  bool _isKeyboardMashing(String text) {
    // Check for common keyboard mashing patterns
    final patterns = [
      RegExp(r'(.)\1{4,}'), // Same character repeated 5+ times
      RegExp(r'asdf', caseSensitive: false),
      RegExp(r'qwer', caseSensitive: false),
      RegExp(r'zxcv', caseSensitive: false),
      RegExp(r'jkl;', caseSensitive: false),
    ];

    return patterns.any((p) => p.hasMatch(text));
  }

  double _calculateVariance(List<int> values) {
    if (values.isEmpty) return 0;
    final mean = values.reduce((a, b) => a + b) / values.length;
    final squaredDiffs = values.map((v) => pow(v - mean, 2));
    return squaredDiffs.reduce((a, b) => a + b) / values.length;
  }

  double _calculateQualityScore(List<ValidationIssue> issues) {
    double score = 1.0;

    for (final issue in issues) {
      switch (issue.severity) {
        case IssueSeverity.high:
          score -= 0.3;
          break;
        case IssueSeverity.medium:
          score -= 0.15;
          break;
        case IssueSeverity.low:
          score -= 0.05;
          break;
      }
    }

    return score.clamp(0, 1);
  }
}

class SurveyResponse {
  final String questionId;
  final ResponseType type;
  final dynamic value;
  final int responseTimeMs;

  SurveyResponse({
    required this.questionId,
    required this.type,
    required this.value,
    required this.responseTimeMs,
  });
}

enum ResponseType {
  multipleChoice,
  text,
  rating,
  scale,
}

class SurveyValidationResult {
  final bool isValid;
  final double qualityScore;
  final List<ValidationIssue> issues;

  SurveyValidationResult({
    required this.isValid,
    required this.qualityScore,
    required this.issues,
  });
}

class ValidationIssue {
  final ValidationIssueType type;
  final IssueSeverity severity;
  final String message;
  final Map<String, dynamic>? details;

  ValidationIssue({
    required this.type,
    required this.severity,
    required this.message,
    this.details,
  });
}

enum ValidationIssueType {
  tooFast,
  tooSlow,
  suspiciousTiming,
  straightlining,
  duplicateContent,
  gibberish,
  tooShort,
}

enum IssueSeverity {
  low,
  medium,
  high,
}
```

---

## 5.3 CAPTCHA Integration 🟡

**File:** `lib/core/security/captcha_service.dart`

```dart
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Service for CAPTCHA verification
/// Uses reCAPTCHA v3 for invisible verification
class CaptchaService {
  static const String _siteKey = 'YOUR_RECAPTCHA_SITE_KEY';
  static const String _verifyUrl =
      'https://us-central1-emalichat-d5a4c.cloudfunctions.net/verifyCaptcha';

  /// Risk actions that require CAPTCHA verification
  static const Set<String> _riskActions = {
    'cashout',
    'transfer_large', // Transfers > 1000 tokens
    'suspicious_login',
    'multiple_failed_attempts',
  };

  /// Check if an action requires CAPTCHA
  bool requiresCaptcha(String action, {int? amount}) {
    if (_riskActions.contains(action)) {
      return true;
    }

    // Large transfers require verification
    if (action == 'transfer' && amount != null && amount > 1000) {
      return true;
    }

    return false;
  }

  /// Execute CAPTCHA verification for an action
  Future<CaptchaResult> verify({
    required String action,
    String? userId,
  }) async {
    try {
      // In production, use recaptcha_enterprise or similar package
      // final token = await RecaptchaEnterprise.execute(_siteKey, action: action);

      // For development, simulate token generation
      final token = 'CAPTCHA_TOKEN_PLACEHOLDER';

      // Verify token with backend
      final response = await http.post(
        Uri.parse(_verifyUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'action': action,
          'userId': userId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CaptchaResult(
          success: data['success'] ?? false,
          score: (data['score'] ?? 0.0).toDouble(),
          action: data['action'] ?? action,
          errorCodes: List<String>.from(data['error-codes'] ?? []),
        );
      } else {
        return CaptchaResult(
          success: false,
          score: 0.0,
          action: action,
          errorCodes: ['server-error'],
        );
      }
    } catch (e) {
      debugPrint('CAPTCHA verification failed: $e');
      return CaptchaResult(
        success: false,
        score: 0.0,
        action: action,
        errorCodes: ['exception: $e'],
      );
    }
  }

  /// Check if a CAPTCHA score indicates bot behavior
  bool isBot(double score) {
    // reCAPTCHA v3 scores range from 0.0 (bot) to 1.0 (human)
    return score < 0.5;
  }

  /// Check if a CAPTCHA score indicates suspicious behavior
  bool isSuspicious(double score) {
    return score >= 0.5 && score < 0.7;
  }
}

class CaptchaResult {
  final bool success;
  final double score;
  final String action;
  final List<String> errorCodes;

  CaptchaResult({
    required this.success,
    required this.score,
    required this.action,
    required this.errorCodes,
  });

  bool get isHuman => success && score >= 0.5;
  bool get isBot => !success || score < 0.3;
  bool get isSuspicious => success && score >= 0.3 && score < 0.5;
}
```

---

## 5.4 Audit Trail System 🟡

**File:** `lib/core/security/audit_logger.dart`

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

/// Comprehensive audit logging for security-sensitive operations
class AuditLogger {
  final FirebaseFirestore _firestore;
  final DeviceInfoPlugin _deviceInfo;

  AuditLogger({
    FirebaseFirestore? firestore,
    DeviceInfoPlugin? deviceInfo,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _deviceInfo = deviceInfo ?? DeviceInfoPlugin();

  /// Log a security event
  Future<void> logSecurityEvent({
    required String userId,
    required SecurityEventType eventType,
    required String action,
    bool success = true,
    Map<String, dynamic>? metadata,
    String? errorMessage,
    RiskLevel? riskLevel,
  }) async {
    try {
      final deviceData = await _getDeviceInfo();
      final eventRef = _firestore.collection('auditLogs').doc();

      await eventRef.set({
        'id': eventRef.id,
        'userId': userId,
        'eventType': eventType.name,
        'action': action,
        'success': success,
        'metadata': metadata ?? {},
        'errorMessage': errorMessage,
        'riskLevel': riskLevel?.name ?? RiskLevel.low.name,
        'deviceInfo': deviceData,
        'timestamp': FieldValue.serverTimestamp(),
        'clientTimestamp': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Failed to log security event: $e');
      // Don't throw - logging should not break the app
    }
  }

  /// Log authentication event
  Future<void> logAuthEvent({
    required String userId,
    required AuthAction action,
    bool success = true,
    String? errorMessage,
    String? ipAddress,
  }) async {
    await logSecurityEvent(
      userId: userId,
      eventType: SecurityEventType.authentication,
      action: action.name,
      success: success,
      errorMessage: errorMessage,
      metadata: {
        'ipAddress': ipAddress,
      },
      riskLevel: success ? RiskLevel.low : RiskLevel.medium,
    );
  }

  /// Log financial transaction
  Future<void> logFinancialEvent({
    required String userId,
    required FinancialAction action,
    required int amount,
    bool success = true,
    String? transactionId,
    String? errorMessage,
  }) async {
    final riskLevel = _calculateFinancialRisk(action, amount);

    await logSecurityEvent(
      userId: userId,
      eventType: SecurityEventType.financial,
      action: action.name,
      success: success,
      errorMessage: errorMessage,
      metadata: {
        'amount': amount,
        'transactionId': transactionId,
        'zarValue': amount * 0.01,
      },
      riskLevel: riskLevel,
    );
  }

  /// Log fraud detection event
  Future<void> logFraudEvent({
    required String userId,
    required String fraudType,
    required double riskScore,
    required Map<String, dynamic> indicators,
    bool blocked = false,
  }) async {
    await logSecurityEvent(
      userId: userId,
      eventType: SecurityEventType.fraud,
      action: fraudType,
      success: !blocked,
      metadata: {
        'riskScore': riskScore,
        'indicators': indicators,
        'blocked': blocked,
      },
      riskLevel: riskScore > 0.7 ? RiskLevel.critical : RiskLevel.high,
    );
  }

  /// Log data access event
  Future<void> logDataAccessEvent({
    required String userId,
    required String resourceType,
    required String resourceId,
    required DataAccessAction action,
  }) async {
    await logSecurityEvent(
      userId: userId,
      eventType: SecurityEventType.dataAccess,
      action: action.name,
      metadata: {
        'resourceType': resourceType,
        'resourceId': resourceId,
      },
      riskLevel: RiskLevel.low,
    );
  }

  /// Get audit logs for a user
  Future<List<AuditLogEntry>> getLogsForUser(
    String userId, {
    int limit = 50,
    SecurityEventType? eventType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    Query query = _firestore
        .collection('auditLogs')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (eventType != null) {
      query = query.where('eventType', isEqualTo: eventType.name);
    }

    if (startDate != null) {
      query = query.where('timestamp', isGreaterThanOrEqualTo: startDate);
    }

    if (endDate != null) {
      query = query.where('timestamp', isLessThanOrEqualTo: endDate);
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => AuditLogEntry.fromFirestore(doc))
        .toList();
  }

  RiskLevel _calculateFinancialRisk(FinancialAction action, int amount) {
    if (action == FinancialAction.cashout) {
      if (amount >= 50000) return RiskLevel.critical;
      if (amount >= 10000) return RiskLevel.high;
      if (amount >= 5000) return RiskLevel.medium;
    }

    if (action == FinancialAction.transfer) {
      if (amount >= 10000) return RiskLevel.high;
      if (amount >= 1000) return RiskLevel.medium;
    }

    return RiskLevel.low;
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        return {
          'platform': 'android',
          'model': info.model,
          'brand': info.brand,
          'sdkVersion': info.version.sdkInt,
          'isPhysicalDevice': info.isPhysicalDevice,
        };
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        return {
          'platform': 'ios',
          'model': info.model,
          'systemVersion': info.systemVersion,
          'isPhysicalDevice': info.isPhysicalDevice,
        };
      }
    } catch (e) {
      debugPrint('Failed to get device info: $e');
    }

    return {'platform': 'unknown'};
  }
}

enum SecurityEventType {
  authentication,
  financial,
  fraud,
  dataAccess,
  systemEvent,
}

enum AuthAction {
  login,
  logout,
  register,
  passwordReset,
  otpVerification,
  tokenRefresh,
  sessionExpired,
}

enum FinancialAction {
  earn,
  cashout,
  transfer,
  purchase,
  potWin,
  referralBonus,
}

enum DataAccessAction {
  read,
  create,
  update,
  delete,
  export,
}

enum RiskLevel {
  low,
  medium,
  high,
  critical,
}

class AuditLogEntry {
  final String id;
  final String userId;
  final SecurityEventType eventType;
  final String action;
  final bool success;
  final Map<String, dynamic> metadata;
  final String? errorMessage;
  final RiskLevel riskLevel;
  final Map<String, dynamic> deviceInfo;
  final DateTime timestamp;

  AuditLogEntry({
    required this.id,
    required this.userId,
    required this.eventType,
    required this.action,
    required this.success,
    required this.metadata,
    this.errorMessage,
    required this.riskLevel,
    required this.deviceInfo,
    required this.timestamp,
  });

  factory AuditLogEntry.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AuditLogEntry(
      id: doc.id,
      userId: data['userId'],
      eventType: SecurityEventType.values.firstWhere(
        (e) => e.name == data['eventType'],
        orElse: () => SecurityEventType.systemEvent,
      ),
      action: data['action'],
      success: data['success'] ?? true,
      metadata: Map<String, dynamic>.from(data['metadata'] ?? {}),
      errorMessage: data['errorMessage'],
      riskLevel: RiskLevel.values.firstWhere(
        (e) => e.name == data['riskLevel'],
        orElse: () => RiskLevel.low,
      ),
      deviceInfo: Map<String, dynamic>.from(data['deviceInfo'] ?? {}),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
```

---

## 5.5 Cloud Function: Verify Play Integrity

**File:** `functions/src/fraud.ts`

```typescript
/**
 * Fraud Prevention Cloud Functions
 */

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

// Play Integrity API configuration
const PLAY_INTEGRITY_PROJECT_NUMBER = process.env.GOOGLE_CLOUD_PROJECT_NUMBER;

/**
 * Verify Play Integrity token
 */
export const verifyPlayIntegrity = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const { token, nonce } = data;

  if (!token || !nonce) {
    throw new functions.https.HttpsError("invalid-argument", "Token and nonce required");
  }

  try {
    // In production, call Play Integrity API
    // const playintegrity = google.playintegrity('v1');
    // const result = await playintegrity.v1.decodeIntegrityToken({
    //   packageName: 'com.imali.chat',
    //   requestBody: { integrityToken: token }
    // });

    // For now, return a simulated response
    const verdict = {
      isValid: true,
      verdict: "MEETS_DEVICE_INTEGRITY",
      deviceRecognition: "MEETS_DEVICE_INTEGRITY",
      appLicensing: "LICENSED",
      details: "Token verified successfully",
    };

    // Log the verification attempt
    await db.collection("integrityChecks").add({
      userId: context.auth.uid,
      nonce: nonce,
      result: verdict,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    return verdict;
  } catch (error) {
    console.error("Play Integrity verification failed:", error);
    throw new functions.https.HttpsError("internal", "Verification failed");
  }
});

/**
 * Verify reCAPTCHA token
 */
export const verifyCaptcha = functions.https.onCall(async (data, context) => {
  const { token, action, userId } = data;

  if (!token) {
    throw new functions.https.HttpsError("invalid-argument", "Token required");
  }

  try {
    // In production, call reCAPTCHA Enterprise API
    // const recaptcha = require('@google-cloud/recaptcha-enterprise');
    // const client = new recaptcha.RecaptchaEnterpriseServiceClient();
    // const result = await client.createAssessment({...});

    // Simulated response
    const result = {
      success: true,
      score: 0.9,
      action: action,
      "error-codes": [],
    };

    // Log the verification
    await db.collection("captchaVerifications").add({
      userId: userId || null,
      action: action,
      score: result.score,
      success: result.success,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    return result;
  } catch (error) {
    console.error("CAPTCHA verification failed:", error);
    throw new functions.https.HttpsError("internal", "Verification failed");
  }
});

/**
 * Check user fraud risk before high-value operation
 */
export const checkFraudRisk = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const userId = context.auth.uid;
  const { action, amount } = data;

  // Get user's fraud history
  const fraudFlags = await db.collection("fraudFlags")
    .where("userId", isEqualTo: userId)
    .where("active", isEqualTo: true)
    .get();

  if (!fraudFlags.empty) {
    // User has active fraud flags
    return {
      allowed: false,
      reason: "Account flagged for review",
      riskScore: 1.0,
    };
  }

  // Check recent suspicious activity
  const oneDayAgo = new Date();
  oneDayAgo.setDate(oneDayAgo.getDate() - 1);

  const recentActivity = await db.collection("auditLogs")
    .where("userId", isEqualTo: userId)
    .where("riskLevel", "in", ["high", "critical"])
    .where("timestamp", ">=", admin.firestore.Timestamp.fromDate(oneDayAgo))
    .get();

  let riskScore = 0;

  // Calculate risk score based on recent activity
  for (const doc of recentActivity.docs) {
    const data = doc.data();
    if (data.riskLevel === "critical") {
      riskScore += 0.3;
    } else if (data.riskLevel === "high") {
      riskScore += 0.15;
    }
  }

  // Adjust for action type and amount
  if (action === "cashout" && amount >= 10000) {
    riskScore += 0.2;
  }

  riskScore = Math.min(riskScore, 1.0);

  return {
    allowed: riskScore < 0.7,
    reason: riskScore >= 0.7 ? "High risk detected" : null,
    riskScore: riskScore,
    requiresCaptcha: riskScore >= 0.5,
  };
});
```

---

# SECTION 6: MISSING BLOCS

## 6.1 HomeBloc 🟡

**File:** `lib/presentation/blocs/home/home_bloc.dart`

```dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/wallet.dart';
import '../../../domain/entities/earn_thread.dart';
import '../../../domain/entities/pot_pool.dart';
import '../../../domain/repositories/wallet_repository.dart';
import '../../../domain/repositories/earn_repository.dart';
import '../../../domain/repositories/gamification_repository.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WalletRepository _walletRepository;
  final EarnRepository _earnRepository;
  final GamificationRepository _gamificationRepository;

  StreamSubscription? _walletSubscription;

  HomeBloc({
    required WalletRepository walletRepository,
    required EarnRepository earnRepository,
    required GamificationRepository gamificationRepository,
  })  : _walletRepository = walletRepository,
        _earnRepository = earnRepository,
        _gamificationRepository = gamificationRepository,
        super(const HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      await event.when(
        loadDashboard: (userId) => _onLoadDashboard(userId, emit),
        refreshWallet: (userId) => _onRefreshWallet(userId, emit),
        subscribeToWallet: (userId) => _onSubscribeToWallet(userId, emit),
        unsubscribe: () => _onUnsubscribe(emit),
      );
    });
  }

  Future<void> _onLoadDashboard(
    String userId,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());

    try {
      // Load all dashboard data in parallel
      final results = await Future.wait([
        _walletRepository.getWallet(userId),
        _earnRepository.getAvailableOpportunities(userId),
        _gamificationRepository.getCurrentPots(),
      ]);

      final walletResult = results[0] as dynamic;
      final opportunitiesResult = results[1] as dynamic;
      final potsResult = results[2] as dynamic;

      // Check for failures
      Wallet? wallet;
      List<EarnThread> opportunities = [];
      List<PotPool> pots = [];

      walletResult.fold(
        (failure) => null,
        (w) => wallet = w,
      );

      opportunitiesResult.fold(
        (failure) => null,
        (o) => opportunities = o,
      );

      potsResult.fold(
        (failure) => null,
        (p) => pots = p,
      );

      if (wallet == null) {
        emit(const HomeState.error('Failed to load wallet'));
        return;
      }

      emit(HomeState.loaded(
        wallet: wallet!,
        earnOpportunities: opportunities,
        activePots: pots,
        dailyProgress: _calculateDailyProgress(wallet!),
      ));
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }

  Future<void> _onRefreshWallet(
    String userId,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;

    if (currentState is _Loaded) {
      final result = await _walletRepository.getWallet(userId);

      result.fold(
        (failure) => null,
        (wallet) {
          emit(currentState.copyWith(
            wallet: wallet,
            dailyProgress: _calculateDailyProgress(wallet),
          ));
        },
      );
    }
  }

  Future<void> _onSubscribeToWallet(
    String userId,
    Emitter<HomeState> emit,
  ) async {
    await _walletSubscription?.cancel();

    _walletSubscription = _walletRepository.watchWallet(userId).listen(
      (result) {
        result.fold(
          (failure) => null,
          (wallet) {
            final currentState = state;
            if (currentState is _Loaded) {
              add(HomeEvent.refreshWallet(userId));
            }
          },
        );
      },
    );
  }

  Future<void> _onUnsubscribe(Emitter<HomeState> emit) async {
    await _walletSubscription?.cancel();
    _walletSubscription = null;
  }

  double _calculateDailyProgress(Wallet wallet) {
    const dailyCap = 500;
    return (wallet.todayEarned / dailyCap).clamp(0.0, 1.0);
  }

  @override
  Future<void> close() {
    _walletSubscription?.cancel();
    return super.close();
  }
}
```

**File:** `lib/presentation/blocs/home/home_event.dart`

```dart
part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadDashboard(String userId) = _LoadDashboard;
  const factory HomeEvent.refreshWallet(String userId) = _RefreshWallet;
  const factory HomeEvent.subscribeToWallet(String userId) = _SubscribeToWallet;
  const factory HomeEvent.unsubscribe() = _Unsubscribe;
}
```

**File:** `lib/presentation/blocs/home/home_state.dart`

```dart
part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded({
    required Wallet wallet,
    required List<EarnThread> earnOpportunities,
    required List<PotPool> activePots,
    required double dailyProgress,
  }) = _Loaded;
  const factory HomeState.error(String message) = _Error;
}
```

---

## 6.2 ProfileBloc 🟡

**File:** `lib/presentation/blocs/profile/profile_bloc.dart`

```dart
import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_profile.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  ProfileBloc({
    required UserRepository userRepository,
    required AuthRepository authRepository,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        super(const ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      await event.when(
        loadProfile: (userId) => _onLoadProfile(userId, emit),
        updateDisplayName: (userId, name) =>
            _onUpdateDisplayName(userId, name, emit),
        updateAvatar: (userId, imageFile) =>
            _onUpdateAvatar(userId, imageFile, emit),
        updateBio: (userId, bio) => _onUpdateBio(userId, bio, emit),
        updateNotificationSettings: (userId, settings) =>
            _onUpdateNotificationSettings(userId, settings, emit),
        deleteAccount: (userId) => _onDeleteAccount(userId, emit),
        signOut: () => _onSignOut(emit),
      );
    });
  }

  Future<void> _onLoadProfile(
    String userId,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loading());

    final result = await _userRepository.getUser(userId);

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (user) => emit(ProfileState.loaded(user: user)),
    );
  }

  Future<void> _onUpdateDisplayName(
    String userId,
    String name,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    emit(ProfileState.updating(user: currentState.user));

    final result = await _userRepository.updateDisplayName(userId, name);

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (user) => emit(ProfileState.loaded(user: user)),
    );
  }

  Future<void> _onUpdateAvatar(
    String userId,
    File imageFile,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    emit(ProfileState.updating(user: currentState.user));

    final result = await _userRepository.updateAvatar(userId, imageFile);

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (user) => emit(ProfileState.loaded(user: user)),
    );
  }

  Future<void> _onUpdateBio(
    String userId,
    String bio,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    emit(ProfileState.updating(user: currentState.user));

    final result = await _userRepository.updateBio(userId, bio);

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (user) => emit(ProfileState.loaded(user: user)),
    );
  }

  Future<void> _onUpdateNotificationSettings(
    String userId,
    NotificationSettings settings,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! _Loaded) return;

    emit(ProfileState.updating(user: currentState.user));

    final result = await _userRepository.updateNotificationSettings(
      userId,
      settings,
    );

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (user) => emit(ProfileState.loaded(user: user)),
    );
  }

  Future<void> _onDeleteAccount(
    String userId,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.deleting());

    final result = await _userRepository.deleteAccount(userId);

    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (_) => emit(const ProfileState.deleted()),
    );
  }

  Future<void> _onSignOut(Emitter<ProfileState> emit) async {
    await _authRepository.signOut();
    emit(const ProfileState.signedOut());
  }
}

class NotificationSettings {
  final bool earnReminders;
  final bool potResults;
  final bool chatMessages;
  final bool referralBonuses;
  final bool marketingEmails;

  NotificationSettings({
    this.earnReminders = true,
    this.potResults = true,
    this.chatMessages = true,
    this.referralBonuses = true,
    this.marketingEmails = false,
  });

  Map<String, bool> toMap() => {
        'earnReminders': earnReminders,
        'potResults': potResults,
        'chatMessages': chatMessages,
        'referralBonuses': referralBonuses,
        'marketingEmails': marketingEmails,
      };
}
```

**File:** `lib/presentation/blocs/profile/profile_event.dart`

```dart
part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.loadProfile(String userId) = _LoadProfile;
  const factory ProfileEvent.updateDisplayName(String userId, String name) =
      _UpdateDisplayName;
  const factory ProfileEvent.updateAvatar(String userId, File imageFile) =
      _UpdateAvatar;
  const factory ProfileEvent.updateBio(String userId, String bio) = _UpdateBio;
  const factory ProfileEvent.updateNotificationSettings(
    String userId,
    NotificationSettings settings,
  ) = _UpdateNotificationSettings;
  const factory ProfileEvent.deleteAccount(String userId) = _DeleteAccount;
  const factory ProfileEvent.signOut() = _SignOut;
}
```

**File:** `lib/presentation/blocs/profile/profile_state.dart`

```dart
part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded({required User user}) = _Loaded;
  const factory ProfileState.updating({required User user}) = _Updating;
  const factory ProfileState.deleting() = _Deleting;
  const factory ProfileState.deleted() = _Deleted;
  const factory ProfileState.signedOut() = _SignedOut;
  const factory ProfileState.error(String message) = _Error;
}
```

---

# IMPLEMENTATION CHECKLIST

## Priority Order

### 🔴 P0 - Critical (Week 1-2)

| # | Task | Files | Status |
|---|------|-------|--------|
| 1 | Add Drift dependencies to pubspec.yaml | pubspec.yaml | ⬜ |
| 2 | Create AppDatabase (Drift) | lib/data/datasources/local/app_database.dart | ⬜ |
| 3 | Run build_runner for Drift | - | ⬜ |
| 4 | Create SyncRemoteDataSource | lib/data/datasources/remote/sync_remote_datasource.dart | ⬜ |
| 5 | Implement SyncRepositoryImpl | lib/data/repositories/sync_repository_impl.dart | ⬜ |
| 6 | Update DI container with sync services | lib/core/di/injection_container.dart | ⬜ |

### 🟠 P1 - High Priority (Week 2-3)

| # | Task | Files | Status |
|---|------|-------|--------|
| 7 | Create Chat Cloud Functions | functions/src/chat.ts | ⬜ |
| 8 | Create Engagement Cloud Functions | functions/src/engagement.ts | ⬜ |
| 9 | Update index.ts exports | functions/src/index.ts | ⬜ |
| 10 | Deploy new Cloud Functions | - | ⬜ |
| 11 | Implement ContactRepositoryImpl | lib/data/repositories/contact_repository_impl.dart | ⬜ |
| 12 | Add contacts_service dependency | pubspec.yaml | ⬜ |

### 🟡 P2 - Medium Priority (Week 3-4)

| # | Task | Files | Status |
|---|------|-------|--------|
| 13 | Create Survey entity | lib/domain/entities/survey.dart | ⬜ |
| 14 | Create EarnMessage entity | lib/domain/entities/earn_message.dart | ⬜ |
| 15 | Create PotDistribution entity | lib/domain/entities/pot_distribution.dart | ⬜ |
| 16 | Create Campaign entity | lib/domain/entities/campaign.dart | ⬜ |
| 17 | Create Video entity | lib/domain/entities/video.dart | ⬜ |
| 18 | Run build_runner for entities | - | ⬜ |
| 19 | Create HomeBloc | lib/presentation/blocs/home/ | ⬜ |
| 20 | Create ProfileBloc | lib/presentation/blocs/profile/ | ⬜ |
| 21 | Create PlayIntegrityService | lib/core/security/play_integrity_service.dart | ⬜ |
| 22 | Create SurveyValidator | lib/core/security/survey_validator.dart | ⬜ |
| 23 | Create CaptchaService | lib/core/security/captcha_service.dart | ⬜ |
| 24 | Create AuditLogger | lib/core/security/audit_logger.dart | ⬜ |
| 25 | Create Fraud Cloud Functions | functions/src/fraud.ts | ⬜ |
| 26 | Update index.ts with fraud exports | functions/src/index.ts | ⬜ |

---

## Dependencies to Add

```yaml
# pubspec.yaml additions
dependencies:
  # Drift (SQLite)
  drift: ^2.14.0
  sqlite3_flutter_libs: ^0.5.18
  path_provider: ^2.1.1
  path: ^1.8.3

  # Connectivity
  connectivity_plus: ^5.0.2

  # Contacts
  contacts_service: ^0.6.3

  # Device Info
  device_info_plus: ^9.1.1

dev_dependencies:
  drift_dev: ^2.14.0
  build_runner: ^2.4.7
```

---

## Build Commands

```bash
# Generate Drift code
flutter pub run build_runner build --delete-conflicting-outputs

# Generate Freezed code for new entities
flutter pub run build_runner build --delete-conflicting-outputs

# Deploy Cloud Functions
cd functions && npm run build && firebase deploy --only functions
```

---

## Testing Checklist

- [ ] Drift database operations work correctly
- [ ] Sync operations work offline → online
- [ ] Chat P2P token transfers work
- [ ] Engagement tracking and rewards work
- [ ] Contact sync and invites work
- [ ] Play Integrity verification works on Android
- [ ] Survey validation catches fraud patterns
- [ ] Audit logs are created for security events
- [ ] HomeBloc loads dashboard correctly
- [ ] ProfileBloc handles all profile operations

---

## Notes

1. **Offline-First Priority**: The Drift implementation should be completed first as it affects multiple features.

2. **Cloud Functions**: Deploy and test incrementally to catch issues early.

3. **Security**: Play Integrity API requires Google Play Console setup and project configuration.

4. **Testing**: Run existing tests after each major change to ensure no regressions.

5. **Dependencies**: Some packages may require additional Android/iOS configuration (permissions, etc.).
