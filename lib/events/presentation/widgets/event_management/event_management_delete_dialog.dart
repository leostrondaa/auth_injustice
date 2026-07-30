import 'dart:async';

import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:autth_injustice_app/core/widgets/editor/app_editor_error_banner.dart';
import 'package:autth_injustice_app/core/widgets/editor/app_editor_text_field.dart';
import 'package:autth_injustice_app/events/domain/models/event_cancellation.dart';
import 'package:flutter/material.dart';

class EventRemovalDecision {
  final String? cancellationReason;

  const EventRemovalDecision.delete() : cancellationReason = null;

  const EventRemovalDecision.cancel({
    required String reason,
  }) : cancellationReason = reason;

  bool get isCancellation => cancellationReason != null;
}

class EventManagementDeleteDialog extends StatefulWidget {
  final String eventTitle;
  final bool isPublished;
  final VoidCallback onCancel;
  final ValueChanged<EventRemovalDecision> onConfirm;

  const EventManagementDeleteDialog({
    super.key,
    required this.eventTitle,
    required this.isPublished,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<EventManagementDeleteDialog> createState() =>
      _EventManagementDeleteDialogState();
}

class _EventManagementDeleteDialogState
    extends State<EventManagementDeleteDialog> {
  final _reasonController = TextEditingController();
  final _reasonFocus = FocusNode();

  bool _showReason = false;
  bool _submitted = false;
  Timer? _validationErrorTimer;

  @override
  void dispose() {
    _validationErrorTimer?.cancel();
    _reasonController.dispose();
    _reasonFocus.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    if (!widget.isPublished) {
      widget.onConfirm(const EventRemovalDecision.delete());
      return;
    }

    if (!_showReason) {
      setState(() => _showReason = true);
      return;
    }

    final reason = _reasonController.text.trim();
    if (!EventCancellationRules.isValidReason(reason)) {
      _showTemporaryValidationError();
      return;
    }

    widget.onConfirm(EventRemovalDecision.cancel(reason: reason));
  }

  void _showTemporaryValidationError() {
    _validationErrorTimer?.cancel();
    setState(() => _submitted = true);
    _validationErrorTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted || !_submitted) return;
      setState(() => _submitted = false);
    });
  }

  void _clearValidationError() {
    if (!_submitted) return;
    _validationErrorTimer?.cancel();
    setState(() => _submitted = false);
  }

  @override
  Widget build(BuildContext context) {
    final error = context.colors.error;
    if (!widget.isPublished) {
      return AppConfirmationDialog(
        icon: Icons.delete_outline_rounded,
        iconColor: error,
        title: context.l10n.eventManagementDeleteTitle,
        message: context.l10n.eventManagementDeleteMessage(
          widget.eventTitle,
        ),
        cancelLabel: context.l10n.commonCancel,
        cancelColor: context.onTertiary.withValues(alpha: 0.72),
        confirmLabel: context.l10n.commonDelete,
        confirmColor: error,
        confirmForegroundColor: context.colors.onError,
        confirmIcon: Icons.delete_outline_rounded,
        onCancel: widget.onCancel,
        onConfirm: () {
          widget.onConfirm(const EventRemovalDecision.delete());
        },
      );
    }

    final responsive = context.responsive;
    final media = MediaQuery.of(context);
    final keyboardHeight = media.viewInsets.bottom;
    final availableHeight = media.size.height - keyboardHeight;
    final keyboardIsOpen = keyboardHeight > 0;
    final compactForm =
        _showReason && (responsive.isVeryCompact || availableHeight < 570);
    final showNotificationPreview = !compactForm || !keyboardIsOpen;
    final horizontalInset = responsive.scaled(22, min: 14, max: 28);
    final verticalInset = compactForm ? 8.0 : 24.0;
    final horizontalContentPadding = responsive.scaled(20, min: 14, max: 20);
    final titleTopPadding = !_showReason ? 6.0 : (compactForm ? 14.0 : 20.0);
    final reasonIsInvalid = _submitted &&
        !EventCancellationRules.isValidReason(_reasonController.text);
    final reasonError = reasonIsInvalid
        ? context.l10n.eventManagementInvalidCancelReason
        : null;

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: horizontalInset,
        vertical: verticalInset,
      ),
      iconPadding: EdgeInsets.fromLTRB(
        horizontalContentPadding,
        responsive.scaled(18, min: 14, max: 20),
        horizontalContentPadding,
        4,
      ),
      titlePadding: EdgeInsets.fromLTRB(
        horizontalContentPadding,
        titleTopPadding,
        horizontalContentPadding,
        0,
      ),
      contentPadding: EdgeInsets.fromLTRB(
        horizontalContentPadding,
        compactForm ? 6 : 10,
        horizontalContentPadding,
        4,
      ),
      actionsPadding: EdgeInsets.fromLTRB(
        12,
        compactForm ? 0 : 4,
        12,
        compactForm ? 8 : 12,
      ),
      backgroundColor: context.tertiary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: context.onTertiary.withValues(alpha: 0.09),
        ),
      ),
      icon: !_showReason
          ? Container(
              width: responsive.scaled(44, min: 38, max: 48),
              height: responsive.scaled(44, min: 38, max: 48),
              decoration: BoxDecoration(
                color: error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.isPublished
                    ? Icons.event_busy_outlined
                    : Icons.delete_outline_rounded,
                size: responsive.scaled(24, min: 21, max: 26),
                color: error,
              ),
            )
          : null,
      title: Text(
        widget.isPublished
            ? context.l10n.eventManagementCancelTitle
            : context.l10n.eventManagementDeleteTitle,
        textAlign: TextAlign.center,
        style: context.text.titleMedium?.copyWith(
          color: context.onTertiary,
          fontWeight: FontWeight.w700,
          fontSize: responsive.scaled(18, min: 16, max: 19),
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.isPublished
                    ? context.l10n.eventManagementCancelMessage(
                        widget.eventTitle,
                      )
                    : context.l10n.eventManagementDeleteMessage(
                        widget.eventTitle,
                      ),
                textAlign: TextAlign.center,
                style: context.bodyMedium?.copyWith(
                  color: context.onTertiary.withValues(alpha: 0.66),
                  fontSize: responsive.scaled(14, min: 12, max: 14),
                  height: compactForm ? 1.25 : 1.35,
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                child: _showReason
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: compactForm ? 10 : 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (showNotificationPreview) ...[
                              _NotificationPreview(
                                eventTitle: widget.eventTitle,
                                compact: compactForm,
                              ),
                              SizedBox(height: compactForm ? 8 : 12),
                            ],
                            AppEditorTextField(
                              controller: _reasonController,
                              focusNode: _reasonFocus,
                              label: "",
                              hintText:
                                  context.l10n.eventManagementCancelReasonHint,
                              alwaysShowHint: true,
                              maxLines: compactForm ? 2 : 3,
                              maxLength: EventCancellationRules.reasonMaxLength,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              onChanged: (_) => _clearValidationError(),
                            ),
                            AppEditorErrorBanner(message: reasonError),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: widget.onCancel,
          style: TextButton.styleFrom(
            foregroundColor: context.onTertiary.withValues(alpha: 0.72),
          ),
          child: Text(context.l10n.commonCancel),
        ),
        if (_showReason)
          FilledButton(
            onPressed: _handleConfirm,
            style: FilledButton.styleFrom(
              backgroundColor: error,
              foregroundColor: context.colors.onError,
            ),
            child: Text(context.l10n.eventManagementConfirmCancellation),
          )
        else
          FilledButton.icon(
            onPressed: _handleConfirm,
            icon: Icon(
              widget.isPublished
                  ? Icons.arrow_forward_rounded
                  : Icons.delete_outline_rounded,
              size: 18,
            ),
            label: Text(
              widget.isPublished
                  ? context.l10n.continueButton
                  : context.l10n.commonDelete,
            ),
            style: FilledButton.styleFrom(
              backgroundColor: error,
              foregroundColor: context.colors.onError,
            ),
          ),
      ],
    );
  }
}

class _NotificationPreview extends StatelessWidget {
  final String eventTitle;
  final bool compact;

  const _NotificationPreview({
    required this.eventTitle,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(compact ? 10 : 14),
      decoration: BoxDecoration(
        color: context.secondary.withValues(
          alpha: context.isDarkMode ? 0.12 : 0.07,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: context.secondary.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications_active_outlined,
            size: compact ? 18 : 21,
            color: context.secondary,
          ),
          SizedBox(width: compact ? 8 : 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.eventManagementCampusNotification,
                  style: context.text.labelSmall?.copyWith(
                    color: context.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: compact ? 2 : 4),
                Text(
                  context.l10n.eventManagementCancellationNotificationTitle(
                    eventTitle,
                  ),
                  style: context.text.bodyMedium?.copyWith(
                    color: context.onTertiary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
