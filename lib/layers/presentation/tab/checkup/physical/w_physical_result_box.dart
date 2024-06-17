
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../../model/vo_physical_inspection.dart';
import 'w_physical_inspection_item.dart';


class PhysicalResultBox extends StatelessWidget {
  final List<String> physicalInspectionDates;
  final List<PhysicalInspection> physicalInspectionList;
  final PageController controller = PageController(initialPage: 0, viewportFraction: 0.9);

  PhysicalResultBox({
    super.key,
    required this.physicalInspectionDates,
    required this.physicalInspectionList,
  });

  double get physicalBoxHeight => 630;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          height: physicalBoxHeight,
          child: physicalInspectionDates.isEmpty
              ? PhysicalInspectionItem(
                  value: '', physicalInspection: PhysicalInspection())
              : PageView.builder(
                  controller: controller,
                  itemCount: physicalInspectionList.isEmpty
                      ? 1
                      : physicalInspectionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PhysicalInspectionItem(
                        value: physicalInspectionDates[index],
                        physicalInspection: physicalInspectionList[index]);
                  },
                ),
        ),

        Visibility(
          visible: physicalInspectionList.isEmpty ? false : true,
          child: Container(
            height: 20,
            margin: const EdgeInsets.only(bottom: AppDim.medium),
            alignment: Alignment.center,
            child: SmoothPageIndicator(
                controller: controller,
                count: physicalInspectionList.length,
                effect: ScrollingDotsEffect(
                  activeDotColor: AppColors.primaryColor,
                  activeStrokeWidth: 12,
                  activeDotScale: 2,
                  maxVisibleDots: 5,
                  radius: 8,
                  spacing: 10,
                  dotHeight: 5,
                  dotWidth: 5,
                )),
          ),
        ),
      ],
    );
  }
}
