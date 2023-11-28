

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/authorization.dart';

import '../../utils/colors.dart';
import '../../widgets/frame.dart';

class MyHealthTopPhraseWidget extends StatelessWidget {
  const MyHealthTopPhraseWidget({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                  text: '안녕하세요. ${Authorization().userName}님!',
                  fontSize: 1.2,
                  fontWeight: FontWeight.w500,
                ),
                const Gap(5),
                Frame.myText(
                    text:'나의 $label 기록',
                    maxLinesCount: 2,
                    color: mainColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.9
                )
              ],
            )
          ]
      ),
    );
  }
}
