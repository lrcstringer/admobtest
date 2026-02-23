import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Dark charcoal background with a subtle WhatsApp-style doodle pattern.
///
/// Used on conversation list, conversation detail, and message requests screens
/// to give a professional, premium feel that makes chat content pop.
class ChatBackground extends StatelessWidget {
  const ChatBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.chatBackground,
      child: CustomPaint(
        painter: _DoodlePainter(),
        size: Size.infinite,
      ),
    );
  }
}

/// Paints a repeating grid of faint chat-themed doodle shapes.
///
/// Each cell in the grid draws a deterministic (position-seeded) icon from a
/// small vocabulary of chat-related shapes: speech bubbles, smileys, hearts,
/// stars, phones, envelopes, etc. The shapes are drawn at very low opacity
/// (~4-6%) so they add texture without competing with content.
class _DoodlePainter extends CustomPainter {
  static const double _cellSize = 64.0;
  static const double _iconSize = 18.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.chatDoodle
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    final cols = (size.width / _cellSize).ceil() + 1;
    final rows = (size.height / _cellSize).ceil() + 1;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        // Offset every other row for a more organic feel
        final xOffset = (row.isOdd) ? _cellSize * 0.5 : 0.0;
        final cx = col * _cellSize + xOffset + _cellSize * 0.5;
        final cy = row * _cellSize + _cellSize * 0.5;

        // Deterministic "random" rotation per cell
        final seed = (row * 137 + col * 251) % 360;
        final angle = seed * math.pi / 180.0;
        final shapeIndex = (row * 31 + col * 17) % 9;

        canvas.save();
        canvas.translate(cx, cy);
        canvas.rotate(angle);
        _drawShape(canvas, paint, shapeIndex);
        canvas.restore();
      }
    }
  }

  void _drawShape(Canvas canvas, Paint paint, int index) {
    final half = _iconSize / 2;

    switch (index) {
      case 0:
        // Speech bubble
        final path = Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: _iconSize, height: _iconSize * 0.75),
            const Radius.circular(4),
          ))
          ..moveTo(-half * 0.3, _iconSize * 0.375)
          ..lineTo(-half * 0.1, _iconSize * 0.55)
          ..lineTo(half * 0.15, _iconSize * 0.375);
        canvas.drawPath(path, paint);
        break;

      case 1:
        // Smiley face
        canvas.drawCircle(Offset.zero, half, paint);
        // Eyes
        canvas.drawCircle(Offset(-half * 0.35, -half * 0.2), 1.2, paint..style = PaintingStyle.fill);
        canvas.drawCircle(Offset(half * 0.35, -half * 0.2), 1.2, paint..style = PaintingStyle.fill);
        paint.style = PaintingStyle.stroke;
        // Smile arc
        final smilePath = Path()
          ..addArc(
            Rect.fromCenter(center: Offset(0, half * 0.1), width: half, height: half * 0.6),
            0.2,
            math.pi - 0.4,
          );
        canvas.drawPath(smilePath, paint);
        break;

      case 2:
        // Heart
        final path = Path();
        path.moveTo(0, half * 0.4);
        path.cubicTo(-half, -half * 0.3, -half * 0.5, -half, 0, -half * 0.5);
        path.cubicTo(half * 0.5, -half, half, -half * 0.3, 0, half * 0.4);
        canvas.drawPath(path, paint);
        break;

      case 3:
        // Star (5-point)
        final path = Path();
        for (int i = 0; i < 5; i++) {
          final outerAngle = (i * 72 - 90) * math.pi / 180;
          final innerAngle = ((i * 72) + 36 - 90) * math.pi / 180;
          final ox = half * math.cos(outerAngle);
          final oy = half * math.sin(outerAngle);
          final ix = half * 0.4 * math.cos(innerAngle);
          final iy = half * 0.4 * math.sin(innerAngle);
          if (i == 0) {
            path.moveTo(ox, oy);
          } else {
            path.lineTo(ox, oy);
          }
          path.lineTo(ix, iy);
        }
        path.close();
        canvas.drawPath(path, paint);
        break;

      case 4:
        // Envelope / mail
        final rect = Rect.fromCenter(center: Offset.zero, width: _iconSize, height: _iconSize * 0.7);
        canvas.drawRect(rect, paint);
        // Flap
        canvas.drawLine(Offset(-half, -_iconSize * 0.35), Offset.zero, paint);
        canvas.drawLine(Offset(half, -_iconSize * 0.35), Offset.zero, paint);
        break;

      case 5:
        // Token / coin circle with iM
        canvas.drawCircle(Offset.zero, half, paint);
        // Inner circle
        canvas.drawCircle(Offset.zero, half * 0.7, paint);
        break;

      case 6:
        // Phone
        final path = Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: _iconSize * 0.55, height: _iconSize),
            const Radius.circular(3),
          ));
        canvas.drawPath(path, paint);
        // Screen line
        canvas.drawLine(
          Offset(-_iconSize * 0.2, half * 0.65),
          Offset(_iconSize * 0.2, half * 0.65),
          paint,
        );
        break;

      case 7:
        // Music note
        canvas.drawLine(Offset(half * 0.3, -half), Offset(half * 0.3, half * 0.5), paint);
        canvas.drawCircle(Offset(0, half * 0.5), half * 0.35, paint);
        // Flag
        canvas.drawLine(Offset(half * 0.3, -half), Offset(half * 0.8, -half * 0.6), paint);
        canvas.drawLine(Offset(half * 0.8, -half * 0.6), Offset(half * 0.3, -half * 0.3), paint);
        break;

      case 8:
        // Camera
        final body = RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(0, half * 0.15), width: _iconSize, height: _iconSize * 0.65),
          const Radius.circular(3),
        );
        canvas.drawRRect(body, paint);
        canvas.drawCircle(Offset(0, half * 0.15), half * 0.3, paint);
        // Lens bump
        canvas.drawLine(
          Offset(-half * 0.3, -_iconSize * 0.17),
          Offset(half * 0.3, -_iconSize * 0.17),
          paint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
