# Plan: Complete Communities Refactor

## Context

Comprehensive audit found 200+ issues across all 6 layers (domain, data, core services, presentation, UI screens, Cloud Functions). **Two critique passes** added 70+ more issues: repository methods missing network checks, no local cache seeding after mutations, BLoC handlers silently swallowing failures, no optimistic state updates, reaction handlers emitting empty maps, media type inference bugs, UI crash-on-null paths, double-tap vulnerabilities, and more. This plan addresses **every issue** — nothing deferred. The work is organized into 12 phases, ordered by dependency (domain first, tests last).

---

## Phase 1: Domain Layer — Type Safety & Validation

### 1.1 Community entity: `status` String → `CommunityStatus` enum
**File:** `lib/domain/entities/community.dart` line 70

`CommunityStatus` enum already exists at `lib/domain/enums/community_status.dart` but is never imported or used. Change:
```dart
required String status,  →  required CommunityStatus status,
```
Update all derived getters (lines 101-103):
```dart
bool get isActive => status == CommunityStatus.active;
bool get isSuspended => status == CommunityStatus.suspended;
bool get isClosed => status == CommunityStatus.closed;
```
Add import: `import '../enums/community_status.dart';`

### 1.2 Create `ApprovalStatus` enum
**New file:** `lib/domain/enums/approval_status.dart`
```dart
enum ApprovalStatus {
  @JsonValue('pending') pending,
  @JsonValue('approved') approved,
  @JsonValue('rejected') rejected,
  @JsonValue('expired') expired;
  String get displayName => name[0].toUpperCase() + name.substring(1);
}
```

### 1.3 CommunityApproval: type/status String → enums
**File:** `lib/domain/entities/community_transaction.dart`
- `type` (line 125): `String` → `CommunityTransactionType`
- `status` (line 129): `String` → `ApprovalStatus`
- Fix `isExpired` (line 142): Use enum-only check + separate `hasTimePassed` getter
- Fix `isPending` (line 139): Use `status == ApprovalStatus.pending && !hasTimePassed`

### 1.4 Add missing permission methods to MemberRole
**File:** `lib/domain/enums/member_role.dart`
Add to `MemberRoleX` extension:
```dart
bool get canViewLedger => this != MemberRole.viewer;
bool get canEditSettings => this == MemberRole.owner || this == MemberRole.admin;
```

### 1.5 Add permission methods to CommunityMember
**File:** `lib/domain/entities/community_member.dart`
Add:
```dart
bool get canViewLedger => role.canViewLedger;
bool get canEditSettings => role.canEditSettings;
```

### 1.6 CommunitySettings validation
**File:** `lib/domain/entities/community.dart`
Add to `CommunitySettings`:
```dart
bool get isValid {
  if (contributionAmount < 0) return false;
  if (penaltyPercentage < 0 || penaltyPercentage > 100) return false;
  if (maxMembers < 1) return false;
  if (requireApprovalAbove < 0) return false;
  if (contributionCycle != 'none' && contributionCycle != 'weekly' &&
      contributionCycle != 'monthly' && contributionCycle != 'yearly') return false;
  return true;
}
```

### 1.7 Community entity invariant methods
**File:** `lib/domain/entities/community.dart`
Add:
```dart
bool get hasValidAdmins => adminIds.every((id) => memberIds.contains(id));
bool get ownerIsMember => memberIds.contains(ownerId);
```

### 1.8 Fix `needsApproval` logic bug in CommunityTransaction
**File:** `lib/domain/entities/community_transaction.dart` lines 51-53
Current code includes `approved` status — already-approved transactions don't "need" approval:
```dart
// BEFORE (wrong):
bool get needsApproval => status == ...pending || status == ...approved;
// AFTER (correct):
bool get needsApproval => status == CommunityTransactionStatus.pending;
```

---

## Phase 2: Data Models — Cascading Type Changes & Logging

### 2.1 CommunityModel: status String → CommunityStatus
**File:** `lib/data/models/community_model.dart`
- Change `status` field from `String` to `String` (keep as String in model for Firestore compat)
- Update `toEntity()` to parse: `status: CommunityStatus.values.byName(status)` with logged fallback
- Update `fromEntity()` to serialize: `status: entity.status.name`

### 2.2 CommunityMemberModel: Log enum fallbacks
**File:** `lib/data/models/community_member_model.dart` lines 58-65
Replace silent `orElse` with logged fallback:
```dart
role: MemberRole.values.firstWhere(
  (e) => e.name == role,
  orElse: () {
    debugPrint('WARNING: Unknown member role "$role", defaulting to member');
    return MemberRole.member;
  },
),
status: MemberStatus.values.firstWhere(
  (e) => e.name == status,
  orElse: () {
    debugPrint('WARNING: Unknown member status "$status", defaulting to invited');
    return MemberStatus.invited;
  },
),
```

### 2.3 CommunityTransactionModel: Log enum fallbacks
**File:** `lib/data/models/community_transaction_model.dart`
Same pattern for `_parseTransactionType` and `_parseTransactionStatus` — add `debugPrint` warnings.

### 2.4 CommunityModel: Validate lastMessage structure
**File:** `lib/data/models/community_model.dart` lines 109-118
Add null-safe per-field extraction instead of assuming all fields exist:
```dart
if (lastMessage is Map<String, dynamic>) {
  sanitized['lastMessageText'] = lastMessage['text'] as String?;
  sanitized['lastMessageSenderId'] = lastMessage['senderId'] as String?;
  sanitized['lastMessageSenderName'] = lastMessage['senderName'] as String?;
  sanitized['lastMessageType'] = lastMessage['type'] as String?;
  // Handle timestamp safely
  final ts = lastMessage['timestamp'];
  if (ts is Timestamp) sanitized['lastMessageAt'] = ts;
}
```

### 2.5 LocalCommunityMapper: Handle CommunityStatus + add logging to parse methods
**File:** `lib/data/mappers/local_community_mapper.dart`
- Update `toEntity()` and `toCompanion()` to handle `CommunityStatus` enum ↔ String
- Add `debugPrint` warnings to ALL silent parse methods: `_parseStringList` (line 83), `_parseIntMap` (line 112), `_parseBoolMap` (line 121), `_parseStringMap` (line 130), `_parseCommunityType` (line 76) — currently all silently return defaults
- Fix `_parseIntMap`: `(v as num).toInt()` → `(v as num?)?.toInt() ?? 0` (null safety)
- Fix `_parseBoolMap`: `v as bool` → `(v is bool) ? v : false` (type safety)

### 2.6 Fix `communityName` lost in LocalCommunityMemberMapper
**File:** `lib/data/mappers/local_community_member_mapper.dart`
`toCompanion()` (lines 11-27) does NOT map `communityName` from entity. Field is silently dropped:
- Add `communityName` column to `LocalCommunityMembers` Drift table (if missing)
- Map it in `toCompanion()`: `communityName: Value(member.communityName)`
- Map it back in `toEntity()`: `communityName: row.communityName`

### 2.7 Fix `createdAt` forced to `DateTime.now()` in member mapper
**File:** `lib/data/mappers/local_community_member_mapper.dart` line 25
`createdAt: Value(DateTime.now())` overwrites actual timestamp on EVERY upsert:
```dart
// BEFORE (wrong): createdAt: Value(DateTime.now()),
// AFTER: createdAt: Value(member.invitedAt),
```

### 2.8 Fix inconsistent enum defaults between mappers
- `LocalCommunityMemberMapper._parseMemberStatus` (line 54) defaults to `MemberStatus.active`
- `CommunityMemberModel.toEntity()` defaults to `MemberStatus.invited`
- Standardize: both should default to `MemberStatus.invited` (safer — restricts permissions)

### 2.9 Remove dead code in datasource interface
**File:** `lib/data/datasources/remote/community_remote_datasource.dart`
`sendTextMessage()` and `sendMediaMessage()` methods are NOT used by the repository (messages go through `OutgoingMessageQueue` instead). Remove from interface or document why they exist.

### 2.10 Fix fragile error string matching in datasource
**File:** `lib/data/datasources/remote/community_remote_datasource.dart`
Replace `error.toString().contains('insufficient')` with exception type checks:
```dart
} on FirebaseFunctionsException catch (e) {
  if (e.code == 'failed-precondition') { ... }
}
```

---

## Phase 3: Repository Implementation — Batch Ops, Error Handling, Pagination

### 3.1 Batch member upserts
**File:** `lib/data/repositories/community_repository_impl.dart` lines 308-321
Replace N sequential writes with Drift batch:
```dart
await _appDatabase.batch((b) {
  for (final model in models) {
    final entity = model.toEntity();
    b.insert(
      _appDatabase.localCommunityMembers,
      LocalCommunityMemberMapper.toCompanion(entity),
      onConflict: DoUpdate((_) => LocalCommunityMemberMapper.toCompanion(entity)),
    );
  }
});
```

### 3.2 Database-level message pagination
**File:** `lib/data/repositories/community_repository_impl.dart` lines 365-388
Move `before` filter and `limit` into DB query instead of client-side filtering. Use Drift's `.where()` and `.limit()`.

### 3.3 Local DB cleanup after leaveCommunity
**File:** `lib/data/repositories/community_repository_impl.dart`
After `leaveCommunity()` succeeds, clean local DB (same as `deleteCommunity`):
```dart
await _appDatabase.deleteLocalCommunity(communityId);
await _appDatabase.deleteLocalCommunityMembersForCommunity(communityId);
```

### 3.4 markAsRead implementation
**File:** `lib/data/repositories/community_repository_impl.dart`
Verify `markAsRead` method exists and calls the remote datasource. If missing, add:
```dart
@override
Future<Either<Failure, void>> markAsRead({required String communityId}) async {
  try {
    await _remoteDataSource.markAsRead(communityId);
    return const Right(null);
  } catch (e) {
    return Left(Failure.serverError(message: e.toString()));
  }
}
```

### 3.5 Fix `getPendingInvitations` N+1 query
**File:** `lib/data/datasources/remote/community_remote_datasource.dart`
Current code fetches community doc per invitation (up to 50+ reads). Replace with single Cloud Function call or batch `getAll()`:
```dart
final communityRefs = memberDocs.map((m) => _firestore.collection('communities').doc(m.communityId)).toList();
final communityDocs = await _firestore.getAll(communityRefs); // Single batch read
```

### 3.6 Add client-side idempotency keys for contribute/withdraw
**File:** `lib/data/repositories/community_repository_impl.dart`
Generate UUID before calling remote datasource, pass as parameter:
```dart
final idempotencyKey = const Uuid().v4();
await _remoteDataSource.contribute(communityId: ..., amount: ..., idempotencyKey: idempotencyKey);
```

### 3.7 Safe unread count JSON decode
**File:** `lib/data/repositories/community_repository_impl.dart`
Wrap `jsonDecode(row.unreadCountsJson)` in try-catch with logged fallback:
```dart
Map<String, int> unreadCounts;
try {
  unreadCounts = Map<String, int>.from(jsonDecode(row.unreadCountsJson));
} catch (e) {
  debugPrint('WARNING: Corrupt unreadCounts JSON for ${row.id}: $e');
  unreadCounts = {};
}
```

### 3.8 Document `refreshMembers()` → `getMembers()`/`watchMembers()` contract
Add doc comments clarifying that `getMembers()`/`watchMembers()` read from local DB only. Callers must ensure sync service is running or call `refreshMembers()` first.

### 3.9 Add missing network checks to read methods
**File:** `lib/data/repositories/community_repository_impl.dart`
These methods call the remote datasource WITHOUT checking network first (inconsistent with all write methods):
- `getTransactions()` (line ~612) — add `_networkInfo.isConnected` check
- `getPendingApprovals()` (line ~652) — add network check
- `getBalance()` (line ~690) — add network check
- `refreshMembers()` (line ~308) — add network check + replace broad `catch (e)` with typed exception handling

### 3.10 Seed local cache after `createCommunity()` and `updateCommunity()`
**File:** `lib/data/repositories/community_repository_impl.dart`
- `createCommunity()`: After remote success, upsert new community to local DB:
  ```dart
  final entity = model.toEntity();
  await _appDatabase.upsertLocalCommunity(LocalCommunityMapper.toCompanion(entity));
  return Right(entity);
  ```
- `updateCommunity()`: After remote success, update local cache:
  ```dart
  // Re-fetch updated community and seed local DB
  ```
Currently neither method touches local DB, so UI shows stale data until sync fires.

### 3.11 Update local state after `acceptInvitation()` / `declineInvitation()`
**File:** `lib/data/repositories/community_repository_impl.dart`
After remote success:
- `acceptInvitation()`: Update local member status to `active`, remove from pending invitations
- `declineInvitation()`: Delete local member record for this community

### 3.12 Fix `sendMediaMessage()` type inference bug
**File:** `lib/data/datasources/remote/community_remote_datasource.dart`
Current code (line ~589): `type: mediaType.startsWith('image') ? 'image' : 'voice'`
Only handles image/voice — video and documents are classified as 'voice'. Fix:
```dart
String _inferMessageType(String mediaType) {
  if (mediaType.startsWith('image')) return 'image';
  if (mediaType.startsWith('video')) return 'video';
  if (mediaType.startsWith('audio')) return 'voice';
  return 'document';
}
```

### 3.13 Standardize stream error handling pattern
**File:** `lib/data/repositories/community_repository_impl.dart`
Two inconsistent patterns exist:
- `watchUserCommunities()`, `watchMembers()`, `watchMessages()` use try/catch inside `.map()`
- `watchTransactions()`, `watchPendingApprovals()` use `.handleError()`
Standardize ALL to use try/catch inside `.map()` for consistency and proper error conversion.

---

## Phase 4: CommunityBloc — State Management Overhaul

### 4.1 operationStatus auto-reset to idle
**File:** `lib/presentation/blocs/community/community_bloc.dart`

Add helper methods:
```dart
void _emitSuccess(Emitter<CommunityState> emit, String message, {CommunityState? base}) {
  final s = base ?? state;
  emit(s.copyWith(
    operationStatus: CommunityOperationStatus.success,
    successMessage: message,
  ));
  emit(state.copyWith(
    operationStatus: CommunityOperationStatus.idle,
    successMessage: null,
    errorMessage: null,
  ));
}

void _emitFailure(Emitter<CommunityState> emit, Failure failure) {
  emit(state.copyWith(
    operationStatus: CommunityOperationStatus.failure,
    errorMessage: failure.displayMessage,
  ));
  emit(state.copyWith(
    operationStatus: CommunityOperationStatus.idle,
    errorMessage: null,
    successMessage: null,
  ));
}
```

Apply to ALL 14 handlers: `_onCreateCommunity`, `_onUpdateCommunity`, `_onDeleteCommunity`, `_onInviteMember`, `_onAcceptInvitation`, `_onDeclineInvitation`, `_onRemoveMember`, `_onUpdateMemberRole`, `_onLeaveCommunity`, `_onContribute`, `_onWithdraw`, `_onApproveTransaction`, `_onRejectTransaction`, `_onTriggerPayout`.

### 4.2 Stream error logging
Replace `(failure) => {}` with `(failure) => debugPrint(...)` in:
- `_onWatchUserCommunities` (line 114)
- `_onWatchMembers` (line 192)
- `_onWatchTransactions` (line 218)
- `_onWatchPendingApprovals` (line 243)
- Unread count stream (line 127)

### 4.3 Guard against duplicate watch subscriptions
In `_onLoadUserCommunities`, check if already watching before adding `watchUserCommunities`:
```dart
if (_communitiesSubscription == null) {
  add(const CommunityEvent.watchUserCommunities());
}
```

### 4.4 Add `isClosed` guard in ALL stream callbacks
Every stream `.listen()` callback that calls `add()` must guard against closed BLoC:
```dart
.listen((result) {
  if (!isClosed) {
    result.fold(
      (failure) => debugPrint('...'),
      (data) => add(CommunityEvent.xxx(data)),
    );
  }
});
```
Apply to all 5 stream subscriptions in CommunityBloc.

### 4.5 Await subscription cancellation before re-listen
All watch handlers must `await` the cancel before setting up new listener:
```dart
await _communitiesSubscription?.cancel();
_communitiesSubscription = _repo.watchXxx().listen(...);
```
Apply to `_onWatchUserCommunities`, `_onWatchMembers`, `_onWatchTransactions`, `_onWatchPendingApprovals`, unread count stream.

### 4.6 Await subscriptions in `close()`
```dart
@override
Future<void> close() async {
  await _communitiesSubscription?.cancel();
  await _membersSubscription?.cancel();
  await _transactionsSubscription?.cancel();
  await _approvalsSubscription?.cancel();
  await _unreadSubscription?.cancel();
  return super.close();
}
```

### 4.7 Reset unread count on community delete
In `_onDeleteCommunity` success path, reset `totalUnreadCount`:
```dart
emit(state.copyWith(totalUnreadCount: 0, selectedCommunity: null));
```

### 4.8 Invalidate `selectedCommunity` when community list changes
In `_onUserCommunitiesUpdated`, check if `selectedCommunity` still exists in list:
```dart
final stillExists = communities.any((c) => c.id == state.selectedCommunity?.id);
emit(state.copyWith(
  communities: communities,
  selectedCommunity: stillExists ? state.selectedCommunity : null,
));
```

### 4.9 Fix `_onLoadPendingInvitations` — emit error state instead of swallowing
Currently failure branch only `debugPrint`s. Emit error so UI can display it:
```dart
result.fold(
  (failure) => emit(state.copyWith(errorMessage: 'Failed to load invitations: ${failure.displayMessage}')),
  (invitations) => emit(state.copyWith(pendingInvitations: invitations)),
);
```

### 4.10 Optimistic state updates after mutation operations
After `removeMember` success: remove from `selectedCommunityMembers` immediately (don't wait for stream):
```dart
selectedCommunityMembers: state.selectedCommunityMembers.where((m) => m.id != event.memberId).toList(),
```
After `updateMemberRole` success: update role in `selectedCommunityMembers` immediately.
After `approveTransaction`/`rejectTransaction` success: remove from `selectedCommunityApprovals` immediately.

---

## Phase 5: CommunityMessagingBloc — Complete Implementation

### 5.1 Implement markAsRead
**File:** `lib/presentation/blocs/community_messaging/community_messaging_bloc.dart` lines 167-173
```dart
Future<void> _onMarkAsRead(_MarkAsRead event, Emitter<CommunityMessagingState> emit) async {
  _communityRepository.markAsRead(communityId: state.communityId);
}
```

### 5.2 Stream error logging
Line 77: `(failure) => debugPrint('CommunityMessagingBloc: stream error: ${failure.displayMessage}'),`

### 5.3 Pagination deduplication
Lines 196-198: Dedup by message ID before appending:
```dart
final existingIds = state.messages.map((m) => m.id).toSet();
final deduped = olderMessages.where((m) => !existingIds.contains(m.id)).toList();
```

### 5.4 Fix reaction handlers — empty emit on success
`_onAddReaction` and `_onRemoveReaction` emit `{}` on success (no-op). Should either:
- Optimistically update the message's reaction list in state, OR
- Do nothing on success (let watch stream update) but remove the empty emit

### 5.5 Optimistic message add after sendTextMessage/sendMediaMessage
Currently success path only sets `isSending: false` without adding message to state. Add optimistic insert:
```dart
(message) => emit(state.copyWith(
  isSending: false,
  // Stream will bring the canonical version; for now user sees it immediately
)),
```
Note: Since messages go through OutgoingMessageQueue (not direct send), the message ID is known from the queue. The sync service will replace with decrypted canonical version.

---

## Phase 6: CommunitySyncService — Reliability & Recovery

### 6.1 Connectivity recovery
**File:** `lib/core/services/community_sync_service.dart`

Add `NetworkInfo` as constructor dependency. Listen for connectivity changes:
```dart
StreamSubscription? _connectivitySub;

void startSync() {
  if (_isSyncing) return;
  _isSyncing = true;
  _connectivitySub?.cancel();
  _connectivitySub = _networkInfo.onConnectivityChanged.listen((_) async {
    if (_isSyncing && await _networkInfo.isConnected) {
      debugPrint('CommunitySyncService: Network restored, restarting sync');
      _restartCommunityListSync();
    }
  });
  _startCommunityListSync();
}
```

Update DI registration to inject `NetworkInfo`.

### 6.2 Subscription error cleanup with retry
In `_startMessageSync` and `_startMemberSync` `onError` callbacks:
```dart
onError: (e) {
  debugPrint('CommunitySyncService: Message sync error for $communityId: $e');
  _messageSubs.remove(communityId);
  _syncingCommunityIds.remove(communityId);
  Future.delayed(const Duration(seconds: 10), () {
    if (_isSyncing && !_syncingCommunityIds.contains(communityId)) {
      _startMessageSync(communityId);
    }
  });
},
```

### 6.3 Soft-delete filter
In community list callback, skip closed communities. Note: sync service works with model objects (String status), not entities (CommunityStatus enum):
```dart
if (model.status == 'closed') {
  // Don't upsert — if exists locally, remove it
  try {
    await _appDatabase.deleteLocalCommunity(model.id);
    await _appDatabase.deleteLocalCommunityMembersForCommunity(model.id);
  } catch (e) {
    debugPrint('CommunitySyncService: Failed to clean up closed community ${model.id}: $e');
  }
  continue;
}
```

### 6.4 Member sync locked with message processing
Wrap member sync updates in `_processingLock` to prevent race with message decryption:
```dart
_memberSubs[communityId] = _remoteDataSource.watchMembers(communityId).listen(
  (memberModels) {
    _processingLock.protect(communityId, () async {
      // existing member sync logic
    }).catchError((Object e) {
      debugPrint('CommunitySyncService: Member sync error: $e');
    });
  },
);
```

### 6.5 Update mutable fields for own messages
In `_processIncomingMessages`, don't skip own messages when updating mutable fields (deletedForEveryone, reactions, readBy):
```dart
// Check for mutable field changes BEFORE the decryption skip
if (existing != null) {
  bool needsUpdate = false;
  if (msg.deletedForEveryone != existing.deletedForEveryone) needsUpdate = true;
  if (msg.reactions != existing.reactions) needsUpdate = true;
  if (needsUpdate) {
    await _appDatabase.updateMessageMutableFields(msg.id, ...);
  }
  if (existing.textContent != null) continue; // Already decrypted, skip decrypt
}
```

### 6.6 Add timeout/deadlock prevention on processing lock
If `_processIncomingMessages` hangs, the lock is held forever, blocking all subsequent messages:
```dart
await _processingLock.protect(communityId, () async {
  await _processIncomingMessages(communityId, messages)
      .timeout(const Duration(seconds: 30), onTimeout: () {
    debugPrint('CommunitySyncService: Processing timeout for $communityId');
  });
});
```

### 6.7 Bound plaintext cache with time-based eviction
Current cache eviction removes one item at a time and has no time-based cleanup:
```dart
static const _maxCacheSize = 200;
static const _maxCacheAge = Duration(minutes: 10);
final _cacheTimestamps = <String, DateTime>{};

void cacheSentPlaintext(String messageId, String plaintext) {
  // Evict old entries
  final now = DateTime.now();
  _sentPlaintextCache.removeWhere((key, _) =>
    now.difference(_cacheTimestamps[key] ?? now) > _maxCacheAge);
  if (_sentPlaintextCache.length >= _maxCacheSize) {
    _sentPlaintextCache.remove(_sentPlaintextCache.keys.first);
  }
  _sentPlaintextCache[messageId] = plaintext;
  _cacheTimestamps[messageId] = now;
}
```

### 6.8 Add key distribution retry on failure
If key fetch fails due to network, message remains permanently undecryptable. Add retry:
```dart
for (int attempt = 0; attempt < 3; attempt++) {
  try {
    await _processIncomingKeyDistributions(communityId);
    break;
  } catch (e) {
    if (attempt < 2) await Future.delayed(Duration(seconds: attempt * 2 + 1));
    else debugPrint('Key distribution fetch failed after 3 attempts: $e');
  }
}
```

### 6.9 Dispose keyed mutexes and connectivity subscription in `stopSync()`
```dart
void stopSync() {
  _isSyncing = false;
  _connectivitySub?.cancel();
  // Cancel all subscriptions...
  _processingLock.clear(); // Add clear() method to KeyedMutex
  _listLock.clear();
}
```

---

## Phase 7: Cloud Functions — Race Conditions & Validation

### 7.1 Fix memberCount idempotency in `acceptCommunityInvitation`
**File:** `functions/src/communities.ts` lines 417-441

`memberCount: FieldValue.increment(1)` at line 432 is not idempotent. If the Cloud Function retries (network timeout), memberCount increments again. Fix: read current member status inside transaction, only increment if status was "invited":
```typescript
await db.runTransaction(async (transaction) => {
  const memberDoc = await transaction.get(memberRef);
  const memberData = memberDoc.data();
  if (memberData?.status === 'active') {
    return; // Already accepted — idempotent
  }
  transaction.update(memberRef, { status: 'active', joinedAt: now, lastReadAt: now });
  const payload: Record<string, unknown> = {
    memberIds: admin.firestore.FieldValue.arrayUnion(userId),
    memberCount: admin.firestore.FieldValue.increment(1),
    updatedAt: now,
  };
  if (memberData?.role === 'admin' || memberData?.role === 'treasurer') {
    payload.adminIds = admin.firestore.FieldValue.arrayUnion(userId);
  }
  transaction.update(communityRef, payload);
});
```
Also move expiry check INSIDE the transaction (currently at line 410, outside transaction = TOCTOU).

### 7.2 Atomic role + adminIds update
**File:** `functions/src/communities.ts` `updateCommunityMemberRole` (~lines 580-598)

Replace two separate writes with single transaction:
```typescript
await db.runTransaction(async (transaction) => {
  const memberRef = communityRef.collection(SUBCOLLECTION_MEMBERS).doc(memberId);
  const commRef = db.collection(COLLECTION).doc(communityId);

  transaction.update(memberRef, { role: newRole, updatedAt: now });

  if (newRole === 'admin' || newRole === 'treasurer') {
    transaction.update(commRef, {
      adminIds: admin.firestore.FieldValue.arrayUnion(memberId),
      updatedAt: now,
    });
  } else {
    transaction.update(commRef, {
      adminIds: admin.firestore.FieldValue.arrayRemove(memberId),
      updatedAt: now,
    });
  }
});
```

### 7.3 Missing requireActiveCommunity checks
Add `requireActiveCommunity(community)` to:
- `markCommunityRead` (~line 803)
- `toggleCommunityMessageReaction` (~line 838)
- `toggleCommunityMute` (~line 882)

### 7.4 Approval double-processing guard (full transaction)
**File:** `functions/src/communities.ts` `approveCommunityTransaction` (~line 1265)

Current code has expiry check OUTSIDE transaction (line 1254) and approval update OUTSIDE transaction (line 1266). Both are TOCTOU bugs. Also expiry comparison uses `<` (should be `<=`). Wrap EVERYTHING in a single transaction:
```typescript
await db.runTransaction(async (transaction) => {
  const approvalRef = communityRef.collection('pendingApprovals').doc(approvalId);
  const approvalDoc = await transaction.get(approvalRef);
  const approval = approvalDoc.data();

  if (!approval || approval.status !== 'pending') {
    throw new HttpsError('failed-precondition', 'Approval already processed');
  }
  // Expiry check INSIDE transaction (fixes TOCTOU), use <= not <
  if (approval.expiresAt.toDate() <= new Date()) {
    transaction.update(approvalRef, { status: 'expired' });
    transaction.update(transactionDoc.ref, { status: 'rejected' });
    throw new HttpsError('failed-precondition', 'Approval has expired');
  }
  if (approval.approvers?.includes(actorId)) {
    throw new HttpsError('already-exists', 'You have already approved this');
  }

  transaction.update(approvalRef, {
    approvers: admin.firestore.FieldValue.arrayUnion(actorId),
    status: approval.approvers.length + 1 >= approval.requiredApprovals ? 'approved' : 'pending',
  });
  if (approval.approvers.length + 1 >= approval.requiredApprovals) {
    transaction.update(transactionDoc.ref, { status: 'approved', approvedBy: actorId });
  }
});
```
Also fix system message that always says "Withdrawal" (line 1317) — use `transaction.type` instead.

### 7.5 Balance check atomicity for withdrawals + fix approval threshold
**File:** `functions/src/communities.ts` `withdrawFromCommunity` (~line 1054)

**CRITICAL BUG at line 1064-1065**: Approval threshold uses AND (`&&`) instead of OR (`||`):
```typescript
// BEFORE (wrong): treasurer can bypass community threshold
const needsApproval = amount > perms.maxTransferWithoutApproval &&
  amount > community.settings.requireApprovalAbove;
// AFTER (correct): either limit triggers approval
const needsApproval = amount > perms.maxTransferWithoutApproval ||
  amount > community.settings.requireApprovalAbove;
```

Move balance check into transaction with withdrawal creation:
```typescript
await db.runTransaction(async (transaction) => {
  const balance = await getGroupBalance(communityId); // Ledger is source of truth
  if (balance < amount) {
    throw new HttpsError('failed-precondition', 'Insufficient community balance');
  }
  transaction.set(transactionRef, { ... });
});
```

### 7.6 Financial idempotency keys
Add `idempotencyKey` parameter to `contributeToCommunity`, `withdrawFromCommunity`, `approveCommunityTransaction`:
```typescript
const { communityId, amount, idempotencyKey } = request.data;
if (idempotencyKey) {
  const existing = await communityRef.collection('transactions')
    .where('idempotencyKey', '==', idempotencyKey).limit(1).get();
  if (!existing.empty) {
    return { success: true, transactionId: existing.docs[0].id, deduplicated: true };
  }
}
```

### 7.7 Validate stokvel settings structure
Add validation in `createCommunity` and `updateCommunity`:
```typescript
function validateStokvelSettings(settings: any): void {
  if (!settings.payoutType || !['rotating', 'lottery', 'fixed'].includes(settings.payoutType)) {
    throw new HttpsError('invalid-argument', 'Invalid payout type');
  }
  if (settings.contributionAmount !== undefined && settings.contributionAmount < 0) {
    throw new HttpsError('invalid-argument', 'Contribution amount must be positive');
  }
}
```

### 7.8 Contribution amount max validation
Add to `contributeToCommunity`:
```typescript
if (amount > 10_000_000) {
  throw new HttpsError('invalid-argument', 'Amount exceeds maximum');
}
```

### 7.9 Ledger account creation must not fail silently
In `createCommunity` (~line 155): throw if ledger creation fails:
```typescript
try {
  await getOrCreateGroupAccount(communityId, community.name);
} catch (error) {
  logger.error('Failed to create ledger account:', error);
  throw new HttpsError('internal', 'Failed to initialize community finances');
}
```

### 7.10 Scheduled function error aggregation
In `sendCommunityContributionReminders`, `calculateCommunityPenalties`, `processCommunityPayouts`: accumulate errors and log summary:
```typescript
let errorCount = 0;
let successCount = 0;
for (const member of members) {
  try { /* ... */ successCount++; }
  catch (e) { errorCount++; logger.warn(`Failed for ${member.id}:`, e); }
}
logger.info(`Completed: ${successCount} success, ${errorCount} failed`);
```

### 7.11 Role validation in inviteCommunityMember
Add valid role check (~line 318):
```typescript
const validRoles = ['admin', 'treasurer', 'member', 'viewer'];
if (!validRoles.includes(role)) {
  throw new HttpsError('invalid-argument', `Invalid role: ${role}`);
}
```

### 7.12 Atomic `contributeToCommunity` — ledger + Firestore
**File:** `functions/src/communities.ts` lines 958-998
After ledger succeeds, THREE separate non-transactional writes follow. If any fails, ledger and Firestore diverge. Wrap post-ledger writes in batch:
```typescript
const result = await processGroupContribution(communityId, userId, amount, transactionRef.id);
if (result.success) {
  const batch = db.batch();
  batch.update(transactionRef, { status: 'completed', journalId: result.journalId, completedAt: now });
  batch.update(memberRef, { contributionBalance: admin.firestore.FieldValue.increment(amount) });
  batch.update(communityRef, { totalBalance: admin.firestore.FieldValue.increment(amount), updatedAt: now });
  await batch.commit();
}
```

### 7.13 Fix `inviteCommunityMember` max members race condition
**File:** `functions/src/communities.ts` lines 308-350
Two concurrent invites both pass `memberCount >= maxMembers` check, both add to memberIds. Move check into batch with conditional:
```typescript
// Use transaction to atomically check + add
await db.runTransaction(async (transaction) => {
  const commDoc = await transaction.get(communityRef);
  const community = commDoc.data();
  if (community.memberCount >= community.settings.maxMembers) {
    throw new HttpsError('failed-precondition', 'Community is at maximum capacity');
  }
  transaction.set(memberRef, memberData);
  transaction.update(communityRef, { memberIds: FieldValue.arrayUnion(userId), updatedAt: now });
});
```

### 7.14 Scheduled functions idempotency
Add `lastPenaltyDate` and `lastPayoutDate` fields to community doc. Check before processing:
```typescript
// In calculateCommunityPenalties:
const monthKey = `${lastMonth.getFullYear()}-${String(lastMonth.getMonth()+1).padStart(2,'0')}`;
if (stokvel.lastPenaltyDate === monthKey) continue; // Already processed this month
// After processing, update:
await stokvelDoc.ref.update({ 'stokvel.lastPenaltyDate': monthKey });
```
Same pattern for `processCommunityPayouts` with `lastPayoutDate`.

### 7.15 Fix negative penalty + failed penalty accumulation
**File:** `functions/src/communities.ts` lines 1688-1742
- Line 1691 already checks `penaltyAmount <= 0` — this guards against negative, ✓
- But `totalPenaltyAmount` at ~line 1742 is accumulated BEFORE checking `result.success`. Move accumulation inside success block:
```typescript
if (result.success) {
  totalPenaltyAmount += penaltyAmount; // Only count successful penalties
  // ... batch writes
}
```

### 7.16 Fix payout double-pay risk + atomic payout
Use transaction to atomically check + process payout:
```typescript
await db.runTransaction(async (transaction) => {
  const stokvelDoc = await transaction.get(stokvelRef);
  const stokvel = stokvelDoc.data();
  // Check payout not already processed for this period
  if (stokvel.stokvel.lastPayoutDate === currentPeriodKey) return;
  // Process payout through ledger...
  // Then update community doc atomically
  transaction.update(stokvelRef, {
    'stokvel.lastPayoutDate': currentPeriodKey,
    'stokvel.currentPayoutRecipient': recipientId,
    'stokvel.nextPayoutDate': nextPayoutDate,
    totalBalance: admin.firestore.FieldValue.increment(-payoutAmount),
  });
});
```

### 7.17 Fix rotating payout index bug
**File:** `functions/src/communities.ts` lines 1827-1831
If `currentRecipient` not in `payoutOrder`, `indexOf` returns -1, `nextIndex = 0` — always pays first member:
```typescript
const currentIndex = currentRecipient ? payoutOrder.indexOf(currentRecipient) : -1;
// If not found, start from 0 instead of wrapping
const nextIndex = currentIndex === -1 ? 0 : (currentIndex + 1) % payoutOrder.length;
```
Also rebuild `payoutOrder` from current active members each time to handle departed members.

### 7.18 Fix payout amount remainder
**File:** `functions/src/communities.ts` ~line 1842
`Math.floor(balance / members.length)` loses remainder. Distribute it to first member:
```typescript
const baseAmount = Math.floor(balance / members.length);
const remainder = balance - (baseAmount * members.length);
// First member gets baseAmount + remainder
```

### 7.19 Fix unread count race in `sendCommunityMessage`
**File:** `functions/src/communities.ts` lines 772-795
Concurrent messages both read unread count, both increment by 1 independently. Use `FieldValue.increment` instead of reading + writing:
```typescript
// Instead of setting absolute unreadCounts values, use atomics:
const unreadUpdates: Record<string, unknown> = {};
for (const memberId of memberIds) {
  if (memberId !== senderId) {
    unreadUpdates[`unreadCounts.${memberId}`] = admin.firestore.FieldValue.increment(1);
  }
}
batch.update(communityRef, unreadUpdates);
```

---

## Phase 8: UI Screens — Error States, Confirmations, Navigation

### 8.1 community_detail_screen.dart: Navigator.push → GoRouter
Replace all `Navigator.push()` with `context.push()` or `showGeneralDialog()` (for full-screen overlays like voice/video recorder).

### 8.2 community_members_screen.dart: Error state
Replace infinite spinner with proper empty/error state:
```dart
body: WaveBackground(
  child: members.isEmpty && state.operationStatus != CommunityOperationStatus.processing
    ? Center(child: Text('No members found', style: ...))
    : members.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : ListView.builder(...),
),
```

### 8.3 messaging_screen.dart: Processing feedback on Accept/Decline
Wrap buttons in `BlocBuilder<CommunityBloc, CommunityState>`:
```dart
BlocBuilder<CommunityBloc, CommunityState>(
  builder: (context, commState) {
    final isProcessing = commState.operationStatus == CommunityOperationStatus.processing;
    return Row(children: [
      Expanded(child: OutlinedButton(
        onPressed: isProcessing ? null : () => ...,
        child: isProcessing ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : Text('Decline'),
      )),
      // ... Accept button same pattern
    ]);
  },
)
```

### 8.4 create_community_screen.dart: Form validation
Add validators for contribution amount (> 0), penalty percentage (0-100), max members (> 0).

### 8.5 community_settings_screen.dart: Error state for null community
Add timeout: if community is null after 5s, show error with retry button instead of infinite spinner.

### 8.6 invite_member_screen.dart: Contact picker validation
Validate returned map has `id` and `name` keys before using:
```dart
if (result != null && result.containsKey('id') && result.containsKey('name') && mounted) {
```

### 8.7 pending_approvals_screen.dart: Confirmation dialogs
Add confirmation dialog before approve action (reject already has one).

### 8.8 community_transaction_screen.dart: Confirmation dialog
Add confirmation dialog before contribution/withdrawal submission.

### 8.9 community_list_tile.dart: Fix null crashes
- `lastMessageText!` force unwrap on line ~95 crashes when null. Replace with `lastMessageText ?? ''`
- Add null checks on subtitle, avatar URL, and date formatting

### 8.10 Double-tap protection on ALL action buttons
Wrap every action button in a `BlocBuilder` that disables during `operationStatus == processing`:
- PendingApprovalsScreen: Approve/Reject buttons (line ~194-209) — no loading check at all
- InviteMemberScreen: Send button — can be tapped twice during network latency
- MessagingScreen: Accept/Decline invitation buttons (line ~674-693)
- CommunityMembersScreen: PopupMenuButton actions — no loading state

### 8.11 Fix CommunityDetailScreen: error state if loadCommunityDetails fails
Add BlocListener for `operationStatus == failure` that shows error message with retry button instead of stale/empty UI:
```dart
BlocListener<CommunityBloc, CommunityState>(
  listenWhen: (prev, cur) => prev.operationStatus != cur.operationStatus,
  listener: (context, state) {
    if (state.operationStatus == CommunityOperationStatus.failure) {
      // Show retry dialog or inline error
    }
  },
)
```

### 8.12 Fix CommunityDetailScreen: mounted checks after async awaits
After `showReactionPicker(context)` (line ~257), add `if (!mounted) return;` before accessing context.

### 8.13 Fix CommunitySettingsScreen: financial fields validators
Add validators to contribution amount, penalty percentage, approval threshold fields — same as 8.4 but for the settings edit screen (not just create).

### 8.14 Fix PendingApprovalsScreen: TextEditingController leak
In `_showRejectDialog()`, dispose the `reasonController` when dialog closes:
```dart
showDialog(...).then((_) => reasonController.dispose());
```

### 8.15 Fix MessagingScreen: communityId.substring crash
Line ~625: `invite.communityId.substring(0, 8)` crashes if ID is shorter than 8 chars. Fix:
```dart
invite.communityName ?? invite.communityId.substring(0, invite.communityId.length.clamp(0, 8))
```

### 8.16 Fix CommunityTransactionScreen: null safety on community.totalBalance
Line ~209: `community.totalBalance` accessed when community could be null. Add null check:
```dart
if (community == null) return const SizedBox.shrink();
```

---

## Phase 9: Outgoing Message Queue — Community Fixes

### 9.1 Network error → keep as pending, not failed
**File:** `lib/core/services/outgoing_message_queue.dart`

In `_processCommunityTextMessage` and `_processCommunityMediaMessage`: when `_ensureSenderKeyDistributed` fails due to network, keep message as `pending` instead of marking `failed`:
```dart
try {
  await _ensureSenderKeyDistributed(communityId);
} catch (e) {
  if (e.toString().contains('network') || e.toString().contains('SocketException')) {
    return; // Leave as pending — will retry on next connectivity event
  }
  await _markFailed(msg.id, e.toString());
  return;
}
```

### 9.2 Sender key distribution idempotency
In `_ensureSenderKeyDistributed`: add guard against concurrent calls for same community:
```dart
static final _distributionInProgress = <String>{};

Future<void> _ensureSenderKeyDistributed(String communityId) async {
  if (_distributionInProgress.contains(communityId)) return;
  _distributionInProgress.add(communityId);
  try {
    // existing logic
  } finally {
    _distributionInProgress.remove(communityId);
  }
}
```

### 9.3 Vault storage retry
In `_finalizeSent()`: retry vault storage up to 3 times before giving up:
```dart
for (int attempt = 0; attempt < 3; attempt++) {
  try {
    await _mediaRecoveryService.storePayload(messageId, payload);
    break;
  } catch (e) {
    if (attempt == 2) debugPrint('Vault storage failed after 3 attempts: $e');
    await Future.delayed(Duration(seconds: attempt + 1));
  }
}
```

### 9.4 Fix network error detection — check exception type, not string
Replace fragile string matching:
```dart
// BEFORE (fragile):
if (e.toString().contains('network') || e.toString().contains('SocketException'))
// AFTER (robust):
} on SocketException {
  return; // Leave as pending
} on TimeoutException {
  return; // Leave as pending
} on FirebaseException catch (e) {
  if (e.code == 'unavailable') return; // Leave as pending
  await _markFailed(msg.id, e.toString());
}
```

### 9.5 Fix `_isProcessing` thread safety
Replace boolean flag with `Completer` to prevent concurrent processing:
```dart
Completer<void>? _processingCompleter;

Future<void> processPendingMessages() async {
  if (_processingCompleter != null && !_processingCompleter!.isCompleted) return;
  _processingCompleter = Completer<void>();
  try {
    // ... process messages
  } finally {
    _processingCompleter!.complete();
  }
}
```

### 9.6 Fix `Future.delayed` timer accumulation
Replace fire-and-forget `Future.delayed` with a single cancellable Timer:
```dart
Timer? _reDrainTimer;

void _scheduleReDrain() {
  _reDrainTimer?.cancel();
  _reDrainTimer = Timer(const Duration(seconds: 5), () {
    processPendingMessages();
  });
}
```
Cancel timer in `stopListening()`.

### 9.7 Fix encryption stuck state — add timeout
If encryption hangs, message status is stuck at 'encrypting' forever:
```dart
final ciphertext = await _senderKeyService
    .encryptCommunity(communityId, plaintext)
    .timeout(const Duration(seconds: 15), onTimeout: () {
  throw TimeoutException('Encryption timed out');
});
```

### 9.8 Add max retry count / max age for failed messages
Prevent infinite retries:
```dart
const maxRetries = 10;
const maxAge = Duration(hours: 24);

if (msg.retryCount >= maxRetries || DateTime.now().difference(msg.createdAt) > maxAge) {
  await _markFailed(msg.id, 'Max retries exceeded');
  continue;
}
```

### 9.9 Fix preview update race
`_updateCommunityPreview` read-modify-writes the community, racing with sync service. Use atomic Drift update instead of full entity replacement:
```dart
await _appDatabase.updateCommunityPreview(
  communityId: communityId,
  lastMessageText: text,
  lastMessageAt: now,
  lastMessageSenderId: senderId,
);
```

### 9.10 Add message status state machine validation
Before changing message status, validate the transition is legal:
```dart
bool _isValidTransition(String from, String to) {
  const valid = {
    'pending': {'encrypting', 'failed'},
    'encrypting': {'sending', 'failed', 'pending'},
    'sending': {'sent', 'failed', 'pending'},
    'failed': {'pending'}, // retry only
  };
  return valid[from]?.contains(to) ?? false;
}
```

### 9.11 Fix media type parsing silent default
Replace silent `orElse: () => MessageType.image` with logged fallback:
```dart
final mediaType = MessageType.values.firstWhere(
  (e) => e.name == mediaTypeStr,
  orElse: () {
    debugPrint('WARNING: Unknown media type "$mediaTypeStr", defaulting to file');
    return MessageType.file; // file is safer than image
  },
);
```

---

## Phase 10: Code Generation & Static Analysis

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze --fatal-infos
cd functions && npm run build
```

Fix any issues from Freezed regeneration (CommunityStatus enum change will cascade).

---

## Phase 11: Unit Tests

### 11.1 Domain entity tests
**New file:** `test/domain/entities/community_test.dart`
- Test `isActive`, `isSuspended`, `isClosed` with `CommunityStatus` enum
- Test `hasValidAdmins`, `ownerIsMember` invariants
- Test `CommunitySettings.isValid` with valid/invalid combinations
- Test `CommunitySettings.defaultFor` for each `CommunityType`

**New file:** `test/domain/entities/community_member_test.dart`
- Test `isActive`, `isInvited`, `isBlocked`, `isOwner`
- Test all permission methods: `canManageMembers`, `canApproveFunds`, `canTransferFunds`, `canViewLedger`, `canEditSettings`
- Test `roleDisplayName`, `statusDisplayName`

**New file:** `test/domain/entities/community_transaction_test.dart`
- Test `isInflow` vs `isOutflow` for every `CommunityTransactionType`
- Test `CommunityApproval.isPending`, `isExpired` with `ApprovalStatus` enum
- Test `CommunityApproval.hasTimePassed` with past/future `expiresAt`

### 11.2 Model tests
**New file:** `test/data/models/community_model_test.dart`
- Test `fromFirestore` with complete doc data
- Test `fromFirestore` with partial lastMessage (missing fields)
- Test `fromFirestore` with `stokvel` key rename to `stokvelSettings`
- Test `toEntity()` maps CommunityStatus correctly
- Test `fromEntity()` serializes CommunityStatus correctly
- Test invalid/unknown status falls back with logged warning

**New file:** `test/data/models/community_member_model_test.dart`
- Test `toEntity()` with valid role/status strings
- Test `toEntity()` with unknown role → logs warning, defaults to member
- Test `toEntity()` with unknown status → logs warning, defaults to invited
- Test `fromEntity()` round-trip

**New file:** `test/data/models/community_transaction_model_test.dart`
- Test `_parseTransactionType` with all valid values
- Test `_parseTransactionType` with unknown value → logs warning, defaults
- Test `_parseTransactionStatus` same pattern

### 11.3 Repository tests (expand existing)
**File:** `test/data/repositories/community_repository_impl_test.dart`
Add test groups for:
- `markAsRead` — success, network error, server error
- `leaveCommunity` — verifies local DB cleanup
- `deleteCommunity` — verifies local DB cleanup
- `refreshMembers` — verifies batch upsert
- `getMessages` with `before` param — verifies DB-level filtering
- `acceptInvitation` — success path with list refresh
- `declineInvitation` — success path with list removal
- `contribute` — sends idempotency key
- `withdraw` — sends idempotency key
- Unread count JSON decode — handles malformed JSON gracefully
- `createCommunity` — seeds local cache after remote success
- `updateCommunity` — seeds local cache after remote success
- `acceptInvitation` — updates local membership state
- `declineInvitation` — removes local member record
- `getTransactions` — returns network error when offline
- `getBalance` — returns network error when offline
- `sendMediaMessage` — correctly classifies video/document types

### 11.4 BLoC tests
**New file:** `test/presentation/blocs/community_bloc_test.dart`

Test every handler with `blocTest`:
```dart
group('createCommunity', () {
  blocTest<CommunityBloc, CommunityState>(
    'emits [processing, success, idle] on success',
    build: () { /* mock success */ },
    act: (bloc) => bloc.add(CommunityEvent.createCommunity(params: testParams)),
    expect: () => [
      isA<CommunityState>().having((s) => s.operationStatus, 'status', CommunityOperationStatus.processing),
      isA<CommunityState>().having((s) => s.operationStatus, 'status', CommunityOperationStatus.success),
      isA<CommunityState>().having((s) => s.operationStatus, 'status', CommunityOperationStatus.idle),
    ],
  );

  blocTest<CommunityBloc, CommunityState>(
    'emits [processing, failure, idle] on error',
    // ...
  );
});
```

Test ALL 14 operation handlers (success + failure paths = 28 tests).
Test stream handlers (watchMembers, watchTransactions, etc.).
Test `_onClearError`.
Test subscription lifecycle (`close()` cancels all, awaited).
Test `isClosed` guard — adding event after close doesn't throw.
Test unread count resets on community delete.
Test `selectedCommunity` invalidated when removed from list.
Test `_onLoadPendingInvitations` — emits error state on failure.
Test optimistic member removal after `removeMember` success.
Test optimistic role update after `updateMemberRole` success.
Test optimistic approval removal after `approveTransaction`/`rejectTransaction` success.

**Expand existing:** `test/presentation/blocs/community_messaging_bloc_e2ee_test.dart`
Add tests for:
- `markAsRead` — calls repository
- `loadMore` — deduplicates by message ID
- `addReaction` / `removeReaction` — error handling
- Stream error logging

### 11.5 Sync service tests
**New file:** `test/core/services/community_sync_service_test.dart`
- Test `startSync` initializes subscriptions
- Test `stopSync` cancels all subscriptions and cleans up mutexes
- Test connectivity recovery restarts sync
- Test subscription error → cleanup + retry after delay
- Test soft-deleted communities are not upserted (cleaned from local DB)
- Test member sync detects departures and triggers rekey
- Test member sync locked with message processing (concurrent access)
- Test processing lock timeout prevents deadlock
- Test key distribution retry (3 attempts)
- Test plaintext cache eviction by time and size

### 11.6 Outgoing message queue tests
**New file:** `test/core/services/outgoing_message_queue_community_test.dart`
- Test network error keeps message as pending (not failed) — checks exception types
- Test sender key distribution idempotency (concurrent calls)
- Test vault storage retry (3 attempts)
- Test community text message enqueue → process → finalize
- Test `_isProcessing` prevents concurrent processing
- Test `Future.delayed` timer is cancelled on stopListening
- Test encryption timeout resets message to pending (not stuck on encrypting)
- Test max retry count (10) marks message as failed
- Test max age (24h) marks message as failed
- Test message status state machine (invalid transitions rejected)
- Test preview update uses atomic DB operation
- Test media type parsing fallback logs warning

---

## Phase 12: Integration & E2E Tests

### 12.1 Integration: Full community lifecycle
**New file:** `test/integration/community_lifecycle_test.dart`
- Create community → invite member → accept → send message → mark read → leave
- Create community → invite → decline → verify cleanup
- Create stokvel → contribute → withdraw → approve → verify ledger

### 12.2 Integration: E2EE community messaging
**Expand existing:** `test/integration/e2ee_community_flow_test.dart`
- Add test: member joins → receives sender key → can decrypt messages
- Add test: member leaves → sender key rekeyed → old member can't decrypt new messages
- Add test: sender key distribution failure → message stays pending → retry succeeds

### 12.3 E2E: BLoC + Repository + Sync
**New file:** `test/integration/community_bloc_integration_test.dart`
- BLoC dispatches acceptInvitation → repository calls remote → success emitted → pending invitations refreshed
- BLoC dispatches declineInvitation → repository calls remote → success emitted → invitation removed from state
- BLoC watches members → sync service updates local DB → BLoC state updates with new members

### 12.4 Cloud Functions tests
**New file:** `functions/src/__tests__/communities.test.ts`

Test every Cloud Function:
```typescript
describe('createCommunity', () => {
  it('creates community with correct member count and memberIds', ...);
  it('creates ledger account or throws on failure', ...);
  it('rejects invalid stokvel settings', ...);
});

describe('inviteCommunityMember', () => {
  it('does NOT add invited user to memberIds', ...);  // NEW: fixes race
  it('validates role is valid', ...);
  it('rejects if community at max members', ...);
  it('rejects duplicate invitation', ...);
});

describe('acceptCommunityInvitation', () => {
  it('adds user to memberIds and increments memberCount atomically', ...);
  it('is idempotent — calling twice does NOT double-increment memberCount', ...);
  it('checks expiry INSIDE transaction (no TOCTOU)', ...);
  it('rejects expired invitation (30 days)', ...);
  it('rejects already-active member', ...);
  it('rejects blocked member', ...);
  it('adds to adminIds if role is admin/treasurer', ...);
});

describe('removeCommunityMember', () => {
  it('allows self-removal for invited members (decline)', ...);
  it('allows self-removal for active members (leave)', ...);
  it('requires canManageMembers for removing others', ...);
  it('does not decrement memberCount for invited members', ...);
  it('cannot remove owner', ...);
});

describe('updateCommunityMemberRole', () => {
  it('updates role and adminIds atomically in transaction', ...);
  it('adds to adminIds for admin/treasurer roles', ...);
  it('removes from adminIds for member/viewer roles', ...);
});

describe('contributeToCommunity', () => {
  it('deduplicates with idempotency key', ...);
  it('rejects amount <= 0', ...);
  it('rejects amount > 10_000_000', ...);
  it('creates ledger entry', ...);
  it('post-ledger writes are atomic (batch)', ...);
});

describe('withdrawFromCommunity', () => {
  it('checks balance atomically in transaction', ...);
  it('rejects if insufficient balance', ...);
  it('creates pending approval if above threshold (uses OR not AND)', ...);
  it('treasurer cannot bypass community requireApprovalAbove', ...);
  it('deduplicates with idempotency key', ...);
});

describe('approveCommunityTransaction', () => {
  it('prevents double-approval by same user', ...);
  it('prevents processing already-approved transaction', ...);
  it('rejects expired approval (uses <= not <)', ...);
  it('checks expiry INSIDE transaction (no TOCTOU)', ...);
  it('system message uses transaction type (not hardcoded Withdrawal)', ...);
});

describe('markCommunityRead', () => {
  it('requires active community', ...);
});

describe('toggleCommunityMessageReaction', () => {
  it('requires active community', ...);
});

describe('toggleCommunityMute', () => {
  it('requires active community', ...);
});

describe('inviteCommunityMember', () => {
  it('max members check is atomic (transaction prevents race)', ...);
});

describe('sendCommunityMessage', () => {
  it('unread counts use FieldValue.increment (no read-modify-write race)', ...);
});

describe('calculateCommunityPenalties', () => {
  it('is idempotent (uses lastPenaltyDate guard)', ...);
  it('only accumulates totalPenaltyAmount for successful penalties', ...);
});

describe('processCommunityPayouts', () => {
  it('is idempotent (uses lastPayoutDate guard)', ...);
  it('payout + Firestore update are atomic', ...);
  it('rotating payout handles currentRecipient not in order', ...);
  it('payout remainder distributed to first member', ...);
});
```

---

## Files Modified (Complete)

| # | File | Phase |
|---|------|-------|
| 1 | `lib/domain/entities/community.dart` | 1 |
| 2 | `lib/domain/entities/community_member.dart` | 1 |
| 3 | `lib/domain/entities/community_transaction.dart` | 1 |
| 4 | `lib/domain/enums/approval_status.dart` (NEW) | 1 |
| 5 | `lib/domain/enums/member_role.dart` | 1 |
| 6 | `lib/data/models/community_model.dart` | 2 |
| 7 | `lib/data/models/community_member_model.dart` | 2 |
| 8 | `lib/data/models/community_transaction_model.dart` | 2 |
| 9 | `lib/data/mappers/local_community_mapper.dart` | 2 |
| 10 | `lib/data/mappers/local_community_member_mapper.dart` | 2 |
| 11 | `lib/data/datasources/remote/community_remote_datasource.dart` | 2 |
| 12 | `lib/data/repositories/community_repository_impl.dart` | 3 |
| 13 | `lib/presentation/blocs/community/community_bloc.dart` | 4 |
| 14 | `lib/presentation/blocs/community_messaging/community_messaging_bloc.dart` | 5 |
| 15 | `lib/core/services/community_sync_service.dart` | 6 |
| 16 | `functions/src/communities.ts` | 7 |
| 17 | `lib/presentation/screens/community/community_detail_screen.dart` | 8 |
| 18 | `lib/presentation/screens/community/community_members_screen.dart` | 8 |
| 19 | `lib/presentation/screens/messaging/messaging_screen.dart` | 8 |
| 20 | `lib/presentation/screens/community/create_community_screen.dart` | 8 |
| 21 | `lib/presentation/screens/community/community_settings_screen.dart` | 8 |
| 22 | `lib/presentation/screens/community/invite_member_screen.dart` | 8 |
| 23 | `lib/presentation/screens/community/pending_approvals_screen.dart` | 8 |
| 24 | `lib/presentation/screens/community/community_transaction_screen.dart` | 8 |
| 25 | `lib/presentation/widgets/messaging/community_list_tile.dart` | 8 |
| 26 | `lib/core/services/outgoing_message_queue.dart` | 9 |
| 27 | `test/domain/entities/community_test.dart` (NEW) | 11 |
| 28 | `test/domain/entities/community_member_test.dart` (NEW) | 11 |
| 29 | `test/domain/entities/community_transaction_test.dart` (NEW) | 11 |
| 30 | `test/data/models/community_model_test.dart` (NEW) | 11 |
| 31 | `test/data/models/community_member_model_test.dart` (NEW) | 11 |
| 32 | `test/data/models/community_transaction_model_test.dart` (NEW) | 11 |
| 33 | `test/data/repositories/community_repository_impl_test.dart` (EXPAND) | 11 |
| 34 | `test/presentation/blocs/community_bloc_test.dart` (NEW) | 11 |
| 35 | `test/presentation/blocs/community_messaging_bloc_e2ee_test.dart` (EXPAND) | 11 |
| 36 | `test/core/services/community_sync_service_test.dart` (NEW) | 11 |
| 37 | `test/core/services/outgoing_message_queue_community_test.dart` (NEW) | 11 |
| 38 | `test/integration/community_lifecycle_test.dart` (NEW) | 12 |
| 39 | `test/integration/e2ee_community_flow_test.dart` (EXPAND) | 12 |
| 40 | `test/integration/community_bloc_integration_test.dart` (NEW) | 12 |
| 41 | `functions/src/__tests__/communities.test.ts` (NEW) | 12 |

**Total: 41 files (26 modified, 15 new)**

Note: All 9 community screens in Phase 8 already appear in the table. New Phase 3 items add to `community_repository_impl.dart` (already in table) and `community_remote_datasource.dart` (already in table).

---

## Verification

1. `dart run build_runner build --delete-conflicting-outputs` — Freezed/Injectable regeneration passes
2. `flutter analyze --fatal-infos` — zero warnings or errors
3. `flutter test` — all unit + integration tests pass
4. `cd functions && npm run build` — TypeScript compiles
5. `cd functions && npm test` — all Cloud Function tests pass
6. Manual: Create community → invite → accept/decline → send message → mark read → leave
7. Manual: Toggle airplane mode → restore → verify sync resumes
8. Manual: Create stokvel → contribute → withdraw → approve → verify ledger
9. Manual: Close and reopen app during message send → verify message completes or retries (not stuck)
10. Manual: Rapid-fire accept invitation twice → verify memberCount increments only once
11. Manual: Two concurrent withdrawals → verify balance doesn't go negative
