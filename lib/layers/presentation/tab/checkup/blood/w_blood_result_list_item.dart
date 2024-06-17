import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../common/common.dart';
import '../../../../model/enum/blood_data_type.dart';
import '../../../widgets/style_text.dart';
import 'v_blood_bottom_sheet.dart';

/// 혈액 검사 결과 리스트 아이템
class BloodTestResultListItem extends StatelessWidget {

  final String bloodValue;
  final String bloodName;
  final BloodDataType bloodDataType;

  const BloodTestResultListItem({
    super.key,
    required this.bloodValue,
    required this.bloodName,
    required this.bloodDataType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (bloodValue != '-'){
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                enableDrag: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return BloodBottomSheetView(
                      bloodDataType: bloodDataType,
                      plotBandValue:
                          Branch.bloodTestStandardValue(bloodDataType));
                })
          }
      },
      child: Container(
        height: AppConstants.boxItemHeight60,
        padding: const EdgeInsets.symmetric(
            horizontal: AppDim.medium,
            vertical: AppDim.small,
        ),
        margin: const EdgeInsets.only(bottom: AppDim.small),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppConstants.borderRadius,
            border: Border.all(
              color: bloodValue == '-'
                  ? Colors.grey.shade300
                  : Branch.calculateBloodStatusColor(
                      bloodDataType, double.parse(bloodValue),
                      badColor: Colors.red, goodColor: AppColors.greyBoxBorder),
              width: 1.5,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyleText(
              text: bloodName,
            ),
            bloodValue == '-'
                ? const StyleText(text: '-      ')
                : Row(
                    children: [
                      const Gap(AppDim.small),
                      StyleText(
                          text: bloodValue,
                          fontWeight: AppDim.weightBold,
                          color: Branch.calculateBloodStatusColor(
                            bloodDataType,
                            double.parse(bloodValue),
                            badColor: Colors.red,
                            goodColor: AppColors.blackTextColor,
                          )),
                      StyleText(
                        text: bloodDataType ==
                                BloodDataType.shinsugularFiltrationRate
                            ? ' mL/min/m2'
                            : bloodDataType == BloodDataType.astSgot ||
                                    bloodDataType == BloodDataType.altSGpt ||
                                    bloodDataType == BloodDataType.gammaGtp
                                ? ' IU/L'
                                : ' g/dL',
                        size: AppDim.fontSizeSmall,
                      ),
                      const Gap(AppDim.xSmall),

                      Image.asset(
                        '${AppStrings.imagePath}/tab/checkup/blood_arrow_icon.png',
                        height: 50,
                        width: 50,
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
