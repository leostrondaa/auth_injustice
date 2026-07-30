import 'package:autth_injustice_app/events/domain/events_types.dart';
import 'package:autth_injustice_app/events/domain/models/event_creation_input.dart';
import 'package:autth_injustice_app/events/domain/models/event_update_input.dart';

abstract interface class IEventsRepository {
  Future<EventsCatalogResult> getCatalog();

  Future<EventsCatalogResult> getManagementCatalog();

  Future<EventDetailsResult> getEventDetails(String eventId);

  Future<EventPersonalRecordResult> setPersonalRecord({
    required String eventId,
    required bool addedToPersonalHistory,
  });

  Future<EventCreationResult> createEvent(EventCreationInput input);

  Future<EventUpdateResult> updateEvent({
    required String eventId,
    required EventUpdateInput input,
  });

  Future<EventDeletionResult> deleteEvent(String eventId);

  Future<EventCancellationResult> cancelEvent({
    required String eventId,
    required String reason,
  });

  Future<EventEndResult> endEvent(String eventId);
}
