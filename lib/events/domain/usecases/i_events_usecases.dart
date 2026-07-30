import 'package:autth_injustice_app/core/patterns/i_usecases.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';

abstract interface class IGetEventsCatalogUseCase
    implements IUseCase<EventsCatalogResult, EventsNoParams> {}

abstract interface class IGetManagementEventsCatalogUseCase
    implements IUseCase<EventsCatalogResult, EventsNoParams> {}

abstract interface class IGetEventDetailsUseCase
    implements IUseCase<EventDetailsResult, EventIdParams> {}

abstract interface class ISetEventPersonalRecordUseCase
    implements IUseCase<EventPersonalRecordResult, EventPersonalRecordParams> {}

abstract interface class ICreateEventUseCase
    implements IUseCase<EventCreationResult, CreateEventParams> {}

abstract interface class IUpdateEventUseCase
    implements IUseCase<EventUpdateResult, UpdateEventParams> {}

abstract interface class IDeleteEventUseCase
    implements IUseCase<EventDeletionResult, DeleteEventParams> {}

abstract interface class ICancelEventUseCase
    implements IUseCase<EventCancellationResult, CancelEventParams> {}

abstract interface class IEndEventUseCase
    implements IUseCase<EventEndResult, EndEventParams> {}
