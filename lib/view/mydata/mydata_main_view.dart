
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/mydata/prescription_history_widget.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../login/login_view.dart';
import 'ai_disease_prediction_results_widget.dart';
import 'blood_test_result_widget.dart';
import 'health_checkup_comprehensive_widget.dart';
import 'metrology_inspection_widget.dart';
import 'my_result_report_viewmodel.dart';


/// 마이데이터(나의 건강기록) 화면
/// 1. 건겅검진 종합소견
/// 2. 혈약검사
/// 3. 계측 검사
/// 4. AI질환 얘측 결과
/// 5. 처방 이력
class MyDataMainView extends StatefulWidget {
  const MyDataMainView({super.key});

  @override
  State<MyDataMainView> createState() => _MyDataMainViewState();
}

class _MyDataMainViewState extends State<MyDataMainView> {

  late MyDataMainViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MyDataMainViewModel(context);
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

      body: ChangeNotifierProvider<MyDataMainViewModel>(
        create: (BuildContext context) => _viewModel,
        child: FutureBuilder(
          future: _viewModel.handleHealthSummary(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasError){
              return Frame.buildFutureBuilderHasError(
                  snapshot.error.toString(), ()=> {}
              );
            }
            else if(snapshot.connectionState == ConnectionState.done
                && snapshot.data == null) {
             return Frame.buildCommonEmptyView('현재 조회된 마이데이터가 없습니다.');
            }
            else if(snapshot.hasData) {
              return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        /// 페이지 안내 메시지 Top
                        buildTopPhraseWidget(),
                        const Gap(15),

                        /// 건강검진 종합 소견
                        HealthCheckUpComprehensiveWidget(
                          comprehensiveOpinionText: _viewModel.comprehensiveOpinionText,
                          lifestyleManagementText: _viewModel.lifestyleManagementText,
                          issuedDate: _viewModel.issuedDate,
                        ),
                        const Gap(5),

                        /// 혈액 검사 결과 위젯
                        BloodTestResultWidget(bloodTest: _viewModel.bloodTest),
                        const Gap(15),

                        /// 계측 검사 위젯
                        MetrologyInspectionWidget(
                            metrologyInspection: _viewModel.metrologyInspection),
                        const Gap(5),

                        /// AI 질환 예측 결과
                        AiDiseasePredictionResultWidget(mydataPredict: _viewModel.mydataPredict),
                        const Gap(5),

                        /// 처방 이력
                        PrescriptionHistoryWidget(
                            medicationInfoList: _viewModel.medicationInfoList),
                        const Gap(15),
                      ],
                    ),
                  )
              );
            } else {
              return Frame.buildFutureBuildProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  /// 마이데이터 (나의 건강기록) 상단 안내 메시지
  Widget buildTopPhraseWidget(){
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
                    text:'나의 건강 기록',
                    maxLinesCount: 2,
                    color: mainColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.9
                )
              ],
            )
          ]
      ),
    );
  }
}







