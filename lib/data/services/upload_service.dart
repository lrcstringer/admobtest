import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ffmpeg_kit_flutter_new_min/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_min/return_code.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;

/// Service for handling file uploads, video compression, and connectivity checks
/// used by the Upload earning type.
@lazySingleton
class UploadService {
  final FirebaseStorage _storage;

  UploadService(this._storage);

  // ── Video Compression ──

  /// Compress video to 480p, 24fps, H.264 main profile, CRF 23, AAC 128kbps.
  /// Returns the compressed file. Progress is reported via [onProgress] (0.0–1.0).
  Future<File> compressVideo(
    File input, {
    void Function(double progress)? onProgress,
  }) async {
    final dir = input.parent.path;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final outputPath = p.join(dir, 'compressed_$timestamp.mp4');

    // Build ffmpeg command
    final command = '-i "${input.path}" '
        '-vf "scale=854:480:force_original_aspect_ratio=decrease,'
        'pad=854:480:(ow-iw)/2:(oh-ih)/2" '
        '-r 24 -c:v mpeg4 -q:v 5 '
        '-c:a aac -b:a 128k -movflags +faststart '
        '-y "$outputPath"';

    debugPrint('UploadService: Compressing video → $outputPath');

    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();

    if (!ReturnCode.isSuccess(returnCode)) {
      final logs = await session.getAllLogsAsString();
      debugPrint('UploadService: Compression failed: $logs');
      throw Exception('Video compression failed (code: $returnCode)');
    }

    final compressed = File(outputPath);
    final originalSize = await input.length();
    final compressedSize = await compressed.length();
    debugPrint(
      'UploadService: Compressed ${formatBytes(originalSize)} → '
      '${formatBytes(compressedSize)} '
      '(${(100 - compressedSize * 100 / originalSize).toStringAsFixed(0)}% reduction)',
    );

    return compressed;
  }

  // ── Firebase Storage Upload ──

  /// Upload a file to Firebase Storage with progress tracking.
  /// Returns the download URL.
  Future<String> uploadFile({
    required File file,
    required String storagePath,
    required String contentType,
    required void Function(int bytesTransferred, int totalBytes) onProgress,
  }) async {
    final ref = _storage.ref().child(storagePath);
    final metadata = SettableMetadata(contentType: contentType);
    final uploadTask = ref.putFile(file, metadata);

    uploadTask.snapshotEvents.listen((snapshot) {
      onProgress(
        snapshot.bytesTransferred,
        snapshot.totalBytes,
      );
    });

    await uploadTask;
    return await ref.getDownloadURL();
  }

  /// Build the storage path for an engagement upload.
  String buildStoragePath({
    required String engagementId,
    required String type, // 'video' or 'image'
    required String fileName,
  }) {
    return 'engagement_uploads/$engagementId/$type/$fileName';
  }

  // ── Connectivity ──

  /// Check if the device is currently on WiFi.
  Future<bool> isOnWifi() async {
    final results = await Connectivity().checkConnectivity();
    return results.contains(ConnectivityResult.wifi);
  }

  // ── Data Cost Estimation ──

  /// Estimate mobile data cost at R0.40 per MB.
  String estimateDataCost(int bytes) {
    final mb = bytes / (1024 * 1024);
    final cost = mb * 0.40;
    return 'R${cost.toStringAsFixed(2)}';
  }

  /// Format bytes as human-readable string (e.g. "2.3 MB").
  static String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  // ── File Validation ──

  /// Validate a video file (max 50 MB).
  Future<bool> isValidVideoFile(File file) async {
    final size = await file.length();
    return size > 0 && size <= 50 * 1024 * 1024;
  }

  /// Validate an image file (max 10 MB).
  Future<bool> isValidImageFile(File file) async {
    final size = await file.length();
    return size > 0 && size <= 10 * 1024 * 1024;
  }

  /// Clean up temporary compressed files.
  Future<void> cleanupTempFile(File? file) async {
    if (file != null && await file.exists()) {
      try {
        await file.delete();
      } catch (e) {
        debugPrint('UploadService: Failed to delete temp file: $e');
      }
    }
  }
}
