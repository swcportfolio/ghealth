import 'package:flutter/material.dart';

import '../../utils/etc.dart';
import '../frame.dart';

class UrineListItem extends StatelessWidget {
  const UrineListItem({Key? key,
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
            border: Border(
                top: BorderSide(
                    color: Colors.grey,
                    width: 0.5
                )
            )
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 항목
              Container(
                  width: 90,
                  child: Frame.myText(
                      text: dataDesc,
                      fontSize: 1.1,
                      fontWeight: FontWeight.normal,
                      maxLinesCount: 1)
              ),

              /// 결과 Image
              Image.asset(
                  Etc.resultStatusToImageStr(dataDesc, value),
                  height: 90,
                  width: 170
              ),

              /// 결과 Text
              Frame.myText(
                  text: Etc.resultStatusToText(dataDesc, value),
                  fontWeight: FontWeight.w500,
                  color: Etc.resultStatusToTextColor(dataDesc, value),
                  maxLinesCount: 1
              ),
            ]
        ));
  }



}