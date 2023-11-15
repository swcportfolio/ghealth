
import 'package:ghealth_app/data/models/status.dart';

import 'health_screening_data.dart';

class HealthInstrumentationResponse {
  final Status status;
  final List<HealthScreeningData> data;

  HealthInstrumentationResponse({required this.status, required this.data});

  factory HealthInstrumentationResponse.fromJson(Map<String, dynamic> json) {
    return HealthInstrumentationResponse(
      status: Status.fromJson(json['status']),
      data: HealthScreeningData.jsonList(json['data']),
    );
  }
}