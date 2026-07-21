import 'package:autth_injustice_app/events/domain/facades/i_events_use_case_facade.dart';
import 'package:autth_injustice_app/events/presentation/commands/events_commands.dart';

import 'events_catalog_commands_viewmodel.dart';
import 'events_catalog_state_viewmodel.dart';

class EventsCatalogViewModel {
  late final EventsCatalogState _state;
  late final EventsCatalogCommands _commands;

  EventsCatalogState get state => _state;
  EventsCatalogCommands get commands => _commands;

  EventsCatalogViewModel(IEventsUseCaseFacade facade) {
    _state = EventsCatalogState();
    _commands = EventsCatalogCommands(
      state: _state,
      loadEventsCatalogCommand: LoadEventsCatalogCommand(facade),
    );
  }
}
