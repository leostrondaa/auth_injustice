import 'package:autth_injustice_app/account/domain/facades/i_account_facade.dart';
import 'package:autth_injustice_app/account/domain/usecases/i_account_usecases.dart';
import 'package:autth_injustice_app/core/typedefs/types_defs.dart';

/// Groups account use cases behind a presentation-friendly boundary.

final class AccountFacadeImpl implements IAccountFacade {
  final IGetAccountUseCase _getAccountUseCase;
  final ISaveAccountUseCase _saveAccountUseCase;
  final IUpdateAccountUseCase _updateAccountUseCase;
  final IUpdateAccountNameUseCase _updateAccountNameUseCase;
  final IDeleteAccountUseCase _deleteAccountUseCase;

  AccountFacadeImpl({
    required IGetAccountUseCase getAccountUseCase,
    required ISaveAccountUseCase saveAccountUseCase,
    required IUpdateAccountUseCase updateAccountUseCase,
    required IUpdateAccountNameUseCase updateAccountNameUseCase,
    required IDeleteAccountUseCase deleteAccountUseCase,
  })  : _getAccountUseCase = getAccountUseCase,
        _saveAccountUseCase = saveAccountUseCase,
        _updateAccountUseCase = updateAccountUseCase,
        _updateAccountNameUseCase = updateAccountNameUseCase,
        _deleteAccountUseCase = deleteAccountUseCase;

  @override
  Future<AccountResult> getAccount(NoParams params) {
    return _getAccountUseCase(params);
  }

  @override
  Future<VoidResult> saveAccount(AccountParams params) {
    return _saveAccountUseCase(params);
  }

  @override
  Future<VoidResult> deleteAccount(NoParams params) {
    return _deleteAccountUseCase(params);
  }

  @override
  Future<VoidResult> updateAccount(AccountParams params) {
    return _updateAccountUseCase(params);
  }

  @override
  Future<VoidResult> updateAccountName(UpdateAccountNameParams params) {
    return _updateAccountNameUseCase(params);
  }
}
