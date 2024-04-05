import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/point_hisstory.dart';
import '../../widgets/frame.dart';
import '../../widgets/horizontal_dashed_line.dart';
import '../../widgets/list_item/point_history_item.dart';
import 'my_health_point_viewmodel.dart';

class PointHistoryListWidget extends StatelessWidget {

  final List<PointHistory> pointHistoryList;
  ScrollController? scrollController;
  int? listCount;

  PointHistoryListWidget({
    super.key,
    required this.pointHistoryList,
    this.scrollController,
    this.listCount,
  });

  @override
  Widget build(BuildContext context) {
    return pointHistoryList.isEmpty
        ? Center(child: Frame.myText(text: '포인트 사용내역이 없습니다.'))
        : ListView.separated(
            controller: scrollController ?? ScrollController(),
            physics: listCount == null
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            itemCount: listCount == null ? pointHistoryList.length : pointHistoryList.length > 2 ? 2 : pointHistoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return PointHistoryItem(
                  pointHistory: pointHistoryList[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const HorizontalDottedLine(mWidth: 200);
            },
          );
  }
}
