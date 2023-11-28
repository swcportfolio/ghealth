import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/services/health_service.dart';
import 'package:ghealth_app/utils/api_exception.dart';
import 'package:health/health.dart';
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

  bool requested = false;
  double heartRate = 0;
  DateTime? heartRateDate;

  /// 한번 초기화로 계속 사용할 수 있다.
  static final Health _healthInstance = Health.internal();

  factory Health(){
    return _healthInstance;
  }

  Health.internal() {
    healthDataList = [];
    // TODO useHealthConnectIfAvailable: true => 데이터가 없을시 화면에 NullPointerException 남!
    health = HealthFactory();

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
    final types = [HealthDataType.STEPS, HealthDataType.SLEEP_IN_BED, HealthDataType.HEART_RATE];  // define the types to get
    final permissions = [HealthDataAccess.READ, HealthDataAccess.READ, HealthDataAccess.READ];// with coresponsing permissions

    if(!requested){
      try {
        requested = await health.requestAuthorization(types, permissions: permissions); // needed, since we only want READ access.
        logger.d('[Health fetchData] => $requested');
      } catch (error) {
        logger.d('[Health fetchData] => Exception in authorize: $error');
        throw Exception('permissionsError');
      }
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
        List<HealthDataPoint> daySleep          = await health.getHealthDataFromTypes(today24Hour, now, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoDaySleep       = await health.getHealthDataFromTypes(agoDay, today24Hour, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoTwoDaySleep    = await health.getHealthDataFromTypes(agoTwoDay, agoDay, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoThreeDaySleep  = await health.getHealthDataFromTypes(agoThreeDay, agoTwoDay, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoFourthDaySleep = await health.getHealthDataFromTypes(agoFourthDay, agoThreeDay, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoFifthDaySleep  = await health.getHealthDataFromTypes(agoFifthDay, agoFourthDay, [HealthDataType.SLEEP_IN_BED]);
        List<HealthDataPoint> agoSixthDaySleep  = await health.getHealthDataFromTypes(agoSixthDay, agoFifthDay, [HealthDataType.SLEEP_IN_BED]);

        /// 심박동 가져오기
        List<HealthDataPoint> recentHeartRate  = await health.getHealthDataFromTypes(today24Hour, now, [HealthDataType.HEART_RATE]);
        recentHeartRate.sort((a, b) => b.dateFrom.compareTo(a.dateFrom));// 최신순으로 정렬
        if (recentHeartRate.isNotEmpty) {
          HealthDataPoint latestHeartRateData = recentHeartRate.first;

          heartRate = double.parse(latestHeartRateData.value.toString());
          heartRateDate = latestHeartRateData.dateFrom;

          logger.i('최근 심박동 데이터: $heartRate');
          logger.i('최근 심박동 데이터 dateFrom: ${latestHeartRateData.dateFrom.toString()}');
          logger.i('최근 심박동 데이터 dateTo: ${latestHeartRateData.dateTo.toString()}');
        } else {
          logger.e('심박동 데이터 없음');
        }

        return ChartHealthData(dayStep: dayStep, agoDayStep: agoDayStep, agoTwoDayStep: agoTwoDayStep,
                        agoThreeDayStep: agoThreeDayStep, agoFourthDayStep: agoFourthDayStep,
                        agoFifthStep:agoFifthStep, agoSixthStep:agoSixthStep,

            daySleep         : daySleep.isEmpty?          0 : double.parse(daySleep[0].value.toString()).toInt(),
            agoDaySleep      : agoDaySleep.isEmpty?       0 : double.parse(agoDaySleep[0].value.toString()).toInt(),
            agoTwoDaySleep   : agoTwoDaySleep.isEmpty?    0 : double.parse(agoTwoDaySleep[0].value.toString()).toInt(),
            agoThreeDaySleep : agoThreeDaySleep.isEmpty?  0 : double.parse(agoThreeDaySleep[0].value.toString()).toInt(),
            agoFourthDaySleep: agoFourthDaySleep.isEmpty? 0 : double.parse(agoFourthDaySleep[0].value.toString()).toInt(),
            agoFifthDaySleep : agoFifthDaySleep.isEmpty?  0 : double.parse(agoFifthDaySleep[0].value.toString()).toInt(),
            agoSixthDaySleep : agoSixthDaySleep.isEmpty?  0 : double.parse(agoSixthDaySleep[0].value.toString()).toInt(),
        );

      } catch (error) {
        throw ApiException('NotGranted');
        // logger.e("[Health fetchData] => Exception in getHealthDataFromTypes: $error");
        // CustomDialog.showMyDialog(
        //   title: '건강 데이터!',
        //   content: '데이터 접근 또는 계정이\n 승인되지 않았습니다.',
        //   mainContext: context,
        // );
        //
        //
        // return ChartHealthData(dayStep: 0, agoDayStep: 0, agoTwoDayStep: 0,
        //     agoThreeDayStep: 0, agoFourthDayStep: 0,
        //     agoFifthStep:0, agoSixthStep:0,
        //
        //     daySleep : 0, agoDaySleep : 0, agoTwoDaySleep : 0, agoThreeDaySleep: 0,
        //     agoFourthDaySleep : 0, agoFifthDaySleep: 0, agoSixthDaySleep: 0
        // );
      }
    }

    else {
      throw ApiException('NotGranted');
      // print("Authorization not granted!!");
      // CustomDialog.showMyDialog(
      //   title: '건강 데이터!',
      //   content: '데이터 접근 또는 계정이\n 승인되지 않았습니다.',
      //   mainContext: context,
      // );
      //
      // return ChartHealthData(dayStep: 0, agoDayStep: 0, agoTwoDayStep: 0,
      //     agoThreeDayStep: 0, agoFourthDayStep: 0,
      //     agoFifthStep:0, agoSixthStep:0,
      //
      //     daySleep : 0, agoDaySleep : 0, agoTwoDaySleep : 0, agoThreeDaySleep: 0,
      //     agoFourthDaySleep : 0, agoFifthDaySleep: 0, agoSixthDaySleep: 0
      // );
    }
  }

}
