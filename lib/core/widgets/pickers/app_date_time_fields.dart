import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppDateTimeFields extends StatelessWidget {
  final DateTime? value;
  final String dateLabel;
  final String timeLabel;
  final String emptyDateText;
  final String emptyTimeText;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;
  final IconData dateIcon;
  final IconData timeIcon;
  final double spacing;

  const AppDateTimeFields({
    super.key,
    required this.value,
    required this.dateLabel,
    required this.timeLabel,
    required this.emptyDateText,
    required this.emptyTimeText,
    required this.onPickDate,
    required this.onPickTime,
    this.dateIcon = Icons.calendar_today_outlined,
    this.timeIcon = Icons.schedule_outlined,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AppDateTimeField(
          icon: dateIcon,
          label: dateLabel,
          value: value == null
              ? emptyDateText
              : MaterialLocalizations.of(context).formatMediumDate(value!),
          selected: value != null,
          onTap: onPickDate,
        ),
        SizedBox(height: spacing),
        _AppDateTimeField(
          icon: timeIcon,
          label: timeLabel,
          value: value == null
              ? emptyTimeText
              : TimeOfDay.fromDateTime(value!).format(context),
          selected: value != null,
          onTap: onPickTime,
        ),
      ],
    );
  }
}

class _AppDateTimeField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  const _AppDateTimeField({
    required this.icon,
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.surface.withValues(
        alpha: context.isDarkMode ? 1 : 1,
      ),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected
                    ? context.primary
                    : context.onTertiary.withValues(alpha: 0.42),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: context.text.labelSmall?.copyWith(
                        color: context.onTertiary.withValues(alpha: 0.48),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: context.text.bodyLarge?.copyWith(
                        color: selected
                            ? context.onTertiary
                            : context.onTertiary.withValues(alpha: 0.62),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: context.onTertiary.withValues(alpha: 0.30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
