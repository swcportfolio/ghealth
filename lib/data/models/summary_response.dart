import 'package:ghealth_app/data/models/status.dart';

import 'health_screening_data.dart';
import 'health_screening_history_data.dart';
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
  final List<dynamic> issuedDateList;
  final MyDataAIPredictData? mydataPredict;
  final List<HealthScreeningData>? healthScreeningList;
  final List<MedicationInfoData>? medicationInfoList;
  final Map<String, List<HealthScreeningHistoryData>>? healthScreeningHistoryList;

  SummaryData({
      required this.issuedDateList,
      required this.mydataPredict,
      required this.healthScreeningList,
      required this.medicationInfoList,
      required this.healthScreeningHistoryList,
  });

  factory SummaryData.fromJson(Map<String, dynamic> json) {
    return SummaryData(
        issuedDateList: json['issuedDateList'].toList(),
        mydataPredict: MyDataAIPredictData.fromJson(json['mydataPredict']),
        healthScreeningList: HealthScreeningData.jsonList(json['healthScreeningList']),
        medicationInfoList: MedicationInfoData.jsonList(json['medicationInfoList']),
        healthScreeningHistoryList: HealthScreeningHistoryData.groupDataByDate(json['healthScreeningHistoryList']),
    );
  }
}
