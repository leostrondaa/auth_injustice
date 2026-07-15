import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/typedefs/types_defs.dart';

import '../../../core/patterns/command.dart';
import '../../../core/patterns/result.dart';
import '../../domain/facades/i_auth_use_case_facade.dart';
import '../../../domain/models/auth_entities.dart';

final class SignInCommand extends ParameterizedCommand<AuthSession, Failure, SignInParams> {
  final IAuthUseCaseFacade _authUseCaseFacade;

  SignInCommand(this._authUseCaseFacade);

  @override
  Future<AuthSessionResult> execute() async {
    if (parameter == null || parameter!.email.isEmpty || parameter!.password.isEmpty) {
      // Dispara a chave l10n para "Por favor, preencha os campos"
      return Error(InvalidInputFailure('fieldsRequired')); 
    }

    return await _authUseCaseFacade.signInUseCase(parameter!);
  }
}

final class SignInWithGoogleCommand extends ParameterizedCommand<AuthSession, Failure, NoParams> {
  final IAuthUseCaseFacade _authUseCaseFacade;

  SignInWithGoogleCommand(this._authUseCaseFacade);

  @override
  Future<AuthSessionResult> execute() async {
    if (parameter == null) {
      // Como não criamos uma chave específica para isso no JSON,
      // podemos passar uma mensagem direta. O nosso switch/case vai cair no 'default' e exibir isso na tela perfeitamente!
      return Error(InvalidInputFailure('Erro interno: Parâmetro nulo no Google Sign-In.'));
    }
    return await _authUseCaseFacade.signInWithGoogleUseCase(parameter!);
  }
}

final class SignOutCommand extends ParameterizedCommand<void, Failure, NoParams> {
  final IAuthUseCaseFacade _authUseCaseFacade;

  SignOutCommand(this._authUseCaseFacade);

  @override
  Future<VoidResult> execute() async {
    if (parameter == null) {
      // Mesma coisa: erro de desenvolvedor, cai no default e exibe esse texto.
      return Error(InvalidInputFailure('Erro interno ao realizar sign-out.'));
    }
    return await _authUseCaseFacade.signOutUseCase(parameter!);
  }
}

final class SignUpCommand extends ParameterizedCommand<AuthSession, Failure, SignUpParams> {
  final IAuthUseCaseFacade _authUseCaseFacade;

  SignUpCommand(this._authUseCaseFacade);

  @override
  Future<AuthSessionResult> execute() async {
    if (parameter == null || parameter!.email.isEmpty || parameter!.password.isEmpty) {
      // Dispara a chave l10n para "Por favor, preencha os campos"
      return Error(InvalidInputFailure('fieldsRequired'));
    }

    return await _authUseCaseFacade.signUpUseCase(parameter!);
  }
}