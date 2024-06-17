import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/vm_tab_frame.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../../model/enum/tab_item_type.dart';
import '../widgets/style_text.dart';

class NavigationBarItemIcon extends StatelessWidget {
  final TabItemType type;

  const NavigationBarItemIcon({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TabFrameViewModelTest>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: provider.selectedIndex == type.itemIndex
                  ? ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)
                  : const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
              child: Image.asset(type.iconPath, height: 28, width: 28),
            ),
            const Gap(AppDim.xSmall),
            StyleText(
              text: type.label,
              align: TextAlign.center,
              color: provider.selectedIndex == type.itemIndex ? AppColors.primaryColor : AppColors.grey,
              size: AppDim.fontSizeXSmall,
              maxLinesCount: 2,
            )
          ],
        );
      },
    );
  }
}
