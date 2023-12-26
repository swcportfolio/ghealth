import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/view/lifelog/test_result_body_widget.dart';
import 'package:ghealth_app/widgets/frame.dart';
import '../../data/models/authorization.dart';
import '../../utils/colors.dart';
import '../../utils/etc.dart';
import '../login/login_view.dart';
import 'health_point_box_widget.dart';


/// 라이프로그 메인 화면
/// 건강 관리소에서 측정된 결과 데이터를 확인할 수 있습니다.
class LifeLogMainView extends StatefulWidget {
  const LifeLogMainView({super.key});

  @override
  State<LifeLogMainView> createState() => _MyHealthRecordViewState();
}

class _MyHealthRecordViewState extends State<LifeLogMainView> {

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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 페이지 안내 메시지 Top
              buildLifeLogTopPhrase(),

              /// 건강 포인트
              //HealthPointBoxWidget(),

              const Gap(30),

              /// 라이프로그 검사 결과 자세히 보기 (전신 그림)
              const TestResultsBodyWidget(),
            ],
          ),
        ),
      ),
    );
  }

  /// 페이지 상단 안내 메시지 위젯
  Widget buildLifeLogTopPhrase() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                  text: '안녕하세요. ${Authorization().userName}님!',
                  fontSize: 1.2,
                  fontWeight: FontWeight.w500,
                ),
                const Gap(5),
                Frame.myText(
                    text: '나의 라이프로그 기록',
                    maxLinesCount: 2,
                    color: mainColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.9)
              ],
            )
          ]),
    );
  }
}


