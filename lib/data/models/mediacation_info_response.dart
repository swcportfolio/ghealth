import 'package:ghealth_app/data/models/status.dart';

import 'medication_Info_data.dart';

/// 투약정보 리스트 조회 Response body 클래스
class MedicationInfoResponse {
  final Status status;
  final List<MedicationInfoData> data;

  MedicationInfoResponse({required this.status, required this.data});

  factory MedicationInfoResponse.fromJson(Map<String, dynamic> json) {
    return MedicationInfoResponse(
      status: Status.fromJson(json['status']),
      data: MedicationInfoData.jsonList(json['data']),
    );
  }
}