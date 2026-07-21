import 'package:autth_injustice_app/dev/demo_backend/demo_backend_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DemoBackendStore', () {
    test('shares personal records with the informal hours estimate', () {
      final store = DemoBackendStore();
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
      final store = DemoBackendStore();
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
      final store = DemoBackendStore();
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
  });
}
