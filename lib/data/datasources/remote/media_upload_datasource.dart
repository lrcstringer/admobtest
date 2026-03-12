import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;

import '../../../core/services/crypto_service.dart';

/// Result of a media upload operation.
class MediaUploadResult {
  final String url;
  final String? thumbnailUrl;
  final String fileName;
  final int fileSize;
  final String mimeType;
  final int? duration;
  final int? width;
  final int? height;

  /// AES-256-GCM key used to encrypt the full media file (base64).
  /// Null when media is uploaded unencrypted.
  final String? mediaKey;

  /// AES-256-GCM key used to encrypt the thumbnail (base64).
  /// Null when thumbnail is uploaded unencrypted.
  final String? thumbKey;

  const MediaUploadResult({
    required this.url,
    this.thumbnailUrl,
    required this.fileName,
    required this.fileSize,
    required this.mimeType,
    this.duration,
    this.width,
    this.height,
    this.mediaKey,
    this.thumbKey,
  });

  /// Convert to a map suitable for embedding in a Firestore message document.
  Map<String, dynamic> toMediaMap() => {
        'url': url,
        if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
        'fileName': fileName,
        'fileSize': fileSize,
        'mimeType': mimeType,
        if (duration != null) 'duration': duration,
        if (width != null) 'width': width,
        if (height != null) 'height': height,
        if (mediaKey != null) 'mediaKey': mediaKey,
        if (thumbKey != null) 'thumbKey': thumbKey,
      };
}

/// Handles media uploads (images, voice) for conversations and communities.
///
/// Storage paths:
///   conversations/{id}/images/{messageId}_full.jpg
///   conversations/{id}/images/{messageId}_thumb.jpg
///   conversations/{id}/voice/{messageId}.m4a
///   communities/{id}/images/{messageId}_full.jpg
///   communities/{id}/images/{messageId}_thumb.jpg
///   communities/{id}/voice/{messageId}.m4a
@lazySingleton
class MediaUploadDatasource {
  final FirebaseStorage _storage;
  final CryptoService _cryptoService;

  MediaUploadDatasource(this._storage, this._cryptoService);

  static const int _maxImageBytes = 10 * 1024 * 1024; // 10 MB
  static const int _maxVoiceBytes = 5 * 1024 * 1024; // 5 MB
  static const int _fullImageMaxDimension = 1920;
  static const int _thumbSize = 150;
  static const int _jpegQuality = 85;
  static const int _thumbJpegQuality = 80;

  /// Upload an image for a chat message.
  ///
  /// Compresses to max 1920px, generates a 150px square thumbnail,
  /// and uploads both to Firebase Storage.
  Future<MediaUploadResult> uploadImage({
    required File imageFile,
    required String parentCollection, // "conversations" or "communities"
    required String parentId,
    required String messageId,
  }) async {
    final fileSize = await imageFile.length();
    if (fileSize > _maxImageBytes) {
      throw Exception('Image exceeds ${_maxImageBytes ~/ (1024 * 1024)} MB limit');
    }

    final rawBytes = await imageFile.readAsBytes();
    final decoded = img.decodeImage(rawBytes);
    if (decoded == null) {
      throw Exception('Unable to decode image');
    }

    // Compress full-size image (max 1920px on longest side)
    final fullImage = _resizeToMax(decoded, _fullImageMaxDimension);
    final fullJpeg = Uint8List.fromList(
      img.encodeJpg(fullImage, quality: _jpegQuality),
    );

    // Generate square thumbnail (150x150, center-crop)
    final thumb = img.copyResizeCropSquare(decoded, size: _thumbSize);
    final thumbJpeg = Uint8List.fromList(
      img.encodeJpg(thumb, quality: _thumbJpegQuality),
    );

    // Upload both in parallel
    final fullPath = '$parentCollection/$parentId/images/${messageId}_full.jpg';
    final thumbPath =
        '$parentCollection/$parentId/images/${messageId}_thumb.jpg';

    final results = await Future.wait([
      _uploadBytes(fullJpeg, fullPath, 'image/jpeg'),
      _uploadBytes(thumbJpeg, thumbPath, 'image/jpeg'),
    ]);

    return MediaUploadResult(
      url: results[0],
      thumbnailUrl: results[1],
      fileName: p.basename(imageFile.path),
      fileSize: fullJpeg.length,
      mimeType: 'image/jpeg',
      width: fullImage.width,
      height: fullImage.height,
    );
  }

  /// Upload a voice recording for a chat message.
  ///
  /// Expects an M4A/AAC file. No server-side transcoding.
  Future<MediaUploadResult> uploadVoice({
    required File voiceFile,
    required String parentCollection, // "conversations" or "communities"
    required String parentId,
    required String messageId,
    required int durationSeconds,
  }) async {
    final fileSize = await voiceFile.length();
    if (fileSize > _maxVoiceBytes) {
      throw Exception('Voice file exceeds ${_maxVoiceBytes ~/ (1024 * 1024)} MB limit');
    }

    final storagePath =
        '$parentCollection/$parentId/voice/$messageId.m4a';

    final url = await _uploadFile(voiceFile, storagePath, 'audio/m4a');

    return MediaUploadResult(
      url: url,
      fileName: p.basename(voiceFile.path),
      fileSize: fileSize,
      mimeType: 'audio/m4a',
      duration: durationSeconds,
    );
  }

  /// Upload a user avatar image.
  ///
  /// Compresses to 512px square, uploads to `avatars/{userId}.jpg`.
  /// Returns the download URL.
  Future<String> uploadAvatar({
    required File imageFile,
    required String userId,
  }) async {
    final fileSize = await imageFile.length();
    if (fileSize > _maxImageBytes) {
      throw Exception('Image exceeds ${_maxImageBytes ~/ (1024 * 1024)} MB limit');
    }

    final rawBytes = await imageFile.readAsBytes();
    final decoded = img.decodeImage(rawBytes);
    if (decoded == null) {
      throw Exception('Unable to decode image');
    }

    // Resize to max 512px and compress
    final resized = _resizeToMax(decoded, 512);
    final jpeg = Uint8List.fromList(
      img.encodeJpg(resized, quality: _jpegQuality),
    );

    final storagePath = 'profiles/$userId/avatar.jpg';
    return _uploadBytes(jpeg, storagePath, 'image/jpeg');
  }

  // =========================================================================
  // MARKETPLACE LISTING IMAGES
  // =========================================================================

  /// Upload a marketplace listing image.
  ///
  /// Compresses to max 1920px and uploads to
  /// `marketplace/listings/{listingId}/{index}.jpg`.
  /// Returns the download URL.
  Future<String> uploadListingImage({
    required File imageFile,
    required String listingId,
    required int index,
  }) async {
    final fileSize = await imageFile.length();
    if (fileSize > _maxImageBytes) {
      throw Exception(
          'Image exceeds ${_maxImageBytes ~/ (1024 * 1024)} MB limit');
    }

    final rawBytes = await imageFile.readAsBytes();
    final decoded = img.decodeImage(rawBytes);
    if (decoded == null) {
      throw Exception('Unable to decode image');
    }

    final resized = _resizeToMax(decoded, _fullImageMaxDimension);
    final jpeg = Uint8List.fromList(
      img.encodeJpg(resized, quality: _jpegQuality),
    );

    final storagePath = 'marketplace/listings/$listingId/$index.jpg';
    return _uploadBytes(jpeg, storagePath, 'image/jpeg');
  }

  /// Upload marketplace listing image from raw bytes (cross-platform).
  ///
  /// Compresses to max 1920px and uploads to
  /// `marketplace/listings/{listingId}/{index}.jpg`.
  /// Returns the download URL.
  Future<String> uploadListingImageBytes({
    required Uint8List imageBytes,
    required String listingId,
    required int index,
  }) async {
    if (imageBytes.length > _maxImageBytes) {
      throw Exception(
          'Image exceeds ${_maxImageBytes ~/ (1024 * 1024)} MB limit');
    }

    final decoded = img.decodeImage(imageBytes);
    if (decoded == null) {
      throw Exception('Unable to decode image');
    }

    final resized = _resizeToMax(decoded, _fullImageMaxDimension);
    final jpeg = Uint8List.fromList(
      img.encodeJpg(resized, quality: _jpegQuality),
    );

    final storagePath = 'marketplace/listings/$listingId/$index.jpg';
    return _uploadBytes(jpeg, storagePath, 'image/jpeg');
  }

  // =========================================================================
  // ENCRYPTED UPLOADS (E2EE)
  // =========================================================================

  /// Upload an image encrypted with AES-256-GCM.
  ///
  /// Generates a random key, encrypts both full-size and thumbnail,
  /// uploads ciphertext to Storage, and returns the keys in the result
  /// so the caller can embed them in the E2EE message metadata.
  Future<MediaUploadResult> uploadEncryptedImage({
    required File imageFile,
    required String parentCollection,
    required String parentId,
    required String messageId,
  }) async {
    final fileSize = await imageFile.length();
    if (fileSize > _maxImageBytes) {
      throw Exception('Image exceeds ${_maxImageBytes ~/ (1024 * 1024)} MB limit');
    }

    final rawBytes = await imageFile.readAsBytes();
    final decoded = img.decodeImage(rawBytes);
    if (decoded == null) {
      throw Exception('Unable to decode image');
    }

    // Compress
    final fullImage = _resizeToMax(decoded, _fullImageMaxDimension);
    final fullJpeg = Uint8List.fromList(
      img.encodeJpg(fullImage, quality: _jpegQuality),
    );
    final thumb = img.copyResizeCropSquare(decoded, size: _thumbSize);
    final thumbJpeg = Uint8List.fromList(
      img.encodeJpg(thumb, quality: _thumbJpegQuality),
    );

    // Encrypt each with a separate random key
    final fullKey = _cryptoService.generateAesKey();
    final thumbKey = _cryptoService.generateAesKey();
    final encryptedFull = await _cryptoService.encrypt(fullJpeg, fullKey);
    final encryptedThumb = await _cryptoService.encrypt(thumbJpeg, thumbKey);

    // Upload encrypted bytes (use .enc extension to signal encrypted)
    final fullPath = '$parentCollection/$parentId/images/${messageId}_full.enc';
    final thumbPath = '$parentCollection/$parentId/images/${messageId}_thumb.enc';

    final results = await Future.wait([
      _uploadBytes(encryptedFull, fullPath, 'application/octet-stream'),
      _uploadBytes(encryptedThumb, thumbPath, 'application/octet-stream'),
    ]);

    return MediaUploadResult(
      url: results[0],
      thumbnailUrl: results[1],
      fileName: p.basename(imageFile.path),
      fileSize: fullJpeg.length,
      mimeType: 'image/jpeg',
      width: fullImage.width,
      height: fullImage.height,
      mediaKey: base64Encode(fullKey),
      thumbKey: base64Encode(thumbKey),
    );
  }

  /// Upload a voice recording encrypted with AES-256-GCM.
  Future<MediaUploadResult> uploadEncryptedVoice({
    required File voiceFile,
    required String parentCollection,
    required String parentId,
    required String messageId,
    required int durationSeconds,
  }) async {
    final fileSize = await voiceFile.length();
    if (fileSize > _maxVoiceBytes) {
      throw Exception('Voice file exceeds ${_maxVoiceBytes ~/ (1024 * 1024)} MB limit');
    }

    final rawBytes = await voiceFile.readAsBytes();
    final voiceKey = _cryptoService.generateAesKey();
    final encryptedBytes = await _cryptoService.encrypt(rawBytes, voiceKey);

    final storagePath =
        '$parentCollection/$parentId/voice/$messageId.enc';
    final url = await _uploadBytes(
        encryptedBytes, storagePath, 'application/octet-stream');

    return MediaUploadResult(
      url: url,
      fileName: p.basename(voiceFile.path),
      fileSize: fileSize,
      mimeType: 'audio/m4a',
      duration: durationSeconds,
      mediaKey: base64Encode(voiceKey),
    );
  }

  // =========================================================================
  // ENCRYPTED DOCUMENTS (E2EE)
  // =========================================================================

  static const int _maxDocumentBytes = 10 * 1024 * 1024; // 10 MB

  /// Upload a document encrypted with AES-256-GCM.
  ///
  /// No compression or thumbnails — documents are uploaded as-is after
  /// encryption. Returns the download URL and encryption key.
  Future<MediaUploadResult> uploadEncryptedDocument({
    required File documentFile,
    required String parentCollection,
    required String parentId,
    required String messageId,
  }) async {
    final fileSize = await documentFile.length();
    if (fileSize > _maxDocumentBytes) {
      throw Exception(
          'Document exceeds ${_maxDocumentBytes ~/ (1024 * 1024)} MB limit');
    }

    final rawBytes = await documentFile.readAsBytes();
    final docKey = _cryptoService.generateAesKey();
    final encryptedBytes = await _cryptoService.encrypt(rawBytes, docKey);

    final storagePath =
        '$parentCollection/$parentId/documents/$messageId.enc';
    final url = await _uploadBytes(
        encryptedBytes, storagePath, 'application/octet-stream');

    return MediaUploadResult(
      url: url,
      fileName: p.basename(documentFile.path),
      fileSize: fileSize,
      mimeType: _mimeTypeFromExtension(p.extension(documentFile.path)),
      mediaKey: base64Encode(docKey),
    );
  }

  /// Map file extension to MIME type for documents.
  static String _mimeTypeFromExtension(String ext) {
    switch (ext.toLowerCase()) {
      case '.pdf':
        return 'application/pdf';
      case '.doc':
        return 'application/msword';
      case '.docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case '.xls':
        return 'application/vnd.ms-excel';
      case '.xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case '.ppt':
        return 'application/vnd.ms-powerpoint';
      case '.pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      case '.txt':
        return 'text/plain';
      case '.csv':
        return 'text/csv';
      case '.zip':
        return 'application/zip';
      default:
        return 'application/octet-stream';
    }
  }

  // =========================================================================
  // ENCRYPTED VIDEO (E2EE)
  // =========================================================================

  static const int _maxVideoBytes = 5 * 1024 * 1024; // 5 MB

  /// Upload a video message encrypted with AES-256-GCM.
  ///
  /// Expects an already-compressed MP4 file (480×480, H.264, ≤5MB) and a
  /// JPEG thumbnail. Encrypts both with separate random keys and uploads
  /// in parallel.
  Future<MediaUploadResult> uploadEncryptedVideo({
    required File videoFile,
    required File thumbnailFile,
    required String parentCollection,
    required String parentId,
    required String messageId,
    required int durationSeconds,
  }) async {
    final videoSize = await videoFile.length();
    if (videoSize > _maxVideoBytes) {
      throw Exception(
          'Video exceeds ${_maxVideoBytes ~/ (1024 * 1024)} MB limit');
    }

    final videoBytes = await videoFile.readAsBytes();
    final thumbBytes = await thumbnailFile.readAsBytes();

    // Encrypt each with a separate random key
    final videoKey = _cryptoService.generateAesKey();
    final thumbKey = _cryptoService.generateAesKey();
    final encryptedVideo = await _cryptoService.encrypt(videoBytes, videoKey);
    final encryptedThumb = await _cryptoService.encrypt(thumbBytes, thumbKey);

    // Upload encrypted bytes in parallel
    final videoPath =
        '$parentCollection/$parentId/videos/$messageId.enc';
    final thumbPath =
        '$parentCollection/$parentId/videos/${messageId}_thumb.enc';

    final results = await Future.wait([
      _uploadBytes(encryptedVideo, videoPath, 'application/octet-stream'),
      _uploadBytes(encryptedThumb, thumbPath, 'application/octet-stream'),
    ]);

    return MediaUploadResult(
      url: results[0],
      thumbnailUrl: results[1],
      fileName: p.basename(videoFile.path),
      fileSize: videoBytes.length,
      mimeType: 'video/mp4',
      duration: durationSeconds,
      width: 480,
      height: 480,
      mediaKey: base64Encode(videoKey),
      thumbKey: base64Encode(thumbKey),
    );
  }

  // =========================================================================
  // ENCRYPTED DOWNLOADS (E2EE)
  // =========================================================================

  /// Download and decrypt an encrypted media file from Firebase Storage.
  ///
  /// [url] is the Firebase Storage download URL of the encrypted file.
  /// [mediaKeyBase64] is the AES-256-GCM key used to encrypt it.
  /// Returns the decrypted bytes.
  Future<Uint8List> downloadAndDecrypt({
    required String url,
    required String mediaKeyBase64,
  }) async {
    // Fix #5: Validate URL is not empty before attempting download
    if (url.isEmpty) {
      throw ArgumentError('Media URL is empty');
    }

    // Fix #6: Validate base64 key before decoding
    final Uint8List key;
    try {
      key = base64Decode(mediaKeyBase64);
    } on FormatException catch (e) {
      throw ArgumentError('Invalid base64 media key: $e');
    }
    if (key.length != 32) {
      throw ArgumentError(
        'Media key must be 32 bytes (AES-256), got ${key.length}',
      );
    }

    // Get storage reference from URL and download
    final ref = _storage.refFromURL(url);
    final encryptedBytes = await ref.getData().timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            throw TimeoutException('Media download timed out after 30s');
          },
        );
    if (encryptedBytes == null) {
      throw Exception('Failed to download encrypted media');
    }

    // Fix #1: Validate minimum size before splitting nonce/ciphertext
    // Format: nonce(12 bytes) || ciphertext(>=1 byte) || GCM tag(16 bytes)
    if (encryptedBytes.length < 29) {
      throw Exception(
        'Encrypted media too small (${encryptedBytes.length} bytes). '
        'Expected at least 29 bytes (12 nonce + 1 data + 16 tag).',
      );
    }

    // Decrypt: format is nonce(12) || ciphertext || mac(16)
    final nonce = Uint8List.fromList(encryptedBytes.sublist(0, 12));
    final ciphertextWithMac = Uint8List.fromList(encryptedBytes.sublist(12));
    return _cryptoService.decrypt(ciphertextWithMac, key, nonce: nonce);
  }

  // =========================================================================
  // PRIVATE HELPERS
  // =========================================================================

  /// Resize an image so its longest side is at most [maxDimension] pixels.
  /// Returns the original if already smaller.
  img.Image _resizeToMax(img.Image source, int maxDimension) {
    if (source.width <= maxDimension && source.height <= maxDimension) {
      return source;
    }

    final isWider = source.width >= source.height;
    return img.copyResize(
      source,
      width: isWider ? maxDimension : null,
      height: isWider ? null : maxDimension,
      interpolation: img.Interpolation.linear,
    );
  }

  /// Upload raw bytes to Firebase Storage. Returns the download URL.
  Future<String> _uploadBytes(
    Uint8List data,
    String storagePath,
    String contentType,
  ) async {
    final ref = _storage.ref().child(storagePath);
    final metadata = SettableMetadata(contentType: contentType);
    await ref.putData(data, metadata);
    return ref.getDownloadURL();
  }

  /// Upload a [File] to Firebase Storage. Returns the download URL.
  Future<String> _uploadFile(
    File file,
    String storagePath,
    String contentType,
  ) async {
    final ref = _storage.ref().child(storagePath);
    final metadata = SettableMetadata(contentType: contentType);
    await ref.putFile(file, metadata);
    return ref.getDownloadURL();
  }
}
