import 'package:autth_injustice_app/account/domain/facades/i_account_facade.dart';

import 'change_name_commands_viewmodel.dart';
import 'change_name_state_viewmodel.dart';

class ChangeNameViewModel {
  late final ChangeNameState _state;
  late final ChangeNameCommands _commands;

  ChangeNameState get state => _state;
  ChangeNameCommands get commands => _commands;

  ChangeNameViewModel(IAccountFacade facade) {
    _state = ChangeNameState();
    _commands = ChangeNameCommands(
      state: _state,
      accountFacade: facade,
    );
  }
}
