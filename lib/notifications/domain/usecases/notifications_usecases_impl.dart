import 'package:autth_injustice_app/notifications/data/repositories/i_notifications_repository.dart';
import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';

import 'i_notifications_usecases.dart';

final class GetNotificationsUseCase implements IGetNotificationsUseCase {
  final INotificationsRepository _notificationsRepository;

  GetNotificationsUseCase({
    required INotificationsRepository notificationsRepository,
  }) : _notificationsRepository = notificationsRepository;

  @override
  Future<NotificationsResult> call(NotificationsNoParams params) {
    return _notificationsRepository.getNotifications();
  }
}

final class MarkNotificationAsReadUseCase
    implements IMarkNotificationAsReadUseCase {
  final INotificationsRepository _notificationsRepository;

  MarkNotificationAsReadUseCase({
    required INotificationsRepository notificationsRepository,
  }) : _notificationsRepository = notificationsRepository;

  @override
  Future<NotificationActionResult> call(NotificationIdParams params) {
    return _notificationsRepository.markAsRead(params.notificationId);
  }
}

final class MarkAllNotificationsAsReadUseCase
    implements IMarkAllNotificationsAsReadUseCase {
  final INotificationsRepository _notificationsRepository;

  MarkAllNotificationsAsReadUseCase({
    required INotificationsRepository notificationsRepository,
  }) : _notificationsRepository = notificationsRepository;

  @override
  Future<NotificationActionResult> call(NotificationsNoParams params) {
    return _notificationsRepository.markAllAsRead();
  }
}
