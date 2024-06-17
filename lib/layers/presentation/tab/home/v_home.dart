import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/tab/home/w_home_header.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_view_padding.dart';

import '../../../../common/data/validate/auth_validation_mixin.dart';
import '../../../../main.dart';
import '../../../model/authorization_test.dart';
import 'support_service_button.dart';
import 'w_move_site_buttons.dart';


/// 홈화면
class HomeViewTest extends StatefulWidget {
  const HomeViewTest({super.key});

  @override
  State<HomeViewTest> createState() => _HomeViewTestState();
}

class _HomeViewTestState extends State<HomeViewTest> with AuthValidationMixin{

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewPadding(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            /// 홈 헤더
            const HomeHeader(),

            /// 동구, 광산구 예약버튼
            const MoveSiteButtons(),
            const Gap(AppDim.large),

            /// 서비스 지원 버튼
            const SupportServiceButton(),
            const Gap(AppDim.large),

            /// 협력사 이미지
            poImage(),
          ],
        ),
      )
    );
  }


  /// PO: Participating organizations - 참여기관
  Widget poImage() => Image.asset('images/organizations.png');
}













