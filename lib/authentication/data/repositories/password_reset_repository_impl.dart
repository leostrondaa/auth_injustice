import 'package:autth_injustice_app/authentication/data/repositories/i_password_reset_repository.dart';
import 'package:autth_injustice_app/authentication/data/services/password_reset/i_password_reset_service.dart';
import 'package:autth_injustice_app/authentication/domain/password_reset_types.dart';

class PasswordResetRepositoryImpl implements IPasswordResetRepository {
  final IPasswordResetService _service;

  const PasswordResetRepositoryImpl({
    required IPasswordResetService passwordResetService,
  }) : _service = passwordResetService;

  @override
  Future<PasswordResetResult> resetPassword(PasswordResetParams params) {
    return _service.resetPassword(params);
  }
}
