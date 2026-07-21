import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';

typedef AccountSecurityResult = Result<void, Failure>;

typedef ChangePasswordParams = ({
  String currentPassword,
  String newPassword,
});

typedef RequestEmailChangeParams = ({
  String currentPassword,
  String newEmail,
});
