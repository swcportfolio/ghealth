import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../data/models/mydata_predict_data.dart';
import '../../widgets/frame.dart';

class AiDiseasePredictionResults extends StatelessWidget {
  const AiDiseasePredictionResults({super.key, required this.mydataPredict});

  final MyDataPredictData mydataPredict;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Frame.myText(
                text: 'AI 질환 예측 결과',
                fontSize: 1.3,
                fontWeight: FontWeight.w600),
            const Gap(5),
            Frame.myText(
              text: '유전체+건강검진이력+라이프로그 데이터를 결합한 예측결과로 주의를 받은 항목입니다.',
              softWrap: true,
              maxLinesCount: 2,
              fontSize: 1.0,
            ),
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildPredictionItem('관절',
                    mydataPredict.bone == '0'
                        ? Colors.greenAccent
                        : Colors.redAccent),
                const Gap(10),
                buildPredictionItem('당뇨병',
                    mydataPredict.diabetes == '0'
                        ? Colors.greenAccent
                        : Colors.redAccent),
                const Gap(10),
                buildPredictionItem('눈건강',
                    mydataPredict.eye == '0'
                        ? Colors.greenAccent
                        : Colors.redAccent),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildPredictionItem('고혈압',
                    mydataPredict.highpress == '0'
                        ? Colors.greenAccent
                        : Colors.redAccent),
                const Gap(10),
                buildPredictionItem('면역',
                    mydataPredict.immune == '0'
                        ? Colors.greenAccent
                        : Colors.redAccent),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildPredictionItem(String label, Color borderColor) {
    return Container(
      height: 35,
      width: 80,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor, width: 1)),
      child: Center(
        child: Frame.myText(
          text: label,
          fontSize: 1.0,
        ),
      ),
    );
  }
}
