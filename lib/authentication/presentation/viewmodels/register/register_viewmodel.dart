import 'package:autth_injustice_app/authentication/domain/facades/i_auth_use_case_facade.dart';
import 'package:autth_injustice_app/authentication/presentation/commands/auth_commands.dart';

import 'package:autth_injustice_app/authentication/presentation/commands/register_commands.dart';
import 'register_state_viewmodel.dart';

class RegisterViewModel {
  late final RegisterState _state;
  late final RegisterCommands _commands;

  RegisterState get state => _state;
  RegisterCommands get commands => _commands;

  RegisterViewModel(IAuthUseCaseFacade facade) {
    _state = RegisterState();

    _commands = RegisterCommands(
      state: _state,
      signUpCommand: SignUpCommand(facade),
    );
  }
}
