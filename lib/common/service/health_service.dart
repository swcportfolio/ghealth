
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ghealth_app/layers/domain/usecase/ghealth/wearable_save_usecase.dart';
import 'package:ghealth_app/layers/entity/wearable_dto.dart';
import 'package:health/health.dart';

import '../../layers/model/authorization_test.dart';
import '../../layers/model/vo_chart.dart';
import '../../main.dart';

import '../data/preference/prefs.dart';
import '../util/text_format.dart';

class HealthService {

  late HealthFactory health;
  late List<HealthDataType> types;
  late List<HealthDataAccess> permissions;

  /// ToDay
  late DateTime now;

  ///오늘(당일) 새벽 12시 시점
  late DateTime today24Hour;

  /// 1일~ 6일전
  late DateTime agoDay;
  late DateTime agoTwoDay;
  late DateTime agoThreeDay;
  late DateTime agoFourthDay;
  late DateTime agoFifthDay;
  late DateTime agoSixthDay;

  /// 전날 날짜 String
  String previousDayDate = '';

  bool requested = false;

  int dayStep = 0;
  int daySleep = 0;
  double heartRate = 0;

  DateTime heartRateDate = DateTime.now();

  /// 주간 걸음, 수면 데이터 리스트
  late List<ChartData> chartStepData;
  late List<ChartData> chartSleepData;

  static final HealthService _instance = HealthService.internal();

  factory HealthService(){
    return _instance;
  }

  HealthService.internal(){
    /// health property init
    health = HealthFactory();
    types = [HealthDataType.STEPS, HealthDataType.SLEEP_IN_BED, HealthDataType.HEART_RATE];
    permissions = [HealthDataAccess.READ, HealthDataAccess.READ, HealthDataAccess.READ];

    /// DateTimes init
    now          = DateTime.now();
    today24Hour  = DateTime(now.year, now.month, now.day, 0, 0);
    agoDay       = DateTime(subtractDays(1).year,subtractDays(1).month, subtractDays(1).day, 0, 0);  // 1일전
    agoTwoDay    = DateTime(subtractDays(2).year, subtractDays(2).month, subtractDays(2).day, 0, 0);  // 2일전
    agoThreeDay  = DateTime(subtractDays(3).year, subtractDays(3).month, subtractDays(3).day, 0, 0);  // 3일전
    agoFourthDay = DateTime(subtractDays(4).year, subtractDays(4).month, subtractDays(4).day, 0, 0);  // 4일전
    agoFifthDay  = DateTime(subtractDays(5).year, subtractDays(5).month, subtractDays(5).day, 0, 0);  // 5일전
    agoSixthDay  = DateTime(subtractDays(6).year, subtractDays(6).month, subtractDays(6).day, 0, 0);  // 6일전
  }

  Future<bool> requestPermission() async {
    if (AuthorizationTest().isCompletedPermission) {
      requested = true;
      return true;
    }
    try {
      requested = await health.requestAuthorization(types, permissions: permissions);
      logger.d('=>requested: $requested');
      if (requested) {
        AuthorizationTest().isCompletedPermission = requested;
        Prefs.isCompletedPermission.set(requested);
      }
      return requested;
    } catch (error) {
      logger.d('=>requested: $requested / $error');
      throw 'NotGranted';
    }
  }

  /// 웨어러블 화면에 보여줄 당일 데이터 가져오기
  Future<void> fetchToDayData() async {
    if (requested) {
      try {
        dayStep = await health.getTotalStepsInInterval(today24Hour, now) ?? 0;

        logger.i('dayStep: $dayStep');
        List<HealthDataPoint> healthDataList = await health
            .getHealthDataFromTypes(today24Hour, now, [HealthDataType.HEART_RATE, HealthDataType.SLEEP_IN_BED]);

        List<HealthDataPoint> healthHeartData = healthDataList
            .where((data) => data.type == HealthDataType.HEART_RATE)
            .toList();

        List<HealthDataPoint> healthSleepData = healthDataList
            .where((data) => data.type == HealthDataType.SLEEP_IN_BED)
            .toList();

        // 최근 심박동 데이터 가져오기
        if (healthHeartData.isNotEmpty) {
          HealthDataPoint latestHeartRateData = healthHeartData.first;

          heartRate = double.parse(latestHeartRateData.value.toString());
          heartRateDate = latestHeartRateData.dateFrom;

          logger.i('최근 심박동 데이터: $heartRate');
          logger.i('최근 심박동 데이터 dateFrom: ${latestHeartRateData.dateFrom.toString()}');
          logger.i('최근 심박동 데이터 dateTo: ${latestHeartRateData.dateTo.toString()}');
        } else {
          logger.i('심박동 데이터 없음');
        }

        // 총 수면 시간 계산
        double totalValue = 0;
        logger.i('healthSleepData.length: ${healthSleepData.length}');

        // healthSleepData의 각 요소에 대해 누적값 계산
        for (var data in healthSleepData) {
          totalValue += double.parse(data.value.toString());
          logger.i(totalValue);
        }
        daySleep = totalValue.toInt();
      } catch (error) {
        throw 'NotGranted';
      }
    } else {
      throw 'NotGranted';
    }
  }

  /// 전날 축적된 건강데이터 가져오기
  /// HomeFrameView() 화면에서 실행됩니다.
  Future<void> fetchPreviousDayData(DateTime targetTime) async {
    List<Map<String, dynamic>> stepMap = [];
    List<Map<String, dynamic>> sleepMap = [];
    List<Map<String, dynamic>> heartMap = [];

    logger.i('=>$targetTime 날짜 fetchPreviousDayData!');

    DateTime agoDayOfTargetDate = targetTime.subtract(const Duration(days: 1));
    DateTime startTime = DateTime(agoDayOfTargetDate.year,agoDayOfTargetDate.month, agoDayOfTargetDate.day, 0, 0);  // targetTime 1일전 00시00분
    DateTime endTime = DateTime(agoDayOfTargetDate.year,agoDayOfTargetDate.month, agoDayOfTargetDate.day, 23, 59);  // targetTime 1일전 23시59분

    if(requested){
      List<HealthDataPoint> healthDataList = await health
          .getHealthDataFromTypes(startTime, endTime, types);

      List<HealthDataPoint> healthStepData = healthDataList
          .where((data) => data.type == HealthDataType.STEPS)
          .toList();

      List<HealthDataPoint> healthHeartData = healthDataList
          .where((data) => data.type == HealthDataType.HEART_RATE)
          .toList();

      List<HealthDataPoint> healthSleepData = healthDataList
          .where((data) => data.type == HealthDataType.SLEEP_IN_BED)
          .toList();

      // 데이터 포멧에 맞춰 setMap
      healthStepData.map((p)=> stepMap.add(setMap(p))).toList();
      healthSleepData.map((p)=> sleepMap.add(setMap(p))).toList();
      healthHeartData.map((p)=> heartMap.add(setMap(p))).toList();

      logger.i('=> healthStepData: ${stepMap.toString()}');
      logger.i('=> healthSleepData: ${sleepMap.toString()}');
      logger.i('=> healthHeartData: ${heartMap.toString()}');

      // 서버로 health 데이터 전송
      handleMultipleHealthData(stepMap, sleepMap, heartMap);
    } else {
      logger.e('=> 권한및 데이터 접근 퍼미션이 거절되었습니다.');
    }
  }

  /// 일주일 건강(걸음, 수면) 데이터 가져오기
  Future<void> fetchOneWeekData() async {
    if (requested) {
      try {
        /// 걸음 수
        int? dayStep          = await health.getTotalStepsInInterval(today24Hour, now) ?? 0;
        int? agoDayStep       = await health.getTotalStepsInInterval(agoDay, today24Hour) ?? 0;
        int? agoTwoDayStep    = await health.getTotalStepsInInterval(agoTwoDay, agoDay) ?? 0;
        int? agoThreeDayStep  = await health.getTotalStepsInInterval(agoThreeDay, agoTwoDay) ?? 0;
        int? agoFourthDayStep = await health.getTotalStepsInInterval(agoFourthDay, agoThreeDay) ?? 0;
        int? agoFifthStep     = await health.getTotalStepsInInterval(agoFifthDay, agoFourthDay) ?? 0;
        int? agoSixthStep     = await health.getTotalStepsInInterval(agoSixthDay, agoFifthDay) ?? 0;

        /// 수면시간 가져오기
        List<HealthDataPoint> daySleep          = await health.getHealthDataFromTypes(today24Hour, now, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoDaySleep       = await health.getHealthDataFromTypes(agoDay, today24Hour, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoTwoDaySleep    = await health.getHealthDataFromTypes(agoTwoDay, agoDay, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoThreeDaySleep  = await health.getHealthDataFromTypes(agoThreeDay, agoTwoDay, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoFourthDaySleep = await health.getHealthDataFromTypes(agoFourthDay, agoThreeDay, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoFifthDaySleep  = await health.getHealthDataFromTypes(agoFifthDay, agoFourthDay, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoSixthDaySleep  = await health.getHealthDataFromTypes(agoSixthDay, agoFifthDay, [HealthDataType.SLEEP_IN_BED]);


        chartSleepData = [
          ChartData(
            x: TextFormat.setXAxisDateTime(0),
            y: calculateSum(daySleep).toInt(),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(1),
            y: calculateSum(agoDaySleep).toInt(),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(2),
            y: calculateSum(agoTwoDaySleep).toInt(),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(3),
            y: calculateSum(agoThreeDaySleep).toInt(),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(4),
            y: calculateSum(agoFourthDaySleep).toInt(),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(5),
            y: calculateSum(agoFifthDaySleep).toInt(),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(6),
            y:calculateSum(agoSixthDaySleep).toInt(),
          ),
        ];
        chartStepData = [
          ChartData(
            x: TextFormat.setXAxisDateTime(0),
            y: int.parse(dayStep.toString()),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(1),
            y: int.parse(agoDayStep.toString()),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(2),
            y: int.parse(agoTwoDayStep.toString()),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(3),
            y: int.parse(agoThreeDayStep.toString()),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(4),
            y: int.parse(agoFourthDayStep.toString()),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(5),
            y: int.parse(agoFifthStep.toString()),
          ),
          ChartData(
            x: TextFormat.setXAxisDateTime(6),
            y: int.parse(agoSixthStep.toString()),
          ),
        ];

      } catch (error) {
        throw 'NotGranted';
      }
    } else {
      logger.e('NotRequested');
      throw 'NotRequested';
    }
  }


  /// durationDay 릍 통해 now의 이전 DateTime값을 리턴한다.
  DateTime subtractDays(int durationDay){
    return now.subtract(Duration(days: durationDay));
  }

  /// Function to calculate the sum of values in a list of HealthDataPoint
  double calculateSum(List<HealthDataPoint> healthDataList) {
    double sum = 0.0;
    for (var dataPoint in healthDataList) {
      // Assuming there is a property called value in HealthDataPoint
      sum += double.parse(dataPoint.value.toString());
    }
    return sum;
  }

  /// 웨어러블 헬스 데이터 저장
  Future<void> saveWearableHealthData(String dataType, List<Map<String, dynamic>> healthDataMap) async {
    try{
      WearableDTO? response = await WearableSaveUseCase()
          .execute(dataType, dioMap(dataType, healthDataMap));

      if(response != null && response.statusDTO.code == '200'){
        logger.i('=> Wearable health data transmission successful');
      } else {
        logger.e('=> ${response?.statusDTO.code} /${response?.statusDTO.message}');
        logger.e('=> health data send failed');
      }
    } on DioException catch (dioError){
      logger.i('=> save wearable error: $dioError');

    } catch (e) {
      logger.i('=> save wearable error: $e');

    }
  }

  /// 수집된 Health Data 서버로 저장
  Future<void> handleMultipleHealthData(
      List<Map<String, dynamic>> stepMap,
      List<Map<String, dynamic>> sleepMap,
      List<Map<String, dynamic>> heartMap,
      ) async {
    if(stepMap.isNotEmpty){
      await saveWearableHealthData('stepcount', stepMap);
    } else {
      logger.i('=> stepcount 데이터가 없습니다.');
    }

    if(heartMap.isNotEmpty){
      await saveWearableHealthData('heartrate', heartMap);
    } else {
      logger.i('=> heartrate 없습니다.');
    }

    if(sleepMap.isNotEmpty){
      await saveWearableHealthData('sleeptime', sleepMap);
    } else {
      logger.i('=> sleeptime 없습니다.');
    }
  }

  Map<String, dynamic> dioMap(String type, List<Map<String, dynamic>> healthDataMap) {
    Map<String, dynamic> toMap = {
      'os': Platform.isAndroid ? 'A' : 'I',
      'userID': AuthorizationTest().userID,
      'measureDate': previousDayDate,
      'rawData': healthDataMap
    };
    return toMap;
  }

  Map<String, dynamic> setMap(HealthDataPoint p) {
    String value = p.value.toString();
    previousDayDate = p.dateFrom.toString().substring(0, 10);

    Map<String, dynamic> toMap = {
      'time': '${p.dateFrom.toString().substring(0, 19)} ~ ${p.dateTo.toString().substring(0, 19)}',
      'value': value
    };
    return toMap;
  }


}