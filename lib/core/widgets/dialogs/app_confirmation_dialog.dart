import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppConfirmationDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String cancelLabel;
  final Color cancelColor;
  final String confirmLabel;
  final Color confirmColor;
  final Color confirmForegroundColor;
  final IconData? confirmIcon;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const AppConfirmationDialog({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.cancelLabel,
    required this.cancelColor,
    required this.confirmLabel,
    required this.confirmColor,
    required this.confirmForegroundColor,
    required this.onCancel,
    required this.onConfirm,
    this.confirmIcon,
  });

  @override
  Widget build(BuildContext context) {
    final verticalActions = context.responsive.isCompact;

    return AlertDialog(
      backgroundColor: context.tertiary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: context.onTertiary.withValues(alpha: 0.09),
        ),
      ),
      icon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.13),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: context.titleLarge?.copyWith(
          color: context.onTertiary,
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: context.bodyMedium?.copyWith(
          color: context.onTertiary.withValues(alpha: 0.66),
        ),
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: verticalActions
          ? [
              _VerticalDialogActions(
                cancelLabel: cancelLabel,
                cancelColor: cancelColor,
                confirmLabel: confirmLabel,
                confirmColor: confirmColor,
                confirmForegroundColor: confirmForegroundColor,
                confirmIcon: confirmIcon,
                onCancel: onCancel,
                onConfirm: onConfirm,
              ),
            ]
          : [
              KeyedSubtree(
                key: const ValueKey(
                  'app-confirmation-actions-horizontal',
                ),
                child: _CancelButton(
                  label: cancelLabel,
                  color: cancelColor,
                  onPressed: onCancel,
                ),
              ),
              _ConfirmButton(
                label: confirmLabel,
                color: confirmColor,
                foregroundColor: confirmForegroundColor,
                icon: confirmIcon,
                onPressed: onConfirm,
              ),
            ],
    );
  }
}

class _VerticalDialogActions extends StatelessWidget {
  final String cancelLabel;
  final Color cancelColor;
  final String confirmLabel;
  final Color confirmColor;
  final Color confirmForegroundColor;
  final IconData? confirmIcon;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const _VerticalDialogActions({
    required this.cancelLabel,
    required this.cancelColor,
    required this.confirmLabel,
    required this.confirmColor,
    required this.confirmForegroundColor,
    required this.confirmIcon,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        key: const ValueKey('app-confirmation-actions-vertical'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _CancelButton(
            label: cancelLabel,
            color: cancelColor,
            onPressed: onCancel,
          ),
          _ConfirmButton(
            label: confirmLabel,
            color: confirmColor,
            foregroundColor: confirmForegroundColor,
            icon: confirmIcon,
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _CancelButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: color),
      child: Text(label),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color foregroundColor;
  final IconData? icon;
  final VoidCallback onPressed;

  const _ConfirmButton({
    required this.label,
    required this.color,
    required this.foregroundColor,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final style = FilledButton.styleFrom(
      backgroundColor: color,
      foregroundColor: foregroundColor,
    );

    if (icon == null) {
      return FilledButton(
        onPressed: onPressed,
        style: style,
        child: Text(label),
      );
    }

    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: style,
    );
  }
}

Future<bool> showAppConfirmationDialog({
  required BuildContext context,
  required IconData icon,
  required Color iconColor,
  required String title,
  required String message,
  required String cancelLabel,
  required Color cancelColor,
  required String confirmLabel,
  required Color confirmColor,
  required Color confirmForegroundColor,
  IconData? confirmIcon,
  bool barrierDismissible = true,
}) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (dialogContext) => AppConfirmationDialog(
          icon: icon,
          iconColor: iconColor,
          title: title,
          message: message,
          cancelLabel: cancelLabel,
          cancelColor: cancelColor,
          confirmLabel: confirmLabel,
          confirmColor: confirmColor,
          confirmForegroundColor: confirmForegroundColor,
          confirmIcon: confirmIcon,
          onCancel: () => Navigator.of(dialogContext).pop(false),
          onConfirm: () => Navigator.of(dialogContext).pop(true),
        ),
      ) ??
      false;
}
