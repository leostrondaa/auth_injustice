import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/user_management/domain/user_management_types.dart';

/// Administrative source for the institution's user directory.
///
/// A Firebase adapter should query only users from the active institution and
/// verify the actor's permission on the server.
abstract interface class IUserManagementService {
  Future<UserDirectoryResult> getUsers(String actorUid);

  Future<ManagedUserDetailsResult> getUserDetails(
    String actorUid,
    String userId,
  );

  /// A production adapter must perform this operation in trusted backend code.
  /// Never allow clients to write the role field directly in Firestore.
  Future<ManagedUserRoleResult> updateUserRole(
    String actorUid,
    String userId,
    AccountRole role,
  );
}
