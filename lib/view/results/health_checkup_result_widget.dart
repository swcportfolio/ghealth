import 'package:flutter/material.dart';
import 'package:ghealth_app/widgets/frame.dart';

/// 건강검진 결과 안내
class HealthCheckUpResultWidget extends StatelessWidget {
  const HealthCheckUpResultWidget(
      {super.key,
      required this.comprehensiveOpinionText,
      required this.lifestyleManagementText,
      required this.issuedDate});

  /// [healthScreeningList]중에 [dataName]이 "종합소견_판정" 의
  /// dataValue 값
  ///
  /// ex)"dataValue": "정상B(경계) ,일반 질환의심
  final String comprehensiveOpinionText;

  /// [healthScreeningList]중에 [dataName]이 "종합소견_생활습관관리"의
  /// dataValue 값
  ///
  /// ex) dataValue": "위험음주상태입니다. 절주 또는 금주가 필요합니다.신체활동량이 부족합니다. 운동을 생활화하십시오."
  final String lifestyleManagementText;

  /// 검진일
  final String issuedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.greenAccent, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Frame.myText(
                    text: '건강 검진 결과 안내',
                    color: Colors.black,
                    fontSize: 1.2,
                    fontWeight: FontWeight.w600),
                /// 검진 날짜
                Frame.myText(
                  text: '검진일 : $issuedDate',
                  fontSize: 0.9,
                )
              ],
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.green,
              ),
              child: Center(
                child: Frame.myText(
                    text: comprehensiveOpinionText,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.3),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Frame.myText(
                  text: '• $lifestyleManagementText',
                  maxLinesCount: 3,
                  fontSize: 1.0,
                  softWrap: true),
            ),
          ],
        ),
      ),
    );
  }
}
