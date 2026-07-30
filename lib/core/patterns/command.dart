import 'package:signals_flutter/signals_flutter.dart';

import 'result.dart';

abstract interface class ICommand<TOk, TError> {
  Future<Result<TOk, TError>> execute();
}

abstract base class Command<TOk, TError> implements ICommand<TOk, TError> {
  final _running = signal(false);
  final _result = signal<Result<TOk, TError>?>(null);
  Future<Result<TOk, TError>>? _inFlight;

  ReadonlySignal<bool> get isExecuting => _running.readonly();
  ReadonlySignal<Result<TOk, TError>?> get result => _result.readonly();

  Future<Result<TOk, TError>> call() {
    final currentExecution = _inFlight;
    if (currentExecution != null) return currentExecution;

    final execution = _executeOnce();
    _inFlight = execution;
    return execution;
  }

  Future<Result<TOk, TError>> _executeOnce() async {
    _running.value = true;
    _result.value = null;

    try {
      _result.value = await Future<Result<TOk, TError>>.sync(execute);
      return _result.value!;
    } finally {
      _running.value = false;
      _inFlight = null;
    }
  }

  void clear() {
    _result.value = null;
  }

  void reset() {
    if (_running.value) return;
    clear();
  }
}

abstract base class ParameterizedCommand<TOk, TError, P>
    extends Command<TOk, TError> {
  P? _parameter;

  P? get parameter => _parameter;

  Future<Result<TOk, TError>> executeWith(P parameter) {
    if (isExecuting.value) return call();
    _parameter = parameter;
    return call();
  }

  @override
  Future<Result<TOk, TError>> execute();
}
