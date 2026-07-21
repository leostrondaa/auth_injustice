import 'package:autth_injustice_app/events/domain/events_types.dart';

abstract interface class IEventsRepository {
  Future<EventsCatalogResult> getCatalog();

  Future<EventDetailsResult> getEventDetails(String eventId);

  Future<EventPersonalRecordResult> setPersonalRecord({
    required String eventId,
    required bool addedToPersonalHistory,
  });
}
