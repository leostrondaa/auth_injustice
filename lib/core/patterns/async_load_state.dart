import 'package:signals_flutter/signals_flutter.dart';

mixin AsyncLoadState {
  final loading = signal(false);
  final loaded = signal(false);
  final errorMessage = signal<String?>(null);

  bool get hasLoaded => loaded.value;
  bool get isInitialLoading => loading.value && !hasLoaded;
  bool get isRefreshing => loading.value && hasLoaded;
  bool get hasInitialError => errorMessage.value != null && !hasLoaded;

  void setLoading(bool value) {
    loading.value = value;
  }

  void markLoaded() {
    loaded.value = true;
  }

  void showError(String message) {
    errorMessage.value = message;
  }

  void clearError() {
    errorMessage.value = null;
  }
}
