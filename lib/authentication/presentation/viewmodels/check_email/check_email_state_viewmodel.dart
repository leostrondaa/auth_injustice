import 'package:signals_flutter/signals_flutter.dart';

class CheckEmailState {
  final loading = signal(false);
  final confirmed = signal(false);
  final errorMessage = signal<String?>(null);

  void setLoading(bool value) {
    loading.value = value;
  }

  void setConfirmed(bool value) {
    confirmed.value = value;
  }

  void showError(String message) {
    errorMessage.value = message;
  }

  void clearError() {
    errorMessage.value = null;
  }

  void reset() {
    setLoading(false);
    setConfirmed(false);
    clearError();
  }
}
