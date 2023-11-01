
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/frame.dart';

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

              buildRecordDetail()
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
        const Gap(5),
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
          fontSize: 2.0
        ),
        const Gap(10),

        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Frame.myText(
                    text: '클릭하시면 자세한 결과를 보실수 있습니다.'
                  ),

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
              child: Image.asset('images/sight_text_box.png',height: 70, width: 170),
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
              top: 100,
              left: 10,
              child: Image.asset('images/kidneys_text_box.png',height: 70, width: 170),
            ),
            Positioned(
              top: 100,
              left: 10,
              child: Image.asset('images/pee_text_box.png',height: 70, width: 70),
            ),
            Positioned(
              top: 100,
              left: 10,
              child: Image.asset('images/walking_text_box.png',height: 70,width: 170),
            ),


          ],
        )
      ],
    );
  }
}
