
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghealth_app/main.dart';
import 'package:ghealth_app/utlis/etc.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:ghealth_app/widgets/horizontal_dashed_line.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../utlis/colors.dart';

enum UserInfoType {
  name,
  phone,
  email,
  address
}

/// 개인 정보 수정화면
class MyInfoView extends StatefulWidget {
  const MyInfoView({super.key});

  @override
  State<MyInfoView> createState() => _MyInfoViewState();
}

class _MyInfoViewState extends State<MyInfoView> {
  String? croppedProfileFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '개인 정보 수정'
      ),

     body: SingleChildScrollView(
       physics: const BouncingScrollPhysics(),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           buildProfileImage(),
           buildName(),
           const SizedBox(height: 15),
           buildLogoutBtn(),
           buildUserInfoBox(),
           buildBottomGuideText(),
         ],
       ),
     ),
    );
  }

  /// 프로필 사진 및 닉네임?
  Widget buildProfileImage() {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 55,
                    backgroundImage: croppedProfileFilePath == null
                        ? Image.asset('images/profile_image.png').image
                        : FileImage(File(croppedProfileFilePath.toString()))),
                Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                        child: InkWell(
                            onTap: () async {
                              final XFile? image = await ImagePicker().pickImage(
                                  source: ImageSource.gallery);
                              if (image == null) return;

                              var croppedProfileFile = await ImageCropper().cropImage(
                                sourcePath: image.path.toString(),
                                aspectRatioPresets: [
                                  CropAspectRatioPreset.square,
                                  CropAspectRatioPreset.ratio3x2,
                                  CropAspectRatioPreset.original,
                                  CropAspectRatioPreset.ratio4x3,
                                  CropAspectRatioPreset.ratio16x9
                                ],
                                uiSettings: [
                                  AndroidUiSettings(
                                      toolbarTitle: '사진 편집',
                                      toolbarColor: mainColor,
                                      toolbarWidgetColor: Colors.white,
                                      initAspectRatio:
                                      CropAspectRatioPreset.original,
                                      lockAspectRatio: false),
                                  IOSUiSettings(
                                      title: '사진 편집', minimumAspectRatio: 1.0),
                                ],
                              );
                              setState(() {
                                croppedProfileFilePath = croppedProfileFile!.path;
                              });
                            },
                            child: CircleAvatar(
                                backgroundColor: mainColor,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(50))
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: mainColor,
                                    size: 21,
                                  ),
                                ))))
                )
              ]),
            ],
          ),
          const SizedBox(height: 12),
         // HighLightedText('홍길동 님', color: mainColor)
        ],
      ),
    );
  }

  /// 사용자 이름
  Widget buildName(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Frame.myText(
          text: '홍길동',
          fontSize: 1.7,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
        Frame.myText(
          text: '님',
          fontSize: 1.7
        )
      ],
    );
  }

  /// 로그아웃 버튼
  Widget buildLogoutBtn(){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
        child: Frame.myText(
          text: '로그아웃',
          fontSize: 1.3,
          color: mainColor
        ),
      ),
    );
  }

  /// 사용자 정보 박스
  Widget buildUserInfoBox(){
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 30),
      child: Column(
        children: [
          Etc.solidNotPaddingLine(context),
          buildInfoItem(Icons.account_circle_outlined, '홍길동', UserInfoType.name),
          const HorizontalDottedLine(mWidth: double.infinity),
          buildInfoItem(Icons.phone, '+82 01**-34**', UserInfoType.phone),
          const HorizontalDottedLine(mWidth: double.infinity),
          buildInfoItem(Icons.email, 'adbce123@gmail.com', UserInfoType.email),
          const HorizontalDottedLine(mWidth: double.infinity),
          buildInfoItem(Icons.location_on, '서울특별시 강동구 길동', UserInfoType.address),
          Etc.solidNotPaddingLine(context),
        ],
      ),
    );
  }

  /// 사용자 정보 아이템
  Widget buildInfoItem(IconData iconData, String text, UserInfoType type){
    return SizedBox(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(iconData, color: mainColor, size: 32),
          Frame.myText(
            text: text,
            fontSize: 1.3,
            fontWeight: FontWeight.w500
          ),
          buildEditBtn(type)
        ],
      ),
    );
  }

  /// 수정버튼
  Widget buildEditBtn(UserInfoType type){
    return GestureDetector(
      onTap: (){},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Frame.myText(
          text: '수정',
          fontSize: 1.2,
          color: Colors.grey
        ),
      ),
    );
  }

  /// bottom text
  Widget buildBottomGuideText(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Frame.myText(
        text: '계정 정보를 확인하고 안전하게 건강관리하세요.',
        maxLinesCount: 2,
        color: Colors.grey,
        fontSize: 1.0
      ),
    );
  }
}
