import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_record.dart';
import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_summary.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';

typedef ComplementaryHoursSummaryResult
    = Result<ComplementaryHoursSummary, Failure>;

typedef ComplementaryHoursRecordsResult
    = Result<List<ComplementaryHoursRecord>, Failure>;

typedef ComplementaryHoursRecordActionResult = Result<void, Failure>;

typedef ComplementaryHoursNoParams = ();
typedef DeleteComplementaryHoursRecordParams = ({String recordId});
