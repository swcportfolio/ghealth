
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/tab/checkup/blood/w_blood_result_list_item.dart';

import '../../../../model/enum/blood_data_type.dart';
import '../../../../model/vo_blood_test.dart';
import '../../../widgets/frame_container.dart';
import '../../../widgets/style_text.dart';
import 'v_blood_detail_view.dart';

/// 혈액검사 결과
class BloodResultBox extends StatelessWidget {
  final BloodTest bloodTest;

  const BloodResultBox({
    super.key,
    required this.bloodTest,
  });

  double get boxHeight => 300;
  int get itemMaxCount => 3;
  String get title => '혈액검사';
  String get addText => '자세히';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: FrameContainer(
        height: boxHeight,
        backgroundColor: AppColors.bloodResultBgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StyleText(
                  text: title,
                  fontWeight: AppDim.weightBold,
                ),

                InkWell(
                  // 더보기 화면으로 이동
                  onTap: ()=> Nav.doPush(context, BloodDetailView(bloodTest: bloodTest)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StyleText(
                          text: addText,
                          maxLinesCount: 2,
                          size: AppDim.fontSizeSmall,
                          fontWeight: AppDim.weight500,
                          softWrap: true),
                      const Gap(AppDim.xSmall),

                      const Icon(
                          Icons.arrow_forward_ios,
                          size: AppDim.iconXxSmall,
                      )
                    ],
                  ),
                ),

              ],
            ),
            const Gap(AppDim.small),

            SizedBox(
              height: 220,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemMaxCount,
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
          ],
        ),
      ),
    );
  }
}