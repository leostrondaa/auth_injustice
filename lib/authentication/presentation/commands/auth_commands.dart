import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/typedefs/types_defs.dart';

import 'package:autth_injustice_app/core/patterns/command.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/authentication/domain/facades/i_auth_use_case_facade.dart';
import 'package:autth_injustice_app/authentication/domain/models/auth_session.dart';

final class SignInCommand
    extends ParameterizedCommand<AuthSession, Failure, SignInParams> {
  final IAuthUseCaseFacade _authUseCaseFacade;

  SignInCommand(this._authUseCaseFacade);

  @override
  Future<AuthSessionResult> execute() async {
    if (parameter == null ||
        parameter!.email.isEmpty ||
        parameter!.password.isEmpty) {
      return Error(InvalidInputFailure('fieldsRequired'));
    }

    return _authUseCaseFacade.signInUseCase(parameter!);
  }
}

final class SignInWithGoogleCommand
    extends ParameterizedCommand<AuthSession, Failure, NoParams> {
  final IAuthUseCaseFacade _authUseCaseFacade;

  SignInWithGoogleCommand(this._authUseCaseFacade);

  @override
  Future<AuthSessionResult> execute() async {
    if (parameter == null) {
      return Error(InvalidInputFailure('authUnexpectedError'));
    }
    return _authUseCaseFacade.signInWithGoogleUseCase(parameter!);
  }
}

final class SignOutCommand
    extends ParameterizedCommand<void, Failure, NoParams> {
  final IAuthUseCaseFacade _authUseCaseFacade;

  SignOutCommand(this._authUseCaseFacade);

  @override
  Future<VoidResult> execute() async {
    if (parameter == null) {
      return Error(InvalidInputFailure('authUnexpectedError'));
    }
    return _authUseCaseFacade.signOutUseCase(parameter!);
  }
}

final class SignUpCommand
    extends ParameterizedCommand<AuthSession, Failure, SignUpParams> {
  final IAuthUseCaseFacade _authUseCaseFacade;

  SignUpCommand(this._authUseCaseFacade);

  @override
  Future<AuthSessionResult> execute() async {
    if (parameter == null ||
        parameter!.email.isEmpty ||
        parameter!.password.isEmpty) {
      return Error(InvalidInputFailure('fieldsRequired'));
    }

    return _authUseCaseFacade.signUpUseCase(parameter!);
  }
}
