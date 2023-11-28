import 'package:ghealth_app/data/models/reservation_data.dart';
import 'package:ghealth_app/data/models/status.dart';

/// 가장 최신 방문 예약 정보 Response body 클래스
class ReservationRecentResponse {
  final Status status;
  final ReservationData? data;

  ReservationRecentResponse({required this.status, required this.data});

  factory ReservationRecentResponse.fromJson(Map<String, dynamic> json) {
    return ReservationRecentResponse(
      status: Status.fromJson(json['status']),
      data: ReservationData.fromJson(json['data']),
    );
  }
}