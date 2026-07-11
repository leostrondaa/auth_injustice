import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final ValueNotifier<double> _scale = ValueNotifier<double>(1.0);

  ButtonPrimary({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _scale,
      builder: (context, scaleValue, child) {
        return AnimatedScale(
          scale: scaleValue,
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOut,
          child: child,
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: context.colors.onSurface.withOpacity(0.6),
              blurRadius: 15,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTapDown: onTap == null ? null : (_) => _scale.value = 0.995,
          onTapUp: (_) => _scale.value = 1.0,
          onTapCancel: () => _scale.value = 1.0,
          onTap: onTap,
          splashColor: context.colors.onSurface.withValues(alpha: 0.12),
          highlightColor: context.colors.onSurface.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: context.text.displaySmall?.copyWith(
                color: context.colors.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
