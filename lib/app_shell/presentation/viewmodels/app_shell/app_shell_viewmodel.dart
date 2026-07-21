import 'app_shell_commands_viewmodel.dart';
import 'app_shell_state_viewmodel.dart';

class AppShellViewModel {
  late final AppShellState _state;
  late final AppShellCommands _commands;

  AppShellState get state => _state;
  AppShellCommands get commands => _commands;

  AppShellViewModel() {
    _state = AppShellState();
    _commands = AppShellCommands(state: _state);
  }
}
