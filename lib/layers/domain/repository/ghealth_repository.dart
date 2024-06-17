
import '../../entity/ai_health_dto.dart';
import '../../entity/blood_history_dto.dart';
import '../../entity/drug_info_dto.dart';
import '../../entity/lifelog_result_dto.dart';
import '../../entity/medication_dto.dart';
import '../../entity/physical_history_dto.dart';
import '../../entity/point_history_dto.dart';
import '../../entity/product_dto.dart';
import '../../entity/reservation_dto.dart';
import '../../entity/summary_dto.dart';
import '../../entity/total_point_dto.dart';
import '../../entity/visit_date_dto.dart';
import '../../entity/wearable_dto.dart';

abstract class GHealthRepository {
  Future<SummaryDTO?> getSummary(String? dateTime);
  Future<MedicationDTO?> getMedication(int page);
  Future<DrugInfoDTO?> getDrugInfo(String medicationCode);
  Future<BloodHistoryDTO?> getBloodHistory(String type);
  Future<PhysicalHistoryDTO?> getPhysicalHistory(String type);
  Future<VisitDateDTO?> getVisitDate();
  Future<LifeLogResultDTO?> getLifeLogResult(Map<String, dynamic> toMap);
  Future<ReservationHistoryDTO?> getReservationHistory(int page);
  Future<ReservationRecentDTO?> getReservationRecent();
  Future<ReservationDayOffDTO?> getReservationDayOff(Map<String, dynamic> toMap);
  Future<ReservationPossibleDTO?> getReservationPossible(Map<String, dynamic> toMap);
  Future<ReservationStatueDTO?> getReservationSave(Map<String, dynamic> toMap);
  Future<ReservationStatueDTO?> getReservationCancel(Map<String, dynamic> toMap);
  Future<AiHealthDTO?> getAiHealth();
  Future<WearableDTO?> saveWearable(String type, Map<String, dynamic> data);
  Future<PointHistoryDTO?> getPointHistory(Map<String, dynamic> data);
  Future<ProductDTO?> getProduct();
  Future<TotalPointDTO?> getTotalPoint();
}