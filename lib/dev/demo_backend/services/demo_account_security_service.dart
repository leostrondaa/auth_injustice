import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/settings/data/services/i_account_security_service.dart';
import 'package:autth_injustice_app/settings/domain/account_security_types.dart';

/// Presentation adapter used until credential changes are wired to Firebase.
class DemoAccountSecurityService implements IAccountSecurityService {
  static const _requestDelay = Duration(milliseconds: 900);

  @override
  Future<AccountSecurityResult> changePassword(
    ChangePasswordParams params,
  ) async {
    await Future<void>.delayed(_requestDelay);
    return const Success(null);
  }

  @override
  Future<AccountSecurityResult> requestEmailChange(
    RequestEmailChangeParams params,
  ) async {
    await Future<void>.delayed(_requestDelay);
    return const Success(null);
  }
}
