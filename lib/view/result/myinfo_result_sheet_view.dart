
import 'package:flutter/material.dart';
import 'package:ghealth_app/widgets/frame.dart';

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
        child: Column(
          children: [
            // 종합 결과 내역
            buildFinalResult(),

            /// 임시
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset('images/point_box.png'),
            ),
            /// 임시
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset('images/chart_box.png'),
            ),
            const SizedBox(height: 10),

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

            const SizedBox(height: 10),
            Container(
                width: double.infinity,
                margin:const EdgeInsets.only(left: 15),
                child: Image.asset('images/ex_3.png', fit: BoxFit.cover)
            ),
            const SizedBox(height: 20),
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
      margin: const EdgeInsets.fromLTRB(15, 30, 15, 15),
      child: Row(
        children: [
          // 종 모양 이미지
          Flexible(
              flex: 4,
              child: Image.asset('images/bell_image.png')
          ),
          const SizedBox(width: 15),

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
                const SizedBox(height: 5),

                MyRichText.infoResultRichTxt(context),

              ],
            ),
          )

        ]
      ),
    );
  }
}
