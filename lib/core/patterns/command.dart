import 'package:signals_flutter/signals_flutter.dart';

import 'result.dart';

// Interface base para comandos
abstract interface class ICommand<TOk, TError> {
  Future<Result<TOk, TError>> execute();
}

// Comando abstrato com estado reativo
abstract base class Command<TOk, TError> implements ICommand<TOk, TError> {
  final _running = signal(false);
  final _result = signal<Result<TOk, TError>?>(null);

  //final _error = signal<TError?>(null);

  // Getters para os sinais reativos
  ReadonlySignal<bool> get isExecuting => _running.readonly();
  ReadonlySignal<Result<TOk, TError>?> get result => _result.readonly();
  //ReadonlySignal<TError?> get error => _error.readonly();

  // Computed signals
  late final hasResult = computed(() => _result.value != null);
  late final hasError = computed(() => _result.value?.isFailure ?? false);
  late final isSuccess = computed(() => _result.value?.isSuccess ?? false);
  // late final data = computed(() => _result.value?.successValueOrNull);

  // Método para executar o comando com tratamento
  Future<Result<TOk, TError>> call() async {
    if (_running.value) {
      while (_running.value) {
        await Future.delayed(Duration.zero);
      }
      return _result.value!;
    }

    _running.value = true;
    _result.value = null;

    try {
      _result.value = await execute();
      return _result.value!;
    } finally {
      _running.value = false;
    }
  }

  void clear() {
    _result.value = null;
  }

  void reset() {
    _running.value = false;
    clear();
  }
}

// Comando parametrizado
abstract base class ParameterizedCommand<TOk, TError, P>
    extends Command<TOk, TError> {
  P? _parameter;

  P? get parameter => _parameter;

  Future<Result<TOk, TError>> executeWith(P parameter) {
    _parameter = parameter;
    return call();
  }

  @override
  Future<Result<TOk, TError>> execute();
}

// Comando composto que executa múltiplos comandos e acumula resultados
final class CompositeCommand<TOk, TError> extends Command<List<TOk>, TError> {
  final List<Command<TOk, TError>> _commands;

  CompositeCommand(this._commands);

  @override
  Future<Result<List<TOk>, TError>> execute() async {
    final results = <TOk>[];

    for (final command in _commands) {
      final result =
          await command.call(); // usa o call() para registrar estados

      if (result.isFailure) {
        return Error(result.failureValueOrNull as TError);
      }

      final value = result.successValueOrNull;
      if (value != null) {
        results.add(value);
      }
    }

    return Success(results);
  }
}
