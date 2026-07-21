import 'package:autth_injustice_app/events/domain/events_types.dart';

abstract interface class IEventsUseCaseFacade {
  Future<EventsCatalogResult> getCatalog(EventsNoParams params);

  Future<EventDetailsResult> getEventDetails(EventIdParams params);

  Future<EventPersonalRecordResult> setEventPersonalRecord(
    EventPersonalRecordParams params,
  );
}
