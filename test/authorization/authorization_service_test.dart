import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/authorization/domain/models/app_permission.dart';
import 'package:autth_injustice_app/authorization/domain/services/authorization_service.dart';
import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthorizationService', () {
    test('guest has no account and no authenticated permissions', () {
      final service = AuthorizationService(
        currentAccountProvider: _FakeCurrentAccountProvider(null),
      );

      expect(service.isGuest, isTrue);
      expect(service.isAuthenticated, isFalse);
      expect(service.canManageEvents, isFalse);
      expect(service.canPublishAnnouncements, isFalse);
      expect(service.canManageAccounts, isFalse);
    });

    test('student cannot manage events or accounts', () {
      final service = _serviceFor(AccountRole.student);

      expect(service.canManageEvents, isFalse);
      expect(service.canManageAccounts, isFalse);
    });

    test('event manager can manage events but not accounts', () {
      final service = _serviceFor(AccountRole.eventManager);

      expect(service.can(AppPermission.publishEvent), isTrue);
      expect(service.can(AppPermission.endEvent), isTrue);
      expect(service.canPublishAnnouncements, isFalse);
      expect(service.canManageAccounts, isFalse);
    });

    test('administrator has every declared permission', () {
      final service = _serviceFor(AccountRole.administrator);

      for (final permission in AppPermission.values) {
        expect(service.can(permission), isTrue);
      }
      expect(service.canPublishAnnouncements, isTrue);
    });
  });
}

AuthorizationService _serviceFor(AccountRole role) {
  return AuthorizationService(
    currentAccountProvider: _FakeCurrentAccountProvider(
      Account.initial(
        uid: 'test-user',
        email: 'test@ifpr.edu.br',
        displayName: 'Test User',
      ).copyWith(
        role: role,
      ),
    ),
  );
}

class _FakeCurrentAccountProvider implements ICurrentAccountProvider {
  @override
  final Account? currentAccount;

  _FakeCurrentAccountProvider(this.currentAccount);

  @override
  String? get currentUid => currentAccount?.uid;
}
