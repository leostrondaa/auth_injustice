import 'package:autth_injustice_app/authentication/domain/facades/i_password_reset_facade.dart';

import 'password_reset_commands_viewmodel.dart';
import 'password_reset_state_viewmodel.dart';

class PasswordResetViewModel {
  late final PasswordResetState _state;
  late final PasswordResetCommands _commands;

  PasswordResetState get state => _state;
  PasswordResetCommands get commands => _commands;

  PasswordResetViewModel(IPasswordResetFacade facade) {
    _state = PasswordResetState();
    _commands = PasswordResetCommands(
      state: _state,
      passwordResetFacade: facade,
    );
  }
}
