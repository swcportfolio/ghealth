import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:ghealth_app/common/common.dart';


class MyPhotoView extends StatelessWidget {
  final String imagePath;

  const MyPhotoView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.veryDarkGrey,
        body: Padding(
          padding: AppConstants.viewPadding,
          child: Stack(
            children: [
              PhotoView(
                imageProvider: AssetImage(imagePath),
              ),
              Positioned(
                top: 70,
                right: 20,
                child: IconButton(
                  onPressed: () => Nav.doPop(context),
                  icon: const Icon(
                      Icons.cancel_outlined,
                      color: AppColors.white,
                      size: AppDim.iconMedium),

                ),
              )
            ],
          ),
        )
    );
  }
}
