import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/view/point/point_history_list_widget.dart';
import 'package:ghealth_app/view/point/point_search_view.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:provider/provider.dart';

import '../../data/models/authorization.dart';
import '../../utils/colors.dart';
import '../../utils/etc.dart';
import '../aihealth/health_point_box_widget.dart';
import '../login/login_view.dart';
import 'ghealth_shop_banner_widget.dart';
import 'my_health_point_viewmodel.dart';

/// 나의 건강 포인트 화면
class MyHealthPointView extends StatefulWidget {
  const MyHealthPointView({
    super.key,
    required this.totalPoint
  });
  final String totalPoint;

  @override
  State<MyHealthPointView> createState() => _MyHealthPointViewState();
}

class _MyHealthPointViewState extends State<MyHealthPointView> {

  late MyHealthPointViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MyHealthPointViewModel(context, 1);
  }


  @override
  Widget build(BuildContext context) {

    /// AccessToken 확인
    Authorization().checkAuthToken().then((result) {
      if(!result){
        Etc.commonSnackBar('권한 만료, 재 로그인 필요합니다.', context, seconds: 6);
        Frame.doPagePush(context, const LoginView());
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '나의 건강 포인트',
        isIconBtn: false,
      ),

      body: ChangeNotifierProvider(
        create: (BuildContext context) => _viewModel,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Column(
              children: [

                /// 포인트 설명 헬퍼
                buildPointDescription(),

                /// 건강 포인트 위젯
                HealthPointBoxWidget(totalPoint: widget.totalPoint),
                const Gap(10),

                /// 포인트 적립 / 차감 내역
                buildPointHistory(),
                const Gap(15),

                /// 포인트 Q&A
                buildPointAccumulateMethod(),

                /// GHealth 쇼핑몰 광고 및 웹 링크 전환
                const GHealthShopBannerWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 포인트 설명 글 헬퍼
  Widget buildPointDescription() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Frame.myText(
            text: '건강 포인트란?',
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontSize: 1.8,
            align: TextAlign.start,
          ),
          const Gap(10),

          Frame.myText(
            text: '건강은 우리 삶의 중요한 부분이며,\n그걸 더 쉽게 관리하고 보호하기 위해 Ghealth \n앱을 소개합니다! 이 앱은 건강한 라이프스타일을\n증진하고, 그 노력에 보상을 제공합니다.',
            fontSize: 1.0,
            align: TextAlign.start,
            maxLinesCount: 5,
            softWrap: true,
          )
        ],
      ),
    );
  }

  /// 현재 포인트 정보를 나타내는 헬퍼
  Widget buildCurrentPointBox() {
    return Container(
      height: 210,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        color: mainColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // 사용가능한 포인트 Text
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Frame.myText(
                          text: '사용가능한 포인트',
                          color: Colors.white,
                          fontSize: 1.2
                      ),
                      const Gap(10),
                      Frame.myText(
                          text: '${Etc.formatNumberWithCommas(int.parse(widget.totalPoint))}P',
                          color: Colors.white,
                          fontSize: 2.5,
                          fontWeight: FontWeight.w600
                      ),
                    ],
                  ),
                ),

                // 포인트 Image
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                      'images/point_image.png',
                      height: 110,
                      width: 110
                  ),
                )
              ],
            ),

            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
                child: Center(
                  child: Frame.myText(
                      text: '포인트 사용처',
                      fontSize: 1.1
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 포인트 사용/적립 내역을 나타내는 헬퍼
  Widget buildPointHistory(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Frame.myText(
                text: '포인트 적립 / 차감 내역',
                fontSize: 1.3,
                fontWeight: FontWeight.w600,
              ),

              InkWell(
                onTap: ()=> Frame.doPagePush(context, const PointSearchView()),
                child: Row(
                  children: [
                    Frame.myText(
                      text: '더보기',
                      fontSize: 0.9,
                      color: Colors.grey
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14)
                  ],
                ),
              ),
            ],
          ),
        ),

        const Gap(10),
        SizedBox(
          height: 190,
          child: PointHistoryListWidget(viewModel:_viewModel, listCount: 2),
        ),
      ],
    );
  }

  /// 포인트 적립 방법 헬퍼
  Widget buildPointAccumulateMethod() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Frame.myText(
                text: '포인트 Q&A',
                fontSize: 1.3,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color(0xfff4f4f4)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    color: Colors.white
                ),
                child: Frame.myText(
                    text: "포인트 어떻게 적립하나요?",
                    fontWeight: FontWeight.w600
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Frame.myText(
                    text: "1.Ghealth 앱의 걸음 수 챌린지에 참여하여 매일 목표 걸음 수를 달성하세요. 적립된 포인트는 건강한 신체 활동으로 보상됩니다. 걷기는 즐겁고 효과적인 운동이니, 일상 속에서 건강 포인트를 쌓아보세요!\n\n2.수면은 건강에 중요한 역할을 합니다. Ghealth 앱은 수면 기록을 통해 규칙적인 수면 습관을 만들도록 도와줍니다. 잠을 충분히 취함으로써 얻는 건강한 생활을 경험하며, 그에 따른 포인트를 획득하세요.\n\n3. Ghealth 앱을 통해 건강관리소 방문 시 포인트를 더욱 효과적으로 쌓을 수 있는 기회가 주어집니다!",
                    fontSize: 0.9,
                    softWrap: true,
                    maxLinesCount: 700
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

