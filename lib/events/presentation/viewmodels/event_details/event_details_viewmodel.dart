import 'package:autth_injustice_app/events/domain/facades/i_events_use_case_facade.dart';
import 'package:autth_injustice_app/events/presentation/commands/events_commands.dart';

import 'event_details_commands_viewmodel.dart';
import 'event_details_state_viewmodel.dart';

class EventDetailsViewModel {
  late final EventDetailsState _state;
  late final EventDetailsCommands _commands;

  EventDetailsState get state => _state;
  EventDetailsCommands get commands => _commands;

  EventDetailsViewModel(IEventsUseCaseFacade facade) {
    _state = EventDetailsState();
    _commands = EventDetailsCommands(
      state: _state,
      loadEventDetailsCommand: LoadEventDetailsCommand(facade),
      setEventPersonalRecordCommand: SetEventPersonalRecordCommand(facade),
    );
  }
}
