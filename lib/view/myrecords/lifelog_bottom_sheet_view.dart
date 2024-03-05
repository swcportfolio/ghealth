import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/widgets/horizontal_dashed_line.dart';
import 'package:provider/provider.dart';

import '../../data/enum/lifelog_data_type.dart';
import '../../data/models/lifelog_data.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/frame.dart';
import '../../widgets/list_item/urine_list_itme.dart';
import 'lifelog_bottom_sheet_viewmodel.dart';

/// 라이프로그 검사 결과 표시 화면 (BottomSheet)
class LifeLogBottomSheetView extends StatefulWidget {
  const LifeLogBottomSheetView({
    super.key,
    required this.healthReportType,
    required this.selectedDate,
  });

  final LifeLogDataType healthReportType;
  final String selectedDate;

  @override
  State<LifeLogBottomSheetView> createState() => _LifeLogBottomSheetViewState();
}

class _LifeLogBottomSheetViewState extends State<LifeLogBottomSheetView> {
   late LifeLogBottomSheetViewModel _viewModel;

   /// 라이프로그 건강검진 결과 데이터 리스트
   late List<LifeLogData> _lifeLogDataList;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = LifeLogBottomSheetViewModel(widget.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LifeLogBottomSheetViewModel>(
      create: (BuildContext context) => _viewModel,
      child: Container(
        height: MediaQuery.of(context).size.height * widget.healthReportType.ratio,
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0)),
            color: metrologyInspectionBgColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            /// 상단 내림 바
            buildTopBar(),
            const Gap(25),

            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: _viewModel.handleLifeLogResult(widget.healthReportType),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return SizedBox(
                          height: 300,
                          child: Frame.buildFutureBuilderHasError(snapshot.error.toString(), () => {}));
                    }
                     if (!snapshot.hasData) {
                      return SizedBox(
                          height: 300,
                          child: Frame.buildFutureBuildProgressIndicator());
                    }

                    if (snapshot.connectionState == ConnectionState.done){
                      _lifeLogDataList = List.of(snapshot.data);
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              const Icon(Icons.bar_chart, color: mainColor, size: 30),
                              const Gap(5),
                              Frame.myText(
                                  text: '${widget.healthReportType.name} 검사 결과',
                                  color: mainColor,
                                  fontSize: 1.6,
                                  fontWeight: FontWeight.w600
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),

                        widget.healthReportType == LifeLogDataType.pee
                            ? buildUrineResultList()
                            : _lifeLogDataList.isEmpty
                            ? buildReportResultEmptyView()
                            : Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Etc.solidLine(context),
                                        const Gap(20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Frame.myText(
                                              text: '구분',
                                              fontSize: 1.4,
                                            ),
                                            Frame.myText(
                                                text: '결과',
                                                fontSize: 1.4,
                                                fontWeight: FontWeight.w600),
                                          ],
                                        ),
                                        const Gap(10),
                                        Etc.solidLine(context),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: SizedBox(
                                            height: _lifeLogDataList.length * 70,
                                            child: ListView.separated(
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: _lifeLogDataList.length,
                                              itemBuilder: (BuildContext context, int index)
                                              {
                                                return buildLifeLogDataListItem(
                                                  _lifeLogDataList[index].dataDesc,
                                                  _lifeLogDataList[index].value,
                                                );
                                              },
                                              separatorBuilder: (BuildContext context, int index)
                                              {
                                                return const HorizontalDottedLine(mWidth: 200);
                                              },
                                            ),
                                          ),
                                        ),
                                        Etc.solidLine(context),
                                        const Gap(10),
                                        Visibility(
                                          visible: widget.healthReportType == LifeLogDataType.brains
                                              ? true
                                              : false,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Frame.myText(
                                                    text: '• 자율 신경건강도 지수: 수치가 클수록 건강함을 의미합니다.(평균) 5.16~6.69',
                                                    softWrap: true,
                                                    maxLinesCount: 2,
                                                    color: Colors.grey,
                                                    fontSize: 0.9),
                                                const Gap(5),
                                                Frame.myText(
                                                    text: '• 두뇌 활동 정도: 중간 범위가 건강한 상태입니다.(정상범위) 11.7~19Hz',
                                                    softWrap: true,
                                                    maxLinesCount: 2,
                                                    color: Colors.grey,
                                                    fontSize: 0.9),
                                                const Gap(5),
                                                Frame.myText(
                                                    text: '• 두뇌 스트레스: 낮을수록 건강한 상태 입니다.',
                                                    softWrap: true,
                                                    maxLinesCount: 2,
                                                    color: Colors.grey,
                                                    fontSize: 0.9)
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Gap(20),
                                      ],
                                    ),
                                  ),
                      ],
                    );
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
  Widget buildTopBar() {
     return Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Container(
           width: 70,
           height: 3,
           decoration: const BoxDecoration(
               color: Colors.grey,
               borderRadius: BorderRadius.all(Radius.circular(10.0))),
         )
       ],
     );
   }

  /// 검사 결과 데이터 존재시 포멧에 맞춰 리포트 데이터를 보여준다.
  Widget buildHealthReportWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Etc.solidLine(context),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Frame.myText(
                text: '구분',
                fontSize: 1.4,
              ),
              Frame.myText(
                  text: '결과', fontSize: 1.4, fontWeight: FontWeight.w600),
            ],
          ),
          const Gap(10),
          Etc.solidLine(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: _lifeLogDataList.length * 70,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _lifeLogDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildLifeLogDataListItem(
                    _lifeLogDataList[index].dataDesc,
                    _lifeLogDataList[index].value,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const HorizontalDottedLine(mWidth: 200);
                },
              ),
            ),
          ),
          Etc.solidLine(context),
          const Gap(10),
          Visibility(
            visible: widget.healthReportType == LifeLogDataType.brains
                ? true
                : false,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Frame.myText(
                      text: '• 자율 신경건강도 지수: 수치가 클수록 건강함을 의미합니다.(평균) 5.16~6.69',
                      softWrap: true,
                      maxLinesCount: 2,
                      color: Colors.grey,
                      fontSize: 0.9),
                  const Gap(5),
                  Frame.myText(
                      text: '• 두뇌 활동 정도: 중간 범위가 건강한 상태입니다.(정상범위) 11.7~19Hz',
                      softWrap: true,
                      maxLinesCount: 2,
                      color: Colors.grey,
                      fontSize: 0.9),
                  const Gap(5),
                  Frame.myText(
                      text: '• 두뇌 스트레스: 낮을수록 건강한 상태 입니다.',
                      softWrap: true,
                      maxLinesCount: 2,
                      color: Colors.grey,
                      fontSize: 0.9)
                ],
              ),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }

  /// 라이프로그 건강검진 데이터 리스트 아이템
  Widget buildLifeLogDataListItem(String dataDesc, String value) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Frame.myText(
              text: dataDesc,
              fontSize: 1.2,
            ),
            Frame.myText(
                text: value, fontSize: 1.3, fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }

  /// 소변 결과 리스트
  Widget buildUrineResultList() {
    return _viewModel.lifeLogDataList.isEmpty
        ? buildReportResultEmptyView()
        : Container(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 700,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _viewModel.lifeLogDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return UrineListItem(
                    dataDesc: _viewModel.lifeLogDataList[index].dataDesc,
                    value: _viewModel.lifeLogDataList[index].value,
                  );
                },
              ),
            ),
          );
  }

  /// EmptyView 화면을 보여준다.
  Widget buildReportResultEmptyView() {
    return SizedBox(
      height:
          (MediaQuery.of(context).size.height * widget.healthReportType.ratio) -
              150,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/empty_search_image.png', height: 60, width: 60),
          const Gap(15),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Frame.myText(
                text: '측정된 데이터가 없습니다.',
                maxLinesCount: 2,
                softWrap: true,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

