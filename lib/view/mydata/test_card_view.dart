
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/models/metrology_inspection.dart';
import '../../utils/colors.dart';
import 'metrology_inspection_widget.dart';

class TestCardView extends StatelessWidget {
   final List<String> dates;
   final List<MetrologyInspection> dataList;
   final PageController controller = PageController(initialPage: 0, viewportFraction: 0.9);

   TestCardView({
    super.key,
    required this.dates,
    required this.dataList,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 630,
          child: PageView.builder(
            controller: controller,
            itemCount: dataList.isEmpty ? 1 : dataList.length,
            itemBuilder: (BuildContext context, int index) {

              if(dates.isEmpty){
                return MetrologyInspectionWidget(
                    date: '',
                    metrologyInspection: MetrologyInspection()
                );
              }

              else {
                return MetrologyInspectionWidget(
                    date: dates[index],
                    metrologyInspection: dataList[index]
                );
              }

            },
          ),
        ),

          Visibility(
            visible: dataList.isEmpty ? false : true,
            child: Container(
              height: 20,
              margin: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.center,
              child: SmoothPageIndicator(
                  controller: controller,
                  count: dataList.length,
                  effect: const ScrollingDotsEffect(
                    activeDotColor: mainColor,
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
