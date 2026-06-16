import '../../core/failure/failure.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/types_defs.dart';
import 'account_repository_interface.dart';
import 'i_auth_repository.dart';
import '../services/remote/account_remote_storage_interface.dart';
import '../../domain/models/account_entity.dart';

/// Implementação do repositório para Account.
///
/// O `uid` utilizado nas operações é resolvido a partir da sessão de
/// autenticação ativa ([IAuthRepository.currentSession]), de forma que a
/// interface pública continua sem expor o `uid` para quem chama.
final class AccountRepositoryImpl implements IAccountRepository {
  final IAccountRemoteStorage _remoteStorage;
  final IAuthRepository _authRepository;

  AccountRepositoryImpl({
    required IAccountRemoteStorage remoteStorage,
    required IAuthRepository authRepository,
  })  : _remoteStorage = remoteStorage,
        _authRepository = authRepository;

  /// Resolve o uid da conta atualmente logada, ou retorna falha se
  /// não houver sessão ativa.
  String? get _currentUid => _authRepository.currentSession?.account.uid;

  @override
  Future<AccountResult> getAccount() async {
    final uid = _currentUid;
    if (uid == null) {
      return Error(UnauthenticatedFailure());
    }
    return _remoteStorage.getAccount(uid);
  }

  @override
  Future<VoidResult> deleteAccount() async {
    final uid = _currentUid;
    if (uid == null) {
      return Error(UnauthenticatedFailure());
    }
    return _remoteStorage.deleteAccount(uid);
  }

  @override
  Future<VoidResult> saveAccount(Account account) {
    return _remoteStorage.saveAccount(account);
  }

  @override
  Future<VoidResult> updateAccount(Account account) {
    return _remoteStorage.updateAccount(account);
  }
}
