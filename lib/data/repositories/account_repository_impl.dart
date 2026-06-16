import '../../core/failure/failure.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/types_defs.dart';
import '../../authentication/data/repositories/i_auth_repository.dart';
import '../../data/services/remote/account_remote_storage_interface.dart';
import '../../domain/models/account_entity.dart';
import 'account_repository_interface.dart';

/// Implementação do repositório de Account.
///
/// O [uid] é sempre resolvido a partir da sessão de autenticação ativa,
/// mantendo a interface limpa sem expor uid para os use cases.
final class AccountRepositoryImpl implements IAccountRepository {
  final IAccountRemoteStorage _remoteStorage;
  final IAuthRepository _authRepository;

  AccountRepositoryImpl({
    required IAccountRemoteStorage remoteStorage,
    required IAuthRepository authRepository,
  })  : _remoteStorage = remoteStorage,
        _authRepository = authRepository;

  String? get _currentUid => _authRepository.currentSession?.account.uid;

  UnauthenticatedFailure get _unauthError => UnauthenticatedFailure();

  @override
  Future<AccountResult> getAccount() async {
    final uid = _currentUid;
    if (uid == null) return Error(_unauthError);
    return _remoteStorage.getAccount(uid);
  }

  @override
  Future<VoidResult> saveAccount(Account account) async {
    if (_currentUid == null) return Error(_unauthError);
    return _remoteStorage.saveAccount(account);
  }

  @override
  Future<VoidResult> updateAccount(Account account) async {
    if (_currentUid == null) return Error(_unauthError);
    return _remoteStorage.updateAccount(account);
  }

  @override
  Future<VoidResult> deleteAccount() async {
    final uid = _currentUid;
    if (uid == null) return Error(_unauthError);
    return _remoteStorage.deleteAccount(uid);
  }
}
