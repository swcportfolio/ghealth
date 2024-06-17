import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/aihealth/vm_ai_health.dart';
import 'package:ghealth_app/layers/presentation/tab/aihealth/w_prediction_age.dart';
import 'package:provider/provider.dart';

import '../../../../common/common.dart';
import '../../../../common/data/validate/auth_validation_mixin.dart';
import '../../widgets/w_future_handler.dart';
import '../../widgets/w_view_padding.dart';
import 'w_aiheatlh_header.dart';
import 'w_prediction_result.dart';

/// AI 건강예측 화면
class AiHealthViewTest extends StatefulWidget {
  const AiHealthViewTest({super.key});

  @override
  State<AiHealthViewTest> createState() => _AiHealthViewTestState();
}

class _AiHealthViewTestState extends State<AiHealthViewTest> with AuthValidationMixin{

  String get title => 'AI 질환 예측 결과';

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AiHealthViewModelTest(),
        child: Consumer<AiHealthViewModelTest>(
          builder: (context, provider, child) {
            return FutureHandler(
              isLoading: provider.isLoading,
              isError: provider.isError,
              errorMessage: provider.errorMessage,
              onRetry: () {  },
              child: ViewPadding(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children:
                    [
                      const Gap(AppDim.medium),

                      /// Ai 건강예측 헤더
                      const AiHealthHeader(),
                      const Gap(AppDim.medium),

                      /// AI 예측 결과
                      PredictionResult(aiHealthData: provider.aiHealthData),
                      const Gap(AppDim.medium),

                      /// AI 질환 예측 나이
                      PredictionAge(aiHealthData: provider.aiHealthData),
                      const Gap(AppDim.medium),
                    ],
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
