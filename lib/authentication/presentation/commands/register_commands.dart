import 'package:autth_injustice_app/authentication/presentation/commands/auth_commands.dart';
import 'package:autth_injustice_app/authentication/presentation/viewmodels/register/register_state_viewmodel.dart';

class RegisterCommands {
  final RegisterState state;

  final SignUpCommand _signUpCommand;

  RegisterCommands({
    required this.state,
    required SignUpCommand signUpCommand,
  }) : _signUpCommand = signUpCommand;

  Future<bool> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    state.setLoading(true);
    state.clearError();
    state.setSuccess(false);

    try {
      final result = await _signUpCommand.executeWith((
        email: email,
        password: password,
        name: name,
      ));

      return result.fold(
        onSuccess: (_) {
          state.setSuccess(true);
          return true;
        },
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
