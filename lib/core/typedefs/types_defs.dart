import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/account/domain/models/account_name.dart';
import 'package:autth_injustice_app/authentication/domain/models/auth_session.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';

// typedefs para autenticação
typedef VoidResult = Result<void, Failure>;
typedef AuthSessionResult = Result<AuthSession, Failure>;

// typedefs para parâmetros
typedef NoParams = ();
typedef SignInParams = ({String email, String password});
typedef SignUpParams = ({
  AccountName name,
  String email,
  String password,
});

// typedefs para tipo Result
typedef AccountResult = Result<Account, Failure>;

// typedefs para parâmetros
typedef AccountParams = ({Account account});
typedef UpdateAccountNameParams = ({AccountName name});
