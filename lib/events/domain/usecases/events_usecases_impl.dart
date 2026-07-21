import 'package:autth_injustice_app/events/data/repositories/i_events_repository.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';

import 'i_events_usecases.dart';

final class GetEventsCatalogUseCase implements IGetEventsCatalogUseCase {
  final IEventsRepository _eventsRepository;

  GetEventsCatalogUseCase({required IEventsRepository eventsRepository})
      : _eventsRepository = eventsRepository;

  @override
  Future<EventsCatalogResult> call(EventsNoParams params) {
    return _eventsRepository.getCatalog();
  }
}

final class GetEventDetailsUseCase implements IGetEventDetailsUseCase {
  final IEventsRepository _eventsRepository;

  GetEventDetailsUseCase({required IEventsRepository eventsRepository})
      : _eventsRepository = eventsRepository;

  @override
  Future<EventDetailsResult> call(EventIdParams params) {
    return _eventsRepository.getEventDetails(params.eventId);
  }
}

final class SetEventPersonalRecordUseCase
    implements ISetEventPersonalRecordUseCase {
  final IEventsRepository _eventsRepository;

  SetEventPersonalRecordUseCase({required IEventsRepository eventsRepository})
      : _eventsRepository = eventsRepository;

  @override
  Future<EventPersonalRecordResult> call(EventPersonalRecordParams params) {
    return _eventsRepository.setPersonalRecord(
      eventId: params.eventId,
      addedToPersonalHistory: params.addedToPersonalHistory,
    );
  }
}
