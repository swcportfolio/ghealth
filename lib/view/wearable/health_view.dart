
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/services/health_service.dart';
import 'package:ghealth_app/view/wearable/health_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/picker_data.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_picker.dart';
import '../../widgets/frame.dart';
import '../../widgets/health_circular_chart.dart';

enum HealthDataType  {
  sleep,
  step,
}

class HealthView extends StatefulWidget {
  const HealthView({super.key});

  @override
  State<HealthView> createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> {
  late HealthViewModel _viewModel;



  /// 건강데이터 메인화면 로드시 한번만 전송하게 된다.
  bool isRunOnce = true;


  String targetSleep = Authorization().targetSleep;
  String targetStep = Authorization().targetStep;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = HealthViewModel(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: HealthService().fetchToDayData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            if(snapshot.error.toString().contains('NotGranted')){
              return Frame.showMessageHealthErrorScreen('건강 데이터 접근 또는\n계정이 승인되지 않았습니다.', () =>
                HealthService().requestPermission().then((required){
                  if(required) setState(() {});
                }));
            } else if(snapshot.error.toString().contains('permissionsError')){
              return Frame.showMessageHealthErrorScreen('건강 데이터(걸음, 수면, 심박)\n 접근을 허용해주세요.', () =>
                  HealthService().requestPermission().then((required){
                    if(required) setState(() {});
                  }));
            } else {
              return Frame.buildFutureBuilderHasError(
                  snapshot.error.toString(), () => {});
            }

          }
          else if(snapshot.connectionState == ConnectionState.waiting) {
            return Frame.buildFutureBuildProgressIndicator();
          }
            return  SingleChildScrollView(
              child: Column(
                children: [
                  buildAppTopMessage(),

                  /// 수면 시간 진행 위젯
                   HealthCircularChart(
                    mainValue:'${(HealthService().toDayTotalSleep ?? 0) ~/ 60}시간',
                    targetValue: targetSleep,
                    type: HealthDataType.sleep,
                    function: (type)=> showCustomDialog(type),
                     chartData: [ChartData2('A', calculateAchievementRate((HealthService().toDayTotalSleep ?? 0) ~/ 60, int.parse(targetSleep)))],
                  ),

                  /// 걸음 수 진행 위젯
                   HealthCircularChart(
                    mainValue: HealthService().dayStep.toString() ?? '0',
                    targetValue: targetStep,
                    type: HealthDataType.step,
                    function: (type)=> showCustomDialog(type),
                     chartData: [ChartData2('B', calculateAchievementRate(HealthService().dayStep ?? 0, int.parse(targetStep)))],
                  ),

                  buildHartRateBox()
                ],
              ),
            );
        },
      ),
    );
  }

  /// 달성률 계산
  calculateAchievementRate(int value, int target){
    if (target == 0 || value == 0) {
     return 0.0;
    }

    if (value > target) {
      return 100.0;
    }

    // 달성률 계산
    double rate = (value / target) * 100;
    return rate;
  }

  showCustomDialog(HealthDataType type){
    CustomPicker().showBottomSheet(
        PickerData(19, type == HealthDataType.sleep ? Constants.targetSleepList: Constants.targetStepsList, context,
                (callbackData)=> onGetPickerData(callbackData)));
  }

  /// Number picker Function callback
  /// @param callbackData : 반환 값
  onGetPickerData(callbackData) {
    setState(() {
      int getPickerData = int.parse(callbackData.toString());
      if(getPickerData<1000){ // 수면시간
        targetSleep = getPickerData.toString();
        Authorization().targetSleep = targetSleep;
        setStringData('targetSleep', targetSleep);
      } else { // 걸음수
        targetStep = getPickerData.toString();
        Authorization().targetStep = targetStep;
        setStringData('targetStep', targetStep);
      }
      logger.i(getPickerData.toString());
    });
  }

  void setStringData(String key , String data) async{
    var pref = await SharedPreferences.getInstance();
    pref.setString(key,data);
  }

  /// 최근 심박수 표시 박스 위젯
  Widget buildHartRateBox(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20,20,20,10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(width: 2.0, color: Colors.grey.shade200)),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.monitor_heart_outlined, color: Colors.redAccent),
                  const Gap(10),
                  Frame.myText(
                      text: '심박수',
                      fontSize: 1.3,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(10),
                  Image.asset('images/heart_rate.png', height: 100, width: 100,),
                  const Gap(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Frame.myText(
                        text: HealthService().heartRate.toInt().toString(),
                        fontSize: 1.8,
                        fontWeight: FontWeight.w500,
                      ),
                      Frame.myText(
                        text: 'BPM',
                        fontSize: 1.6,
                        fontWeight: FontWeight.w500,
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                  const Gap(50),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Frame.myText(
                          text:'측정 일시',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 1.0
                      ),
                      Frame.myText(
                        text: HealthService().heartRateDate == null
                            ? '-'
                            : DateFormat('yyyy-MM-dd\nHH:mm').format(HealthService().heartRateDate!),
                        softWrap: true,
                        align: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        fontSize: 1.1,
                        maxLinesCount: 2
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Health Empty View
  Widget buildEmptyView(String text) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.question_mark, size: 40),
          const Gap(20),
          Frame.myText(
              text: text,
              fontSize: 1.3,
              color: mainColor,
              fontWeight: FontWeight.w600),
        ],
      ),
    );
  }

  /// 앱 상단 메시지 표시 위젯
 Widget buildAppTopMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Frame.myText(
                  text: '홍길동님의 ',
                  fontSize: 1.7,
                  fontWeight: FontWeight.bold
              ),
              Frame.myText(
                text: '웨어러블',
                fontSize: 1.7,
                fontWeight: FontWeight.bold,
                color: mainColor,
              )
            ],
          ),
          const Gap(5),
          Frame.myText(
            text: '수면, 걸음 수, 심박수에 대한 정보를 제공합니다.',
            maxLinesCount: 2
          ),
        ],
      ),
    );
  }
}



