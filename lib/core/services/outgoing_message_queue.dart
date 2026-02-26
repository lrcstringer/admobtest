import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

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

  StreamSubscription<bool>? _connectivitySub;
  bool _isProcessing = false;

  OutgoingMessageQueue(
    this._appDatabase,
    this._networkInfo,
    this._conversationRemoteDS,
    this._communityRemoteDS,
    this._signalProtocolService,
    this._senderKeyService,
    this._messageSyncService,
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
      })),
      status: const Value('pending'),
      createdAt: Value(now),
    ));

    final optimistic = Message(
      id: id,
      senderId: _conversationRemoteDS.currentUserId ?? '',
      senderName: '',
      type: isAudio ? MessageType.voice : MessageType.image,
      status: MessageStatus.sending,
      textContent: caption,
      createdAt: now,
    );
    await _appDatabase.upsertLocalMessage(
      LocalMessageMapper.toCompanion(optimistic, conversationId),
    );

    await _updateConversationPreview(
      conversationId,
      isAudio ? '🎙 Voice message' : '📷 Photo',
      now,
    );

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
    required String mediaUrl,
    required String mediaType,
    String? caption,
  }) async {
    final id = 'pending_${_uuid.v4()}';
    final now = DateTime.now();

    await _appDatabase.insertPendingMessage(LocalPendingMessagesCompanion(
      id: Value(id),
      conversationId: Value(communityId),
      type: const Value('community_media'),
      plaintext: Value(caption),
      payloadJson: Value(jsonEncode({
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
        'caption': caption,
      })),
      status: const Value('pending'),
      createdAt: Value(now),
    ));

    final optimistic = Message(
      id: id,
      senderId: _conversationRemoteDS.currentUserId ?? '',
      senderName: '',
      type: MessageType.image,
      status: MessageStatus.sending,
      textContent: caption,
      communityId: communityId,
      createdAt: now,
    );
    await _appDatabase.upsertLocalMessage(
      LocalMessageMapper.toCompanion(optimistic, communityId),
    );

    await _updateCommunityPreview(communityId, caption ?? '📷 Photo', now);

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
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final pending = await _appDatabase.getPendingMessages();
      if (pending.isEmpty) return;

      debugPrint(
          'OutgoingMessageQueue: Processing ${pending.length} pending messages');

      DateTime? earliestRetry;
      for (final msg in pending) {
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

      // Schedule a delayed re-drain for the earliest backed-off message
      if (earliestRetry != null) {
        final delay = earliestRetry.difference(DateTime.now());
        if (delay > Duration.zero) {
          Future.delayed(delay, () => _processNextPending());
        }
      }
    } finally {
      _isProcessing = false;
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
      final msgType = isAudio ? 'voice' : 'image';
      final messageId = await _conversationRemoteDS.sendEncryptedMessage(
        conversationId: msg.conversationId,
        ciphertext: ciphertextStr,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        x3dhHeader: encrypted['x3dhHeader'] as Map<String, dynamic>?,
        messageType: msgType,
        replyToMessageId: msg.replyToMessageId,
      );

      await _finalizeSent(
        pendingId: msg.id,
        realMessageId: messageId,
        conversationId: msg.conversationId,
        plaintext: encryptedPayloadJson,
        type: isAudio ? MessageType.voice : MessageType.image,
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
      try {
        await _ensureSenderKeyDistributed(communityId);
      } catch (e) {
        await _markFailed(
            msg.id, 'Waiting for connection to distribute encryption key');
        return;
      }

      await _appDatabase.updatePendingMessageStatus(msg.id, 'encrypting');
      final encrypted = await _senderKeyService.encryptCommunity(
        communityId,
        plaintext,
      );

      await _appDatabase.updatePendingMessageStatus(msg.id, 'sending');
      final messageId =
          await _communityRemoteDS.sendEncryptedCommunityMessage(
        communityId: communityId,
        ciphertext: encrypted['ciphertext'] as String,
        e2ee: encrypted['e2ee'] as Map<String, dynamic>,
        replyToMessageId: msg.replyToMessageId,
      );

      // Cache for community sync service
      _messageSyncService.cacheSentPlaintext(messageId, plaintext);

      await _finalizeSent(
        pendingId: msg.id,
        realMessageId: messageId,
        conversationId: communityId,
        plaintext: plaintext,
        type: MessageType.text,
        communityId: communityId,
        createdAt: msg.createdAt,
      );
    } catch (e) {
      await _markFailed(msg.id, _userFriendlyError(e));
    }
  }

  // ─── COMMUNITY MEDIA ───────────────────────────────────────────────────

  Future<void> _processCommunityMediaMessage(LocalPendingMessage msg) async {
    final communityId = msg.conversationId;

    try {
      final meta = msg.payloadJson != null
          ? jsonDecode(msg.payloadJson!) as Map<String, dynamic>
          : <String, dynamic>{};
      final mediaUrl = meta['mediaUrl'] as String?;
      final mediaType = meta['mediaType'] as String? ?? 'image';
      final caption = meta['caption'] as String?;

      if (mediaUrl == null) {
        await _markFailed(msg.id, 'Missing media URL');
        return;
      }

      await _appDatabase.updatePendingMessageStatus(msg.id, 'sending');
      final model = await _communityRemoteDS.sendMediaMessage(
        communityId: communityId,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
        caption: caption,
      );

      final sentMessage = model.toEntity();
      // Replace optimistic with real
      await _appDatabase.deleteLocalMessage(msg.id);
      await _appDatabase.upsertLocalMessage(
        LocalMessageMapper.toCompanion(sentMessage, communityId),
      );
      await _appDatabase.deletePendingMessage(msg.id);
    } catch (e) {
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
      );

      final sentMessage = model.toEntity();
      // Cache plaintext if present
      if (message != null && message.isNotEmpty) {
        try {
          await _appDatabase
              .cacheDecryptedPlaintext(sentMessage.id, message);
        } catch (_) {}
      }

      // Replace optimistic with real
      await _appDatabase.deleteLocalMessage(msg.id);
      await _appDatabase.upsertLocalMessage(
        LocalMessageMapper.toCompanion(sentMessage, msg.conversationId),
      );
      _messageSyncService.cacheSentPlaintext(
          sentMessage.id, message ?? '');
      await _appDatabase.deletePendingMessage(msg.id);
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
      );

      final sentMessage = model.toEntity();
      if (message != null && message.isNotEmpty) {
        try {
          await _appDatabase
              .cacheDecryptedPlaintext(sentMessage.id, message);
        } catch (_) {}
      }

      await _appDatabase.deleteLocalMessage(msg.id);
      await _appDatabase.upsertLocalMessage(
        LocalMessageMapper.toCompanion(sentMessage, msg.conversationId),
      );
      _messageSyncService.cacheSentPlaintext(
          sentMessage.id, message ?? '');
      await _appDatabase.deletePendingMessage(msg.id);
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

      // Replace optimistic with real
      if (msg.plaintext != null) {
        _messageSyncService.cacheSentPlaintext(messageId, msg.plaintext!);
      }
      await _appDatabase.deleteLocalMessage(msg.id);
      await _appDatabase.deletePendingMessage(msg.id);
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

  /// Convert raw exceptions to user-facing error messages.
  String _userFriendlyError(Object e) {
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
    _messageSyncService.cacheSentPlaintext(realMessageId, plaintext);
    try {
      await _appDatabase.cacheDecryptedPlaintext(realMessageId, plaintext);
    } catch (_) {}

    // Replace optimistic message with real one
    final sentMessage = Message(
      id: realMessageId,
      senderId: _conversationRemoteDS.currentUserId ?? '',
      senderName: '',
      type: type,
      status: MessageStatus.sent,
      textContent: plaintext,
      communityId: communityId,
      createdAt: createdAt ?? DateTime.now(),
    );

    await _appDatabase.deleteLocalMessage(pendingId);
    await _appDatabase.upsertLocalMessage(
      LocalMessageMapper.toCompanion(sentMessage, conversationId),
    );
    await _appDatabase.deletePendingMessage(pendingId);
  }

  /// Mark a pending message as failed and update the optimistic UI.
  Future<void> _markFailed(String pendingId, String error) async {
    debugPrint('OutgoingMessageQueue: Message $pendingId failed: $error');
    await _appDatabase.updatePendingMessageStatus(
      pendingId,
      'failed',
      error: error,
      lastAttemptAt: DateTime.now(),
    );
    await _appDatabase.incrementPendingMessageRetry(pendingId);
    // Update the optimistic local message status to failed
    await _appDatabase.updateLocalMessageStatus(pendingId, 'failed');
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
  Future<void> _ensureSenderKeyDistributed(String communityId) async {
    if (await _senderKeyService.isDistributed(communityId)) return;

    final hasKey = await _senderKeyService.hasSenderKey(communityId);
    if (!hasKey) {
      await _senderKeyService.generateSenderKey(communityId);
    }

    final members = await _communityRemoteDS.getMembers(communityId);
    final currentUserId = _communityRemoteDS.currentUserId;
    final otherMemberIds = members
        .map((m) => m.userId)
        .where((id) => id != currentUserId)
        .toList();

    if (otherMemberIds.isNotEmpty) {
      await _senderKeyService.distributeSenderKeyToAll(
        communityId,
        otherMemberIds,
      );
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
  Future<void> _updateCommunityPreview(
    String communityId,
    String text,
    DateTime now,
  ) async {
    try {
      final community = await _appDatabase.getLocalCommunity(communityId);
      if (community != null) {
        await _appDatabase.upsertLocalCommunity(LocalCommunitiesCompanion(
          id: Value(community.id),
          type: Value(community.type),
          name: Value(community.name),
          description: Value(community.description),
          avatarUrl: Value(community.avatarUrl),
          ownerId: Value(community.ownerId),
          memberIdsJson: Value(community.memberIdsJson),
          adminIdsJson: Value(community.adminIdsJson),
          memberCount: Value(community.memberCount),
          totalBalance: Value(community.totalBalance),
          status: Value(community.status),
          settingsJson: Value(community.settingsJson),
          stokvelSettingsJson: Value(community.stokvelSettingsJson),
          lastMessageText: Value(text),
          lastMessageSenderId:
              Value(_conversationRemoteDS.currentUserId ?? ''),
          lastMessageSenderName: const Value(''),
          lastMessageType: const Value('text'),
          lastMessageAt: Value(now),
          unreadCountsJson: Value(community.unreadCountsJson),
          mutedJson: Value(community.mutedJson),
          encryptedPreviewsJson: Value(community.encryptedPreviewsJson),
          createdAt: Value(community.createdAt),
          updatedAt: Value(now),
        ));
      }
    } catch (e) {
      debugPrint('OutgoingMessageQueue: Failed to update community preview: $e');
    }
  }
}
