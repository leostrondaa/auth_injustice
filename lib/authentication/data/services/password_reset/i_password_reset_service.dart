import 'package:autth_injustice_app/authentication/domain/password_reset_types.dart';

/// Backend boundary for completing a password recovery.
///
/// A production adapter must validate [PasswordResetParams.actionCode] with
/// the authentication provider. The email shown by the UI is not proof of
/// identity by itself.
abstract interface class IPasswordResetService {
  Future<PasswordResetResult> resetPassword(PasswordResetParams params);
}
