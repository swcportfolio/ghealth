
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';

import '../../../widgets/style_text.dart';

class MedicationImage extends StatelessWidget {
  final AnimationController animationController;
  final String? imageUrl;

  const MedicationImage({
    super.key,
    required this.animationController,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
        height: 210,
        decoration: BoxDecoration(
            borderRadius:AppConstants.borderMediumRadius,
            border: Border.all(
                width: AppConstants.borderMediumWidth,
                color: AppColors.greyBoxBorder,
            )),
        child: ClipRRect(
          borderRadius: AppConstants.borderMediumRadius,
          child: buildExtendedImage(
              animationController,
              imageUrl ?? '',
              double.infinity,
          ),
        )
    );
  }

  buildExtendedImage(AnimationController controller, String  url, double size){
    return ExtendedImage.network(
      url.replaceAll('https', 'http'),
      fit: BoxFit.fill,
      alignment: Alignment.center,
      loadStateChanged: (ExtendedImageState state) {

        switch (state.extendedImageLoadState) {
          case LoadState.loading:{
              return Platform.isAndroid
                  ? const Center(
                  child: SizedBox(
                      height: 40.0,
                      width: 40.0,
                      child: CircularProgressIndicator(strokeWidth: 4)))
                  : const Center(
                child: SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: CupertinoActivityIndicator(radius: 15)));
          }
          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
            );
          case LoadState.failed:
            return SizedBox(
              width: double.infinity,
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.question_mark, color: AppColors.primaryColor),
                    const Gap(AppDim.small),
                    const StyleText(text: '사진을 불러오지 못했습니다.')
                  ],
                ),
                onTap: () {
                  state.reLoadImage();
                },
              ),
            );
        }
      },
    );
  }
}
