import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_summary.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ComplementaryHoursState {
  final loading = signal(false);
  final summary = signal<ComplementaryHoursSummary?>(null);
  final errorMessage = signal<String?>(null);

  bool get hasSummary => summary.value != null;

  void setLoading(bool value) {
    loading.value = value;
  }

  void setSummary(ComplementaryHoursSummary value) {
    summary.value = value;
  }

  void showError(String message) {
    errorMessage.value = message;
  }

  void clearError() {
    errorMessage.value = null;
  }
}
