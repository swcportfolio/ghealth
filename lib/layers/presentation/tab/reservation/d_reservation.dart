
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../model/enum/region_type.dart';
import '../../widgets/style_text.dart';

class ReservationDialogTest{

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
                borderRadius: BorderRadius.circular(20.0)),
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
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                          ),

                          // 오른쪽 상단 취소 버튼
                          InkWell(
                            onTap: ()=> Navigator.pop(context),
                            child: const Icon(Icons.close,
                                color: Colors.black, size: 25),
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
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                          ),

                          Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30)
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
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                          ),

                          Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30)
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
                          StyleText(
                            text: '예약시간',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                          Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30)
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
                            text: '해당 날짜의 ',
                            align: TextAlign.center,
                            size: AppDim.fontSizeSmall,
                        ),
                        StyleText(
                          text: '예약을 진행',
                          align: TextAlign.center,
                          size: AppDim.fontSizeSmall,

                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                        const StyleText(
                            text: '하시겠습니까?',
                            align: TextAlign.center,
                          size: AppDim.fontSizeSmall,
                        ),
                      ],
                    ),

                    const Gap(15),
                    // 예약하기
                    InkWell(
                      onTap: ()=> {
                        Navigator.pop(context),
                        saveReservationFunction(),
                      },
                      child: Container(
                        height: 43,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: AppColors.primaryColor,
                        ),
                        child: const Center(
                            child: StyleText(
                                text: '예약 하기',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                borderRadius: BorderRadius.circular(20.0)),
            content: SizedBox(
              height: 340,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StyleText(
                            text: '방문 예약 취소',
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor
                        ),

                        // 오른쪽 상단 취소 버튼
                        InkWell(
                          onTap: ()=> Navigator.pop(context),
                          child: const Icon(Icons.close,
                              color: Colors.black, size: 25),
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
                            fontWeight: FontWeight.bold,
                        ),

                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30)
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
                            fontWeight: FontWeight.bold,

                        ),

                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30)
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
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30)
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
                          fontWeight: FontWeight.w600
                      ),
                      StyleText(
                          text: '하시겠습니까?',
                        size: AppDim.fontSizeSmall,
                      ),
                    ],
                  ),

                  const Gap(15),
                  // 예약하기
                  InkWell(
                    onTap: ()=> {
                      Navigator.pop(context),
                      cancelReservationFunction(),
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
                              text: '취소하기',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
}