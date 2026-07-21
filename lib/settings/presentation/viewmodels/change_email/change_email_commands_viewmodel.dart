import 'package:autth_injustice_app/settings/domain/facades/i_account_security_facade.dart';

import 'change_email_state_viewmodel.dart';

class ChangeEmailCommands {
  final ChangeEmailState state;
  final IAccountSecurityFacade _facade;

  ChangeEmailCommands({
    required this.state,
    required IAccountSecurityFacade accountSecurityFacade,
  }) : _facade = accountSecurityFacade;

  Future<void> requestEmailChange({
    required String currentPassword,
    required String newEmail,
  }) async {
    if (state.loading.value) return;

    state
      ..setLoading(true)
      ..setSuccess(false)
      ..clearError();

    try {
      final result = await _facade.requestEmailChange((
        currentPassword: currentPassword,
        newEmail: newEmail,
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
