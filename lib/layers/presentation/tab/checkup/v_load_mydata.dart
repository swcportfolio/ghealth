import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';

import '../../widgets/frame_scaffold.dart';
import '../../widgets/style_text.dart';
import '../../widgets/w_dotted_line.dart';
import 'w_my_photo_view.dart';

/// 사용하고 있지 않는 화면
class LoadMyDataView extends StatefulWidget {
  const LoadMyDataView({super.key});

  @override
  State<LoadMyDataView> createState() => _LoadMyDataViewState();
}

class _LoadMyDataViewState extends State<LoadMyDataView> {

  String get title => '나의건강기록 가져오기';

  String get fristImagePath => '${AppStrings.imagePath}/tab/checkup/my_health_record_image1.png';
  String get secondImagePath => '${AppStrings.imagePath}/tab/checkup/my_health_record_image2.png';
  String get thirdImagePath => '${AppStrings.imagePath}/tab/checkup/my_health_record_image3.png';
  String get fourthImagePath => '${AppStrings.imagePath}/tab/checkup/my_health_record_image4.png';

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,
      body: Padding(
          padding: AppConstants.viewPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(AppDim.large),

                const StyleText(
                  text: '나의 건강기록 가져오는 방법으로\n순차적으로 따라해주세요.',
                  softWrap: true,
                  maxLinesCount: 2,
                  size: AppDim.fontSizeXLarge,
                  fontWeight: AppDim.weightBold,
                ),
                const Gap(AppDim.small),
                StyleText(
                    text: 'Tip) 이미지를 클릭하시면 확대가 가능합니다.',
                  color: AppColors.greyTextColor,
                  size: AppDim.fontSizeSmall,
                ),

                const Gap(AppDim.large),
                Center(
                  child: InkWell(
                      onTap: () => Nav.doPush(context, MyPhotoView(imagePath: fristImagePath)),
                      child: Image.asset(fristImagePath)),
                ),
                const DottedLine(mWidth: double.infinity),
                const Gap(AppDim.large),

                Center(
                  child: InkWell(
                      onTap: () => Nav.doPush(context, MyPhotoView(imagePath: secondImagePath)),
                      child: Image.asset(secondImagePath)),
                ),
                const DottedLine(mWidth: double.infinity),
                const Gap(AppDim.large),

                Center(
                  child: InkWell(
                      onTap: () => Nav.doPush(context, MyPhotoView(imagePath: thirdImagePath)),
                      child: Image.asset(thirdImagePath)),
                ),
                const DottedLine(mWidth: double.infinity),
                const Gap(AppDim.large),

                Center(
                  child: InkWell(
                      onTap: () => Nav.doPush(context, MyPhotoView(imagePath: fourthImagePath)),
                      child: Image.asset(fourthImagePath)),
                ),
                const DottedLine(mWidth: double.infinity),
                const Gap(AppDim.large),
              ],
            ),
          )),
    );
  }
}
