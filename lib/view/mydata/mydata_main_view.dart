
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/utils/etc.dart';
import 'package:ghealth_app/view/mydata/prescription_history_widget.dart';
import 'package:ghealth_app/view/mydata/test_card_view.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:provider/provider.dart';

import '../../data/enum/snackbar_status_type.dart';
import '../../utils/colors.dart';
import '../../utils/snackbar_utils.dart';
import '../../utils/text_formatter.dart';
import '../login/login_view.dart';
import 'ai_disease_prediction_results_widget.dart';
import 'blood_test_result_widget.dart';
import 'health_checkup_comprehensive_widget.dart';
import 'metrology_inspection_widget.dart';
import 'mydata_main_viewmodel.dart';


/// 마이데이터(나의 건강기록) 화면
/// 1. 건겅검진 종합소견
/// 2. 혈약검사
/// 3. 계측 검사
/// 4. AI질환 얘측 결과
/// 5. 처방 이력
class MyDataMainView extends StatefulWidget {
  const MyDataMainView({super.key});

  @override
  State<MyDataMainView> createState() => _MyDataMainViewState();
}

class _MyDataMainViewState extends State<MyDataMainView> {

  late MyDataMainViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MyDataMainViewModel(context);
  }

  @override
  Widget build(BuildContext context) {

    /// AccessToken 확인
    Authorization().checkAuthToken().then((result) {
      if(!result){
        SnackBarUtils.showBGWhiteSnackBar(
            '권한 만료, 재 로그인 필요합니다.', context);
        Frame.doPagePush(context, const LoginView());
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,

      body: ChangeNotifierProvider<MyDataMainViewModel>(
        create: (BuildContext context) => _viewModel,
        child: FutureBuilder(
          future: _viewModel.handleHealthSummary(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasError){
              return Frame.buildFutureBuilderHasError(
                  snapshot.error.toString(), ()=> {}
              );
            }
            else if(snapshot.connectionState == ConnectionState.done
                && snapshot.data == null) {
             return Frame.buildCommonEmptyView('현재 조회된 마이데이터가 없습니다.');
            }
            else if(snapshot.hasData) {
              return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        /// 페이지 안내 메시지 Top
                        buildTopPhraseWidget(),
                        const Gap(15),

                        /// 건강검진 종합 소견
                        HealthCheckUpComprehensiveWidget(
                          comprehensiveOpinionText: _viewModel.comprehensiveOpinionText,
                          lifestyleManagementText: _viewModel.lifestyleManagementText,
                          //issuedDate: _viewModel.issuedDate,
                        ),
                        const Gap(5),

                        /// 혈액 검사 결과 위젯
                        BloodTestResultWidget(bloodTest: _viewModel.bloodTest),
                        const Gap(15),

                        /// 계측 검사 위젯
                        TestCardView(
                          dates: _viewModel.dates,
                          dataList: _viewModel.dataList,
                        ),
                        // MetrologyInspectionWidget(
                        //     metrologyInspection: _viewModel.metrologyInspection),

                        /// AI 질환 예측 결과
                        // AiDiseasePredictionResultWidget(mydataPredict: _viewModel.mydataPredict),
                        // const Gap(5),

                        /// 처방 이력
                        PrescriptionHistoryWidget(
                            medicationInfoList: _viewModel.medicationInfoList),
                        const Gap(15),
                      ],
                    ),
                  )
              );
            }
            else {
              return Frame.buildFutureBuildProgressIndicator();
            }
          },
        ),
      ),
    );
  }
  String? selectedValue;

  /// 마이데이터 (나의 건강기록) 상단 안내 메시지
  Widget buildTopPhraseWidget(){
    return Consumer<MyDataMainViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Frame.myText(
                      text: '안녕하세요. ${Authorization().userName}님!',
                      fontSize: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                    const Gap(5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Frame.myText(
                              text:'나의 건강 기록',
                              maxLinesCount: 2,
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 1.9
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Frame.myText(
                                      text: value.issuedDateList.isEmpty
                                          ? '-'
                                          : TextFormatter.myDataFormatDate(value.issuedDateList[0]),
                                      fontSize: 0.9),
                                ],
                              ),
                              items: value.issuedDateList.map((String item) => DropdownMenuItem<String>(
                                  value: TextFormatter.myDataFormatDate(item),
                                  child: Frame.myText(
                                      text: TextFormatter.myDataFormatDate(item),
                                      fontSize: 0.9,
                                      overflow: TextOverflow.ellipsis
                                  )
                              )).toList(),
                              value: selectedValue,
                              onChanged: (selectedValue) => {
                                if(this.selectedValue != selectedValue){
                                  setState(() {
                                    this.selectedValue = selectedValue;
                                    value.onChangedDropdownButton(selectedValue!);
                                    SnackBarUtils.showStatusSnackBar(
                                        message: '날짜가 변경되었습니다.',
                                        context: context,
                                        statusType: SnackBarStatusType.success
                                    );
                                  })
                                }
                              },
                              alignment: AlignmentDirectional.center,
                              buttonStyleData: ButtonStyleData(
                                height: 35,
                                width: 160,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black26),
                                  color: Colors.white,
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                ),
                                iconSize: 25,
                                iconEnabledColor: Colors.grey,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                offset: const Offset(0, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(20),
                                  thickness: MaterialStateProperty.all(3),
                                  thumbVisibility: MaterialStateProperty.all(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ]
          ),
        );
      },
    );
  }
}







