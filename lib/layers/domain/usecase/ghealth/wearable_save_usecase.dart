import '../../../../common/di/di.dart';
import '../../../entity/wearable_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// 웨어러블데이터 저장 유스케이스
class WearableSaveUseCase implements MultipleUseCase<void, String, Map<String, dynamic>> {
  final GHealthRepository _gHealthRepository;

  WearableSaveUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<WearableDTO?> execute(String type, Map<String, dynamic> data) {
    return _gHealthRepository.saveWearable(type, data);
  }
}