import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/view/aihealth/aihealth_main_viewmodel.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../data/models/authorization.dart';
import '../../utils/colors.dart';
import '../../utils/etc.dart';
import '../../utils/snackbar_utils.dart';
import '../../widgets/list_item/predict_list_item.dart';
import '../login/login_view.dart';


/// AI건강예측 화면
/// 마이데이터 기반 AI건강 예측 서비스
class AiHealthMainView extends StatefulWidget {
  const AiHealthMainView({super.key});

  @override
  State<AiHealthMainView> createState() => _AiHealthMainViewState();
}

class _AiHealthMainViewState extends State<AiHealthMainView> {
  late AiHealthMainViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _viewModel = AiHealthMainViewModel();
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
      body: ChangeNotifierProvider(
        create: (BuildContext context) => _viewModel,
        child: FutureBuilder(
          future: _viewModel.handleAiHealth(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasError){
              return Frame.buildFutureBuilderHasError(
                  snapshot.error.toString(), ()=> {}
              );
            }
            else if(snapshot.connectionState == ConnectionState.done
                && snapshot.data == null) {
              return Frame.buildCommonEmptyView('현재 조회된 AI 건강예측\n데이터가 없습니다.');
            }
            else if(snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 페이지 안내 메시지 Top
                      buildAiHealthTopPhrase(),
                      const Gap(20),

                      buildAiHealthResultBody(),
                      const Gap(20),
                      buildAiHealthResultBody2(),
                    ],
                  ),
                ),
              );
            }
            else {
              return Frame.buildFutureBuildProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  /// 페이지 상단 안내 메시지 위젯
  Widget buildAiHealthTopPhrase() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Frame.myText(
                    text: 'AI 건강 예측',
                    maxLinesCount: 2,
                    color: mainColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.9
                ),
                const Gap(5),
                Frame.myText(
                  text: '발병 예측 확률을 보여줍니다.',
                  fontSize: 1.1,
                ),
              ],
            )
          ]),
    );
  }

  Widget buildAiHealthResultBody() {
    return Container(
      width: double.infinity,
      height: 450,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1.5, color: Colors.grey.shade200)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Frame.myText(
              text:'AI 예측 결과',
              fontWeight: FontWeight.w600,
              fontSize: 1.3
            ),
          ),

          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),

            child: Consumer<AiHealthMainViewModel>(
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  children: [
                    PredictListItem(title: '관절', indicatorColor: Colors.red, percent: double.parse(value.aiHealthData.boneProb)),
                    PredictListItem(title: '당뇨병', indicatorColor: Colors.red, percent: double.parse(value.aiHealthData.diabetesProb)),
                    PredictListItem(title: '눈건강', indicatorColor: Colors.red, percent: double.parse(value.aiHealthData.eyeProb)),
                    PredictListItem(title: '고혈압', indicatorColor: aiHealthBg, percent: double.parse(value.aiHealthData.highpressProb)),
                    PredictListItem(title: '면역', indicatorColor: aiHealthBg, percent: double.parse(value.aiHealthData.immuneProb)),
                  ],
                );
              },
            )
          )
        ],
      ),
    );
  }
  Widget buildAiHealthResultBody2() {
    return Container(
      width: double.infinity,
      height: 380,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1.5, color: Colors.grey.shade200)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Frame.myText(
                text:'AI 질환 예측 나이',
                fontWeight: FontWeight.w600,
                fontSize: 1.3
            ),
          ),

          Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Consumer<AiHealthMainViewModel>(
                  builder: (BuildContext context, value, Widget? child) {
                return Column(
                  children: [
                    PredictAgeListItem(title: '고혈압', age: value.aiHealthData.hypertensionAge),
                    PredictAgeListItem(title: '당뇨병', age: value.aiHealthData.diabetesAge),
                    PredictAgeListItem(title: '비만', age: value.aiHealthData.obesityAge),
                    PredictAgeListItem(title: '간', age: value.aiHealthData.liverAge),
                  ],
                );
              }))
        ],
      ),
    );
  }



  Widget buildPredictionResultItem(String title, Color indicatorColor, double percent) {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(bottom: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Frame.myText(
                text: title,
                align: TextAlign.center,
                maxLinesCount: 2,
                fontSize: 0.9
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearPercentIndicator(
                  animation: true,
                  animationDuration: 100,
                  lineHeight: 18.0,
                  percent: percent,
                  progressColor: indicatorColor,
                backgroundColor: Colors.grey.shade300,
                  barRadius: const Radius.circular(10),
                ),
                const Gap(10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Frame.myText(
                        text: '${(percent*100).toInt()}%예측',
                        color: (percent*100).toInt() >=50 ? Colors.red : Colors.black,
                        fontSize: 1.0,
                        fontWeight: FontWeight.w500
                      ),

                      Container(
                        height: 22,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(width: 1, color: Colors.black)
                        ),
                        child: Center(
                          child: Frame.myText(
                            text: '45세 발생 예상',
                            fontSize: 0.85
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


