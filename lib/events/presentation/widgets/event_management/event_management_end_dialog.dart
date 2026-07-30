import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class EventManagementEndDialog extends StatelessWidget {
  final String eventTitle;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const EventManagementEndDialog({
    super.key,
    required this.eventTitle,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFE49B32);

    return AppConfirmationDialog(
      icon: Icons.stop_circle_outlined,
      iconColor: accent,
      title: context.l10n.eventManagementEndTitle,
      message: context.l10n.eventManagementEndMessage(eventTitle),
      cancelLabel: context.l10n.commonCancel,
      cancelColor: context.onTertiary.withValues(alpha: 0.72),
      confirmLabel: context.l10n.eventManagementEnd,
      confirmColor: accent,
      confirmForegroundColor: Colors.black,
      confirmIcon: Icons.stop_circle_outlined,
      onCancel: onCancel,
      onConfirm: onConfirm,
    );
  }
}
