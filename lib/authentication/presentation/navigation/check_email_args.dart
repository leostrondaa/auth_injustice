enum CheckEmailFlow {
  register,
  forgotPassword,
  changeEmail,
}

class CheckEmailArgs {
  final String email;
  final CheckEmailFlow flow;

  const CheckEmailArgs({
    required this.email,
    required this.flow,
  });
}
