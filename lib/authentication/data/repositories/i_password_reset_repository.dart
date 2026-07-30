import 'package:autth_injustice_app/authentication/domain/password_reset_types.dart';

abstract interface class IPasswordResetRepository {
  Future<PasswordResetResult> resetPassword(PasswordResetParams params);
}
