import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:flutter/material.dart';

class ComplementaryHoursHeader extends StatelessWidget {
  final double scale;
  final VoidCallback onSettingsPressed;
  final VoidCallback? onUsersPressed;

  const ComplementaryHoursHeader({
    super.key,
    required this.scale,
    required this.onSettingsPressed,
    this.onUsersPressed,
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
            top: onUsersPressed == null ? 10 : 0,
            right: 0,
            child: AppEntranceTransition(
              delay: const Duration(milliseconds: 70),
              child: onUsersPressed == null
                  ? Tooltip(
                      message: context.l10n.settingsTitle,
                      child: IconButton.filledTonal(
                        onPressed: onSettingsPressed,
                        icon: const Icon(Icons.settings_outlined),
                        color: context.onTertiary,
                        style: IconButton.styleFrom(
                          backgroundColor:
                              context.onTertiary.withValues(alpha: 0.08),
                          fixedSize: Size.square(48 * scale),
                        ),
                      ),
                    )
                  : _AdminHeaderActions(
                      scale: scale,
                      onSettingsPressed: onSettingsPressed,
                      onUsersPressed: onUsersPressed!,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminHeaderActions extends StatelessWidget {
  final double scale;
  final VoidCallback onSettingsPressed;
  final VoidCallback onUsersPressed;

  const _AdminHeaderActions({
    required this.scale,
    required this.onSettingsPressed,
    required this.onUsersPressed,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(26 * scale);

    return Material(
      color: context.onTertiary.withValues(alpha: 0.08),
      borderRadius: radius,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 48 * scale,
        height: 96 * scale,
        child: Column(
          children: [
            Expanded(
              child: _HeaderAction(
                tooltip: context.l10n.settingsTitle,
                icon: Icons.settings_outlined,
                onPressed: onSettingsPressed,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 * scale),
              child: Divider(
                height: 1,
                thickness: 1,
                color: context.onTertiary.withValues(alpha: 0.12),
              ),
            ),
            Expanded(
              child: _HeaderAction(
                tooltip: context.l10n.userManagementTitle,
                icon: Icons.group_outlined,
                onPressed: onUsersPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  const _HeaderAction({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        splashColor: context.secondary.withValues(alpha: 0.10),
        highlightColor: context.secondary.withValues(alpha: 0.04),
        child: Center(
          child: Icon(
            icon,
            size: 24,
            color: context.onTertiary,
          ),
        ),
      ),
    );
  }
}
