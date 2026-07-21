import 'package:autth_injustice_app/complementary_hours/domain/complementary_hours_types.dart';

/// Fonte dos dados do contador informal e do histórico pessoal de uma conta.
///
/// Uma implementação Firestore pode usar a coleção
/// `/accounts/{uid}/personalActivityRecords`. O repositório é responsável
/// por resolver o [uid] da sessão; o serviço recebe sempre um usuário válido.
abstract interface class IComplementaryHoursService {
  Future<ComplementaryHoursSummaryResult> getSummary(String uid);

  /// Retorna os registros pessoais em ordem decrescente de data. A carga
  /// horária pode ser nula quando o evento não informa horas complementares.
  Future<ComplementaryHoursRecordsResult> getRecords(String uid);

  /// Remove apenas o registro informal pertencente à conta informada.
  Future<ComplementaryHoursRecordActionResult> deleteRecord(
    String uid,
    String recordId,
  );
}
