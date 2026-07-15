import 'package:autth_injustice_app/authentication/presentation/commands/auth_commands.dart';

import 'login_state_viewmodel.dart';

class LoginCommands {
  final LoginState state;

  final SignInCommand _signInCommand;
  final SignInWithGoogleCommand _signInWithGoogleCommand;

  LoginCommands({
    required this.state,
    required SignInCommand signInCommand,
    required SignInWithGoogleCommand signInWithGoogleCommand,
  })  : _signInCommand = signInCommand,
        _signInWithGoogleCommand = signInWithGoogleCommand;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state.setLoading(true);
    state.clearError();

    try {
      await _signInCommand.executeWith((
        email: email,
        password: password,
      ));
    } catch (_) {
      await state.showTemporaryError(
        "Email ou senha incorretos",
      );
    } finally {
      state.setLoading(false);
    }
  }
}
