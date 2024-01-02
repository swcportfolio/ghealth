import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/widgets/frame.dart';

/// 건강검진 종합 소견
class HealthCheckUpComprehensiveWidget extends StatelessWidget {
  const HealthCheckUpComprehensiveWidget(
      {super.key,
      required this.comprehensiveOpinionText,
      required this.lifestyleManagementText,
      //required this.issuedDate
      });

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

  /// 최근 검진일
  //final String? issuedDate;

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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.greenAccent, width: 2),
          ),
          child: comprehensiveOpinionText == ''
              ? _buildCheckUpEmptyView()
              :
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Frame.myText(
                      text: '건강 검진 종합 소견',
                      fontSize: 1.2,
                      fontWeight: FontWeight.w600),
                  // /// 최근 검진 날짜
                  // Visibility(
                  //   visible: issuedDate == '' ? false : true,
                  //   child: Frame.myText(
                  //     text: '최근 검진일\n$issuedDate',
                  //     maxLinesCount: 2,
                  //     fontSize: 0.9,
                  //   ),
                  // )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.green,
                ),
                child: Center(
                  child: Frame.myText(
                      text: comprehensiveOpinionText,
                      color: Colors.white,
                      softWrap: true,
                      maxLinesCount: 7,
                      fontWeight: FontWeight.w600,
                      fontSize: 1.3),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Frame.myText(
                    text: '• $lifestyleManagementText',
                    maxLinesCount: 4,
                    fontSize: 0.95,
                    softWrap: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 건강 검진 결과 안내의 종합소견_판정의 데이터가 ''일 경우
  /// 전체 EmptyView 화면을 보여준다.
  _buildCheckUpEmptyView(){
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/empty_search_image.png', height: 60, width: 60),
          const Gap(15),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Frame.myText(
              text: '죄송합니다. 건강 검진 결과 조회 내역이 현재 시스템상 확인되지 않습니다.',
              maxLinesCount: 2,
              softWrap: true,
              fontSize: 1.0,
              fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }
}
