import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final ValueNotifier<double> _scale;

  ButtonPrimary({
    super.key,
    required this.text,
    required this.onTap,
  }) : _scale = ValueNotifier<double>(1.0);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

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
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors.onSecondary.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTapDown: onTap == null ? null : (_) => _scale.value = 0.99,
            onTapUp: onTap == null ? null : (_) => _scale.value = 1.0,
            onTapCancel: onTap == null ? null : () => _scale.value = 1.0,
            onTap: onTap,
            splashColor: colors.tertiary.withValues(alpha: 0.8),
            highlightColor: colors.onTertiary.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: context.text.displaySmall?.copyWith(
                  color: colors.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
