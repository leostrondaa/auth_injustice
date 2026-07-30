class PasswordResetArgs {
  final String email;
  final String actionCode;

  const PasswordResetArgs({
    required this.email,
    required this.actionCode,
  });
}
