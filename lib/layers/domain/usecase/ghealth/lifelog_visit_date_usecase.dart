

import '../../../../common/di/di.dart';
import '../../../entity/blood_history_dto.dart';
import '../../../entity/visit_date_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// 혈액검사 이력 유스케이스
class LifeLogVisitDateUseCase implements NoParamUseCase<void, void> {
  final GHealthRepository _gHealthRepository;

  LifeLogVisitDateUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<VisitDateDTO?> execute() {
    return _gHealthRepository.getVisitDate();
  }
}