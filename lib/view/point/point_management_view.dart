import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/point_hisstory.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../../utils/colors.dart';
import '../../widgets/horizontal_dashed_line.dart';

/// 포인트 관리 화면
class PointManagementView extends StatefulWidget {
  const PointManagementView({super.key});

  @override
  State<PointManagementView> createState() => _PointManagementViewState();
}

class _PointManagementViewState extends State<PointManagementView> {

  final List<PointHistory> sampleDataList = [
    PointHistory(title: '진단서 및 소견서 업로드', date: '2023.07.26', textColor: Colors.blueAccent, pointValue: '+2,000P', pointStatus: '적립'),
    PointHistory(title: '상품권 교환', date: '2023.07.20', textColor: Colors.redAccent, pointValue: '-1,000P', pointStatus: '사용'),
    PointHistory(title: '상품권 교환', date: '2023.07.18', textColor: Colors.redAccent, pointValue: '- 1,000P', pointStatus: '사용'),
    PointHistory(title: '진단서 및 소견서 업로드', date: '2023.06.13', textColor: Colors.blueAccent, pointValue: '+ 2,000P', pointStatus: '적립'),
    PointHistory(title: '진단서 및 소견서 업로드', date: '2023.05.18', textColor: Colors.blueAccent, pointValue: '+ 2,000P', pointStatus: '적립'),
    PointHistory(title: '진단서 및 소견서 업로드', date: '2023.04.05', textColor: Colors.blueAccent, pointValue: '+ 2,000P', pointStatus: '적립'),
    PointHistory(title: '진단서 및 소견서 업로드', date: '2023.02.22', textColor: Colors.blueAccent, pointValue: '+ 2,000P', pointStatus: '적립'),
    PointHistory(title: '진단서 및 소견서 업로드', date: '2023.01.09', textColor: Colors.blueAccent, pointValue: '+ 2,000P', pointStatus: '적립'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '포인트 관리',
        isIconBtn: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            buildCurrentPointBox(),
            buildPointHistory()
          ],
        ),
      ),
    );
  }

  /// 현재 포인트 정보를 나타내는 위젯을 생성합니다.
  Widget buildCurrentPointBox() {
    return Container(
      height: 210,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        color: mainColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // 사용가능한 포인트 Text
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Frame.myText(
                        text: '사용가능한 포인트',
                        color: Colors.white,
                        fontSize: 1.2
                      ),
                      const Gap(10),
                      Frame.myText(
                          text: '0 pt',
                          color: Colors.white,
                          fontSize: 3.0,
                          fontWeight: FontWeight.w600
                      ),
                    ],
                  ),
                ),

                // 포인트 Image
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'images/point_image.png',
                    height: 110,
                    width: 110
                  ),
                )
              ],
            ),

            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
                child: Center(
                  child: Frame.myText(
                      text: '포인트 사용처',
                      fontSize: 1.1
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  /// 포인트 사용/적립 내역을 나타내는 위젯을 생성합니다.
  Widget buildPointHistory(){
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(10),
        color: historyBgColor,
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 타이틀
              Frame.myText(
               text: '사용 / 적립 내역',
               fontWeight: FontWeight.bold,
                fontSize: 1.3
              ),
              const Gap(20),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: sampleDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PointHistoryItem(pointHistory: sampleDataList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                   return const HorizontalDottedLine(mWidth: 200);
                  } ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 포인트 적립, 사용 내역 리스트 아이템
class PointHistoryItem extends StatelessWidget {
  const PointHistoryItem({super.key, required this.pointHistory});

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
                  text: pointHistory.title,
                  fontSize: 1.2,
                  fontWeight: FontWeight.w600
              ),
              const Gap(5),

              Frame.myText(
                  text: pointHistory.date,
                  fontSize: 1.1,
                  color: Colors.grey
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Frame.myText(
                  text: pointHistory.pointValue,
                  fontSize: 1.3,
                  color: pointHistory.textColor,
                  fontWeight: FontWeight.w600
              ),
              const Gap(5),

              Frame.myText(
                  text: pointHistory.pointStatus,
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

