import 'package:autth_injustice_app/authentication/presentation/commands/auth_commands.dart';

import 'verify_state_viewmodel.dart';

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
      state.showError("E-mail ou senha incorretos");

      await Future.delayed(const Duration(seconds: 3));

      state.clearError();
    } finally {
      state.setLoading(false);
    }
  }
}
