

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../../common/util/dio/dio_exceptions.dart';
import '../../../../common/util/snackbar_utils.dart';
import '../../../../common/util/text_format.dart';
import '../../../domain/usecase/ghealth/summary_usecase.dart';
import '../../../entity/summary_dto.dart';

import '../../../model/enum/snackbar_status_type.dart';
import '../../../model/vo_blood_test.dart';
import '../../../model/vo_physical_inspection.dart';

class CheckupViewModelTest extends ChangeNotifier {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  CheckupViewModelTest() {
    getSummary();
  }

  /// 서버 데이터 조회시 사용될 Date 포멧 String
  String? _searchDate;

  /// 검진 날짜 리스트
  List<String> _issuedDateList = [];

  /// ui에서 보여준 Date text
  /// replaceAll('-') 되기 전
  String? _selectedTempValue;

  /// 나의 건강검진 마이데이터 객체
  SummaryDataDTO? _summaryDataDTO;

  /// 건강검진 종합 내용
  /// [healthScreeningList]중에 [dataName]이 "종합소견_판정" 의
  ///
  /// ex)"dataValue": "정상B(경계) ,일반 질환의심
  String _comprehensiveOpinionText = '';

  ///  건강검진 종합 의견
  /// [healthScreeningList]중에 [dataName]이 "종합소견_생활습관관리"의
  ///
  /// ex) dataValue": "위험음주상태입니다. 절주 또는 금주가 필요합니다.신체활동량이 부족, 운동을 생활화하십시오."
  String _lifestyleManagementText = '';

  /// 혈액검사 결과 객체
  final _bloodTest = BloodTest();

  /// 계측검사 날짜 리스트
  final List<String> _physicalInspectionDates = [];

  /// 계측 검사 결과 객체 리스트
  /// 시력, 청력, 혈압, 허리둘레, 체질량지수 등등
  final List<PhysicalInspection> _physicalInspectionList = [];

  /// 약 처방 리스트
  List<MedicationInfoDTO> _medicationInfoList = [];

  /// 건강 검진 종합 소견 건진일
  String _issuedDate = '';


  String get issuedDate => _issuedDate;
  List<String> get issuedDateList => _issuedDateList;
  String? get selectedTempValue => _selectedTempValue;
  String get comprehensiveOpinionText => _comprehensiveOpinionText;
  String get lifestyleManagementText => _lifestyleManagementText;
  BloodTest get bloodTest => _bloodTest;
  List<String> get physicalInspectionDates => _physicalInspectionDates;
  List<PhysicalInspection> get physicalInspectionList => _physicalInspectionList;
  List<MedicationInfoDTO> get medicationInfoList => _medicationInfoList;


  /// 마이데이터 전체 데이터 조회
  Future<void> getSummary() async {
    try{
      final summaryDTO = await SummaryCase().execute(_searchDate);
      if (summaryDTO?.status.code == '200' && summaryDTO?.data != null) {
        _summaryDataDTO =  summaryDTO?.data;

        parseHealthScreeningData(); // 종합소견
        parseBloodTest(); // 혈액검사
        parsePhysicalInspection(); // 계측검사
        parseMedicationInfo(); // 약처방
      }
      _isLoading = false;
      notifyListeners();

    } on DioException catch (e) {
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }


  /// [_summaryDataDTO]의 건강검진 종합 소견 데이터 추출
  parseHealthScreeningData(){
    if(_summaryDataDTO?.healthScreeningList != null) {
      for(var value in _summaryDataDTO!.healthScreeningList!){
        if(value.dataName == '종합소견_판정'){ //종합소견_판정, 인지기능장애_결과
          _comprehensiveOpinionText = value.dataValue;
          _issuedDate = TextFormat.defaultDateFormat(value.issuedDate);
        }
        if(value.dataName == '종합소견_생활습관관리'){ //종합소견_생활습관관리, 노인신체기능검사_결과
          _lifestyleManagementText = value.dataValue;
        }
      }
    }
  }


  /// [_summaryData]의 건강 검진 목록에서 혈액 검사 데이터 추출
  /// 만약 건강 검진 목록이 null이 아니라면, [_bloodTest] 객체를 사용하여 데이터를 파싱하고 추가적인 사용을 위해 저장합니다.
  parseBloodTest(){
    if(_summaryDataDTO?.healthScreeningList != null){
      _bloodTest.parseFromHealthScreeningList(_summaryDataDTO!.healthScreeningList!);
    }
  }


  /// [_summaryDataDTO]의 건강 검진 목록에서 계측 검사 데이터 추출
  parsePhysicalInspection(){
    physicalInspectionDates.clear();
    physicalInspectionList.clear();

    final healthScreeningHistoryList = _summaryDataDTO?.healthScreeningHistoryList;

    if (healthScreeningHistoryList != null) {
      _summaryDataDTO!.healthScreeningHistoryList?.forEach((date, data) {
        physicalInspectionDates.add(date);

        final metrologyInspection = PhysicalInspection();
        metrologyInspection.parseFromHealthScreeningHistoryList(data);
        physicalInspectionList.add(metrologyInspection);
      });
    }
  }


  /// [_summaryDataDTO]의 건강 검진 목록에서 약 처방  데이터 추출
  parseMedicationInfo(){
    if(_summaryDataDTO?.medicationInfoList != null) {
      _issuedDateList = List.of(_summaryDataDTO!.issuedDateList)
          .cast<String>()
          .toSet()
          .toList();
      _medicationInfoList = _summaryDataDTO!.medicationInfoList ?? [];
    }
  }


  /// DropdownButton onChanged
  onChanged(String? value, BuildContext context) {
    if (_selectedTempValue != value) {
      _selectedTempValue = value!;
      _searchDate = _selectedTempValue!.replaceAll('-', '');
      SnackBarUtils.showStatusSnackBar(
          message: '날짜가 변경되었습니다.',
          context: context,
          statusType: SnackBarStatusType.success
      );
      getSummary();
    }
  }


  /// 에러 처리
  notifyError(String message){
    _isLoading = false;
    _errorMessage = message;
    _isError = true;
    notifyListeners();
  }
}