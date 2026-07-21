import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/command.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';
import 'package:autth_injustice_app/events/domain/facades/i_events_use_case_facade.dart';
import 'package:autth_injustice_app/events/domain/models/event_details.dart';
import 'package:autth_injustice_app/events/domain/models/events_catalog.dart';

final class LoadEventsCatalogCommand
    extends ParameterizedCommand<EventsCatalog, Failure, EventsNoParams> {
  final IEventsUseCaseFacade _eventsFacade;

  LoadEventsCatalogCommand(this._eventsFacade);

  @override
  Future<EventsCatalogResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('Parâmetro do catálogo não informado.')),
      );
    }

    return _eventsFacade.getCatalog(parameter!);
  }
}

final class LoadEventDetailsCommand
    extends ParameterizedCommand<EventDetails, Failure, EventIdParams> {
  final IEventsUseCaseFacade _eventsFacade;

  LoadEventDetailsCommand(this._eventsFacade);

  @override
  Future<EventDetailsResult> execute() {
    if (parameter == null || parameter!.eventId.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('Identificador do evento inválido.')),
      );
    }

    return _eventsFacade.getEventDetails(parameter!);
  }
}

final class SetEventPersonalRecordCommand
    extends ParameterizedCommand<bool, Failure, EventPersonalRecordParams> {
  final IEventsUseCaseFacade _eventsFacade;

  SetEventPersonalRecordCommand(this._eventsFacade);

  @override
  Future<EventPersonalRecordResult> execute() {
    if (parameter == null || parameter!.eventId.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('Identificador do evento inválido.')),
      );
    }

    return _eventsFacade.setEventPersonalRecord(parameter!);
  }
}
