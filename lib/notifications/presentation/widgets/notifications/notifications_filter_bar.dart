import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/notifications/domain/models/app_notification.dart';
import 'package:flutter/material.dart';

class NotificationsFilterBar extends StatelessWidget {
  final AppNotificationType? selectedType;
  final ValueChanged<AppNotificationType?> onSelected;
  final double horizontalPadding;
  final double scale;
  final double textScale;

  const NotificationsFilterBar({
    super.key,
    required this.selectedType,
    required this.onSelected,
    required this.horizontalPadding,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      _NotificationFilter(
          label: context.l10n.notificationsFilterAll, type: null),
      _NotificationFilter(
        label: context.l10n.notificationsFilterEvents,
        type: AppNotificationType.event,
      ),
      _NotificationFilter(
        label: context.l10n.notificationsFilterReminders,
        type: AppNotificationType.reminder,
      ),
      _NotificationFilter(
        label: context.l10n.notificationsFilterUpdates,
        type: AppNotificationType.update,
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          for (final filter in filters) ...[
            _FilterChip(
              label: filter.label,
              selected: selectedType == filter.type,
              onTap: () => onSelected(filter.type),
              scale: scale,
              textScale: textScale,
            ),
            SizedBox(width: 8 * scale),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double scale;
  final double textScale;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.scale,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    final background = selected
        ? context.onTertiary
        : context.onTertiary.withValues(alpha: 0.08);
    final foreground = selected ? context.tertiary : context.onTertiary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: 15 * scale,
            vertical: 9 * scale,
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            label,
            style: context.text.labelMedium?.copyWith(
              color: foreground,
              fontSize: (context.text.labelMedium?.fontSize ?? 12) * textScale,
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationFilter {
  final String label;
  final AppNotificationType? type;

  const _NotificationFilter({required this.label, required this.type});
}
