import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/user_management/domain/user_management_types.dart';

abstract interface class IUserManagementRepository {
  Future<UserDirectoryResult> getUsers();
  Future<ManagedUserDetailsResult> getUserDetails(String userId);
  Future<ManagedUserRoleResult> updateUserRole(
    String userId,
    AccountRole role,
  );
}
