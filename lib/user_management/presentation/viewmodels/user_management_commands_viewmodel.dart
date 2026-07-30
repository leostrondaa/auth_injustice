import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/user_management/presentation/commands/user_management_commands.dart';
import 'package:autth_injustice_app/user_management/presentation/viewmodels/user_management_state_viewmodel.dart';

class UserManagementCommands {
  final UserManagementState state;
  final LoadManagedUsersCommand _loadUsersCommand;

  const UserManagementCommands({
    required this.state,
    required LoadManagedUsersCommand loadUsersCommand,
  }) : _loadUsersCommand = loadUsersCommand;

  Future<void> loadUsers({bool forceRefresh = false}) async {
    if (state.loading.value || (!forceRefresh && state.hasLoaded)) return;

    state.setLoading(true);
    state.clearError();
    try {
      final result = await _loadUsersCommand.executeWith(());
      result.fold(
        onSuccess: state.setUsers,
        onFailure: (failure) => state.showError(failure.msg),
      );
    } finally {
      state.setLoading(false);
    }
  }

  void selectRole(AccountRole? role) => state.selectRole(role);

  void search(String value) => state.setSearchQuery(value);

  void cycleSort() => state.cycleSortMode();

  void resetFilters() {
    state.selectRole(null);
    state.setSearchQuery('');
    state.resetSort();
  }
}
