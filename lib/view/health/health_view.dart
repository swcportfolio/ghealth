
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/chart_data.dart';
import '../../data/models/chart_health_data.dart';
import '../../services/health.dart';
import '../../utils/colors.dart';
import '../../widgets/bar_chart.dart';
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

  /// Chat data class
  late ChartHealthData? chartHealthData;

  /// 건강데이터 메인화면 로드시 한번만 전송하게 된다.
  bool isRunOnce = true;

  /// chart ui elements Map<String, dynamic> list
  List<Map<String, dynamic>> chartWidgetElements = [
    {
      'image'     : 'images/sleeping.png',
      'headText'  : '수면 패턴',
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildAppTopMessage(),

            /// 수면 시간 진행 위젯
            const HealthCircularChart(
              mainValue: '5시간',
              targetValue: '7시간',
              type: HealthDataType.sleep,
            ),

            /// 걸음 수 진행 위젯
            const HealthCircularChart(
              mainValue: '2341',
              targetValue: '6000',
              type: HealthDataType.step,
            ),

            // Expanded(
            //   child: FutureBuilder(
            //     /// The steps and sleep time are called through Health().
            //     future: Health().fetchData(context),
            //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //
            //       if(snapshot.hasError){
            //         return Center(
            //             child: Text(snapshot.error.toString().replaceFirst('Exception: ', ''),
            //                 textScaleFactor: 1.1, style: const TextStyle(color: Colors.black)));
            //       }
            //
            //       if (!snapshot.hasData) {
            //         return const Center(
            //             child: SizedBox(height: 40.0, width: 40.0,
            //                 child: CircularProgressIndicator(strokeWidth: 5)));
            //       }
            //
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         chartHealthData = snapshot.data;
            //
            //         chartHealthData?.initStepChartData();  // 걸음수 차트 데이터 초기화
            //         chartHealthData?.initSleepChartData(); // 수면시간 차트 데이터 초기화
            //
            //         if(isRunOnce){
            //           isRunOnce = false;
            //           //_insertHealthData();
            //         }
            //       }
            //
            //       return chartHealthData == null ? buildEmptyView('건강 데이터가 없습니다.') :
            //
            //       SingleChildScrollView(
            //         child: Container(
            //           padding: const EdgeInsets.all(15),
            //           child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children:
            //               [
            //
            //                 /// 수면 차트
            //                 buildChart(0, chartHealthData!.chartSleepData),
            //
            //                 const Gap(10),
            //
            //                 /// 걸음 수 차트
            //                 buildChart(1, chartHealthData!.chartStepData),
            //               ]
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
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

  /// 차트 widget
  Widget buildChart(int index, List<ChartData> chartData) {
    return Container(
        height: 380,
        child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    children:
                    [
                      Image.asset(chartWidgetElements[index]['image']!, height: 25, width: 25),
                      const Gap(10),
                      Frame.myText(text: chartWidgetElements[index]['headText']!, fontSize: 1.3, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                    ],
                  ),
                ),

                SizedBox(
                    height: 300,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                        child: BarChart().buildColumnSeriesChart(
                            chartData: chartData,
                            chartColor: chartWidgetElements[index]['color']!,
                            chartType: chartWidgetElements[index]['chartType']!))
                ),
              ],
            )
        )
    );
  }

  /// 앱 상단 메시지 표시
  buildAppTopMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20),
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
          Frame.myText(
            text: '수면패턴과 걸음 수에 대한 정보를 제공합니다.',
          ),
        ],
      ),
    );
  }
}
