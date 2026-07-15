sealed class Failure implements Exception {
  final String msg;
  Failure(this.msg);

  @override
  String toString() => '$runtimeType: $msg!!!';
}

class DefaultFailure extends Failure {
  DefaultFailure([String? msg])
      : super(msg ?? 'fieldsRequired'); // Usa uma chave como padrão
}

class ValidationError extends Failure {
  ValidationError(super.msg);
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure([String? msg]) : super(msg ?? 'fieldsRequired');
}
