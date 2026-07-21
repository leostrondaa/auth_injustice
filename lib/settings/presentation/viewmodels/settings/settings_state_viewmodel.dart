import 'package:signals_flutter/signals_flutter.dart';

class SettingsState {
  final loading = signal(false);
  final notificationsEnabled = signal(true);
  final errorMessage = signal<String?>(null);

  void setLoading(bool value) {
    loading.value = value;
  }

  void setNotificationsEnabled(bool value) {
    notificationsEnabled.value = value;
  }

  void setError(String? message) {
    errorMessage.value = message;
  }
}
