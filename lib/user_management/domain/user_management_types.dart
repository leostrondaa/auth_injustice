import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/user_management/domain/models/managed_user_details.dart';
import 'package:autth_injustice_app/user_management/domain/models/user_directory_entry.dart';

typedef UserDirectoryResult = Result<List<UserDirectoryEntry>, Failure>;
typedef ManagedUserDetailsResult = Result<ManagedUserDetails, Failure>;
typedef ManagedUserRoleResult = Result<UserDirectoryEntry, Failure>;
typedef UserManagementNoParams = ();
typedef ManagedUserIdParams = ({String userId});
typedef UpdateManagedUserRoleParams = ({
  String userId,
  AccountRole role,
});
