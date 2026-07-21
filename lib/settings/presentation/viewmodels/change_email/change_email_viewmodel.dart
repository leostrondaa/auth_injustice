import 'package:autth_injustice_app/settings/domain/facades/i_account_security_facade.dart';

import 'change_email_commands_viewmodel.dart';
import 'change_email_state_viewmodel.dart';

class ChangeEmailViewModel {
  late final ChangeEmailState _state;
  late final ChangeEmailCommands _commands;

  ChangeEmailState get state => _state;
  ChangeEmailCommands get commands => _commands;

  ChangeEmailViewModel(IAccountSecurityFacade facade) {
    _state = ChangeEmailState();
    _commands = ChangeEmailCommands(
      state: _state,
      accountSecurityFacade: facade,
    );
  }
}
