import 'package:flutter/material.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/point/w_point_history_item.dart';

import '../../../../entity/point_history_dto.dart';
import '../../../widgets/style_text.dart';
import '../../../widgets/w_horizontal_dotted_line.dart';

// ignore: must_be_immutable
class PointHistoryListFrame extends StatelessWidget {

  final List<PointHistoryDataDTO> pointHistoryList;
  ScrollController? scrollController;
  int? listCount;

  PointHistoryListFrame({
    super.key,
    required this.pointHistoryList,
    this.scrollController,
    this.listCount,
  });

  @override
  Widget build(BuildContext context) {
    return pointHistoryList.isEmpty
        ? const Center(child: StyleText(text: '포인트 사용내역이 없습니다.'))
        : ListView.separated(
      controller: scrollController ?? ScrollController(),
      physics: listCount == null
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: listCount == null ? pointHistoryList.length : pointHistoryList.length > 2 ? 2 : pointHistoryList.length,
      itemBuilder: (BuildContext context, int index) {
        return PointHistoryItem(pointHistory: pointHistoryList[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const HorizontalDottedLine(mWidth: 200);
      },
    );
  }
}