import 'package:autth_injustice_app/core/patterns/i_usecases.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';

abstract interface class IGetEventsCatalogUseCase
    implements IUseCase<EventsCatalogResult, EventsNoParams> {}

abstract interface class IGetEventDetailsUseCase
    implements IUseCase<EventDetailsResult, EventIdParams> {}

abstract interface class ISetEventPersonalRecordUseCase
    implements IUseCase<EventPersonalRecordResult, EventPersonalRecordParams> {}
