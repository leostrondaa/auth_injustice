import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/notifications/data/services/i_notifications_service.dart';
import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';

import 'i_notifications_repository.dart';

class NotificationsRepositoryImpl implements INotificationsRepository {
  final INotificationsService _notificationsService;
  final ICurrentAccountProvider _currentAccountProvider;

  NotificationsRepositoryImpl({
    required INotificationsService notificationsService,
    required ICurrentAccountProvider currentAccountProvider,
  })  : _notificationsService = notificationsService,
        _currentAccountProvider = currentAccountProvider;

  String? get _currentUid => _currentAccountProvider.currentUid;

  @override
  Future<NotificationsResult> getNotifications() {
    final uid = _currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _notificationsService.getNotifications(uid);
  }

  @override
  Future<NotificationActionResult> markAsRead(String notificationId) {
    final uid = _currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _notificationsService.markAsRead(uid, notificationId);
  }

  @override
  Future<NotificationActionResult> markAllAsRead() {
    final uid = _currentUid;
    if (uid == null) return Future.value(Error(UnauthenticatedFailure()));

    return _notificationsService.markAllAsRead(uid);
  }
}
