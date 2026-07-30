import 'package:autth_injustice_app/complementary_hours/domain/complementary_hours_types.dart';
import 'package:autth_injustice_app/complementary_hours/domain/facades/i_complementary_hours_use_case_facade.dart';
import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_record.dart';
import 'package:autth_injustice_app/complementary_hours/domain/models/complementary_hours_summary.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/command.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';

final class LoadComplementaryHoursSummaryCommand extends ParameterizedCommand<
    ComplementaryHoursSummary, Failure, ComplementaryHoursNoParams> {
  final IComplementaryHoursUseCaseFacade _facade;

  LoadComplementaryHoursSummaryCommand(this._facade);

  @override
  Future<ComplementaryHoursSummaryResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('complementaryHoursLoadError')),
      );
    }

    return _facade.getSummary(parameter!);
  }
}

final class LoadComplementaryHoursRecordsCommand extends ParameterizedCommand<
    List<ComplementaryHoursRecord>, Failure, ComplementaryHoursNoParams> {
  final IComplementaryHoursUseCaseFacade _facade;

  LoadComplementaryHoursRecordsCommand(this._facade);

  @override
  Future<ComplementaryHoursRecordsResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('complementaryHoursRecordsLoadError')),
      );
    }

    return _facade.getRecords(parameter!);
  }
}

final class DeleteComplementaryHoursRecordCommand extends ParameterizedCommand<
    void, Failure, DeleteComplementaryHoursRecordParams> {
  final IComplementaryHoursUseCaseFacade _facade;

  DeleteComplementaryHoursRecordCommand(this._facade);

  @override
  Future<ComplementaryHoursRecordActionResult> execute() {
    if (parameter == null) {
      return Future.value(
        Error(InvalidInputFailure('complementaryHoursDeleteError')),
      );
    }

    return _facade.deleteRecord(parameter!);
  }
}
