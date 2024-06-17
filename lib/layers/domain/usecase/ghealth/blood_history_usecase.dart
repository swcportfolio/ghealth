

import '../../../../common/di/di.dart';
import '../../../entity/blood_history_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// 혈액검사 이력 유스케이스
class BloodHistoryCase implements BaseUseCase<void, String> {
  final GHealthRepository _gHealthRepository;

  BloodHistoryCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<BloodHistoryDTO?> execute(String type) {
    return _gHealthRepository.getBloodHistory(type);
  }
}