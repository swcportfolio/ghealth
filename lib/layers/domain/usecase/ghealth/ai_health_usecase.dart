
import '../../../../common/di/di.dart';
import '../../../entity/ai_health_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// AI 건강예측 조회 유스케이스
class AiHealthUseCase implements NoParamUseCase<void, void> {
  final GHealthRepository _gHealthRepository;

  AiHealthUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<AiHealthDTO?> execute() {
    return _gHealthRepository.getAiHealth();
  }
}