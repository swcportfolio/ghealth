


import 'package:ghealth_app/data/models/status.dart';

class AccumulatePointResponse {
  final Status status;

  AccumulatePointResponse({required this.status});

  factory AccumulatePointResponse.fromJson(Map<String, dynamic> json) {
    return AccumulatePointResponse(
        status: Status.fromJson(json['status']),
    );
  }
}