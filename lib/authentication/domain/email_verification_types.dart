import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';

enum EmailVerificationFlow {
  register,
  forgotPassword,
  changeEmail,
}

enum EmailVerificationStatus {
  pending,
  confirmed,
  expired,
}

class EmailVerificationCheck {
  final EmailVerificationStatus status;
  final String? actionCode;

  const EmailVerificationCheck({
    required this.status,
    this.actionCode,
  });
}

typedef EmailVerificationParams = ({
  String email,
  EmailVerificationFlow flow,
});

typedef EmailVerificationStatusResult = Result<EmailVerificationCheck, Failure>;

typedef EmailVerificationActionResult = Result<void, Failure>;
