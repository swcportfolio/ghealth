
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../common/common.dart';
import '../../../../entity/summary_dto.dart';
import '../../../widgets/style_text.dart';
import 'v_drug_info.dart';


/// 약처방 내역 리스트 아이템
class MedicationListItem extends StatelessWidget {
  final MedicationInfoDTO medicationInfoDTO;

  const MedicationListItem({
    super.key,
    required this.medicationInfoDTO,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Nav.doPush(context, DrugInfoView(medicationCode: medicationInfoDTO.medicationCode)),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //TODO: 이미지 변경해야됨
            Image.asset(
                '${AppStrings.imagePath}/tab/checkup/medicine_image_1.png',
                height: 70,
                width: 70,
            ),
            const Gap(AppDim.medium),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyleText(
                      text: '조제일자: ${medicationInfoDTO.whenPrepared}'
                  ),
                  const Gap(AppDim.xSmall),

                  StyleText(
                      text: medicationInfoDTO.medicationName,
                      maxLinesCount: 5,
                      fontWeight: AppDim.weightBold,
                      color: AppColors.primaryColor,
                      softWrap: true,
                      size: AppDim.fontSizeSmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}