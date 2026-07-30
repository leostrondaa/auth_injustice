import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_record.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class ComplementaryHoursDeleteRecordDialog extends StatelessWidget {
  final ComplementaryHoursRecord record;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const ComplementaryHoursDeleteRecordDialog({
    super.key,
    required this.record,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final error = context.colors.error;

    return AppConfirmationDialog(
      icon: Icons.delete_outline_rounded,
      iconColor: error,
      title: context.l10n.complementaryHoursDeleteTitle,
      message: context.l10n.complementaryHoursDeleteMessage(record.eventName),
      cancelLabel: context.l10n.commonCancel,
      cancelColor: context.onTertiary.withValues(alpha: 0.72),
      confirmLabel: context.l10n.commonDelete,
      confirmColor: error,
      confirmForegroundColor: context.colors.onError,
      confirmIcon: Icons.delete_outline_rounded,
      onCancel: onCancel,
      onConfirm: onConfirm,
    );
  }
}
