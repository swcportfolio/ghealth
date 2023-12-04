
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/view/report/health_checkup_record_body_view.dart';
import 'package:ghealth_app/widgets/frame.dart';

import 'health_point_box_widget.dart';
import 'my_health_topphrase_widget.dart';

/// 건강검진 기록 화면
class MyHealthRecordView extends StatefulWidget {
  const MyHealthRecordView({super.key});

  @override
  State<MyHealthRecordView> createState() => _MyHealthRecordViewState();
}

class _MyHealthRecordViewState extends State<MyHealthRecordView> {
  final String title = '건강검진 기록 전체 보기';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 페이지 안내 메시지 Top
              MyHealthTopPhraseWidget(label: '라이프로그',),
              //Gap(15),

              /// 건강 포인트
              //HealthPointBoxWidget(),
              Gap(30),

              HealthCheckUpRecordBodyWidget(),
            ],
          ),
        ),
      ),
    );
  }

  buildTitleLabel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        Frame.myText(
            text: '건강검진기록',
            color: mainColor,
            fontSize: 2.1,
            fontWeight: FontWeight.w600),
        Frame.myText(
            text: '한눈에 확인하기!',
            fontSize: 2.1,
            fontWeight: FontWeight.w600)
      ],
    );
  }

}

/// 한눈에 보기[총콜레스테롤, 혈당, 중성지방]
//   buildAtGlance(){
//     return Container(
//       height: 350,
//       margin: const EdgeInsets.only(top: 20, bottom: 15),
//       child: Card(
//         color: reservedCardBgColor,
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 20 , 20, 0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset('images/exclamation_mark_red.png',
//                       width: 25, height: 25),
//                   const Gap(8),
//                   Frame.myText(
//                     text: '주의 항목 ',
//                     fontSize: 1.3,
//                     color: Colors.redAccent,
//                   ),
//                   Frame.myText(
//                     text: '한눈에 보기',
//                     fontSize: 1.3,
//                   )
//                 ],
//               ),
//
//               Expanded(
//                 child: ListView.separated(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: sampleBodyCompositionList.length,
//
//                   itemBuilder: (BuildContext context, int index) {
//                   return BodyCompositionListItem(bodyComposition: sampleBodyCompositionList[index]);
//                   },
//                   separatorBuilder: (BuildContext context, int index) {
//                     return const HorizontalDottedLine(mWidth: 200);
//                   } ,
//                 ),
//               )
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<BodyComposition> sampleBodyCompositionList = [
//     BodyComposition('총콜레스테롤(T.Chol)', '0 ~ 199', '220'),
//     BodyComposition('혈당(Glucose)', '74 ~ 100', '108'),
//     BodyComposition('중성 지방(Triglyceride)', '0~149', '177'),
//   ];
// }
//
// class BodyComposition {
//   late String mainLabel;
//   late String baselineValue;
//   late String measurements;
//
//   BodyComposition(this.mainLabel, this.baselineValue, this.measurements);

// /// 체성분 리스트 아이템
// class BodyCompositionListItem extends StatelessWidget {
//   const BodyCompositionListItem(
//       {super.key,
//       required this.bodyComposition});
//
//   final BodyComposition bodyComposition;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       margin: const EdgeInsets.only(top: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// 측정 항목
//               Frame.myText(
//                 text: bodyComposition.mainLabel,
//                 fontSize: 1.2,
//                 fontWeight: FontWeight.bold
//               ),
//
//               /// 기준 수치
//               Frame.myText(
//                   text: '기준 수치: ${bodyComposition.baselineValue}mg/dL',
//                   fontSize: 1.0,
//               ),
//             ],
//           ),
//
//           /// 실제 측정수치
//           Row(
//             children: [
//               Frame.myText(
//                 text: bodyComposition.measurements,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 1.3,
//                 color: Colors.redAccent
//               ),
//               Frame.myText(
//                   text: ' mg/dl',
//                   fontSize: 1.3
//               ),
//               const Gap(10),
//               Image.asset('images/arrow_blue.png',
//                   height: 25, width: 25),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

