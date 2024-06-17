import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/w_urine_list_item.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_dotted_line.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_future_handler.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_line.dart';
import 'package:provider/provider.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../entity/lifelog_result_dto.dart';
import '../../../model/enum/lifelog_data_type.dart';
import 'd_daily_bottom_sheet_viewmodel.dart';


/// 라이프로그 건강관리소 검사 결과(계측 검사) 표시 화면
class DailyBottomSheetView extends StatefulWidget {
  final LifeLogDataType type;
  final String selectedDate;

  const DailyBottomSheetView({
    super.key,
    required this.type,
    required this.selectedDate,
  });


  @override
  State<DailyBottomSheetView> createState() => _DailyBottomSheetViewState();
}

class _DailyBottomSheetViewState extends State<DailyBottomSheetView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          LifeLogBottomSheetViewModel(widget.type, widget.selectedDate),
      child: Consumer<LifeLogBottomSheetViewModel>(
        builder: (context, provider, child) {
          return Container(
              height: MediaQuery.of(context).size.height * widget.type.ratio,
              padding: const EdgeInsets.all(AppDim.medium),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topRight: AppConstants.mediumRadius,
                  topLeft: AppConstants.mediumRadius,
                ),
              ),
              child: FutureHandler(
                isLoading: provider.isLoading,
                isError: provider.isError,
                errorMessage: provider.errorMessage,
                onRetry: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 상단 내림 바
                    buildTopBar(),
                    const Gap(AppDim.mediumLarge),

                    /// 타입별 검사 결과 표
                    buildResultBody(provider)
                  ],
                ),
              ));
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
              borderRadius: AppConstants.borderLightRadius),
        )
      ],
    );
  }


  /// 검사 결과 표
  buildResultBody(LifeLogBottomSheetViewModel provider) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 타이틀
            Padding(
              padding: const EdgeInsets.only(left: AppDim.large),
              child: Row(
                children: [
                  Icon(
                    Icons.bar_chart,
                    color: AppColors.primaryColor,
                    size: AppDim.iconMedium,
                  ),
                  const Gap(AppDim.xSmall),
                  StyleText(
                    text: '${widget.type.name} 검사 결과',
                    color: AppColors.primaryColor,
                    size: AppDim.fontSizeLarge,
                    fontWeight: AppDim.weightBold,
                  ),
                ],
              ),
            ),
            const Gap(AppDim.mediumLarge),

            /// 검사 결과 표
            widget.type == LifeLogDataType.pee
                ? buildUrineResultList(provider.lifeLogDataList)
                : provider.lifeLogDataList.isEmpty
                    ? buildReportResultEmptyView()
                    : Padding(
                        padding: const EdgeInsets.all(AppDim.small),
                        child: Column(
                          children: [
                            const Line(),
                            const Gap(AppDim.small),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                StyleText(
                                  text: '구분',
                                  size: AppDim.fontSizeLarge,
                                ),
                                StyleText(
                                    text: '결과',
                                    size: AppDim.fontSizeLarge,
                                    fontWeight: AppDim.weightBold),
                              ],
                            ),
                            const Gap(AppDim.small),
                            const Line(),
                            const Gap(AppDim.small),
                            SizedBox(
                              height: provider.lifeLogDataList.length * 80,
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.lifeLogDataList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return buildLifeLogDataListItem(
                                    provider.lifeLogDataList[index].dataDesc,
                                    provider.lifeLogDataList[index].value,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const DottedLine(mWidth: 200);
                                },
                              ),
                            ),
                            const Line(),
                            const Gap(AppDim.small),
                            Visibility(
                              visible: widget.type == LifeLogDataType.brains
                                  ? true
                                  : false,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: AppDim.large),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StyleText(
                                        text:
                                            '• 자율 신경건강도 지수: 수치가 클수록 건강함을 의미합니다.(평균) 5.16~6.69',
                                        softWrap: true,
                                        maxLinesCount: 2,
                                        color: AppColors.greyTextColor,
                                        size: AppDim.fontSizeSmall),
                                    const Gap(AppDim.xSmall),
                                    StyleText(
                                      text:
                                          '• 두뇌 활동 정도: 중간 범위가 건강한 상태입니다.(정상범위) 11.7~19Hz',
                                      softWrap: true,
                                      maxLinesCount: 2,
                                      color: AppColors.greyTextColor,
                                      size: AppDim.fontSizeSmall,
                                    ),
                                    const Gap(AppDim.xSmall),
                                    StyleText(
                                      text: '• 두뇌 스트레스: 낮을수록 건강한 상태 입니다.',
                                      softWrap: true,
                                      maxLinesCount: 2,
                                      color: AppColors.greyTextColor,
                                      size: AppDim.fontSizeSmall,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }


  /// 라이프로그 건강검진 데이터 리스트 아이템
  buildLifeLogDataListItem(String dataDesc, String value) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(left: 60, right: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyleText(
              text: dataDesc,
            ),
            StyleText(
              text: value,
              fontWeight: AppDim.weightBold,
            ),
          ],
        ),
      ),
    );
  }


  /// 소변 결과 리스트
  buildUrineResultList(List<LifeLogData> lifeLogDataList) {
    return lifeLogDataList.isEmpty
        ? buildReportResultEmptyView()
        : Container(
            padding: const EdgeInsets.all(AppDim.small),
            child: SizedBox(
              height: 700,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lifeLogDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return UrineListItem(
                    dataDesc: lifeLogDataList[index].dataDesc,
                    value: lifeLogDataList[index].value,
                  );
                },
              ),
            ),
          );
  }


  /// EmptyView 화면을 보여준다.
  buildReportResultEmptyView() {
    return SizedBox(
      height: (MediaQuery.of(context).size.height * widget.type.ratio) - 150,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            '${AppStrings.imagePath}/tab/daily/empty_search_image.png',
            height: 60,
            width: 60,
          ),
          const Gap(AppDim.medium),
          Container(
            padding: const EdgeInsets.all(AppDim.small),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppConstants.borderLightRadius,
            ),
            child: const StyleText(
              text: '측정된 데이터가 없습니다.',
              maxLinesCount: 2,
              softWrap: true,
              fontWeight: AppDim.weight500,
            ),
          )
        ],
      ),
    );
  }


}
