import 'package:autth_injustice_app/settings/domain/facades/i_account_security_facade.dart';

import 'change_password_commands_viewmodel.dart';
import 'change_password_state_viewmodel.dart';

class ChangePasswordViewModel {
  late final ChangePasswordState _state;
  late final ChangePasswordCommands _commands;

  ChangePasswordState get state => _state;
  ChangePasswordCommands get commands => _commands;

  ChangePasswordViewModel(IAccountSecurityFacade facade) {
    _state = ChangePasswordState();
    _commands = ChangePasswordCommands(
      state: _state,
      accountSecurityFacade: facade,
    );
  }
}
