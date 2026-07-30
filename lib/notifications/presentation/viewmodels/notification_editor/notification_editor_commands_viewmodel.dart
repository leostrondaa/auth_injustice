import 'package:autth_injustice_app/notifications/presentation/commands/notifications_commands.dart';

import 'notification_editor_state_viewmodel.dart';

class NotificationEditorCommands {
  final NotificationEditorState state;
  final PublishAnnouncementCommand _publishAnnouncementCommand;

  NotificationEditorCommands({
    required this.state,
    required PublishAnnouncementCommand publishAnnouncementCommand,
  }) : _publishAnnouncementCommand = publishAnnouncementCommand;

  Future<bool> publishAnnouncement() async {
    if (state.loading.value) return false;

    state.setLoading(true);
    state.clearError();

    try {
      final result = await _publishAnnouncementCommand.executeWith(
        (draft: state.draft.value),
      );

      return result.fold(
        onSuccess: (notification) {
          state.setPublishedNotification(notification);
          return true;
        },
        onFailure: (failure) {
          state.showError(failure.msg);
          return false;
        },
      );
    } finally {
      state.setLoading(false);
    }
  }
}
