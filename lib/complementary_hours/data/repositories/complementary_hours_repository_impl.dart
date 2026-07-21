import 'package:autth_injustice_app/account/domain/services/i_current_account_provider.dart';
import 'package:autth_injustice_app/complementary_hours/data/services/i_complementary_hours_service.dart';
import 'package:autth_injustice_app/complementary_hours/domain/complementary_hours_types.dart';
import 'package:autth_injustice_app/complementary_hours/domain/repositories/i_complementary_hours_repository.dart';
import 'package:autth_injustice_app/core/failure/failure.dart';
import 'package:autth_injustice_app/core/patterns/result.dart';

class ComplementaryHoursRepositoryImpl
    implements IComplementaryHoursRepository {
  final IComplementaryHoursService _service;
  final ICurrentAccountProvider _currentAccountProvider;

  ComplementaryHoursRepositoryImpl({
    required IComplementaryHoursService complementaryHoursService,
    required ICurrentAccountProvider currentAccountProvider,
  })  : _service = complementaryHoursService,
        _currentAccountProvider = currentAccountProvider;

  String? get _currentUid => _currentAccountProvider.currentUid;

  UnauthenticatedFailure get _unauthenticatedFailure =>
      UnauthenticatedFailure();

  @override
  Future<ComplementaryHoursSummaryResult> getSummary() async {
    final uid = _currentUid;
    if (uid == null) return Error(_unauthenticatedFailure);

    return _service.getSummary(uid);
  }

  @override
  Future<ComplementaryHoursRecordsResult> getRecords() async {
    final uid = _currentUid;
    if (uid == null) return Error(_unauthenticatedFailure);

    return _service.getRecords(uid);
  }

  @override
  Future<ComplementaryHoursRecordActionResult> deleteRecord(
    String recordId,
  ) async {
    final uid = _currentUid;
    if (uid == null) return Error(_unauthenticatedFailure);

    return _service.deleteRecord(uid, recordId);
  }
}
