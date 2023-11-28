import 'package:ghealth_app/data/models/status.dart';

class DefaultResponse {
  final Status status;
  final dynamic data; // null 반환됨

  DefaultResponse({required this.status, this.data});

  factory DefaultResponse.fromJson(Map<String, dynamic> json) {
    return DefaultResponse(
      status: Status.fromJson(json['status']),
      data: json['data'],
    );
  }
}