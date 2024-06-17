import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/common.dart';
import '../../../../../common/data/validate/auth_validation_mixin.dart';
import '../../../../model/authorization_test.dart';
import '../../../widgets/frame_scaffold.dart';
import '../../../widgets/w_dotted_line.dart';
import '../../../widgets/w_future_handler.dart';
import 'w_medication_list_item.dart';
import 'vm_medication_detail.dart';

/// 처방이력- 투약정보 더보기
class MedicationDetailViewTest extends StatefulWidget {
  const MedicationDetailViewTest({super.key});

  @override
  State<MedicationDetailViewTest> createState() => _MedicationDetailViewTestState();
}

class _MedicationDetailViewTestState extends State<MedicationDetailViewTest> with AuthValidationMixin{
  String get title => '처방 이력';

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
            create: (BuildContext context) => MedicationDetailViewModelTest(context),
            child: Padding(
                padding: AppConstants.viewPadding,
                child: Consumer<MedicationDetailViewModelTest>(
                    builder: (context, provider, child) {
                  return FutureHandler(
                      isLoading: provider.isLoading,
                      isError: provider.isError,
                      errorMessage: provider.errorMessage,
                      onRetry: () {},
                      child: ListView.separated(
                        controller: provider.scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: provider.medicationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MedicationListItem(
                              medicationInfoDTO: provider.medicationList[index]);
                        },
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return const DottedLine(mWidth: 200);
                        },
                      ));
                }),
            ),
        ),
    );
  }
}
