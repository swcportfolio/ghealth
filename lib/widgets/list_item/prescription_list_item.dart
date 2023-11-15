
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../data/models/medication_Info_data.dart';
import '../frame.dart';

/// 약처방 내역 리스트 아이템
class PrescriptionListItem extends StatelessWidget {
  const PrescriptionListItem({super.key, required this.medicationInfoData});
  final MedicationInfoData medicationInfoData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //TODO: 이미지 변경해야됨
          Image.asset('images/medicine_image_1.png', height: 70, width: 70),
          const Gap(15),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Frame.myText(
                  text: '조제일자: ${medicationInfoData.whenPrepared}'
              ),
              const Gap(3),

              SizedBox(
                width: 200,
                child: Frame.myText(
                  text: medicationInfoData.medicationName,
                  maxLinesCount: 3,
                  fontWeight: FontWeight.w500,
                  softWrap: true,
                  fontSize: 1.0
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}