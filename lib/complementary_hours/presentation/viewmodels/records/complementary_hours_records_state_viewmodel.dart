import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_record.dart';
import 'package:autth_injustice_app/core/patterns/async_load_state.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ComplementaryHoursRecordsState with AsyncLoadState {
  final records = signal<List<ComplementaryHoursRecord>>(const []);
  final deletingIds = signal<Set<String>>(const {});

  bool get hasRecords => records.value.isNotEmpty;

  void setRecords(List<ComplementaryHoursRecord> value) {
    records.value = List.unmodifiable(value);
    markLoaded();
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
}
