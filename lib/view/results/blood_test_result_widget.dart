import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/view/results/blood_test_detail_view.dart';

import '../../data/models/blood_test.dart';
import '../../utils/colors.dart';
import '../../widgets/frame.dart';
import '../../widgets/list_item/blood_test_result_list_item.dart';

class BloodTestResultWidget extends StatelessWidget {
  const BloodTestResultWidget({super.key, required this.bloodTest});

  /// 혈액 검사 결과 데이터 클래스
  final BloodTest bloodTest;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 320,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          color: bloodResultBgColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.redAccent.shade200, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Frame.myText(
                    text: '혈액 검사',
                    color: Colors.black,
                    fontSize: 1.2,
                    fontWeight: FontWeight.w600),

                /// 검진 날짜
                Frame.myText(
                  text: '검진일 : ${bloodTest.issuedDate}',
                  fontSize: 0.9,
                )
              ],
            ),
            const Gap(10),
            SizedBox(
              height: 220,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  String bloodValue = bloodTest.toList()[index];
                  String bloodName = bloodTest.nameList()[index];
                  return BloodTestResultListItem(
                      bloodValue: bloodValue, bloodName: bloodName);
                },
              ),
            ),
            InkWell(
              // 더보기 화면으로 이동
              onTap: ()=> Frame.doPagePush(context, BloodTestDetailView(bloodTest: bloodTest)),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Frame.myText(
                        text: '더보기',
                        maxLinesCount: 2,
                        fontSize: 1.0,
                        fontWeight: FontWeight.w600,
                        softWrap: true),
                    const Icon(Icons.keyboard_arrow_down, color:Colors.black)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
