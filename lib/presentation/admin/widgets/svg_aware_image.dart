import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/image_resize_utils.dart';

/// Whether [name] ends with `.svg` (case-insensitive).
bool isSvgFileName(String? name) =>
    name != null && name.toLowerCase().endsWith('.svg');

/// Whether [url]'s path component ends with `.svg` (ignores query params).
bool isSvgUrl(String url) {
  final path = Uri.tryParse(url)?.path ?? url;
  return path.toLowerCase().endsWith('.svg');
}

/// Renders an image from [bytes], using [SvgPicture] when [fileName] is `.svg`.
Widget svgAwareMemoryImage(
  Uint8List bytes, {
  String? fileName,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
}) {
  if (isSvgFileName(fileName)) {
    return SvgPicture.memory(bytes, width: width, height: height, fit: fit);
  }
  return Image.memory(bytes, width: width, height: height, fit: fit);
}

/// Renders an image from [url], using [SvgPicture] when the URL path is `.svg`.
Widget svgAwareNetworkImage(
  String url, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
}) {
  if (isSvgUrl(url)) {
    return SvgPicture.network(url, width: width, height: height, fit: fit);
  }
  return Image.network(
    url,
    width: width,
    height: height,
    fit: fit,
    errorBuilder: errorBuilder,
  );
}

/// Allowed image extensions for admin file pickers (includes SVG).
const adminImageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'svg'];

/// Uploads an image to Firebase Storage.
///
/// SVG files are uploaded raw; raster images are resized via [resizeTarget].
/// Returns the download URL.
Future<String> uploadAdminImage({
  required Uint8List bytes,
  required String? fileName,
  required String storagePath,
  required String fileId,
  required ImageResizeTarget resizeTarget,
  void Function(double progress)? onProgress,
}) async {
  final isSvg = isSvgFileName(fileName);
  Uint8List uploadBytes;
  String ext;
  String contentType;

  if (isSvg) {
    uploadBytes = bytes;
    ext = 'svg';
    contentType = 'image/svg+xml';
  } else {
    ResizedImage? resized;
    try {
      resized = resizeImageForUpload(bytes, resizeTarget);
    } catch (e) {
      debugPrint('[uploadAdminImage] Resize threw: $e');
    }

    if (resized != null) {
      uploadBytes = resized.bytes;
      ext = resized.extension;
      contentType = resized.contentType;
    } else if (kIsWeb) {
      // Web fallback: the `image` package can struggle on web.
      // Upload the original bytes with a best-guess content type.
      debugPrint('[uploadAdminImage] Resize failed on web — uploading raw');
      uploadBytes = bytes;
      final lower = (fileName ?? '').toLowerCase();
      if (lower.endsWith('.png')) {
        ext = 'png';
        contentType = 'image/png';
      } else if (lower.endsWith('.webp')) {
        ext = 'webp';
        contentType = 'image/webp';
      } else {
        ext = 'jpg';
        contentType = 'image/jpeg';
      }
    } else {
      throw Exception('Failed to process image');
    }
  }

  final ref = FirebaseStorage.instance
      .ref()
      .child(storagePath)
      .child('$fileId.$ext');

  final uploadTask = ref.putData(
    uploadBytes,
    SettableMetadata(contentType: contentType),
  );

  if (onProgress != null) {
    uploadTask.snapshotEvents.listen((snapshot) {
      onProgress(snapshot.bytesTransferred / snapshot.totalBytes);
    });
  }

  await uploadTask;
  return ref.getDownloadURL();
}
