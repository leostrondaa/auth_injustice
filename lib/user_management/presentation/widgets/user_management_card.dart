import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/core/formatters/hours_minutes_formatter.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/user_management/domain/models/user_directory_entry.dart';
import 'package:flutter/material.dart';

class UserManagementCard extends StatelessWidget {
  final UserDirectoryEntry user;
  final double scale;
  final double textScale;
  final int index;
  final VoidCallback? onTap;

  const UserManagementCard({
    super.key,
    required this.user,
    required this.scale,
    required this.textScale,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isManager = user.account.role == AccountRole.eventManager;
    final hasName = user.name.trim().isNotEmpty;
    final accent = isManager
        ? context.onTertiary.withValues(alpha: 0.8)
        : context.onTertiary.withValues(alpha: 0.8);
    final radius = BorderRadius.circular(18 * scale);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 260 + (index.clamp(0, 6) * 45)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, (1 - value) * 16 * scale),
          child: child,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Ink(
            decoration: BoxDecoration(
              color: context.onTertiary.withValues(
                alpha: context.isDarkMode ? 0.035 : 0.025,
              ),
              borderRadius: radius,
              border: Border.all(
                color: context.onTertiary.withValues(alpha: 0.09),
              ),
            ),
            padding: EdgeInsets.all(16 * scale),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasName ? user.name : user.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.text.titleSmall?.copyWith(
                          color: context.onTertiary,
                          fontSize: 15 * textScale,
                        ),
                      ),
                      if (hasName) ...[
                        SizedBox(height: 4 * scale),
                        Text(
                          user.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodySmall?.copyWith(
                            color: context.onTertiary.withValues(alpha: 0.52),
                            fontSize: 11.5 * textScale,
                          ),
                        ),
                      ],
                      SizedBox(height: 9 * scale),
                      _RoleLabel(
                        label: isManager
                            ? context.l10n.userManagementRoleEventManager
                            : context.l10n.userManagementRoleStudent,
                        color: accent,
                        scale: scale,
                        textScale: textScale,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10 * scale),
                _HoursTotal(
                  minutes: user.totalComplementaryMinutes,
                  scale: scale,
                  textScale: textScale,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleLabel extends StatelessWidget {
  final String label;
  final Color color;
  final double scale;
  final double textScale;

  const _RoleLabel({
    required this.label,
    required this.color,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 9 * scale,
        vertical: 5 * scale,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? context.secondary.withValues(alpha: 0.2)
            : context.primary.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: context.text.labelSmall?.copyWith(
          color: color,
          fontSize: 9.5 * textScale,
        ),
      ),
    );
  }
}

class _HoursTotal extends StatelessWidget {
  final int minutes;
  final double scale;
  final double textScale;

  const _HoursTotal({
    required this.minutes,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    final formatted = HoursMinutesFormatter.formatMinutes(minutes);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 78 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formatted,
            maxLines: 1,
            style: context.titleLarge?.copyWith(
              color: context.onTertiary,
              fontSize: 15 * textScale,
            ),
          ),
          SizedBox(height: 3 * scale),
          Text(
            context.l10n.userManagementTotalHours,
            maxLines: 2,
            textAlign: TextAlign.end,
            style: context.text.labelSmall?.copyWith(
              color: context.onTertiary.withValues(alpha: 0.42),
              fontSize: 8.5 * textScale,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }
}
