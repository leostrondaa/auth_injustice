import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/events/data/services/i_events_service.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';
import 'package:autth_injustice_app/events/domain/models/event_creation_input.dart';
import 'package:autth_injustice_app/events/domain/models/event_update_input.dart';

import 'i_events_repository.dart';

class EventsRepositoryImpl implements IEventsRepository {
  final IEventsService _eventsService;
  final ICurrentAccountProvider _currentAccountProvider;

  EventsRepositoryImpl({
    required IEventsService eventsService,
    required ICurrentAccountProvider currentAccountProvider,
  })  : _eventsService = eventsService,
        _currentAccountProvider = currentAccountProvider;

  @override
  Future<EventsCatalogResult> getCatalog() => _eventsService.getCatalog();

  @override
  Future<EventsCatalogResult> getManagementCatalog() {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _eventsService.getManagementCatalog(actorUid: uid);
  }

  @override
  Future<EventDetailsResult> getEventDetails(String eventId) {
    return _eventsService.getEventDetails(
      uid: _currentAccountProvider.currentUid,
      eventId: eventId,
    );
  }

  @override
  Future<EventPersonalRecordResult> setPersonalRecord({
    required String eventId,
    required bool addedToPersonalHistory,
  }) {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _eventsService.setPersonalRecord(
      uid: uid,
      eventId: eventId,
      addedToPersonalHistory: addedToPersonalHistory,
    );
  }

  @override
  Future<EventCreationResult> createEvent(EventCreationInput input) {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _eventsService.createEvent(
      actorUid: uid,
      input: input,
    );
  }

  @override
  Future<EventUpdateResult> updateEvent({
    required String eventId,
    required EventUpdateInput input,
  }) {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _eventsService.updateEvent(
      actorUid: uid,
      eventId: eventId,
      input: input,
    );
  }

  @override
  Future<EventDeletionResult> deleteEvent(String eventId) {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _eventsService.deleteEvent(
      actorUid: uid,
      eventId: eventId,
    );
  }

  @override
  Future<EventCancellationResult> cancelEvent({
    required String eventId,
    required String reason,
  }) {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _eventsService.cancelEvent(
      actorUid: uid,
      eventId: eventId,
      reason: reason,
    );
  }

  @override
  Future<EventEndResult> endEvent(String eventId) {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _eventsService.endEvent(
      actorUid: uid,
      eventId: eventId,
    );
  }
}
