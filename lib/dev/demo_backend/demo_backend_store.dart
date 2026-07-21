import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_record.dart';
import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_summary.dart';
import 'package:autth_injustice_app/dev/demo_backend/demo_backend_seed.dart';
import 'package:autth_injustice_app/dev/demo_backend/models/demo_event.dart';
import 'package:autth_injustice_app/account/domain/models/account.dart';
import 'package:autth_injustice_app/events/domain/models/event_details.dart';
import 'package:autth_injustice_app/events/domain/models/events_catalog.dart';
import 'package:autth_injustice_app/notifications/domain/models/app_notification.dart';

/// Backend local compartilhado pelas features durante o desenvolvimento.
///
/// Ele concentra somente estado e regras de integração. As telas continuam
/// acessando seus próprios serviços, repositórios, use cases e viewmodels.
class DemoBackendStore {
  final Account currentUser = DemoBackendSeed.account;
  final List<DemoEvent> _featuredEvents =
      List.of(DemoBackendSeed.featuredEvents);

  final List<DemoEvent> _futureEvents = List.of(DemoBackendSeed.futureEvents);
  final Set<String> _eventsInPersonalHistory = {};

  List<ComplementaryHoursRecord> _records =
      DemoBackendSeed.buildComplementaryHoursRecords();
  List<AppNotification> _notifications = DemoBackendSeed.buildNotifications();

  EventsCatalog get eventsCatalog => EventsCatalog(
        featuredEvents: List.unmodifiable(
          _featuredEvents.map((event) => event.preview),
        ),
        futureEvents: List.unmodifiable(
          _futureEvents.map((event) => event.preview),
        ),
      );

  EventDetails? eventDetails(String uid, String eventId) {
    _ensureDemoUser(uid);
    final event = _findEvent(eventId);
    if (event == null) return null;

    return EventDetails(
      event: event.preview,
      addedToPersonalHistory: _eventsInPersonalHistory.contains(eventId),
      complementaryMinutes: event.complementaryMinutes,
    );
  }

  bool setEventPersonalRecord({
    required String uid,
    required String eventId,
    required bool addedToPersonalHistory,
  }) {
    _ensureDemoUser(uid);
    final event = _findEvent(eventId);
    if (event == null) return false;

    if (addedToPersonalHistory) {
      _eventsInPersonalHistory.add(eventId);
      _upsertPersonalRecord(event);
    } else {
      _eventsInPersonalHistory.remove(eventId);
      _records = [
        for (final record in _records)
          if (record.id != eventId) record,
      ];
    }

    return true;
  }

  ComplementaryHoursSummary complementaryHoursSummary(String uid) {
    _ensureDemoUser(uid);
    final completedMinutes = _records.fold<int>(
      0,
      (total, record) => total + (record.durationMinutes ?? 0),
    );

    return ComplementaryHoursSummary(
      completedMinutes: completedMinutes,
      targetMinutes: DemoBackendSeed.targetComplementaryMinutes,
      milestoneMinutes: DemoBackendSeed.complementaryHoursMilestoneMinutes,
    );
  }

  List<ComplementaryHoursRecord> complementaryHoursRecords(String uid) {
    _ensureDemoUser(uid);
    final records = List<ComplementaryHoursRecord>.of(_records)
      ..sort((a, b) => b.eventDate.compareTo(a.eventDate));
    return List.unmodifiable(records);
  }

  bool deleteComplementaryHoursRecord(String uid, String recordId) {
    _ensureDemoUser(uid);
    final exists = _records.any((record) => record.id == recordId);
    if (!exists) return false;

    _records = [
      for (final record in _records)
        if (record.id != recordId) record,
    ];
    _eventsInPersonalHistory.remove(recordId);
    return true;
  }

  List<AppNotification> notificationsFor(String uid) {
    _ensureDemoUser(uid);
    final notifications = List<AppNotification>.of(_notifications)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return List.unmodifiable(notifications);
  }

  bool markNotificationAsRead(String uid, String notificationId) {
    _ensureDemoUser(uid);
    final exists = _notifications.any((item) => item.id == notificationId);
    if (!exists) return false;

    _notifications = [
      for (final item in _notifications)
        item.id == notificationId ? item.copyWith(isRead: true) : item,
    ];
    return true;
  }

  void markAllNotificationsAsRead(String uid) {
    _ensureDemoUser(uid);
    _notifications = [
      for (final item in _notifications) item.copyWith(isRead: true),
    ];
  }

  Iterable<DemoEvent> get _allEvents sync* {
    yield* _featuredEvents;
    yield* _futureEvents;
  }

  DemoEvent? _findEvent(String eventId) {
    for (final event in _allEvents) {
      if (event.preview.id == eventId) return event;
    }
    return null;
  }

  void _upsertPersonalRecord(DemoEvent event) {
    _records = [
      ComplementaryHoursRecord(
        id: event.preview.id,
        eventName: event.preview.title,
        eventDate: event.preview.startsAt,
        durationMinutes: event.complementaryMinutes,
      ),
      for (final record in _records)
        if (record.id != event.preview.id) record,
    ];
  }

  void _ensureDemoUser(String uid) {
    if (uid != currentUser.uid) {
      throw StateError('Usuário demo inválido: $uid');
    }
  }
}
