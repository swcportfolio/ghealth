
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../data/models/point_hisstory.dart';
import '../../utils/etc.dart';
import '../../utils/text_formatter.dart';
import '../frame.dart';

/// 포인트 적립, 사용 내역 리스트 아이템
class PointHistoryItem extends StatelessWidget {
  const PointHistoryItem({
    super.key,
    required this.pointHistory
  });

  final PointHistory pointHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(5, 20, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Frame.myText(
                  text: pointHistory.pointDesc,
                  fontSize: 1.2,
                  fontWeight: FontWeight.w600
              ),
              const Gap(5),

              Frame.myText(
                  text: TextFormatter.pointDateFormat(pointHistory.createDT),
                  fontSize: 1.1,
                  color: Colors.grey
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Frame.myText(
                  text: '${pointHistory.pointType == '적립'?'+':'-'}${pointHistory.point}P',
                  fontSize: 1.3,
                  color: pointHistory.pointType == '적립'
                      ? Colors.blueAccent
                      : Colors.redAccent,
                  fontWeight: FontWeight.w600
              ),
              const Gap(5),

              Frame.myText(
                  text: pointHistory.pointType,
                  fontSize: 1.1,
                  color: Colors.grey
              ),
            ],
          ),
        ],
      ),
    );
  }
}