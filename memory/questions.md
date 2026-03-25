# Open Questions

## Backlog

### Purge soft-deleted campaigns and opportunities (2026-03-19)
Soft-deleted earn threads and opportunities accumulate in Firestore and Storage indefinitely. Need a cleanup mechanism.

**Proposed approach:** Scheduled CF (weekly) with configurable retention period (default 90 days). Steps:
1. Find all `isDeleted: true` opportunities older than retention period
2. Delete their Storage files (images, videos)
3. Delete associated `polls` collection documents
4. Delete or archive engagement records
5. Delete the Firestore opportunity document
6. Purge parent threads only if all child opportunities are already purged
7. Audit log the purge

**Priority:** Low — costs are minimal at current scale, but should be built before production launch at scale.
