import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:flutter/material.dart';

class ComplementaryHoursHeader extends StatelessWidget {
  final double scale;
  final VoidCallback onSettingsPressed;

  const ComplementaryHoursHeader({
    super.key,
    required this.scale,
    required this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100 * scale,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AppEntranceTransition(
              child: Text(
                context.l10n.complementaryHoursTitle,
                style: context.displayLarge?.copyWith(
                  color: context.onTertiary,
                  fontSize: 48 * scale,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 0,
            child: AppEntranceTransition(
              delay: const Duration(milliseconds: 70),
              child: Tooltip(
                message: context.l10n.settingsTitle,
                child: IconButton.filledTonal(
                  onPressed: onSettingsPressed,
                  icon: const Icon(Icons.settings_outlined),
                  color: context.onTertiary,
                  style: IconButton.styleFrom(
                    backgroundColor: context.onTertiary.withValues(alpha: 0.08),
                    fixedSize: Size.square(48 * scale),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
