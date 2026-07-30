import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';

typedef PasswordResetParams = ({
  String email,
  String actionCode,
  String newPassword,
});

typedef PasswordResetResult = Result<void, Failure>;
