
import 'package:ghealth_app/data/models/reservation_time_data.dart';
import 'package:ghealth_app/data/models/status.dart';

class ReservationPossibleResponse {
  final Status status;
  List<ReservationTimeData> data;

  ReservationPossibleResponse({required this.status, required this.data});

  factory ReservationPossibleResponse.fromJson(Map<String, dynamic> json) {
    return ReservationPossibleResponse(
      status: Status.fromJson(json['status']),
      data: ReservationTimeData.jsonList(json['data']),
    );
  }
}