import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ComplementaryHoursRecordsDrawerHandle extends StatelessWidget {
  final double scale;
  final ValueListenable<double> progress;
  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;

  const ComplementaryHoursRecordsDrawerHandle({
    super.key,
    required this.scale,
    required this.progress,
    required this.onTap,
    required this.onVerticalDragUpdate,
    required this.onVerticalDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      child: ValueListenableBuilder<double>(
        valueListenable: progress,
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            height: 42 * scale,
            padding: EdgeInsets.symmetric(horizontal: 18 * scale),
            decoration: BoxDecoration(
              color: context.secondary,
              borderRadius: BorderRadius.circular(99),
              border: Border.all(
                color: context.onSecondary.withValues(alpha: 0.14),
              ),
              boxShadow: [
                BoxShadow(
                  color: context.secondary.withValues(alpha: 0.24),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.history_rounded,
                  size: 19 * scale,
                  color: context.onSecondary,
                ),
                SizedBox(width: 9 * scale),
                Text(
                  context.l10n.complementaryHoursRecords,
                  style: context.text.labelLarge?.copyWith(
                    color: context.onSecondary,
                    fontSize: 14 * scale,
                  ),
                ),
                SizedBox(width: 7 * scale),
                Transform.rotate(
                  angle: value * 3.141592653589793,
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 20 * scale,
                    color: context.onSecondary.withValues(alpha: 0.78),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
