import 'map_commands_viewmodel.dart';
import 'map_state_viewmodel.dart';

class MapViewModel {
  late final MapState _state;
  late final MapCommands _commands;

  MapState get state => _state;
  MapCommands get commands => _commands;

  MapViewModel() {
    _state = MapState();
    _commands = MapCommands(state: _state);
  }
}
