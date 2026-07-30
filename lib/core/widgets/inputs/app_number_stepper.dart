import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppNumberStepper extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final int step;
  final String unit;
  final ValueChanged<int> onChanged;
  final bool compact;

  const AppNumberStepper({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
    this.step = 1,
    this.compact = false,
  })  : assert(min <= max),
        assert(step > 0),
        assert(value >= min && value <= max);

  void _decrement() => onChanged((value - step).clamp(min, max));

  void _increment() => onChanged((value + step).clamp(min, max));

  static double resolvedHeight(
    BuildContext context, {
    required bool compact,
  }) {
    return context.responsive.scaled(
      compact ? 174 : 192,
      min: compact ? 158 : 174,
      max: compact ? 186 : 206,
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final canDecrement = value > min;
    final canIncrement = value < max;
    final numberSize = responsive.scaled(
      compact ? 50 : 80,
      min: compact ? 40 : 60,
      max: compact ? 80 : 100,
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 190),
      curve: Curves.easeOutCubic,
      height: resolvedHeight(context, compact: compact),
      padding: EdgeInsets.fromLTRB(
        responsive.scaled(compact ? 10 : 12, min: 9, max: 14),
        responsive.scaled(14, min: 12, max: 16),
        responsive.scaled(compact ? 10 : 12, min: 9, max: 14),
        responsive.scaled(12, min: 10, max: 14),
      ),
      decoration: BoxDecoration(
        color: context.onTertiary.withValues(
          alpha: context.isDarkMode ? 0.07 : 0.04,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.onTertiary.withValues(
            alpha: context.isDarkMode ? 0.12 : 0.08,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: context.isDarkMode ? 0.12 : 0.05,
            ),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(end: value.toDouble()),
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      builder: (context, animatedValue, _) {
                        return Text(
                          animatedValue.round().toString(),
                          style: context.text.displayLarge?.copyWith(
                            color: context.primary,
                            fontSize: numberSize,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 4),
                    Text(
                      unit,
                      style: context.text.titleMedium?.copyWith(
                        color: context.onTertiary,
                        fontSize: responsive.scaled(
                          compact ? 13 : 15,
                          min: 11,
                          max: compact ? 14 : 16,
                        ),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              _StepperButton(
                icon: Icons.remove_rounded,
                enabled: canDecrement,
                compact: compact,
                onPressed: _decrement,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '$min-$max',
                      style: context.text.labelSmall?.copyWith(
                        color: context.onTertiary.withValues(alpha: 0.42),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              _StepperButton(
                icon: Icons.add_rounded,
                enabled: canIncrement,
                compact: compact,
                onPressed: _increment,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final bool compact;
  final VoidCallback onPressed;

  const _StepperButton({
    required this.icon,
    required this.enabled,
    required this.compact,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final size = responsive.scaled(
      compact ? 36 : 40,
      min: compact ? 32 : 35,
      max: compact ? 38 : 42,
    );

    return Material(
      color: enabled
          ? context.onTertiary.withValues(
              alpha: context.isDarkMode ? 0.12 : 0.08,
            )
          : context.onTertiary.withValues(alpha: 0.035),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        customBorder: const CircleBorder(),
        splashColor: context.primary.withValues(alpha: 0.28),
        child: SizedBox.square(
          dimension: size,
          child: Icon(
            icon,
            size: responsive.scaled(21, min: 18, max: 23),
            color: enabled
                ? context.onTertiary
                : context.onTertiary.withValues(alpha: 0.22),
          ),
        ),
      ),
    );
  }
}
