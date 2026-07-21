import 'package:autth_injustice_app/complementary_hours/domain/complementary_hours_types.dart';

abstract interface class IComplementaryHoursUseCaseFacade {
  Future<ComplementaryHoursSummaryResult> getSummary(
    ComplementaryHoursNoParams params,
  );

  Future<ComplementaryHoursRecordsResult> getRecords(
    ComplementaryHoursNoParams params,
  );

  Future<ComplementaryHoursRecordActionResult> deleteRecord(
    DeleteComplementaryHoursRecordParams params,
  );
}
