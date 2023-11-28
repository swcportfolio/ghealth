
import 'package:ghealth_app/data/models/status.dart';

class ReservationDayOffResponse {
  final Status status;
  final List<String> data;

  ReservationDayOffResponse({required this.status, required this.data});

  factory ReservationDayOffResponse.fromJson(Map<String, dynamic> json) {
    return ReservationDayOffResponse(
      status: Status.fromJson(json['status']),
      data: List<String>.from(json['data']),
    );
  }
}