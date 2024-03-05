import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/point/my_health_point_view.dart';

import '../../utils/colors.dart';
import '../../utils/text_formatter.dart';
import '../../widgets/frame.dart';

class HealthPointBoxWidget extends StatelessWidget {
  const HealthPointBoxWidget({super.key, required this.totalPoint});
  final String totalPoint;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ()=> Frame.doPagePush(context, MyHealthPointView(totalPoint: totalPoint)),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
              width: double.infinity,
              height: 130,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: SizedBox(
                        width: double.infinity,
                        child: Frame.myText(
                            text: '나의 건강포인트',
                            color: Colors.white,
                            fontSize: 1.2,
                            fontWeight: FontWeight.w600),
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
                            child: Image.asset('images/point.png',
                                color: mainColor, height: 40, width: 40),
                          ),
                          const Gap(5),
                          Frame.myText(
                            text: '${TextFormatter.formatNumberWithCommas(int.parse(totalPoint))}P',
                            fontSize: 1.8,
                            fontWeight: FontWeight.w500,
                          ),
                          const Gap(10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Frame.myText(text: '나의 건강 포인트 확인하고'),
                              Frame.myText(
                                  text: '저렴하게 진료받으세요!',
                                  fontWeight: FontWeight.w600),
                            ],
                          )
                        ],
                      ),
                    ),
                  ])),
        ),
      ),
    );
  }
}
