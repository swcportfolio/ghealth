// ignore_for_file: avoid_init_to_null

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:health/health.dart';

import '../data/models/authorization.dart';
import '../data/models/reservation_default_response.dart';
import '../data/models/week_chart_data.dart';
import '../main.dart';
import '../utils/api_exception.dart';
import '../utils/etc.dart';

class HealthService {

 late HealthFactory health;
 late List<HealthDataType> types;
 late List<HealthDataAccess> permissions;
 late PostRepository _postRepository;
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

 late int? dayStep;
 late int? toDayTotalSleep;
 late double heartRate = 0;
 late DateTime? heartRateDate = null;

 /// 주간 걸음, 수면 데이터 리스트
 late List<WeekChartData> chartStepData;
 late List<WeekChartData> chartSleepData;

 static final HealthService _instance = HealthService.internal();

 factory HealthService(){
  return _instance;
 }

 HealthService.internal(){
  /// health property init
  health = HealthFactory();
  types = [HealthDataType.STEPS, HealthDataType.SLEEP_IN_BED, HealthDataType.HEART_RATE];
  permissions = [HealthDataAccess.READ, HealthDataAccess.READ, HealthDataAccess.READ];

  ///repository init
  _postRepository = PostRepository();

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
  if (!requested) {
   try {
    requested = await health.requestAuthorization(types, permissions: permissions);
    logger.d('=>requested: $requested');
    return requested;
   } catch (error) {
    logger.d('=>requested: $requested / $error');
    throw ApiException('NotGranted');
   }
  }
  return requested; // 이미 권한이 요청된 경우 현재 값을 반환합니다.
 }

  /// 웨어러블 화면에 보여줄 당일 데이터 가져오기
  Future<void> fetchToDayData() async {
    if (requested) {
      try {
        dayStep = await health.getTotalStepsInInterval(today24Hour, now) ?? 0;

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

        // healthSleepData의 각 요소에 대해 누적값 계산
        for (var data in healthSleepData) {
          totalValue += double.parse(data.value.toString());
        }
        toDayTotalSleep = totalValue.toInt();
      } catch (error) {
        throw ApiException('NotGranted');
      }
    } else {
      throw ApiException('NotGranted');
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

   //데이터 포멧에 맞춰 setMap
   healthStepData.map((p)=> stepMap.add(setMap(p))).toList();
   healthSleepData.map((p)=> sleepMap.add(setMap(p))).toList();
   healthHeartData.map((p)=> heartMap.add(setMap(p))).toList();

   logger.i('=> healthStepData: ${stepMap.toString()}');
   logger.i('=> healthSleepData: ${sleepMap.toString()}');
   logger.i('=> healthHeartData: ${heartMap.toString()}');

   //서버로 health 데이터 전송
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
          WeekChartData(
            x: Etc.setDateTime(0),
            y: calculateSum(daySleep).toInt(),
          ),
          WeekChartData(
            x: Etc.setDateTime(1),
            y: calculateSum(agoDaySleep).toInt(),
          ),
          WeekChartData(
            x: Etc.setDateTime(2),
            y: calculateSum(agoTwoDaySleep).toInt(),
          ),
          WeekChartData(
            x: Etc.setDateTime(3),
            y: calculateSum(agoThreeDaySleep).toInt(),
          ),
          WeekChartData(
            x: Etc.setDateTime(4),
            y: calculateSum(agoFourthDaySleep).toInt(),
          ),
          WeekChartData(
            x: Etc.setDateTime(5),
            y: calculateSum(agoFifthDaySleep).toInt(),
          ),
          WeekChartData(
            x: Etc.setDateTime(6),
            y:calculateSum(agoSixthDaySleep).toInt(),
          ),
        ];
        chartStepData = [
          WeekChartData(
            x: Etc.setDateTime(0),
            y: int.parse(dayStep.toString()),
          ),
          WeekChartData(
            x: Etc.setDateTime(1),
            y: int.parse(agoDayStep.toString()),
          ),
          WeekChartData(
            x: Etc.setDateTime(2),
            y: int.parse(agoTwoDayStep.toString()),
          ),
          WeekChartData(
            x: Etc.setDateTime(3),
            y: int.parse(agoThreeDayStep.toString()),
          ),
          WeekChartData(
            x: Etc.setDateTime(4),
            y: int.parse(agoFourthDayStep.toString()),
          ),
          WeekChartData(
            x: Etc.setDateTime(5),
            y: int.parse(agoFifthStep.toString()),
          ),
          WeekChartData(
            x: Etc.setDateTime(6),
            y: int.parse(agoSixthStep.toString()),
          ),
        ];

      } catch (error) {
        throw ApiException('NotGranted');
      }
    } else {
      logger.e('NotRequested');
      throw ApiException('NotRequested');
    }
  }

  Future<void> handleSaveHealthData(String dataType, List<Map<String, dynamic>> healthDataMap) async {
  try{
   DefaultResponse response = await _postRepository
       .saveHealthDataDio(dataType, dioMap(dataType, healthDataMap));

   if(response.status.code == '200'){
    logger.i('=> dataType: health data transmission successful');
   } else {
    logger.e('=> ${response.status.code} /${response.status.message}');
    logger.e('=> dataType: health data send failed');
   }
  } on DioException catch (dioError){
   logger.i('=> ${dioError.message}');
  }
 }

 /// 수집된 Health Data 서버로 저장
 Future<void> handleMultipleHealthData(
     List<Map<String, dynamic>> stepMap,
     List<Map<String, dynamic>> sleepMap,
     List<Map<String, dynamic>> heartMap,
     ) async {
  if(stepMap.isNotEmpty){
   await handleSaveHealthData('stepcount', stepMap);
  } else {
   logger.i('=> stepcount null');
  }

  if(heartMap.isNotEmpty){
   await handleSaveHealthData('heartrate', heartMap);
  } else {
   logger.i('=> heartrate null');
  }

  if(sleepMap.isNotEmpty){
   await handleSaveHealthData('sleeptime', sleepMap);
  } else {
   logger.i('=> sleeptime null');
  }
 }

 Map<String, dynamic> dioMap(String type, List<Map<String, dynamic>> healthDataMap) {
  Map<String, dynamic> toMap = {
   'os': Platform.isAndroid ? 'A' : 'I',
   'userID': Authorization().userID,
   'measureDate': previousDayDate,
   'rawData': healthDataMap
  };
  return toMap;
 }

 Map<String, dynamic> setMap(HealthDataPoint p) {
  String value = p.value.toString();
  previousDayDate = p.dateFrom.toString().substring(0, 10);

  Map<String, dynamic> toMap = {
   'time':
   '${p.dateFrom.toString().substring(0, 19)} ~ ${p.dateTo.toString().substring(0, 19)}',
   'value': value
  };
  return toMap;
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
}