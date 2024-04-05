

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/product_data_response.dart';
import 'package:provider/provider.dart';

import '../../data/models/authorization.dart';
import '../../data/models/product_data.dart';
import '../../utils/colors.dart';
import '../../widgets/frame.dart';
import 'my_health_point_viewmodel.dart';



/// GHealth 쇼핑몰 광고 및 웹 링크 전환 위젯
class GHealthShopBannerWidget extends StatelessWidget {
  const GHealthShopBannerWidget({super.key, required this.viewModel});
  final MyHealthPointViewModel viewModel;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewModel.handleProductDio(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Frame.myText(
                text:'상품을 불러오지 못했습니다.'
              ),
            ),
          ); //Frame.buildFutureBuilderHasError(snapshot.error.toString(), () => {});
        }
        else if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<MyHealthPointViewModel>(
            builder: (BuildContext context, value, Widget? child) {
              return value.productList.isEmpty
                  ? Center(
                  child: Frame.myText(text: '추천 상품이 없습니다.'))
                  : buildContainer(value.productList);
            },
          );
        } else {
          return Frame.buildFutureBuildProgressIndicator();
        }
      },
    );
  }

  Widget buildContainer(List<ProductData> productList) {
    return Container(
        height: 300,
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(width: 2.0, color: Colors.grey.shade200)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child:
                            Image.memory(
                              Uri.parse(viewModel.productList[0].productImg).data!.contentAsBytes(),
                              fit: BoxFit.cover,
                            ),

                            // Frame.buildExtendedImage(
                            //     viewModel.animationController,
                            //     viewModel.productList[0].productImg, double.infinity),
                          )
                      ),
                    ),
                    const Gap(10),

                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(width: 2.0, color: Colors.grey.shade200)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.memory(
                              Uri.parse(viewModel.productList[1].productImg).data!.contentAsBytes(),
                              fit: BoxFit.cover,
                            ),
                          )
                      ),
                    ),
                  ],
                )
              ),
            ),

            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 170, left: 20, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(10),

                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Frame.myText(
                              text: productList[0].title,
                              color: Colors.white,
                              fontSize: 0.9,
                            softWrap: true,
                            maxLinesCount: 2

                          ),
                          Frame.myText(
                              text: '${productList[0].price}P',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 1.1
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),


                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Frame.myText(
                              text: productList[0].title,
                              color: Colors.white,
                              fontSize: 0.9,
                              softWrap: true,
                              maxLinesCount: 2
                          ),
                          Frame.myText(
                              text: '${productList[1].price}P',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 1.1
                          ),
                        ],
                      ),
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
                  padding: const EdgeInsets.only(top: 235),
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