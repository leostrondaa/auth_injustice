import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/dev/demo_backend/demo_backend_store.dart';
import 'package:autth_injustice_app/user_management/data/services/i_user_management_service.dart';
import 'package:autth_injustice_app/user_management/domain/user_management_types.dart';

class DemoUserManagementService implements IUserManagementService {
  final DemoBackendStore _store;

  const DemoUserManagementService({
    required DemoBackendStore demoBackendStore,
  }) : _store = demoBackendStore;

  @override
  Future<UserDirectoryResult> getUsers(String actorUid) async {
    return Success(_store.usersForManagement(actorUid));
  }

  @override
  Future<ManagedUserDetailsResult> getUserDetails(
    String actorUid,
    String userId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 320));
    final details = _store.managedUserDetails(actorUid, userId);
    if (details == null) {
      return Error(NotFoundFailure('userDetailsNotFound'));
    }
    return Success(details);
  }

  @override
  Future<ManagedUserRoleResult> updateUserRole(
    String actorUid,
    String userId,
    AccountRole role,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    final updated = _store.updateManagedUserRole(actorUid, userId, role);
    if (updated == null) {
      return Error(InvalidInputFailure('userDetailsRoleChangeError'));
    }
    return Success(updated);
  }
}
