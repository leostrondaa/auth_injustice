import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_summary.dart';
import 'package:autth_injustice_app/core/patterns/async_load_state.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ComplementaryHoursState with AsyncLoadState {
  final summary = signal<ComplementaryHoursSummary?>(null);

  bool get hasSummary => summary.value != null;

  void setSummary(ComplementaryHoursSummary value) {
    summary.value = value;
    markLoaded();
  }
}
