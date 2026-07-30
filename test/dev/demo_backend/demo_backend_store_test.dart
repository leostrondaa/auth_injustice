import 'package:autth_injustice_app/authorization/domain/models/account_role.dart';
import 'package:autth_injustice_app/dev/demo_backend/demo_backend_store.dart';
import 'package:autth_injustice_app/events/domain/models/event_editor_draft.dart';
import 'package:autth_injustice_app/events/domain/models/event_timing.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_package.dart';
import 'package:autth_injustice_app/institution/packages/ifpr_pgua/ifpr_pgua_event_categories.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_draft.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DemoBackendStore', () {
    test('public event details do not expose a personal record', () {
      final store = _createStore();
      final details = store.eventDetails(null, 'neon-district');

      expect(details, isNotNull);
      expect(details!.addedToPersonalHistory, isFalse);
    });

    test('shares personal records with the informal hours estimate', () {
      final store = _createStore();
      final uid = store.currentUser.uid;
      final initialHours = store.complementaryHoursSummary(uid).completedHours;

      expect(
        store.setEventPersonalRecord(
          uid: uid,
          eventId: 'neon-district',
          addedToPersonalHistory: true,
        ),
        isTrue,
      );

      expect(
        store.eventDetails(uid, 'neon-district')?.addedToPersonalHistory,
        isTrue,
      );
      expect(
        store.eventDetails(uid, 'neon-district')?.complementaryHours,
        4,
      );
      expect(
        store.complementaryHoursSummary(uid).completedHours,
        initialHours + 4,
      );
      expect(
        store
            .complementaryHoursRecords(uid)
            .any((record) => record.id == 'neon-district'),
        isTrue,
      );
      store.setEventPersonalRecord(
        uid: uid,
        eventId: 'neon-district',
        addedToPersonalHistory: false,
      );

      expect(
        store.eventDetails(uid, 'neon-district')?.addedToPersonalHistory,
        isFalse,
      );
      expect(
        store.complementaryHoursSummary(uid).completedHours,
        initialHours,
      );
      expect(
        store
            .complementaryHoursRecords(uid)
            .any((record) => record.id == 'neon-district'),
        isFalse,
      );
    });

    test('deleting a record also removes it from personal history', () {
      final store = _createStore();
      final uid = store.currentUser.uid;

      store.setEventPersonalRecord(
        uid: uid,
        eventId: 'city-run',
        addedToPersonalHistory: true,
      );
      expect(
        store.eventDetails(uid, 'city-run')?.addedToPersonalHistory,
        isTrue,
      );

      expect(
        store.deleteComplementaryHoursRecord(uid, 'city-run'),
        isTrue,
      );
      expect(
        store.eventDetails(uid, 'city-run')?.addedToPersonalHistory,
        isFalse,
      );
    });

    test('events without workload are kept in personal records', () {
      final store = _createStore();
      final uid = store.currentUser.uid;
      final initialHours = store.complementaryHoursSummary(uid).completedHours;

      expect(store.eventDetails(uid, 'jazz-under-stars')?.complementaryHours,
          isNull);
      expect(
        store.setEventPersonalRecord(
          uid: uid,
          eventId: 'jazz-under-stars',
          addedToPersonalHistory: true,
        ),
        isTrue,
      );

      expect(
        store.complementaryHoursSummary(uid).completedHours,
        initialHours,
      );
      expect(
        store
            .complementaryHoursRecords(uid)
            .any((record) => record.id == 'jazz-under-stars'),
        isTrue,
      );
      expect(
        store
            .complementaryHoursRecords(uid)
            .where((record) => record.id == 'jazz-under-stars')
            .single
            .hours,
        isNull,
      );
    });

    test('deleting a private event removes it permanently', () {
      final store = _createStore();
      final uid = store.currentUser.uid;
      final now = DateTime.now();
      final created = store.createEvent(
        uid,
        EventEditorDraft(
          title: 'Evento ainda privado',
          category: IfprPguaEventCategories.institutional,
          startsAt: now.add(const Duration(days: 3)),
          endMode: EventEndMode.manual,
          description: 'Evento agendado que ainda não foi publicado.',
          selectedImageSource: 'C:/tmp/private-event.jpg',
          publishAt: now.add(const Duration(days: 1)),
        ).toCreationInput(),
      );

      expect(store.deleteEvent(uid, created.event.id), isTrue);
      expect(store.eventDetails(uid, created.event.id), isNull);
      expect(
        store.managementEventsCatalog.futureEvents.any(
          (event) => event.id == created.event.id,
        ),
        isFalse,
      );
    });

    test('cancelling a published event preserves it and notifies everyone', () {
      final store = _createStore();
      final uid = store.currentUser.uid;
      final now = DateTime.now();
      final created = store.createEvent(
        uid,
        EventEditorDraft(
          title: 'Encontro da comunidade',
          category: IfprPguaEventCategories.community,
          startsAt: now.add(const Duration(days: 2)),
          endMode: EventEndMode.manual,
          description: 'Encontro aberto para toda a comunidade do campus.',
          selectedImageSource: 'C:/tmp/published-event.jpg',
        ).toCreationInput(),
      );

      expect(
        store.cancelEvent(
          uid,
          created.event.id,
          'O espaço ficará indisponível para manutenção.',
          cancelledAt: now,
        ),
        isTrue,
      );

      final details = store.eventDetails(uid, created.event.id);
      expect(details?.event.isCancelled, isTrue);
      expect(
        details?.event.cancellationReason,
        'O espaço ficará indisponível para manutenção.',
      );
      expect(
        store.eventsCatalog.futureEvents.any(
          (event) => event.id == created.event.id,
        ),
        isFalse,
      );
      final notification = store.notificationsFor(uid).firstWhere(
            (item) => item.eventId == created.event.id,
          );
      expect(notification.authorUid, uid);
      expect(notification.message, details?.event.cancellationReason);
    });

    test('created event keeps optional workload in minutes', () {
      final store = _createStore();
      final now = DateTime.now();
      final created = store.createEvent(
        store.currentUser.uid,
        EventEditorDraft(
          title: 'Mostra de projetos',
          category: IfprPguaEventCategories.academic,
          startsAt: now.add(const Duration(days: 2)),
          endMode: EventEndMode.automatic,
          endsAt: now.add(const Duration(days: 2, hours: 2)),
          description: 'Apresentação dos projetos desenvolvidos no campus.',
          complementaryMinutes: 270,
          selectedImageSource: 'C:/tmp/event.jpg',
        ).toCreationInput(),
      );

      expect(created.complementaryMinutes, 270);
      expect(
        store.eventsCatalog.futureEvents.any(
          (event) => event.id == created.event.id,
        ),
        isTrue,
      );
    });

    test('scheduled event stays private until its publication time', () {
      final store = _createStore();
      final now = DateTime.now();
      final created = store.createEvent(
        store.currentUser.uid,
        EventEditorDraft(
          title: 'Semana cultural',
          category: IfprPguaEventCategories.artsAndCulture,
          startsAt: now.add(const Duration(days: 3)),
          endMode: EventEndMode.automatic,
          endsAt: now.add(const Duration(days: 3, hours: 2)),
          description: 'Atividades culturais abertas para toda a comunidade.',
          selectedImageSource: 'C:/tmp/event.jpg',
          publishAt: now.add(const Duration(hours: 2)),
        ).toCreationInput(),
      );

      expect(
        store.managementEventsCatalog.futureEvents.any(
          (event) => event.id == created.event.id,
        ),
        isTrue,
      );
      expect(
        store.eventsCatalog.futureEvents.any(
          (event) => event.id == created.event.id,
        ),
        isFalse,
      );
    });

    test('updating an event preserves its image and personal record', () {
      final store = _createStore();
      final uid = store.currentUser.uid;
      final current = store.eventDetails(uid, 'city-run')!;

      store.setEventPersonalRecord(
        uid: uid,
        eventId: current.event.id,
        addedToPersonalHistory: true,
      );

      final updated = store.updateEvent(
        uid,
        current.event.id,
        EventEditorDraft.fromDetails(current)
            .copyWith(
              title: 'Corrida do campus',
              complementaryMinutes: 150,
            )
            .toUpdateInput(),
      );

      expect(updated?.event.title, 'Corrida do campus');
      expect(updated?.event.imageUrl, current.event.imageUrl);
      expect(updated?.complementaryMinutes, 150);
      expect(
        store
            .complementaryHoursRecords(uid)
            .where((record) => record.id == current.event.id)
            .single
            .durationMinutes,
        150,
      );
    });

    test('manual event remains featured until an administrator ends it', () {
      final store = _createStore();
      final now = DateTime.now();
      final created = store.createEvent(
        store.currentUser.uid,
        EventEditorDraft(
          title: 'Apresentação aberta',
          category: IfprPguaEventCategories.artsAndCulture,
          startsAt: now.subtract(const Duration(minutes: 30)),
          endMode: EventEndMode.manual,
          description: 'Evento com horário de término ainda indefinido.',
          selectedImageSource: 'C:/tmp/event.jpg',
        ).toCreationInput(),
      );

      expect(
        store.eventsCatalog.featuredEvents.any(
          (event) => event.id == created.event.id,
        ),
        isTrue,
      );
      expect(
        store.endEvent(
          store.currentUser.uid,
          created.event.id,
          endedAt: now,
        ),
        isTrue,
      );
      expect(
        store.eventsCatalog.featuredEvents.any(
          (event) => event.id == created.event.id,
        ),
        isFalse,
      );
      expect(
        store
            .eventDetails(store.currentUser.uid, created.event.id)
            ?.event
            .endedAt,
        now,
      );
    });

    test('publishing an announcement adds a campus-wide update', () {
      final store = _createStore();
      final uid = store.currentUser.uid;
      final createdAt = DateTime(2026, 7, 28, 10, 30);
      final published = store.publishAnnouncement(
        uid,
        const NotificationAnnouncementDraft(
          title: 'Manutenção programada',
          message: 'O sistema ficará indisponível durante a tarde.',
          externalUrl: 'https://ifpr.edu.br/avisos',
        ).toInput(),
        createdAt: createdAt,
      );

      expect(published.type.name, 'update');
      expect(published.authorUid, uid);
      expect(published.externalUrl, 'https://ifpr.edu.br/avisos');
      expect(published.createdAt, createdAt);
      expect(
        store.notificationsFor(uid).firstWhere(
              (notification) => notification.id == published.id,
            ),
        same(published),
      );
    });

    test('managed user details share account, progress, and records', () {
      final store = _createStore();
      final actorUid = store.currentUser.uid;
      final user = store.usersForManagement(actorUid).firstWhere(
            (item) => item.id == 'demo-student-ana',
          );

      final details = store.managedUserDetails(actorUid, user.id);

      expect(details, isNotNull);
      expect(details?.user, user);
      expect(
        details?.hoursSummary.completedMinutes,
        user.totalComplementaryMinutes,
      );
      expect(details?.records, isNotEmpty);
    });

    test('managed user role can be promoted and demoted', () {
      final store = _createStore();
      final actorUid = store.currentUser.uid;
      const userId = 'demo-student-ana';

      final promoted = store.updateManagedUserRole(
        actorUid,
        userId,
        AccountRole.eventManager,
      );
      final demoted = store.updateManagedUserRole(
        actorUid,
        userId,
        AccountRole.student,
      );

      expect(promoted?.account.role, AccountRole.eventManager);
      expect(demoted?.account.role, AccountRole.student);
    });
  });
}

DemoBackendStore _createStore() {
  return DemoBackendStore(
    institutionPackage: const IfprPguaPackage(),
  );
}
