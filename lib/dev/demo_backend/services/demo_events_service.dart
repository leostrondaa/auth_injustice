import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/dev/demo_backend/demo_backend_store.dart';
import 'package:autth_injustice_app/events/data/services/i_events_service.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';

class DemoEventsService implements IEventsService {
  final DemoBackendStore _store;

  DemoEventsService({required DemoBackendStore demoBackendStore})
      : _store = demoBackendStore;

  @override
  Future<EventsCatalogResult> getCatalog() async {
    return Success(_store.eventsCatalog);
  }

  @override
  Future<EventDetailsResult> getEventDetails({
    required String uid,
    required String eventId,
  }) async {
    final details = _store.eventDetails(uid, eventId);
    if (details == null) {
      return Error(NotFoundFailure('eventNotFound'));
    }

    return Success(details);
  }

  @override
  Future<EventPersonalRecordResult> setPersonalRecord({
    required String uid,
    required String eventId,
    required bool addedToPersonalHistory,
  }) async {
    final updated = _store.setEventPersonalRecord(
      uid: uid,
      eventId: eventId,
      addedToPersonalHistory: addedToPersonalHistory,
    );
    if (!updated) {
      return Error(NotFoundFailure('eventNotFound'));
    }

    return Success(addedToPersonalHistory);
  }
}
