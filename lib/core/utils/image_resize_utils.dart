import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ResizedImage {
  final Uint8List bytes;
  final String extension; // always 'jpg'
  final String contentType; // always 'image/jpeg'
  const ResizedImage({
    required this.bytes,
    required this.extension,
    required this.contentType,
  });
}

enum ImageResizeTarget {
  clientLogo(200, 200),
  threadImage(400, 400),
  opportunityImage(600, 400),
  featuredImage(800, 400, crop: false);

  final int width, height;
  final bool crop;
  const ImageResizeTarget(this.width, this.height, {this.crop = true});

  bool get isSquare => width == height;
}

/// Decodes [rawBytes] (any supported format), resizes/crops to [target]
/// dimensions, and re-encodes as JPEG quality 85.
///
/// Returns `null` if the image cannot be decoded.
ResizedImage? resizeImageForUpload(Uint8List rawBytes, ImageResizeTarget target) {
  final decoded = img.decodeImage(rawBytes);
  if (decoded == null) return null;

  img.Image resized;

  if (target.isSquare) {
    // Square crop: scale so the shorter side matches, then center-crop
    resized = img.copyResizeCropSquare(decoded, size: target.width);
  } else if (!target.crop) {
    // Fit within bounds — scale down preserving aspect ratio, no cropping.
    // Only downscale; if already smaller, keep original dimensions.
    if (decoded.width <= target.width && decoded.height <= target.height) {
      resized = decoded;
    } else {
      final scaleX = target.width / decoded.width;
      final scaleY = target.height / decoded.height;
      final scale = scaleX < scaleY ? scaleX : scaleY;
      resized = img.copyResize(
        decoded,
        width: (decoded.width * scale).round(),
        height: (decoded.height * scale).round(),
        interpolation: img.Interpolation.linear,
      );
    }
  } else {
    // Non-square with crop: scale-to-cover then center-crop
    final srcAspect = decoded.width / decoded.height;
    final targetAspect = target.width / target.height;

    int scaledWidth, scaledHeight;
    if (srcAspect > targetAspect) {
      // Source is wider — fit height, crop width
      scaledHeight = target.height;
      scaledWidth = (decoded.width * target.height / decoded.height).round();
    } else {
      // Source is taller — fit width, crop height
      scaledWidth = target.width;
      scaledHeight = (decoded.height * target.width / decoded.width).round();
    }

    final scaled = img.copyResize(
      decoded,
      width: scaledWidth,
      height: scaledHeight,
      interpolation: img.Interpolation.linear,
    );

    // Center-crop to exact target dimensions
    final x = ((scaledWidth - target.width) / 2).round();
    final y = ((scaledHeight - target.height) / 2).round();
    resized = img.copyCrop(
      scaled,
      x: x,
      y: y,
      width: target.width,
      height: target.height,
    );
  }

  final jpegBytes = img.encodeJpg(resized, quality: 85);

  return ResizedImage(
    bytes: Uint8List.fromList(jpegBytes),
    extension: 'jpg',
    contentType: 'image/jpeg',
  );
}
