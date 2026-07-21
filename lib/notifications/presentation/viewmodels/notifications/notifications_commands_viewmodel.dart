import 'dart:async';

import 'package:autth_injustice_app/notifications/domain/models/app_notification.dart';
import 'package:autth_injustice_app/notifications/presentation/commands/notifications_commands.dart';

import 'notifications_state_viewmodel.dart';

class NotificationsCommands {
  final NotificationsState state;
  final LoadNotificationsCommand _loadNotificationsCommand;
  final MarkNotificationAsReadCommand _markNotificationAsReadCommand;
  final MarkAllNotificationsAsReadCommand _markAllNotificationsAsReadCommand;

  NotificationsCommands({
    required this.state,
    required LoadNotificationsCommand loadNotificationsCommand,
    required MarkNotificationAsReadCommand markNotificationAsReadCommand,
    required MarkAllNotificationsAsReadCommand
        markAllNotificationsAsReadCommand,
  })  : _loadNotificationsCommand = loadNotificationsCommand,
        _markNotificationAsReadCommand = markNotificationAsReadCommand,
        _markAllNotificationsAsReadCommand = markAllNotificationsAsReadCommand;

  Future<void> loadNotifications({bool forceRefresh = false}) async {
    if (state.loading.value || (!forceRefresh && state.hasNotifications)) {
      return;
    }

    state.setLoading(true);
    state.clearError();

    try {
      final result = await _loadNotificationsCommand.executeWith(());
      result.fold(
        onSuccess: state.setNotifications,
        onFailure: (failure) => state.showError(failure.msg),
      );
    } finally {
      state.setLoading(false);
    }
  }

  void selectFilter(AppNotificationType? type) {
    state.selectType(type);
  }

  Future<void> markAsRead(String notificationId) async {
    final notification = state.notificationById(notificationId);
    if (notification == null || notification.isRead) return;
    if (!state.startMarkingAsRead(notificationId)) return;

    try {
      final result = await _markNotificationAsReadCommand
          .executeWith((notificationId: notificationId,));
      result.fold(
        onSuccess: (_) => state.markAsReadLocally(notificationId),
        onFailure: (failure) => state.showError(failure.msg),
      );
    } finally {
      state.finishMarkingAsRead(notificationId);
    }
  }

  void toggleExpanded(String notificationId) {
    if (state.toggleExpanded(notificationId)) {
      unawaited(markAsRead(notificationId));
    }
  }

  Future<void> markAllAsRead() async {
    if (state.loading.value || state.unreadCount == 0) return;

    state.setLoading(true);
    state.clearError();

    try {
      final result = await _markAllNotificationsAsReadCommand.executeWith(());
      result.fold(
        onSuccess: (_) => state.markAllAsReadLocally(),
        onFailure: (failure) => state.showError(failure.msg),
      );
    } finally {
      state.setLoading(false);
    }
  }
}
