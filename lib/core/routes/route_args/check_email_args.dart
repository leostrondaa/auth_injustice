enum CheckEmailFlow {
  register,
  forgotPassword,
}

class CheckEmailArgs {
  final String email;
  final CheckEmailFlow flow;

  const CheckEmailArgs({
    required this.email,
    required this.flow,
  });
}