import 'package:autth_injustice_app/complementary_hours/domain/complementary_hours_types.dart';
import 'package:autth_injustice_app/complementary_hours/data/repositories/i_complementary_hours_repository.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';

import 'i_complementary_hours_usecases.dart';

final class GetComplementaryHoursSummaryUseCase
    implements IGetComplementaryHoursSummaryUseCase {
  final IComplementaryHoursRepository _repository;

  GetComplementaryHoursSummaryUseCase({
    required IComplementaryHoursRepository complementaryHoursRepository,
  }) : _repository = complementaryHoursRepository;

  @override
  Future<ComplementaryHoursSummaryResult> call(
    ComplementaryHoursNoParams params,
  ) {
    return _repository.getSummary();
  }
}

final class GetComplementaryHoursRecordsUseCase
    implements IGetComplementaryHoursRecordsUseCase {
  final IComplementaryHoursRepository _repository;

  GetComplementaryHoursRecordsUseCase({
    required IComplementaryHoursRepository complementaryHoursRepository,
  }) : _repository = complementaryHoursRepository;

  @override
  Future<ComplementaryHoursRecordsResult> call(
    ComplementaryHoursNoParams params,
  ) {
    return _repository.getRecords();
  }
}

final class DeleteComplementaryHoursRecordUseCase
    implements IDeleteComplementaryHoursRecordUseCase {
  final IComplementaryHoursRepository _repository;

  DeleteComplementaryHoursRecordUseCase({
    required IComplementaryHoursRepository complementaryHoursRepository,
  }) : _repository = complementaryHoursRepository;

  @override
  Future<ComplementaryHoursRecordActionResult> call(
    DeleteComplementaryHoursRecordParams params,
  ) {
    if (params.recordId.trim().isEmpty) {
      return Future.value(
        Error(InvalidInputFailure('complementaryHoursDeleteError')),
      );
    }

    return _repository.deleteRecord(params.recordId);
  }
}
