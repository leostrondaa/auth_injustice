import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/dev/demo_backend/demo_backend_store.dart';
import 'package:autth_injustice_app/events/data/services/i_events_service.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';
import 'package:autth_injustice_app/events/domain/models/event_creation_input.dart';
import 'package:autth_injustice_app/events/domain/models/event_update_input.dart';

class DemoEventsService implements IEventsService {
  final DemoBackendStore _store;

  DemoEventsService({required DemoBackendStore demoBackendStore})
      : _store = demoBackendStore;

  @override
  Future<EventsCatalogResult> getCatalog() async {
    return Success(_store.eventsCatalog);
  }

  @override
  Future<EventsCatalogResult> getManagementCatalog({
    required String actorUid,
  }) async {
    return Success(_store.managementEventsCatalog);
  }

  @override
  Future<EventDetailsResult> getEventDetails({
    String? uid,
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

  @override
  Future<EventCreationResult> createEvent({
    required String actorUid,
    required EventCreationInput input,
  }) async {
    return Success(_store.createEvent(actorUid, input));
  }

  @override
  Future<EventUpdateResult> updateEvent({
    required String actorUid,
    required String eventId,
    required EventUpdateInput input,
  }) async {
    final updated = _store.updateEvent(actorUid, eventId, input);
    if (updated == null) {
      return Error(NotFoundFailure('eventNotFound'));
    }

    return Success(updated);
  }

  @override
  Future<EventDeletionResult> deleteEvent({
    required String actorUid,
    required String eventId,
  }) async {
    final deleted = _store.deleteEvent(actorUid, eventId);
    if (!deleted) {
      return Error(NotFoundFailure('eventNotFound'));
    }

    return const Success(true);
  }

  @override
  Future<EventCancellationResult> cancelEvent({
    required String actorUid,
    required String eventId,
    required String reason,
  }) async {
    final cancelled = _store.cancelEvent(actorUid, eventId, reason);
    if (!cancelled) {
      return Error(InvalidInputFailure('eventManagementCancelError'));
    }

    return const Success(true);
  }

  @override
  Future<EventEndResult> endEvent({
    required String actorUid,
    required String eventId,
  }) async {
    final ended = _store.endEvent(actorUid, eventId);
    if (!ended) {
      return Error(InvalidInputFailure('eventManagementEndError'));
    }

    return const Success(true);
  }
}
