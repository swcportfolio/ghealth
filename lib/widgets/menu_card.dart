import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../utils/colors.dart';

class MenuCard1 extends StatelessWidget {
  const MenuCard1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: Card(
        color: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Frame.myText(
                text: '나의 건강 정보\n종합결과지',
                fontSize: 1.9,
                maxLinesCount: 2,
                color: Colors.white,
                align: TextAlign.left,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuCard2 extends StatelessWidget {
  const MenuCard2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: Card(
        color: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Frame.myText(
                text: '방문 예약하기\n예약내역',
                fontSize: 1.9,
                maxLinesCount: 2,
                color: Colors.white,
                align: TextAlign.left,
                fontWeight: FontWeight.w600,
              ),
              const Gap(15),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('images/hospital_white.png', height: 100, width: 100),
                ],
              ),
              const Gap(10),

              Container(
                height: 90,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Frame.myText(
                          text: '지난 방문 내역',
                          color: Colors.black,
                          fontSize: 0.9
                        ),
                        const Gap(20),
                        Frame.myText(
                            text: '2023-09-09',
                            color: Colors.black,
                            fontSize: 1.1
                        ),
                      ],
                    ),
                    const Gap(10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Frame.myText(
                            text: '방문 예약 내역',
                            color: Colors.black,
                            fontSize: 0.9
                        ),
                        const Gap(20),
                        Frame.myText(
                            text: '2023-10-09',
                            color: Colors.black,
                            fontSize: 1.1
                        ),
                      ],
                    )
                  ],

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class MenuCard3 extends StatelessWidget {
  const MenuCard3({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: Card(
        color: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Frame.myText(
                text: '식습관 관리\n서비스',
                maxLinesCount: 2,
                color: Colors.white,
                fontSize: 1.9,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
        ),
      ),
    );
  }
}
