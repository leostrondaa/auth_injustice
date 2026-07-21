import 'package:autth_injustice_app/core/patterns/i_usecases.dart';
import 'package:autth_injustice_app/notifications/domain/notifications_types.dart';

abstract interface class IGetNotificationsUseCase
    implements IUseCase<NotificationsResult, NotificationsNoParams> {}

abstract interface class IMarkNotificationAsReadUseCase
    implements IUseCase<NotificationActionResult, NotificationIdParams> {}

abstract interface class IMarkAllNotificationsAsReadUseCase
    implements IUseCase<NotificationActionResult, NotificationsNoParams> {}
