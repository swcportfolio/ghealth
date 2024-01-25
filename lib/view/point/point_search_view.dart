import 'package:flutter/material.dart';
import 'package:ghealth_app/view/point/point_history_list_widget.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:provider/provider.dart';

import 'my_health_point_viewmodel.dart';

/// 포인트 적립, 차감 상세 조회 화면
class PointSearchView extends StatefulWidget {
  const PointSearchView({super.key});

  @override
  State<PointSearchView> createState() => _PointSearchViewState();
}

class _PointSearchViewState extends State<PointSearchView> {
  late MyHealthPointViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MyHealthPointViewModel(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Frame.myAppbar(
        '포인트 조회',
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => _viewModel,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Frame.myText(
                    text: '포인트 적립 / 차감 내역',
                    fontSize: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                  Frame.myText(
                    text: '1개월 • 전체 • 최근순',
                    fontSize: 0.9,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                  child: PointHistoryListWidget(viewModel:_viewModel),
                )
            ),
          ],
        )
      ),
    );
  }
}
