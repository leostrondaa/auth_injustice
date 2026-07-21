import 'app_shell_state_viewmodel.dart';

class AppShellCommands {
  final AppShellState state;

  AppShellCommands({required this.state});

  void selectTab(int index) {
    if (index < 0 || index >= AppShellState.tabCount) {
      throw RangeError.range(index, 0, AppShellState.tabCount - 1, 'index');
    }

    state.setCurrentTabIndex(index);
  }
}
