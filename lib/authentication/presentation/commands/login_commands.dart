import 'package:autth_injustice_app/authentication/presentation/commands/auth_commands.dart';
import 'package:autth_injustice_app/authentication/presentation/controllers/login/login_state_viewmodel.dart';

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

    try {
      await _signInCommand.executeWith((
        email: email,
        password: password,
      ));
    } finally {
      state.setLoading(false);
    }
  }


  Future<void> signInWithGoogle() async {
    state.setLoading(true);

    try {
      await _signInWithGoogleCommand.executeWith(());
    } finally {
      state.setLoading(false);
    }
  }
}
