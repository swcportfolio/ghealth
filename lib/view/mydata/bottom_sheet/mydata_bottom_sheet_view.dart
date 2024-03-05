import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/widgets/horizontal_dashed_line.dart';
import 'package:provider/provider.dart';

import '../../../data/enum/mydata_measurement_type.dart';
import '../../../data/models/column_series_chart_data.dart';
import '../../../data/models/default_series_chart_data.dart';
import '../../../data/models/health_screening_data.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/text_formatter.dart';
import '../../../widgets/chart/column_series_chart.dart';
import '../../../widgets/chart/default_series_chart.dart';
import '../../../widgets/frame.dart';
import 'mydata_bottom_sheet_viewmodel.dart';

/// 마이데이터 건강 검진 결과를 표시합니다.
/// 과거 이력에 대한 그래프 차트 및 표로 확인 할 수있습니다.
class MyDataBottomSheetView extends StatefulWidget {
  const MyDataBottomSheetView(
      {super.key, required this.screeningsDataType});

  /// 마이데이터으 계측 검사에 해당되는 데이터 타입 enum class
  final MyDataMeasurementType screeningsDataType;

  @override
  State<MyDataBottomSheetView> createState() => _MyDataBottomSheetViewState();
}

class _MyDataBottomSheetViewState extends State<MyDataBottomSheetView> {
   late MyDataBottomSheetViewModel _viewModel;

   late List<ColumnSeriesChartData> _columnDataList;
   late List<DefaultSeriesChartData> _defaultDataList;
   late List<HealthScreeningData> _hearingAbilityList;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = MyDataBottomSheetViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyDataBottomSheetViewModel>(
      create: (BuildContext context) => _viewModel,
      child: Container(
      height: 480,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)
          ),
          color: metrologyInspectionBgColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          /// 상단 내림 바
          _buildTopBar(),
          const Gap(20),

          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: _viewModel.handleInstrumentation(widget.screeningsDataType!),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Frame.buildFutureBuilderHasError(snapshot.data, () => {});
                  }
                  if (!snapshot.hasData) {
                    return SizedBox(height: 250,
                    child: Frame.buildFutureBuildProgressIndicator()
                    );
                  }
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (widget.screeningsDataType == MyDataMeasurementType.vision ||
                          widget.screeningsDataType == MyDataMeasurementType.bloodPressure) {
                        _columnDataList = List.of(snapshot.data);
                      }
                      if (widget.screeningsDataType == MyDataMeasurementType.weight ||
                          widget.screeningsDataType == MyDataMeasurementType.height ||
                          widget.screeningsDataType == MyDataMeasurementType.waistCircumference ||
                          widget.screeningsDataType == MyDataMeasurementType.bodyMassIndex) {
                        _defaultDataList = List.of(snapshot.data);
                      }
                      if (widget.screeningsDataType == MyDataMeasurementType.hearingAbility) {
                        _hearingAbilityList = List.of(snapshot.data);
                      }
                    }
                    switch (widget.screeningsDataType) {
                      case MyDataMeasurementType.vision:
                      case MyDataMeasurementType.bloodPressure:
                        return buildMyHealthChartBox(true);
                      case MyDataMeasurementType.weight:
                      case MyDataMeasurementType.height:
                      case MyDataMeasurementType.waistCircumference:
                      case MyDataMeasurementType.bodyMassIndex:
                        return buildMyHealthChartBox(false);
                      case MyDataMeasurementType.hearingAbility:
                        return buildOnlyHearingAbilityResult();
                    }
                  },
              ),
            ),
          )
        ],
      ),
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
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10.0))
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
   Widget buildMyHealthChartBox(bool isColumnChart) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: const EdgeInsets.only(left: 20),
           child: Row(
             children: [
               /// 상단 제목
               const Icon(Icons.bar_chart, color: mainColor, size: 30),
               const Gap(5),
               Frame.myText(
                   text: widget.screeningsDataType.label,
                   color: mainColor,
                   fontSize: 1.5,
                   fontWeight: FontWeight.w600),
             ],
           ),
         ),
         const Gap(10),


         Container(
             padding: const EdgeInsets.all(5),
             margin: const EdgeInsets.symmetric(vertical: 10),
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
                         chartData: _columnDataList,
                         dataType: widget.screeningsDataType)
                         : DefaultSeriesChart(
                         chartData: _defaultDataList,
                         dataType: widget.screeningsDataType)
                 )
               ],
             )),

         /// 하단 부연 설명
         Container(
           width: double.infinity,
           margin: const EdgeInsets.symmetric(horizontal: 10),
           padding: const EdgeInsets.all(10),
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(10),
           ),
           child: Frame.myText(
               text: '• 과거 검사결과 데이터 기반으로 그려진 추이 그래프 입니다\n• 최대 5년치(최근) 데이터를 보여줍니다.',
               softWrap: true,
               maxLinesCount: 4,
               fontSize: 0.9,
               fontWeight: FontWeight.w500),
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
   Widget buildOnlyHearingAbilityResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              const Icon(Icons.bar_chart, color: mainColor, size: 30),
              const Gap(5),
              Frame.myText(
                  text: '청력(좌/우)',
                  color: mainColor,
                  fontSize: 1.5,
                  fontWeight: FontWeight.w600),
            ],
          ),
        ),
        const Gap(20),
        _hearingAbilityList.isEmpty
        ? _buildResultEmptyView()
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Frame.myText(
                        text: '최근 검진일',
                        fontSize: 1.5,
                      ),
                      Frame.myText(text: '결과', fontSize: 1.5),
                    ],
                  ),
                  const Gap(10),

                  Etc.solidLine(context),
                  SizedBox(
                    height: _hearingAbilityList.length * 60,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _hearingAbilityList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Frame.myText(
                                text: TextFormatter.defaultDateFormat(_hearingAbilityList[index].issuedDate),
                                fontSize: 1.2,
                              ),
                              Frame.myText(
                                  text: _hearingAbilityList[index].dataValue
                                      .split(' ')[0],
                                  fontSize: 1.2,
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const HorizontalDottedLine(mWidth: 200);
                      },
                    ),
                  ),
                  const Gap(10),
                  Etc.solidLine(context),
                ],
              ),
            ),
            const Gap(15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Frame.myText(
                    text: '청력(좌/우)결과는 정상/비정상 으로만 표현이 됩니다.',
                    softWrap: true,
                    maxLinesCount: 4,
                    fontSize: 0.9,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Gap(20),
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
           Image.asset('images/empty_search_image.png', height: 80, width: 80),
           const Gap(15),
           Container(
             padding: const EdgeInsets.all(10.0),
             decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10.0)
             ),
             child: Frame.myText(
                 text: '측정된 데이터가 없습니다.',
                 maxLinesCount: 2,
                 softWrap: true,
                 fontSize: 1.1,
                 fontWeight: FontWeight.w500
             ),
           )
         ],
       ),
     );
   }
}

