import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../data/models/metrology_inspection.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/frame.dart';
import 'bottom_sheet/mydata_bottom_sheet_view.dart';

/// 계측 검사 위젯
class MetrologyInspectionWidget extends StatefulWidget {
  const MetrologyInspectionWidget(
      {super.key, required this.metrologyInspection});

  /// 계측검사 결과 데이터 클래스
  final MetrologyInspection metrologyInspection;

  @override
  State<MetrologyInspectionWidget> createState() => _MetrologyInspectionWidgetState();
}

class _MetrologyInspectionWidgetState extends State<MetrologyInspectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Stack(
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
                        fontSize: 1.2,
                        fontWeight: FontWeight.w600),

                    /// 검진 날짜
                    Frame.myText(
                      text: '최근 검진일 : ${widget.metrologyInspection.issuedDate}',
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
              40, 80, null, null,
              '${widget.metrologyInspection.visionOld == '-'
                  ? (widget.metrologyInspection.visionLeft == '-'
                    ? '-'
                    : '${widget.metrologyInspection.visionLeft}/${widget.metrologyInspection.visionRight}')
                  : widget.metrologyInspection.visionOld}',
              '시력(좌/우)',
              ScreeningsDataType.vision
          ),
          buildMeasurementResultPositionedItem(
              20, 200, null, null, '${widget.metrologyInspection.bloodPressure}',
              '혈압',
              ScreeningsDataType.bloodPressure
          ),
          buildMeasurementResultPositionedItem(
              30, 360, null, null, '${widget.metrologyInspection.weight}',
              '몸무게',
              ScreeningsDataType.weight
          ),
          buildMeasurementResultPositionedItem(
              35, 460, null, null, '${widget.metrologyInspection.height}',
              '키',
              ScreeningsDataType.height
          ),
          buildMeasurementResultPositionedItem(
              null, 83, 50, null,
                  '${widget.metrologyInspection.hearingAbilityOld == '-'
                  ? (widget.metrologyInspection.hearingAbilityLeft == '-'
                  ? '-'
                  : '${widget.metrologyInspection.hearingAbilityLeft}/${widget.metrologyInspection.hearingAbilityRight}')
                  : widget.metrologyInspection.hearingAbilityOld}',
              '청력(좌/우)',
              ScreeningsDataType.hearingAbility
          ),
          buildMeasurementResultPositionedItem(
              null, 205, 40, null,
              '${widget.metrologyInspection.waistCircumference}',
              '허리둘레',
              ScreeningsDataType.waistCircumference
          ),
          buildMeasurementResultPositionedItem(
              null, 335, 25, null,
              '${widget.metrologyInspection.bodyMassIndex}',
              '체질량지수',
              ScreeningsDataType.bodyMassIndex
          ),
        ],
      ),
    );
  }

  /// 계측검사 검사 결과 Positioned item
  Widget buildMeasurementResultPositionedItem(
      double? left, double? top, double? right, double? bottom,
      String resultText,
      String resultLabel,
      ScreeningsDataType dataType,
      ) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: InkWell(
        onTap: ()=> {
          if(resultText != '-'){
            /// '-'조건일때 다이얼로그 띄워주고 조회한데이터가 없다고 해야됨
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return MyDataBottomSheetView(screeningsDataType: dataType);
                })
          }
        },
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
            Frame.myText(text:resultLabel, fontSize: 1.0)
          ],
        ),
      ),
    );
  }
}
