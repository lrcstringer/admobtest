import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:cloud_functions/cloud_functions.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../data/datasources/local/app_database.dart';
import '../../data/datasources/remote/community_remote_datasource.dart';
import '../../data/datasources/remote/conversation_remote_datasource.dart';
import '../../data/mappers/local_message_mapper.dart';
import '../../domain/entities/message.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';
import 'community_sync_service.dart';
import 'media_recovery_service.dart';
import 'sender_key_service.dart';
import 'signal_protocol_service.dart';
import '../network/network_info.dart';
import 'message_sync_service.dart';

const _uuid = Uuid();

/// Persistent outgoing message queue.
///
/// Persists every outgoing message to the local DB *before* attempting to
/// send, so messages survive app kills. When connectivity returns (or on
/// explicit retry), the queue drains in createdAt order.
@lazySingleton
class OutgoingMessageQueue {
  final AppDatabase _appDatabase;
  final NetworkInfo _networkInfo;
  final ConversationRemoteDataSource _conversationRemoteDS;
  final CommunityRemoteDataSource _communityRemoteDS;
  final SignalProtocolService _signalProtocolService;
  final SenderKeyService _senderKeyService;
  final MessageSyncService _messageSyncService;
  final CommunitySyncService _communitySyncService;
  final MediaRecoveryService _mediaRecoveryService;

  StreamSubscription<bool>? _connectivitySub;
  Completer<void>? _processingCompleter;
  Timer? _reDrainTimer;

  // 9.2 Guard against concurrent sender key distribution for same community
  static final _distributionInProgress = <String>{};

  // 9.8 Max retry count and max age for failed messages
  static const _maxRetries = 10;
  static const _maxAge = Duration(hours: 24);

  OutgoingMessageQueue(
    this._appDatabase,
    this._networkInfo,
    this._conversationRemoteDS,
    this._communityRemoteDS,
    this._signalProtocolService,
    this._senderKeyService,
    this._messageSyncService,
    this._communitySyncService,
    this._mediaRecoveryService,
  );

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  /// Start listening for connectivity changes to drain the queue.
  void startListening() {
    _connectivitySub?.cancel();
    _connectivitySub = _networkInfo.onConnectivityChanged.listen((connected) {
      if (connected) {
        processPendingMessages();
      }
    });
    // Also try to drain on start in case we have pending items.
    processPendingMessages();
  }

  /// Stop listening for connectivity changes.
  void stopListening() {
    _connectivitySub?.cancel();
    _connectivitySub = null;
    // 9.6 Cancel any pending re-drain timer
    _reDrainTimer?.cancel();
    _reDrainTimer = null;
  }

  // =========================================================================
  // ENQUEUE — P2P TEXT
  // =========================================================================

  /// Enqueue a P2P text message. Returns an optimistic [Message] immediately.
  Future<Message> enqueueTextMessage({
    required String conversationId,
    required String text,
    required String recipientId,
    String? replyToMessageId,
  }) async {
    final id = 'pending_${_uuid.v4()}';
    final now = DateTime.now();

    // 1. Persist pending message
    await _appDatabase.insertPendingMessage(LocalPendingMessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      type: const Value('text'),
      plaintext: Value(text),
      recipientId: Value(recipientId),
      replyToMessageId: Value(replyToMessageId),
      status: const Value('pending'),
      createdAt: Value(now),
    ));

    // 2. Insert optimistic LocalFullMessage
    final optimistic = Message(
      id: id,
      senderId: _conversationRemoteDS.currentUserId ?? '',
      senderName: '',
      type: MessageType.text,
      status: MessageStatus.sending,
      textContent: text,
      createdAt: now,
    );
    await _appDatabase.upsertLocalMessage(
      LocalMessageMapper.toCompanion(optimistic, conversationId),
    );

    // 3. Update conversation preview
    await _updateConversationPreview(conversationId, text, now);

    // 4. If online, try to send immediately
    if (await _networkInfo.isConnected) {
      _processNextPending();
    }

    return optimistic;
  }

  // =========================================================================
  // ENQUEUE — P2P MEDIA
  // =========================================================================

  /// Enqueue a P2P media message. Media upload must be done BEFORE calling
  /// this — pass the upload result in [payloadJson].
  Future<Message> enqueueMediaMessage({
    required String conversationId,
    required String recipientId,
    required String encryptedPayloadJson,
    required String mediaType,
    String? caption,
    int? durationSeconds,
    String? replyToMessageId,
  }) async {
    final id = 'pending_${_uuid.v4()}';
    final now = DateTime.now();
    final isAudio = mediaType.startsWith('audio');
    final isDocument =
        mediaType == 'document' || mediaType.startsWith('application');
    final isVideo = mediaType.startsWith('video');

    await _appDatabase.insertPendingMessage(LocalPendingMessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      type: const Value('media'),
      plaintext: Value(encryptedPayloadJson),
      recipientId: Value(recipientId),
      replyToMessageId: Value(replyToMessageId),
      payloadJson: Value(jsonEncode({
        'mediaType': mediaType,
        'caption': caption,
        'durationSeconds': durationSeconds,
        'isAudio': isAudio,
        'isDocument': isDocument,
        'isVideo': isVideo,
      })),
      status: const Value('pending'),
      createdAt: Value(now),
    ));

    // Parse media metadata from the payload so the optimistic message
    // renders the image/voice/document correctly on the sender side.
    MessageMedia? mediaData;
    try {
      final parsed = jsonDecode(encryptedPayloadJson) as Map<String, dynamic>;
      if (parsed.containsKey('media')) {
        mediaData = MessageMedia.fromJson(
          parsed['media'] as Map<String, dynamic>,
        );
      }
    } catch (_) {}

    final MessageType msgType;
    if (isAudio) {
      msgType = MessageType.voice;
    } else if (isDocument) {
      msgType = MessageType.document;
    } else if (isVideo) {
      msgType = MessageType.video;
    } else {
      msgType = MessageType.image;
    }

    final optimistic = Message(
      id: id,
      senderId: _conversationRemoteDS.currentUserId ?? '',
      senderName: '',
      type: msgType,
      status: MessageStatus.sending,
      textContent: caption,
      media: mediaData,
      createdAt: now,
    );
    await _appDatabase.upsertLocalMessage(
      LocalMessageMapper.toCompanion(optimistic, conversationId),
    );

    final String preview;
    if (isAudio) {
      preview = '🎙 Voice message';
    } else if (isDocument) {
      preview = '📄 Document';
    } else if (isVideo) {
      preview = '🎬 Video message';
    } else {
      preview = '📷 Photo';
    }
    await _updateConversationPreview(conversationId, preview, now);

    if (await _networkInfo.isConnected) {
      _processNextPending();
    }

    return optimistic;
  }

  // =========================================================================
  // ENQUEUE — COMMUNITY TEXT
  // =========================================================================

  /// Enqueue a community text message.
  Future<Message> enqueueCommunityTextMessage({
    required String communityId,
    required String text,
    String? replyToMessageId,
  }) async {
    final id = 'pending_${_uuid.v4()}';
    final now = DateTime.now();

    await _appDatabase.insertPendingMessage(LocalPendingMessagesCompanion(
      id: Value(id),
      conversationId: Value(communityId),
      type: const Value('community_text'),
      plaintext: Value(text),
      replyToMessageId: Value(replyToMessageId),
      status: const Value('pending'),
      createdAt: Value(now),
    ));

    final optimistic = Message(
      id: id,
      senderId: _conversationRemoteDS.currentUserId ?? '',
      senderName: '',
      type: MessageType.text,
      status: MessageStatus.sending,
      textContent: text,
      communityId: communityId,
      createdAt: now,
    );
    await _appDatabase.upsertLocalMessage(
      LocalMessageMapper.toCompanion(optimistic, communityId),
    );

    await _updateCommunityPreview(communityId, text, now);

    if (await _networkInfo.isConnected) {
      _processNextPending();
    }

    return optimistic;
  }

  // =========================================================================
  // ENQUEUE — COMMUNITY MEDIA
  // =========================================================================

  /// Enqueue a community media message. Upload must be done before calling.
  Future<Message> enqueueCommunityMediaMessage({
    required String communityId,
    required String payloadJson,
    required String mediaType,
    String? caption,
  }) async {
    final id = 'pending_${_uuid.v4()}';
    final now = DateTime.now();

    // Derive MessageType from MIME type string
    final msgType = mediaType.startsWith('audio')
        ? MessageType.voice
        : mediaType.startsWith('video')
            ? MessageType.video
            : (mediaType == 'document' || mediaType.startsWith('application'))
                ? MessageType.document
                : MessageType.image;

    await _appDatabase.insertPendingMessage(LocalPendingMessagesCompanion(
      id: Value(id),
      conversationId: Value(communityId),
      type: const Value('community_media'),
      plaintext: Value(caption),
      payloadJson: Value(payloadJson),
      status: const Value('pending'),
      createdAt: Value(now),
    ));

    final optimistic = Message(
      id: id,
      senderId: _conversationRemoteDS.currentUserId ?? '',
      senderName: '',
      type: msgType,
      status: MessageStatus.sending,
      textContent: caption,
      communityId: communityId,
      createdAt: now,
    );
    await _appDatabase.upsertLocalMessage(
      LocalMessageMapper.toCompanion(optimistic, communityId),
    );

    // Type-appropriate preview text
    final previewText = switch (msgType) {
      MessageType.voice => '🎤 Voice note',
      MessageType.video => '🎬 Video',
      MessageType.document => '📎 Document',
      _ => caption ?? '📷 Photo',
    };
    await _updateCommunityPreview(communityId, previewText, now);

    if (await _networkInfo.isConnected) {
      _processNextPending();
    }

    return optimistic;
  }

  // =========================================================================
  // ENQUEUE — TOKEN SEND
  // =========================================================================

  /// Enqueue a P2P token send.
  Future<Message> enqueueTokenSend({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? message,
    String? subAccountId,
  }) async {
    final id = 'pending_${_uuid.v4()}';
    final now = DateTime.now();

    await _appDatabase.insertPendingMessage(LocalPendingMessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      type: const Value('token_send'),
      plaintext: Value(message),
      recipientId: Value(recipientId),
      payloadJson: Value(jsonEncode({
        'amount': amount,
        'message': message,
        if (subAccountId != null) 'senderSubAccountId': subAccountId,
      })),
      status: const Value('pending'),
      createdAt: Value(now),
    ));

    final optimistic = Message(
      id: id,
      senderId: _conversationRemoteDS.currentUserId ?? '',
      senderName: '',
      type: MessageType.tokenSend,
      status: MessageStatus.sending,
      textContent: message,
      tokenAmount: amount,
      recipientId: recipientId,
      createdAt: now,
    );
    await _appDatabase.upsertLocalMessage(
      LocalMessageMapper.toCompanion(optimistic, conversationId),
    );

    await _updateConversationPreview(
      conversationId,
      '💰 Sent $amount tokens',
      now,
    );

    if (await _networkInfo.isConnected) {
      _processNextPending();
    }

    return optimistic;
  }

  // =========================================================================
  // ENQUEUE — TOKEN REQUEST
  // =========================================================================

  /// Enqueue a P2P token request.
  Future<Message> enqueueTokenRequest({
    required String conversationId,
    required String recipientId,
    required int amount,
    String? message,
    String? subAccountId,
  }) async {
    final id = 'pending_${_uuid.v4()}';
    final now = DateTime.now();

    await _appDatabase.insertPendingMessage(LocalPendingMessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      type: const Value('token_request'),
      plaintext: Value(message),
      recipientId: Value(recipientId),
      payloadJson: Value(jsonEncode({
        'amount': amount,
        'message': message,
        if (subAccountId != null) 'senderSubAccountId': subAccountId,
      })),
      status: const Value('pending'),
      createdAt: Value(now),
    ));

    final optimistic = Message(
      id: id,
      senderId: _conversationRemoteDS.currentUserId ?? '',
      senderName: '',
      type: MessageType.tokenRequest,
      status: MessageStatus.sending,
      textContent: message,
      tokenAmount: amount,
      recipientId: recipientId,
      createdAt: now,
    );
    await _appDatabase.upsertLocalMessage(
      LocalMessageMapper.toCompanion(optimistic, conversationId),
    );

    await _updateConversationPreview(
      conversationId,
      '💰 Requested $amount tokens',
      now,
    );

    if (await _networkInfo.isConnected) {
      _processNextPending();
    }

    return optimistic;
  }

  // =========================================================================
  // ENQUEUE — FORWARD
  // =========================================================================

  /// Enqueue a message forward.
  Future<Message> enqueueForwardMessage({
    required String sourceConversationId,
    required String sourceMessageId,
    required String targetConversationId,
    String? plaintextContent,
    String? recipientId,
  }) async {
    final id = 'pending_${_uuid.v4()}';
    final now = DateTime.now();

    await _appDatabase.insertPendingMessage(LocalPendingMessagesCompanion(
      id: Value(id),
      conversationId: Value(targetConversationId),
      type: const Value('forward'),
      plaintext: Value(plaintextContent),
      recipientId: Value(recipientId),
      payloadJson: Value(jsonEncode({
        'sourceConversationId': sourceConversationId,
        'sourceMessageId': sourceMessageId,
        'targetConversationId': targetConversationId,
      })),
      status: const Value('pending'),
      createdAt: Value(now),
    ));

    final optimistic = Message(
      id: id,
      senderId: _conversationRemoteDS.currentUserId ?? '',
      senderName: '',
      type: MessageType.text,
      status: MessageStatus.sending,
      textContent: plaintextContent,
      createdAt: now,
    );
    await _appDatabase.upsertLocalMessage(
      LocalMessageMapper.toCompanion(optimistic, targetConversationId),
    );

    await _updateConversationPreview(
      targetConversationId,
      plaintextContent ?? 'Forwarded message',
      now,
    );

    if (await _networkInfo.isConnected) {
      _processNextPending();
    }

    return optimistic;
  }

  // =========================================================================
  // RETRY
  // =========================================================================

  /// Retry a failed pending message.
  Future<void> retryMessage(String pendingId) async {
    await _appDatabase.updatePendingMessageStatus(pendingId, 'pending');
    // Also update the optimistic local message back to sending
    await _appDatabase.updateLocalMessageStatus(pendingId, 'sending');
    _processNextPending();
  }

  // =========================================================================
  // PROCESS QUEUE
  // =========================================================================

  /// Process all pending messages. Called on connectivity restored.
  Future<void> processPendingMessages() async {
    // 9.5 Use Completer to prevent concurrent processing
    if (_processingCompleter != null && !_processingCompleter!.isCompleted) {
      return;
    }
    _processingCompleter = Completer<void>();

    try {
      final pending = await _appDatabase.getPendingMessages();
      if (pending.isEmpty) return;

      debugPrint(
          'OutgoingMessageQueue: Processing ${pending.length} pending messages');

      DateTime? earliestRetry;
      for (final msg in pending) {
        // 9.8 Skip messages that have exceeded max retries or max age
        if (msg.retryCount >= _maxRetries ||
            DateTime.now().difference(msg.createdAt) > _maxAge) {
          await _markFailed(
            msg.id,
            msg.retryCount >= _maxRetries
                ? 'Max retries exceeded'
                : 'Message expired (over 24 hours old)',
          );
          continue;
        }

        // Skip messages still in exponential backoff
        if (_isInBackoff(msg)) {
          final retryAt = msg.lastAttemptAt!.add(_backoffDuration(msg.retryCount));
          if (earliestRetry == null || retryAt.isBefore(earliestRetry)) {
            earliestRetry = retryAt;
          }
          continue;
        }
        try {
          await _processMessage(msg);
        } catch (e) {
          debugPrint(
              'OutgoingMessageQueue: Failed to process ${msg.type} '
              '${msg.id}: $e');
        }
      }

      // 9.6 Schedule a single cancellable timer for the earliest backed-off message
      if (earliestRetry != null) {
        final delay = earliestRetry.difference(DateTime.now());
        if (delay > Duration.zero) {
          _reDrainTimer?.cancel();
          _reDrainTimer = Timer(delay, () => _processNextPending());
        }
      }
    } finally {
      _processingCompleter!.complete();
    }
  }

  /// Fire-and-forget helper to kick off queue processing.
  void _processNextPending() {
    Future.microtask(() => processPendingMessages());
  }

  // =========================================================================
  // PROCESS INDIVIDUAL MESSAGE
  // =========================================================================

  Future<void> _processMessage(LocalPendingMessage msg) async {
    switch (msg.type) {
      case 'text':
        await _processTextMessage(msg);
        break;
      case 'media':
        await _processMediaMessage(msg);
        break;
      case 'community_text':
        await _processCommunityTextMessage(msg);
        break;
      case 'community_media':
        await _processCommunityMediaMessage(msg);
        break;
      case 'token_send':
        await _processTokenSend(msg);
        break;
      case 'token_request':
        await _processTokenRequest(msg);
        break;
      case 'forward':
        await _processForwardMessage(msg);
        break;
      default:
        debugPrint('OutgoingMessageQueue: Unknown type: ${msg.type}');
    }
  }

  // ─── P2P TEXT ───────────────────────────────────────────────────────────

  Future<void> _processTextMessage(LocalPendingMessage msg) async {
    final plaintext = msg.plaintext;
    final recipientId = msg.recipientId;
    if (plaintext == null || recipientId == null) {
      await _markFailed(msg.id, 'Missing plaintext or recipientId');
      return;
    }

    try {
      // Encrypt
      await _appDatabase.updatePendingMessageStatus(msg.id, 'encrypting');
      final encrypted =
          await _encryptWithFreshnessCheck(recipientId, plaintext);

      // Pre-cache plaintext by ciphertext fingerprint
      final ciphertextStr = encrypted['ciphertext'] as String;
      final ctFingerprint = _ciphertextFingerprint(ciphertextStr);
      try {
        await _appDatabase.cacheDecryptedPlaintext(ctFingerprint, plaintext);
      } catch (_) {}

      // Send
      await _appDatabase.updatePendingMessageStatus(msg.id, 'sending');
      final messageId = await _conversationRemoteDS.sendEncryptedMessage(
        conversationId: msg.conversationId,
        ciphertext: ciphertextStr,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        x3dhHeader: encrypted['x3dhHeader'] as Map<String, dynamic>?,
        replyToMessageId: msg.replyToMessageId,
      );

      // Success: cache plaintext, upsert real message, remove pending
      await _finalizeSent(
        pendingId: msg.id,
        realMessageId: messageId,
        conversationId: msg.conversationId,
        plaintext: plaintext,
        type: MessageType.text,
        createdAt: msg.createdAt,
      );
    } catch (e) {
      await _markFailed(msg.id, _userFriendlyError(e));
    }
  }

  // ─── P2P MEDIA ─────────────────────────────────────────────────────────

  Future<void> _processMediaMessage(LocalPendingMessage msg) async {
    final encryptedPayloadJson = msg.plaintext; // stored as plaintext field
    final recipientId = msg.recipientId;
    if (encryptedPayloadJson == null || recipientId == null) {
      await _markFailed(msg.id, 'Missing payload or recipientId');
      return;
    }

    try {
      final meta = msg.payloadJson != null
          ? jsonDecode(msg.payloadJson!) as Map<String, dynamic>
          : <String, dynamic>{};
      final isAudio = meta['isAudio'] as bool? ?? false;
      final isDocument = meta['isDocument'] as bool? ?? false;
      final isVideo = meta['isVideo'] as bool? ?? false;

      await _appDatabase.updatePendingMessageStatus(msg.id, 'encrypting');
      final encrypted =
          await _encryptWithFreshnessCheck(recipientId, encryptedPayloadJson);

      final ciphertextStr = encrypted['ciphertext'] as String;
      final ctFingerprint = _ciphertextFingerprint(ciphertextStr);
      try {
        await _appDatabase.cacheDecryptedPlaintext(
            ctFingerprint, encryptedPayloadJson);
      } catch (_) {}

      await _appDatabase.updatePendingMessageStatus(msg.id, 'sending');
      final String msgType;
      if (isAudio) {
        msgType = 'voice';
      } else if (isDocument) {
        msgType = 'document';
      } else if (isVideo) {
        msgType = 'video';
      } else {
        msgType = 'image';
      }
      final messageId = await _conversationRemoteDS.sendEncryptedMessage(
        conversationId: msg.conversationId,
        ciphertext: ciphertextStr,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        x3dhHeader: encrypted['x3dhHeader'] as Map<String, dynamic>?,
        messageType: msgType,
        replyToMessageId: msg.replyToMessageId,
      );

      final MessageType finalType;
      if (isAudio) {
        finalType = MessageType.voice;
      } else if (isDocument) {
        finalType = MessageType.document;
      } else if (isVideo) {
        finalType = MessageType.video;
      } else {
        finalType = MessageType.image;
      }
      await _finalizeSent(
        pendingId: msg.id,
        realMessageId: messageId,
        conversationId: msg.conversationId,
        plaintext: encryptedPayloadJson,
        type: finalType,
        createdAt: msg.createdAt,
      );
    } catch (e) {
      await _markFailed(msg.id, _userFriendlyError(e));
    }
  }

  // ─── COMMUNITY TEXT ─────────────────────────────────────────────────────

  Future<void> _processCommunityTextMessage(LocalPendingMessage msg) async {
    final plaintext = msg.plaintext;
    if (plaintext == null) {
      await _markFailed(msg.id, 'Missing plaintext');
      return;
    }

    final communityId = msg.conversationId;

    try {
      // Ensure sender key is distributed
      // 9.1 + 9.4: Network errors keep message as pending (will retry)
      try {
        await _ensureSenderKeyDistributed(communityId);
      } on SocketException {
        await _resetToPending(msg.id);
        return;
      } on TimeoutException {
        await _resetToPending(msg.id);
        return;
      } on FirebaseFunctionsException catch (e) {
        if (e.code == 'unavailable') {
          await _resetToPending(msg.id);
          return;
        }
        await _markFailed(msg.id, _userFriendlyError(e));
        return;
      } catch (e) {
        if (_isNetworkError(e)) {
          await _resetToPending(msg.id);
          return;
        }
        await _markFailed(
            msg.id, 'Failed to distribute encryption key: ${_userFriendlyError(e)}');
        return;
      }

      // CRIT-1: Check for cached encrypted output from a previous attempt.
      // Re-encryption would ratchet the chain forward again, corrupting
      // state for all recipients.
      Map<String, dynamic> encrypted;
      final cachedPayload = msg.payloadJson;
      if (cachedPayload != null && cachedPayload.startsWith('{"_encrypted"')) {
        try {
          final cached = jsonDecode(cachedPayload) as Map<String, dynamic>;
          encrypted = {
            'ciphertext': cached['ciphertext'] as String,
            'e2ee': cached['e2ee'] as Map<String, dynamic>,
          };
        } catch (_) {
          // Corrupt cache — re-encrypt (unavoidable)
          encrypted = await _encryptAndCache(msg.id, communityId, plaintext);
        }
      } else {
        encrypted = await _encryptAndCache(msg.id, communityId, plaintext);
      }

      await _appDatabase.updatePendingMessageStatus(msg.id, 'sending');
      // H1: Use pending ID as idempotency key to prevent duplicate messages
      // on network retry (Cloud Function deduplicates by this key).
      final messageId =
          await _communityRemoteDS.sendEncryptedCommunityMessage(
        communityId: communityId,
        ciphertext: encrypted['ciphertext'] as String,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        replyToMessageId: msg.replyToMessageId,
        idempotencyKey: msg.id,
      );

      // C1: Cache IMMEDIATELY after getting messageId (before vault retries
      // in _finalizeSent) so CommunitySyncService can find it when the
      // Firestore stream fires.
      _communitySyncService.cacheSentPlaintext(messageId, plaintext);
      try {
        await _appDatabase.cacheDecryptedPlaintext(messageId, plaintext);
      } catch (_) {}

      await _finalizeSent(
        pendingId: msg.id,
        realMessageId: messageId,
        conversationId: communityId,
        plaintext: plaintext,
        type: MessageType.text,
        communityId: communityId,
        createdAt: msg.createdAt,
      );
    } on SocketException {
      await _resetToPending(msg.id);
    } on TimeoutException {
      await _resetToPending(msg.id);
      await _appDatabase.incrementPendingMessageRetry(msg.id);
    } on FirebaseFunctionsException catch (e) {
      if (e.code == 'unavailable') {
        await _resetToPending(msg.id);
        return;
      }
      await _markFailed(msg.id, _userFriendlyError(e));
    } catch (e) {
      if (_isNetworkError(e)) {
        await _resetToPending(msg.id);
        return;
      }
      await _markFailed(msg.id, _userFriendlyError(e));
    }
  }

  // ─── COMMUNITY MEDIA ───────────────────────────────────────────────────

  Future<void> _processCommunityMediaMessage(LocalPendingMessage msg) async {
    final communityId = msg.conversationId;

    try {
      if (msg.payloadJson == null || msg.payloadJson!.isEmpty) {
        await _markFailed(msg.id, 'Missing media payload');
        return;
      }

      // CRIT-1: Check for cached encrypted output from a previous attempt
      final String payload;
      final String mediaTypeStr;
      Map<String, dynamic>? cachedEncrypted;

      final currentPayload = msg.payloadJson!;
      final meta = jsonDecode(currentPayload) as Map<String, dynamic>;

      if (meta.containsKey('_encrypted')) {
        // Previous attempt cached encrypted output — this is a retry.
        // We need the original plaintext payload which was stored before
        // encryption. Use the plaintext field for text-based payloads.
        cachedEncrypted = {
          'ciphertext': meta['ciphertext'] as String,
          'e2ee': meta['e2ee'] as Map<String, dynamic>,
        };
        // Original payload is in the plaintext field (set during _encryptAndCache)
        payload = msg.plaintext ?? currentPayload;
        mediaTypeStr = meta['_mediaType'] as String? ?? 'image';
      } else if (meta.containsKey('mediaUrl')) {
        // OLD FORMAT — build simple payload for legacy messages
        final mediaUrl = meta['mediaUrl'] as String?;
        final mediaType = meta['mediaType'] as String? ?? 'image';
        final caption = meta['caption'] as String?;
        if (mediaUrl == null) {
          await _markFailed(msg.id, 'Missing media URL');
          return;
        }
        payload = jsonEncode({
          if (caption != null) 'text': caption,
          'media': {'url': mediaUrl, 'mediaType': mediaType},
        });
        mediaTypeStr = mediaType;
      } else {
        // NEW FORMAT — payloadJson is the full structured payload from
        // CommunityRepositoryImpl (contains media upload result with keys)
        payload = currentPayload;
        final media = meta['media'] as Map<String, dynamic>?;
        mediaTypeStr = media?['mimeType'] as String? ?? 'image';
      }

      // Ensure sender key is distributed (same as text messages)
      try {
        await _ensureSenderKeyDistributed(communityId);
      } on SocketException {
        await _resetToPending(msg.id);
        return;
      } on TimeoutException {
        await _resetToPending(msg.id);
        return;
      } on FirebaseFunctionsException catch (e) {
        if (e.code == 'unavailable') {
          await _resetToPending(msg.id);
          return;
        }
        await _markFailed(msg.id, _userFriendlyError(e));
        return;
      } catch (e) {
        if (_isNetworkError(e)) {
          await _resetToPending(msg.id);
          return;
        }
        await _markFailed(
            msg.id, 'Failed to distribute encryption key: ${_userFriendlyError(e)}');
        return;
      }

      // CRIT-1: Reuse cached encrypted output or encrypt fresh
      Map<String, dynamic> encrypted;
      if (cachedEncrypted != null) {
        encrypted = cachedEncrypted;
      } else {
        await _appDatabase.updatePendingMessageStatus(msg.id, 'encrypting');
        encrypted = await _senderKeyService
            .encryptCommunity(communityId, payload)
            .timeout(const Duration(seconds: 15), onTimeout: () {
          throw TimeoutException('Encryption timed out');
        });
        // Cache encrypted output for retry safety
        final cacheJson = jsonEncode({
          '_encrypted': true,
          '_mediaType': mediaTypeStr,
          'ciphertext': encrypted['ciphertext'],
          'e2ee': encrypted['e2ee'],
        });
        await ((_appDatabase.update(_appDatabase.localPendingMessages)
              ..where((m) => m.id.equals(msg.id)))
            .write(LocalPendingMessagesCompanion(
          payloadJson: Value(cacheJson),
          // Store original payload in plaintext for recovery
          plaintext: Value(payload),
        )));
      }

      await _appDatabase.updatePendingMessageStatus(msg.id, 'sending');
      // H1: Idempotency key for duplicate prevention on network retry
      final messageId =
          await _communityRemoteDS.sendEncryptedCommunityMessage(
        communityId: communityId,
        ciphertext: encrypted['ciphertext'] as String,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        replyToMessageId: msg.replyToMessageId,
        idempotencyKey: msg.id,
      );

      // C1: Cache IMMEDIATELY after getting messageId (before vault retries)
      _communitySyncService.cacheSentPlaintext(messageId, payload);
      try {
        await _appDatabase.cacheDecryptedPlaintext(messageId, payload);
      } catch (_) {}

      await _finalizeSent(
        pendingId: msg.id,
        realMessageId: messageId,
        conversationId: communityId,
        plaintext: payload,
        type: _inferMessageType(mediaTypeStr),
        communityId: communityId,
        createdAt: msg.createdAt,
      );
    } on SocketException {
      await _resetToPending(msg.id);
    } on TimeoutException {
      await _resetToPending(msg.id);
      await _appDatabase.incrementPendingMessageRetry(msg.id);
    } on FirebaseFunctionsException catch (e) {
      if (e.code == 'unavailable') {
        await _resetToPending(msg.id);
        return;
      }
      await _markFailed(msg.id, _userFriendlyError(e));
    } catch (e) {
      if (_isNetworkError(e)) {
        await _resetToPending(msg.id);
        return;
      }
      await _markFailed(msg.id, _userFriendlyError(e));
    }
  }

  // ─── TOKEN SEND ─────────────────────────────────────────────────────────

  Future<void> _processTokenSend(LocalPendingMessage msg) async {
    final recipientId = msg.recipientId;
    if (recipientId == null) {
      await _markFailed(msg.id, 'Missing recipientId');
      return;
    }

    try {
      final meta = msg.payloadJson != null
          ? jsonDecode(msg.payloadJson!) as Map<String, dynamic>
          : <String, dynamic>{};
      final amount = meta['amount'] as int? ?? 0;
      final message = meta['message'] as String?;
      final subAccountId = meta['senderSubAccountId'] as String?;

      // Encrypt optional message text
      String? encryptedMsg;
      Map<String, dynamic>? msgE2ee;
      Map<String, dynamic>? msgX3dh;
      if (message != null && message.isNotEmpty) {
        await _appDatabase.updatePendingMessageStatus(msg.id, 'encrypting');
        final encrypted =
            await _encryptWithFreshnessCheck(recipientId, message);
        encryptedMsg = encrypted['ciphertext'] as String;
        msgE2ee = encrypted['e2ee'] as Map<String, dynamic>;
        msgX3dh = encrypted['x3dhHeader'] as Map<String, dynamic>?;
      }

      await _appDatabase.updatePendingMessageStatus(msg.id, 'sending');
      final model = await _conversationRemoteDS.sendTokens(
        conversationId: msg.conversationId,
        recipientId: recipientId,
        amount: amount,
        encryptedMessage: encryptedMsg,
        messageE2ee: msgE2ee,
        messageX3dh: msgX3dh,
        subAccountId: subAccountId,
      );

      // Preserve the user's plaintext note on the local entity — the CF
      // response has textContent: null (correct for E2EE) but the local
      // row must keep the decrypted text so the UI continues to show it.
      final sentMessage = (message != null && message.isNotEmpty)
          ? model.toEntity().copyWith(textContent: message)
          : model.toEntity();

      // Cache plaintext if present
      if (message != null && message.isNotEmpty) {
        try {
          await _appDatabase
              .cacheDecryptedPlaintext(sentMessage.id, message);
        } catch (_) {}
      }

      // Replace optimistic with real — atomic to prevent brief duplicate
      _messageSyncService.cacheSentPlaintext(
          sentMessage.id, message ?? '');
      await _appDatabase.transaction(() async {
        await _appDatabase.upsertLocalMessage(
          LocalMessageMapper.toCompanion(sentMessage, msg.conversationId),
        );
        await _appDatabase.deleteLocalMessage(msg.id);
        await _appDatabase.deletePendingMessage(msg.id);
      });
    } catch (e) {
      await _markFailed(msg.id, _userFriendlyError(e));
    }
  }

  // ─── TOKEN REQUEST ──────────────────────────────────────────────────────

  Future<void> _processTokenRequest(LocalPendingMessage msg) async {
    final recipientId = msg.recipientId;
    if (recipientId == null) {
      await _markFailed(msg.id, 'Missing recipientId');
      return;
    }

    try {
      final meta = msg.payloadJson != null
          ? jsonDecode(msg.payloadJson!) as Map<String, dynamic>
          : <String, dynamic>{};
      final amount = meta['amount'] as int? ?? 0;
      final message = meta['message'] as String?;
      final subAccountId = meta['senderSubAccountId'] as String?;

      String? encryptedMsg;
      Map<String, dynamic>? msgE2ee;
      Map<String, dynamic>? msgX3dh;
      if (message != null && message.isNotEmpty) {
        await _appDatabase.updatePendingMessageStatus(msg.id, 'encrypting');
        final encrypted =
            await _encryptWithFreshnessCheck(recipientId, message);
        encryptedMsg = encrypted['ciphertext'] as String;
        msgE2ee = encrypted['e2ee'] as Map<String, dynamic>;
        msgX3dh = encrypted['x3dhHeader'] as Map<String, dynamic>?;
      }

      await _appDatabase.updatePendingMessageStatus(msg.id, 'sending');
      final model = await _conversationRemoteDS.requestTokens(
        conversationId: msg.conversationId,
        recipientId: recipientId,
        amount: amount,
        encryptedMessage: encryptedMsg,
        messageE2ee: msgE2ee,
        messageX3dh: msgX3dh,
        subAccountId: subAccountId,
      );

      // Preserve the user's plaintext note — same as _processTokenSend.
      final sentMessage = (message != null && message.isNotEmpty)
          ? model.toEntity().copyWith(textContent: message)
          : model.toEntity();

      if (message != null && message.isNotEmpty) {
        try {
          await _appDatabase
              .cacheDecryptedPlaintext(sentMessage.id, message);
        } catch (_) {}
      }

      // Replace optimistic with real — atomic to prevent brief duplicate
      _messageSyncService.cacheSentPlaintext(
          sentMessage.id, message ?? '');
      await _appDatabase.transaction(() async {
        await _appDatabase.upsertLocalMessage(
          LocalMessageMapper.toCompanion(sentMessage, msg.conversationId),
        );
        await _appDatabase.deleteLocalMessage(msg.id);
        await _appDatabase.deletePendingMessage(msg.id);
      });
    } catch (e) {
      await _markFailed(msg.id, _userFriendlyError(e));
    }
  }

  // ─── FORWARD ────────────────────────────────────────────────────────────

  Future<void> _processForwardMessage(LocalPendingMessage msg) async {
    try {
      final meta = msg.payloadJson != null
          ? jsonDecode(msg.payloadJson!) as Map<String, dynamic>
          : <String, dynamic>{};
      final sourceConversationId = meta['sourceConversationId'] as String?;
      final sourceMessageId = meta['sourceMessageId'] as String?;
      final targetConversationId = meta['targetConversationId'] as String?;

      if (sourceConversationId == null ||
          sourceMessageId == null ||
          targetConversationId == null) {
        await _markFailed(msg.id, 'Missing forward metadata');
        return;
      }

      String? ciphertext;
      Map<String, dynamic>? e2ee;
      Map<String, dynamic>? x3dhHeader;

      // Re-encrypt plaintext for target conversation
      if (msg.plaintext != null &&
          msg.plaintext!.isNotEmpty &&
          msg.recipientId != null &&
          msg.recipientId!.isNotEmpty) {
        await _appDatabase.updatePendingMessageStatus(msg.id, 'encrypting');
        final encrypted = await _encryptWithFreshnessCheck(
            msg.recipientId!, msg.plaintext!);
        ciphertext = encrypted['ciphertext'] as String;
        e2ee = encrypted['e2ee'] as Map<String, dynamic>;
        x3dhHeader = encrypted['x3dhHeader'] as Map<String, dynamic>?;
      }

      await _appDatabase.updatePendingMessageStatus(msg.id, 'sending');
      final messageId = await _conversationRemoteDS.forwardMessage(
        sourceConversationId: sourceConversationId,
        sourceMessageId: sourceMessageId,
        targetConversationId: targetConversationId,
        ciphertext: ciphertext,
        e2ee: e2ee,
        x3dhHeader: x3dhHeader,
      );

      // Replace optimistic with real — atomic to prevent brief duplicate
      if (msg.plaintext != null) {
        _messageSyncService.cacheSentPlaintext(messageId, msg.plaintext!);
      }
      await _appDatabase.transaction(() async {
        await _appDatabase.deleteLocalMessage(msg.id);
        await _appDatabase.deletePendingMessage(msg.id);
      });
    } catch (e) {
      await _markFailed(msg.id, _userFriendlyError(e));
    }
  }

  // =========================================================================
  // HELPERS
  // =========================================================================

  /// Exponential backoff duration: min(30s, 2^retryCount seconds).
  Duration _backoffDuration(int retryCount) {
    final seconds = math.min(30, math.pow(2, retryCount).toInt());
    return Duration(seconds: seconds);
  }

  /// Whether a failed message is still within its backoff window.
  bool _isInBackoff(LocalPendingMessage msg) {
    if (msg.retryCount == 0 || msg.lastAttemptAt == null) return false;
    final backoff = _backoffDuration(msg.retryCount);
    return DateTime.now().isBefore(msg.lastAttemptAt!.add(backoff));
  }

  /// 9.4 Check exception type rather than string matching for network errors.
  bool _isNetworkError(Object e) {
    if (e is SocketException || e is TimeoutException) return true;
    if (e is FirebaseFunctionsException && e.code == 'unavailable') return true;
    // Fallback string check for wrapped exceptions
    final msg = e.toString().toLowerCase();
    return msg.contains('socketexception') ||
        msg.contains('timeout') ||
        msg.contains('network_error');
  }

  /// Convert raw exceptions to user-facing error messages.
  String _userFriendlyError(Object e) {
    if (e is SocketException || e is TimeoutException) {
      return 'Network error — will retry when connected';
    }
    if (e is FirebaseFunctionsException) {
      if (e.code == 'unavailable') {
        return 'Network error — will retry when connected';
      }
      return e.message ?? 'Server error — will retry automatically';
    }
    final msg = e.toString().toLowerCase();
    if (msg.contains('network') ||
        msg.contains('socket') ||
        msg.contains('timeout')) {
      return 'Network error — will retry when connected';
    }
    if (msg.contains('session') ||
        msg.contains('encrypt') ||
        msg.contains('key')) {
      return 'Encryption error — will retry automatically';
    }
    if (msg.contains('insufficient') || msg.contains('balance')) {
      return 'Insufficient token balance';
    }
    return 'Send failed — will retry automatically';
  }

  /// 9.11 Infer MessageType from MIME type string with logged fallback.
  MessageType _inferMessageType(String mediaTypeStr) {
    if (mediaTypeStr.startsWith('image')) return MessageType.image;
    if (mediaTypeStr.startsWith('video')) return MessageType.video;
    if (mediaTypeStr.startsWith('audio')) return MessageType.voice;
    if (mediaTypeStr == 'document' || mediaTypeStr.startsWith('application')) {
      return MessageType.document;
    }
    // Try matching by enum name
    final match = MessageType.values.where((t) => t.name == mediaTypeStr);
    if (match.isNotEmpty) return match.first;
    debugPrint(
        'OutgoingMessageQueue: Unknown media type "$mediaTypeStr", '
        'defaulting to file/document');
    return MessageType.document;
  }

  /// 9.10 Message status state machine validation.
  /// Valid transitions: pending→encrypting→sending→sent, any→failed, failed→pending (retry).
  static const _validTransitions = <String, Set<String>>{
    'pending': {'encrypting', 'failed'},
    'encrypting': {'sending', 'failed', 'pending'},
    'sending': {'sent', 'failed', 'pending'},
    'failed': {'pending'}, // retry only
  };

  /// Returns true if the status transition is valid.
  static bool isValidTransition(String from, String to) {
    return _validTransitions[from]?.contains(to) ?? false;
  }

  /// Mark a pending message as sent, replacing the optimistic local message
  /// with the real server message.
  Future<void> _finalizeSent({
    required String pendingId,
    required String realMessageId,
    required String conversationId,
    required String plaintext,
    required MessageType type,
    String? communityId,
    DateTime? createdAt,
  }) async {
    // Cache plaintext by real message ID
    // C1: Skip P2P cache for community messages (already cached in CommunitySyncService)
    if (communityId == null) {
      _messageSyncService.cacheSentPlaintext(realMessageId, plaintext);
    }
    try {
      await _appDatabase.cacheDecryptedPlaintext(realMessageId, plaintext);
    } catch (_) {}

    // M3: Store payload in vault fire-and-forget to avoid blocking queue.
    _mediaRecoveryService.storePayload(realMessageId, plaintext).catchError((e) {
      debugPrint('OutgoingMessageQueue: vault store failed: $e');
    });

    // Parse structured payload to extract text and media separately.
    // Media messages store JSON like {"text":"caption", "media":{...}}.
    String? textContent = plaintext;
    MessageMedia? mediaData;
    if (type == MessageType.image || type == MessageType.voice || type == MessageType.document || type == MessageType.video) {
      try {
        final parsed = jsonDecode(plaintext) as Map<String, dynamic>;
        textContent = parsed['text'] as String?;
        if (parsed.containsKey('media')) {
          mediaData = MessageMedia.fromJson(
            parsed['media'] as Map<String, dynamic>,
          );
        }
      } catch (_) {
        // Not valid JSON — keep plaintext as textContent (text-only message)
      }
    }

    // H2: Guard against null currentUserId
    final currentUserId = _conversationRemoteDS.currentUserId;
    if (currentUserId == null) {
      debugPrint('OutgoingMessageQueue: currentUserId is null in _finalizeSent');
      await _markFailed(pendingId, 'Not authenticated');
      return;
    }

    // Replace optimistic message with real one
    final sentMessage = Message(
      id: realMessageId,
      senderId: currentUserId,
      senderName: '',
      type: type,
      status: MessageStatus.sent,
      textContent: textContent,
      media: mediaData,
      communityId: communityId,
      createdAt: createdAt ?? DateTime.now(),
    );

    // H3: Atomically replace the pending message with the real one inside a
    // transaction. Without this, the watch stream fires between the upsert
    // and delete, briefly exposing both pending_xxx and the real message
    // to the UI (visible as a duplicate bubble).
    await _appDatabase.transaction(() async {
      await _appDatabase.upsertLocalMessage(
        LocalMessageMapper.toCompanion(sentMessage, conversationId),
      );
      await _appDatabase.deleteLocalMessage(pendingId);
      await _appDatabase.deletePendingMessage(pendingId);
    });
  }

  /// Mark a pending message as failed and update the optimistic UI.
  /// M2: Does NOT increment retry count — that's only for transient failures.
  Future<void> _markFailed(String pendingId, String error) async {
    debugPrint('OutgoingMessageQueue: Message $pendingId failed: $error');
    await _appDatabase.updatePendingMessageStatus(
      pendingId,
      'failed',
      error: error,
      lastAttemptAt: DateTime.now(),
    );
    // Update the optimistic local message status to failed
    await _appDatabase.updateLocalMessageStatus(pendingId, 'failed');
  }

  /// HIGH-1: Reset message status to pending on network errors.
  /// Ensures messages don't get stuck in 'encrypting' or 'sending' state.
  Future<void> _resetToPending(String pendingId) async {
    await _appDatabase.updatePendingMessageStatus(pendingId, 'pending',
        lastAttemptAt: DateTime.now());
  }

  /// CRIT-1: Encrypt plaintext and cache the encrypted output in the pending
  /// message's payloadJson. On retry, the cached ciphertext is reused to
  /// prevent re-encryption which would ratchet the chain forward again.
  Future<Map<String, dynamic>> _encryptAndCache(
    String pendingId,
    String communityId,
    String plaintext,
  ) async {
    await _appDatabase.updatePendingMessageStatus(pendingId, 'encrypting');
    final encrypted = await _senderKeyService
        .encryptCommunity(communityId, plaintext)
        .timeout(const Duration(seconds: 15), onTimeout: () {
      throw TimeoutException('Encryption timed out');
    });
    // Persist encrypted output so retries don't re-encrypt
    final cacheJson = jsonEncode({
      '_encrypted': true,
      'ciphertext': encrypted['ciphertext'],
      'e2ee': encrypted['e2ee'],
    });
    await ((_appDatabase.update(_appDatabase.localPendingMessages)
          ..where((m) => m.id.equals(pendingId)))
        .write(LocalPendingMessagesCompanion(
      payloadJson: Value(cacheJson),
    )));
    return encrypted;
  }

  /// E2EE encrypt with pre/post identity key freshness check.
  /// Extracted from ConversationRepositoryImpl._encryptWithFreshnessCheck.
  Future<Map<String, dynamic>> _encryptWithFreshnessCheck(
    String recipientId,
    String plaintext,
  ) async {
    // ── Pre-encrypt: reset stale session ──
    String? preEncryptPeerKey;
    try {
      preEncryptPeerKey =
          await _conversationRemoteDS.getUserE2eeIdentityKey(recipientId);
      if (preEncryptPeerKey != null) {
        final isStale = await _signalProtocolService.isPeerKeyStale(
          recipientId,
          preEncryptPeerKey,
        );
        if (isStale) {
          debugPrint('E2EE: Peer $recipientId identity key changed — '
              'resetting stale session for re-establishment');
          await _signalProtocolService.resetSession(recipientId);
        }
      }
    } catch (e) {
      debugPrint('E2EE: Pre-encrypt freshness check failed: $e');
    }

    // ── Encrypt ──
    final preEncryptTime = DateTime.now();
    var encrypted = await _signalProtocolService.encryptP2P(
      recipientId,
      plaintext,
    );

    // ── Post-encrypt: verify key didn't change during encryption ──
    // Only check if encryption took > 5 seconds (enough time for a key
    // rotation to have occurred; skip the redundant network call otherwise).
    final encryptElapsed = DateTime.now().difference(preEncryptTime);
    if (encryptElapsed.inSeconds > 5) {
      try {
        final postEncryptPeerKey =
            await _conversationRemoteDS.getUserE2eeIdentityKey(recipientId);
        if (postEncryptPeerKey != null &&
            preEncryptPeerKey != null &&
            postEncryptPeerKey != preEncryptPeerKey) {
          debugPrint('E2EE: Recipient $recipientId key changed during encrypt '
              '— re-encrypting with fresh bundle');
          await _signalProtocolService.resetSession(recipientId);
          encrypted = await _signalProtocolService.encryptP2P(
            recipientId,
            plaintext,
          );
        }
      } catch (e) {
        debugPrint('E2EE: Post-encrypt freshness check failed: $e');
      }
    }

    return encrypted;
  }

  /// Compute a stable fingerprint from ciphertext for pre-caching plaintext.
  static String _ciphertextFingerprint(String ciphertextBase64) {
    final fpLen = math.min(64, ciphertextBase64.length);
    return 'sent_ct:${ciphertextBase64.substring(0, fpLen)}';
  }

  /// Ensure the sender key for a community has been distributed.
  /// 9.2 Guarded against concurrent calls for the same community.
  Future<void> _ensureSenderKeyDistributed(String communityId) async {
    if (await _senderKeyService.isDistributed(communityId)) return;

    // 9.2 Prevent concurrent distribution for the same community
    if (_distributionInProgress.contains(communityId)) return;
    _distributionInProgress.add(communityId);

    try {
      final hasKey = await _senderKeyService.hasSenderKey(communityId);
      if (!hasKey) {
        await _senderKeyService.generateSenderKey(communityId);
      }

      final members = await _communityRemoteDS.getMembers(communityId);
      // H2: Guard against null currentUserId
      final currentUserId = _communityRemoteDS.currentUserId;
      if (currentUserId == null) {
        throw StateError('Cannot distribute sender key: not authenticated');
      }
      // Only distribute to active members (invited members may not have
      // P2P sessions yet, which would cause distribution to fail and
      // abort the entire message send).
      final otherMemberIds = members
          .where((m) => m.status == 'active' && m.userId != currentUserId)
          .map((m) => m.userId)
          .toList();

      if (otherMemberIds.isNotEmpty) {
        final failures = await _senderKeyService.distributeSenderKeyToAll(
          communityId,
          otherMemberIds,
        );
        // HIGH-2: Don't mark as distributed if some members failed —
        // next message send will retry distribution for all members.
        if (failures.isNotEmpty) {
          debugPrint('OutgoingMessageQueue: Key distribution failed for '
              '${failures.length}/${otherMemberIds.length} member(s) in '
              '$communityId: $failures — will retry next send');
          return; // Don't mark distributed — will retry
        }
      }

      // Mark as distributed so subsequent messages skip distribution
      await _senderKeyService.markDistributed(communityId);
    } finally {
      _distributionInProgress.remove(communityId);
    }
  }

  /// Update P2P conversation preview with latest sent message text.
  Future<void> _updateConversationPreview(
    String conversationId,
    String text,
    DateTime now,
  ) async {
    try {
      final conv = await _appDatabase.getLocalConversation(conversationId);
      if (conv != null) {
        final currentUserId = _conversationRemoteDS.currentUserId ?? '';
        await _appDatabase.updateLocalConversationPreview(
          conversationId: conversationId,
          lastMessageText: text,
          lastMessageSenderId: currentUserId,
          lastMessageAt: now,
        );
      }
    } catch (e) {
      debugPrint('OutgoingMessageQueue: Failed to update preview: $e');
    }
  }

  /// Update community preview with latest sent message text.
  /// 9.9 Uses atomic partial update to avoid read-modify-write race with sync service.
  Future<void> _updateCommunityPreview(
    String communityId,
    String text,
    DateTime now,
  ) async {
    try {
      // M11: Pass senderName so community list tile can show "You: message"
      await _appDatabase.updateLocalCommunityPreview(
        communityId: communityId,
        lastMessageText: text,
        lastMessageSenderId: _conversationRemoteDS.currentUserId ?? '',
        lastMessageSenderName: 'You',
        lastMessageAt: now,
      );
    } catch (e) {
      debugPrint('OutgoingMessageQueue: Failed to update community preview: $e');
    }
  }
}
