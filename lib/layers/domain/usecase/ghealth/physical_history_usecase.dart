

import '../../../../common/di/di.dart';
import '../../../entity/physical_history_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// 계측검사 이력 조회 유스케이스
class PhysicalHistoryCase implements BaseUseCase<void, String> {
  final GHealthRepository _gHealthRepository;

  PhysicalHistoryCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<PhysicalHistoryDTO?> execute(String type) {
    return _gHealthRepository.getPhysicalHistory(type);
  }
}