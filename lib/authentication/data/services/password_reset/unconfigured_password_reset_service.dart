import 'package:autth_injustice_app/authentication/data/services/password_reset/i_password_reset_service.dart';
import 'package:autth_injustice_app/authentication/domain/password_reset_types.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';

/// Fails explicitly until the backend validates real password reset codes.
class UnconfiguredPasswordResetService implements IPasswordResetService {
  @override
  Future<PasswordResetResult> resetPassword(
    PasswordResetParams params,
  ) async {
    return Error(RemoteFailure('authBackendUnavailable'));
  }
}
