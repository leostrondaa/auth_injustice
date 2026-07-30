import 'package:autth_injustice_app/authentication/domain/email_verification_types.dart';

export 'package:autth_injustice_app/authentication/domain/email_verification_types.dart'
    show EmailVerificationFlow;

class CheckEmailArgs {
  final String email;
  final EmailVerificationFlow flow;
  final bool linkAlreadySent;

  const CheckEmailArgs({
    required this.email,
    required this.flow,
    this.linkAlreadySent = false,
  });
}
