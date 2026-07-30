import 'package:autth_injustice_app/core/patterns/i_usecases.dart';
import 'package:autth_injustice_app/core/typedefs/types_defs.dart';

abstract interface class ISignInUseCase
    implements IUseCase<AuthSessionResult, SignInParams> {}

abstract interface class ISignInWithGoogleUseCase
    implements IUseCase<AuthSessionResult, NoParams> {}

abstract interface class ISignOutUseCase
    implements IUseCase<VoidResult, NoParams> {}

abstract interface class ISignUpUseCase
    implements IUseCase<AuthSessionResult, SignUpParams> {}
