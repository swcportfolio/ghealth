import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/services/health_service.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';

import '../../data/models/week_chart_data.dart';
import '../../utils/colors.dart';
import '../../utils/etc.dart';
import '../../widgets/bar_chart.dart';
import '../../widgets/frame.dart';
import '../login/login_view.dart';
import 'myrecord_main_view.dart';

/// 일주일 기록된 걷기, 수면 데이터를 보여주는 View
/// [HealthDataType]에 따라 걷기, 수면 오늘 기준 일주일 데이터를 보여준다.
class WearableWeekChartView extends StatefulWidget {
  const WearableWeekChartView({super.key, required this.type});

  final HealthDataType type;

  @override
  State<WearableWeekChartView> createState() => _WearableWeekChartViewState();
}

class _WearableWeekChartViewState extends State<WearableWeekChartView> {

  /// chart ui elements Map<String, dynamic> list
 final List<Map<String, dynamic>> chartWidgetElements = [
    {
      'image'     : 'images/sleeping.png',
      'headText'  : '수면',
      'chartType' : 'sleep',
      'color'     : sleepChartColor
    },
    {
      'image'     : 'images/footstep.png',
      'headText'  : '걸음 수',
      'chartType' : 'step',
      'color'     : stepChartColor
    }
  ];

  @override
  Widget build(BuildContext context) {

    /// AccessToken 확인
    Authorization().checkAuthToken().then((result) {
      if(!result){
        Etc.commonSnackBar('권한 만료, 재 로그인 필요합니다.', context, seconds: 6);
        Frame.doPagePush(context, const LoginView());
      }
    });


    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const CustomAppBar(title: '주간 현황', isIconBtn: false),

      body: FutureBuilder(
        /// The steps and sleep time are called through Health().
        future: HealthService().fetchOneWeekData(),
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

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppTopMessage(),
                const Gap(5),

                Container(
                  padding: const EdgeInsets.all(15),
                  child: widget.type == HealthDataType.sleep
                    ? buildChart(0, HealthService().chartSleepData)
                    : buildChart(1, HealthService().chartStepData),
                ),

                /// 부연 설명 Widget
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Frame.myText(
                          text: '• 1주일 간의 기록된 건강데이터를 차트로 제공됩니다.',
                          maxLinesCount: 2,
                          color: Colors.grey
                      ),
                      const Gap(5),
                      Frame.myText(
                          text: '• 0시 기준으로 데이터가 나눠집니다.',
                          maxLinesCount: 2,
                          color: Colors.grey
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  /// 차트 widget
  Widget buildChart(int index, List<WeekChartData> chartData) {
    return Card(
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Container(
          height: 480,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 2.0, color: Colors.grey.shade200)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children: [
                      Image.asset(chartWidgetElements[index]['image']!,
                          height: 25, width: 25),
                      const Gap(10),
                      Frame.myText(
                          text:
                              '${chartWidgetElements[index]['headText']!} 주간 현황',
                          fontSize: 1.3,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600),
                    ],
                  ),
                ),
                SizedBox(
                    height: 390,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                        child: BarChart().buildColumnSeriesChart(
                            chartData: chartData,
                            chartColor: chartWidgetElements[index]['color']!,
                            chartType: chartWidgetElements[index]['chartType']!
                        ))
                ),
              ],
            )));
  }

  /// Health Empty View
  Widget buildEmptyView(String text) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          const Icon(Icons.question_mark, size: 40),
          const SizedBox(height: 20),
          Frame.myText(text: text, fontSize: 1.3, color: mainColor, fontWeight: FontWeight.w600),
        ],
      ),
    );
  }

  /// 앱 상단 메시지 표시
  buildAppTopMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Frame.myText(
              text: '${Authorization().userName}님의 ',
              fontSize: 1.7,
              fontWeight: FontWeight.bold
          ),
          Frame.myText(
            text: '웨어러블 주간 현황',
            fontSize: 1.7,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
        ],
      ),
    );
  }
}
