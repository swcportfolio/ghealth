

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/common/data/preference/prefs.dart';
import 'package:ghealth_app/common/util/snackbar_utils.dart';
import 'package:ghealth_app/layers/model/enum/snackbar_status_type.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_custom_picker.dart';

import '../../../../common/service/health_service.dart';
import '../../../../common/util/dio/dio_exceptions.dart';
import '../../../../common/common.dart';
import '../../../../main.dart';
import '../../../domain/usecase/ghealth/lifelog_visit_date_usecase.dart';
import '../../../domain/usecase/ghealth/point_usecase.dart';
import '../../../entity/total_point_dto.dart';
import '../../../entity/visit_date_dto.dart';
import '../../../model/authorization_test.dart';
import '../../../model/enum/daily_health_type.dart';

class DailyViewModelTest extends ChangeNotifier {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  DailyViewModelTest(){
    getVisitDate();
    getHealthData();
  }

  /// 건강관리소에서 검진 방문 날짜 리스트
  List<String> _visitDateList = [];

  /// 계측검사 확인을 위한 선택한 날자
  String _selectedDate = '';

  /// 총 포인트
  String _totalPoint = '0';

  /// 목표 걸음
  String _targetStep = AuthorizationTest().targetStep;
  String _targetSleep = AuthorizationTest().targetSleep;

  bool _permissionDenied = AuthorizationTest().permissionDenied;

  String _dayStep = '0';
  int _daySleep = 0;
  String _dayHeartRate = '0';
  DateTime _heartRateDate = DateTime.now();


  final targetStepsList = generateTargetList(1000, 60000, 1000);
  final targetSleepList = generateTargetList(1, 10, 1);

  List<String> get visitDateList => _visitDateList;
  String get selectedDate => _selectedDate;
  String get targetStep => _targetStep;
  String get targetSleep => _targetSleep;
  String get totalPoint => _totalPoint;
  String get dayStep => _dayStep;
  int get daySleep => _daySleep;
  String get dayHeartRate => _dayHeartRate;
  DateTime get heartRateDate => _heartRateDate;
  bool get permissionDenied => _permissionDenied;


  /// 건강 데이터 퍼미션 재요청
  retryHealthPermission(BuildContext context) async {
    bool isResponse = await HealthService().requestPermission();
    if(isResponse){
      AuthorizationTest().permissionDenied = !isResponse;
      Prefs.permissionDenied.set(!isResponse);
      logger.i('=> 건강데이터 퍼미션 요청 결과: $isResponse');

      _permissionDenied = false;
      notifyListeners();
      getHealthData();

    } else {
      if(context.mounted){
        SnackBarUtils.showStatusSnackBar(
            context: context,
            message: '접근 권한을 얻지 못했습니다.', statusType: SnackBarStatusType.failure);
      }
    }
  }


  /// 건강관리소 방문 날짜 리스트 조회
  Future<void> getVisitDate() async {
    try {
      final visitDateDTO = await LifeLogVisitDateUseCase().execute();


      final visitDateFuture = LifeLogVisitDateUseCase().execute();
      final totalPointFuture  = TotalPointUseCase().execute();

      final List futureResults = await Future.wait([
        visitDateFuture,
        totalPointFuture,
      ]);

      VisitDateDTO? responseVisitDate  = futureResults[0];
      TotalPointDTO? responseTotalPoint  = futureResults[1];

      /// 건강관리소 방문날짜 조회 결과 로직
      if (responseVisitDate?.status.code == '200') {
        _visitDateList = List.of(visitDateDTO!.data).cast<String>().toList();

        if(_visitDateList.isNotEmpty){
          _selectedDate = _visitDateList[0];
        }
      }

      /// 총 포인트 조회 결과 로직
      if(responseTotalPoint != null){
        _totalPoint = responseTotalPoint.data.toString();
      }
      _isLoading = false;
      notifyListeners();

    } on DioException catch (e) {
      logger.e(e);
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      logger.e(e);
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }


  /// 헬스데이터 조회
  Future<void> getHealthData() async {
    logger.i('=> AuthorizationTest().permissionDenied :${AuthorizationTest().permissionDenied}');
    if(AuthorizationTest().permissionDenied){
      return;
    }

    bool required = await HealthService().requestPermission();
    if(required){
      try{
        HealthService().fetchToDayData().then((_){
          _dayStep = HealthService().dayStep.toString(); // 오늘 총 걸음수
          _daySleep = HealthService().daySleep; // 오늘 총 걸음수
          _dayHeartRate = HealthService().heartRate.toInt().toString(); // 최근 심박동
          _heartRateDate  = HealthService().heartRateDate; // 최근 심박동 날짜

          logger.i('=> fetchToDayData().then 실행! : $_dayStep / $_daySleep / $_dayHeartRate');
          notifyListeners();
        });
      } catch (e) {
        logger.i('getHealthData error: $e');
      }
    }
  }


  /// DropdownButton onChanged
  onChanged(String? value) {
    if (_selectedDate != value) {
      _selectedDate = value!;
      notifyListeners();
    }
  }


  /// show Picker (목표 걸음, 수면시간 설정)
  showCustomDialog(DailyHealthType type, BuildContext context){
    CustomPicker().showBottomSheet(
        PickerData(19, type == DailyHealthType.sleep ? targetSleepList: targetStepsList, context,
                (callbackData)=> onPickerCallBack(callbackData)));
  }


  /// 목표설정(수면, 걸음) 피커 콜백함수
  onPickerCallBack(callbackData) {
    int getPickerData = int.parse(callbackData.toString());

    if(getPickerData<1000){ // 수면시간
      _targetSleep = getPickerData.toString();
      AuthorizationTest().targetSleep = _targetSleep;
      Prefs.targetSleep.set(_targetSleep);
    }
    else { // 걸음수
      _targetStep = getPickerData.toString();
      AuthorizationTest().targetStep = _targetStep;
      Prefs.targetStep.set(_targetStep);
    }

    notifyListeners();
  }


  /// 에러 처리
  notifyError(String message){
    _isLoading = false;
    _errorMessage = message;
    _isError = true;
    notifyListeners();
  }


  static List<String> generateTargetList(int start, int end, int step) {
    List<String> targetList = [];
    for (int i = start; i <= end; i += step) {
      targetList.add(i.toString());
    }
    return targetList;
  }
}