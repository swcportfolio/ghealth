
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/data/validate/auth_validation_mixin.dart';

import '../../../../../common/common.dart';
import '../../../../model/authorization_test.dart';
import '../../../../model/enum/blood_data_type.dart';
import '../../../../model/vo_blood_test.dart';
import '../../../widgets/frame_scaffold.dart';
import '../../../widgets/style_text.dart';
import 'w_blood_result_list_item.dart';

/// 혈액검사 상세(더보기) 화면
class BloodDetailView extends StatefulWidget {
  final BloodTest bloodTest;

  const BloodDetailView({
    super.key,
    required this.bloodTest,
  });

  @override
  State<BloodDetailView> createState() => _BloodDetailViewState();
}

class _BloodDetailViewState extends State<BloodDetailView> with AuthValidationMixin{

  String get title => '혈액검사';

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: AppDim.mediumLarge,
              horizontal: AppDim.small,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   StyleText(
                      text: title,
                      size: AppDim.fontSizeLarge,
                      fontWeight: AppDim.weightBold,
                  ),

                  /// 검진 날짜
                  StyleText(
                    text: '최근 검진일 : ${widget.bloodTest.issuedDate ?? '-'}',
                    size: AppDim.fontSizeSmall,
                  )
                ],
              ),
              const Gap(AppDim.medium),

              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.bloodTest.toList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return BloodTestResultListItem(
                        bloodValue: widget.bloodTest.toList()[index],
                        bloodName: widget.bloodTest.nameList()[index],
                        bloodDataType: BloodDataType.strToEnum(widget.bloodTest.nameList()[index])
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
