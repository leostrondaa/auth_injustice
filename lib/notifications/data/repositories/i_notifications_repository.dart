import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';

abstract interface class INotificationsRepository {
  Future<NotificationsResult> getNotifications();

  Future<NotificationActionResult> markAsRead(String notificationId);

  Future<NotificationActionResult> markAllAsRead();
}
