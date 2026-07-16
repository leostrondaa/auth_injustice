import 'package:flutter/material.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<double> _scale;
  late final AnimationController _loadingController;
  @override
  void initState() {
    super.initState();
    _scale = ValueNotifier<double>(1.0);

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    if (widget.isLoading) {
      _loadingController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant PrimaryButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLoading && !oldWidget.isLoading) {
      _loadingController.repeat();
    }

    if (!widget.isLoading && oldWidget.isLoading) {
      _loadingController
        ..stop()
        ..reset();
    }
  }

  @override
  void dispose() {
    _scale.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isButtonDisabled = widget.onTap == null || widget.isLoading;

    return ValueListenableBuilder<double>(
      valueListenable: _scale,
      builder: (context, scaleValue, child) {
        return AnimatedScale(
          scale: scaleValue,
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOut,
          child: child!,
        );
      },
      child: GestureDetector(
        onTapDown: isButtonDisabled ? null : (_) => _scale.value = 0.98,
        onTapCancel: isButtonDisabled ? null : () => _scale.value = 1.0,
        onTap: isButtonDisabled
            ? null
            : () async {
                _scale.value = 0.98;
                await Future.delayed(const Duration(milliseconds: 120));
                if (mounted) {
                  _scale.value = 1.0;
                  widget.onTap!();
                }
              },
        child: MouseRegion(
          cursor: isButtonDisabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isButtonDisabled
                  ? context.surface.withOpacity(0.9)
                  : context.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                  BoxShadow(
                    color: context.onSecondary.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: widget.isLoading
                    ? _LoadingDots(
                        key: const ValueKey('loading'),
                        animation: _loadingController,
                        color: context.onSurface,
                      )
                    : Text(
                        widget.text,
                        key: const ValueKey('text'),
                        textAlign: TextAlign.center,
                        style: context.text.bodyMedium?.copyWith(
                          color: context.onSurface,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingDots extends StatelessWidget {
  final Animation<double> animation;
  final Color color;

  const _LoadingDots({
    super.key,
    required this.animation,
    required this.color,
  });

  double _offsetFor(int index) {
    final phase = (animation.value + index * 0.18) % 1;
    final movement = phase < 0.5 ? phase * 2 : (1 - phase) * 2;

    return -5 * Curves.easeInOut.transform(movement);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return Transform.translate(
              offset: Offset(0, _offsetFor(index)),
              child: Container(
                width: 7,
                height: 7,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: color,
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
