import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/user_management/presentation/commands/user_management_commands.dart';

import 'user_details_state_viewmodel.dart';

class UserDetailsCommands {
  final UserDetailsState state;
  final LoadManagedUserDetailsCommand _loadDetailsCommand;
  final UpdateManagedUserRoleCommand _updateRoleCommand;

  const UserDetailsCommands({
    required this.state,
    required LoadManagedUserDetailsCommand loadDetailsCommand,
    required UpdateManagedUserRoleCommand updateRoleCommand,
  })  : _loadDetailsCommand = loadDetailsCommand,
        _updateRoleCommand = updateRoleCommand;

  Future<void> load(String userId) async {
    if (state.loading.value) return;

    state
      ..setLoading(true)
      ..clearError();
    try {
      final result = await _loadDetailsCommand.executeWith((userId: userId));
      result.fold(
        onSuccess: state.setDetails,
        onFailure: (failure) => state.showError(failure.msg),
      );
    } catch (_) {
      state.showError('userDetailsLoadError');
    } finally {
      state.setLoading(false);
    }
  }

  Future<bool> updateRole(AccountRole role) async {
    final details = state.details.value;
    if (details == null || state.updatingRole.value) return false;
    if (details.user.account.role == role) return true;

    state
      ..setUpdatingRole(role)
      ..clearError();
    try {
      final result = await _updateRoleCommand.executeWith((
        userId: details.user.id,
        role: role,
      ));
      return result.fold(
        onSuccess: (user) {
          state.updateUser(user);
          return true;
        },
        onFailure: (failure) {
          state.showError(failure.msg);
          return false;
        },
      );
    } catch (_) {
      state.showError('userDetailsRoleChangeError');
      return false;
    } finally {
      state.setUpdatingRole(null);
    }
  }
}
