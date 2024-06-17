import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../../../common/util/text_format.dart';
import '../../../../model/enum/physical_type.dart';
import '../../../../model/vo_physical_inspection.dart';
import '../../../widgets/style_text.dart';
import 'v_physical_bottom_sheet.dart';


/// 나의 건강 검진 - 계측 검사
class PhysicalInspectionItem extends StatelessWidget {

  /// 계측검사 결과 데이터 클래스
  final PhysicalInspection physicalInspection;
  final String value;

  const PhysicalInspectionItem({
    super.key,
    required this.physicalInspection,
    required this.value,
  });


  String get title => '계측 검사';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 610,
          margin:  EdgeInsets.only(right: value == '' ? 0 : AppDim.small),
          padding: const EdgeInsets.all(AppDim.mediumLarge),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppConstants.borderRadius,
              border: Border.all(
                  width: AppConstants.borderMediumWidth,
                  color: AppColors.greyBoxBorder)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 검진 날짜 Text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyleText(
                      text: title,
                      fontWeight: AppDim.weightBold,
                  ),

                  /// 검진 날짜
                  Visibility(
                    visible: value.isEmpty ? false : true,
                    child: StyleText(
                      text: '검진일 : ${TextFormat.defaultDateFormat(value)}',
                      size: AppDim.fontSizeSmall,
                    ),
                  )
                ],
              ),

              /// 사람 이미지
              Padding(
                padding: const EdgeInsets.all(AppDim.mediumLarge),
                child: Image.asset(
                  '${AppStrings.imagePath}/tab/checkup/body_image.png',
                  height: 460,
                  width: 180,
                ),
              ),
              const Gap(AppDim.medium),

              StyleText(
                  text: '클릭하시면 자세한 결과를 보실수 있습니다.',
                  color: AppColors.blackTextColor,
                  size: AppDim.fontSizeSmall,
                  ),
            ],
          ),
        ),

        /// 각 항목 Positioned Container
        buildMeasurementResultPositionedItem(
            0, 84, 200, null,
            '${physicalInspection.visionOld == '-'
                ? (physicalInspection.visionLeft == '-'
                ? '-'
                : '${physicalInspection.visionLeft}/${physicalInspection.visionRight}')
                : physicalInspection.visionOld}',
            '시력(좌/우)',
            PhysicalType.vision,
            context,
        ),
        buildMeasurementResultPositionedItem(
            0, 205, 240, null, '${physicalInspection.bloodPressure}',
            '혈압',
            PhysicalType.bloodPressure,
            context,
        ),
        buildMeasurementResultPositionedItem(
            0, 365, 200, null, '${physicalInspection.weight}',
            '몸무게',
            PhysicalType.weight,
            context,
        ),
        buildMeasurementResultPositionedItem(
            0, 460, 200, null, '${physicalInspection.height}',
            '키',
            PhysicalType.height,
            context,
        ),
        buildMeasurementResultPositionedItem(
            145, 90, 0, null,
            '${physicalInspection.hearingAbilityOld == '-'
                ? (physicalInspection.hearingAbilityLeft == '-'
                ? '-'
                : '${physicalInspection.hearingAbilityLeft}/${physicalInspection.hearingAbilityRight}')
                : physicalInspection.hearingAbilityOld}',
            '청력(좌/우)',
            PhysicalType.hearingAbility,
            context,
        ),
        buildMeasurementResultPositionedItem(
            180, 210, 0, null,
            '${physicalInspection.waistCircumference}',
            '허리둘레',
            PhysicalType.waistCircumference,
            context,
        ),
        buildMeasurementResultPositionedItem(
            200, 340, 0, null,
            '${physicalInspection.bodyMassIndex}',
            '체질량지수',
            PhysicalType.bodyMassIndex,
            context,
        ),
      ],
    );
  }

  /// 계측검사 검사 결과 Positioned item
  Widget buildMeasurementResultPositionedItem(
      double? left, double? top, double? right, double? bottom,
      String resultText,
      String resultLabel,
      PhysicalType physicalType,
      BuildContext context,
      ) {
    // 청력, 혈압 기준값에 의해서 borderbox 컬러값 설정
    Color borderColor = Branch.getBloodPressureColor(resultText, resultLabel);

    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: InkWell(
        onTap: ()=> {
          if(resultText != '-'){
            /// '-'조건일때 다이얼로그 띄워주고 조회할 데이터가 없다고 해야됨
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return PhysicalBottomSheetView(screeningsDataType: physicalType);
              },
            )
          }
        },
        child: Column(
          children:
          [
            /// 검사 결과 박스
            Container(
              height: 30,
              width: 65,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppConstants.borderRadius,
                  border: Border.all(width: 1, color: borderColor)),
              child: Center(
                child: StyleText(
                    text: resultText,
                    color: borderColor,
                    fontWeight: AppDim.weightBold,
                    size: AppDim.fontSizeSmall,
                ),
              ),
            ),
            const Gap(AppDim.xSmall),

            /// 측정 항목명 텍스트
            StyleText(
              text: resultLabel,
              size: AppDim.fontSizeXSmall,
            )
          ],
        ),
      ),
    );
  }
}
