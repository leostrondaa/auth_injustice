import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_action_button.dart';
import 'package:flutter/material.dart';

class EventDetailsActions extends StatelessWidget {
  final bool addedToPersonalHistory;
  final bool personalRecordUpdating;
  final VoidCallback? onPersonalRecordTap;
  final VoidCallback onMapTap;

  const EventDetailsActions({
    super.key,
    required this.addedToPersonalHistory,
    required this.personalRecordUpdating,
    required this.onPersonalRecordTap,
    required this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 16,
              color: context.onTertiary.withValues(alpha: 0.48),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                context.l10n.personalRecordNotice,
                style: context.bodySmall?.copyWith(
                  color: context.onTertiary.withValues(alpha: 0.52),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AppActionButton(
          text: personalRecordUpdating
              ? context.l10n.personalRecordUpdating
              : addedToPersonalHistory
                  ? context.l10n.personalHistoryAdded
                  : context.l10n.addToPersonalHistory,
          color: context.secondary,
          icon: addedToPersonalHistory
              ? Icons.bookmark_added_rounded
              : Icons.bookmark_add_outlined,
          onPressed: personalRecordUpdating ? null : onPersonalRecordTap,
        ),
        const SizedBox(height: 9),
        AppActionButton(
          text: context.l10n.viewOnMap,
          color: context.onTertiary,
          style: AppActionButtonStyle.outlined,
          icon: Icons.map_outlined,
          onPressed: onMapTap,
        ),
      ],
    );
  }
}
