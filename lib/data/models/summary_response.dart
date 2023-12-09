import 'package:ghealth_app/data/models/status.dart';

import 'health_screening_data.dart';
import 'medication_Info_data.dart';
import 'mydata_predict_data.dart';

class SummaryResponse {
  final Status status;
  final SummaryData? data;

  SummaryResponse({required this.status, required this.data});

  factory SummaryResponse.fromJson(Map<String, dynamic> json) {
    return SummaryResponse(
        status: Status.fromJson(json['status']),
        data: SummaryData.fromJson(json['data']),
    );
  }
}


class SummaryData {
  final MyDataAIPredictData? mydataPredict;
  final List<HealthScreeningData>? healthScreeningList;
  final List<MedicationInfoData>? medicationInfoList;

  SummaryData(
      {required this.mydataPredict,
      required this.healthScreeningList,
      required this.medicationInfoList});

  factory SummaryData.fromJson(Map<String, dynamic> json) {
    return SummaryData(
        mydataPredict: MyDataAIPredictData.fromJson(json['mydataPredict']),
        healthScreeningList: HealthScreeningData.jsonList(json['healthScreeningList']),
        medicationInfoList: MedicationInfoData.jsonList(json['medicationInfoList'])
    );
  }
}
