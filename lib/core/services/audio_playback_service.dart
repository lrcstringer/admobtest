import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/datasources/remote/media_upload_datasource.dart';

/// Singleton audio playback service for voice messages.
///
/// Wraps a single [AudioPlayer] so only one voice message plays at a time.
/// Handles downloading + decrypting E2EE voice files before playback.
@lazySingleton
class AudioPlaybackService {
  final MediaUploadDatasource _mediaDatasource;
  final AudioPlayer _player = AudioPlayer();

  /// Cache of already-decrypted voice files: messageId → temp file path.
  /// Fix #8: Bounded to [_maxCacheSize] entries with LRU eviction.
  static const int _maxCacheSize = 50;
  final Map<String, String> _fileCache = {};
  final List<String> _cacheOrder = []; // LRU order: oldest first

  /// Which message is currently loaded in the player.
  String? _currentMessageId;

  /// Whether the service is currently loading a file (downloading/decrypting).
  bool _isLoading = false;

  AudioPlaybackService(this._mediaDatasource);

  // ---------------------------------------------------------------------------
  // Streams for UI binding
  // ---------------------------------------------------------------------------

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  String? get currentMessageId => _currentMessageId;
  bool get isLoading => _isLoading;

  // ---------------------------------------------------------------------------
  // Playback controls
  // ---------------------------------------------------------------------------

  /// Play a voice message. Stops any currently playing message first.
  ///
  /// If [mediaKeyBase64] is non-null, the file is downloaded and decrypted.
  /// Otherwise the URL is streamed directly.
  Future<void> playVoice({
    required String messageId,
    required String url,
    String? mediaKeyBase64,
  }) async {
    // Fix #17: Prevent double-tap race — reject if already loading
    if (_isLoading) return;

    // If same message and paused, just resume
    if (_currentMessageId == messageId && !_player.playing) {
      _player.play();
      return;
    }

    // Stop current playback
    await _player.stop();
    _currentMessageId = messageId;
    _isLoading = true;

    try {
      if (mediaKeyBase64 != null && mediaKeyBase64.isNotEmpty) {
        // E2EE: download, decrypt, play from file
        final filePath = await _resolveEncryptedFile(
          messageId,
          url,
          mediaKeyBase64,
        );
        await _player.setFilePath(filePath);
      } else {
        // Plain: stream directly from URL
        await _player.setUrl(url);
      }
      _isLoading = false;
      _player.play();
    } catch (e) {
      debugPrint('AudioPlaybackService: playVoice error: $e');
      _isLoading = false;
      _currentMessageId = null;
      rethrow;
    }
  }

  Future<void> pause() => _player.pause();

  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> stop() async {
    await _player.stop();
    _currentMessageId = null;
  }

  /// Clear cached temp files.
  Future<void> clearCache() async {
    for (final path in _fileCache.values) {
      try {
        await File(path).delete();
      } catch (_) {}
    }
    _fileCache.clear();
    _cacheOrder.clear();
  }

  @disposeMethod
  Future<void> dispose() async {
    await _player.dispose();
    await clearCache();
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<String> _resolveEncryptedFile(
    String messageId,
    String url,
    String mediaKeyBase64,
  ) async {
    // Return cached file if available
    if (_fileCache.containsKey(messageId)) {
      final cached = _fileCache[messageId]!;
      if (File(cached).existsSync()) {
        // Fix #8: Move to end of LRU order (most recently used)
        _cacheOrder.remove(messageId);
        _cacheOrder.add(messageId);
        return cached;
      }
      _fileCache.remove(messageId);
      _cacheOrder.remove(messageId);
    }

    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/voice_$messageId.m4a';

    final decrypted = await _mediaDatasource.downloadAndDecrypt(
      url: url,
      mediaKeyBase64: mediaKeyBase64,
    );
    await File(filePath).writeAsBytes(decrypted);

    _fileCache[messageId] = filePath;
    _cacheOrder.add(messageId);

    // Fix #8: Evict oldest entries when cache exceeds limit
    while (_cacheOrder.length > _maxCacheSize) {
      final evictId = _cacheOrder.removeAt(0);
      final evictPath = _fileCache.remove(evictId);
      if (evictPath != null) {
        File(evictPath).delete().ignore();
      }
    }

    return filePath;
  }
}
