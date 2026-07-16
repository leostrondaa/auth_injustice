import 'check_email_state_viewmodel.dart';

class CheckEmailCommands {
  static const fakeConfirmationDelay = Duration(seconds: 4);

  final CheckEmailState state;

  CheckEmailCommands({  
    required this.state,
  });

  Future<void> waitForConfirmation({
    required String email,
  }) async {
    state.setLoading(true);
    state.clearError();

    try {
      await Future.delayed(fakeConfirmationDelay);

      // Temporario
      state.setConfirmed(true);
    } catch (_) {
      state.showError('Nao foi possivel confirmar o email.');
    } finally {
      state.setLoading(false);
    }
  }
}
