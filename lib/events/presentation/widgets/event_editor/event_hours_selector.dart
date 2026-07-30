import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/inputs/app_number_stepper.dart';
import 'package:flutter/material.dart';

class EventHoursSelector extends StatelessWidget {
  final bool enabled;
  final int hours;
  final int minutes;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<int> onHoursChanged;
  final ValueChanged<int> onMinutesChanged;

  const EventHoursSelector({
    super.key,
    required this.enabled,
    required this.hours,
    required this.minutes,
    required this.onEnabledChanged,
    required this.onHoursChanged,
    required this.onMinutesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: context.onTertiary.withValues(
            alpha: context.isDarkMode ? 0.06 : 0.035,
          ),
          borderRadius: BorderRadius.circular(14),
          child: SwitchListTile.adaptive(
            value: enabled,
            onChanged: onEnabledChanged,
            activeTrackColor: context.primary,
            title: Text(
              context.l10n.eventEditorHasHours,
              style: context.text.titleMedium?.copyWith(
                color: context.onTertiary,
              ),
            ),
            secondary: Icon(
              Icons.workspace_premium_outlined,
              color: enabled
                  ? context.primary
                  : context.onTertiary.withValues(alpha: 0.46),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          child: enabled
              ? Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 11,
                        child: AppNumberStepper(
                          value: hours,
                          min: 0,
                          max: 100,
                          unit: 'h',
                          onChanged: onHoursChanged,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 9,
                        child: AppNumberStepper(
                          value: minutes,
                          min: 0,
                          max: 55,
                          step: 5,
                          unit: 'm',
                          compact: true,
                          onChanged: onMinutesChanged,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
