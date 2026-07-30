import 'package:autth_injustice_app/events/domain/events_types.dart';
import 'package:autth_injustice_app/events/domain/usecases/i_events_usecases.dart';

import 'i_events_use_case_facade.dart';

class EventsUseCaseFacadeImpl implements IEventsUseCaseFacade {
  final IGetEventsCatalogUseCase _getEventsCatalogUseCase;
  final IGetManagementEventsCatalogUseCase _getManagementEventsCatalogUseCase;
  final IGetEventDetailsUseCase _getEventDetailsUseCase;
  final ISetEventPersonalRecordUseCase _setEventPersonalRecordUseCase;
  final ICreateEventUseCase _createEventUseCase;
  final IUpdateEventUseCase _updateEventUseCase;
  final IDeleteEventUseCase _deleteEventUseCase;
  final ICancelEventUseCase _cancelEventUseCase;
  final IEndEventUseCase _endEventUseCase;

  EventsUseCaseFacadeImpl({
    required IGetEventsCatalogUseCase getEventsCatalogUseCase,
    required IGetManagementEventsCatalogUseCase
        getManagementEventsCatalogUseCase,
    required IGetEventDetailsUseCase getEventDetailsUseCase,
    required ISetEventPersonalRecordUseCase setEventPersonalRecordUseCase,
    required ICreateEventUseCase createEventUseCase,
    required IUpdateEventUseCase updateEventUseCase,
    required IDeleteEventUseCase deleteEventUseCase,
    required ICancelEventUseCase cancelEventUseCase,
    required IEndEventUseCase endEventUseCase,
  })  : _getEventsCatalogUseCase = getEventsCatalogUseCase,
        _getManagementEventsCatalogUseCase = getManagementEventsCatalogUseCase,
        _getEventDetailsUseCase = getEventDetailsUseCase,
        _setEventPersonalRecordUseCase = setEventPersonalRecordUseCase,
        _createEventUseCase = createEventUseCase,
        _updateEventUseCase = updateEventUseCase,
        _deleteEventUseCase = deleteEventUseCase,
        _cancelEventUseCase = cancelEventUseCase,
        _endEventUseCase = endEventUseCase;

  @override
  Future<EventsCatalogResult> getCatalog(EventsNoParams params) {
    return _getEventsCatalogUseCase(params);
  }

  @override
  Future<EventsCatalogResult> getManagementCatalog(EventsNoParams params) {
    return _getManagementEventsCatalogUseCase(params);
  }

  @override
  Future<EventDetailsResult> getEventDetails(EventIdParams params) {
    return _getEventDetailsUseCase(params);
  }

  @override
  Future<EventPersonalRecordResult> setEventPersonalRecord(
    EventPersonalRecordParams params,
  ) {
    return _setEventPersonalRecordUseCase(params);
  }

  @override
  Future<EventCreationResult> createEvent(CreateEventParams params) {
    return _createEventUseCase(params);
  }

  @override
  Future<EventUpdateResult> updateEvent(UpdateEventParams params) {
    return _updateEventUseCase(params);
  }

  @override
  Future<EventDeletionResult> deleteEvent(DeleteEventParams params) {
    return _deleteEventUseCase(params);
  }

  @override
  Future<EventCancellationResult> cancelEvent(CancelEventParams params) {
    return _cancelEventUseCase(params);
  }

  @override
  Future<EventEndResult> endEvent(EndEventParams params) {
    return _endEventUseCase(params);
  }
}
