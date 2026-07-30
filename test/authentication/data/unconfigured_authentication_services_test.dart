import 'package:autth_injustice_app/authentication/data/services/email_verification/unconfigured_email_verification_service.dart';
import 'package:autth_injustice_app/authentication/data/services/password_reset/unconfigured_password_reset_service.dart';
import 'package:autth_injustice_app/authentication/data/services/remote/unconfigured_auth_service.dart';
import 'package:autth_injustice_app/authentication/domain/email_verification_types.dart';
import 'package:autth_injustice_app/settings/data/services/unconfigured_account_security_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('unconfigured authentication never creates a local session', () async {
    final service = UnconfiguredAuthService();

    final result = await service.signIn(
      'student@ifpr.edu.br',
      'Password@123',
    );

    expect(result.failureValueOrNull?.msg, 'authBackendUnavailable');
    expect(service.currentSession, isNull);
    expect(service.currentSessionSignal.value, isNull);
  });

  test('unconfigured email verification fails instead of confirming', () async {
    final service = UnconfiguredEmailVerificationService();
    final result = await service.getStatus((
      email: 'student@ifpr.edu.br',
      flow: EmailVerificationFlow.register,
    ));

    expect(result.failureValueOrNull?.msg, 'authBackendUnavailable');
    expect(result.successValueOrNull, isNull);
  });

  test('unconfigured password reset never accepts a fake action code',
      () async {
    final service = UnconfiguredPasswordResetService();
    final result = await service.resetPassword((
      email: 'student@ifpr.edu.br',
      actionCode: 'not-a-real-backend-code',
      newPassword: 'Password@123',
    ));

    expect(result.failureValueOrNull?.msg, 'authBackendUnavailable');
  });

  test('unconfigured account security never changes credentials', () async {
    final service = UnconfiguredAccountSecurityService();
    final result = await service.changePassword((
      currentPassword: 'Current@123',
      newPassword: 'NewPassword@123',
    ));

    expect(result.failureValueOrNull?.msg, 'authBackendUnavailable');
  });
}
