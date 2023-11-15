
import 'package:ghealth_app/data/models/status.dart';

class SendMessageResponse {
  final Status status;
  final dynamic data; // null 반환됨

  SendMessageResponse({required this.status, this.data});

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) {
    return SendMessageResponse(
      status: Status.fromJson(json['status']),
      data: json['data'],
    );
  }
}