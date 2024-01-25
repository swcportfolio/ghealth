
import 'package:ghealth_app/data/models/point_hisstory.dart';
import 'package:ghealth_app/data/models/status.dart';

class TotalPointResponse {
  final Status status;
  final String? data;

  TotalPointResponse({required this.status, required this.data});

  factory TotalPointResponse.fromJson(Map<String, dynamic> json) {
    return TotalPointResponse(
      status: Status.fromJson(json['status']),
      data: json['data'],
    );
  }
}
