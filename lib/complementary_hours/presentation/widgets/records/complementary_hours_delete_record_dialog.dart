import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_record.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
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

    return AlertDialog(
      backgroundColor: context.tertiary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: context.onTertiary.withValues(alpha: 0.09),
        ),
      ),
      icon: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: error.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.delete_outline_rounded, color: error),
      ),
      title: Text(
        context.l10n.complementaryHoursDeleteTitle,
        style: context.titleLarge?.copyWith(color: context.onTertiary),
      ),
      content: Text(
        context.l10n.complementaryHoursDeleteMessage(record.eventName),
        textAlign: TextAlign.center,
        style: context.bodyMedium?.copyWith(
          color: context.onTertiary.withValues(alpha: 0.66),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: onCancel,
          style: TextButton.styleFrom(
            foregroundColor: context.onTertiary.withValues(alpha: 0.72),
          ),
          child: Text(context.l10n.commonCancel),
        ),
        FilledButton.icon(
          onPressed: onConfirm,
          icon: const Icon(Icons.delete_outline_rounded, size: 18),
          label: Text(context.l10n.commonDelete),
          style: FilledButton.styleFrom(
            backgroundColor: error,
            foregroundColor: context.colors.onError,
          ),
        ),
      ],
    );
  }
}
