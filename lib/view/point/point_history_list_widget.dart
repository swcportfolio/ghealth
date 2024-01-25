import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/frame.dart';
import '../../widgets/horizontal_dashed_line.dart';
import '../../widgets/list_item/point_history_item.dart';
import 'my_health_point_viewmodel.dart';

class PointHistoryListWidget extends StatelessWidget {
  const PointHistoryListWidget({
        super.key,
        required this.viewModel,
         this.listCount
      });

  final MyHealthPointViewModel viewModel;
  final int? listCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: FutureBuilder(
          future: viewModel.handlePointHistoryList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Frame.buildFutureBuilderHasError(snapshot.error.toString(), () => {});
            }
            else if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<MyHealthPointViewModel>(
                builder: (BuildContext context, value, Widget? child) {
                  return value.pointHistoryList.isEmpty
                      ? Center(
                          child: Frame.myText(text: '포인트 사용내역이 없습니다.'))
                      : ListView.separated(
                          controller: value.scrollController,
                          physics: listCount == null ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                          itemCount: listCount == null ? value.pointHistoryList.length : listCount!,
                          itemBuilder: (BuildContext context, int index) {
                            return PointHistoryItem(pointHistory: value.pointHistoryList[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const HorizontalDottedLine(mWidth: 200);
                          },
                        );
                },
              );
            } else {
              return Frame.buildFutureBuildProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
