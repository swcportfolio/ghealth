import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../data/models/blood_test.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/frame.dart';
import '../../widgets/list_item/blood_test_result_list_item.dart';
import 'blood_test_detail_view.dart';

class BloodTestResultWidget extends StatelessWidget {
  const BloodTestResultWidget({super.key, required this.bloodTest});

  /// 혈액 검사 결과 데이터 클래스
  final BloodTest bloodTest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Card(
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Frame.myText(
                      text: '혈액 검사',
                      fontSize: 1.2,
                      fontWeight: FontWeight.w600),

                  InkWell(
                    // 더보기 화면으로 이동
                    onTap: ()=> Frame.doPagePush(context, BloodTestDetailView(bloodTest: bloodTest)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Frame.myText(
                            text: '자세히',
                            maxLinesCount: 2,
                            fontSize: 0.9,
                            fontWeight: FontWeight.w500,
                            softWrap: true),
                        const Gap(5),
                        const Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Icon(Icons.arrow_forward_ios, size: 12),
                        )
                      ],
                    ),
                  ),

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
                      bloodValue: bloodValue,
                      bloodName: bloodName,
                      bloodDataType: BloodDataType.strToEnum(bloodName)
                    );
                  },
                ),
              ),
              /// 검진 날짜
              Visibility(
                visible: bloodTest.issuedDate == '-' || bloodTest.issuedDate == null
                    ? false
                    : true,
                child: Frame.myText(
                  text: '최근 검진일 : ${bloodTest.issuedDate}',
                  fontSize: 0.9,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
