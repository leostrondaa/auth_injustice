import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/authorization/domain/services/authorization_service.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/events/data/repositories/i_events_repository.dart';
import 'package:autth_injustice_app/events/domain/events_types.dart';
import 'package:autth_injustice_app/events/domain/models/event_creation_input.dart';
import 'package:autth_injustice_app/events/domain/models/event_editor_draft.dart';
import 'package:autth_injustice_app/events/domain/models/event_timing.dart';
import 'package:autth_injustice_app/events/domain/models/event_update_input.dart';
import 'package:autth_injustice_app/events/domain/usecases/events_usecases_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/test_event_categories.dart';

void main() {
  group('CreateEventUseCase', () {
    late _CreateEventRepositorySpy repository;
    late CreateEventUseCase useCase;

    setUp(() {
      repository = _CreateEventRepositorySpy();
      useCase = CreateEventUseCase(
        eventsRepository: repository,
        authorizationService: AuthorizationService(
          currentAccountProvider: _EventManagerProvider(),
        ),
      );
    });

    test('does not send an invalid draft to the repository', () async {
      final result = await useCase((draft: const EventEditorDraft()));

      expect(repository.createCalls, 0);
      expect(result.failureValueOrNull?.msg, 'eventEditorInvalidTitle');
    });

    test('sends a normalized creation input to the repository', () async {
      final now = DateTime.now();
      final startsAt = now.add(const Duration(days: 2));
      final draft = EventEditorDraft(
        title: '  Feira de projetos  ',
        category: TestEventCategories.academic,
        startsAt: startsAt,
        endMode: EventEndMode.automatic,
        endsAt: startsAt.add(const Duration(hours: 2)),
        location: '  Auditório  ',
        description: '  Exposição dos projetos desenvolvidos no campus.  ',
        externalUrl: ' ifpr.edu.br/eventos ',
        selectedImageSource: ' C:/tmp/event.jpg ',
      );

      await useCase((draft: draft));

      expect(repository.createCalls, 1);
      expect(repository.received?.title, 'Feira de projetos');
      expect(repository.received?.locationLabel, 'Auditório');
      expect(repository.received?.externalUrl, 'https://ifpr.edu.br/eventos');
      expect(repository.received?.imageSource, 'C:/tmp/event.jpg');
    });

    test('does not send an invalid external link to the repository', () async {
      final startsAt = DateTime.now().add(const Duration(days: 2));
      final draft = EventEditorDraft(
        title: 'Feira de projetos',
        category: TestEventCategories.academic,
        startsAt: startsAt,
        endMode: EventEndMode.manual,
        description: 'Exposição dos projetos desenvolvidos no campus.',
        externalUrl: 'arquivo://inscricao',
        selectedImageSource: 'C:/tmp/event.jpg',
      );

      final result = await useCase((draft: draft));

      expect(repository.createCalls, 0);
      expect(
        result.failureValueOrNull?.msg,
        'eventEditorInvalidExternalLink',
      );
    });
  });

  group('CancelEventUseCase', () {
    late _CreateEventRepositorySpy repository;
    late CancelEventUseCase useCase;

    setUp(() {
      repository = _CreateEventRepositorySpy();
      useCase = CancelEventUseCase(
        eventsRepository: repository,
        authorizationService: AuthorizationService(
          currentAccountProvider: _EventManagerProvider(),
        ),
      );
    });

    test('rejects a short reason before reaching the repository', () async {
      final result = await useCase(
        (
          eventId: 'event-1',
          reason: 'Chuva',
        ),
      );

      expect(repository.cancelCalls, 0);
      expect(
        result.failureValueOrNull?.msg,
        'eventManagementInvalidCancelReason',
      );
    });

    test('sends a normalized cancellation reason', () async {
      await useCase(
        (
          eventId: 'event-1',
          reason: '  O auditório ficará indisponível para manutenção.  ',
        ),
      );

      expect(repository.cancelCalls, 1);
      expect(
        repository.receivedCancellationReason,
        'O auditório ficará indisponível para manutenção.',
      );
    });
  });
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

class _CreateEventRepositorySpy implements IEventsRepository {
  int createCalls = 0;
  int cancelCalls = 0;
  EventCreationInput? received;
  String? receivedCancellationReason;

  @override
  Future<EventCreationResult> createEvent(EventCreationInput input) {
    createCalls++;
    received = input;
    return Future.value(Error(RemoteFailure('testRemoteFailure')));
  }

  @override
  Future<EventCancellationResult> cancelEvent({
    required String eventId,
    required String reason,
  }) {
    cancelCalls++;
    receivedCancellationReason = reason;
    return Future.value(Error(RemoteFailure('testRemoteFailure')));
  }

  @override
  Future<EventDeletionResult> deleteEvent(String eventId) =>
      throw UnimplementedError();

  @override
  Future<EventEndResult> endEvent(String eventId) => throw UnimplementedError();

  @override
  Future<EventUpdateResult> updateEvent({
    required String eventId,
    required EventUpdateInput input,
  }) =>
      throw UnimplementedError();

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
