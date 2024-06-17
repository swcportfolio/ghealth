import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/layers/presentation/tab/checkup/medication/w_medication_image.dart';
import 'package:ghealth_app/layers/presentation/widgets/frame_scaffold.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_future_handler.dart';
import 'package:provider/provider.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../../../common/data/validate/auth_validation_mixin.dart';
import '../../../../model/authorization_test.dart';
import '../../../../model/enum/drug_info_type.dart';
import '../../../widgets/style_text.dart';
import 'vm_drug_info.dart';

/// 처방약 상세설명서
class DrugInfoView extends StatefulWidget {
  /// 처방 약 코드
  final String medicationCode;

  const DrugInfoView({
    super.key,
    required this.medicationCode,
  });

  @override
  State<DrugInfoView> createState() => _DrugInfoViewState();
}

class _DrugInfoViewState extends State<DrugInfoView> with TickerProviderStateMixin, AuthValidationMixin{
  late AnimationController animationController;
  late TabController _tabController;

  @override
  void initState() {
    checkAuthToken(context);
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        lowerBound: 0.0,
        upperBound: 1.0);

    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  String get title => '의약품 정보';

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,
      body: ChangeNotifierProvider(
          create: (context) =>
              DrugInfoViewModelTest(context, widget.medicationCode),
          child: Padding(
            padding: AppConstants.viewPadding,
            child: Consumer<DrugInfoViewModelTest>(
              builder: (context, provider, child) {
                return FutureHandler(
                  isLoading: provider.isLoading,
                  isError: provider.isError,
                  errorMessage: provider.errorMessage,
                  onRetry: () {},
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const Gap(AppDim.medium),

                        /// 처방 약 이미지
                        MedicationImage(
                          animationController: animationController,
                          imageUrl: provider.drugInfoDataDTO?.imageUrl,
                        ),

                        /// 처방 약 정보
                        buildMedicineInfo(),
                        const Gap(AppDim.medium),

                        /// 처방 약 상세
                        buildMedicineDetail(),
                        const Gap(AppDim.medium)
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }

  buildMedicineInfo() {
    return Consumer<DrugInfoViewModelTest>(
      builder: (context, proiver, child) {
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDim.mediumLarge),
            margin: const EdgeInsets.only(top: AppDim.mediumLarge),
            decoration: BoxDecoration(
              borderRadius: AppConstants.borderMediumRadius,
              border: Border.all(
                width: AppConstants.borderMediumWidth,
                color: AppColors.greyBoxBorder,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleText(
                  text: '${proiver.drugInfoDataDTO?.drugNameKR}',
                  size: AppDim.fontSizeXLarge,
                  fontWeight: FontWeight.bold,
                ),
                const Gap(AppDim.mediumLarge),
                StyleText(
                    text: '• ${proiver.drugInfoDataDTO?.drugNameEN}',
                    maxLinesCount: 3,
                    softWrap: true),
                const Gap(AppDim.small),
                StyleText(
                    text: '• ${proiver.drugInfoDataDTO?.ingredient}',
                    maxLinesCount: 3,
                    softWrap: true),
                const Gap(AppDim.small),
                const StyleText(
                  text: '• 보험급여가격: 0',
                )
              ],
            ));
      },
    );
  }


  Widget buildMedicineDetail() {
    return Consumer<DrugInfoViewModelTest>(
      builder: (context, provider, child) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildChip('복약', DrugInfoType.taking,
                      provider.isSelectedList[0], provider),
                  buildChip('용법', DrugInfoType.usage,
                      provider.isSelectedList[1], provider),
                  buildChip('효능', DrugInfoType.efficacy,
                      provider.isSelectedList[2], provider),
                  buildChip('주의', DrugInfoType.advise,
                      provider.isSelectedList[3], provider),
                  buildChip('DUR', DrugInfoType.dur, provider.isSelectedList[4],
                      provider),
                  buildChip('기본', DrugInfoType.basic,
                      provider.isSelectedList[5], provider),
                ],
              ),
            ),
            const Gap(AppDim.xSmall),
            Container(
              padding: const EdgeInsets.all(AppDim.large),
              decoration: BoxDecoration(
                borderRadius: AppConstants.borderMediumRadius,
                color: AppColors.greyBoxBg,
              ),
              child: provider.isSelectedList[5]
                  ? buildMedicationInfoBasicItem(provider)
                  : buildMedicationInfoSection(
                      title: provider.medicationEtcTitle,
                      content: provider.medicationEtcContent),
            )
          ],
          //buildSelectedChipView()
        );
      },
    );
  }


  /// 6번째 항목(기본) - 분류번호, 성분정보, 성상 내용
  buildMedicationInfoBasicItem(DrugInfoViewModelTest provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 분류번호
        buildMedicationInfoSection(
            title: provider.medicationEtcTitle,
            content: provider.medicationEtcContent),
        const Gap(20),

        /// 성분정보
        buildMedicationInfoSection(
            title: provider.medicationIngredientTitle,
            content: provider.medicationIngredientContent),
        const Gap(20),

        /// 성상
        buildMedicationInfoSection(
            title: provider.medicationPropertiesTitle,
            content: provider.medicationPropertiesContent)
      ],
    );
  }


  buildMedicationInfoSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 타이틀
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: AppDim.xSmall,
            horizontal: AppDim.small,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppConstants.borderRadius,
            border: Border.all(
              color: AppColors.greyDarkBoxBorder,
              width: AppConstants.borderLightWidth,
            ),
          ),
          child: StyleText(
              text: title,
              fontWeight: AppDim.weightBold,
          ),

        ),
        const Gap(AppDim.small),

        /// 내용
        Padding(
          padding: const EdgeInsets.only(left: AppDim.xSmall),
          child: StyleText(
              text: content,
              size: AppDim.fontSizeSmall,
              softWrap: true,
              maxLinesCount: 700),
        ),
      ],
    );
  }


  buildChip(String label, DrugInfoType type, isSelected, DrugInfoViewModelTest provider) {
    return GestureDetector(
      onTap: () => provider.onPressedChip(type),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDim.xSmall),
        child: Chip(
          labelPadding: const EdgeInsets.symmetric(horizontal: AppDim.small),
          backgroundColor: isSelected ? AppColors.brightBlue : Colors.white,
          label: StyleText(
            text: label,
            size: AppDim.fontSizeSmall,
            color:
                isSelected ? AppColors.primaryColor : AppColors.greyTextColor,
            fontWeight: AppDim.weightBold,
          ),
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: AppConstants.borderMediumRadius,
            side: BorderSide(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.greyDarkBoxBorder,
              width: AppConstants.borderLightWidth,
            ),
          ),
          padding: const EdgeInsets.all(AppDim.small),
        ),
      ),
    );
  }
}
