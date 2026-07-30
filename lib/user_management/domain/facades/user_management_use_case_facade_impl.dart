import 'package:autth_injustice_app/user_management/domain/facades/i_user_management_use_case_facade.dart';
import 'package:autth_injustice_app/user_management/domain/usecases/i_user_management_usecases.dart';
import 'package:autth_injustice_app/user_management/domain/user_management_types.dart';

class UserManagementUseCaseFacadeImpl implements IUserManagementUseCaseFacade {
  final IGetManagedUsersUseCase _getManagedUsersUseCase;
  final IGetManagedUserDetailsUseCase _getManagedUserDetailsUseCase;
  final IUpdateManagedUserRoleUseCase _updateManagedUserRoleUseCase;

  const UserManagementUseCaseFacadeImpl({
    required IGetManagedUsersUseCase getManagedUsersUseCase,
    required IGetManagedUserDetailsUseCase getManagedUserDetailsUseCase,
    required IUpdateManagedUserRoleUseCase updateManagedUserRoleUseCase,
  })  : _getManagedUsersUseCase = getManagedUsersUseCase,
        _getManagedUserDetailsUseCase = getManagedUserDetailsUseCase,
        _updateManagedUserRoleUseCase = updateManagedUserRoleUseCase;

  @override
  Future<UserDirectoryResult> getUsers(UserManagementNoParams params) {
    return _getManagedUsersUseCase(params);
  }

  @override
  Future<ManagedUserDetailsResult> getUserDetails(
    ManagedUserIdParams params,
  ) {
    return _getManagedUserDetailsUseCase(params);
  }

  @override
  Future<ManagedUserRoleResult> updateUserRole(
    UpdateManagedUserRoleParams params,
  ) {
    return _updateManagedUserRoleUseCase(params);
  }
}
