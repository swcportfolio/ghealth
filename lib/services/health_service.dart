import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:health/health.dart';

import '../data/models/authorization.dart';
import '../data/models/reservation_default_response.dart';
import '../main.dart';
import '../utils/api_exception.dart';

class HealthService {

 late HealthFactory health;
 late List<HealthDataType> types;
 late List<HealthDataAccess> permissions;
 late PostRepository _postRepository;
 /// ToDay
 late DateTime now;

 ///오늘(당일) 새벽 12시 시점
 late DateTime today24Hour;

 /// 전날
 late DateTime agoDay;

 /// 전날 날짜 String
 String previousDayDate = '';

 bool requested = false;
 List<Map<String, dynamic>> stepMap = [];
 List<Map<String, dynamic>> sleepMap = [];
 List<Map<String, dynamic>> hartMap = [];

 late int? dayStep;
 late int? toDayTotalSleep;
 late double heartRate = 0;
 late DateTime? heartRateDate = null;

 static final HealthService _instance = HealthService.internal();

 factory HealthService(){
  return _instance;
 }

 HealthService.internal(){
  health = HealthFactory();
  types = [HealthDataType.STEPS, HealthDataType.SLEEP_IN_BED, HealthDataType.HEART_RATE];
  permissions = [HealthDataAccess.READ, HealthDataAccess.READ, HealthDataAccess.READ];

  _postRepository = PostRepository();

  now = DateTime.now();
  today24Hour = DateTime(now.year, now.month, now.day, 0, 0);
  DateTime tempDate = now.subtract(const Duration(days: 1));
  agoDay = DateTime(tempDate.year,tempDate.month, tempDate.day, 0, 0);  // 1일전
 }

 requestPermission() async {
  if(!requested){ //퍼미션 받지 못했을 경우에만 실행
   try {
    requested = await health
        .requestAuthorization(types, permissions: permissions); // needed, since we only want READ access.
    logger.d('=>requested: $requested');
   } catch (error) {
    logger.d('=>requested: $requested / $error');
    throw ApiException('NotGranted');
   }
  }
 }

 /// 웨어러블 화면에 보여줄 당일 데이터 가져오기
 Future<void> fetchToDayData() async {
  await requestPermission();
  if(requested){
   try{
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
     logger.e('심박동 데이터 없음');
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
 Future<void> fetchPreviousDayData() async {
  await requestPermission();

  if(requested){
   List<HealthDataPoint> healthDataList = await health
       .getHealthDataFromTypes(agoDay, today24Hour, types);

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
   healthHeartData.map((p)=> hartMap.add(setMap(p))).toList();
   healthSleepData.map((p)=> sleepMap.add(setMap(p))).toList();

   logger.i('=> healthStepData: ${stepMap.toString()}');
   logger.i('=> healthHeartData: ${hartMap.toString()}');
   logger.i('=> healthSleepData: ${sleepMap.toString()}');

   //서버로 health 데이터 전송
   handleMultipleHealthData();
  } else {
   logger.e('=> 권한및 데이터 접근 퍼미션이 거절되었습니다.');
  }
 }

 Future<void> handleSaveHealthData(String dataType) async {
  try{
   DefaultResponse response = await _postRepository
       .saveHealthDataDio(dataType, dioMap(dataType));

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
 Future<void> handleMultipleHealthData() async {
  if(stepMap.isNotEmpty){
   await handleSaveHealthData('stepcount');
  } else {
   logger.i('=> stepcount null');
  }

  if(hartMap.isNotEmpty){
   await handleSaveHealthData('heartrate');
  } else {
   logger.i('=> heartrate null');
  }

  if(sleepMap.isNotEmpty){
   await handleSaveHealthData('sleeptime');
  } else {
   logger.i('=> sleeptime null');
  }
 }

 Map<String, dynamic> dioMap(String type) {
  Map<String, dynamic> toMap = {
   'os': Platform.isAndroid ? 'A' : 'I',
   'userID': Authorization().userID,
   'measureDate': previousDayDate,
   'rawData': type == 'stepcount' ? stepMap : type == 'sleeptime' ? sleepMap : hartMap
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
}