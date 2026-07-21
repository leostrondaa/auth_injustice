import 'package:autth_injustice_app/events/domain/events_types.dart';
import 'package:autth_injustice_app/events/domain/usecases/i_events_usecases.dart';

import 'i_events_use_case_facade.dart';

class EventsUseCaseFacadeImpl implements IEventsUseCaseFacade {
  final IGetEventsCatalogUseCase _getEventsCatalogUseCase;
  final IGetEventDetailsUseCase _getEventDetailsUseCase;
  final ISetEventPersonalRecordUseCase _setEventPersonalRecordUseCase;

  EventsUseCaseFacadeImpl({
    required IGetEventsCatalogUseCase getEventsCatalogUseCase,
    required IGetEventDetailsUseCase getEventDetailsUseCase,
    required ISetEventPersonalRecordUseCase setEventPersonalRecordUseCase,
  })  : _getEventsCatalogUseCase = getEventsCatalogUseCase,
        _getEventDetailsUseCase = getEventDetailsUseCase,
        _setEventPersonalRecordUseCase = setEventPersonalRecordUseCase;

  @override
  Future<EventsCatalogResult> getCatalog(EventsNoParams params) {
    return _getEventsCatalogUseCase(params);
  }

  @override
  Future<EventDetailsResult> getEventDetails(EventIdParams params) {
    return _getEventDetailsUseCase(params);
  }

  @override
  Future<EventPersonalRecordResult> setEventPersonalRecord(
    EventPersonalRecordParams params,
  ) {
    return _setEventPersonalRecordUseCase(params);
  }
}
