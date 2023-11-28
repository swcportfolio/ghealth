import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/colors.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';


/// AI 질환 예측 화면
class AiDiseasePredictionView extends StatefulWidget {
  const AiDiseasePredictionView({super.key});

  @override
  State<AiDiseasePredictionView> createState() => _AiDiseasePredictionViewState();
}

class _AiDiseasePredictionViewState extends State<AiDiseasePredictionView> {
  final String title = 'AI 질환 예측 결과';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: title, isIconBtn: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitleText(),
              buildAiPrediction(),
              const Gap(20),

              Image.asset('images/ai_result_ex_1.png')
            ],
          ),
        ),
      ),
    );

  }

  /// 나의 질환 예측결과 타이틀 텍스트
  buildTitleText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Frame.myText(
              text: 'AI가 진단한',
              color: mainColor,
              fontSize: 1.4,
              fontWeight: FontWeight.bold),
          Frame.myText(
              text: '나의 질환 예측 결과',
              fontSize: 1.4,
              fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  /// 예측 결과[pie graph, indicator]
  buildAiPrediction() {
    return Container(
      height: 450,
      margin: const EdgeInsets.only(top: 20, bottom: 15),
      child: Card(
        color: reservedCardBgColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset('images/ai_result_ex.png', fit: BoxFit.cover,)),
            const Gap(10),

             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildVerticalIndicator(' 당뇨 ', '경고', 0.9, Colors.red, Colors.red),
                  buildVerticalIndicator('심근경색', '주의', 0.6, Colors.yellow, Colors.black),
                  buildVerticalIndicator('신장질환', '안정', 0.3, Colors.blue, Colors.black),
                  buildVerticalIndicator('심장질환', '주의', 0.6, Colors.red, Colors.red),
                  buildVerticalIndicator('간질환', '안정', 0.3, Colors.blueAccent, Colors.black),
                ],
            ),
             )
          ],
        ),
      ),
    );
  }

  Widget buildVerticalIndicator(
      String footerText,
      String statusText,
      double percent,
      Color indicatorColor,
      Color statusTextColor) {
    return Column(
      children: [
           VerticalBarIndicator(
          animationDuration: const Duration(seconds: 1),
          percent: percent,
          height: 130,
          width: 18,
          color: [indicatorColor,indicatorColor],
          footer: footerText,
          footerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),

        /// 상태 단계[경고, 주의, 안정]
        Frame.myText(
            text: statusText,
            color: statusTextColor,
            fontSize: 0.9
        )
      ],
    );
  }
}
