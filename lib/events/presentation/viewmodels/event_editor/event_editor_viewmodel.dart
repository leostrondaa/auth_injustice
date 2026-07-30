import 'package:autth_injustice_app/events/domain/facades/i_events_use_case_facade.dart';
import 'package:autth_injustice_app/events/presentation/commands/events_commands.dart';

import 'event_editor_commands_viewmodel.dart';
import 'event_editor_state_viewmodel.dart';

class EventEditorViewModel {
  late final EventEditorState _state;
  late final EventEditorCommands _commands;

  EventEditorState get state => _state;
  EventEditorCommands get commands => _commands;

  EventEditorViewModel(IEventsUseCaseFacade facade) {
    _state = EventEditorState();
    _commands = EventEditorCommands(
      state: _state,
      loadEventDetailsCommand: LoadEventDetailsCommand(facade),
      createEventCommand: CreateEventCommand(facade),
      updateEventCommand: UpdateEventCommand(facade),
    );
  }
}
