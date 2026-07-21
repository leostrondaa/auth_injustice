import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/authentication/data/repositories/i_auth_repository.dart';
import 'package:autth_injustice_app/account/domain/models/account.dart';

class AuthenticatedCurrentAccountProvider implements ICurrentAccountProvider {
  final IAuthRepository _authRepository;

  const AuthenticatedCurrentAccountProvider({
    required IAuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Account? get currentAccount => _authRepository.currentSession?.account;

  @override
  String? get currentUid => currentAccount?.uid;
}
