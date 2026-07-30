import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/user_management/data/repositories/i_user_management_repository.dart';
import 'package:autth_injustice_app/user_management/data/services/i_user_management_service.dart';
import 'package:autth_injustice_app/user_management/domain/user_management_types.dart';

class UserManagementRepositoryImpl implements IUserManagementRepository {
  final IUserManagementService _service;
  final ICurrentAccountProvider _currentAccountProvider;

  const UserManagementRepositoryImpl({
    required IUserManagementService userManagementService,
    required ICurrentAccountProvider currentAccountProvider,
  })  : _service = userManagementService,
        _currentAccountProvider = currentAccountProvider;

  @override
  Future<UserDirectoryResult> getUsers() {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _service.getUsers(uid);
  }

  @override
  Future<ManagedUserDetailsResult> getUserDetails(String userId) {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _service.getUserDetails(uid, userId);
  }

  @override
  Future<ManagedUserRoleResult> updateUserRole(
    String userId,
    AccountRole role,
  ) {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _service.updateUserRole(uid, userId, role);
  }
}
