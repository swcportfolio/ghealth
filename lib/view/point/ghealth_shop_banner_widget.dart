

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../data/models/authorization.dart';
import '../../utils/colors.dart';
import '../../widgets/frame.dart';

/// GHealth 쇼핑몰 광고 및 웹 링크 전환 위젯
class GHealthShopBannerWidget extends StatelessWidget {
  const GHealthShopBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 270,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: const Color(0xfff8f8ff),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Gap(20),
                    Frame.myText(
                        text: '${Authorization().userName} 님에게는',
                        fontWeight: FontWeight.bold,
                        fontSize: 1.1),
                    Frame.myText(
                        text: ' 이런 건강식품을 추천해드려요!',
                        color: mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 1.1)
                  ],
                ),
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0),
                      ),
                      color: mainColor
                  ),
                )

              ],
            ),

            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 35, left: 20, right: 25),
                child: Image.asset('images/shop_image.png'),
              ),
            ),

            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 150, left: 20, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Frame.myText(
                            text: '프라임 혈당 핏플러스',
                            color: Colors.white,
                            fontSize: 1.1
                        ),
                        Frame.myText(
                            text: '72,000P',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 1.1
                        ),
                      ],
                    ),
                    const Gap(30),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Frame.myText(
                            text: '프라임 홍삼핏',
                            color: Colors.white,
                            fontSize: 1.1
                        ),
                        Frame.myText(
                            text: '130,000P',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 1.1
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            Positioned(
              child: InkWell(
                onTap: ()=> Frame.doLaunchUniversalLink(Uri(
                  scheme: 'https',
                  host: 'shop.ghealth.or.kr',
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Frame.myText(
                                text: 'GHealth 샵으로 이동',
                                fontWeight: FontWeight.w600
                            ),
                            const Gap(10),
                            const Icon(Icons.arrow_forward_ios, size: 13)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}