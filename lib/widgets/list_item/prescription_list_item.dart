
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../data/models/medication_Info_data.dart';
import '../../utils/colors.dart';
import '../../view/mydata/medication_detail_view.dart';
import '../frame.dart';

/// 약처방 내역 리스트 아이템
class PrescriptionListItem extends StatelessWidget {
  const PrescriptionListItem({super.key, required this.medicationInfoData});
  final MedicationInfoData medicationInfoData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Frame.doPagePush(context, MedicationDetailView(medicationCode: medicationInfoData.medicationCode)),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //TODO: 이미지 변경해야됨
            Image.asset('images/medicine_image_1.png', height: 70, width: 70),
            const Gap(15),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Frame.myText(
                      text: '조제일자: ${medicationInfoData.whenPrepared}'
                  ),
                  const Gap(3),

                  Frame.myText(
                      text: medicationInfoData.medicationName,
                      maxLinesCount: 5,
                      fontWeight: FontWeight.w600,
                      color: mainColor,
                      softWrap: true,
                      fontSize: 0.9
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