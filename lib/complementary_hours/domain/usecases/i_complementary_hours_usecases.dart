import 'package:autth_injustice_app/complementary_hours/domain/complementary_hours_types.dart';
import 'package:autth_injustice_app/core/patterns/i_usecases.dart';

abstract interface class IGetComplementaryHoursSummaryUseCase
    implements
        IUseCase<ComplementaryHoursSummaryResult, ComplementaryHoursNoParams> {}

abstract interface class IGetComplementaryHoursRecordsUseCase
    implements
        IUseCase<ComplementaryHoursRecordsResult, ComplementaryHoursNoParams> {}

abstract interface class IDeleteComplementaryHoursRecordUseCase
    implements
        IUseCase<ComplementaryHoursRecordActionResult,
            DeleteComplementaryHoursRecordParams> {}
