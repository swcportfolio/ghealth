

import '../../../../common/di/di.dart';
import '../../../entity/reservation_dto.dart';
import '../../repository/ghealth_repository.dart';
import '../base_usecase.dart';

/// 최근 예약 이력 조회 유스케이스
class ReservationRecentUseCase implements NoParamUseCase<void, void> {
  final GHealthRepository _gHealthRepository;

  ReservationRecentUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<ReservationRecentDTO?> execute() {
    return _gHealthRepository.getReservationRecent();
  }
}


/// 예약 휴일 죄회 유스케이스
class ReservationDayOffUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final GHealthRepository _gHealthRepository;

  ReservationDayOffUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<ReservationDayOffDTO?> execute(Map<String, dynamic> toMap) {
    return _gHealthRepository.getReservationDayOff(toMap);
  }
}


/// 예약 휴일 조회 유스케이스
class ReservationPossibleUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final GHealthRepository _gHealthRepository;

  ReservationPossibleUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<ReservationPossibleDTO?> execute(Map<String, dynamic> toMap) {
    return _gHealthRepository.getReservationPossible(toMap);
  }
}


/// 예약 이력 조회 유스케이스
class ReservationHistoryUseCase implements BaseUseCase<void, int> {
  final GHealthRepository _gHealthRepository;

  ReservationHistoryUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<ReservationHistoryDTO?> execute(int page) {
    return _gHealthRepository.getReservationHistory(page);
  }
}


/// 예약 저장 유스케이스
class ReservationSaveUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final GHealthRepository _gHealthRepository;

  ReservationSaveUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<ReservationStatueDTO?> execute(Map<String, dynamic> toMap) {
    return _gHealthRepository.getReservationSave(toMap);
  }
}


/// 예약 취소 유스케이스
class ReservationCancelUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final GHealthRepository _gHealthRepository;

  ReservationCancelUseCase([GHealthRepository? gHealthRepository]) : _gHealthRepository = gHealthRepository ?? locator();

  @override
  Future<ReservationStatueDTO?> execute(Map<String, dynamic> toMap) {
    return _gHealthRepository.getReservationCancel(toMap);
  }
}