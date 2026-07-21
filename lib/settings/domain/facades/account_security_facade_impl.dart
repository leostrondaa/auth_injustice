import 'package:autth_injustice_app/settings/domain/account_security_types.dart';
import 'package:autth_injustice_app/settings/domain/facades/i_account_security_facade.dart';
import 'package:autth_injustice_app/settings/domain/usecases/i_account_security_usecases.dart';

class AccountSecurityFacadeImpl implements IAccountSecurityFacade {
  final IChangePasswordUseCase _changePasswordUseCase;
  final IRequestEmailChangeUseCase _requestEmailChangeUseCase;

  const AccountSecurityFacadeImpl({
    required IChangePasswordUseCase changePasswordUseCase,
    required IRequestEmailChangeUseCase requestEmailChangeUseCase,
  })  : _changePasswordUseCase = changePasswordUseCase,
        _requestEmailChangeUseCase = requestEmailChangeUseCase;

  @override
  Future<AccountSecurityResult> changePassword(ChangePasswordParams params) {
    return _changePasswordUseCase(params);
  }

  @override
  Future<AccountSecurityResult> requestEmailChange(
    RequestEmailChangeParams params,
  ) {
    return _requestEmailChangeUseCase(params);
  }
}
