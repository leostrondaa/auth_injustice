import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_entrance_transition.dart';
import 'package:autth_injustice_app/settings/presentation/widgets/about/about_identity.dart';
import 'package:autth_injustice_app/settings/presentation/widgets/about/about_team_member.dart';
import 'package:autth_injustice_app/settings/presentation/widgets/settings/settings_option_tile.dart';
import 'package:autth_injustice_app/settings/presentation/widgets/settings/settings_panel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(context.l10n.settingsComingSoon)),
      );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final scale = responsive.layoutScale;
    final textScale = responsive.textScale;
    final topPadding = responsive.isCompact ? 12.0 : 18.0;
    final bottomPadding = (36 * scale).clamp(28.0, 48.0);

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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.l10n.settingsAbout,
                    style: context.displayLarge?.copyWith(
                      color: context.onTertiary,
                      fontSize: 48 * textScale,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30 * scale),
              AppEntranceTransition(
                delay: const Duration(milliseconds: 95),
                child: SettingsPanel(
                  scale: scale,
                  child: AboutIdentity(
                    scale: scale,
                    textScale: textScale,
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
                        title: context.l10n.aboutTeam,
                        textScale: textScale,
                      ),
                      SizedBox(height: 22 * scale),
                      Row(
                        children: [
                          AboutTeamMember(
                            name: 'Leonardo',
                            role: context.l10n.aboutDeveloperRole,
                            scale: scale,
                            textScale: textScale,
                          ),
                          SizedBox(width: 16 * scale),
                          AboutTeamMember(
                            name: 'Mateus',
                            role: context.l10n.aboutDeveloperRole,
                            scale: scale,
                            textScale: textScale,
                          ),
                        ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SettingsSectionTitle(
                        title: context.l10n.aboutLegalInformation,
                        textScale: textScale,
                      ),
                      SizedBox(height: 12 * scale),
                      SettingsOptionTile(
                        icon: Icons.privacy_tip_outlined,
                        label: context.l10n.aboutPrivacyPolicy,
                        scale: scale,
                        textScale: textScale,
                        showChevron: true,
                        onTap: () => _showComingSoon(context),
                      ),
                      SettingsOptionTile(
                        icon: Icons.description_outlined,
                        label: context.l10n.aboutTermsOfUse,
                        scale: scale,
                        textScale: textScale,
                        showChevron: true,
                        onTap: () => _showComingSoon(context),
                      ),
                    ],
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
