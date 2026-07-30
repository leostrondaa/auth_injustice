import 'package:autth_injustice_app/authentication/data/repositories/i_password_reset_repository.dart';
import 'package:autth_injustice_app/authentication/domain/password_reset_types.dart';
import 'package:autth_injustice_app/authentication/domain/usecases/password_reset_usecase_impl.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normalizes email and forwards an authorized password reset', () async {
    final repository = _FakePasswordResetRepository();
    final useCase = ResetPasswordUseCase(
      passwordResetRepository: repository,
    );

    final result = await useCase((
      email: '  STUDENT@IFPR.EDU.BR ',
      actionCode: 'authorized-code',
      newPassword: 'Password@123',
    ));

    expect(result, isA<Success<void, Failure>>());
    expect(repository.lastParams?.email, 'student@ifpr.edu.br');
  });

  test('rejects a reset without an authorization code', () async {
    final repository = _FakePasswordResetRepository();
    final useCase = ResetPasswordUseCase(
      passwordResetRepository: repository,
    );

    final result = await useCase((
      email: 'student@ifpr.edu.br',
      actionCode: '',
      newPassword: 'Password@123',
    ));

    expect(result.failureValueOrNull, isA<InvalidInputFailure>());
    expect(repository.calls, 0);
  });
}

class _FakePasswordResetRepository implements IPasswordResetRepository {
  PasswordResetParams? lastParams;
  int calls = 0;

  @override
  Future<PasswordResetResult> resetPassword(
    PasswordResetParams params,
  ) async {
    calls++;
    lastParams = params;
    return const Success(null);
  }
}
