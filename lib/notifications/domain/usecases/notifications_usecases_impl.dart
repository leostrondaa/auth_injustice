import 'package:autth_injustice_app/authorization/domain/services/authorization_service.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/notifications/data/repositories/i_notifications_repository.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_validator.dart';
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

final class PublishAnnouncementUseCase implements IPublishAnnouncementUseCase {
  final INotificationsRepository _notificationsRepository;
  final AuthorizationService _authorizationService;

  PublishAnnouncementUseCase({
    required INotificationsRepository notificationsRepository,
    required AuthorizationService authorizationService,
  })  : _notificationsRepository = notificationsRepository,
        _authorizationService = authorizationService;

  @override
  Future<NotificationPublishResult> call(PublishAnnouncementParams params) {
    if (!_authorizationService.canPublishAnnouncements) {
      return Future.value(
        Error(ForbiddenFailure('notificationManagementUnauthorized')),
      );
    }

    final issue = NotificationAnnouncementValidator.validateForPublishing(
      params.draft,
    );
    if (issue != null) {
      return Future.value(
        Error(InvalidInputFailure(issue.messageKey)),
      );
    }

    return _notificationsRepository.publishAnnouncement(
      params.draft.toInput(),
    );
  }
}
