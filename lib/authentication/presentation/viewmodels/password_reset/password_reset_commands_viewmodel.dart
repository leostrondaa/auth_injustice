import 'package:autth_injustice_app/authentication/domain/facades/i_password_reset_facade.dart';

import 'password_reset_state_viewmodel.dart';

class PasswordResetCommands {
  final PasswordResetState state;
  final IPasswordResetFacade _facade;

  PasswordResetCommands({
    required this.state,
    required IPasswordResetFacade passwordResetFacade,
  }) : _facade = passwordResetFacade;

  Future<bool> resetPassword({
    required String email,
    required String actionCode,
    required String newPassword,
  }) async {
    if (state.loading.value) return false;

    state
      ..setLoading(true)
      ..setSuccess(false)
      ..clearError();

    try {
      final result = await _facade.resetPassword((
        email: email,
        actionCode: actionCode,
        newPassword: newPassword,
      ));
      return result.fold(
        onSuccess: (_) {
          state.setSuccess(true);
          return true;
        },
        onFailure: (failure) {
          state.showError(failure.msg);
          return false;
        },
      );
    } catch (_) {
      state.showError('passwordResetFailed');
      return false;
    } finally {
      state.setLoading(false);
    }
  }
}
