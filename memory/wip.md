# WIP: Fix E2EE OTK Race Condition — "Session expired" on Fresh Install

## Status: IMPLEMENTED (not committed)

### Problem
On fresh install, incoming messages show "Session expired — message unavailable" for ~15 minutes before working. Root cause: rapid Firestore snapshot events exhaust the 3-attempt decrypt failure limit in seconds, permanently marking messages as unrecoverable before the E2EE session has a chance to establish.

### What was fixed

1. **Time-gated failure counting** (`message_decryption_service.dart`)
   - Added `_failureTimestamps` map + `_failureGateInterval = 30s`
   - `recordFailure()` now skips counting if <30s since last failure for same message
   - Prevents rapid snapshots from exhausting `maxDecryptAttempts` in seconds
   - Increased `maxDecryptAttempts` from 3 → 5
   - Timestamps cleaned up in `resetFailures()`, `resetSessionForPeer()`, `_evictFailuresIfNeeded()`

2. **DB permanent sentinel recovery** (`app_database.dart`)
   - New `clearPermanentSentinel(conversationId, senderId)` method
   - Changes `[Session expired — message cannot be recovered]` → `[Cannot decrypt]` with `isDecrypted: false`
   - Allows retry on next Firestore snapshot

3. **Session-establishment retry with DB cleanup** (`message_sync_service.dart`)
   - When `sendersWithGoodSession` is populated, now calls `clearPermanentSentinel()` BEFORE resetting in-memory counters
   - Previously, the DB sentinel persisted even after session was established, blocking all future retries

### Files modified
- `lib/core/services/message_decryption_service.dart`
- `lib/core/services/message_sync_service.dart`
- `lib/data/datasources/local/app_database.dart`

### Not yet done
- No commit (user hasn't asked)
- No git push
- Version bumped to 1.1.0+11 (separate change)
