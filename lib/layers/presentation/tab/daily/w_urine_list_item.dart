import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';

import '../../../../common/util/lifelog_urine_branch.dart';


class UrineListItem extends StatelessWidget {
  const UrineListItem({
    Key? key,
    required this.dataDesc,
    required this.value,
  }) : super(key: key);

  final String dataDesc;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 항목
              SizedBox(
                  width: 90,
                  child: StyleText(
                      text: dataDesc,
                      fontWeight: FontWeight.normal,
                      maxLinesCount: 1)),
              /// 결과 Image
              Image.asset(
                  LifeLogUrineBranch.resultStatusToImageStr(dataDesc, value),
                  height: 90,
                  width: 170),

              /// 결과 Text
              StyleText(
                  text: LifeLogUrineBranch.resultStatusToText(dataDesc, value),
                  fontWeight: FontWeight.w500,
                  color: LifeLogUrineBranch.resultStatusToTextColor(dataDesc, value),
                  maxLinesCount: 1),
            ]));
  }
}
