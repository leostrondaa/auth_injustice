import '../../../domain/facades/i_auth_use_case_facade.dart';
import '../../commands/auth_commands.dart';
import 'forgot_commands_viewmodel.dart';
import 'forgot_state_viewmodel.dart';

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
