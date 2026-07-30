import 'package:autth_injustice_app/authentication/domain/facades/i_password_reset_facade.dart';
import 'package:autth_injustice_app/authentication/domain/password_reset_types.dart';
import 'package:autth_injustice_app/authentication/domain/usecases/i_password_reset_usecase.dart';

class PasswordResetFacadeImpl implements IPasswordResetFacade {
  final IResetPasswordUseCase _resetPasswordUseCase;

  const PasswordResetFacadeImpl({
    required IResetPasswordUseCase resetPasswordUseCase,
  }) : _resetPasswordUseCase = resetPasswordUseCase;

  @override
  Future<PasswordResetResult> resetPassword(PasswordResetParams params) {
    return _resetPasswordUseCase(params);
  }
}
