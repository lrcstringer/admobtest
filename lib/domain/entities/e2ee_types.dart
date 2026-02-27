import 'package:freezed_annotation/freezed_annotation.dart';

part 'e2ee_types.freezed.dart';
part 'e2ee_types.g.dart';

/// Private key bundle containing all keys needed for the Signal Protocol.
///
/// This is stored locally on the device and NEVER uploaded to the server.
/// Contains the identity key pair, signed pre-key, and one-time pre-keys.
@freezed
class KeyBundle with _$KeyBundle {
  const factory KeyBundle({
    /// The long-term identity key pair (X25519), base64-encoded as "priv|pub".
    required String identityKeyPair,

    /// The signed pre-key (rotated periodically), base64-encoded as "priv|pub".
    required String signedPreKey,

    /// Signature over the signed pre-key using the identity key.
    required String signedPreKeySignature,

    /// List of one-time pre-keys (consumed on first message), base64-encoded.
    required List<String> oneTimePreKeys,

    /// Local registration ID for this device.
    required int registrationId,

    /// Ed25519 signing key pair, base64-encoded as "priv|pub".
    /// Used for verifiable signatures on the signed pre-key.
    /// Null for bundles generated before Ed25519 support was added.
    String? ed25519IdentityKeyPair,

    /// Ed25519 signature over the signed pre-key's public key bytes.
    /// Verifiable by any party using the Ed25519 public key.
    String? ed25519Signature,

    // ── v2 (Signal-compliant) fields ──────────────────────────────

    /// Integer ID of the current signed pre-key (for SPK rotation tracking).
    /// Null for v1 bundles.
    int? signedPreKeyId,

    /// Next one-time pre-key ID counter (monotonically increasing).
    /// Used to assign integer IDs to newly generated OTKs.
    int? nextOneTimePreKeyId,

    /// Protocol version (2 = spec-compliant Signal Protocol).
    @Default(2) int protocolVersion,

    /// Previous signed pre-key (retained during grace period), base64 "priv|pub".
    String? previousSignedPreKey,

    /// ID of the previous signed pre-key.
    int? previousSignedPreKeyId,

    /// Signature of the previous signed pre-key.
    String? previousSignedPreKeySignature,

    /// Timestamp when the current SPK was created (for grace period calculation).
    DateTime? signedPreKeyTimestamp,

    /// Timestamp when the previous SPK was created (for grace period expiry).
    DateTime? previousSignedPreKeyTimestamp,
  }) = _KeyBundle;

  factory KeyBundle.fromJson(Map<String, dynamic> json) =>
      _$KeyBundleFromJson(json);
}

/// Public portion of a user's key bundle, fetched from the server.
///
/// Used by the sender to establish an X3DH session with the recipient.
@freezed
class PublicKeyBundle with _$PublicKeyBundle {
  const factory PublicKeyBundle({
    /// The recipient's public identity key (X25519), base64-encoded.
    required String identityKey,

    /// The recipient's current signed pre-key (X25519), base64-encoded.
    required String signedPreKey,

    /// Signature over the signed pre-key, base64-encoded.
    required String signedPreKeySignature,

    /// Available one-time pre-keys (server returns one), base64-encoded.
    required List<String> oneTimePreKeys,

    /// The recipient's registration ID.
    required int registrationId,

    /// The user ID this bundle belongs to.
    required String userId,

    /// Ed25519 public identity key for signature verification, base64-encoded.
    /// Null for bundles generated before Ed25519 support.
    String? ed25519IdentityKey,

    /// Ed25519 signature over the signed pre-key public bytes, base64-encoded.
    /// Verifiable using [ed25519IdentityKey].
    String? ed25519Signature,

    // ── v2 (Signal-compliant) fields ──────────────────────────────

    /// Integer ID of the signed pre-key (for X3DH header).
    int? signedPreKeyId,

    /// Integer ID of the one-time pre-key returned by the server.
    /// Null if no OTK was available (X3DH without DH4).
    int? oneTimePreKeyId,

    /// Protocol version supported by this peer (2 = spec-compliant).
    @Default(2) int protocolVersion,
  }) = _PublicKeyBundle;

  factory PublicKeyBundle.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyBundleFromJson(json);
}

/// Metadata about a user's encrypted key backup stored on the server.
@freezed
class BackupMetadata with _$BackupMetadata {
  const factory BackupMetadata({
    /// Whether a backup exists on the server.
    required bool backupExists,

    /// When the last backup was created/updated.
    DateTime? lastBackupAt,

    /// Version number of the backup format.
    int? backupVersion,

    /// The user ID this backup belongs to.
    required String userId,
  }) = _BackupMetadata;

  factory BackupMetadata.fromJson(Map<String, dynamic> json) =>
      _$BackupMetadataFromJson(json);
}
