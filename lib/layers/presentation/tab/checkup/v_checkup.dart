

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/checkup/blood/w_blood_result_box.dart';
import 'package:ghealth_app/layers/presentation/tab/checkup/medication/w_medication_history.dart';
import 'package:ghealth_app/layers/presentation/tab/checkup/physical/w_physical_result_box.dart';
import 'package:ghealth_app/layers/presentation/tab/checkup/w_checkup_header.dart';
import 'package:ghealth_app/layers/presentation/tab/checkup/w_comprehensive_examination.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_future_handler.dart';
import 'package:provider/provider.dart';

import '../../../../common/common.dart';
import '../../../../common/data/validate/auth_validation_mixin.dart';
import '../../../model/authorization_test.dart';
import 'vm_checkup.dart';

/// 나의 건강검진 기록
class CheckupViewTest extends StatefulWidget {
  const CheckupViewTest({super.key});

  @override
  State<CheckupViewTest> createState() => _CheckupViewTestState();
}

class _CheckupViewTestState extends State<CheckupViewTest> with AuthValidationMixin{

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckupViewModelTest(),
      child: Padding(
        padding: AppConstants.viewPadding,
        child: Consumer<CheckupViewModelTest>(
          builder: (context, provider, child) {
            return FutureHandler(
              isLoading: provider.isLoading,
              isError: provider.isError,
              errorMessage: provider.errorMessage,
              onRetry: () {  },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Gap(AppDim.medium),

                    /// 나의 건강검진 헤더
                    const CheckupHeader(),
                    const Gap(AppDim.large),

                    /// 건강검진 종합 소견
                    ComprehensiveExamination(
                      issuedDate: provider.issuedDate,
                      resultTitleText: provider.comprehensiveOpinionText,
                      additionalText: provider.lifestyleManagementText,
                    ),
                    const Gap(AppDim.medium),

                    /// 혈액검사 결과
                    BloodResultBox(bloodTest: provider.bloodTest),
                    const Gap(AppDim.medium),

                    /// 계측 검사 위젯
                    PhysicalResultBox(
                      physicalInspectionDates: provider.physicalInspectionDates,
                      physicalInspectionList: provider.physicalInspectionList,
                    ),

                    /// 처방 이력
                    MedicationHistory(
                      medicationInfoList: provider.medicationInfoList,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
