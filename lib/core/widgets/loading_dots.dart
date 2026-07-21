import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  final Color color;
  final double size;
  final double spacing;
  final double rise;
  final Duration duration;

  const LoadingDots({
    super.key,
    required this.color,
    this.size = 7,
    this.spacing = 3,
    this.rise = 5,
    this.duration = const Duration(milliseconds: 850),
  });

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant LoadingDots oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _offsetFor(int index) {
    final phase = (_controller.value + index * 0.18) % 1;
    final movement = phase < 0.5 ? phase * 2 : (1 - phase) * 2;

    return -widget.rise * Curves.easeInOut.transform(movement);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return Transform.translate(
              offset: Offset(0, _offsetFor(index)),
              child: Container(
                width: widget.size,
                height: widget.size,
                margin: EdgeInsets.symmetric(horizontal: widget.spacing),
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
