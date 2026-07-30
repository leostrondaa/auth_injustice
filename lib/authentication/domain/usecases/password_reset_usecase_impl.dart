import 'package:autth_injustice_app/authentication/data/repositories/i_password_reset_repository.dart';
import 'package:autth_injustice_app/authentication/domain/password_reset_types.dart';
import 'package:autth_injustice_app/authentication/domain/usecases/i_password_reset_usecase.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';

final class ResetPasswordUseCase implements IResetPasswordUseCase {
  final IPasswordResetRepository _repository;

  const ResetPasswordUseCase({
    required IPasswordResetRepository passwordResetRepository,
  }) : _repository = passwordResetRepository;

  @override
  Future<PasswordResetResult> call(PasswordResetParams params) {
    final normalizedEmail = params.email.trim().toLowerCase();
    if (normalizedEmail.isEmpty || params.actionCode.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('passwordResetInvalidLink')),
      );
    }
    if (params.newPassword.length < 8) {
      return Future.value(
        Error(InvalidInputFailure('passwordMinLength')),
      );
    }

    return _repository.resetPassword((
      email: normalizedEmail,
      actionCode: params.actionCode,
      newPassword: params.newPassword,
    ));
  }
}
