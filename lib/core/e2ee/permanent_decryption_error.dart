/// Thrown when a message can never be decrypted, regardless of retries.
///
/// Causes: missing x3dhHeader (pre-fix legacy message), OTK mismatch
/// (sender used an OTK the receiver no longer has after key regeneration),
/// or stale session with no recovery path.
class PermanentDecryptionError extends StateError {
  PermanentDecryptionError(super.message);
}
