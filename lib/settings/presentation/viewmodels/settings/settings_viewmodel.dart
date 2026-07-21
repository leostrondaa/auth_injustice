import 'package:autth_injustice_app/authentication/presentation/viewmodels/auth/auth_session_viewmodel.dart';
import 'package:autth_injustice_app/core/l10n/locale_controller.dart';
import 'package:autth_injustice_app/core/theme/theme_controller.dart';

import 'settings_commands_viewmodel.dart';
import 'settings_state_viewmodel.dart';

class SettingsViewModel {
  late final SettingsState _state;
  late final SettingsCommands _commands;

  SettingsState get state => _state;
  SettingsCommands get commands => _commands;

  SettingsViewModel(
    ThemeController themeController,
    LocaleController localeController,
    AuthSessionViewModel authSession,
  ) {
    _state = SettingsState();
    _commands = SettingsCommands(
      state: _state,
      themeController: themeController,
      localeController: localeController,
      authSession: authSession,
    );
  }
}
