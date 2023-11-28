import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/report/report_bottom_sheet_viewmodel.dart';
import 'package:ghealth_app/widgets/horizontal_dashed_line.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/frame.dart';
import '../../widgets/list_item/urine_list_itme.dart';

/// 건강검진 기록 상세 화면
/// TODO: 스크롤을 내리면 화면이 갱신되는 오류가 있음!!!!
/// 미타민, 포도장 으로 나온다
class ReportBottomSheetView extends StatefulWidget {
  const ReportBottomSheetView({super.key, required this.healthReportType});
  final HealthReportType healthReportType;

  @override
  State<ReportBottomSheetView> createState() => _ReportBottomSheetViewState();
}

class _ReportBottomSheetViewState extends State<ReportBottomSheetView> {
   late ReportBottomSheetViewModel _viewModel;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = ReportBottomSheetViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReportBottomSheetViewModel>(
      create: (BuildContext context) => _viewModel,
      child: Container(
        height: 500,
        padding: const EdgeInsets.all(15),
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
            _buildTopBar(),
            const Gap(25),

            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: _viewModel.handleHealthReport(widget.healthReportType),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return SizedBox(
                          height: 300,
                          child: Frame.buildFutureBuilderHasError(snapshot.error.toString(), () => {}));
                    }
                    else if (snapshot.connectionState == ConnectionState.waiting) {
                      return
                        SizedBox(
                          height: 300,
                          child: Frame.buildFutureBuildProgressIndicator()
                        );
                    }
                    else {
                      return Consumer<ReportBottomSheetViewModel>(
                        builder: (BuildContext context, value, Widget? child) {
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
                                        text: '${widget.healthReportType.name} 검사 결과',
                                        color: mainColor,
                                        fontSize: 1.6,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(20),

                              widget.healthReportType == HealthReportType.pee
                                  ? buildUrineResultList()
                                  :
                              value.lifeLogDataList.isEmpty
                                  ? _buildReportResultEmptyView()
                                  : Padding(
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
                                            text: '결과',
                                            fontSize: 1.4,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ],
                                    ),
                                    const Gap(10),

                                    Etc.solidLine(context),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: SizedBox(
                                        height: value.lifeLogDataList.length * 70,
                                        child: ListView.separated(
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: value.lifeLogDataList.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return buildLifeLogDataListItem(
                                              value.lifeLogDataList[index].dataDesc,
                                              value.lifeLogDataList[index].value,
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
                                      visible: widget.healthReportType == HealthReportType.brains
                                          ? true
                                          : false,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Frame.myText(
                                                text: '• 자율 신경건강도 지수: 수치가 클수록 건강함을 의미합니다.(평균) 5.16~6.69',
                                                softWrap: true,
                                                maxLinesCount: 2,
                                                color: Colors.grey,
                                                fontSize: 0.9
                                            ),
                                            const Gap(5),
                                            Frame.myText(
                                                text: '• 두뇌 활동 정도: 중간 범위가 건강한 상태입니다.(정상범위) 11.7~19Hz',
                                                softWrap: true,
                                                maxLinesCount: 2,
                                                color: Colors.grey,
                                                fontSize: 0.9
                                            ),
                                            const Gap(5),

                                            Frame.myText(
                                                text: '• 두뇌 스트레스: 낮을수록 건강한 상태 입니다.',
                                                softWrap: true,
                                                maxLinesCount: 2,
                                                color: Colors.grey,
                                                fontSize: 0.9
                                            )
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
                      );
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
                 text: value,
                 fontSize: 1.3,
                 fontWeight: FontWeight.w600
             ),
           ],
         ),
       ),
     );
   }

   /// 소변 결과 리스트
   Widget buildUrineResultList() {
     return Container(
       padding: const  EdgeInsets.all(10.0),
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

   /// EmptyView 화면을 보여준다.
   _buildReportResultEmptyView(){
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

