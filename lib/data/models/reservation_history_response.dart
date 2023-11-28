import 'package:ghealth_app/data/models/reservation_data.dart';
import 'package:ghealth_app/data/models/status.dart';

/// 방문 예약 히스토리  Response body 클래스
class ReservationHistoryResponse {
  final Status status;
  final List<ReservationData> data;

  ReservationHistoryResponse({required this.status, required this.data});

  factory ReservationHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ReservationHistoryResponse(
      status: Status.fromJson(json['status']),
      data: ReservationData.jsonList(json['data']),
    );
  }
}