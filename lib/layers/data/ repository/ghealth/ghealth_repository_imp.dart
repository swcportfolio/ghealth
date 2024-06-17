
import 'dart:convert';

import 'package:ghealth_app/layers/entity/point_history_dto.dart';
import 'package:ghealth_app/layers/entity/product_dto.dart';
import 'package:ghealth_app/layers/entity/total_point_dto.dart';
import 'package:ghealth_app/layers/entity/wearable_dto.dart';

import '../../../../common/common.dart';
import '../../../../common/util/dio/dio_manager.dart';
import '../../../../main.dart';
import '../../../domain/repository/ghealth_repository.dart';
import '../../../entity/ai_health_dto.dart';
import '../../../entity/blood_history_dto.dart';
import '../../../entity/drug_info_dto.dart';
import '../../../entity/lifelog_result_dto.dart';
import '../../../entity/medication_dto.dart';
import '../../../entity/physical_history_dto.dart';
import '../../../entity/reservation_dto.dart';
import '../../../entity/summary_dto.dart';
import '../../../entity/visit_date_dto.dart';

class GHealthRepositoryImp implements GHealthRepository {

  /// 나의 건강검진 정보 조회(마이데이터)
  @override
  Future<SummaryDTO?> getSummary(String? dateTime) async {
    try {
      final response = await DioManager()
          .privateDio
          .get(summaryApiUrl, queryParameters: {'issuedDate': dateTime});

      logger.d(response.data);
      if (response.statusCode == 200) {
        final summaryDTO = SummaryDTO.fromJson(response.data);
        return summaryDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 투약정보 조회
  @override
  Future<MedicationDTO?> getMedication(int page) async {
    try {
      final response = await DioManager()
          .privateDio
          .get(medicationInfoApiUrl, queryParameters: {'page': page});

      logger.d(response.data);
      if (response.statusCode == 200) {
        final medicationDTO = MedicationDTO.fromJson(response.data);
        return medicationDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 처방 약 상세정보 조회
  @override
  Future<DrugInfoDTO?> getDrugInfo(String medicationCode) async {
    try {
      final response = await DioManager()
          .privateDio
          .get(drugInfoApiUrl, queryParameters: {'medicationCode': medicationCode});

      logger.d(response.data);
      if (response.statusCode == 200) {
        final drugInfoDTO = DrugInfoDTO.fromJson(response.data);
        return drugInfoDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 혈액검사 과거 이력 조회
  @override
  Future<BloodHistoryDTO?> getBloodHistory(String type) async {
    try {
      final response = await DioManager()
          .privateDio
          .get(bloodHistoryApiUrl, queryParameters: {'dataType': type});

      logger.d(response.data);
      if (response.statusCode == 200) {
        final bloodHistoryDTO = BloodHistoryDTO.fromJson(response.data);
        return bloodHistoryDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PhysicalHistoryDTO?> getPhysicalHistory(String type) async {
    try {
      final response = await DioManager()
          .privateDio
          .get(physicalHistoryApiUrl, queryParameters: {'dataType': type});

      logger.d(response.data);
      if (response.statusCode == 200) {
        final physicalHistoryDTO = PhysicalHistoryDTO.fromJson(response.data);
        return physicalHistoryDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 라이프로그 건강관리소 방문 날자 조회
  @override
  Future<VisitDateDTO?> getVisitDate() async {
    try {
      final response = await DioManager()
          .privateDio
          .get(getVisitDateApiUrl);

      logger.d(response.data);
      if (response.statusCode == 200) {
        final visitDateDTO = VisitDateDTO.fromJson(response.data);
        return visitDateDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 라이프로그 건강관리소 신체 검사 결과 조회
  @override
  Future<LifeLogResultDTO?> getLifeLogResult(Map<String, dynamic> toMap) async {
    try {
      final response = await DioManager()
          .privateDio
          .get(lifeLogReulstApiUrl, queryParameters: toMap);

      logger.d(response.data);
      if (response.statusCode == 200) {
        final lifeLogResultDTO = LifeLogResultDTO.fromJson(response.data);
        return lifeLogResultDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 예약 내역 리스트 조회
  @override
  Future<ReservationHistoryDTO?> getReservationHistory(int page) async {
    try {
      final response = await DioManager()
          .privateDio
          .get(reservationHistoryApiUrl,
          queryParameters: {'page': page, 'serviceType': 'lifelog'});

      logger.d(response.data);
      if (response.statusCode == 200) {
        final reservationHistoryDTO = ReservationHistoryDTO.fromJson(response.data);
        return reservationHistoryDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 예약 휴일 조회
  @override
  Future<ReservationDayOffDTO?> getReservationDayOff(Map<String, dynamic> toMap) async {
    try {
      final response = await DioManager()
          .privateDio
          .get(reservationDayOffApiUrl, queryParameters: toMap);

      logger.d(response.data);
      if (response.statusCode == 200) {
        final reservationDayOffDTO = ReservationDayOffDTO.fromJson(response.data);
        return reservationDayOffDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 최근 얘약 내역 조회
  @override
  Future<ReservationRecentDTO?> getReservationRecent() async {
      try {
        final response = await DioManager()
            .privateDio
            .get(reservationRecentApiUrl,
            queryParameters: {'serviceType': 'lifelog'});

        logger.d(response.data);
        if (response.statusCode == 200) {
          final reservationRecentDTO = ReservationRecentDTO.fromJson(response.data);
          return reservationRecentDTO;
        } else {
          return null;
        }
      } catch (error) {
        rethrow;
      }
    }

  /// 예약가능한 시간 조회
  @override
  Future<ReservationPossibleDTO?> getReservationPossible(Map<String, dynamic> toMap) async {
    try {
      final response = await DioManager()
          .privateDio
          .get(reservationPossibleApiUrl,
          queryParameters: toMap);

      logger.d(response.data);
      if (response.statusCode == 200) {
        final reservationPossibleDTO = ReservationPossibleDTO.fromJson(response.data);
        return reservationPossibleDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }


  /// 예약 저장
  @override
  Future<ReservationStatueDTO?> getReservationSave(Map<String, dynamic> toMap) async {
    try {
      final response = await DioManager()
          .privateDio
          .post(reservationSaveApiUrl, data: toMap);

      logger.d(response.data);
      if (response.statusCode == 200) {
        final reservationStatueDTO = ReservationStatueDTO.fromJson(response.data);
        return reservationStatueDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }


  /// 예약 취소
  @override
  Future<ReservationStatueDTO?> getReservationCancel(Map<String, dynamic> toMap) async {
    try {
      final response = await DioManager()
          .privateDio
          .delete(reservationCancelApiUrl, data: toMap);

      logger.d(response.data);
      if (response.statusCode == 200) {
        final reservationStatueDTO = ReservationStatueDTO.fromJson(response.data);
        return reservationStatueDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// AI 건강예측 데이터 조회
  @override
  Future<AiHealthDTO?> getAiHealth() async {
    try {
      final response = await DioManager()
          .privateDio
          .get(getAiHealthApiUrl);

      logger.d(response.data);
      if (response.statusCode == 200) {
        final aiHealthDTO = AiHealthDTO.fromJson(response.data);
        return aiHealthDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 웨어러블 데이터 저장
  @override
  Future<WearableDTO?> saveWearable(String type, Map<String, dynamic> data) async {
    try {
      final response = await DioManager()
          .privateDio
          .post('$saveHealthApiUrl$type', data: data);
      logger.d(response.data);
      if (response.statusCode == 200) {
        return WearableDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 포인트 적립/사용 내역 조회
  @override
  Future<PointHistoryDTO?> getPointHistory(Map<String, dynamic> toMap) async {
    try {
      final response = await DioManager()
          .privateDio
          .get(getPointHistoryApiUrl, queryParameters: toMap);
      logger.d(response.data);
      if (response.statusCode == 200) {
        return PointHistoryDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 상품 조회
  @override
  Future<ProductDTO?> getProduct() async {
    try {
      final response = await DioManager()
          .privateDio
          .get(getProductApiUrl, queryParameters: {'userID': 'U00000'});
      logger.d(response.data);
      if (response.statusCode == 200) {
        return ProductDTO.fromJson(jsonDecode(response.data));
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 총 포인트 조회
  @override
  Future<TotalPointDTO?> getTotalPoint() async {
    try {
      final response = await DioManager()
          .privateDio
          .get(getTotalPointApiUrl);
      logger.d(response.data);
      if (response.statusCode == 200) {
        return TotalPointDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }
}