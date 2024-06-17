
import '../../../../common/di/di.dart';
import '../../../entity/point_history_dto.dart';
import '../../../entity/total_point_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// 포인트 이력 조회 유스케이스
class PointHistoryUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final GHealthRepository _gHealthRepository;

  PointHistoryUseCase([GHealthRepository? gHealthRepository])
      : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<PointHistoryDTO?> execute(Map<String, dynamic> toMap) {
    return _gHealthRepository.getPointHistory(toMap);
  }
}

/// 총 포인트 조회 유스케이스
class TotalPointUseCase implements NoParamUseCase<void, void> {
  final GHealthRepository _gHealthRepository;

  TotalPointUseCase([GHealthRepository? gHealthRepository])
      : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<TotalPointDTO?> execute() {
    return _gHealthRepository.getTotalPoint();
  }
}