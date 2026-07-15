import 'package:autth_injustice_app/authentication/presentation/commands/auth_commands.dart';
import 'package:autth_injustice_app/authentication/presentation/controllers/register/register_state_viewmodel.dart';

class RegisterCommands {
  final RegisterState state;

  final SignUpCommand _signUpCommand;

  RegisterCommands({
    required this.state,
    required SignUpCommand signUpCommand,
  }) : _signUpCommand = signUpCommand;

  Future<void> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    state.setLoading(true);
    state.clearError();

    // ==========================================================
    // TODO:
    // await _signUpCommand.executeWith((
    //   email: email,
    //   password: password,
    //   name: name,
    // ));
    //
    // Observar o resultado do command e atualizar o RegisterState:
    // - loading
    // - mensagens de erro
    // - sucesso do cadastro
    // - redirecionamento
    // ==========================================================

    // Simulação temporária
    await Future.delayed(const Duration(seconds: 2));

    state.setLoading(false);

    state.showError('Erro ao criar conta');

    await Future.delayed(const Duration(seconds: 3));

    state.clearError();
  }

  // ==========================================================
  // FUTURO
  // ==========================================================
  //
  // Future<void> resendVerificationEmail()
  //
  // Future<void> verifyEmail()
  //
  // Future<void> cancelRegister()
  //
  // ==========================================================
}
