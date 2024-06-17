
// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/checkup/medication/v_medication_detail.dart';

import '../../../../../common/common.dart';
import '../../../../entity/summary_dto.dart';
import '../../../widgets/style_text.dart';
import '../../../widgets/w_dotted_line.dart';
import 'w_medication_list_item.dart';

/// 처방 이력 - 투약정보 위젯
class MedicationHistory extends StatelessWidget {
  final  List<MedicationInfoDTO>? medicationInfoList;

  const MedicationHistory({
    super.key,
    required this.medicationInfoList,
  });

  String get titleText => '처방이력';
  String get addText => '자세히';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppConstants.borderRadius,
          border: Border.all(
              width: AppConstants.borderMediumWidth,
              color: AppColors.greyBoxBorder)
      ),
      child: SizedBox(
        height: medicationInfoList == null || medicationInfoList?.length == 0
            ? 220 : 300,
        child: Padding(
          padding: const EdgeInsets.all(AppDim.mediumLarge),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   StyleText(
                      text: titleText,
                      fontWeight: AppDim.weightBold
                  ),

                  /// 더보기 버튼
                  Visibility(
                    visible: medicationInfoList == null || medicationInfoList?.length == 0
                        ? false : true,
                    child: InkWell(
                      onTap: ()=> Nav.doPush(context, const MedicationDetailViewTest()),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StyleText(
                              text: addText,
                              size: AppDim.fontSizeSmall,
                              fontWeight: AppDim.weight500,
                              softWrap: true,
                          ),
                          const Gap(AppDim.xSmall),

                          const Icon(
                              Icons.arrow_forward_ios,
                              size: AppDim.iconXxSmall,
                          )
                        ],
                      ),
                    ),

                  )
                ],
              ),
              const Gap(AppDim.mediumLarge),

              medicationInfoList == null || medicationInfoList?.length == 0
                  ? _buildMedicEmptyView()
                  : Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: medicationInfoList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MedicationListItem(
                              medicationInfoDTO: medicationInfoList![index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const DottedLine(mWidth: 200);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  /// 건강 검진 결과 안내의 종합소견_판정의 데이터가 ''일 경우
  /// 전체 EmptyView 화면을 보여준다.
  _buildMedicEmptyView(){
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              '${AppStrings.imagePath}/tab/daily/empty_search_image.png',
              height: 60,
              width: 60,
          ),
          const Gap(AppDim.medium),

          Container(
            padding: const EdgeInsets.all(AppDim.small),
            decoration: BoxDecoration(
                color: AppColors.greyBoxBorder,
                borderRadius: AppConstants.borderLightRadius,
            ),
            child: const StyleText(
                text: '처방하신 내역이 없습니다.',
                maxLinesCount: 2,
                size: AppDim.fontSizeSmall,
                softWrap: true,
                fontWeight: AppDim.weight500
            ),
          )
        ],
      ),
    );
  }
}
