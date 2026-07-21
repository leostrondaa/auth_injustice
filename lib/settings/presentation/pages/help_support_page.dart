import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:autth_injustice_app/settings/presentation/widgets/help/help_topic_tile.dart';
import 'package:autth_injustice_app/settings/presentation/widgets/help/support_contact.dart';
import 'package:autth_injustice_app/settings/presentation/widgets/settings/settings_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class HelpSupportPage extends StatelessWidget {
  static const _supportEmail = 'mateus@ifpr.edu.br';

  const HelpSupportPage({super.key});

  Future<void> _copySupportEmail(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: _supportEmail));
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(context.l10n.helpEmailCopied)),
      );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final scale = responsive.layoutScale;
    final textScale = responsive.textScale;
    final topPadding = responsive.isCompact ? 12.0 : 18.0;
    final bottomPadding = (36 * scale).clamp(28.0, 48.0);

    final topics = [
      (
        icon: Icons.verified_outlined,
        title: context.l10n.helpPersonalHistoryTitle,
        explanation: context.l10n.helpPersonalHistoryDescription,
      ),
      (
        icon: Icons.schedule_outlined,
        title: context.l10n.helpHoursTitle,
        explanation: context.l10n.helpHoursDescription,
      ),
      (
        icon: Icons.swipe_outlined,
        title: context.l10n.helpRecordsTitle,
        explanation: context.l10n.helpRecordsDescription,
      ),
      (
        icon: Icons.notifications_none_rounded,
        title: context.l10n.helpNotificationsTitle,
        explanation: context.l10n.helpNotificationsDescription,
      ),
      (
        icon: Icons.manage_accounts_outlined,
        title: context.l10n.helpAccountTitle,
        explanation: context.l10n.helpAccountDescription,
      ),
    ];

    return Scaffold(
      backgroundColor: context.tertiary,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: context.extraPagePadding.copyWith(
            top: topPadding,
            bottom: bottomPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppEntranceTransition(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    tooltip:
                        MaterialLocalizations.of(context).backButtonTooltip,
                    onPressed: context.pop,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 25 * scale,
                      color: context.onTertiary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18 * scale),
              AppEntranceTransition(
                delay: const Duration(milliseconds: 45),
                child: Text(
                  context.l10n.settingsHelpSupport,
                  style: context.displayLarge?.copyWith(
                    color: context.onTertiary,
                    fontSize: 48 * textScale,
                  ),
                ),
              ),
              SizedBox(height: 30 * scale),
              AppEntranceTransition(
                delay: const Duration(milliseconds: 95),
                child: SettingsPanel(
                  scale: scale,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50 * scale,
                        height: 50 * scale,
                        decoration: BoxDecoration(
                          color: context.secondary.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                        child: Icon(
                          Icons.lightbulb_outline_rounded,
                          color: context.secondary,
                          size: 27 * scale,
                        ),
                      ),
                      SizedBox(width: 15 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.helpIntroTitle,
                              style: context.titleLarge?.copyWith(
                                color: context.onTertiary,
                                fontSize: 18 * textScale,
                              ),
                            ),
                            SizedBox(height: 7 * scale),
                            Text(
                              context.l10n.helpIntroDescription,
                              style: context.bodySmall?.copyWith(
                                color: context.onTertiary.withValues(
                                  alpha: 0.62,
                                ),
                                fontSize: 11.5 * textScale,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18 * scale),
              AppEntranceTransition(
                delay: const Duration(milliseconds: 145),
                child: SettingsPanel(
                  scale: scale,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SettingsSectionTitle(
                        title: context.l10n.helpTopicsTitle,
                        textScale: textScale,
                      ),
                      SizedBox(height: 10 * scale),
                      for (final topic in topics)
                        HelpTopicTile(
                          icon: topic.icon,
                          title: topic.title,
                          explanation: topic.explanation,
                          scale: scale,
                          textScale: textScale,
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18 * scale),
              AppEntranceTransition(
                delay: const Duration(milliseconds: 195),
                child: SettingsPanel(
                  scale: scale,
                  child: SupportContact(
                    email: _supportEmail,
                    scale: scale,
                    textScale: textScale,
                    onCopyEmail: () => _copySupportEmail(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
