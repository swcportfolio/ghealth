import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/etc.dart';

import '../../utils/constants.dart';
import '../../view/mydata/bottom_sheet/blood_bottom_sheet_view.dart';
import '../frame.dart';

/// 혈액 검사 결과 리스트 아이템
class BloodTestResultListItem extends StatelessWidget {
  const BloodTestResultListItem(
      {super.key,
        required this.bloodValue,
        required this.bloodName,
        required this.bloodDataType});

  final String bloodValue;
  final String bloodName;
  final BloodDataType bloodDataType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> {
        if(bloodValue != '-'){
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              enableDrag: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return BloodBottomSheetView(
                    bloodDataType: bloodDataType,
                    plotBandValue: Etc.bloodTestStandardValue(bloodDataType)
                );
              })
        }
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: bloodValue == '-'
                    ? Colors.grey.shade300
                    : Etc.calculateBloodStatusColor(
                    bloodDataType, double.parse(bloodValue),
                    badColor: Colors.red, goodColor: Colors.grey.shade300),
                width: 1.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Frame.myText(
              text: bloodName,
              fontSize: 1.1,
            ),

            bloodValue == '-'
            ? Frame.myText(text: '-      ')
            : Row(
              children: [
                const Gap(10),
                Frame.myText(
                  text:bloodValue,
                  fontWeight: FontWeight.w600,
                  fontSize: 1.1,
                  color: Etc.calculateBloodStatusColor(
                      bloodDataType, double.parse(bloodValue), badColor: Colors.red, goodColor: Colors.black)
                ),
                Frame.myText(
                  text: bloodDataType == BloodDataType.shinsugularFiltrationRate
                      ? ' mL/min/m2'
                      : bloodDataType == BloodDataType.astSgot ||
                              bloodDataType == BloodDataType.altSGpt ||
                              bloodDataType == BloodDataType.gammaGtp
                          ? ' IU/L'
                          : ' g/dL',
                  fontWeight: FontWeight.normal,
                  fontSize: 0.9,
                ),
                const Gap(5),

                Image.asset('images/blood_arrow_icon.png',
                    height: 50, width: 50)
              ],
            )
          ],
        ),
      ),
    );
  }
}