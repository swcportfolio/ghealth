
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/enum/lifelog_data_type.dart';
import '../../widgets/frame.dart';
import 'lifelog_bottom_sheet_view.dart';

class TestResultsBodyWidget extends StatefulWidget {
  const TestResultsBodyWidget({super.key});

  @override
  State<TestResultsBodyWidget> createState() => _TestResultsBodyWidgetState();
}

class _TestResultsBodyWidgetState extends State<TestResultsBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Frame.myText(
              text: '검사결과 자세히 보기',
              fontWeight: FontWeight.bold,
              fontSize: 1.5
          ),
          const Gap(10),

          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 580,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Frame.myText(
                        text: '클릭하시면 자세한 결과를 보실수 있습니다.',
                        color: Colors.grey.shade600,
                        fontSize: 1.0
                    ),
                    const Gap(15),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset('images/person_body.png', height: 460, width: 180,),
                    )
                  ],
                ),
              ),

              buildPositionedBox(50, 60, null, '시력 측정기', LifeLogDataType.eye),
              buildPositionedBox(10, 150, null, '혈압 측정기', LifeLogDataType.bloodPressure),
              buildPositionedBox(10, 200, null, '혈당 측정', LifeLogDataType.bloodSugar),
              buildPositionedBox(10, 360, null, '키 몸무게 측정기', LifeLogDataType.heightWeight),
              buildPositionedBox(30, 410, null, '체성분 분석기', LifeLogDataType.bodyComposition),

              buildPositionedBox(null, 80, 20, '두뇌건강 측정기', LifeLogDataType.brains),
              buildPositionedBox(null, 130, 20, '치매선별 검사기', LifeLogDataType.dementia),

              buildPositionedBox(null, 180, 20, '뇌파측정기', LifeLogDataType.brainWaves),
              buildPositionedBox(null, 300, 20, '소변 검사기', LifeLogDataType.pee),
              buildPositionedBox(null, 480, 20, '초음파 골밀도 측정기', LifeLogDataType.boneDensity),
            ],
          )
        ],
      ),
    );
  }

  Positioned buildPositionedBox(
      double? left, double? top, double? right,
      String label, LifeLogDataType type) {
    return Positioned(
        left: left,
        top: top,
        right: right,
        bottom: null,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return LifeLogBottomSheetView(healthReportType: type);
                });
          },
          child: Container(
            decoration: BoxDecoration(
              color: metrologyInspectionBgColor,
              border: Border.all(width: 1.5, color: mainColor),
              borderRadius: BorderRadius.circular(30),
            ),

            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                    text: label,
                    color: mainColor,
                    fontSize: 0.95,
                    fontWeight: FontWeight.w600),
              ],
            ),
          ),
        ));
  }
}
