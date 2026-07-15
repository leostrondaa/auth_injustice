import 'package:signals_flutter/signals_flutter.dart';

class LoginState {
  final _loading = signal(false);
  final _errorMessage = signal<String?>(null);

  ReadonlySignal<bool> get loading => _loading.readonly();
  ReadonlySignal<String?> get errorMessage => _errorMessage.readonly();

  void setLoading(bool value) {
    _loading.value = value;
  }

  void showError(String message) {
    _errorMessage.value = message;

    Future.delayed(const Duration(seconds: 3), () {
      if (_errorMessage.value == message) {
        _errorMessage.value = null;
      }
    });
  }

  void clearError() {
    _errorMessage.value = null;
  }
}
