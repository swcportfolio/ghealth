
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../widgets/style_text.dart';
import 'vm_reservation.dart';

class RegionChoice extends StatelessWidget {
  const RegionChoice({super.key});

  String get title => '방문할 건강관리소';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<ReservationViewModelTest>(
      builder: (context, provider, child) {
        return Visibility(
          visible: provider.visibleRegionChoice(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppDim.small),
                child: Row(
                  children: [
                    Icon(
                      Icons.home_outlined,
                      color: AppColors.primaryColor,
                      size: AppDim.iconSmall,
                    ),
                    const Gap(AppDim.xSmall),

                    StyleText(
                      text: title,
                      size: AppDim.fontSizeLarge,
                      fontWeight: AppDim.weight500,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: ToggleSwitch(
                  initialLabelIndex: provider.toggleIndex,
                  totalSwitches: 2,
                  animationDuration: 400,
                  inactiveBgColor: Colors.grey.shade200,
                  activeBgColor: [
                    AppColors.primaryColor,
                  ],
                  customWidths: [size.width / 2 - 16, size.width / 2 - 16],
                  labels: const ['동구 건강관리소', '광산구 건강관리소'],
                  fontSize: AppDim.fontSizeSmall,
                  customTextStyles: const [TextStyle(fontWeight: AppDim.weightBold)],
                  onToggle: provider.onToggle,
                ),
              )

            ],
          ),
        );
      },
    );
  }
}
