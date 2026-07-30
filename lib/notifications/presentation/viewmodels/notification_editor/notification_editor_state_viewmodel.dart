import 'package:autth_injustice_app/notifications/domain/models/app_notification.dart';
import 'package:autth_injustice_app/notifications/domain/models/notification_announcement_draft.dart';
import 'package:signals_flutter/signals_flutter.dart';

class NotificationEditorState {
  final draft = signal(const NotificationAnnouncementDraft());
  final currentStep = signal(0);
  final loading = signal(false);
  final errorMessage = signal<String?>(null);
  final publishedNotification = signal<AppNotification?>(null);

  void reset() {
    draft.value = const NotificationAnnouncementDraft();
    currentStep.value = 0;
    loading.value = false;
    errorMessage.value = null;
    publishedNotification.value = null;
  }

  void updateDraft(NotificationAnnouncementDraft value) {
    draft.value = value;
    clearError();
  }

  void setCurrentStep(int value) {
    currentStep.value = value;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void showError(String message) {
    errorMessage.value = message;
  }

  void clearError() {
    errorMessage.value = null;
  }

  void setPublishedNotification(AppNotification value) {
    publishedNotification.value = value;
  }
}
