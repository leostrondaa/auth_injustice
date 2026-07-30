import 'package:autth_injustice_app/core/patterns/async_load_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestLoadState with AsyncLoadState {}

void main() {
  late _TestLoadState state;

  setUp(() {
    state = _TestLoadState();
  });

  test('starts as an unloaded idle state', () {
    expect(state.hasLoaded, isFalse);
    expect(state.isInitialLoading, isFalse);
    expect(state.isRefreshing, isFalse);
    expect(state.hasInitialError, isFalse);
  });

  test('distinguishes initial loading from background refresh', () {
    state.setLoading(true);
    expect(state.isInitialLoading, isTrue);
    expect(state.isRefreshing, isFalse);

    state
      ..markLoaded()
      ..setLoading(false)
      ..setLoading(true);

    expect(state.isInitialLoading, isFalse);
    expect(state.isRefreshing, isTrue);
  });

  test('only exposes a blocking error before the first successful load', () {
    state.showError('offline');
    expect(state.hasInitialError, isTrue);

    state
      ..clearError()
      ..markLoaded()
      ..showError('offline');

    expect(state.hasInitialError, isFalse);
    expect(state.errorMessage.value, 'offline');
  });
}
