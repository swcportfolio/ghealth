

import 'package:ghealth_app/data/models/ai_health_data.dart';
import 'package:ghealth_app/data/models/status.dart';

class AiHealthResponse {
  final Status status;
  final AiHealthData data;

  AiHealthResponse({required this.status, required this.data});

  factory AiHealthResponse.fromJson(Map<String, dynamic> json) {
    return AiHealthResponse(
      status: Status.fromJson(json['status']),
      data: AiHealthData.fromJson(json['data'])
    );
  }
}