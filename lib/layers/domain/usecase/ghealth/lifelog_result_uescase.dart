

import '../../../../common/di/di.dart';

import '../../../entity/lifelog_result_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// 라이프로글 건강관리소 신체검사 결과 조회 유스케이스
class LifeLogResultUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final GHealthRepository _gHealthRepository;

  LifeLogResultUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<LifeLogResultDTO?> execute(Map<String, dynamic> toMap) {
    return _gHealthRepository.getLifeLogResult(toMap);
  }
}