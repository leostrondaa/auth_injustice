import 'package:autth_injustice_app/events/domain/events_types.dart';

abstract interface class IEventsUseCaseFacade {
  Future<EventsCatalogResult> getCatalog(EventsNoParams params);

  Future<EventsCatalogResult> getManagementCatalog(EventsNoParams params);

  Future<EventDetailsResult> getEventDetails(EventIdParams params);

  Future<EventPersonalRecordResult> setEventPersonalRecord(
    EventPersonalRecordParams params,
  );

  Future<EventCreationResult> createEvent(CreateEventParams params);

  Future<EventUpdateResult> updateEvent(UpdateEventParams params);

  Future<EventDeletionResult> deleteEvent(DeleteEventParams params);

  Future<EventCancellationResult> cancelEvent(CancelEventParams params);

  Future<EventEndResult> endEvent(EndEventParams params);
}
