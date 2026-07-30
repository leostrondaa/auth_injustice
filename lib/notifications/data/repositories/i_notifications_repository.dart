import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_input.dart';

abstract interface class INotificationsRepository {
  Future<NotificationsResult> getNotifications();

  Future<NotificationActionResult> markAsRead(String notificationId);

  Future<NotificationActionResult> markAllAsRead();

  Future<NotificationPublishResult> publishAnnouncement(
    NotificationAnnouncementInput input,
  );
}
