import 'package:signals_flutter/signals_flutter.dart';

class ChangeEmailState {
  final loading = signal(false);
  final errorMessage = signal<String?>(null);
  final success = signal(false);

  void setLoading(bool value) => loading.value = value;

  void setSuccess(bool value) => success.value = value;

  void clearError() => errorMessage.value = null;

  void setError(String message) => errorMessage.value = message;

  Future<void> showTemporaryError(String message) async {
    errorMessage.value = message;
    await Future<void>.delayed(const Duration(seconds: 3));

    if (errorMessage.value == message) clearError();
  }

  void reset() {
    loading.value = false;
    errorMessage.value = null;
    success.value = false;
  }
}
