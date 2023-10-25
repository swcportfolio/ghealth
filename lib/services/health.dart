
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import '../data/models/chart_health_data.dart';
import '../main.dart';
import '../widgets/dialog.dart';


/// Load health data class
/// Health API usage
/// IOS : 건강앱, Android: Google 피트니스 엑세스
/// Access data from 7 days ago.
class Health {

  late List<HealthDataPoint> healthDataList;
  late HealthFactory health;

  late DateTime now;
  late DateTime today24Hour;
  late DateTime agoDay;
  late DateTime agoTwoDay;
  late DateTime agoThreeDay;
  late DateTime agoFourthDay;
  late DateTime agoFifthDay;
  late DateTime agoSixthDay;

  /// 한번 초기화로 계속 사용할 수 있다.
  static final Health _healthInstance = Health.internal();

  factory Health(){
    return _healthInstance;
  }

  Health.internal() {
    healthDataList = [];
    // TODO useHealthConnectIfAvailable: true => 데이터가 없을시 화면에 NullPointerException 남!
    health = HealthFactory(useHealthConnectIfAvailable: true);

    now          = DateTime.now();               // 측정 현재 시간
    today24Hour  = DateTime(now.year, now.month, now.day, 0, 0);  // 오늘
    agoDay       = DateTime(now.subtract(const Duration(days: 1)).year, now.subtract(const Duration(days: 1)).month, now.subtract(Duration(days: 1)).day, 0, 0);  // 1일전
    agoTwoDay    = DateTime(now.subtract(const Duration(days: 2)).year, now.subtract(const Duration(days: 2)).month, now.subtract(Duration(days: 2)).day, 0, 0);  // 2일전
    agoThreeDay  = DateTime(now.subtract(const Duration(days: 3)).year, now.subtract(const Duration(days: 3)).month, now.subtract(Duration(days: 3)).day, 0, 0);  // 3일전
    agoFourthDay = DateTime(now.subtract(const Duration(days: 4)).year, now.subtract(const Duration(days: 4)).month, now.subtract(Duration(days: 4)).day, 0, 0);  // 4일전
    agoFifthDay  = DateTime(now.subtract(const Duration(days: 5)).year, now.subtract(const Duration(days: 5)).month, now.subtract(Duration(days: 5)).day, 0, 0);  // 5일전
    agoSixthDay  = DateTime(now.subtract(const Duration(days: 6)).year, now.subtract(const Duration(days: 6)).month, now.subtract(Duration(days: 6)).day, 0, 0);  // 6일전
  }


  /// Fetch Step, Sleep data
  Future<ChartHealthData> fetchData(BuildContext context) async
  {
    final types = [HealthDataType.STEPS, HealthDataType.SLEEP_SESSION];  // define the types to get
    final permissions = [HealthDataAccess.READ, HealthDataAccess.READ];// with coresponsing permissions
    bool requested = false;
    try {
     requested = await health.requestAuthorization([HealthDataType.SLEEP_LIGHT, HealthDataType.SLEEP_SESSION], permissions: [HealthDataAccess.READ, HealthDataAccess.READ]); // needed, since we only want READ access.
      mLog.d('[ChartHealthData requested]  $requested');
    } catch (error) {
      print("Exception in authorize: $error");
    }

    if (requested){
      try {
        /// 일주일 걸음 수 가져오기
        int? dayStep           = await health.getTotalStepsInInterval(today24Hour, now) ?? 0;
        int? agoDayStep        = await health.getTotalStepsInInterval(agoDay, today24Hour)?? 0;
        int? agoTwoDayStep     = await health.getTotalStepsInInterval(agoTwoDay, agoDay)?? 0;
        int? agoThreeDayStep   = await health.getTotalStepsInInterval(agoThreeDay, agoTwoDay)?? 0;
        int? agoFourthDayStep  = await health.getTotalStepsInInterval(agoFourthDay, agoThreeDay)?? 0;
        int? agoFifthStep      = await health.getTotalStepsInInterval(agoFifthDay, agoFourthDay)?? 0;
        int? agoSixthStep      = await health.getTotalStepsInInterval(agoSixthDay, agoFifthDay)?? 0;


        /// 일주일 수면시간 가져오기
        List<HealthDataPoint> daySleep          = await health.getHealthDataFromTypes(today24Hour, now, [HealthDataType.SLEEP_SESSION]);
        List<HealthDataPoint> agoDaySleep       = await health.getHealthDataFromTypes(agoDay, today24Hour, [HealthDataType.SLEEP_SESSION]);
        List<HealthDataPoint> agoTwoDaySleep    = await health.getHealthDataFromTypes(agoTwoDay, agoDay, [HealthDataType.SLEEP_SESSION]);
        List<HealthDataPoint> agoThreeDaySleep  = await health.getHealthDataFromTypes(agoThreeDay, agoTwoDay, [HealthDataType.SLEEP_SESSION]);
        List<HealthDataPoint> agoFourthDaySleep = await health.getHealthDataFromTypes(agoFourthDay, agoThreeDay, [HealthDataType.SLEEP_SESSION]);
        List<HealthDataPoint> agoFifthDaySleep  = await health.getHealthDataFromTypes(agoFifthDay, agoFourthDay, [HealthDataType.SLEEP_SESSION]);
        List<HealthDataPoint> agoSixthDaySleep  = await health.getHealthDataFromTypes(agoSixthDay, agoFifthDay, [HealthDataType.SLEEP_SESSION]);


        mLog.i('daySleep: ${daySleep[0].value}');
        mLog.i('daySleep: ${daySleep}');

        return ChartHealthData(dayStep: dayStep, agoDayStep: agoDayStep, agoTwoDayStep: agoTwoDayStep,
                        agoThreeDayStep: agoThreeDayStep, agoFourthDayStep: agoFourthDayStep,
                        agoFifthStep:agoFifthStep, agoSixthStep:agoSixthStep,

            daySleep         : daySleep.isEmpty?          0 : int.parse(daySleep[0].value.toString()),
            agoDaySleep      : agoDaySleep.isEmpty?       0 : int.parse(agoDaySleep[0].value.toString()),
            agoTwoDaySleep   : agoTwoDaySleep.isEmpty?    0 : int.parse(agoTwoDaySleep[0].value.toString()),
            agoThreeDaySleep : agoThreeDaySleep.isEmpty?  0 : int.parse(agoThreeDaySleep[0].value.toString()),
            agoFourthDaySleep: agoFourthDaySleep.isEmpty? 0 : int.parse(agoFourthDaySleep[0].value.toString()),
            agoFifthDaySleep : agoFifthDaySleep.isEmpty?  0 : int.parse(agoFifthDaySleep[0].value.toString()),
            agoSixthDaySleep : agoSixthDaySleep.isEmpty?  0 : int.parse(agoSixthDaySleep[0].value.toString()),
        );

      } catch (error) {
        mLog.e("Exception in getHealthDataFromTypes: $error");
        CustomDialog.showMyDialog(
          title: '건강 데이터!',
          content: '데이터 접근 또는 계정이\n 승인되지 않았습니다.',
          mainContext: context,
        );


        return ChartHealthData(dayStep: 0, agoDayStep: 0, agoTwoDayStep: 0,
            agoThreeDayStep: 0, agoFourthDayStep: 0,
            agoFifthStep:0, agoSixthStep:0,

            daySleep : 0, agoDaySleep : 0, agoTwoDaySleep : 0, agoThreeDaySleep: 0,
            agoFourthDaySleep : 0, agoFifthDaySleep: 0, agoSixthDaySleep: 0
        );
      }
    }

    else {
      print("Authorization not granted!!");
      CustomDialog.showMyDialog(
        title: '건강 데이터!',
        content: '데이터 접근 또는 계정이\n 승인되지 않았습니다.',
        mainContext: context,
      );

      return ChartHealthData(dayStep: 0, agoDayStep: 0, agoTwoDayStep: 0,
          agoThreeDayStep: 0, agoFourthDayStep: 0,
          agoFifthStep:0, agoSixthStep:0,

          daySleep : 0, agoDaySleep : 0, agoTwoDaySleep : 0, agoThreeDaySleep: 0,
          agoFourthDaySleep : 0, agoFifthDaySleep: 0, agoSixthDaySleep: 0
      );
    }
  }
}
