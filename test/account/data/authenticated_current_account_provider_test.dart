import 'package:autth_injustice_app/account/data/services/authenticated_current_account_provider.dart';
import 'package:autth_injustice_app/authentication/data/repositories/i_auth_repository.dart';
import 'package:autth_injustice_app/authentication/domain/models/auth_session.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  test('execution without an authenticated session starts as visitor', () {
    final provider = AuthenticatedCurrentAccountProvider(
      authRepository: _GuestAuthRepository(),
    );

    expect(provider.currentAccount, isNull);
    expect(provider.currentUid, isNull);
  });
}

class _GuestAuthRepository implements IAuthRepository {
  @override
  AuthSession? get currentSession => null;

  @override
  final Signal<AuthSession?> sessionSignal = signal(null);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
