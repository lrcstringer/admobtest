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
    /// The long-term identity key pair (Ed25519/X25519), base64-encoded.
    required String identityKeyPair,

    /// The signed pre-key (rotated periodically), base64-encoded.
    required String signedPreKey,

    /// Signature over the signed pre-key using the identity key.
    required String signedPreKeySignature,

    /// List of one-time pre-keys (consumed on first message), base64-encoded.
    required List<String> oneTimePreKeys,

    /// Local registration ID for this device.
    required int registrationId,
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
    /// The recipient's public identity key, base64-encoded.
    required String identityKey,

    /// The recipient's current signed pre-key, base64-encoded.
    required String signedPreKey,

    /// Signature over the signed pre-key, base64-encoded.
    required String signedPreKeySignature,

    /// Available one-time pre-keys (server returns one), base64-encoded.
    required List<String> oneTimePreKeys,

    /// The recipient's registration ID.
    required int registrationId,

    /// The user ID this bundle belongs to.
    required String userId,
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
