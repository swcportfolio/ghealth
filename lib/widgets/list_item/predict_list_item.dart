import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../frame.dart';


class PredictListItem extends StatelessWidget {
  const PredictListItem({
    super.key,
    required this.title,
    required this.indicatorColor,
    required this.percent,
    required this.state,
  });

  final String title;
  final Color indicatorColor;
  final double percent;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: Colors.grey.shade300,
              width: 1.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Frame.myText(
              text: title,
              fontSize: 1.1,
            ),
          ),

          Expanded(
            flex: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start, 
              children: [
                Expanded(
                  child: LinearPercentIndicator(
                    animation: true,
                    animationDuration: 100,
                    lineHeight: 18.0,
                    percent: double.parse(percent.toStringAsFixed(2)),
                    progressColor: indicatorColor,
                    backgroundColor: Colors.grey.shade300,
                    barRadius: const Radius.circular(10),
                  ),
                ),

                Frame.myText(
                    text: state,
                    color: indicatorColor,
                    fontSize: 1.1,
                    fontWeight: FontWeight.w600
                ),
                const Gap(10),

              ],
            ),
          )
        ],
      ),
    );
  }
}

/// 혈액 검사 결과 리스트 아이템
class PredictAgeListItem extends StatelessWidget {
  const PredictAgeListItem({
    super.key,
    required this.title,
    required this.age,

  });

  final String title;
  final String age;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.fromLTRB(30, 10, 5, 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: Colors.grey.shade300,
              width: 1.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Frame.myText(
            text: title,
            fontSize: 1.1,
          ),

          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Frame.myText(
                text: '$age세 발생 예상',
                fontSize: 1.1,
                fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    );
  }
}