import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/dialogs/app_confirmation_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showUserRoleChangeDialog({
  required BuildContext context,
  required String userName,
  required AccountRole targetRole,
}) async {
  final promoting = targetRole == AccountRole.eventManager;

  final accent = promoting ? context.secondary : context.colors.error;

  return showAppConfirmationDialog(
    context: context,
    icon: promoting
        ? Icons.manage_accounts_outlined
        : Icons.person_remove_outlined,
    iconColor: accent,
    title: promoting
        ? context.l10n.userDetailsPromoteTitle
        : context.l10n.userDetailsDemoteTitle,
    message: promoting
        ? context.l10n.userDetailsPromoteMessage(userName)
        : context.l10n.userDetailsDemoteMessage(userName),
    cancelLabel: context.l10n.commonCancel,
    cancelColor: context.onTertiary.withValues(alpha: 0.72),
    confirmLabel: promoting
        ? context.l10n.userDetailsPromote
        : context.l10n.userDetailsDemote,
    confirmColor: accent,
    confirmForegroundColor:
        promoting ? context.onSecondary : context.colors.onError,
    confirmIcon:
        promoting ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
  );
}
