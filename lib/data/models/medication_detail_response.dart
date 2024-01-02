import 'package:ghealth_app/data/models/medication_detail.dart';
import 'package:ghealth_app/data/models/status.dart';

import 'medication_Info_data.dart';

/// 투약정보 상세정보 조회 Response body 클래스
class MedicationDetailResponse {
  final Status status;
  final MedicationDetailData data;

  MedicationDetailResponse({required this.status, required this.data});

  factory MedicationDetailResponse.fromJson(Map<String, dynamic> json) {
    return MedicationDetailResponse(
      status: Status.fromJson(json['status']),
      data: MedicationDetailData.fromJson(json['data']),
    );
  }
}