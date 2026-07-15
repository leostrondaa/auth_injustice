import '../../../data/repositories/i_auth_repository.dart';
import '../../../domain/facades/i_auth_use_case_facade.dart';
import '../../commands/auth_commands.dart';
import 'auth_session_commands_viewmodel.dart';
import 'auth_session_state_viewmodel.dart';

/// ViewModel responsável por expor o estado e os comandos da sessão.
class AuthSessionViewModel {
  late final AuthSessionState _session;
  late final AuthSessionCommands _commands;

  /// Estado reativo da sessão.
  AuthSessionState get session => _session;

  /// Comandos relacionados à autenticação.
  AuthSessionCommands get commands => _commands;

  AuthSessionViewModel(
    IAuthRepository repository,
    IAuthUseCaseFacade facade,
  ) {
    _session = AuthSessionState();

    _commands = AuthSessionCommands(
      repository: repository,
      state: _session,
      signInCommand: SignInCommand(facade),
      signInWithGoogleCommand: SignInWithGoogleCommand(facade),
      signOutCommand: SignOutCommand(facade),
      signUpCommand: SignUpCommand(facade),
    );
  }
}