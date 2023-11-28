
import 'package:flutter/material.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../utils/colors.dart';
import '../../widgets/frame.dart';
import '../../widgets/horizontal_dashed_line.dart';
import '../../widgets/list_item/prescription_list_item.dart';
import 'medication_info_detail_viewmodel.dart';

/// 처방이력- 투약정보 더보기
class MedicationInfoDetailView extends StatefulWidget {
  const MedicationInfoDetailView({super.key});

  @override
  State<MedicationInfoDetailView> createState() => _MedicationInfoDetailViewState();
}

class _MedicationInfoDetailViewState extends State<MedicationInfoDetailView> {
  late MedicationInfoDetailViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = MedicationInfoDetailViewModel(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metrologyInspectionBgColor,
      appBar: const CustomAppBar(
          title: '처방 이력',
          isIconBtn: false),

      body: ChangeNotifierProvider(
        create: (BuildContext context) => _viewModel,
        child: Stack(
          children: [
            SafeArea(
              child: FutureBuilder(
                future: _viewModel.handleMedicationInfoDio(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    return Frame.buildFutureBuilderHasError(
                        snapshot.error.toString(), () => {});
                  }
                  else if(snapshot.connectionState == ConnectionState.done){ // 비동기 작업이 완료되었음
                    return Consumer<MedicationInfoDetailViewModel>(
                      builder: (BuildContext context, value, Widget? child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Frame.myText(
                                  text: '처방이력',
                                  fontSize: 1.2,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListView.separated(
                                  controller: value.scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: value.medicationInfoDataList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return PrescriptionListItem(
                                        medicationInfoData: value.medicationInfoDataList[index]);
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const HorizontalDottedLine(mWidth: 200);
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else {
                    return Frame.buildFutureBuildProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
