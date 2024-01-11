

import 'package:ghealth_app/data/models/status.dart';

/// 나의 일싱 기록의 라이프로그 건강관리소 방문 시
/// 저장된 날짜 가져오는 RecordDateResponse 클레스
class RecordDateResponse {
  final Status status;
  final List<dynamic> data;

  RecordDateResponse({required this.status, required this.data});

  factory RecordDateResponse.fromJson(Map<String, dynamic> json) {
    return RecordDateResponse(
      status: Status.fromJson(json['status']),
      data: json['data'].toList(),
    );
  }
}