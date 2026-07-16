import 'package:signals_flutter/signals_flutter.dart';

class LoginState {
  final loading = signal(false);
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

  void clearError() {
    errorMessage.value = null;
  }

  Future<void> showTemporaryError(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) async {
    showError(message);

    await Future.delayed(duration);

    clearError();
  }
}
