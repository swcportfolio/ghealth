
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/utils/etc.dart';

import '../../data/models/blood_test.dart';
import '../../data/models/health_screening_data.dart';
import '../../data/models/medication_Info_data.dart';
import '../../data/models/metrology_inspection.dart';
import '../../data/models/mydata_predict_data.dart';
import '../../data/models/summary_response.dart';
import '../../data/models/summary_response.dart';
import '../../main.dart';
import '../../utils/api_exception.dart';

class MyHealthReportViewModel extends ChangeNotifier {

  late BuildContext context;

  final _postRepository = PostRepository();
  final _metrologyInspection = MetrologyInspection();
  final _bloodTest = BloodTest();

  late SummaryData _summaryData;
  late  MyDataPredictData _mydataPredict;

  late List<MedicationInfoData> _medicationInfoList;

  /// 건강검진 결과 안내
  /// [healthScreeningList]중에 [dataName]이 "종합소견_판정" 의
  /// dataValue 값
  ///
  /// ex)"dataValue": "정상B(경계) ,일반 질환의심
  String _comprehensiveOpinionText = '';

  ///  건강검진 결과 안내
  /// [healthScreeningList]중에 [dataName]이 "종합소견_생활습관관리"의
  /// dataValue 값
  ///
  /// ex) dataValue": "위험음주상태입니다. 절주 또는 금주가 필요합니다.신체활동량이 부족합니다. 운동을 생활화하십시오."
  String _lifestyleManagementText = '';

  /// 검진날짜
  late String _issuedDate;

  SummaryData get summaryData => _summaryData;
  MetrologyInspection get metrologyInspection => _metrologyInspection;
  BloodTest get bloodTest => _bloodTest;
  List<MedicationInfoData> get medicationInfoList => _medicationInfoList;
  MyDataPredictData get mydataPredict => _mydataPredict;

  String get comprehensiveOpinionText => _comprehensiveOpinionText;
  String get lifestyleManagementText => _lifestyleManagementText;
  String get issuedDate => _issuedDate;

  Future<void> handleHealthSummary() async {
    try{
      SummaryResponse response = await _postRepository.getHealthSummaryDio();
      if(response.status.code == '200'){
        _summaryData =  response.data;

        dataParsingByWidget();

      }
      else {
        //ToDo: 여기에 대한 테스트가 필요하다.
        throw ApiException('Unexpected status code: ${response.status.code}');
      }

    } on DioException catch (dioError) {
      // 예외 처리
      logger.e('=> dioError: $dioError');
      rethrow;
    } catch (error) {
      logger.e('=> error: $error');
      rethrow;
    }
  }


  /// 위젯별 데이터 파싱
  dataParsingByWidget() {
    parsingHealthScreeningList();
    parsingMetrologyInspection();
    parsingBloodTest();
    _mydataPredict = _summaryData.mydataPredict;
    _medicationInfoList = List.of(_summaryData.medicationInfoList);
    notifyListeners(); // 상태 변경을 알립니다.
  }

  parsingHealthScreeningList() {
    for(var value in _summaryData.healthScreeningList){
      if(value.dataName == '종합소견_판정'){
        _comprehensiveOpinionText = value.dataValue;
        _issuedDate = Etc.defaultDateFormat(value.issuedDate);
      }
      if(value.dataName == '종합소견_생활습관관리'){
        _lifestyleManagementText = value.dataValue;
      }
    }
  }

  void parsingMetrologyInspection() =>
    _metrologyInspection.parseFromHealthScreeningList(_summaryData.healthScreeningList);

  void parsingBloodTest() =>
      _bloodTest.parseFromHealthScreeningList(_summaryData.healthScreeningList);
}