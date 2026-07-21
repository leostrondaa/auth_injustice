import 'package:autth_injustice_app/account/data/repositories/i_account_repository.dart';
import 'package:autth_injustice_app/account/domain/usecases/i_account_usecases.dart';
import 'package:autth_injustice_app/core/typedefs/types_defs.dart';

/// implementacao de todos os usecases relacionados a Account

/// usecase para obter a conta do usuario
final class GetAccountUseCaseImpl implements IGetAccountUseCase {
  final IAccountRepository _repository;

  GetAccountUseCaseImpl({required IAccountRepository repository})
      : _repository = repository;

  @override
  Future<AccountResult> call(NoParams params) async {
    return _repository.getAccount();
  }
}

/// usecase para salvar a conta do usuario
final class SaveAccountUseCaseImpl implements ISaveAccountUseCase {
  final IAccountRepository _repository;

  SaveAccountUseCaseImpl({required IAccountRepository repository})
      : _repository = repository;

  @override
  Future<VoidResult> call(AccountParams params) {
    return _repository.saveAccount(params.account);
  }
}

/// usecase para deletar a conta do usuario
final class DeleteAccountUseCaseImpl implements IDeleteAccountUseCase {
  final IAccountRepository _repository;

  DeleteAccountUseCaseImpl({required IAccountRepository repository})
      : _repository = repository;

  @override
  Future<VoidResult> call(NoParams params) {
    return _repository.deleteAccount();
  }
}

final class UpdateAccountUseCaseImpl implements IUpdateAccountUseCase {
  final IAccountRepository _repository;

  UpdateAccountUseCaseImpl({required IAccountRepository repository})
      : _repository = repository;

  @override
  Future<VoidResult> call(AccountParams params) {
    return _repository.updateAccount(params.account);
  }
}
