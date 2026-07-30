import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';
import 'package:autth_injustice_app/notifications/domain/usecases/i_notifications_usecases.dart';

import 'i_notifications_use_case_facade.dart';

class NotificationsUseCaseFacadeImpl implements INotificationsUseCaseFacade {
  final IGetNotificationsUseCase _getNotificationsUseCase;
  final IMarkNotificationAsReadUseCase _markNotificationAsReadUseCase;
  final IMarkAllNotificationsAsReadUseCase _markAllNotificationsAsReadUseCase;
  final IPublishAnnouncementUseCase _publishAnnouncementUseCase;

  NotificationsUseCaseFacadeImpl({
    required IGetNotificationsUseCase getNotificationsUseCase,
    required IMarkNotificationAsReadUseCase markNotificationAsReadUseCase,
    required IMarkAllNotificationsAsReadUseCase
        markAllNotificationsAsReadUseCase,
    required IPublishAnnouncementUseCase publishAnnouncementUseCase,
  })  : _getNotificationsUseCase = getNotificationsUseCase,
        _markNotificationAsReadUseCase = markNotificationAsReadUseCase,
        _markAllNotificationsAsReadUseCase = markAllNotificationsAsReadUseCase,
        _publishAnnouncementUseCase = publishAnnouncementUseCase;

  @override
  Future<NotificationsResult> getNotifications(NotificationsNoParams params) {
    return _getNotificationsUseCase(params);
  }

  @override
  Future<NotificationActionResult> markAsRead(NotificationIdParams params) {
    return _markNotificationAsReadUseCase(params);
  }

  @override
  Future<NotificationActionResult> markAllAsRead(NotificationsNoParams params) {
    return _markAllNotificationsAsReadUseCase(params);
  }

  @override
  Future<NotificationPublishResult> publishAnnouncement(
    PublishAnnouncementParams params,
  ) {
    return _publishAnnouncementUseCase(params);
  }
}
