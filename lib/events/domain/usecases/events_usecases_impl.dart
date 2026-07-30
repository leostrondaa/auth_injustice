import 'package:autth_injustice_app/events/data/repositories/i_events_repository.dart';
import 'package:autth_injustice_app/authorization/domain/models/app_permission.dart';
import 'package:autth_injustice_app/authorization/domain/services/authorization_service.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';
import 'package:autth_injustice_app/events/domain/models/event_draft_validator.dart';
import 'package:autth_injustice_app/events/domain/models/event_cancellation.dart';

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

final class GetManagementEventsCatalogUseCase
    implements IGetManagementEventsCatalogUseCase {
  final IEventsRepository _eventsRepository;
  final AuthorizationService _authorizationService;

  GetManagementEventsCatalogUseCase({
    required IEventsRepository eventsRepository,
    required AuthorizationService authorizationService,
  })  : _eventsRepository = eventsRepository,
        _authorizationService = authorizationService;

  @override
  Future<EventsCatalogResult> call(EventsNoParams params) {
    if (!_authorizationService.canManageEvents) {
      return Future.value(
        Error(ForbiddenFailure('eventManagementUnauthorized')),
      );
    }

    return _eventsRepository.getManagementCatalog();
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

final class CreateEventUseCase implements ICreateEventUseCase {
  final IEventsRepository _eventsRepository;
  final AuthorizationService _authorizationService;

  CreateEventUseCase({
    required IEventsRepository eventsRepository,
    required AuthorizationService authorizationService,
  })  : _eventsRepository = eventsRepository,
        _authorizationService = authorizationService;

  @override
  Future<EventCreationResult> call(CreateEventParams params) {
    if (!_authorizationService.can(AppPermission.createEvent)) {
      return Future.value(
        Error(ForbiddenFailure('eventManagementUnauthorized')),
      );
    }

    final validationIssue = EventDraftValidator.validateForCreation(
      params.draft,
      now: DateTime.now(),
    );
    if (validationIssue != null) {
      return Future.value(
        Error(InvalidInputFailure(validationIssue.messageKey)),
      );
    }

    return _eventsRepository.createEvent(
      params.draft.toCreationInput(),
    );
  }
}

final class UpdateEventUseCase implements IUpdateEventUseCase {
  final IEventsRepository _eventsRepository;
  final AuthorizationService _authorizationService;

  UpdateEventUseCase({
    required IEventsRepository eventsRepository,
    required AuthorizationService authorizationService,
  })  : _eventsRepository = eventsRepository,
        _authorizationService = authorizationService;

  @override
  Future<EventUpdateResult> call(UpdateEventParams params) {
    if (!_authorizationService.can(AppPermission.editEvent)) {
      return Future.value(
        Error(ForbiddenFailure('eventManagementUnauthorized')),
      );
    }
    if (params.eventId.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('eventNotFound')),
      );
    }

    final validationIssue = EventDraftValidator.validateForUpdate(
      params.draft,
      now: DateTime.now(),
    );
    if (validationIssue != null) {
      return Future.value(
        Error(InvalidInputFailure(validationIssue.messageKey)),
      );
    }

    return _eventsRepository.updateEvent(
      eventId: params.eventId,
      input: params.draft.toUpdateInput(),
    );
  }
}

final class DeleteEventUseCase implements IDeleteEventUseCase {
  final IEventsRepository _eventsRepository;
  final AuthorizationService _authorizationService;

  DeleteEventUseCase({
    required IEventsRepository eventsRepository,
    required AuthorizationService authorizationService,
  })  : _eventsRepository = eventsRepository,
        _authorizationService = authorizationService;

  @override
  Future<EventDeletionResult> call(DeleteEventParams params) {
    if (!_authorizationService.can(AppPermission.archiveEvent)) {
      return Future.value(
        Error(ForbiddenFailure('eventManagementUnauthorized')),
      );
    }

    return _eventsRepository.deleteEvent(params.eventId);
  }
}

final class CancelEventUseCase implements ICancelEventUseCase {
  final IEventsRepository _eventsRepository;
  final AuthorizationService _authorizationService;

  CancelEventUseCase({
    required IEventsRepository eventsRepository,
    required AuthorizationService authorizationService,
  })  : _eventsRepository = eventsRepository,
        _authorizationService = authorizationService;

  @override
  Future<EventCancellationResult> call(CancelEventParams params) {
    if (!_authorizationService.can(AppPermission.archiveEvent)) {
      return Future.value(
        Error(ForbiddenFailure('eventManagementUnauthorized')),
      );
    }
    if (params.eventId.trim().isEmpty ||
        !EventCancellationRules.isValidReason(params.reason)) {
      return Future.value(
        Error(InvalidInputFailure('eventManagementInvalidCancelReason')),
      );
    }

    return _eventsRepository.cancelEvent(
      eventId: params.eventId,
      reason: params.reason.trim(),
    );
  }
}

final class EndEventUseCase implements IEndEventUseCase {
  final IEventsRepository _eventsRepository;
  final AuthorizationService _authorizationService;

  EndEventUseCase({
    required IEventsRepository eventsRepository,
    required AuthorizationService authorizationService,
  })  : _eventsRepository = eventsRepository,
        _authorizationService = authorizationService;

  @override
  Future<EventEndResult> call(EndEventParams params) {
    if (!_authorizationService.can(AppPermission.endEvent)) {
      return Future.value(
        Error(ForbiddenFailure('eventManagementUnauthorized')),
      );
    }

    return _eventsRepository.endEvent(params.eventId);
  }
}
