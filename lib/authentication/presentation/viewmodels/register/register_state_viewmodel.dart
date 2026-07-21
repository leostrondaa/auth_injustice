import 'package:signals_flutter/signals_flutter.dart';

class RegisterState {
  /// Indica se há uma operação em andamento
  final loading = signal(false);

  /// Mensagem de erro e sucesso exibida na tela
  final errorMessage = signal<String?>(null);
  final success = signal(false);

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

  void setSuccess(bool value) {
    success.value = value;
  }

  void reset() {
    loading.value = false;
    errorMessage.value = null;
    success.value = false;
  }

  Future<void> showTemporaryError(String message) async {
    showError(message);

    await Future.delayed(const Duration(seconds: 3));

    clearError();
  }

  void clearError() {
    errorMessage.value = null;
  }
}
