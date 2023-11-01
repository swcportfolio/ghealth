
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
        child: Column(
          children: [
            buildFinalResult(),
            buildHealthPointBox(),

            /// 임시
            const Gap(20),
            InkWell(
              onTap: ()=> Frame.doPagePush(context, const ExaminationRecordView()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Image.asset('images/chart_box.png'),
              ),
            ),
            const Gap(10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Image.asset('images/ex_1.png'),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Image.asset('images/ex_2.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Gap(10),
            Container(
                width: double.infinity,
                margin:const EdgeInsets.only(left: 15),
                child: Image.asset('images/ex_3.png', fit: BoxFit.cover)
            ),

            const Gap(20),
            Container(
                width: double.infinity,
                margin:const EdgeInsets.only(left: 15),
                child: Image.asset('images/ex_4.png', fit: BoxFit.cover)
            ),

          ],
        )
      ),
    );
  }

  Widget buildFinalResult(){
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 종 모양 이미지
          SizedBox(
            height: 160,
              width: 160,
              child: Image.asset('images/bell_image.png', fit: BoxFit.cover)),

          // 사용자 성함, 지난 검진 결과 내용
          Flexible(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                  text: '홍길동님',
                  fontSize: 1.8,
                  fontWeight: FontWeight.w600,
                ),
                const Gap(5),

                MyRichText.infoResultRichTxt(context),

              ],
            ),
          )
        ]
      ),
    );
  }

  buildHealthPointBox() {
   return Container(
     width: double.infinity,
     height: 95,
     margin: const EdgeInsets.symmetric(horizontal: 20),
     padding: const EdgeInsets.all(20),
     decoration: BoxDecoration(
       color: mainColor,
       borderRadius: BorderRadius.circular(25),
     ),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         /// 포인트 이미지, 포인트 점수
         Row(
           children: [
             Padding(
               padding: const EdgeInsets.all(2.0),
               child: Image.asset('images/point.png'),
             ),
             const Gap(10),

             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Frame.myText(
                   text: '건강포인트',
                   color: Colors.white,
                   fontSize: 0.95,
                 ),
                 const Gap(3),

                 /// 실제 포인트 점수 텍스트
                 Frame.myText(
                   text: '11,000pt',
                   fontSize: 1.8,
                   fontWeight: FontWeight.w500,
                   color: Colors.white,
                 )
               ],
             )
           ],
         ),

         // arrow 아이콘
         const Icon(Icons.arrow_forward_ios, color: Colors.white,)

       ]
     )
   );
  }
}
