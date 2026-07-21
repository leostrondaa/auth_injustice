import 'package:autth_injustice_app/authentication/presentation/viewmodels/auth/auth_session_viewmodel.dart';
import 'package:autth_injustice_app/core/l10n/locale_controller.dart';
import 'package:autth_injustice_app/core/theme/theme_controller.dart';

import 'settings_state_viewmodel.dart';

class SettingsCommands {
  final SettingsState state;
  final ThemeController _themeController;
  final LocaleController _localeController;
  final AuthSessionViewModel _authSession;

  SettingsCommands({
    required this.state,
    required ThemeController themeController,
    required LocaleController localeController,
    required AuthSessionViewModel authSession,
  })  : _themeController = themeController,
        _localeController = localeController,
        _authSession = authSession;

  void setDarkMode(bool enabled) {
    _themeController.setDarkMode(enabled);
  }

  void setNotificationsEnabled(bool enabled) {
    // Futuro: persistir esta preferência no perfil do usuário.
    state.setNotificationsEnabled(enabled);
  }

  void cycleLanguage(String currentLanguageCode) {
    _localeController.cycleLanguage(currentLanguageCode);
  }

  Future<bool> signOut() async {
    if (state.loading.value) return false;

    state
      ..setLoading(true)
      ..setError(null);

    try {
      await _authSession.commands.signOut();
      final result = _authSession.commands.signOutCommand.result.value;

      if (result == null) {
        return false;
      }

      return result.fold(
        onSuccess: (_) => true,
        onFailure: (failure) {
          state.setError(failure.msg);
          return false;
        },
      );
    } finally {
      state.setLoading(false);
    }
  }
}
