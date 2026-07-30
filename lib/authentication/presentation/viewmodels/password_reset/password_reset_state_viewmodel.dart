import 'package:signals_flutter/signals_flutter.dart';

class PasswordResetState {
  final loading = signal(false);
  final success = signal(false);
  final errorMessage = signal<String?>(null);

  void setLoading(bool value) => loading.value = value;

  void setSuccess(bool value) => success.value = value;

  void showError(String message) => errorMessage.value = message;

  void clearError() => errorMessage.value = null;

  void reset() {
    setLoading(false);
    setSuccess(false);
    clearError();
  }
}
