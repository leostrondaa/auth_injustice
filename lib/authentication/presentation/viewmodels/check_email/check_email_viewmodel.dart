import 'check_email_commands_viewmodel.dart';
import 'check_email_state_viewmodel.dart';

class CheckEmailViewModel {
  late final CheckEmailState _state;
  late final CheckEmailCommands _commands;

  CheckEmailState get state => _state;
  CheckEmailCommands get commands => _commands;

  CheckEmailViewModel() {
    _state = CheckEmailState();
    _commands = CheckEmailCommands(state: _state);
  }
}
