import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../data/models/metrology_inspection.dart';
import '../../utils/colors.dart';
import '../../widgets/frame.dart';

class MetrologyInspectionWidget extends StatelessWidget {
  const MetrologyInspectionWidget(
      {super.key, required this.metrologyInspection});

  /// 계측검사 결과 데이터 클래스
  final MetrologyInspection metrologyInspection;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 610,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 검진 날짜 Text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Frame.myText(
                      text: '계측 검사',
                      color: Colors.black,
                      fontSize: 1.2,
                      fontWeight: FontWeight.w600),

                  /// 검진 날짜
                  Frame.myText(
                    text: '검진일 : ${metrologyInspection.issuedDate}',
                    fontSize: 0.9,
                  )
                ],
              ),

              /// 사람 이미지
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'images/body_image.png',
                  height: 460,
                  width: 180,
                ),
              ),
              const Gap(15),

              Frame.myText(
                  text: '클릭하시면 자세한 결과를 보실수 있습니다.',
                  color: Colors.grey.shade600,
                  fontSize: 1.1),
            ],
          ),
        ),

        /// 각 항목 Positioned Container
        buildMeasurementResultPositionedItem(
            40, 80, null, null, '${metrologyInspection.vision}', '시력(좌/우)'),
        buildMeasurementResultPositionedItem(
            20, 200, null, null, '${metrologyInspection.bloodPressure}', '혈압'),
        buildMeasurementResultPositionedItem(
            30, 360, null, null, '${metrologyInspection.weight}', '몸무게'),
        buildMeasurementResultPositionedItem(
            35, 460, null, null, '${metrologyInspection.height}', '키'),
        buildMeasurementResultPositionedItem(
            null, 83, 50, null, '${metrologyInspection.hearingAbility}', '청력(좌/우)'),
        buildMeasurementResultPositionedItem(
            null, 205, 40, null, '${metrologyInspection.waistCircumference}', '허리둘레'),
        buildMeasurementResultPositionedItem(
            null, 335, 25, null, '${metrologyInspection.bodyMassIndex}', '체질량지수'),
      ],
    );
  }

  /// 계측검사 검사 결과 Positioned item
  Widget buildMeasurementResultPositionedItem(double? left, double? top,
      double? right, double? bottom, String resultText, String resultLabel) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Column(
        children: [
          /// 검사 결과 박스
          Container(
            height: 35,
            width: 80,
            decoration: BoxDecoration(
                color: metrologyInspectionBgColor,
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(width: 1, color: Colors.blueAccent)),
            child: Center(
              child: Frame.myText(
                  text: resultText,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
          ),
          const Gap(5),

          /// 측정 항목명 텍스트
          Frame.myText(text: resultLabel, fontSize: 1.0)
        ],
      ),
    );
  }
}
