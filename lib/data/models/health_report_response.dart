
import 'package:ghealth_app/data/models/status.dart';
import 'lifelog_data.dart';

class HealthReportResponse {
  final Status status;
  final List<LifeLogData> data;

  HealthReportResponse({required this.status, required this.data});

  factory HealthReportResponse.fromJson(Map<String, dynamic> json) {
    return HealthReportResponse(
      status: Status.fromJson(json['status']),
      data: LifeLogData.jsonList(json['data']),
    );
  }
}