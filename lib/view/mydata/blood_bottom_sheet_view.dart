import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:provider/provider.dart';

import '../../data/models/blood_series_chart_data.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/chart/blood_series_chart.dart';
import '../../widgets/frame.dart';
import 'blood_bottom_sheet_viewmodel.dart';

/// 마이데이터 건강 검진 결과를 표시합니다.
/// 과거 이력에 대한 그래프 차트 및 표로 확인 할 수있습니다.
class BloodBottomSheetView extends StatefulWidget {
  const BloodBottomSheetView({
    super.key,
    required this.bloodDataType,
    required this.plotBandValue,
  });

  /// 마이데이터의 혈액 검사에 해당되는 데이터 타입  enum class
  final BloodDataType bloodDataType;

  /// 피검사 결과 참고치의 기준값
  /// 기준값을 통해 그래프의 빨강색 라인 기준선을 만들어 준다.
  final double plotBandValue;

  @override
  State<BloodBottomSheetView> createState() => _BloodBottomSheetViewState();
}

class _BloodBottomSheetViewState extends State<BloodBottomSheetView> {
  late BloodBottomSheetViewModel _viewModel;
  late List<BloodSeriesChartData> _defaultDataList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = BloodBottomSheetViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BloodBottomSheetViewModel>(
      create: (BuildContext context) => _viewModel,
      child: Container(
        height: 470,
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
                  future: _viewModel.handeBlood(widget.bloodDataType),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Frame.buildFutureBuilderHasError(snapshot.data, () => {});
                    }
                    if (!snapshot.hasData) {
                      return SizedBox(
                          height: 250,
                          child: Frame.buildFutureBuildProgressIndicator());
                    }
                    if(snapshot.connectionState == ConnectionState.done) {
                      _defaultDataList = List.of(snapshot.data);
                    }
                    return buildBloodChartBox(); // 피검사 데이터 타입
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

  Widget buildBloodChartBox() {
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
                  text: widget.bloodDataType.label,
                  color: mainColor,
                  fontSize: 1.5,
                  fontWeight: FontWeight.w600),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 차트 및 표
                SizedBox(
                    height: 260,
                    width: double.infinity - 90,
                    child: BloodSeriesChart(
                      chartData: _viewModel.defaultDataList,
                      bloodDataType: widget.bloodDataType,
                      plotBandValue: widget.plotBandValue,
                    ))
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Frame.myText(
                      text: '• ${widget.bloodDataType.label}은 ',
                      softWrap: true,
                      fontSize: 0.9,
                      fontWeight: FontWeight.w500),
                  Frame.mySolidText(
                      text: widget.bloodDataType == BloodDataType.hemoglobin
                          ? Authorization().gender == 'M'
                          ? '13.0 ~ 16.5 '
                          : '12.0 ~ 15.5 '
                          : '${widget.plotBandValue}${widget.bloodDataType.inequalitySign} ',
                      softWrap: true,
                      color: mainColor,
                      fontSize: 0.9,
                      fontWeight: FontWeight.w600),
                  Frame.myText(
                      text: '정상 범위입니다.',
                      softWrap: true,
                      fontSize: 0.9,
                      fontWeight: FontWeight.w500),
                ],
              ),
              const Gap(5),

              Frame.myText(
                  text: '• 과거 검사결과 데이터 기반으로 그려진 추이 그래프 입니다',
                  softWrap: true,
                  maxLinesCount: 4,
                  fontSize: 0.9,
                  fontWeight: FontWeight.w500),
              const Gap(5),

              Frame.myText(
                  text: '• 최대 5년치(최근) 데이터를 보여줍니다.',
                  softWrap: true,
                  maxLinesCount: 4,
                  fontSize: 0.9,
                  fontWeight: FontWeight.w500),
            ],
          ),
        ),
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

