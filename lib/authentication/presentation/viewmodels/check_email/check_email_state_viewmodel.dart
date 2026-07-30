import 'package:signals_flutter/signals_flutter.dart';

class CheckEmailState {
  final loading = signal(false);
  final resending = signal(false);
  final confirmed = signal(false);
  final actionCode = signal<String?>(null);
  final errorMessage = signal<String?>(null);

  void setLoading(bool value) {
    loading.value = value;
  }

  void setConfirmation({
    required bool value,
    String? actionCode,
  }) {
    confirmed.value = value;
    this.actionCode.value = value ? actionCode : null;
  }

  void setResending(bool value) {
    resending.value = value;
  }

  void showError(String message) {
    errorMessage.value = message;
  }

  void clearError() {
    errorMessage.value = null;
  }

  void reset() {
    setLoading(false);
    setResending(false);
    setConfirmation(value: false);
    clearError();
  }
}
