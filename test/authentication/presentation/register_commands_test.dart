import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/authentication/domain/facades/i_auth_use_case_facade.dart';
import 'package:autth_injustice_app/authentication/domain/models/auth_session.dart';
import 'package:autth_injustice_app/authentication/presentation/commands/auth_commands.dart';
import 'package:autth_injustice_app/authentication/presentation/commands/register_commands.dart';
import 'package:autth_injustice_app/authentication/presentation/viewmodels/register/register_state_viewmodel.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/core/typedefs/types_defs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('registration returns success and leaves a consistent state', () async {
    final state = RegisterState();
    final commands = RegisterCommands(
      state: state,
      signUpCommand: SignUpCommand(_SuccessfulAuthFacade()),
    );

    final registered = await commands.signUp(
      email: 'student@ifpr.edu.br',
      password: 'Password@123',
      firstName: 'Mateus',
      lastName: 'Silva',
    );

    expect(registered, isTrue);
    expect(state.success.value, isTrue);
    expect(state.loading.value, isFalse);
    expect(state.errorMessage.value, isNull);
  });
}

class _SuccessfulAuthFacade implements IAuthUseCaseFacade {
  @override
  Future<AuthSessionResult> signUpUseCase(SignUpParams params) async {
    final now = DateTime(2026, 7, 30);
    return Success(
      AuthSession(
        account: Account(
          uid: 'new-user',
          email: params.email,
          displayName: params.name.displayName,
          createdAt: now,
          updatedAt: now,
          isProfileConfigured: true,
        ),
        token: Token(expiresAt: now.add(const Duration(hours: 1))),
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
