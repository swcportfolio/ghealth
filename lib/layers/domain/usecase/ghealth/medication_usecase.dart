
import '../../../../common/di/di.dart';
import '../../../entity/drug_info_dto.dart';
import '../../../entity/medication_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// 처방 약 정보 유스케이스
class MedicationUseCase implements BaseUseCase<void, int> {
  final GHealthRepository _gHealthRepository;

  MedicationUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<MedicationDTO?> execute(int page) {
    return _gHealthRepository.getMedication(page);
  }
}

/// 의료 약 상세 정보 유스케이스
class DrugInfoUseCase implements BaseUseCase<void, String> {
  final GHealthRepository _gHealthRepository;

  DrugInfoUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<DrugInfoDTO?> execute(String medicationCode) {
    return _gHealthRepository.getDrugInfo(medicationCode);
  }
}