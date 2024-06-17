
import '../../../../common/di/di.dart';
import '../../../entity/summary_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// GHealth Summary 나의 건강기록 유스케이스
class SummaryCase implements BaseUseCase<void, String?> {
  final GHealthRepository _gHealthRepository;

  SummaryCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<SummaryDTO?> execute(String? dateTime) {
    return _gHealthRepository.getSummary(dateTime);
  }
}