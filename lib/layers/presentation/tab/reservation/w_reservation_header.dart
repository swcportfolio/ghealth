

import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../widgets/style_text.dart';

class ReservationHeader extends StatelessWidget {
  const ReservationHeader({super.key});

  String get titleText => '언제 건강관리소에\n방문하시나요?';

  @override
  Widget build(BuildContext context) {
    return StyleText(
        text: titleText,
        maxLinesCount: 2,
        size: AppDim.fontSizeXLarge,
        fontWeight: FontWeight.bold
    );
  }
}
