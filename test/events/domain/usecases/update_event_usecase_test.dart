import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/authorization/domain/services/authorization_service.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/events/data/repositories/i_events_repository.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';
import 'package:autth_injustice_app/events/domain/models/event_creation_input.dart';
import 'package:autth_injustice_app/events/domain/models/event_details.dart';
import 'package:autth_injustice_app/events/domain/models/event_editor_draft.dart';
import 'package:autth_injustice_app/events/domain/models/event_preview.dart';
import 'package:autth_injustice_app/events/domain/models/event_timing.dart';
import 'package:autth_injustice_app/events/domain/models/event_update_input.dart';
import 'package:autth_injustice_app/events/domain/usecases/events_usecases_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/test_event_categories.dart';

void main() {
  group('UpdateEventUseCase', () {
    late _UpdateEventRepositorySpy repository;
    late UpdateEventUseCase useCase;

    setUp(() {
      repository = _UpdateEventRepositorySpy();
      useCase = UpdateEventUseCase(
        eventsRepository: repository,
        authorizationService: AuthorizationService(
          currentAccountProvider: _EventManagerProvider(),
        ),
      );
    });

    test('does not send an invalid draft to the repository', () async {
      final result = await useCase(
        (
          eventId: 'event-1',
          draft: const EventEditorDraft(),
        ),
      );

      expect(repository.updateCalls, 0);
      expect(result.failureValueOrNull?.msg, 'eventEditorInvalidTitle');
    });

    test('sends normalized data while keeping the current image', () async {
      final startsAt = DateTime.now().subtract(const Duration(minutes: 10));
      final draft = EventEditorDraft(
        title: '  Feira de projetos  ',
        category: TestEventCategories.academic,
        startsAt: startsAt,
        endMode: EventEndMode.manual,
        location: '  Auditório  ',
        description: '  Exposição dos projetos desenvolvidos no campus.  ',
        externalUrl: ' ifpr.edu.br/eventos ',
        existingImageUrl: 'https://example.com/event.jpg',
      );

      await useCase((eventId: 'event-1', draft: draft));

      expect(repository.updateCalls, 1);
      expect(repository.receivedEventId, 'event-1');
      expect(repository.received?.title, 'Feira de projetos');
      expect(repository.received?.locationLabel, 'Auditório');
      expect(repository.received?.externalUrl, 'https://ifpr.edu.br/eventos');
      expect(repository.received?.replacementImageSource, isNull);
    });

    test('treats a past scheduled publication as already published', () {
      final now = DateTime(2027, 3, 18, 12);
      final startsAt = now.add(const Duration(days: 1));
      final details = _eventDetails(
        startsAt: startsAt,
        publishAt: now.subtract(const Duration(hours: 1)),
      );

      final draft = EventEditorDraft.fromDetails(details, now: now);

      expect(draft.publishAt, isNull);
    });
  });
}

EventDetails _eventDetails({
  required DateTime startsAt,
  DateTime? publishAt,
}) {
  return EventDetails(
    event: EventPreview(
      id: 'event-1',
      title: 'Feira de projetos',
      category: TestEventCategories.academic,
      startsAt: startsAt,
      location: '',
      description: 'Projetos desenvolvidos no campus.',
      imageUrl: 'https://example.com/event.jpg',
      endMode: EventEndMode.manual,
      publishAt: publishAt,
    ),
    addedToPersonalHistory: false,
  );
}

class _EventManagerProvider implements ICurrentAccountProvider {
  @override
  Account get currentAccount => Account(
        uid: 'event-manager',
        email: 'events@ifpr.edu.br',
        displayName: 'Event manager',
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
        role: AccountRole.eventManager,
      );

  @override
  String get currentUid => currentAccount.uid;
}

class _UpdateEventRepositorySpy implements IEventsRepository {
  int updateCalls = 0;
  String? receivedEventId;
  EventUpdateInput? received;

  @override
  Future<EventUpdateResult> updateEvent({
    required String eventId,
    required EventUpdateInput input,
  }) {
    updateCalls++;
    receivedEventId = eventId;
    received = input;
    return Future.value(Error(RemoteFailure('testRemoteFailure')));
  }

  @override
  Future<EventCancellationResult> cancelEvent({
    required String eventId,
    required String reason,
  }) =>
      throw UnimplementedError();

  @override
  Future<EventCreationResult> createEvent(EventCreationInput input) =>
      throw UnimplementedError();

  @override
  Future<EventDeletionResult> deleteEvent(String eventId) =>
      throw UnimplementedError();

  @override
  Future<EventEndResult> endEvent(String eventId) => throw UnimplementedError();

  @override
  Future<EventsCatalogResult> getCatalog() => throw UnimplementedError();

  @override
  Future<EventDetailsResult> getEventDetails(String eventId) =>
      throw UnimplementedError();

  @override
  Future<EventsCatalogResult> getManagementCatalog() =>
      throw UnimplementedError();

  @override
  Future<EventPersonalRecordResult> setPersonalRecord({
    required String eventId,
    required bool addedToPersonalHistory,
  }) =>
      throw UnimplementedError();
}
