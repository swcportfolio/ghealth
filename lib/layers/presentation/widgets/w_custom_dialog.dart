

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/presentation/tab/reservation/vm_reservation.dart';

import '../../model/enum/region_type.dart';
import '../auth/login_view.dart';
import 'style_text.dart';

class CustomDialog {

  /// 사용자 지정 다이얼로그를 화면에 표시하는 함수.
  ///
  /// [title]: 다이얼로그 상단에 표시할 제목 문자열.
  /// [content]: 다이얼로그 내용에 표시할 문자열.
  /// [mainContext]: 다이얼로그를 띄울 화면의 BuildContext.
  static showMyDialog({
    required String title,
    required String content,
    required BuildContext mainContext,
  }) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: AppConstants.borderLightRadius,
            ),
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Icon(
                    Icons.error,
                    color: AppColors.primaryColor,
                    size: AppDim.xLarge,
                  ),
                  const Gap(AppDim.small),
                  StyleText(
                    text: title,
                    fontWeight: AppDim.weightBold,
                  )
                ],
              ),
            ),
            content: SizedBox(
              height: 135,
              child: Column(
                children: [
                  const Gap(AppDim.xSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDim.large),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 220,
                              child: StyleText(
                                  text: content,
                                  align: TextAlign.center,
                                  size: AppDim.fontSizeSmall,
                                  maxLinesCount: 2,
                                  fontWeight: AppDim.weight500
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  const Gap(AppDim.large),

                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              elevation: 5.0,
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: AppConstants.lightRadius,
                                    bottomLeft: AppConstants.lightRadius,
                                  ))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const StyleText(
                            text: '확인',
                            color: AppColors.white,
                            fontWeight: AppDim.weightBold,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.all(0),
            actionsAlignment: MainAxisAlignment.end,
            actionsPadding: const EdgeInsets.all(0),

          );
        });
  }


  static showLoginDialog({
    required String title,
    required String content,
    required BuildContext mainContext,
  }) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: AppConstants.borderLightRadius),
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: AppColors.primaryColor,
                    size: AppDim.xLarge,
                  ),
                  const Gap(AppDim.small),
                  StyleText(
                    text: title,
                    fontWeight: AppDim.weightBold,
                  )
                ],
              ),
            ),
            content: SizedBox(
              height: 135,
              child: Column(
                children: [
                  const Gap(AppDim.xSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDim.large),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 220,
                              child: StyleText(
                                text: content,
                                align: TextAlign.center,
                                size: AppDim.fontSizeSmall,
                                maxLinesCount: 2,
                                fontWeight: AppDim.weight500,
                              ))
                        ],
                      ),
                    ),
                  ),
                  const Gap(AppDim.large),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 60,
                          height: 45,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                elevation: 3.0,
                                backgroundColor: AppColors.primaryColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5.0)))),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const StyleText(
                              text: '취소',
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      const Gap(1),
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          width: 60,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                elevation: 5.0,
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1.0,
                                        color: AppColors.primaryColor),
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(5.0)))),
                            onPressed: () =>
                            {
                              Navigator.pop(context),
                              Nav.doPush(context, const LoginViewTest()),
                            },
                            child: const StyleText(
                                text: '로그인', color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
            contentPadding: const EdgeInsets.all(0),
            actionsAlignment: MainAxisAlignment.end,
            actionsPadding: const EdgeInsets.all(0),

          );
        });
  }

  /// 네트워크 연결 상태 다이얼로그
  static showNetworkDialog(String title, String text, BuildContext mainContext,
      Function onPressed) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center,
                          textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Container(
                height: 40,
                width: 240,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => onPressed(),
                    child: const Text('확인', textScaleFactor: 1.0,
                        style: TextStyle(color: AppColors.white))
                ),
              ),

            ],
          );
        });
  }


  /// 예약 다이얼로그
  static showReservationDialog({
    required double width,
    required BuildContext mainContext,
    required String reservationDate,
    required String reservationTime,
    required RegionType type,
    required Function() saveReservationFunction,
  }) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: AppConstants.borderMediumRadius,
            ),
            content: SizedBox(
              width: width * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StyleText(
                              text: '건강관리소 방문 예약',
                              size: AppDim.fontSizeLarge,
                              fontWeight: AppDim.weightBold,
                              color: AppColors.primaryColor
                          ),

                          // 오른쪽 상단 취소 버튼
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.close,
                              color: AppColors.darkGrey,
                              size: AppDim.iconSmall,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 예약일
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StyleText(
                            text: '방문장소',
                            color: AppColors.greyTextColor,
                            fontWeight: AppDim.weightBold,
                          ),

                          Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppColors.greyBoxBorder,
                              borderRadius: AppConstants.borderRadius,
                            ),
                            child: Center(
                              child: StyleText(
                                text: type.name,
                                size: AppDim.fontSizeSmall,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),


                    // 예약일
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StyleText(
                            text: '예약일',
                            color: AppColors.greyTextColor,
                            fontWeight: AppDim.weightBold,
                          ),

                          Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppColors.greyBoxBorder,
                              borderRadius: AppConstants.borderRadius,
                            ),
                            child: Center(
                              child: StyleText(
                                text: reservationDate,
                                size: AppDim.fontSizeSmall,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 예약시간 타이틀
                          const StyleText(
                            text: '예약시간',
                            fontWeight: AppDim.weightBold,
                            color: AppColors.grey,
                          ),
                          Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                                color: AppColors.greyBoxBorder,
                                borderRadius: AppConstants.borderRadius,
                            ),
                            child: Center(
                              child: StyleText(
                                text: reservationTime,
                                size: AppDim.fontSizeSmall,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap(AppDim.xSmall),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const StyleText(
                          text: '해당 날짜의 ',
                          align: TextAlign.center,
                          size: AppDim.fontSizeSmall,
                        ),
                        StyleText(
                          text: '예약을 진행',
                          align: TextAlign.center,
                          size: AppDim.fontSizeSmall,
                          fontWeight: AppDim.weightBold,
                          color: AppColors.primaryColor,
                        ),
                        const StyleText(
                          text: '하시겠습니까?',
                          align: TextAlign.center,
                          size: AppDim.fontSizeSmall,
                        ),
                      ],
                    ),
                    const Gap(AppDim.medium),

                    // 예약하기
                    InkWell(
                      onTap: () =>
                      {
                        Navigator.pop(context),
                        saveReservationFunction(),
                      },
                      child: Container(
                        height: 43,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: AppColors.primaryColor
                        ),
                        child: const Center(
                            child: StyleText(
                              text: '예약 하기',
                              color: AppColors.white,
                              fontWeight: AppDim.weightBold,
                              size: AppDim.fontSizeSmall,
                            )
                        ),
                      ),
                    ),
                    const Gap(15),
                  ],
                ),
              ),
            ),
            contentPadding: const EdgeInsets.all(0),
            actionsAlignment: MainAxisAlignment.end,
            actionsPadding: const EdgeInsets.all(0),

          );
        });
  }


  /// 예약 취소 다이얼로그
  static showCancelReservationDialog({
    required BuildContext mainContext,
    required String reservationDate,
    required String reservationTime,
    required RegionType type,
    required Function() cancelReservationFunction,
  }) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: AppConstants.borderMediumRadius),
            content: SizedBox(
              height: 340,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppDim.mediumLarge),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StyleText(
                            text: '방문 예약 취소',
                            size: AppDim.fontSizeLarge,
                            fontWeight: AppDim.weightBold,
                            color: AppColors.primaryColor
                        ),

                        // 오른쪽 상단 취소 버튼
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            color: AppColors.darkGrey,
                            size: AppDim.iconSmall,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 예약일
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const StyleText(
                          text: '방문 장소',
                          fontWeight: AppDim.weightBold,

                        ),

                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: AppColors.greyBoxBorder,
                              borderRadius: AppConstants.borderRadius
                          ),
                          child: Center(
                            child: StyleText(
                              text: '${type.name} 건강관리소',
                              size: AppDim.fontSizeSmall,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // 예약일
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const StyleText(
                          text: '예약일',
                          fontWeight: AppDim.weightBold,

                        ),

                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: AppColors.greyBoxBorder,
                            borderRadius: AppConstants.borderRadius,
                          ),
                          child: Center(
                            child: StyleText(
                              text: reservationDate,
                              size: AppDim.fontSizeSmall,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 예약시간 타이틀
                        const StyleText(
                          text: '예약시간',
                          fontWeight: AppDim.weightBold,
                        ),
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: AppColors.greyBoxBorder,
                            borderRadius: AppConstants.borderRadius,
                          ),
                          child: Center(
                            child: StyleText(
                              text: reservationTime,
                              size: AppDim.fontSizeSmall,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const StyleText(
                        text: '예약을 ',
                        size: AppDim.fontSizeSmall,
                      ),
                      StyleText(
                        text: '취소',
                        size: AppDim.fontSizeSmall,
                        color: AppColors.primaryColor,
                        fontWeight: AppDim.weightBold,
                      ),
                      const StyleText(
                        text: '하시겠습니까?',
                        size: AppDim.fontSizeSmall,
                      ),
                    ],
                  ),

                  const Gap(AppDim.medium),
                  // 예약하기
                  InkWell(
                    onTap: () =>
                    {
                      Navigator.pop(context),
                      cancelReservationFunction(),
                    },
                    child: Container(
                      height: 43,
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppDim.medium),
                      decoration: BoxDecoration(
                          borderRadius: AppConstants.borderRadius,
                          color: AppColors.primaryColor
                      ),
                      child: const Center(
                          child: StyleText(
                            text: '취소하기',
                            color: AppColors.white,
                            fontWeight: AppDim.weightBold,
                            size: AppDim.fontSizeSmall,
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
            contentPadding: const EdgeInsets.all(0),
            actionsAlignment: MainAxisAlignment.end,
            actionsPadding: const EdgeInsets.all(0),

          );
        });
  }


  /// 설정 다이얼 로그(로그 아웃)
  static showSettingDialog({
    required String title,
    required String text,
    required BuildContext mainContext,
    required Function onPressed
  }) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: AppConstants.borderLightRadius),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleText(
                    text: title,
                    fontWeight: AppDim.weightBold,
                  ),
                ],
              ),
            ),
            content: SizedBox(
              height: 122,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 190,
                            height: 31,
                            child: StyleText(
                              text: text,
                              align: TextAlign.center,
                              size: AppDim.fontSizeSmall,
                              maxLinesCount: 2,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34),
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: SizedBox(
                            width: 60,
                            height: 45,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  elevation: 3.0,
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: AppConstants.lightRadius))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const StyleText(
                                  text: '취소', color: AppColors.white),
                            ),
                          ),
                        ),
                        const Gap(1),

                        Expanded(
                          child: SizedBox(
                            height: 45,
                            width: 60,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  elevation: 5.0,
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1.0,
                                          color: AppColors.primaryColor),
                                      borderRadius:  BorderRadius.only(
                                          bottomRight: AppConstants.lightRadius))),
                              onPressed: () => onPressed(),
                              child: const StyleText(
                                  text: '확인',
                                  color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.all(0.0),
          );
        });
  }


  /// Dio Exception Dialog
  static showDioDialog(String title, String text, BuildContext mainContext,
      {required Function onPositive}) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center,
                          textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[


              Container(
                width: 240,
                height: 40,
                margin: const EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => onPositive(),
                    child: const Text('확인', textScaleFactor: 1.0,
                        style: TextStyle(color: AppColors.grey))
                ),
              )

            ],
          );
        });
  }


  /// 팝업 형태로 표시
  static popup(context,
      {required Widget child, double width = 300, required double height, double padding = 10,
        bool bBackgroundTapPop = true, Color color = AppColors
          .white, double round = 15.0}) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(round))),
            contentPadding: EdgeInsets.all(padding),
            content: Container(
                width: width,
                //height:  // 호출 하는 곳의 column에서 mainAxisSize: MainAxisSize.min 적용 필요
                child: child
            ),
          );
        }
    );
  }
}
