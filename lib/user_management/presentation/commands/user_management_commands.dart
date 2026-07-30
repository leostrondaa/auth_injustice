import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/command.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/user_management/domain/facades/i_user_management_use_case_facade.dart';
import 'package:autth_injustice_app/user_management/domain/models/user_directory_entry.dart';
import 'package:autth_injustice_app/user_management/domain/models/managed_user_details.dart';
import 'package:autth_injustice_app/user_management/domain/user_management_types.dart';

final class LoadManagedUsersCommand extends ParameterizedCommand<
    List<UserDirectoryEntry>, Failure, UserManagementNoParams> {
  final IUserManagementUseCaseFacade _facade;

  LoadManagedUsersCommand(this._facade);

  @override
  Future<UserDirectoryResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('userManagementLoadError')),
      );
    }

    return _facade.getUsers(parameter!);
  }
}

final class LoadManagedUserDetailsCommand extends ParameterizedCommand<
    ManagedUserDetails, Failure, ManagedUserIdParams> {
  final IUserManagementUseCaseFacade _facade;

  LoadManagedUserDetailsCommand(this._facade);

  @override
  Future<ManagedUserDetailsResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('userDetailsLoadError')),
      );
    }

    return _facade.getUserDetails(parameter!);
  }
}

final class UpdateManagedUserRoleCommand extends ParameterizedCommand<
    UserDirectoryEntry, Failure, UpdateManagedUserRoleParams> {
  final IUserManagementUseCaseFacade _facade;

  UpdateManagedUserRoleCommand(this._facade);

  @override
  Future<ManagedUserRoleResult> execute() {
    final params = parameter;
    if (params == null ||
        (params.role != AccountRole.student &&
            params.role != AccountRole.eventManager)) {
      return Future.value(
        Error(InvalidInputFailure('userDetailsInvalidRole')),
      );
    }

    return _facade.updateUserRole(params);
  }
}
