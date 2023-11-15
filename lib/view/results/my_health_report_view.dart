
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/prescription_data.dart';
import 'package:ghealth_app/view/results/blood_test_result_widget.dart';
import 'package:ghealth_app/view/results/health_point_widget.dart';
import 'package:ghealth_app/view/results/prescription_history_widget.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:provider/provider.dart';

import 'ai_disease_prediction_results_widget.dart';
import 'health_checkup_result_widget.dart';
import 'metrology_inspection_widget.dart';
import 'my_health_topphrase_widget.dart';
import 'my_result_report_viewmodel.dart';

/// 나의 건강보고서 화면
class MyHealthReportView extends StatefulWidget {
  const MyHealthReportView({super.key});

  @override
  State<MyHealthReportView> createState() => _MyHealthReportViewState();
}

class _MyHealthReportViewState extends State<MyHealthReportView> {

  late MyHealthReportViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = Provider.of<MyHealthReportViewModel>(context,listen: false);
    _viewModel.context = context;

    return Scaffold(
      backgroundColor: Colors.white,

      body: FutureBuilder(
        future: _viewModel.handleHealthSummary(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasError){
           return Frame.buildFutureBuilderHasError(()=>{});
          } else if(snapshot.connectionState == ConnectionState.waiting){
            return Frame.buildFutureBuildProgressIndicator();
          } else {
            return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      /// 페이지 안내 메시지 Top
                      const MyHealthTopPhraseWidget(),
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
                      PrescriptionHistoryWidget(
                          medicationInfoList: _viewModel.medicationInfoList),
                      const Gap(15),

                    ],
                  ),
                )
            );
          }
        },
      ),
    );
  }
}







