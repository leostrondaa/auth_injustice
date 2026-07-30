import 'package:autth_injustice_app/complementary_hours/domain/complementary_hours_types.dart';

/// Data contract for the informal counter and personal records.
abstract interface class IComplementaryHoursRepository {
  Future<ComplementaryHoursSummaryResult> getSummary();
  Future<ComplementaryHoursRecordsResult> getRecords();
  Future<ComplementaryHoursRecordActionResult> deleteRecord(String recordId);
}
