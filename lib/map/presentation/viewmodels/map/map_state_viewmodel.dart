import 'package:signals_flutter/signals_flutter.dart';

class MapState {
  final loading = signal(false);

  void setLoading(bool value) {
    loading.value = value;
  }
}
