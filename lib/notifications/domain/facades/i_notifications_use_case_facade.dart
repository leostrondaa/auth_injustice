import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';

abstract interface class INotificationsUseCaseFacade {
  Future<NotificationsResult> getNotifications(NotificationsNoParams params);

  Future<NotificationActionResult> markAsRead(NotificationIdParams params);

  Future<NotificationActionResult> markAllAsRead(NotificationsNoParams params);
}
