
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/services/health_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/etc.dart';
import '../../utils/snackbar_utils.dart';
import '../../widgets/frame.dart';
import '../../widgets/health_circular_chart.dart';
import '../aihealth/health_point_box_widget.dart';
import '../login/login_view.dart';
import 'attendance_button_widget.dart';
import 'health_center_record_view.dart';
import 'myrecord_main_viewmodel.dart';

enum HealthDataType {
  sleep,
  step,
}

class MyRecordMainView extends StatefulWidget {
  const MyRecordMainView({super.key});

  @override
  State<MyRecordMainView> createState() => _MyRecordMainViewState();
}

class _MyRecordMainViewState extends State<MyRecordMainView> {
  late MyRecordMainViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MyRecordMainViewModel(
        context,
        Authorization().targetSleep,
        Authorization().targetStep,
        Authorization().isToDayAttendance);
  }

  @override
  Widget build(BuildContext context) {
    _viewModel.handleTotalPoint();

    /// AccessToken 확인
    Authorization().checkAuthToken().then((result) {
      if(!result){
        SnackBarUtils.showBGWhiteSnackBar(
            '권한 만료, 재 로그인 필요합니다.', context);
        Frame.doPagePush(context, const LoginView());
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (BuildContext context) => _viewModel,
        child: FutureBuilder(
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
                return Frame.buildFutureBuilderHasError(snapshot.error.toString(), () => {});
              }
            }
            else if(snapshot.connectionState == ConnectionState.waiting) {
              return Frame.buildFutureBuildProgressIndicator();
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    buildTopPhraseWidget(),

                    /// 포인트 위젯
                    Consumer<MyRecordMainViewModel>(
                        builder: (BuildContext context, value, Widget? child) {
                      return HealthPointBoxWidget(totalPoint: value.totalPoint, isOnTap: true,);
                    }),

                    /// 출석 체크 버튼
                    // Consumer<MyRecordMainViewModel>(
                    //     builder: (BuildContext context, value, Widget? child) {
                    //       return AttendanceButtonWidget(viewModel: value, isAttendance: value.isAttendance);
                    //     }),

                    /// 라이프로그 검사 결과 자세히 보기 (전신 그림)
                     const HealthCenterRecordView(),

                    buildWearableCharts(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 앱 상단 메시지 표시 위젯
  Widget buildTopPhraseWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Frame.myText(
                  text: '${Authorization().userName}님의 ',
                  fontSize: 1.7,
                  fontWeight: FontWeight.bold
              ),
              Frame.myText(
                text: '일상 기록',
                fontSize: 1.7,
                fontWeight: FontWeight.bold,
                color: mainColor,
              )
            ],
          ),
          const Gap(5),
          Frame.myText(
              text: '계측검사 • 수면 • 걸음 수 • 심박수에 대한\n정보를 제공합니다.',
              maxLinesCount: 2
          ),
        ],
      ),
    );
  }

  /// 최근 심박수 표시 박스 위젯
  Widget buildHartRateBox(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
    );
  }

  /// 웨어러블(걷기, 수면) 차트 윗젯
  Widget buildWearableCharts() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 2.0, color: Colors.grey.shade200)),
                child: Consumer<MyRecordMainViewModel>(
                  builder: (BuildContext context, value, Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 웨어러블 박스 상단 타이틀
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Frame.myText(
                              text: '${Authorization().userName}님의 웨어러블',
                              fontSize: 1.3,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        /// 걸음 수 진행 위젯
                        HealthCircularChart(
                          mainValue: HealthService().dayStep.toString(),
                          targetValue: value.targetStep,
                          type: HealthDataType.step,
                          function: (type)=> _viewModel.showCustomDialog(type),
                          chartData: [ChartData2('B', Etc.calculateAchievementRate(HealthService().dayStep ?? 0, int.parse(value.targetStep)))],
                        ),

                        /// 실시간 걸음 랭킹
                        // buildRealTimeStepRanking(),

                        Etc.solidLineWearableBox(context),

                        /// 수면 시간 진행 위젯
                        HealthCircularChart(
                          mainValue:'${(HealthService().toDayTotalSleep ?? 0) ~/ 60}시간',
                          targetValue: value.targetSleep,
                          type: HealthDataType.sleep,
                          function: (type)=> _viewModel.showCustomDialog(type),
                          chartData: [ChartData2('A', Etc.calculateAchievementRate((HealthService().toDayTotalSleep ?? 0) ~/ 60, int.parse(value.targetSleep)))],
                        ),

                        Etc.solidLineWearableBox(context),

                        buildHartRateBox(),
                      ],
                    );
                  },
                )
            )
        )
    );
  }

  /// 신규 걷기 랭킹 위젯
  Widget buildRealTimeStepRanking(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Frame.myText(
            text: '실시간 걸음 랭킹',
            fontSize: 1.2,
          ),
        ),
        const Gap(10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildStepChartBarItem(
                  barColor: Colors.green.shade300,
                  stepText: '6000보',
                  rankingText: '1',
                  height: 140),
              buildStepChartBarItem(
                  barColor: Colors.green,
                  stepText: '5500보',
                  rankingText: '2',
                  height: 120),
              buildStepChartBarItem(
                  barColor: Colors.green.shade300,
                  stepText: '3123보',
                  rankingText: '3',
                  height: 100),
              buildStepChartBarItem(
                  barColor: Colors.green,
                  stepText: '2000보',
                  rankingText: '4',
                  height: 80),
              buildStepChartBarItem(
                  barColor: Colors.green.shade300,
                  stepText: '1000보',
                  rankingText: '5',
                  height: 60),
            ],
          ),
        ),

        Container(
          height: 60,
          margin: const EdgeInsets.all(25.0),
          color: Colors.grey.shade200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Frame.myText(
                    text:'${Authorization().userName}은 현재'
                  ),
                  Frame.myText(
                      text:'2순위',
                      fontWeight: FontWeight.bold
                  ),
                ],
              ),
              Frame.myText(
                  text:'조금 더 열심히 걸어주세요!',
              ),
            ],
          ),
        )
      ],
    );
  }

  /// 랭킹 차트 아이템 위젯
  Widget buildStepChartBarItem({
    required Color barColor,
    required String stepText,
    required String rankingText,
    required double height})
  {
    return Expanded(
      flex: 1,
      child: Container(
        height: height,
        color: barColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Frame.myText(text: stepText, color: Colors.white, fontWeight: FontWeight.w500, fontSize: 0.85),
            ),
            Frame.myText(text: rankingText, color: Colors.white, fontWeight: FontWeight.w500)
          ],
        ),
      ),
    );
  }
}



