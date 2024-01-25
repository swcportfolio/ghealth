import 'package:ghealth_app/data/models/point_hisstory.dart';
import 'package:ghealth_app/data/models/status.dart';

class PointHistoryResponse {
  final Status status;
  final List<PointHistory>? data;

  PointHistoryResponse({required this.status, required this.data});

  factory PointHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PointHistoryResponse(
      status: Status.fromJson(json['status']),
      data: json['data'] == null ? null : PointHistory.jsonToList(json['data']),
    );
  }
}
