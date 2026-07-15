import 'package:autth_injustice_app/authentication/domain/facades/i_auth_use_case_facade.dart';
import 'package:autth_injustice_app/authentication/presentation/commands/auth_commands.dart';

import '../../commands/register_commands.dart';
import 'register_commands_viewmodel.dart';
import 'register_state_viewmodel.dart';

class RegisterViewModel {
  late final RegisterState _state;
  late final RegisterCommands _commands;

  /// Responsável por observar os Commands e atualizar o estado.
  /// Atualmente permanece sem observers, pois o fluxo de cadastro
  /// ainda está sendo simulado. Será utilizado quando o backend
  /// for integrado.
  late final RegisterCommandsViewModel _commandsViewModel;

  RegisterState get state => _state;
  RegisterCommands get commands => _commands;

  

  RegisterViewModel(IAuthUseCaseFacade facade) {
    
    _state = RegisterState();

    _commands = RegisterCommands(
      state: _state,
      signUpCommand: SignUpCommand(facade),
    );

    _commandsViewModel = RegisterCommandsViewModel(
      state: _state,
      commands: _commands,
    );
  }
}
