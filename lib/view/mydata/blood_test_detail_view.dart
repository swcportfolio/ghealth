import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';

import '../../data/models/blood_test.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/frame.dart';
import '../../widgets/list_item/blood_test_result_list_item.dart';

/// 혈액 검사 결과 더보기 화면
class BloodTestDetailView extends StatefulWidget {
  const BloodTestDetailView({super.key, required this.bloodTest});

  /// 혈액 검사 결과 데이터 클래스
  final BloodTest bloodTest;

  @override
  State<BloodTestDetailView> createState() => _BloodTestDetailViewState();
}

class _BloodTestDetailViewState extends State<BloodTestDetailView> {
  late List<String> bloodValueList;
  late List<String> bloodNameList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloodValueList = widget.bloodTest.toList();
    bloodNameList = widget.bloodTest.nameList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metrologyInspectionBgColor,
      appBar: const CustomAppBar(title: '혈액 검사', isIconBtn: false),

      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            //bloodResultBgColor,
            borderRadius: BorderRadius.circular(20.0),
            //border: Border.all(color: Colors.redAccent.shade200, width: 2),
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
                      fontSize: 1.2,
                      fontWeight: FontWeight.w600),

                  /// 검진 날짜
                  Frame.myText(
                    text: '최근 검진일 : ${widget.bloodTest.issuedDate ?? '-'}',
                    fontSize: 0.9,
                  )
                ],
              ),
              const Gap(20),
              Expanded(
                child: ListView.builder(
                  itemCount: bloodValueList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BloodTestResultListItem(
                      bloodValue: bloodValueList[index],
                      bloodName: bloodNameList[index],
                      bloodDataType: BloodDataType.strToEnum(bloodNameList[index])
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
