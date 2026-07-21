import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_record.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ComplementaryHoursRecordsState {
  final loading = signal(false);
  final loaded = signal(false);
  final records = signal<List<ComplementaryHoursRecord>>(const []);
  final deletingIds = signal<Set<String>>(const {});
  final errorMessage = signal<String?>(null);

  bool get hasRecords => records.value.isNotEmpty;

  void setLoading(bool value) {
    loading.value = value;
  }

  void setRecords(List<ComplementaryHoursRecord> value) {
    records.value = List.unmodifiable(value);
    loaded.value = true;
  }

  bool startDeleting(String recordId) {
    if (deletingIds.value.isNotEmpty) return false;

    deletingIds.value = {recordId};
    return true;
  }

  void finishDeleting(String recordId) {
    deletingIds.value = {
      for (final id in deletingIds.value)
        if (id != recordId) id,
    };
  }

  void removeRecord(String recordId) {
    records.value = [
      for (final record in records.value)
        if (record.id != recordId) record,
    ];
  }

  void showError(String message) {
    errorMessage.value = message;
  }

  void clearError() {
    errorMessage.value = null;
  }
}
