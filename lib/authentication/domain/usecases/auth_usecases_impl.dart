import 'package:autth_injustice_app/authentication/data/repositories/i_auth_repository.dart';
import 'package:autth_injustice_app/authentication/domain/usecases/i_auth_usecases.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/core/typedefs/types_defs.dart';

final class SignInUseCase implements ISignInUseCase {
  final IAuthRepository _authRepository;

  SignInUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<AuthSessionResult> call(SignInParams params) {
    return _authRepository.signIn(params.email, params.password);
  }
}

final class SignInWithGoogleUseCase implements ISignInWithGoogleUseCase {
  final IAuthRepository _authRepository;

  SignInWithGoogleUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<AuthSessionResult> call(NoParams params) {
    return _authRepository.signInWithGoogle();
  }
}

final class SignOutUseCase implements ISignOutUseCase {
  final IAuthRepository _authRepository;

  SignOutUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<VoidResult> call(NoParams params) {
    return _authRepository.signOut();
  }
}

final class SignUpUseCase implements ISignUpUseCase {
  final IAuthRepository _authRepository;

  SignUpUseCase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<AuthSessionResult> call(SignUpParams params) {
    if (!params.name.isComplete) {
      return Future.value(
        Error(InvalidInputFailure('accountInvalidFullName')),
      );
    }

    return _authRepository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}
