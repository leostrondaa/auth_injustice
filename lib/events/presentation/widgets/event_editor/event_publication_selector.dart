import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/pickers/app_date_time_fields.dart';
import 'package:autth_injustice_app/events/domain/models/event_editor_draft.dart';
import 'package:flutter/material.dart';

class EventPublicationSelector extends StatelessWidget {
  final EventPublicationMode mode;
  final DateTime? publishAt;
  final ValueChanged<EventPublicationMode> onModeChanged;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;

  const EventPublicationSelector({
    super.key,
    required this.mode,
    required this.publishAt,
    required this.onModeChanged,
    required this.onPickDate,
    required this.onPickTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SegmentedButton<EventPublicationMode>(
          segments: [
            ButtonSegment(
              value: EventPublicationMode.now,
              icon: const Icon(Icons.send_outlined),
              label: Text(context.l10n.eventEditorPublishNow),
            ),
            ButtonSegment(
              value: EventPublicationMode.scheduled,
              icon: const Icon(Icons.schedule_send_outlined),
              label: Text(context.l10n.eventEditorSchedule),
            ),
          ],
          selected: {mode},
          onSelectionChanged: (selection) {
            onModeChanged(selection.first);
          },
          showSelectedIcon: false,
          style: ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(
              Size.fromHeight(54),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? context.tertiary
                  : context.onTertiary.withValues(alpha: 0.68);
            }),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? context.onTertiary.withValues(alpha: 0.9)
                  : Colors.transparent;
            }),
            side: WidgetStateProperty.resolveWith((states) {
              return BorderSide(
                color: states.contains(WidgetState.selected)
                    ? context.tertiary
                    : context.onTertiary.withValues(alpha: 0.18),
                width: 1.2,
              );
            }),
            overlayColor: WidgetStatePropertyAll(
              context.primary.withValues(alpha: 0.08),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            textStyle: WidgetStatePropertyAll(
              context.text.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            iconSize: const WidgetStatePropertyAll(20),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          child: mode == EventPublicationMode.scheduled
              ? Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: AppDateTimeFields(
                    value: publishAt,
                    dateLabel: context.l10n.eventEditorPublicationDate,
                    timeLabel: context.l10n.eventEditorPublicationTime,
                    emptyDateText: context.l10n.eventEditorChooseDate,
                    emptyTimeText: context.l10n.eventEditorChooseTime,
                    dateIcon: Icons.event_available_outlined,
                    timeIcon: Icons.schedule_send_outlined,
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
