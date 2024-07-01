import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/common/data/validate/auth_validation_mixin.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/point/vm_point_detail.dart';
import 'package:ghealth_app/layers/presentation/tab/daily/point/w_point_history_list_frame.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_future_handler.dart';
import 'package:provider/provider.dart';

import '../../../widgets/frame_scaffold.dart';


/// 포인트 적립, 차감 상세 조회 화면
class PointDetailView extends StatefulWidget {
  const PointDetailView({
    super.key,
  });

  @override
  State<PointDetailView> createState() => _PointDetailViewState();
}

class _PointDetailViewState extends State<PointDetailView> with AuthValidationMixin{

  String get title => '포인트 조회';

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
     appBarTitle: title,
      body: ChangeNotifierProvider(
        create: (BuildContext context) => PointDetailViewModelTest(),
        child: Consumer<PointDetailViewModelTest>(
          builder: (context, provider, child) {
            return FutureHandler(
              isLoading: provider.isLoading,
              isError: provider.isError,
              errorMessage: provider.errorMessage,
              onRetry: () {  },
              child: Column(
                children:
                [
                  const Gap(AppDim.large),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDim.small),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StyleText(
                          text: '포인트 적립 / 차감 내역',
                          size: AppDim.fontSizeLarge,
                          fontWeight: AppDim.weightBold,
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppDim.xSmall),

                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(AppDim.small),
                          child: PointHistoryListFrame(
                            pointHistoryList: provider.pointHistoryList,
                            scrollController: provider.scrollController,
                          )

                      )
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  buildDetailHeader(){

  }

  buildDetailBody(){

  }
}
