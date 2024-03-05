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
import '../../utils/snackbar_utils.dart';
import '../../utils/text_formatter.dart';
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

class _MyHealthPointViewState extends State<MyHealthPointView> with TickerProviderStateMixin {

  late MyHealthPointViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MyHealthPointViewModel(
        context, 1,
        AnimationController(
            vsync: this,
            duration: const Duration(seconds: 1),
            lowerBound: 0.0,
            upperBound: 1.0));
  }


  @override
  Widget build(BuildContext context) {

    /// AccessToken 확인
    Authorization().checkAuthToken().then((result) {
      if(!result){
        SnackBarUtils.showBGWhiteSnackBar(
            '권한 만료, 재 로그인 필요합니다.', context);
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
                GHealthShopBannerWidget(viewModel: _viewModel)
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
            text: '건강포인트"는 G-Health 플랫폼에서 제공되는 \n다양한 재화와 서비스를 구매·이용할 수 있는 현금처럼\n사용가능한 가상의 화폐입니다.',
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
                          text: '${TextFormatter.formatNumberWithCommas(int.parse(widget.totalPoint))}P',
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
                onTap: ()=> Frame.doPagePush(context, PointSearchView(viewModel: _viewModel)),
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
                    text: '<포인트 정책>\n- 회원가입 및 라이프로그 장비 측정 : 5,000p\n- 마이데이터 제공 : 5,000p\n- 진단서, 처방전 등록 : 5,000p(유효기간 3년 이내 고혈압, 당뇨 진단서, 처방전 한하며 1인 1회 포인트 제공)\n- 일일 출석체크 : 30p\n- 일일 건강퀴즈 :  20p\n- 걷기 챌린지 : 200p(1일 목표걸음 8천보, 1주일 중 4일 이상 달성 시 지급)\n- 영상시청 후 퀴즈풀기 : 50p',
                    fontSize: 0.95,
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

