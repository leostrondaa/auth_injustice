import 'package:autth_injustice_app/complementary_hours/data/services/i_complementary_hours_service.dart';
import 'package:autth_injustice_app/complementary_hours/domain/complementary_hours_types.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';
import 'package:autth_injustice_app/dev/demo_backend/demo_backend_store.dart';

class DemoComplementaryHoursService implements IComplementaryHoursService {
  final DemoBackendStore _store;

  DemoComplementaryHoursService({required DemoBackendStore demoBackendStore})
      : _store = demoBackendStore;

  @override
  Future<ComplementaryHoursSummaryResult> getSummary(String uid) async {
    try {
      return Success(_store.complementaryHoursSummary(uid));
    } on StateError catch (error) {
      return Error(DefaultFailure(error.message.toString()));
    }
  }

  @override
  Future<ComplementaryHoursRecordsResult> getRecords(String uid) async {
    try {
      return Success(_store.complementaryHoursRecords(uid));
    } on StateError catch (error) {
      return Error(DefaultFailure(error.message.toString()));
    }
  }

  @override
  Future<ComplementaryHoursRecordActionResult> deleteRecord(
    String uid,
    String recordId,
  ) async {
    try {
      if (!_store.deleteComplementaryHoursRecord(uid, recordId)) {
        return Error(DefaultFailure('Registro não encontrado.'));
      }
      return const Success(null);
    } on StateError catch (error) {
      return Error(DefaultFailure(error.message.toString()));
    }
  }
}
