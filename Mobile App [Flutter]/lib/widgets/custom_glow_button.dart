import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fotisia/core/app_export.dart';
class GlowingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const GlowingButton({
    required this.onPressed,
    required this.child,
  });

  @override
  _GlowingButtonState createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: CustomPaint(
        // painter: _GlowPainter(_animation),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            shape: BoxShape.circle,
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  final Animation<double> animation;

  _GlowPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);

    final gradient = RadialGradient(
      colors: [
        Colors.blue.withOpacity(0.0),
        Colors.blue.withOpacity(0.5),
        Colors.blue.withOpacity(0.0),
      ],
    );

    final rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    final shader = gradient.createShader(rect);
    glowPaint.shader = shader;

    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      glowPaint,
    );

    final angle = animation.value;
    final trailLength = 0.3;
    final numSegments = 10;
    for (int i = 0; i < numSegments; i++) {
      final segmentAngle = angle - (i * trailLength / numSegments * 2 * pi);
      final x = radius + radius * cos(segmentAngle);
      final y = radius + radius * sin(segmentAngle);
      final dotPaint = Paint()..color = theme.colorScheme.secondary.withOpacity((1 - i / numSegments) * 0.8);
      canvas.drawCircle(Offset(x, y), 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}