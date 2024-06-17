

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/w_inspection_positioned_item.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';

import '../../../model/enum/lifelog_data_type.dart';

/// 건강관리소 신체검사 선택지
class LifeLogBodyAnalysis extends StatelessWidget {
  final List<String> visitDateList;
  final String selectedDate;
  final Function(String?) onChanged;

  const LifeLogBodyAnalysis({
    super.key,
    required this.visitDateList,
    required this.selectedDate,
    required this.onChanged,
  });

  double get boxHeigth => 700;
  double get bodyImageHeigth => 560;
  double get bodyImageWidth => 250;

  String get title => '계측 검사';
  String get guideText => '클릭하시면 자세한 결과를 보실수 있습니다.';


  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
      [
        Container(
          width: double.infinity,
          height: boxHeigth,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppConstants.borderRadius,
              border: Border.all(
                  width: AppConstants.borderMediumWidth,
                  color: AppColors.greyBoxBorder,
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:
            [
              buildMetrologyTopTitle(),

              /// 바디 이미지
              Padding(
                padding: const EdgeInsets.only(right: AppDim.large),
                child: Image.asset('${AppStrings.imagePath}/tab/daily/person_body.png',
                    height: bodyImageHeigth,
                    width: bodyImageWidth,
                ),
              ),
              const Gap(AppDim.medium),

              StyleText(
                  text: guideText,
                  color: AppColors.greyTextColor,
                  size: AppDim.fontSizeSmall,
              ),
            ],
          ),
        ),

        InspectionPositionedItem(left: 30, top: 128, right: null,
            label: '시력 측정기', type: LifeLogDataType.eye, date: selectedDate),
        InspectionPositionedItem(left: 20, top: 270, right: null,
            label: '혈압 측정기', type: LifeLogDataType.bloodPressure, date: selectedDate),
        InspectionPositionedItem(left: 20, top: 305, right: null
            , label: '혈당 측정', type: LifeLogDataType.bloodSugar, date: selectedDate),
        InspectionPositionedItem(left: 20, top: 440, right: null,
            label: '키 몸무게 측정기', type: LifeLogDataType.heightWeight, date: selectedDate),
        InspectionPositionedItem(left: 25, top: 475, right: null,
            label: '체성분 분석기',type:  LifeLogDataType.bodyComposition, date: selectedDate),

        InspectionPositionedItem(left: 240, top: 150, right: null,
            label: '두뇌건강 측정기', type: LifeLogDataType.brains, date: selectedDate),
        InspectionPositionedItem(left: 240, top: 185, right: null,
            label: '치매선별 검사기', type: LifeLogDataType.dementia, date: selectedDate),
        InspectionPositionedItem(left: 240, top: 220, right: null,
            label: '뇌파측정기', type: LifeLogDataType.brainWaves, date: selectedDate),
        InspectionPositionedItem(left: 250, top: 353, right: null,
            label: '소변 검사기', type: LifeLogDataType.pee, date: selectedDate),
        InspectionPositionedItem(left: 240, top: 555, right: null,
            label: '초음파 골밀도\n측정기', type: LifeLogDataType.boneDensity, date: selectedDate),
      ],
    );
  }

  Widget buildMetrologyTopTitle() {
    return Padding(
      padding: const EdgeInsets.all(AppDim.large),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           StyleText(
              text: title,
              fontWeight: AppDim.weightBold,
              size: AppDim.fontSizeLarge,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Row(
                children: [
                  StyleText(
                    text: visitDateList.isEmpty ? '-' : visitDateList[0],
                    size: AppDim.fontSizeSmall,
                  ),
                ],
              ),
              items: visitDateList
                  .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: StyleText(
                        text: item,
                        size: AppDim.fontSizeSmall,
                        overflow: TextOverflow.ellipsis,
                      )))
                  .toList(),
              value: selectedDate,
              onChanged: (value) => onChanged(value),
              alignment: AlignmentDirectional.center,
              buttonStyleData: ButtonStyleData(
                height: 35,
                width: 160,
                padding: const EdgeInsets.symmetric(horizontal: AppDim.medium),
                decoration: BoxDecoration(
                  borderRadius: AppConstants.borderMediumRadius,
                  border: Border.all(color: AppColors.grey),
                  color: AppColors.white,
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                ),
                iconSize: 25,
                iconEnabledColor: AppColors.grey,
                iconDisabledColor: AppColors.grey,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: AppConstants.borderLightRadius,
                  color: Colors.white,
                ),
                offset: const Offset(0, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: AppConstants.mediumRadius,
                  thickness: MaterialStateProperty.all(3),
                  thumbVisibility: MaterialStateProperty.all(true),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: AppDim.medium),
              ),
            ),
          )
        ],
      ),
    );
  }

}
