import '../../utils/etc.dart';
import 'chart_data.dart';

/// Chart data Class
/// TODO: userID 수정해야됨
class ChartHealthData{

  // 수면
  int? daySleep = 0;
  int? agoDaySleep = 0;
  int? agoTwoDaySleep = 0;
  int? agoThreeDaySleep = 0;
  int? agoFourthDaySleep = 0;
  int? agoFifthDaySleep = 0;
  int? agoSixthDaySleep = 0;
  late List<ChartData> chartSleepData;

  // 걸음 수
  int? dayStep;
  int? agoDayStep;
  int? agoTwoDayStep;
  int? agoThreeDayStep;
  int? agoFourthDayStep;
  int? agoFifthStep;
  int? agoSixthStep;
  late List<ChartData> chartStepData;


  @override
  String toString() {
    return 'ChartHealthData{daySleep: $daySleep, agoDaySleep: $agoDaySleep, agoTwoDaySleep: $agoTwoDaySleep, agoThreeDaySleep: $agoThreeDaySleep, agoFourthDaySleep: $agoFourthDaySleep, agoFifthDaySleep: $agoFifthDaySleep, agoSixthDaySleep: $agoSixthDaySleep, chartSleepData: $chartSleepData, dayStep: $dayStep, agoDayStep: $agoDayStep, agoTwoDayStep: $agoTwoDayStep, agoThreeDayStep: $agoThreeDayStep, agoFourthDayStep: $agoFourthDayStep, agoFifthStep: $agoFifthStep, agoSixthStep: $agoSixthStep, chartStepData: $chartStepData}';
  }

  ChartHealthData(
      {this.daySleep,
      this.agoDaySleep,
      this.agoTwoDaySleep,
      this.agoThreeDaySleep,
      this.agoFourthDaySleep,
      this.agoFifthDaySleep,
      this.agoSixthDaySleep,

      this.dayStep,
      this.agoDayStep,
      this.agoTwoDayStep,
      this.agoThreeDayStep,
      this.agoFourthDayStep,
      this.agoFifthStep,
      this.agoSixthStep});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> toMap = {
      'userID': 'Authorization().userID',
      'daySleep': daySleep,
      'agoDaySleep': agoDaySleep,
      'agoTwoDaySleep': agoTwoDaySleep,
      'agoThreeDaySleep': agoThreeDaySleep,
      'agoFourthDaySleep': agoFourthDaySleep,
      'agoFifthDaySleep': agoFifthDaySleep,
      'agoSixthDaySleep': agoSixthDaySleep,
      'dayStep': dayStep,
      'agoDayStep': agoDayStep,
      'agoTwoDayStep': agoTwoDayStep,
      'agoThreeDayStep': agoThreeDayStep,
      'agoFourthDayStep': agoFourthDayStep,
      'agoFifthStep': agoFifthStep,
      'agoSixthStep': agoSixthStep,
    };
    return toMap;
  }

  /// 수집된 걸음 수 [chartStepData] 초기화
  initStepChartData(){
    chartStepData = <ChartData> [
      ChartData(
        x: Etc.setDateTime(0),
        y: int.parse(dayStep.toString()),
        yValue: 40,
      ),
      ChartData(
        x: Etc.setDateTime(1),
        y: int.parse(agoDayStep.toString()),
        yValue: 40,
      ),
      ChartData(
        x: Etc.setDateTime(2),
        y: int.parse(agoTwoDayStep.toString()),
        yValue: 40,
      ),
      ChartData(
        x: Etc.setDateTime(3),
        y: int.parse(agoThreeDayStep.toString()),
        yValue: 45,
      ),
      ChartData(
        x: Etc.setDateTime(4),
        y: int.parse(agoFourthDayStep.toString()),
        yValue: 23,
      ),
      ChartData(
          x: Etc.setDateTime(5),
          y: int.parse(agoFifthStep.toString()),
          yValue: 18),
      ChartData(
          x:Etc.setDateTime(6),
          y: int.parse(agoSixthStep.toString()),
          yValue: 18),
    ];
  }

  /// 수집된 수면데이터 [chartSleepData] 초기화
  initSleepChartData(){
    chartSleepData = <ChartData> [
      ChartData(
        x: Etc.setDateTime(0),
        y: int.parse(daySleep.toString()),
        yValue: 40,
      ),
      ChartData(
        x: Etc.setDateTime(1),
        y: int.parse(agoDaySleep.toString()),
        yValue: 40,
      ),
      ChartData(
        x: Etc.setDateTime(2),
        y: int.parse(agoTwoDaySleep.toString()),
        yValue: 40,
      ),
      ChartData(
        x: Etc.setDateTime(3),
        y: int.parse(agoThreeDaySleep.toString()),
        yValue: 45,
      ),
      ChartData(
        x: Etc.setDateTime(4),
        y: int.parse(agoFourthDaySleep.toString()),
        yValue: 23,
      ),
      ChartData(
          x: Etc.setDateTime(5),
          y: int.parse(agoFifthDaySleep.toString()),
          yValue: 18),
      ChartData(
          x:Etc.setDateTime(6),
          y: int.parse(agoSixthDaySleep.toString()),
          yValue: 18),
    ];
  }

}