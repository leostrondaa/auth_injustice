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
        Error(InvalidInputFailure('eventsLoadError')),
      );
    }

    return _eventsFacade.getCatalog(parameter!);
  }
}

final class LoadManagementEventsCatalogCommand
    extends ParameterizedCommand<EventsCatalog, Failure, EventsNoParams> {
  final IEventsUseCaseFacade _eventsFacade;

  LoadManagementEventsCatalogCommand(this._eventsFacade);

  @override
  Future<EventsCatalogResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('eventManagementLoadError')),
      );
    }

    return _eventsFacade.getManagementCatalog(parameter!);
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
        Error(InvalidInputFailure('eventDetailsUnavailable')),
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
        Error(InvalidInputFailure('eventDetailsUnavailable')),
      );
    }

    return _eventsFacade.setEventPersonalRecord(parameter!);
  }
}

final class CreateEventCommand
    extends ParameterizedCommand<EventDetails, Failure, CreateEventParams> {
  final IEventsUseCaseFacade _eventsFacade;

  CreateEventCommand(this._eventsFacade);

  @override
  Future<EventCreationResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('eventEditorRequiredFields')),
      );
    }

    return _eventsFacade.createEvent(parameter!);
  }
}

final class UpdateEventCommand
    extends ParameterizedCommand<EventDetails, Failure, UpdateEventParams> {
  final IEventsUseCaseFacade _eventsFacade;

  UpdateEventCommand(this._eventsFacade);

  @override
  Future<EventUpdateResult> execute() {
    if (parameter == null || parameter!.eventId.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('eventNotFound')),
      );
    }

    return _eventsFacade.updateEvent(parameter!);
  }
}

final class DeleteEventCommand
    extends ParameterizedCommand<bool, Failure, DeleteEventParams> {
  final IEventsUseCaseFacade _eventsFacade;

  DeleteEventCommand(this._eventsFacade);

  @override
  Future<EventDeletionResult> execute() {
    if (parameter == null || parameter!.eventId.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('eventNotFound')),
      );
    }

    return _eventsFacade.deleteEvent(parameter!);
  }
}

final class CancelEventCommand
    extends ParameterizedCommand<bool, Failure, CancelEventParams> {
  final IEventsUseCaseFacade _eventsFacade;

  CancelEventCommand(this._eventsFacade);

  @override
  Future<EventCancellationResult> execute() {
    if (parameter == null || parameter!.eventId.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('eventNotFound')),
      );
    }

    return _eventsFacade.cancelEvent(parameter!);
  }
}

final class EndEventCommand
    extends ParameterizedCommand<bool, Failure, EndEventParams> {
  final IEventsUseCaseFacade _eventsFacade;

  EndEventCommand(this._eventsFacade);

  @override
  Future<EventEndResult> execute() {
    if (parameter == null || parameter!.eventId.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('eventNotFound')),
      );
    }

    return _eventsFacade.endEvent(parameter!);
  }
}
