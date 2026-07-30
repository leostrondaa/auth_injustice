import 'package:autth_injustice_app/core/patterns/i_usecases.dart';
import 'package:autth_injustice_app/user_management/domain/user_management_types.dart';

abstract interface class IGetManagedUsersUseCase
    implements IUseCase<UserDirectoryResult, UserManagementNoParams> {}

abstract interface class IGetManagedUserDetailsUseCase
    implements IUseCase<ManagedUserDetailsResult, ManagedUserIdParams> {}

abstract interface class IUpdateManagedUserRoleUseCase
    implements IUseCase<ManagedUserRoleResult, UpdateManagedUserRoleParams> {}
