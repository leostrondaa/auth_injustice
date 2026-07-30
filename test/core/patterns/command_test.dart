import 'dart:async';

import 'package:autth_injustice_app/core/patterns/command.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('shares one execution between repeated calls', () async {
    final command = _DeferredCommand();

    final first = command();
    final second = command();

    expect(identical(first, second), isTrue);
    expect(command.calls, 1);
    expect(command.isExecuting.value, isTrue);

    command.complete(42);

    expect((await first).successValueOrNull, 42);
    expect((await second).successValueOrNull, 42);
    expect(command.isExecuting.value, isFalse);
  });

  test('does not replace parameters during an active execution', () async {
    final command = _DeferredParameterizedCommand();

    final first = command.executeWith(7);
    final second = command.executeWith(99);

    expect(command.parametersRead, [7]);
    expect(command.parameter, 7);

    command.complete();

    expect((await first).successValueOrNull, 7);
    expect((await second).successValueOrNull, 7);
  });
}

final class _DeferredCommand extends Command<int, String> {
  final _completer = Completer<Result<int, String>>();
  int calls = 0;

  @override
  Future<Result<int, String>> execute() {
    calls++;
    return _completer.future;
  }

  void complete(int value) {
    _completer.complete(Success(value));
  }
}

final class _DeferredParameterizedCommand
    extends ParameterizedCommand<int, String, int> {
  final _completer = Completer<Result<int, String>>();
  final parametersRead = <int?>[];

  @override
  Future<Result<int, String>> execute() {
    parametersRead.add(parameter);
    return _completer.future;
  }

  void complete() {
    _completer.complete(Success(parameter!));
  }
}
