
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/view/myrecords/health_center_record_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../data/enum/lifelog_data_type.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../widgets/frame.dart';
import 'lifelog_bottom_sheet_view.dart';

/// 나의 일상의 건강관리소 방문시 검사한 결과
/// 바디 계측 결과
class HealthCenterRecordView extends StatefulWidget {
  const HealthCenterRecordView({super.key});

  @override
  State<HealthCenterRecordView> createState() => _HealthCenterRecordViewState();
}

class _HealthCenterRecordViewState extends State<HealthCenterRecordView> {

  late HealthCenterRecordViewModel _viewModel;
  String selectedDate = '';

  @override
  void initState() {
    super.initState();

    _viewModel = HealthCenterRecordViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _viewModel,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 700,
              decoration: BoxDecoration(
                  color: metrologyInspectionBgColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2.0, color: Colors.grey.shade200)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                [
                  buildMetrologyTopTitle(),

                  Padding(
                    padding: const EdgeInsets.only(right: 23),
                    child: Image.asset('images/person_body.png', height: 560, width: 250),
                  ),
                  const Gap(15),

                  Frame.myText(
                      text: '클릭하시면 자세한 결과를 보실수 있습니다.',
                      color: Colors.grey.shade600,
                      fontSize: 1.0
                  ),
                ],
              ),
            ),

            buildPositionedBox(30, 118, null, '시력 측정기', LifeLogDataType.eye),
            buildPositionedBox(10, 260, null, '혈압 측정기', LifeLogDataType.bloodPressure),
            buildPositionedBox(10, 295, null, '혈당 측정', LifeLogDataType.bloodSugar),
            buildPositionedBox(10, 420, null, '키 몸무게 측정기', LifeLogDataType.heightWeight),
            buildPositionedBox(25, 455, null, '체성분 분석기', LifeLogDataType.bodyComposition),

            buildPositionedBox(null, 140, 20, '두뇌건강 측정기', LifeLogDataType.brains),
            buildPositionedBox(null, 175, 20, '치매선별 검사기', LifeLogDataType.dementia),
            buildPositionedBox(null, 210, 20, '뇌파측정기', LifeLogDataType.brainWaves),

            buildPositionedBox(null, 345, 20, '소변 검사기', LifeLogDataType.pee),
            buildPositionedBox(null, 555, 10, '초음파 골밀도 측정기', LifeLogDataType.boneDensity),
          ],
        ),
      ),
    );
  }




  Widget buildMetrologyTopTitle() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Frame.myText(
              text: '계측검사', fontWeight: FontWeight.w600, fontSize: 1.3),

          FutureBuilder(
            future: _viewModel.handleLookupDate(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasError) {
                return Container();
              }

              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data.length != 0) {
                selectedDate = snapshot.data[0];
                logger.i('selectedValue: $selectedDate');
              }

              if(snapshot.hasData) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Frame.myText(
                            text: _viewModel.recordDateList.isEmpty
                                ? '0000-00-00'
                                : _viewModel.recordDateList[0],
                            fontSize: 0.9),
                      ],
                    ),
                    items: _viewModel.recordDateList
                        .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Frame.myText(
                            text: item,
                            fontSize: 0.9,
                            overflow: TextOverflow.ellipsis)))
                        .toList(),
                    value: selectedDate,
                    onChanged: (selectedValue) => {
                      setState(() {
                        selectedDate = selectedValue ?? '';
                      })
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
                );
              }
              else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  Positioned buildPositionedBox(
      double? left, double? top, double? right,
      String label, LifeLogDataType type) {
    return Positioned(
        left: left,
        top: top,
        right: right,
        bottom: null,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return LifeLogBottomSheetView(healthReportType: type, selectedDate: selectedDate);
                });
          },
          child: Container(
            decoration: BoxDecoration(
              color: metrologyInspectionBgColor,
              border: Border.all(width: 1.5, color: mainColor),
              borderRadius: BorderRadius.circular(30),
            ),

            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                    text: label,
                    color: mainColor,
                    fontSize: 0.95,
                    fontWeight: FontWeight.w600),
              ],
            ),
          ),
        ));
  }
}
