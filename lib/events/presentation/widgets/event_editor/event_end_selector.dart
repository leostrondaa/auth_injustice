import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/pickers/app_date_time_fields.dart';
import 'package:autth_injustice_app/events/domain/models/event_timing.dart';
import 'package:flutter/material.dart';

class EventEndSelector extends StatelessWidget {
  final EventEndMode? mode;
  final DateTime? endsAt;
  final ValueChanged<EventEndMode> onModeChanged;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;

  const EventEndSelector({
    super.key,
    required this.mode,
    required this.endsAt,
    required this.onModeChanged,
    required this.onPickDate,
    required this.onPickTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _EndModeOption(
          selected: mode == EventEndMode.automatic,
          icon: Icons.event_available_outlined,
          title: context.l10n.eventEditorAutomaticEnd,
          description: context.l10n.eventEditorAutomaticEndDescription,
          onTap: () => onModeChanged(EventEndMode.automatic),
        ),
        const SizedBox(height: 12),
        _EndModeOption(
          selected: mode == EventEndMode.manual,
          icon: Icons.touch_app_outlined,
          title: context.l10n.eventEditorManualEnd,
          description: context.l10n.eventEditorManualEndDescription,
          onTap: () => onModeChanged(EventEndMode.manual),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          child: mode == EventEndMode.automatic
              ? Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: AppDateTimeFields(
                    value: endsAt,
                    dateLabel: context.l10n.eventEditorEndDate,
                    timeLabel: context.l10n.eventEditorEndTime,
                    emptyDateText: context.l10n.eventEditorChooseDate,
                    emptyTimeText: context.l10n.eventEditorChooseTime,
                    dateIcon: Icons.event_busy_outlined,
                    timeIcon: Icons.timer_outlined,
                    onPickDate: onPickDate,
                    onPickTime: onPickTime,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _EndModeOption extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _EndModeOption({
    required this.selected,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = context.primary;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        splashColor: accent.withValues(alpha: 0.12),
        highlightColor: accent.withValues(alpha: 0.05),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 190),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: context.isDarkMode ? 0.16 : 0.09)
                : context.onTertiary.withValues(
                    alpha: context.isDarkMode ? 0.055 : 0.035,
                  ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? accent.withValues(alpha: 0.72)
                  : context.onTertiary.withValues(alpha: 0.11),
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 190),
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: selected
                      ? accent
                      : context.onTertiary.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  size: 21,
                  color: selected
                      ? context.onPrimary
                      : context.onTertiary.withValues(alpha: 0.60),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.text.titleMedium?.copyWith(
                        color: context.onTertiary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: context.text.bodySmall?.copyWith(
                        color: context.onTertiary.withValues(alpha: 0.62),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 160),
                child: Icon(
                  selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                  key: ValueKey(selected),
                  size: 22,
                  color: selected
                      ? accent
                      : context.onTertiary.withValues(alpha: 0.25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
