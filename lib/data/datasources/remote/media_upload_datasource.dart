import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;

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

  const MediaUploadResult({
    required this.url,
    this.thumbnailUrl,
    required this.fileName,
    required this.fileSize,
    required this.mimeType,
    this.duration,
    this.width,
    this.height,
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

  MediaUploadDatasource(this._storage);

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
