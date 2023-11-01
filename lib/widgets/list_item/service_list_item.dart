import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/widgets/frame.dart';

class ServiceListItem extends StatelessWidget {
  const ServiceListItem({
    super.key,
    required this.label,
    required this.index
  });

  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// 서비스 이미지
        Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: serviceCircleBgColor,
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Image.asset('images/service_${index + 1}.png',
                      height: 65, width: 65)),
            )),
        const Gap(10),

        /// 서비스 이름
        Frame.myText(
            text: label,
            fontSize: 1.1,
            maxLinesCount: 2,
            align: TextAlign.center,
            color: Colors.black)
      ],
    );
  }
}
