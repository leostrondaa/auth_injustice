import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ButtonPrimary extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  const ButtonPrimary({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<ButtonPrimary> createState() => _ButtonPrimaryState();
}

class _ButtonPrimaryState extends State<ButtonPrimary>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<double> _scale;

  @override
  void initState() {
    super.initState();
    _scale = ValueNotifier<double>(1.0);
  }

  @override
  void dispose() {
    _scale.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isButtonDisabled = widget.onTap == null;

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
                  ? context.surface.withOpacity(0.5)
                  : context.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                if (!isButtonDisabled)
                  BoxShadow(
                    color: context.onSecondary.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: Text(
                widget.text,
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
    );
  }
}
