import 'package:autth_injustice_app/core/navigation/app_transitions.dart';
import 'package:autth_injustice_app/settings/presentation/pages/account_page.dart';
import 'package:autth_injustice_app/settings/presentation/pages/about_page.dart';
import 'package:autth_injustice_app/settings/presentation/pages/change_email_page.dart';
import 'package:autth_injustice_app/settings/presentation/pages/change_name_page.dart';
import 'package:autth_injustice_app/settings/presentation/pages/change_password_page.dart';
import 'package:autth_injustice_app/settings/presentation/pages/help_support_page.dart';
import 'package:autth_injustice_app/settings/presentation/pages/settings_page.dart';
import 'package:go_router/go_router.dart';

class SettingsRouteNames {
  static const settings = 'settings';
  static const about = 'about';
  static const helpSupport = 'help-support';
  static const account = 'account';
  static const changeName = 'change-name';
  static const changeEmail = 'change-email';
  static const changePassword = 'change-password';
}

class SettingsPaths {
  static const settings = '/settings';
  static const aboutSegment = 'about';
  static const helpSupportSegment = 'help';
  static const accountSegment = 'account';
  static const changeNameSegment = 'name';
  static const changeEmailSegment = 'email';
  static const changePasswordSegment = 'password';
  static const about = '/settings/about';
  static const helpSupport = '/settings/help';
  static const account = '/settings/account';
  static const changeName = '/settings/account/name';
  static const changeEmail = '/settings/account/email';
  static const changePassword = '/settings/account/password';
}

final settingsRoute = GoRoute(
  path: SettingsPaths.settings,
  name: SettingsRouteNames.settings,
  pageBuilder: (context, state) => NoTransitionPage(
    key: state.pageKey,
    child: const SettingsPage(),
  ),
  routes: [
    GoRoute(
      path: SettingsPaths.helpSupportSegment,
      name: SettingsRouteNames.helpSupport,
      pageBuilder: (context, state) => slidePage(
        key: state.pageKey,
        child: const HelpSupportPage(),
      ),
    ),
    GoRoute(
      path: SettingsPaths.aboutSegment,
      name: SettingsRouteNames.about,
      pageBuilder: (context, state) => slidePage(
        key: state.pageKey,
        child: const AboutPage(),
      ),
    ),
    GoRoute(
      path: SettingsPaths.accountSegment,
      name: SettingsRouteNames.account,
      pageBuilder: (context, state) => slidePage(
        key: state.pageKey,
        child: const AccountPage(),
      ),
      routes: [
        GoRoute(
          path: SettingsPaths.changeNameSegment,
          name: SettingsRouteNames.changeName,
          pageBuilder: (context, state) => slidePage(
            key: state.pageKey,
            child: const ChangeNamePage(),
          ),
        ),
        GoRoute(
          path: SettingsPaths.changeEmailSegment,
          name: SettingsRouteNames.changeEmail,
          pageBuilder: (context, state) => slidePage(
            key: state.pageKey,
            child: const ChangeEmailPage(),
          ),
        ),
        GoRoute(
          path: SettingsPaths.changePasswordSegment,
          name: SettingsRouteNames.changePassword,
          pageBuilder: (context, state) => slidePage(
            key: state.pageKey,
            child: const ChangePasswordPage(),
          ),
        ),
      ],
    ),
  ],
);
