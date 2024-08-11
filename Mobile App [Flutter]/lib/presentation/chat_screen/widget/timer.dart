import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('2 Seconds Analog Timer')),
      body: Center(
        child: AnalogTimer(),
      ),
    ),
  ));
}

class AnalogTimer extends StatefulWidget {
  @override
  _AnalogTimerState createState() => _AnalogTimerState();
}

class _AnalogTimerState extends State<AnalogTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: TimerPainter(_controller),
          size: const Size(40, 40),
        ),
        const Text("Sia is about to respond."),
        // const Text("hold screen if you're still talking.", style: TextStyle(fontWeight: FontWeight.bold),),
      ],
    );
  }
}

class TimerPainter extends CustomPainter {
  final Animation<double> animation;

  TimerPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange.withOpacity(0.4)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    Paint centerDot = Paint()..color = Colors.orange.withOpacity(0.5);

    double radius = min(size.width / 2, size.height / 2) - paint.strokeWidth / 2;
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);

    double progress = (1.0 - animation.value) * 2 * pi;
    Offset hand = Offset(
      center.dx + radius * 0.8 * cos(progress),
      center.dy - radius * 0.8 * sin(progress),
    );

    canvas.drawLine(center, hand, paint);
    canvas.drawCircle(center, 2, centerDot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
