import 'package:signals_flutter/signals_flutter.dart';

class AppShellState {
  static const tabCount = 4;

  final currentTabIndex = signal(0);

  void setCurrentTabIndex(int index) {
    currentTabIndex.value = index;
  }
}
