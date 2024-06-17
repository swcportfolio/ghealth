import 'package:ghealth_app/layers/entity/status_dto.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/vm_reservation.dart';

import '../model/enum/region_type.dart';

/// 최근 예약
class ReservationRecentDTO {
  final StatusDTO status;
  final ReservationDataDTO data;

  ReservationRecentDTO({
    required this.status,
    required this.data,
  });

  factory ReservationRecentDTO.fromJson(Map<String, dynamic> json) {
    return ReservationRecentDTO(
      status: StatusDTO.fromJson(json['status']),
      data: ReservationDataDTO.fromJson(json['data']),
    );
  }
}

/// 예약 휴일
class ReservationDayOffDTO {
  final StatusDTO status;
  final List<String> data;

  ReservationDayOffDTO({required this.status, required this.data});

  factory ReservationDayOffDTO.fromJson(Map<String, dynamic> json) {
    return ReservationDayOffDTO(
      status: StatusDTO.fromJson(json['status']),
      data: List<String>.from(json['data']),
    );
  }
}


/// 예약 내역 리스트
class ReservationHistoryDTO {
  final StatusDTO status;
  final List<ReservationDataDTO> data;

  ReservationHistoryDTO({
    required this.status,
    required this.data,
  });

  factory ReservationHistoryDTO.fromJson(Map<String, dynamic> json) {
    return ReservationHistoryDTO(
      status: StatusDTO.fromJson(json['status']),
      data: ReservationDataDTO.jsonList(json['data']),
    );
  }
}


/// 예약 가능시간
class ReservationPossibleDTO {
  final StatusDTO status;
  List<ReservationTimeDataDTO> data;

  ReservationPossibleDTO({required this.status, required this.data});

  factory ReservationPossibleDTO.fromJson(Map<String, dynamic> json) {
    return ReservationPossibleDTO(
      status: StatusDTO.fromJson(json['status']),
      data: ReservationTimeDataDTO.jsonList(json['data']),
    );
  }
}

class ReservationStatueDTO {
  final StatusDTO status;
  final dynamic data; // null 반환됨

  ReservationStatueDTO({required this.status, this.data});

  factory ReservationStatueDTO.fromJson(Map<String, dynamic> json) {
    return ReservationStatueDTO(
      status: StatusDTO.fromJson(json['status']),
      data: json['data'],
    );
  }
}


class ReservationDataDTO {
  late String? reservationIdx; //예약 번호
  late String? reservationDate; //예약 날짜
  late String? reservationTime; //예약 시간
  late String? reservationStatus; //예약 상태
  late RegionType? orgType; //예약 상태

  ReservationDataDTO({
    this.reservationIdx,
    this.reservationDate,
    this.reservationTime,
    this.reservationStatus,
    this.orgType,
  });

  factory ReservationDataDTO.fromJson(Map<String, dynamic>? json){
    return ReservationDataDTO(
      reservationIdx: json?['reservationIdx'] ?? '',
      reservationDate: json?['reservationDate'] ?? '',
      reservationTime: json?['reservationTime'] ?? '',
      reservationStatus: json?['reservationStatus']?? '',
      orgType: (json?['orgType'] == 'D' ? RegionType.donggu :  RegionType.gwangsangu),
    );
  }

  static List<ReservationDataDTO> jsonList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => ReservationDataDTO.fromJson(json))
        .toList();
  }
}

class ReservationTimeDataDTO{
  final String reservationTime;

  ReservationTimeDataDTO({required this.reservationTime});

  factory ReservationTimeDataDTO.fromJson(Map<String, dynamic> json){
    return ReservationTimeDataDTO(
        reservationTime: json['reservationTime']);
  }

  static List<ReservationTimeDataDTO> jsonList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson
        .map((json) => ReservationTimeDataDTO.fromJson(json))
        .toList();
  }
}