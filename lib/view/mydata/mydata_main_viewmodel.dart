
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/health_screening_data.dart';
import 'package:ghealth_app/data/models/health_screening_history_data.dart';

import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/utils/my_exception.dart';

import '../../data/models/blood_test.dart';
import '../../data/models/medication_Info_data.dart';
import '../../data/models/metrology_inspection.dart';
import '../../data/models/mydata_predict_data.dart';
import '../../data/models/summary_response.dart';
import '../../main.dart';
import '../../utils/text_formatter.dart';

class MyDataMainViewModel extends ChangeNotifier {
  MyDataMainViewModel(this.context);
  late BuildContext context;

  final _postRepository = PostRepository();

  /// 계측 검사 결과 객체
  /// 시력, 청력, 혈압, 허리둘레, 체질량지수 등등
  final _metrologyInspection = MetrologyInspection();

  final _metrologyInspectionList = <MetrologyInspection>[];

  /// 혈액검사 결과 객체
  final _bloodTest = BloodTest();

  /// 마이데이터(나의 건강정보 요약)
  late SummaryData? _summaryData;

  /// AI질환 예측 검사 결과 데이터
  late  MyDataAIPredictData? _mydataPredict;

  /// 약 처방 리스트
  late List<MedicationInfoData>? _medicationInfoList = [];

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
  /// ex) dataValue": "위험음주상태입니다. 절주 또는 금주가 필요합니다.신체활동량이 부족, 운동을 생활화하십시오."
  String _lifestyleManagementText = '';

  /// mydata 검진날짜
  late String _issuedDate = '';

  late List<String> _issuedDateList = [];

  String? selectedDateTime;

  SummaryData? get summaryData => _summaryData;
  BloodTest get bloodTest => _bloodTest;
  MetrologyInspection get metrologyInspection => _metrologyInspection;
  MyDataAIPredictData? get mydataPredict => _mydataPredict;
  List<MedicationInfoData>? get medicationInfoList => _medicationInfoList;
  List<String> get issuedDateList => _issuedDateList;


  /// 건강검진 결과 안내 propertys
  String get comprehensiveOpinionText => _comprehensiveOpinionText;
  String get lifestyleManagementText => _lifestyleManagementText;
  String get issuedDate => _issuedDate;


  /// 마이데이터 전체 데이터 조회
  Future<SummaryData?> handleHealthSummary() async {
    try{
      SummaryResponse response = await _postRepository.getHealthSummaryDio(selectedDateTime);

      if(response.status.code == '200' && response.data != null) {
        _summaryData = response.data;
        dataParsingByWidget();
        return summaryData;
      } else {
        return null;
      }
    }  on DioException catch (dioError) {
      logger.e('=> $dioError');
      MyException.myDioException(dioError.type);
    }
    return null;
  }

  /// DropdownButton 날짜 선택 onChanged
  onChangedDropdownButton(String selectedDateTime){
    this.selectedDateTime = selectedDateTime.replaceAll('-','');
    logger.i('수정된 selectedDateTime: ${this.selectedDateTime}');
    handleHealthSummary();
    notifyListeners();
  }


  /// [_summaryData] 위젯별 데이터 파싱
  dataParsingByWidget() {
    parsingHealthScreeningList();
    parsingMetrologyInspection();
    parsingMetrologyInspection2();
    parsingBloodTest();
    _mydataPredict = _summaryData?.mydataPredict;

    if(_summaryData?.medicationInfoList != null) {
      _issuedDateList = List.of(_summaryData!.issuedDateList).cast<String>().toList();
      _medicationInfoList = _summaryData!.medicationInfoList;
    }
    notifyListeners(); // 상태 변경을 알립니다.
  }


  /// 마이데이터 건강검진 종합소견 데이터 파싱
  /// "종합소견_판정", "종합소견_생활습관관리"에 해당되는 [dataName] 추출
  parsingHealthScreeningList() {
    if(_summaryData?.healthScreeningList != null) {
      for(var value in _summaryData!.healthScreeningList!){
        if(value.dataName == '종합소견_판정'){ //종합소견_판정, 인지기능장애_결과
          _comprehensiveOpinionText = value.dataValue;
          _issuedDate = TextFormatter.defaultDateFormat(value.issuedDate);
        }
        if(value.dataName == '종합소견_생활습관관리'){ //종합소견_생활습관관리, 노인신체기능검사_결과
          _lifestyleManagementText = value.dataValue;
        }
      }
    }
  }


  /// [_summaryData]의 건강 검진 목록에서 계측 검사 데이터를 파싱하는 역할을 합니다.
  /// 건강 검진 목록이 null이 아니라면, [_metrologyInspection] 객체를 사용하여
  /// 데이터를 파싱하고 추가적인 사용을 위해 저장합니다.
  void parsingMetrologyInspection(){
    if(_summaryData?.healthScreeningList != null){
      _metrologyInspection.parseFromHealthScreeningList(_summaryData!.healthScreeningList!);
    }
  }

  /// [_summaryData]의 건강 검진 목록에서 계측 검사 데이터를 파싱하는 역할을 합니다.
  /// 건강 검진 목록이 null이 아니라면, [_metrologyInspection] 객체를 사용하여
  /// 데이터를 파싱하고 추가적인 사용을 위해 저장합니다.
  void parsingMetrologyInspection2(){
    dates.clear();
    dataList.clear();

    if(_summaryData?.healthScreeningList != null) {
      _summaryData!.healthScreeningHistoryList?.forEach((date, data) {
        print('날짜: $date');
        dates.add(date);

        final metrologyInspection = MetrologyInspection();
        metrologyInspection.parseFromHealthScreeningHistoryList(data);
        dataList.add(metrologyInspection);
      });
    }
  }

  List<String> dates = [];
  List<MetrologyInspection> dataList = [];


  /// [_summaryData]의 건강 검진 목록에서 혈액 검사 데이터를 파싱하는 역할을 합니다.
  /// 만약 건강 검진 목록이 null이 아니라면, [_bloodTest] 객체를 사용하여 데이터를 파싱하고 추가적인 사용을 위해 저장합니다.
  void parsingBloodTest(){
    if(_summaryData?.healthScreeningList != null){
      _bloodTest.parseFromHealthScreeningList(_summaryData!.healthScreeningList!);
    }
  }
}