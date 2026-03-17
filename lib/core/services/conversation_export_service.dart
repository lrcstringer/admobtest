import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/media_upload_datasource.dart';
import '../../data/mappers/local_message_mapper.dart';
import '../../domain/entities/message.dart';
import '../../domain/enums/message_type.dart';

/// Exports a conversation as a .txt file (text-only) or .zip (with media).
///
/// Reads decrypted messages from the local Drift database and optionally
/// downloads + decrypts media from Firebase Storage. Produces a file in the
/// app's temp directory and returns it as an [XFile] for the native share sheet.
@lazySingleton
class ConversationExportService {
  final AppDatabase _appDatabase;
  final MediaUploadDatasource _mediaDatasource;

  ConversationExportService(this._appDatabase, this._mediaDatasource);

  static final _dateFormat = DateFormat('dd/MM/yyyy, HH:mm');
  static final _fileDateFormat = DateFormat('yyyy-MM-dd');

  /// Export conversation as plain text (.txt).
  Future<XFile> exportAsText({
    required String conversationId,
    required String conversationName,
    required String currentUserId,
  }) async {
    final messages = await _fetchVisibleMessages(conversationId, currentUserId);
    if (messages.isEmpty) {
      throw const ExportException('No messages to export');
    }

    final text = _formatMessages(messages, currentUserId);
    final exportDir = await _prepareExportDir();
    final safeName = _sanitizeFileName(conversationName);
    final date = _fileDateFormat.format(DateTime.now());
    final file = File(p.join(exportDir.path, '${safeName}_$date.txt'));
    await file.writeAsString(text);

    return XFile(file.path, mimeType: 'text/plain');
  }

  /// Export conversation with media as a .zip file.
  ///
  /// [onProgress] is called after each media file is processed with
  /// (completedCount, totalCount).
  Future<XFile> exportWithMedia({
    required String conversationId,
    required String conversationName,
    required String currentUserId,
    required void Function(int completed, int total) onProgress,
  }) async {
    final messages = await _fetchVisibleMessages(conversationId, currentUserId);
    if (messages.isEmpty) {
      throw const ExportException('No messages to export');
    }

    // Identify media messages for download
    final mediaMessages = messages
        .where((m) =>
            m.media != null &&
            m.media!.url.isNotEmpty &&
            m.media!.mediaKey != null &&
            m.media!.mediaKey!.isNotEmpty)
        .toList();

    final total = mediaMessages.length;
    var completed = 0;

    // Download + decrypt media files, track filenames for text references
    final mediaFiles = <String, Uint8List>{}; // messageId → bytes
    final mediaFileNames = <String, String>{}; // messageId → filename in zip
    var mediaIndex = 1;

    for (final msg in mediaMessages) {
      final indexStr = mediaIndex.toString().padLeft(3, '0');
      final fileName = '${indexStr}_${msg.media!.fileName}';
      try {
        final bytes = await _mediaDatasource.downloadAndDecrypt(
          url: msg.media!.url,
          mediaKeyBase64: msg.media!.mediaKey!,
        );
        mediaFiles[msg.id] = bytes;
        mediaFileNames[msg.id] = fileName;
      } catch (e) {
        // Mark as unavailable — formatter will show [Media unavailable]
      }
      mediaIndex++;
      completed++;
      onProgress(completed, total);
    }

    // Format text with media file references
    final text = _formatMessages(
      messages,
      currentUserId,
      mediaFileNames: mediaFileNames,
    );

    // Build ZIP archive
    final archive = Archive();

    // Add chat.txt
    final textBytes = Uint8List.fromList(text.codeUnits);
    archive.addFile(ArchiveFile('chat.txt', textBytes.length, textBytes));

    // Add media files
    for (final entry in mediaFiles.entries) {
      final fileName = mediaFileNames[entry.key]!;
      archive.addFile(
        ArchiveFile('media/$fileName', entry.value.length, entry.value),
      );
    }

    // Encode and write ZIP
    final zipBytes = ZipEncoder().encode(archive);

    final exportDir = await _prepareExportDir();
    final safeName = _sanitizeFileName(conversationName);
    final date = _fileDateFormat.format(DateTime.now());
    final file = File(p.join(exportDir.path, '${safeName}_$date.zip'));
    await file.writeAsBytes(zipBytes);

    return XFile(file.path, mimeType: 'application/zip');
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<List<Message>> _fetchVisibleMessages(
    String conversationId,
    String currentUserId,
  ) async {
    final rows = await _appDatabase.getAllLocalMessagesAsc(conversationId);
    return rows
        .map(LocalMessageMapper.toEntity)
        .where((m) => m.isVisibleTo(currentUserId))
        .toList();
  }

  Future<Directory> _prepareExportDir() async {
    final cacheDir = await getTemporaryDirectory();
    final exportDir = Directory(p.join(cacheDir.path, 'exports'));
    // Clean up previous exports
    if (exportDir.existsSync()) {
      await exportDir.delete(recursive: true);
    }
    await exportDir.create(recursive: true);
    return exportDir;
  }

  String _formatMessages(
    List<Message> messages,
    String currentUserId, {
    Map<String, String> mediaFileNames = const {},
  }) {
    final buffer = StringBuffer();
    for (final msg in messages) {
      final line = _formatMessage(msg, currentUserId, mediaFileNames);
      buffer.writeln(line);
    }
    return buffer.toString();
  }

  String _formatMessage(
    Message msg,
    String currentUserId,
    Map<String, String> mediaFileNames,
  ) {
    final timestamp = _dateFormat.format(msg.createdAt);
    final sender = msg.senderId == currentUserId ? 'You' : msg.senderName;

    // System messages use a different format
    if (msg.type == MessageType.system) {
      final content = msg.textContent ?? msg.systemEventType ?? 'System event';
      return '[$timestamp] [System: $content]';
    }

    final parts = <String>[];

    // Reply-to context
    if (msg.replyTo != null) {
      parts.add('> ${msg.replyTo!.senderName}: ${msg.replyTo!.text}');
    }

    // Forwarded indicator
    if (msg.isForwarded) {
      parts.add('[Forwarded]');
    }

    // Main content
    parts.add(_formatContent(msg, currentUserId, mediaFileNames));

    return '[$timestamp] $sender: ${parts.join('\n')}';
  }

  String _formatContent(
    Message msg,
    String currentUserId,
    Map<String, String> mediaFileNames,
  ) {
    switch (msg.type) {
      case MessageType.text:
        return msg.textContent ?? '[Encrypted message]';

      case MessageType.image:
        final ref = _mediaRef(msg.id, msg.media, mediaFileNames);
        final caption = msg.textContent;
        return caption != null ? '$ref $caption' : ref;

      case MessageType.voice:
        final durationSec = (msg.media?.duration ?? 0) ~/ 1000;
        return '[Voice Note: ${durationSec}s]';

      case MessageType.document:
        return _mediaRef(msg.id, msg.media, mediaFileNames);

      case MessageType.video:
        return _mediaRef(msg.id, msg.media, mediaFileNames);

      case MessageType.tokenSend:
        final amount = msg.tokenAmount ?? 0;
        final isSender = msg.senderId == currentUserId;
        return isSender ? 'Sent $amount tokens' : 'Received $amount tokens';

      case MessageType.tokenRequest:
        final amount = msg.tokenAmount ?? 0;
        return 'Requested $amount tokens \u2014 ${msg.status.name}';

      case MessageType.gift:
        final gift = msg.gift;
        if (gift != null) {
          return '[Gift: ${gift.amount} tokens \u2014 "${gift.message}"]';
        }
        return '[Gift: ${msg.tokenAmount ?? 0} tokens]';

      case MessageType.tokenSpray:
        final spray = msg.tokenSpray;
        if (spray != null) {
          return '[Token Spray: ${spray.occasion} \u2014 '
              '${spray.currentTotal} tokens]';
        }
        return '[Token Spray]';

      case MessageType.system:
        return msg.textContent ?? msg.systemEventType ?? 'System event';

      case MessageType.groupGift:
        final gg = msg.groupGift;
        if (gg != null) {
          return '[Group Gift: ${gg.amount} tokens from ${gg.organizerName}]';
        }
        return '[Group Gift: ${msg.tokenAmount ?? 0} tokens]';

      case MessageType.marketplaceShare:
        final text = msg.textContent;
        return text != null
            ? '[Shared Marketplace Listing] $text'
            : '[Shared Marketplace Listing]';

      case MessageType.groupBuyShare:
        final text = msg.textContent;
        return text != null
            ? '[Shared Group Buy] $text'
            : '[Shared Group Buy]';

      case MessageType.gooiGooiInvite:
        return msg.textContent ?? '[Gooi-Gooi Invite]';
    }
  }

  /// Returns a media reference string. If the media was downloaded and included
  /// in the zip, references the filename. Otherwise shows type + original name.
  String _mediaRef(
    String messageId,
    MessageMedia? media,
    Map<String, String> mediaFileNames,
  ) {
    final zipName = mediaFileNames[messageId];
    final fileName = media?.fileName ?? 'unknown';
    final typeName = _mediaTypeName(media?.mimeType);

    if (zipName != null) {
      return '[$typeName: media/$zipName]';
    }
    if (media?.url.isNotEmpty == true && mediaFileNames.isNotEmpty) {
      // We attempted download but it failed
      return '[$typeName unavailable: $fileName]';
    }
    return '[$typeName: $fileName]';
  }

  String _mediaTypeName(String? mimeType) {
    if (mimeType == null) return 'File';
    if (mimeType.startsWith('image/')) return 'Image';
    if (mimeType.startsWith('video/')) return 'Video';
    if (mimeType.startsWith('audio/')) return 'Voice Note';
    return 'Document';
  }

  String _sanitizeFileName(String name) {
    // Remove characters invalid in filenames
    return name
        .replaceAll(RegExp(r'[<>:"/\\|?*]'), '')
        .replaceAll(RegExp(r'\s+'), '_')
        .trim();
  }
}

/// Exception thrown when an export operation fails.
class ExportException implements Exception {
  final String message;
  const ExportException(this.message);

  @override
  String toString() => 'ExportException: $message';
}
