import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/user_management/domain/models/managed_user_details.dart';
import 'package:autth_injustice_app/user_management/domain/models/user_directory_entry.dart';
import 'package:signals_flutter/signals_flutter.dart';

class UserDetailsState {
  final loading = signal(false);
  final updatingRole = signal(false);
  final pendingRole = signal<AccountRole?>(null);
  final details = signal<ManagedUserDetails?>(null);
  final errorMessage = signal<String?>(null);

  void setLoading(bool value) => loading.value = value;

  void setUpdatingRole(AccountRole? role) {
    pendingRole.value = role;
    updatingRole.value = role != null;
  }

  void setDetails(ManagedUserDetails value) => details.value = value;

  void updateUser(UserDirectoryEntry user) {
    final current = details.value;
    if (current == null) return;
    details.value = current.copyWith(user: user);
  }

  void showError(String message) => errorMessage.value = message;

  void clearError() => errorMessage.value = null;

  void reset() {
    loading.value = false;
    updatingRole.value = false;
    pendingRole.value = null;
    details.value = null;
    errorMessage.value = null;
  }
}
