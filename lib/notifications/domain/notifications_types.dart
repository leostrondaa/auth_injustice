import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/notifications/domain/models/app_notification.dart';

typedef NotificationsResult = Result<List<AppNotification>, Failure>;
typedef NotificationActionResult = Result<void, Failure>;

typedef NotificationsNoParams = ();
typedef NotificationIdParams = ({String notificationId});
