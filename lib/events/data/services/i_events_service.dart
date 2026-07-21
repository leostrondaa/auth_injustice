import 'package:autth_injustice_app/events/domain/events_types.dart';

abstract interface class IEventsService {
  Future<EventsCatalogResult> getCatalog();

  Future<EventDetailsResult> getEventDetails({
    required String uid,
    required String eventId,
  });

  Future<EventPersonalRecordResult> setPersonalRecord({
    required String uid,
    required String eventId,
    required bool addedToPersonalHistory,
  });
}
