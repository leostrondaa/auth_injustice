import 'package:autth_injustice_app/events/domain/facades/i_events_use_case_facade.dart';
import 'package:autth_injustice_app/events/presentation/commands/events_commands.dart';

import 'event_management_commands_viewmodel.dart';
import 'event_management_state_viewmodel.dart';

class EventManagementViewModel {
  late final EventManagementState _state;
  late final EventManagementCommands _commands;

  EventManagementState get state => _state;
  EventManagementCommands get commands => _commands;

  EventManagementViewModel(IEventsUseCaseFacade facade) {
    _state = EventManagementState();
    _commands = EventManagementCommands(
      state: _state,
      loadEventsCatalogCommand: LoadManagementEventsCatalogCommand(facade),
      deleteEventCommand: DeleteEventCommand(facade),
      cancelEventCommand: CancelEventCommand(facade),
      endEventCommand: EndEventCommand(facade),
    );
  }
}
