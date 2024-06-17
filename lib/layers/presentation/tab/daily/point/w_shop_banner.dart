

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../../entity/product_dto.dart';
import '../../../../model/authorization_test.dart';
import '../../../widgets/style_text.dart';


/// GHealth 쇼핑몰 광고 및 웹 링크 전환 위젯
class ShopBanner extends StatelessWidget {
  final List<ProductDataDTO> productList;

  const ShopBanner({
    super.key,
    required this.productList,
  });

  double get boxHeight => 300;
  String get title1 => '${AuthorizationTest().userName} 님에게는';
  String get title2 => ' 이런 건강식품을 추천해드려요!';

  @override
  Widget build(BuildContext context) {
    return Container(
        height: boxHeight,
        margin: const EdgeInsets.all(AppDim.small),
        padding: const EdgeInsets.only(top: AppDim.mediumLarge),
        decoration: BoxDecoration(
          borderRadius: AppConstants.borderMediumRadius,
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
                    const Gap(AppDim.large),

                    StyleText(
                        text: title1,
                        fontWeight: FontWeight.bold,
                    ),
                    StyleText(
                        text: title2,
                        color: AppColors.primaryColor,
                        fontWeight: AppDim.weightBold,
                       )
                  ],
                ),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: AppConstants.radius,
                        topRight: AppConstants.radius,
                        bottomLeft: AppConstants.mediumRadius,
                        bottomRight: AppConstants.mediumRadius,
                      ),
                      color: AppColors.primaryColor,
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
                                borderRadius: AppConstants.borderMediumRadius,
                            ),
                            child: ClipRRect(
                              borderRadius: AppConstants.borderLightRadius,
                              child: Image.memory(
                                Uri.parse(productList[0].productImg).data!.contentAsBytes(),
                                fit: BoxFit.cover,
                              ),
                            )
                        ),
                      ),
                      const Gap(AppDim.small),

                      Expanded(
                        flex: 1,
                        child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: AppConstants.borderMediumRadius,
                            ),
                            child: ClipRRect(
                              borderRadius: AppConstants.borderLightRadius,
                              child: Image.memory(
                                Uri.parse(productList[1].productImg).data!.contentAsBytes(),
                                fit: BoxFit.cover,
                              ),
                            )
                        ),
                      ),
                    ],
                  )
              ),
            ),

            /// 상품 Row
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
                          StyleText(
                              text: productList[0].title,
                              color: Colors.white,
                              size: AppDim.fontSizeSmall,
                              softWrap: true,
                              maxLinesCount: 2

                          ),
                          StyleText(
                              text: '${productList[0].price}P',
                              color: Colors.white,
                              fontWeight: AppDim.weightBold,
                          ),
                        ],
                      ),
                    ),
                    const Gap(AppDim.small),

                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StyleText(
                              text: productList[1].title,
                              color: Colors.white,
                              size: AppDim.fontSizeSmall,
                              softWrap: true,
                              maxLinesCount: 2

                          ),
                          StyleText(
                            text: '${productList[1].price}P',
                            color: Colors.white,
                            fontWeight: AppDim.weightBold,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            /// 샵 이동 버튼
            Positioned(
              child: InkWell(
                onTap: ()=> Nav.doLaunchUniversalLink(Uri(
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
                          borderRadius: AppConstants.borderRadius,
                          color: AppColors.white,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StyleText(
                                text: 'GHealth 샵으로 이동',
                                fontWeight: AppDim.weightBold,
                              size: AppDim.fontSizeSmall,
                            ),
                            Gap(AppDim.small),

                            Icon(
                                Icons.arrow_forward_ios,
                                size: AppDim.iconXxSmall,
                            )
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