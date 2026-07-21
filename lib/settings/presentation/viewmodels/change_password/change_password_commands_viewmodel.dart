import 'package:autth_injustice_app/settings/domain/facades/i_account_security_facade.dart';

import 'change_password_state_viewmodel.dart';

class ChangePasswordCommands {
  final ChangePasswordState state;
  final IAccountSecurityFacade _facade;

  ChangePasswordCommands({
    required this.state,
    required IAccountSecurityFacade accountSecurityFacade,
  }) : _facade = accountSecurityFacade;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (state.loading.value) return;

    state
      ..setLoading(true)
      ..setSuccess(false)
      ..clearError();

    try {
      final result = await _facade.changePassword((
        currentPassword: currentPassword,
        newPassword: newPassword,
      ));
      result.fold(
        onSuccess: (_) => state.setSuccess(true),
        onFailure: (failure) => state.setError(failure.msg),
      );
    } catch (_) {
      state.setError('authUnexpectedError');
    } finally {
      state.setLoading(false);
    }
  }
}
