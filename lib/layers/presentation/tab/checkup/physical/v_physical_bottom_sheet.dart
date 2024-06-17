import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/model/enum/physical_type.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_future_handler.dart';
import 'package:provider/provider.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../../../common/data/validate/auth_validation_mixin.dart';
import '../../../../../common/util/text_format.dart';
import '../../../../model/authorization_test.dart';
import '../../../widgets/style_text.dart';
import '../../../widgets/w_dotted_line.dart';
import '../../../widgets/w_line.dart';
import 'vm_physical_bottom_sheet.dart';
import 'w_column_series_chart.dart';
import 'w_default_series_chart.dart';

/// 마이데이터 건강 검진 결과를 표시합니다.
/// 과거 이력에 대한 그래프 차트 및 표로 확인 할 수있습니다.
class PhysicalBottomSheetView extends StatefulWidget {
  const PhysicalBottomSheetView({
    super.key,
    required this.screeningsDataType,
  });

  /// 마이데이터으 계측 검사에 해당되는 데이터 타입 enum class
  final PhysicalType screeningsDataType;

  @override
  State<PhysicalBottomSheetView> createState() => _PhysicalBottomSheetViewState();
}

class _PhysicalBottomSheetViewState extends State<PhysicalBottomSheetView> with AuthValidationMixin{

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PhysicalBottomSheetViewModel(widget.screeningsDataType),
      child: Consumer<PhysicalBottomSheetViewModel>(
        builder: (context, provider, child) {
          return Container(
            height: 480,
            padding: const EdgeInsets.all(AppDim.medium),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: AppConstants.mediumRadius,
                    topRight: AppConstants.mediumRadius,
                ),
                color: AppColors.white
            ),
            child: FutureHandler(
              isLoading: provider.isLoading,
              isError: provider.isError,
              errorMessage: provider.errorMessage,
              onRetry: () {  },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    /// 상단 내림 바
                    buildTopBar(),
                    const Gap(AppDim.large),

                    buildPhysicalChartFrame(provider)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  /// 상단 바 widget
  buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 3,
          decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: AppConstants.borderLightRadius
          ),
        )
      ],
    );
  }

  /// 시력, 혈압 차트 및 기타 차트를 생성하고 해당 박스를 반환합니다.
  ///
  /// [isColumnChart]는 차트 종류를 나타내며, true인 경우 세로 막대 차트(Column Chart)를,
  /// false인 경우 기본 차트(Default Chart)를 생성합니다.
  ///
  /// 이 함수는 공통된 UI 요소와 데이터에 따라 다르게 표시되는 차트를 생성하여 반환합니다.
  /// 차트의 데이터 및 타입은 [widget.screeningsDataType]에 의존하며, [widget.bloodDataType]는
  /// 필요에 따라 선택적으로 사용됩니다.
  ///
  /// 차트에 따른 UI는 상단에 아이콘 및 라벨, 중앙에 차트를 나타내는데, 이때 차트 종류에 따라
  /// [ColumnSeriesChart] 또는 [DefaultSeriesChart]를 사용합니다.
  ///
  /// [isColumnChart]가 true일 경우 [ColumnSeriesChart]에 [widget.screeningsDataType]을
  /// 이용하여 세로 막대 차트를, false일 경우 [DefaultSeriesChart]에
  /// [widget.screeningsDataType] 또는 [widget.bloodDataType]를 이용하여 기본 차트를 생성합니다.
  ///
  /// 마지막으로, 박스 하단에는 과거 측정 데이터를 기반으로 그려진 추이 그래프임을 설명하는
  /// 텍스트가 표시됩니다.
   Widget buildMyHealthChartBox(bool isColumnChart, PhysicalBottomSheetViewModel provider) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: const EdgeInsets.only(left: AppDim.large),
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
                   text: widget.screeningsDataType.label,
                   color: AppColors.primaryColor,
                   size: AppDim.fontSizeLarge,
                   fontWeight: AppDim.weightBold,
               ),
             ],
           ),
         ),
         const Gap(AppDim.small),

         Container(
             padding: const EdgeInsets.all(AppDim.xSmall),
             margin: const EdgeInsets.symmetric(vertical: AppDim.small),
             width: double.infinity,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 /// 차트 및 표
                 SizedBox(
                    height: 290,
                    width: double.infinity - 90,
                    child: isColumnChart
                        ? ColumnSeriesChart(
                            chartData: provider.columnDataList,
                            type: widget.screeningsDataType,
                          )
                        : DefaultSeriesChart(
                            chartData: provider.defaultDataList,
                            type: widget.screeningsDataType,
                          ))
              ],
             )),

         /// 하단 부연 설명
         Container(
           width: double.infinity,
           margin: const EdgeInsets.symmetric(horizontal: AppDim.small),
           padding: const EdgeInsets.all(AppDim.small),
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: AppConstants.borderLightRadius,
           ),
           child: const StyleText(
               text: '• 과거 검사결과 데이터 기반으로 그려진 추이 그래프 입니다\n• 최대 5년치(최근) 데이터를 보여줍니다.',
               softWrap: true,
               maxLinesCount: 4,
               size: AppDim.fontSizeSmall,
               fontWeight: AppDim.weight500,
           ),
         ),
       ],
     );
   }


   /// 청력 결과를 나타내는 위젯을 생성하고 반환합니다.
   ///
   /// 청력 결과는 검진일과 결과로 구성되어 있으며, 검진일과 결과를 나타내는
   /// 텍스트를 수평으로 나란히 표시합니다. 검진일은 [Etc.defaultDateFormat]를
   /// 통해 형식을 변경하여 표시하고, 결과는 [dataValue]에서 공백을 기준으로
   /// 분리한 후 첫 번째 단어만 사용하여 표시합니다.
   ///
   /// 이 위젯은 [ListView.separated]를 사용하여 청력 결과 리스트를 표시하며,
   /// 결과 간의 구분을 위해 [HorizontalDottedLine]을 사용합니다.
   ///
   /// 마지막으로, 박스 하단에는 청력 결과가 정상 또는 비정상으로만 표현된다는
   /// 안내 텍스트가 표시됩니다.
   Widget buildOnlyHearingAbilityResult(PhysicalBottomSheetViewModel provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppDim.large),
          child: Row(
            children:
            [
              Icon(
                  Icons.bar_chart,
                  color: AppColors.primaryColor,
                  size: AppDim.iconMedium,
              ),
              const Gap(AppDim.xSmall),
              StyleText(
                  text: '청력(좌/우)',
                  color: AppColors.primaryColor,
                  size: AppDim.fontSizeLarge,
                  fontWeight: AppDim.weightBold,
              ),
            ],
          ),
        ),
        const Gap(AppDim.large),

        provider.hearingAbilityList.isEmpty
        ? _buildResultEmptyView()
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDim.small),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StyleText(
                        text: '최근 검진일',
                        size: AppDim.fontSizeLarge,
                      ),
                      StyleText(
                          text: '결과',
                        size: AppDim.fontSizeLarge,
                      ),
                    ],
                  ),
                  const Gap(AppDim.small),

                  const Line(),
                  SizedBox(
                    height: provider.hearingAbilityList.length * 60,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.hearingAbilityList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppDim.large),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              StyleText(
                                text: TextFormat.defaultDateFormat(provider.hearingAbilityList[index].issuedDate),
                              ),
                              StyleText(
                                  text: provider.hearingAbilityList[index].dataValue.split(' ')[0],
                                  fontWeight: AppDim.weightBold,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const DottedLine(mWidth: 200);
                      },
                    ),
                  ),
                  const Gap(AppDim.small),
                  const Line(),
                ],
              ),
            ),
            const Gap(AppDim.medium),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDim.small),
              padding: const EdgeInsets.all(AppDim.small),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppConstants.borderLightRadius,
              ),
              child: const Center(
                child: StyleText(
                    text: '청력(좌/우)결과는 정상/비정상 으로만 표현이 됩니다.',
                    softWrap: true,
                    maxLinesCount: 4,
                    size: AppDim.fontSizeSmall,
                    fontWeight: AppDim.weightBold,
                ),
              ),
            ),
            const Gap(AppDim.large),
          ],
        )

      ],
    );
  }

   /// EmptyView 화면을 보여준다.
   _buildResultEmptyView(){
     return SizedBox(
       height: 300,
       width: double.infinity,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Image.asset(
               '${AppStrings.imagePath}/tab/daily/empty_search_image.png',
               height: 80,
               width: 80,
           ),
           const Gap(AppDim.medium),

           Container(
             padding: const EdgeInsets.all(AppDim.small),
             decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: AppConstants.borderLightRadius
             ),
             child: const StyleText(
                 text: '측정된 데이터가 없습니다.',
                 maxLinesCount: 2,
                 softWrap: true,
                 fontWeight: AppDim.weight500
             ),
           )
         ],
       ),
     );
   }

   buildPhysicalChartFrame(PhysicalBottomSheetViewModel provider) {
    switch (widget.screeningsDataType) {
      case PhysicalType.vision:
      case PhysicalType.bloodPressure:
        return buildMyHealthChartBox(true, provider);
      case PhysicalType.weight:
      case PhysicalType.height:
      case PhysicalType.waistCircumference:
      case PhysicalType.bodyMassIndex:
        return buildMyHealthChartBox(false, provider);
      case PhysicalType.hearingAbility:
        return buildOnlyHearingAbilityResult(provider);
    }
  }
}

