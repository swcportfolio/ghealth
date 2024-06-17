import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/presentation/tab/checkup/vm_checkup.dart';
import 'package:provider/provider.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../../common/util/text_format.dart';
import '../../../model/authorization_test.dart';
import '../../widgets/style_text.dart';

class CheckupHeader extends StatelessWidget {
  const CheckupHeader({super.key});

  String get helloText => '안녕하세요. ${AuthorizationTest().userName}님!';
  String get titleText => '나의 건강 기록';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
      [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            StyleText(
              text: helloText,
              color: AppColors.blackTextColor,
              fontWeight: AppDim.weight500,
            ),
            StyleText(
              text: titleText,
              color: AppColors.primaryColor,
              size: AppDim.fontSizeXxLarge,
              fontWeight: AppDim.weightBold,
            )
          ],
        ),

        Consumer<CheckupViewModelTest>(
          builder: (context, provider, child) {
            return DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    StyleText(
                      text: provider.issuedDateList.isEmpty
                          ? '-'
                          : TextFormat.stringFormatDate(
                              provider.issuedDateList[0]),
                      size: AppDim.fontSizeSmall,
                    ),
                  ],
                ),
                items: provider.issuedDateList
                    .map((String item) => DropdownMenuItem<String>(
                          value: TextFormat.stringFormatDate(item),
                          child: StyleText(
                            text: TextFormat.stringFormatDate(item),
                            overflow: TextOverflow.ellipsis,
                            size: AppDim.fontSizeSmall,
                          ),
                        ))
                    .toList(),
                value: provider.selectedTempValue,
                onChanged: (value) => provider.onChanged(value, context),
                alignment: AlignmentDirectional.center,
                buttonStyleData: _buttonStyleData,
                iconStyleData: _iconStyleData,
                dropdownStyleData: _dropdownStyleData,
                menuItemStyleData: _menuItemStyleData,
              ),
            );
          },
        ),
      ],
    );
  }


  ButtonStyleData get _buttonStyleData => ButtonStyleData(
    height: 35,
    width: 160,
    padding: const EdgeInsets.symmetric(horizontal: AppDim.medium),
    decoration: BoxDecoration(
      borderRadius: AppConstants.borderRadius,
      border: Border.all(color: Colors.black26),
      color: AppColors.white,
    ),
  );


  IconStyleData get _iconStyleData => const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
        ),
        iconSize: 25,
        iconEnabledColor: AppColors.grey,
        iconDisabledColor: AppColors.grey,
      );


  DropdownStyleData get _dropdownStyleData => DropdownStyleData(
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
  );


  MenuItemStyleData get _menuItemStyleData => const MenuItemStyleData(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: AppDim.medium),
  );


}
