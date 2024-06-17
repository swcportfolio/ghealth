import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/checkup/blood/w_blood_series_chart.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_future_handler.dart';
import 'package:provider/provider.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../../../common/data/validate/auth_validation_mixin.dart';
import '../../../../model/authorization_test.dart';
import '../../../../model/enum/blood_data_type.dart';
import '../../../../model/vo_blood_chart.dart';
import '../../../widgets/style_text.dart';
import 'vm_blood_bottom_sheet.dart';

/// 마이데이터 건강 검진 결과를 표시합니다.
/// 과거 이력에 대한 그래프 차트 및 표로 확인 할 수있습니다.
class BloodBottomSheetView extends StatefulWidget {

  /// 마이데이터의 혈액 검사에 해당되는 데이터 타입  enum class
  final BloodDataType bloodDataType;

  /// 피검사 결과 참고치의 기준값
  /// 기준값을 통해 그래프의 빨강색 라인 기준선을 만들어 준다.
  final double plotBandValue;

  const BloodBottomSheetView({
    super.key,
    required this.bloodDataType,
    required this.plotBandValue,
  });

  @override
  State<BloodBottomSheetView> createState() => _BloodBottomSheetViewState();
}

class _BloodBottomSheetViewState extends State<BloodBottomSheetView> with AuthValidationMixin {

  String get guideText1 => '• 과거 검사결과 데이터 기반으로 그려진 추이 그래프 입니다';
  String get guideText2 => '• 최대 5년치(최근) 데이터를 보여줍니다.';

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BloodBottomSheetViewModel>(
      create: (BuildContext context) => BloodBottomSheetViewModel(widget.bloodDataType),
      child: Consumer<BloodBottomSheetViewModel>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Container(
              height: 470,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: AppConstants.lightRadius,
                      topRight: AppConstants.lightRadius
                  ),),
              child: Padding(
                padding: AppConstants.viewPadding,
                child: FutureHandler(
                  isLoading: provider.isLoading,
                  isError: provider.isError,
                  errorMessage: provider.errorMessage,
                  onRetry: () { },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      const Gap(AppDim.xSmall),

                      /// 상단 내림 바
                      _buildTopBar(),
                      const Gap(AppDim.mediumLarge),

                      Expanded(
                        child: _buildBloodChartBox(provider.defaultDataList, 'M')
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 상단 바 widget
  _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 3,
          decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: AppConstants.borderLightRadius,
          ),
        )
      ],
    );
  }

   _buildBloodChartBox(List<BloodChartData> defaultDataList, String gender) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppDim.mediumLarge),
          child: Row(
            children: [
              /// 상단 제목
              Icon(
                  Icons.bar_chart,
                  color: AppColors.primaryColor,
                  size: AppDim.iconMedium,
              ),
              const Gap(AppDim.xSmall),

              StyleText(
                  text: widget.bloodDataType.label,
                  color: AppColors.primaryColor,
                  size: AppDim.fontSizeLarge,
                  fontWeight: AppDim.weightBold,
              ),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.all(AppDim.xSmall),
            margin: const EdgeInsets.symmetric(vertical: AppDim.small),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 차트 및 표
                SizedBox(
                    height: 260,
                    width: double.infinity - 90,
                    child: BloodSeriesChart(
                      chartData: defaultDataList,
                      bloodDataType: widget.bloodDataType,
                      plotBandValue: widget.plotBandValue,
                      gender: 'M',
                    ))
              ],
            )),

        /// 하단 부연 설명
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: AppDim.small),
          padding: const EdgeInsets.all(AppDim.small),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppConstants.borderLightRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  StyleText(
                      text: '• ${widget.bloodDataType.label}은 ',
                      softWrap: true,
                      size: AppDim.fontSizeSmall,
                      fontWeight: FontWeight.w500),
                    StyleText(
                      text: widget.bloodDataType == BloodDataType.hemoglobin
                      //TODO: Authorization().gender 임사
                          ? gender == 'M'
                          ? '13.0 ~ 16.5 '
                          : '12.0 ~ 15.5 '
                          : '${widget.plotBandValue}${widget.bloodDataType.inequalitySign} ',
                      softWrap: true,
                      color: AppColors.primaryColor,
                      size: AppDim.fontSizeSmall,
                      fontWeight: AppDim.weightBold),
                  const StyleText(
                      text: '정상 범위입니다.',
                      softWrap: true,
                      size: AppDim.fontSizeSmall,
                      fontWeight: AppDim.weight500),
                ],
              ),
              const Gap(AppDim.xSmall),

               StyleText(
                  text: guideText1,
                  softWrap: true,
                  maxLinesCount: 4,
                  size: AppDim.fontSizeSmall,

                  fontWeight: AppDim.weight500),
              const Gap(AppDim.xSmall),

               StyleText(
                  text: guideText2,
                  softWrap: true,
                  maxLinesCount: 4,
                  size: AppDim.fontSizeSmall,
                  fontWeight: AppDim.weight500),
            ],
          ),
        ),
      ],
    );
  }
}

