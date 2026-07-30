import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/authorization/domain/models/app_permission.dart';

class AuthorizationService {
  final ICurrentAccountProvider _currentAccountProvider;

  const AuthorizationService({
    required ICurrentAccountProvider currentAccountProvider,
  }) : _currentAccountProvider = currentAccountProvider;

  AccountRole get currentRole =>
      _currentAccountProvider.currentAccount?.role ?? AccountRole.student;

  bool get isAuthenticated => _currentAccountProvider.currentAccount != null;

  bool get isGuest => !isAuthenticated;

  bool can(AppPermission permission) => currentRole.can(permission);

  bool get canManageEvents => can(AppPermission.createEvent);
  bool get canPublishAnnouncements => can(AppPermission.publishAnnouncement);
  bool get canManageAccounts => can(AppPermission.manageAccounts);
}
