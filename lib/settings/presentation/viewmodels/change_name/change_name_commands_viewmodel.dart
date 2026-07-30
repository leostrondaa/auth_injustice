import 'package:autth_injustice_app/account/domain/facades/i_account_facade.dart';
import 'package:autth_injustice_app/account/domain/models/account_name.dart';

import 'change_name_state_viewmodel.dart';

class ChangeNameCommands {
  final ChangeNameState state;
  final IAccountFacade _facade;

  ChangeNameCommands({
    required this.state,
    required IAccountFacade accountFacade,
  }) : _facade = accountFacade;

  Future<void> loadCurrentName() async {
    if (state.loading.value) return;

    state
      ..setLoading(true)
      ..clearError();

    try {
      final result = await _facade.getAccount(());
      result.fold(
        onSuccess: (account) => state.setCurrentName(account.name),
        onFailure: (failure) => state.setError(failure.msg),
      );
    } catch (_) {
      state.setError('authUnexpectedError');
    } finally {
      state.setLoading(false);
    }
  }

  Future<void> updateName({
    required String firstName,
    required String lastName,
  }) async {
    if (state.loading.value) return;

    state
      ..setLoading(true)
      ..setSuccess(false)
      ..clearError();

    try {
      final name = AccountName(
        firstName: firstName,
        lastName: lastName,
      );
      final result = await _facade.updateAccountName((name: name));

      result.fold(
        onSuccess: (_) {
          state
            ..setCurrentName(name)
            ..setSuccess(true);
        },
        onFailure: (failure) => state.setError(failure.msg),
      );
    } catch (_) {
      state.setError('authUnexpectedError');
    } finally {
      state.setLoading(false);
    }
  }
}
