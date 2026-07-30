import 'package:autth_injustice_app/account/domain/models/account_name.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ChangeNameState {
  final loading = signal(false);
  final errorMessage = signal<String?>(null);
  final success = signal(false);
  final currentName = signal<AccountName?>(null);

  void setLoading(bool value) => loading.value = value;

  void setSuccess(bool value) => success.value = value;

  void setCurrentName(AccountName value) => currentName.value = value;

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
    currentName.value = null;
  }
}
