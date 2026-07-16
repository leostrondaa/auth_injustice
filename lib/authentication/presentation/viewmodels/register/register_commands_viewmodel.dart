import 'package:autth_injustice_app/authentication/presentation/commands/register_commands.dart';
import 'package:autth_injustice_app/authentication/presentation/viewmodels/register/register_state_viewmodel.dart';

/// Responsável por observar os Commands do cadastro
/// e sincronizar o estado reativo da tela.
///
/// Não dispara ações diretamente.
/// Apenas observa os Commands e atualiza o RegisterState.
///
/// Atualmente permanece sem observers, pois o backend
/// ainda não foi integrado.
class RegisterCommandsViewModel {
  final RegisterState state;
  final RegisterCommands commands;

  RegisterCommandsViewModel({
    required this.state,
    required this.commands,
  }) {
    // ==========================================================
    // Futuramente:
    //
    // _observeSignUp();
    //
    // ==========================================================
  }

  // ==========================================================
  // FUTURO
  // ==========================================================

  // void _observeSignUp() {
  //   effect(() {
  //     if (commands.signUpCommand.isExecuting.value) {
  //       state.setLoading(true);
  //       return;
  //     }
  //
  //     state.setLoading(false);
  //
  //     final result = commands.signUpCommand.result.value;
  //     if (result == null) return;
  //
  //     result.fold(
  //       onSuccess: (_) {
  //         // Navegar para próxima tela
  //         // ou solicitar verificação de e-mail
  //       },
  //       onFailure: (failure) async {
  //         await state.showTemporaryError(failure.msg);
  //       },
  //     );
  //   });
  // }

  // ==========================================================
}
