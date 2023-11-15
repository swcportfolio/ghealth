import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../frame.dart';

/// 혈액 검사 결과 리스트 아이템
class BloodTestResultListItem extends StatelessWidget {
  const BloodTestResultListItem(
      {super.key,
        required this.bloodValue,
        required this.bloodName});

  final String bloodValue;
  final String bloodName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade400, width: 1.5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Frame.myText(
            text: bloodName,
            fontSize: 1.1,
          ),

          Row(
            children: [
              const Icon(Icons.arrow_drop_up_outlined, color: Colors.green),
              Frame.myText(
                text:bloodValue,
                fontWeight: FontWeight.w600,
                fontSize: 1.3,
              ),
              Frame.myText(
                text:'g/dL',
                fontWeight: FontWeight.normal,
                fontSize: 1.2,
              ),
              const Gap(5),

              Image.asset('images/blood_arrow_icon.png', height: 50, width: 50)
            ],
          )
        ],
      ),
    );
  }
}