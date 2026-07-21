import 'package:autth_injustice_app/complementary_hours/domain/complementary_hours_types.dart';

/// Contrato de domínio para consultar e alterar o contador informal.
///
/// A camada de domínio não conhece Firebase, mocks ou a sessão atual. Esses
/// detalhes são resolvidos pela implementação localizada em `data`.
abstract interface class IComplementaryHoursRepository {
  Future<ComplementaryHoursSummaryResult> getSummary();
  Future<ComplementaryHoursRecordsResult> getRecords();
  Future<ComplementaryHoursRecordActionResult> deleteRecord(String recordId);
}
