import 'package:autth_injustice_app/user_management/domain/user_management_types.dart';

abstract interface class IUserManagementUseCaseFacade {
  Future<UserDirectoryResult> getUsers(UserManagementNoParams params);
  Future<ManagedUserDetailsResult> getUserDetails(
    ManagedUserIdParams params,
  );
  Future<ManagedUserRoleResult> updateUserRole(
    UpdateManagedUserRoleParams params,
  );
}
