import 'package:autth_injustice_app/authentication/domain/facades/i_auth_use_case_facade.dart';
import 'package:autth_injustice_app/authentication/presentation/commands/auth_commands.dart';
import 'verify_commands_viewmodel.dart';
import 'verify_state_viewmodel.dart';

class LoginViewModel {
  late final LoginState _state;
  late final LoginCommands _commands;

  LoginState get state => _state;
  LoginCommands get commands => _commands;

  LoginViewModel(IAuthUseCaseFacade facade) {
    _state = LoginState();

    _commands = LoginCommands(
      state: _state,
      signInCommand: SignInCommand(facade),
      signInWithGoogleCommand: SignInWithGoogleCommand(facade),
    );
  }
}
