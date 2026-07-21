import 'package:autth_injustice_app/complementary_hours/domain/complementary_hours_types.dart';
import 'package:autth_injustice_app/complementary_hours/domain/usecases/i_complementary_hours_usecases.dart';

import 'i_complementary_hours_use_case_facade.dart';

class ComplementaryHoursUseCaseFacadeImpl
    implements IComplementaryHoursUseCaseFacade {
  final IGetComplementaryHoursSummaryUseCase _getSummaryUseCase;
  final IGetComplementaryHoursRecordsUseCase _getRecordsUseCase;
  final IDeleteComplementaryHoursRecordUseCase _deleteRecordUseCase;

  ComplementaryHoursUseCaseFacadeImpl({
    required IGetComplementaryHoursSummaryUseCase
        getComplementaryHoursSummaryUseCase,
    required IGetComplementaryHoursRecordsUseCase
        getComplementaryHoursRecordsUseCase,
    required IDeleteComplementaryHoursRecordUseCase
        deleteComplementaryHoursRecordUseCase,
  })  : _getSummaryUseCase = getComplementaryHoursSummaryUseCase,
        _getRecordsUseCase = getComplementaryHoursRecordsUseCase,
        _deleteRecordUseCase = deleteComplementaryHoursRecordUseCase;

  @override
  Future<ComplementaryHoursSummaryResult> getSummary(
    ComplementaryHoursNoParams params,
  ) {
    return _getSummaryUseCase(params);
  }

  @override
  Future<ComplementaryHoursRecordsResult> getRecords(
    ComplementaryHoursNoParams params,
  ) {
    return _getRecordsUseCase(params);
  }

  @override
  Future<ComplementaryHoursRecordActionResult> deleteRecord(
    DeleteComplementaryHoursRecordParams params,
  ) {
    return _deleteRecordUseCase(params);
  }
}
