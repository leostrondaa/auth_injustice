import 'package:flutter/material.dart';

enum AppStepEntranceMotion {
  content,
  action,
}

abstract final class AppStepTransitionSpec {
  static const pageDuration = Duration(milliseconds: 400);
  static const pageCurve = Curves.easeInOut;

  static const entranceDelayMilliseconds = 20;
  static const entranceDurationMilliseconds = 450;
  static const entranceDelay = Duration(
    milliseconds: entranceDelayMilliseconds,
  );
  static const entranceDuration = Duration(
    milliseconds: entranceDurationMilliseconds,
  );
}

class AppStepEntranceTransition extends StatefulWidget {
  final bool active;
  final AppStepEntranceMotion motion;
  final Widget child;

  const AppStepEntranceTransition({
    super.key,
    required this.active,
    required this.child,
    this.motion = AppStepEntranceMotion.content,
  });

  @override
  State<AppStepEntranceTransition> createState() =>
      _AppStepEntranceTransitionState();
}

class _AppStepEntranceTransitionState extends State<AppStepEntranceTransition>
    with SingleTickerProviderStateMixin {
  static const _entranceDelayMilliseconds =
      AppStepTransitionSpec.entranceDelayMilliseconds;
  static const _entranceDurationMilliseconds =
      AppStepTransitionSpec.entranceDurationMilliseconds;
  static const _totalDurationMilliseconds =
      _entranceDelayMilliseconds + _entranceDurationMilliseconds;
  static const _totalDuration = Duration(
    milliseconds: _totalDurationMilliseconds,
  );
  static const _contentStart =
      _entranceDelayMilliseconds / _totalDurationMilliseconds;
  static const _contentSlideEnd = _contentStart + (1 - _contentStart) * 0.7;
  static const _contentOpacityEnd = _contentStart + (1 - _contentStart) * 0.9;
  static const _actionSlideStart = _contentStart + (1 - _contentStart) * 0.1;
  static const _actionOpacityStart = _contentStart + (1 - _contentStart) * 0.4;

  late final AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _totalDuration,
    );
    _configureAnimations();
    if (widget.active) _playEntrance();
  }

  @override
  void didUpdateWidget(covariant AppStepEntranceTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.motion != oldWidget.motion) _configureAnimations();
    if (widget.active && !oldWidget.active) _playEntrance();
  }

  void _configureAnimations() {
    switch (widget.motion) {
      case AppStepEntranceMotion.content:
        _slide = Tween<Offset>(
          begin: const Offset(0, -0.8),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              _contentStart,
              _contentSlideEnd,
              curve: Curves.easeOutCubic,
            ),
          ),
        );
        _opacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              _contentStart,
              _contentOpacityEnd,
              curve: Curves.easeOut,
            ),
          ),
        );
      case AppStepEntranceMotion.action:
        _slide = Tween<Offset>(
          begin: const Offset(0, 0.8),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              _actionSlideStart,
              1,
              curve: Curves.easeOutCubic,
            ),
          ),
        );
        _opacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              _actionOpacityStart,
              1,
              curve: Curves.easeIn,
            ),
          ),
        );
    }
  }

  void _playEntrance() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _opacity,
        child: widget.child,
      ),
    );
  }
}
