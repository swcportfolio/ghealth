
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/view/point/point_management_view.dart';
import 'package:ghealth_app/view/result/examination_record_view.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../../utils/colors.dart';
import '../../widgets/my_richtext.dart';

/// 나의 건강정보 종합 결과지
class MyInfoResultSheetView extends StatefulWidget {
  const MyInfoResultSheetView({super.key});

  @override
  State<MyInfoResultSheetView> createState() => _MyInfoResultSheetViewState();
}

class _MyInfoResultSheetViewState extends State<MyInfoResultSheetView> {

  /// 디바이스 사이즈
  late Size deviceSize;

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              /// 페이지 안내 메시지 Top
              buildFinalResult(),
              const Gap(15),

              /// 건강 포인트
              buildHealthPointBox(),
              const Gap(15),

              /// 건강검진 결과 안내 Box
              buildHealthCheckupResult()





            ],
          ),
        )
      ),
    );
  }

  Widget buildFinalResult(){
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
                text: '안녕하세요. 홍길동님!',
                fontSize: 1.2,
                fontWeight: FontWeight.w500,
              ),
              const Gap(5),
              Frame.myText(
                text:'걷기 좋은 가을날,\n가벼운 산책 어떠세요?',
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

  Widget buildHealthPointBox() {
   return InkWell(
     onTap: ()=> Frame.doPagePush(context, const PointManagementView()),
     child: Card(
       elevation: 3,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20.0),
       ),
       child: SizedBox(
         width: double.infinity,
         height: 130,
         child: Column(
           children: [
             Container(
               height: 50,
               padding: const EdgeInsets.fromLTRB(25, 15, 10, 15),
               decoration: const BoxDecoration(
                 color: mainColor,
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(20.0),
                   topRight: Radius.circular(20.0),
                 ),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Frame.myText(
                     text: '건강포인트',
                     color: Colors.white,
                     fontSize: 1.2,
                     fontWeight: FontWeight.w600
                   ),
                   // arrow 아이콘
                   const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20,)
                 ],
               ),
             ),


             /// 포인트 이미지, 포인트 점수
             Container(
               height: 80,
               padding: const EdgeInsets.symmetric(horizontal: 20),
               decoration: const BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(
                   bottomRight: Radius.circular(20.0),
                   bottomLeft: Radius.circular(20.0),
                 ),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(2.0),
                     child: Image.asset('images/point.png', color: mainColor, height: 40, width: 40),
                   ),
                   const Gap(5),

                   Frame.myText(
                     text: '11,000',
                     fontSize: 2.2,
                     fontWeight: FontWeight.w400,
                     color: Colors.black,
                   ),
                   const Gap(10),


                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Frame.myText(
                           text:'나의 건강 포인트 확인하고'
                       ),
                       Frame.myText(
                           text:'저렴하게 진료받으세요!',
                         fontWeight: FontWeight.w600
                       ),
                     ],
                   )
                 ],
               ),
             ),
           ]
         )
       ),
     ),
   );
  }

  Widget buildHealthCheckupResult() {
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
                    fontWeight: FontWeight.w600
                ),
                // arrow 아이콘
                const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20,)
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
                  text: '정상B(경계) 판정',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 1.5
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Frame.myText(
                  text: '• 일주일에 2일 이상 신체 각 부위를 모두 포함하여 근력운동을 수행하십시오.',
                  maxLinesCount: 2,
                  fontSize: 1.1,
                  softWrap: true
              ),
            ),
          ],
        ),
      ),
    );
  }
}
