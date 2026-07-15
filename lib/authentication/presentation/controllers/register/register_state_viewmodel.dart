import 'package:signals_flutter/signals_flutter.dart';

class RegisterState {
  /// Indica se há uma operação em andamento
  final loading = signal(false);

  /// Mensagem de erro exibida na tela
  final errorMessage = signal<String?>(null);

  // ----------------------------------------------------------
  // Loading
  // ----------------------------------------------------------

  void setLoading(bool value) {
    loading.value = value;
  }

  // ----------------------------------------------------------
  // Erros
  // ----------------------------------------------------------

  void showError(String message) {
    errorMessage.value = message;
  }

  Future<void> showTemporaryError(String message) async {
  showError(message);

  await Future.delayed(const Duration(seconds: 3));

  clearError();
}

  void clearError() {
    errorMessage.value = null;
  }

  // ==========================================================
  // FUTURO
  // ==========================================================
  //
  // final success = signal(false);
  //
  // final emailVerificationSent = signal(false);
  //
  // final accountCreated = signal<AuthSession?>(null);
  //
  // void setSuccess(bool value) { ... }
  //
  // void setEmailVerificationSent(bool value) { ... }
  //
  // ==========================================================
}
