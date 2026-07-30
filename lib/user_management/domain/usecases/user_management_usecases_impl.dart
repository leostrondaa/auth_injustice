import 'package:autth_injustice_app/authorization/domain/services/authorization_service.dart';
import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/authorization/domain/models/app_permission.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/user_management/data/repositories/i_user_management_repository.dart';
import 'package:autth_injustice_app/user_management/domain/usecases/i_user_management_usecases.dart';
import 'package:autth_injustice_app/user_management/domain/user_management_types.dart';

final class GetManagedUsersUseCase implements IGetManagedUsersUseCase {
  final IUserManagementRepository _repository;
  final AuthorizationService _authorizationService;

  const GetManagedUsersUseCase({
    required IUserManagementRepository userManagementRepository,
    required AuthorizationService authorizationService,
  })  : _repository = userManagementRepository,
        _authorizationService = authorizationService;

  @override
  Future<UserDirectoryResult> call(UserManagementNoParams params) {
    if (!_authorizationService.canManageAccounts) {
      return Future.value(
        Error(ForbiddenFailure('userManagementUnauthorized')),
      );
    }

    return _repository.getUsers();
  }
}

final class GetManagedUserDetailsUseCase
    implements IGetManagedUserDetailsUseCase {
  final IUserManagementRepository _repository;
  final AuthorizationService _authorizationService;

  const GetManagedUserDetailsUseCase({
    required IUserManagementRepository userManagementRepository,
    required AuthorizationService authorizationService,
  })  : _repository = userManagementRepository,
        _authorizationService = authorizationService;

  @override
  Future<ManagedUserDetailsResult> call(ManagedUserIdParams params) {
    if (!_authorizationService.canManageAccounts) {
      return Future.value(
        Error(ForbiddenFailure('userManagementUnauthorized')),
      );
    }
    if (params.userId.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('userDetailsInvalidUser')),
      );
    }

    return _repository.getUserDetails(params.userId);
  }
}

final class UpdateManagedUserRoleUseCase
    implements IUpdateManagedUserRoleUseCase {
  final IUserManagementRepository _repository;
  final AuthorizationService _authorizationService;

  const UpdateManagedUserRoleUseCase({
    required IUserManagementRepository userManagementRepository,
    required AuthorizationService authorizationService,
  })  : _repository = userManagementRepository,
        _authorizationService = authorizationService;

  @override
  Future<ManagedUserRoleResult> call(UpdateManagedUserRoleParams params) {
    if (!_authorizationService.can(AppPermission.assignRoles)) {
      return Future.value(
        Error(ForbiddenFailure('userDetailsRoleUnauthorized')),
      );
    }
    if (params.userId.trim().isEmpty ||
        (params.role != AccountRole.student &&
            params.role != AccountRole.eventManager)) {
      return Future.value(
        Error(InvalidInputFailure('userDetailsInvalidRole')),
      );
    }

    return _repository.updateUserRole(params.userId, params.role);
  }
}
