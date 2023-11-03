
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../../widgets/horizontal_dashed_line.dart';
import 'ai_disease_prediction_view.dart';

/// 건강검진 기록 화면
class ExaminationRecordView extends StatefulWidget {
  const ExaminationRecordView({super.key});

  @override
  State<ExaminationRecordView> createState() => _ExaminationRecordViewState();
}

class _ExaminationRecordViewState extends State<ExaminationRecordView> {
  final String title = '건강검진 기록 전체 보기';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: CustomAppBar(title: title),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitleLabel(),
              const Gap(25),

              ///임시
              Image.asset('images/examination_1.png'),
              const Gap(20),

              buildRecordDetail(),
              buildAtGlance()
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
            color: Colors.black,
            fontSize: 2.1,
            fontWeight: FontWeight.w600)
      ],
    );
  }

  /// 건강검진기록 자세히 보기
  buildRecordDetail(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Frame.myText(
          text: '건강검진 기록 자세히 보기',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 1.5
        ),
        const Gap(10),

        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 580,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Frame.myText(
                    text: '클릭하시면 자세한 결과를 보실수 있습니다.',
                    color: Colors.grey.shade600,
                    fontSize: 1.1
                  ),
                  const Gap(15),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('images/person_body.png', height: 460, width: 180,),
                  )
                ],
              ),
            ),

            Positioned(
              top: 100,
              left: 10,
              child: InkWell(
                  onTap: ()=> Frame.doPagePush(context, const AiDiseasePredictionView()),
                  child: Image.asset('images/sight_text_box.png',height: 70, width: 170)),
            ),
            Positioned(
              top: 50,
              right: 10,
              child: Image.asset('images/brain_text_box.png',height: 70, width: 170),
            ),
            Positioned(
              top: 150,
              right: 20,
              child: Image.asset('images/blood_text_box.png',height: 70, width: 120),
            ),
            Positioned(
              top: 200,
              left: 10,
              child: Image.asset('images/kidneys_text_box.png',height: 70, width: 170),
            ),
            Positioned(
              top: 220,
              right: 40,
              child: Image.asset('images/pee_text_box.png',height: 200, width: 130),
            ),
            Positioned(
              top: 480,
              left: 20,
              child: Image.asset('images/walking_text_box.png',height: 70,width: 140),
            ),


          ],
        )
      ],
    );
  }


  /// 한눈에 보기[총콜레스테롤, 혈당, 중성지방]
  buildAtGlance(){
    return Container(
      height: 350,
      margin: const EdgeInsets.only(top: 20, bottom: 15),
      child: Card(
        color: reservedCardBgColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20 , 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('images/exclamation_mark_red.png',
                      width: 25, height: 25),
                  const Gap(8),
                  Frame.myText(
                    text: '주의 항목 ',
                    fontSize: 1.3,
                    color: Colors.redAccent,
                  ),
                  Frame.myText(
                    text: '한눈에 보기',
                    fontSize: 1.3,
                  )
                ],
              ),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: sampleBodyCompositionList.length,

                  itemBuilder: (BuildContext context, int index) {
                  return BodyCompositionListItem(bodyComposition: sampleBodyCompositionList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const HorizontalDottedLine(mWidth: 200);
                  } ,
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

  List<BodyComposition> sampleBodyCompositionList = [
    BodyComposition('총콜레스테롤(T.Chol)', '0 ~ 199', '220'),
    BodyComposition('혈당(Glucose)', '74 ~ 100', '108'),
    BodyComposition('중성 지방(Triglyceride)', '0~149', '177'),
  ];
}

class BodyComposition {
  late String mainLabel;
  late String baselineValue;
  late String measurements;

  BodyComposition(this.mainLabel, this.baselineValue, this.measurements);

}

/// 체성분 리스트 아이템
class BodyCompositionListItem extends StatelessWidget {
  const BodyCompositionListItem(
      {super.key,
      required this.bodyComposition});

  final BodyComposition bodyComposition;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 측정 항목
              Frame.myText(
                text: bodyComposition.mainLabel,
                fontSize: 1.2,
                fontWeight: FontWeight.bold
              ),

              /// 기준 수치
              Frame.myText(
                  text: '기준 수치: ${bodyComposition.baselineValue}mg/dL',
                  fontSize: 1.0,
              ),
            ],
          ),

          /// 실제 측정수치
          Row(
            children: [
              Frame.myText(
                text: bodyComposition.measurements,
                fontWeight: FontWeight.bold,
                fontSize: 1.3,
                color: Colors.redAccent
              ),
              Frame.myText(
                  text: ' mg/dl',
                  fontSize: 1.3
              ),
              const Gap(10),
              Image.asset('images/arrow_blue.png',
                  height: 25, width: 25),
            ],
          )
        ],
      ),
    );
  }
}

