import 'package:flutter/material.dart';


class CircularProgressBar extends StatefulWidget {
  CircularProgressBar({super.key, required this.progress});
  double progress;

  @override
  State<CircularProgressBar> createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    value: widget.progress,
    vsync: this,
    duration: const Duration(milliseconds: 5000),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox.square(
            dimension: 40,
            child: CircularProgressIndicator(
              value: 1.0,
              color: Colors.grey,
              strokeWidth: 3.0,
            ),
          ),
          SizedBox.square(
            dimension: 40,
            child: CircularProgressIndicator(
              value: _animationController.value,
              color: getColorFromScore(widget.progress * 100),
              strokeWidth: 3.0,
            ),
          ),
          Text(
            '${(_animationController.value * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color getColorFromScore(double score) {
    // Ensure score is between 0 and 100
    score = score.clamp(0, 100);

    if (score <= 50) {
      // Interpolate between red and yellow
      return Color.lerp(Colors.red, Colors.yellow, score / 50)!;
    } else {
      // Interpolate between yellow and green
      return Color.lerp(Colors.yellow, Colors.green, (score - 50) / 50)!;
    }
  }

}