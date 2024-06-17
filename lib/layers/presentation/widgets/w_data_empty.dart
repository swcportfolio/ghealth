import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/common/constants/app_dimensions.dart';

import 'style_text.dart';

class DataEmpty extends StatelessWidget {
  final String message;

  const DataEmpty({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StyleText(
            text: message,
            maxLinesCount: 2,
            align: TextAlign.center,
          )
        ],
      ),
    );
  }
}
