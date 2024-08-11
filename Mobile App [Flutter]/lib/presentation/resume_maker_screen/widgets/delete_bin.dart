import 'package:flutter/material.dart';

class DeleteAnimationController {
  VoidCallback? _startAnimation;

  void startAnimation() {
    _startAnimation?.call();
  }
}

class DeleteAnimationWidget extends StatefulWidget {
  final DeleteAnimationController controller;
  final VoidCallback onDelete;

  const DeleteAnimationWidget({
    Key? key,
    required this.controller,
    required this.onDelete,
  }) : super(key: key);

  @override
  _DeleteAnimationWidgetState createState() => _DeleteAnimationWidgetState();
}

class _DeleteAnimationWidgetState extends State<DeleteAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    widget.controller._startAnimation = _startAnimation;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward().then((_) {
      widget.onDelete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + (_animation.value * 0.5),
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 30.0 + (_animation.value * 10.0),
          ),
        );
      },
    );
  }
}
