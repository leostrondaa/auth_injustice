import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/dev/demo_backend/demo_backend_store.dart';
import 'package:autth_injustice_app/notifications/data/services/i_notifications_service.dart';
import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_input.dart';

class DemoNotificationsService implements INotificationsService {
  final DemoBackendStore _store;

  DemoNotificationsService({required DemoBackendStore demoBackendStore})
      : _store = demoBackendStore;

  @override
  Future<NotificationsResult> getNotifications(String uid) async {
    return Success(_store.notificationsFor(uid));
  }

  @override
  Future<NotificationActionResult> markAsRead(
    String uid,
    String notificationId,
  ) async {
    if (!_store.markNotificationAsRead(uid, notificationId)) {
      return Error(NotFoundFailure('notificationNotFound'));
    }

    return const Success(null);
  }

  @override
  Future<NotificationActionResult> markAllAsRead(String uid) async {
    _store.markAllNotificationsAsRead(uid);
    return const Success(null);
  }

  @override
  Future<NotificationPublishResult> publishAnnouncement({
    required String actorUid,
    required NotificationAnnouncementInput input,
  }) async {
    return Success(_store.publishAnnouncement(actorUid, input));
  }
}
