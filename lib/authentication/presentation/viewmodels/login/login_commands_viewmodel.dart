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

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state.setLoading(true);
    state.clearError();

    try {
      final result = await _signInCommand.executeWith((
        email: email,
        password: password,
      ));

      return result.fold(
        onSuccess: (_) => true,
        onFailure: (failure) {
          state.showError(failure.msg);
          return false;
        },
      );
    } catch (_) {
      state.showError('authUnexpectedError');
      return false;
    } finally {
      state.setLoading(false);
    }
  }

  Future<bool> signInWithGoogle() async {
    state.setLoading(true);
    state.clearError();

    try {
      final result = await _signInWithGoogleCommand.executeWith(());
      return result.fold(
        onSuccess: (_) => true,
        onFailure: (failure) {
          state.showError(failure.msg);
          return false;
        },
      );
    } catch (_) {
      state.showError('authUnexpectedError');
      return false;
    } finally {
      state.setLoading(false);
    }
  }
}
