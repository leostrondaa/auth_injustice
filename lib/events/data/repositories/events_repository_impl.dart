import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/events/data/services/i_events_service.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';

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
  Future<EventDetailsResult> getEventDetails(String eventId) {
    final uid = _currentAccountProvider.currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _eventsService.getEventDetails(uid: uid, eventId: eventId);
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
}
