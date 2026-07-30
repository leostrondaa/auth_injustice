import 'package:autth_injustice_app/authentication/domain/password_reset_types.dart';
import 'package:autth_injustice_app/core/patterns/i_usecases.dart';

abstract interface class IResetPasswordUseCase
    implements IUseCase<PasswordResetResult, PasswordResetParams> {}
