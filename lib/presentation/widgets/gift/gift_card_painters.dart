import 'dart:math';

import 'package:flutter/material.dart';

import '../../../domain/enums/gift_style.dart';
import '../../theme/app_colors.dart';

/// Style-specific color palettes for rich multi-color gradients.
class GiftStyleColors {
  final List<Color> gradient;
  final Color accent1;
  final Color accent2;
  final Color iconColor;

  const GiftStyleColors({
    required this.gradient,
    required this.accent1,
    required this.accent2,
    required this.iconColor,
  });

  static GiftStyleColors forStyle(GiftStyle style) => switch (style) {
        GiftStyle.celebration => const GiftStyleColors(
            gradient: [Color(0xFFFFB82C), Color(0xFFFF6429), Color(0xFFFF328C)],
            accent1: Color(0xFFFFE066),
            accent2: Color(0xFFFF8A5C),
            iconColor: AppColors.gold,
          ),
        GiftStyle.birthday => const GiftStyleColors(
            gradient: [Color(0xFFFF328C), Color(0xFFA011FF), Color(0xFF08C2F4)],
            accent1: Color(0xFFFF5CA3),
            accent2: Color(0xFF40D1F7),
            iconColor: AppColors.primary,
          ),
        GiftStyle.love => const GiftStyleColors(
            gradient: [Color(0xFFFF1744), Color(0xFFFF328C), Color(0xFFFFB3C1)],
            accent1: Color(0xFFFF6B8A),
            accent2: Color(0xFFFFD6E0),
            iconColor: Color(0xFFFF1744),
          ),
        GiftStyle.ndlovukazi => const GiftStyleColors(
            gradient: [Color(0xFF7B1FA2), Color(0xFFA011FF), Color(0xFFFFB82C)],
            accent1: Color(0xFFCE93D8),
            accent2: Color(0xFFFFCC66),
            iconColor: AppColors.purple,
          ),
        GiftStyle.professional => const GiftStyleColors(
            gradient: [Color(0xFF37474F), Color(0xFF546E7A), Color(0xFF78909C)],
            accent1: Color(0xFF90A4AE),
            accent2: Color(0xFF607D8B),
            iconColor: AppColors.textTertiary,
          ),
      };
}

/// Celebration card decorator: scattered confetti dots, star bursts, streamers.
class CelebrationPainter extends CustomPainter {
  final double opacity;
  static final _rng = Random(42);
  static final _confetti = List.generate(18, (_) => (
        x: _rng.nextDouble(),
        y: _rng.nextDouble(),
        size: 2.0 + _rng.nextDouble() * 4.0,
        rotation: _rng.nextDouble() * pi * 2,
        colorIdx: _rng.nextInt(4),
      ));

  CelebrationPainter({this.opacity = 1.0});

  static const _colors = [
    Color(0xFFFFE066), // bright yellow
    Color(0xFFFF6429), // orange
    Color(0xFFFF328C), // pink
    Color(0xFF08C2F4), // cyan
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final c in _confetti) {
      final paint = Paint()
        ..color = _colors[c.colorIdx].withValues(alpha: 0.6 * opacity);
      final x = c.x * size.width;
      final y = c.y * size.height;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(c.rotation);
      // Draw a small rectangle (confetti piece)
      canvas.drawRect(
        Rect.fromCenter(
            center: Offset.zero, width: c.size, height: c.size * 0.5),
        paint,
      );
      canvas.restore();
    }

    // Draw a few star bursts
    _drawStarBurst(canvas, Offset(size.width * 0.15, size.height * 0.2), 6,
        _colors[0].withValues(alpha: 0.4 * opacity));
    _drawStarBurst(canvas, Offset(size.width * 0.85, size.height * 0.35), 5,
        _colors[2].withValues(alpha: 0.35 * opacity));
    _drawStarBurst(canvas, Offset(size.width * 0.7, size.height * 0.8), 4,
        _colors[3].withValues(alpha: 0.3 * opacity));
  }

  void _drawStarBurst(Canvas canvas, Offset center, double radius, Color c) {
    final paint = Paint()
      ..color = c
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 6; i++) {
      final angle = (pi * 2 / 6) * i;
      final end =
          center + Offset(cos(angle) * radius, sin(angle) * radius);
      canvas.drawLine(center, end, paint);
    }
    canvas.drawCircle(center, 1.5, Paint()..color = c);
  }

  @override
  bool shouldRepaint(CelebrationPainter old) => old.opacity != opacity;
}

/// Birthday card decorator: floating balloons and streamers.
class BirthdayPainter extends CustomPainter {
  final double opacity;
  static final _rng = Random(77);
  static final _balloons = List.generate(8, (_) => (
        x: _rng.nextDouble(),
        y: 0.05 + _rng.nextDouble() * 0.9,
        radius: 5.0 + _rng.nextDouble() * 7.0,
        colorIdx: _rng.nextInt(4),
      ));

  BirthdayPainter({this.opacity = 1.0});

  static const _colors = [
    Color(0xFFFF328C), // hot pink
    Color(0xFFA011FF), // purple
    Color(0xFF08C2F4), // cyan
    Color(0xFFFFB82C), // gold
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final b in _balloons) {
      final color = _colors[b.colorIdx].withValues(alpha: 0.45 * opacity);
      final x = b.x * size.width;
      final y = b.y * size.height;
      final r = b.radius;

      // Balloon body (oval)
      final paint = Paint()..color = color;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(x, y), width: r * 2, height: r * 2.4),
        paint,
      );

      // Balloon knot
      canvas.drawCircle(Offset(x, y + r * 1.2), 1.5, paint);

      // String
      final stringPaint = Paint()
        ..color = color.withValues(alpha: 0.3 * opacity)
        ..strokeWidth = 0.8
        ..style = PaintingStyle.stroke;
      final path = Path()
        ..moveTo(x, y + r * 1.4)
        ..quadraticBezierTo(x + 3, y + r * 1.4 + 8, x - 2, y + r * 1.4 + 16);
      canvas.drawPath(path, stringPaint);

      // Highlight spot on balloon
      canvas.drawCircle(
        Offset(x - r * 0.3, y - r * 0.4),
        r * 0.25,
        Paint()..color = Colors.white.withValues(alpha: 0.3 * opacity),
      );
    }
  }

  @override
  bool shouldRepaint(BirthdayPainter old) => old.opacity != opacity;
}

/// Love card decorator: scattered hearts of varying sizes.
class LovePainter extends CustomPainter {
  final double opacity;
  static final _rng = Random(99);
  static final _hearts = List.generate(14, (_) => (
        x: _rng.nextDouble(),
        y: _rng.nextDouble(),
        size: 4.0 + _rng.nextDouble() * 8.0,
        rotation: (_rng.nextDouble() - 0.5) * 0.6,
        filled: _rng.nextBool(),
        alpha: 0.2 + _rng.nextDouble() * 0.4,
      ));

  LovePainter({this.opacity = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    for (final h in _hearts) {
      final x = h.x * size.width;
      final y = h.y * size.height;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(h.rotation);

      final color = Color.lerp(
        const Color(0xFFFF1744),
        const Color(0xFFFF80AB),
        h.alpha,
      )!
          .withValues(alpha: h.alpha * opacity);

      final heartPath = _heartPath(h.size);

      if (h.filled) {
        canvas.drawPath(heartPath, Paint()..color = color);
      } else {
        canvas.drawPath(
          heartPath,
          Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0,
        );
      }

      canvas.restore();
    }
  }

  Path _heartPath(double size) {
    final s = size;
    return Path()
      ..moveTo(0, s * 0.3)
      ..cubicTo(-s * 0.5, -s * 0.3, -s, s * 0.1, 0, s)
      ..cubicTo(s, s * 0.1, s * 0.5, -s * 0.3, 0, s * 0.3)
      ..close();
  }

  @override
  bool shouldRepaint(LovePainter old) => old.opacity != opacity;
}

/// Ndlovukazi card decorator: sparkles and shimmer dots.
class NdlovukaziPainter extends CustomPainter {
  final double opacity;
  static final _rng = Random(13);
  static final _sparkles = List.generate(12, (_) => (
        x: _rng.nextDouble(),
        y: _rng.nextDouble(),
        size: 2.0 + _rng.nextDouble() * 4.0,
        isGold: _rng.nextBool(),
      ));

  NdlovukaziPainter({this.opacity = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in _sparkles) {
      final x = s.x * size.width;
      final y = s.y * size.height;
      final color = s.isGold
          ? const Color(0xFFFFCC66).withValues(alpha: 0.5 * opacity)
          : const Color(0xFFCE93D8).withValues(alpha: 0.4 * opacity);

      _drawFourPointStar(canvas, Offset(x, y), s.size, color);
    }
  }

  void _drawFourPointStar(
      Canvas canvas, Offset center, double size, Color color) {
    final paint = Paint()..color = color;
    final path = Path();
    for (int i = 0; i < 4; i++) {
      final angle = (pi / 2) * i - pi / 2;
      final outerX = center.dx + cos(angle) * size;
      final outerY = center.dy + sin(angle) * size;
      final innerAngle = angle + pi / 4;
      final innerX = center.dx + cos(innerAngle) * size * 0.35;
      final innerY = center.dy + sin(innerAngle) * size * 0.35;

      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      path.lineTo(innerX, innerY);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(NdlovukaziPainter old) => old.opacity != opacity;
}

/// Returns the appropriate style decorator painter.
CustomPainter? giftStylePainter(GiftStyle style, {double opacity = 1.0}) =>
    switch (style) {
      GiftStyle.celebration => CelebrationPainter(opacity: opacity),
      GiftStyle.birthday => BirthdayPainter(opacity: opacity),
      GiftStyle.love => LovePainter(opacity: opacity),
      GiftStyle.ndlovukazi => NdlovukaziPainter(opacity: opacity),
      GiftStyle.professional => null, // intentionally plain
    };

/// Style-specific animated particle painter for the opening dialog.
/// Used instead of the generic confetti for Celebration/Birthday/Love.
CustomPainter giftRevealPainter(
  GiftStyle style, {
  required double progress,
  required Color color,
}) =>
    switch (style) {
      GiftStyle.love => _FallingHeartsPainter(progress: progress),
      GiftStyle.birthday => _RisingBalloonsPainter(progress: progress),
      _ => _RichConfettiPainter(progress: progress, style: style),
    };

/// Love reveal: hearts floating upward.
class _FallingHeartsPainter extends CustomPainter {
  final double progress;
  static final _hearts = List.generate(25, (i) {
    final r = Random(i * 17 + 3);
    return (
      x: r.nextDouble(),
      speed: 0.4 + r.nextDouble() * 0.6,
      size: 6.0 + r.nextDouble() * 12.0,
      wobble: r.nextDouble() * pi * 2,
      alpha: 0.4 + r.nextDouble() * 0.5,
    );
  });

  _FallingHeartsPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final fade = (1.0 - progress).clamp(0.0, 1.0);

    for (final h in _hearts) {
      final baseX = h.x * size.width;
      final wobbleX = sin(progress * pi * 3 + h.wobble) * 15;
      final x = baseX + wobbleX;
      final y = size.height * (1.0 - progress * h.speed);
      final opacity = fade * h.alpha;

      final color = Color.lerp(
        const Color(0xFFFF1744),
        const Color(0xFFFF80AB),
        h.alpha,
      )!
          .withValues(alpha: opacity);

      canvas.save();
      canvas.translate(x, y);
      final s = h.size;
      final path = Path()
        ..moveTo(0, s * 0.3)
        ..cubicTo(-s * 0.5, -s * 0.3, -s, s * 0.1, 0, s)
        ..cubicTo(s, s * 0.1, s * 0.5, -s * 0.3, 0, s * 0.3)
        ..close();
      canvas.drawPath(path, Paint()..color = color);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_FallingHeartsPainter old) => old.progress != progress;
}

/// Birthday reveal: balloons rising up.
class _RisingBalloonsPainter extends CustomPainter {
  final double progress;
  static const _colors = [
    Color(0xFFFF328C),
    Color(0xFFA011FF),
    Color(0xFF08C2F4),
    Color(0xFFFFB82C),
    Color(0xFF00E676),
  ];
  static final _balloons = List.generate(15, (i) {
    final r = Random(i * 23 + 5);
    return (
      x: r.nextDouble(),
      speed: 0.3 + r.nextDouble() * 0.7,
      radius: 8.0 + r.nextDouble() * 12.0,
      wobble: r.nextDouble() * pi * 2,
      colorIdx: r.nextInt(5),
    );
  });

  _RisingBalloonsPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final fade = (1.0 - progress).clamp(0.0, 1.0);

    for (final b in _balloons) {
      final baseX = b.x * size.width;
      final wobbleX = sin(progress * pi * 2 + b.wobble) * 12;
      final x = baseX + wobbleX;
      final y = size.height * (1.0 - progress * b.speed);
      final opacity = fade * 0.7;
      final r = b.radius;

      final color = _colors[b.colorIdx].withValues(alpha: opacity);
      final paint = Paint()..color = color;

      // Balloon oval
      canvas.drawOval(
        Rect.fromCenter(center: Offset(x, y), width: r * 2, height: r * 2.5),
        paint,
      );

      // Highlight
      canvas.drawCircle(
        Offset(x - r * 0.3, y - r * 0.4),
        r * 0.3,
        Paint()..color = Colors.white.withValues(alpha: opacity * 0.4),
      );

      // String
      final stringPaint = Paint()
        ..color = color.withValues(alpha: opacity * 0.5)
        ..strokeWidth = 0.8
        ..style = PaintingStyle.stroke;
      canvas.drawLine(
          Offset(x, y + r * 1.25), Offset(x, y + r * 1.25 + 20), stringPaint);
    }
  }

  @override
  bool shouldRepaint(_RisingBalloonsPainter old) => old.progress != progress;
}

/// Rich multi-color confetti for celebration/ndlovukazi/professional reveals.
class _RichConfettiPainter extends CustomPainter {
  final double progress;
  final GiftStyle style;
  static final _particles = List.generate(50, (i) {
    final r = Random(i * 31 + 7);
    return (
      x: r.nextDouble(),
      speed: 0.4 + r.nextDouble() * 0.6,
      rotation: r.nextDouble(),
      size: 3.0 + r.nextDouble() * 7.0,
      colorIdx: r.nextInt(5),
      shape: r.nextInt(3), // 0=rect, 1=circle, 2=diamond
    );
  });

  _RichConfettiPainter({required this.progress, required this.style});

  List<Color> get _colors => switch (style) {
        GiftStyle.celebration => const [
            Color(0xFFFFE066),
            Color(0xFFFF6429),
            Color(0xFFFF328C),
            Color(0xFF08C2F4),
            Color(0xFF00E676),
          ],
        GiftStyle.ndlovukazi => const [
            Color(0xFFCE93D8),
            Color(0xFFA011FF),
            Color(0xFFFFCC66),
            Color(0xFFFF328C),
            Color(0xFFE1BEE7),
          ],
        _ => const [
            Color(0xFF90A4AE),
            Color(0xFF607D8B),
            Color(0xFFB0BEC5),
            Color(0xFF78909C),
            Color(0xFFCFD8DC),
          ],
      };

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final fade = (1.0 - progress).clamp(0.0, 1.0);
    final colors = _colors;

    for (final p in _particles) {
      final x = p.x * size.width;
      final y = -20 + (size.height + 40) * progress * p.speed;
      final opacity = fade * 0.8;
      final color = colors[p.colorIdx].withValues(alpha: opacity);
      final paint = Paint()..color = color;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * p.rotation * 6.28);

      switch (p.shape) {
        case 0:
          canvas.drawRect(
            Rect.fromCenter(
                center: Offset.zero, width: p.size, height: p.size * 0.5),
            paint,
          );
        case 1:
          canvas.drawCircle(Offset.zero, p.size * 0.4, paint);
        default:
          final path = Path()
            ..moveTo(0, -p.size * 0.5)
            ..lineTo(p.size * 0.35, 0)
            ..lineTo(0, p.size * 0.5)
            ..lineTo(-p.size * 0.35, 0)
            ..close();
          canvas.drawPath(path, paint);
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_RichConfettiPainter old) =>
      old.progress != progress || old.style != style;
}
