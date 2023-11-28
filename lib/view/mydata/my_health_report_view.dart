
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/mydata/prescription_history_widget.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../join/login_view.dart';
import 'ai_disease_prediction_results_widget.dart';
import 'blood_test_result_widget.dart';
import 'health_checkup_result_widget.dart';
import 'metrology_inspection_widget.dart';
import '../report/my_health_topphrase_widget.dart';
import 'my_result_report_viewmodel.dart';

/// 마이데이터 화면
class MyHealthReportView extends StatefulWidget {
  const MyHealthReportView({super.key});

  @override
  State<MyHealthReportView> createState() => _MyHealthReportViewState();
}

class _MyHealthReportViewState extends State<MyHealthReportView> {

  late MyHealthReportViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = MyHealthReportViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    Authorization().checkAuthToken().then((result){
      // Etc.showSnackBar('권한이 만료 되었습니다. 재 로그인이 필요합니다.', context, seconds: 5);
      // Frame.doPagePush(context, const LoginView());
    });

    return Scaffold(
      backgroundColor: Colors.white,

      body: ChangeNotifierProvider<MyHealthReportViewModel>(
        create: (BuildContext context) => _viewModel,
        child: FutureBuilder(
          future: _viewModel.handleHealthSummary(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasError){
              return Frame.buildFutureBuilderHasError(
                  snapshot.error.toString(), ()=>{}
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        /// 페이지 안내 메시지 Top
                        const MyHealthTopPhraseWidget(label: '건강'),
                        const Gap(15),

                        /// 건강검진 결과 안내
                        HealthCheckUpResultWidget(
                          comprehensiveOpinionText: _viewModel.comprehensiveOpinionText,
                          lifestyleManagementText: _viewModel.lifestyleManagementText,
                          issuedDate: _viewModel.issuedDate,
                        ),
                        const Gap(15),

                        /// 혈액 검사 결과 Box
                        BloodTestResultWidget(bloodTest: _viewModel.bloodTest),
                        const Gap(15),

                        /// 계측 검사 위젯
                        MetrologyInspectionWidget(
                            metrologyInspection: _viewModel.metrologyInspection),
                        const Gap(15),

                        /// AI 질환 예측 결과
                        AiDiseasePredictionResults(mydataPredict: _viewModel.mydataPredict),
                        const Gap(15),

                        /// 처방 이력
                        MedicationInfoWidget(
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


}







