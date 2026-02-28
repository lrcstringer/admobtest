import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';

import '../../../core/di/injection.dart';
import '../../../data/datasources/remote/media_upload_datasource.dart';
import '../../theme/app_colors.dart';

/// Full-screen pinch-to-zoom image viewer.
///
/// Supports both encrypted (E2EE) and plain network images.
/// Uses Hero animation from the message bubble.
class ImageViewerScreen extends StatefulWidget {
  final String messageId;
  final String imageUrl;
  final String? mediaKeyBase64;

  const ImageViewerScreen({
    super.key,
    required this.messageId,
    required this.imageUrl,
    this.mediaKeyBase64,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  Uint8List? _decryptedBytes;
  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;

  bool get _isEncrypted =>
      widget.mediaKeyBase64 != null && widget.mediaKeyBase64!.isNotEmpty;

  /// Image is ready to save (loaded or plain network image).
  bool get _canSave =>
      !_isLoading && _error == null && (!_isEncrypted || _decryptedBytes != null);

  @override
  void initState() {
    super.initState();
    if (_isEncrypted) {
      _loadEncryptedImage();
    }
  }

  Future<void> _loadEncryptedImage() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final datasource = getIt<MediaUploadDatasource>();
      final bytes = await datasource.downloadAndDecrypt(
        url: widget.imageUrl,
        mediaKeyBase64: widget.mediaKeyBase64!,
      );
      if (mounted) {
        setState(() {
          _decryptedBytes = bytes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load image';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _saveToGallery() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      final Uint8List bytes;
      if (_isEncrypted && _decryptedBytes != null) {
        bytes = _decryptedBytes!;
      } else if (!_isEncrypted) {
        // Plain network image — download the bytes
        final client = HttpClient();
        final request = await client.getUrl(Uri.parse(widget.imageUrl));
        final response = await request.close();
        final builder = BytesBuilder();
        await for (final chunk in response) {
          builder.add(chunk);
        }
        bytes = builder.toBytes();
        client.close();
      } else {
        return;
      }

      // Write to temp file for Gal
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/save_${widget.messageId}.jpg');
      await file.writeAsBytes(bytes);

      await Gal.putImage(file.path, album: 'iMaliChat');
      await file.delete().catchError((_) => file);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Saved to gallery'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save image'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xCC000000), // 80% black at top
                Color(0x00000000), // transparent at bottom
              ],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              if (_canSave)
                IconButton(
                  icon: _isSaving
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.download),
                  onPressed: _isSaving ? null : _saveToGallery,
                  tooltip: 'Save to gallery',
                ),
            ],
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image, size: 64, color: AppColors.textHint),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _loadEncryptedImage,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final ImageProvider imageProvider;
    if (_isEncrypted && _decryptedBytes != null) {
      imageProvider = MemoryImage(_decryptedBytes!);
    } else if (!_isEncrypted) {
      imageProvider = NetworkImage(widget.imageUrl);
    } else {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Hero(
      tag: 'image_${widget.messageId}',
      child: PhotoView(
        imageProvider: imageProvider,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3,
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image, size: 64, color: AppColors.textHint),
        ),
      ),
    );
  }
}
