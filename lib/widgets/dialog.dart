import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ghealth_app/data/models/gallery3d_data.dart';
import 'package:ghealth_app/view/login/login_view.dart';
import '../layers/presentation/auth/login_view.dart';
import '../utils/colors.dart';
import '../view/reservation/reservation_viewmodel.dart';
import 'frame.dart';


class CustomDialog{

  /// 사용자 지정 다이얼로그를 화면에 표시하는 함수.
  ///
  /// [title]: 다이얼로그 상단에 표시할 제목 문자열.
  /// [content]: 다이얼로그 내용에 표시할 문자열.
  /// [mainContext]: 다이얼로그를 띄울 화면의 BuildContext.
  ///
  /// 반환값: 다이얼로그를 화면에 표시합니다.
  ///
  /// 이 함수는 커스텀 스타일을 적용한 AlertDialog를 화면에 띄웁니다.
  /// [title]은 다이얼로그 상단에 아이콘과 함께 표시되는 제목입니다.
  /// [content]는 다이얼로그의 본문 내용을 나타낸다
  ///
  /// 주요 기능:
  /// 1. 커스텀 스타일을 적용한 AlertDialog 표시.
  /// 2. 다이얼로그 내부에 아이콘과 제목 텍스트 표시.
  /// 3. 내용 텍스트 표시 및 취소 버튼 옵션.
  /// 4. 확인 버튼을 누르면 다이얼로그가 닫힙니다.
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
                borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: mainColor, size: 35),
                  const Gap(10),
                  Frame.myText(
                      text: title, fontSize: 1.0, fontWeight: FontWeight.w600)
                ],
              ),
            ),
            content: SizedBox(
              height: 135,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 220,
                              child: Frame.myText(
                                  text: content,
                                  align: TextAlign.center,
                                  fontSize: 0.9,
                                  maxLinesCount: 2,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              elevation: 5.0,
                              backgroundColor: mainColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Frame.myText(
                              text: '확인', fontSize: 1.1, color: Colors.white, fontWeight: FontWeight.w600)),
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
                borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: mainColor, size: 35),
                  const Gap(10),
                  Frame.myText(text: title, fontSize: 1.0, fontWeight: FontWeight.w600)
                ],
              ),
            ),
            content: SizedBox(
              height: 130,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 220,
                              child: Frame.myText(
                                  text: content,
                                  align: TextAlign.center,
                                  fontSize: 0.9,
                                  maxLinesCount: 2,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 60,
                          height: 45,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  elevation: 3.0,
                                  backgroundColor: mainColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5.0)))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Frame.myText(text: '취소', color: Colors.white),
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
                                  backgroundColor: mainColor,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(width: 1.0, color: mainColor),
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0)))),
                              onPressed: () =>{
                                //Navigator.pop(context),
                                Frame.doPagePush(context, const LoginViewTest()),
                              } ,
                              child: Frame.myText(text: '로그인', color: Colors.white),
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
  static showNetworkDialog(String title, String text, BuildContext mainContext, Function onPressed) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
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
                      child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Container(
                height: 40,
                width:  240,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => onPressed(),
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
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
                          Frame.myText(
                            text: '건강관리소 방문 예약',
                            fontSize: 1.2,
                            fontWeight: FontWeight.bold,
                            color: mainColor
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
                          Frame.myText(
                              text: '방문장소',
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 1.0
                          ),

                          Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Center(
                              child: Frame.myText(
                                  text: type.name,
                                  fontSize: 0.9
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
                          Frame.myText(
                              text: '예약일',
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 1.0
                          ),

                          Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Center(
                              child: Frame.myText(
                                  text: reservationDate,
                                  fontSize: 0.9
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
                          Frame.myText(
                            text: '예약시간',
                            fontSize: 1.0,
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
                              child: Frame.myText(
                                  text: reservationTime,
                                  fontSize: 0.9
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
                        Frame.myText(
                            text: '해당 날짜의 ',
                            align: TextAlign.center,
                            fontSize: 0.9
                        ),
                        Frame.myText(
                            text: '예약을 진행',
                            align: TextAlign.center,
                            fontSize: 0.9,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                        ),
                        Frame.myText(
                            text: '하시겠습니까?',
                            align: TextAlign.center,
                            fontSize: 0.9
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
                          color: mainColor
                        ),
                        child: Center(
                          child: Frame.myText(
                            text: '예약 하기',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 0.9
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
                        Frame.myText(
                            text: '방문 예약 취소',
                            fontSize: 1.2,
                            fontWeight: FontWeight.bold,
                            color: mainColor
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
                        Frame.myText(
                            text: '방문 장소',
                            fontWeight: FontWeight.bold,
                            fontSize: 1.0
                        ),

                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(
                            child: Frame.myText(
                                text: '${type.name} 건강관리소',
                                fontSize: 0.9
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
                        Frame.myText(
                            text: '예약일',
                            fontWeight: FontWeight.bold,
                            fontSize: 1.0
                        ),

                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(
                            child: Frame.myText(
                                text: reservationDate,
                                fontSize: 0.9
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
                        Frame.myText(
                          text: '예약시간',
                          fontSize: 1.0,
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
                            child: Frame.myText(
                                text: reservationTime,
                                fontSize: 0.9
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
                      Frame.myText(
                          text: '예약을 ',
                          fontSize: 0.9,
                      ),
                      Frame.myText(
                          text: '취소',
                          fontSize: 0.9,
                          color: mainColor,
                          fontWeight: FontWeight.w600
                      ),
                      Frame.myText(
                          text: '하시겠습니까?',
                          fontSize: 0.9
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
                          color: mainColor
                      ),
                      child: Center(
                          child: Frame.myText(
                              text: '취소하기',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 0.9
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


  /// Gallery3dDialog
  static showGallery3dDialog({
    required BuildContext mainContext,
    required double mHeight,
    required GalleryType type,
  }) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: type == GalleryType.card1
                ? buildCard1Content(mHeight, context)
                : type == GalleryType.card2
                    ? buildCard2Content(mHeight, context)
                    : buildCard3Content(mHeight, context),
            contentPadding: const EdgeInsets.all(0),
            actionsAlignment: MainAxisAlignment.end,
            actionsPadding: const EdgeInsets.all(0),
          );
        });
  }

  static buildCard1Content(double mHeight, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Frame.myText(
                    text: '동구 라이프로그',
                    fontSize: 1.2,
                    fontWeight: FontWeight.bold,
                    color: mainColor
                ),

                // 오른쪽 상단 취소 버튼
                InkWell(
                  onTap: ()=> Navigator.pop(context),
                  child: const Icon(Icons.clear,
                      color: Colors.black, size: 25),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                    text: '신청절차',
                    fontSize: 1.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
                ),
                const Gap(5),
                Frame.myText(
                  text: '\“동구라이프로그 건강관리소\“신청하기 \n클릭 후, 원하는방문일자와 시간으로\n예약 신청',
                  maxLinesCount: 4,
                  fontSize: 0.8
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                  text: '혜택',
                  fontSize: 1.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
                ),
                const Gap(5),
                Frame.myText(
                    text: '1. 라이프로그 실증장비 체험\n2. 데이터수집을 통해 포인트 제공',
                    maxLinesCount: 4,
                    fontSize: 0.8
                )
              ],
            ),
          ),

          /// 닫기 버튼
          InkWell(
            onTap: ()=> Navigator.pop(context),
            child: Container(
              height: 45,
              margin: const EdgeInsets.fromLTRB(15, 30, 15, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: mainColor
              ),
              child: Center(
                  child: Frame.myText(
                      text: '닫기',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 0.9
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
  static buildCard2Content(double mHeight, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Frame.myText(
                    text: '스트레스 샤워실',
                    fontSize: 1.3,
                    fontWeight: FontWeight.bold,
                    color: mainColor
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

          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                    text: '신청절차',
                    fontWeight: FontWeight.w500,
                    fontSize: 0.9,
                    color: Colors.grey
                ),
                const Gap(10),
                Frame.myText(
                    text: '\“동구라이프로그 스트레스 샤워실\“신청\n하기 클릭 후, 원하는방문일자와 시간으로\n예약신청',
                    maxLinesCount: 4,
                    fontSize: 0.8
                )
              ],
            ),
          ),

          /// 닫기 버튼
          InkWell(
            onTap: ()=> Navigator.pop(context),
            child: Container(
              height: 45,
              margin: const EdgeInsets.fromLTRB(15, 30, 15, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: mainColor
              ),
              child: Center(
                  child: Frame.myText(
                      text: '닫기',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 0.9
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
  static buildCard3Content(double mHeight, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Frame.myText(
                    text: 'G-Health 기업실증',
                    fontSize: 1.3,
                    fontWeight: FontWeight.bold,
                    color: mainColor
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

          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                    text: '신청절차',
                    fontWeight: FontWeight.w600,
                    fontSize: 0.9,
                    color: Colors.grey
                ),
                const Gap(5),
                Frame.myText(
                    text: '\“G-Health 기업실증\“신청하기 클릭 후\n, 기업별 실증내용을 확인하고 원하는\n기업으로 신청',
                    maxLinesCount: 4,
                    fontSize: 0.8
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                  text: '체험인원 선정방법',
                  fontSize: 0.9,
                  maxLinesCount: 2,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                const Gap(5),
                Frame.myText(
                    text: '신청인원 중 기업들이 제품에 맞는 체험자 \n선정 후, 개별연락',
                    maxLinesCount: 3,
                    fontSize: 0.8
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Frame.myText(
                  text: '혜택',
                  fontSize: 0.9,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                const Gap(5),
                Frame.myText(
                    text: '기업실증 참여를 통한 제품체험 및 데이터\n제공에 따른 온누리상품권 제공(기업별상\n이, 기업안내 참고',
                    maxLinesCount: 5,
                    fontSize: 0.8
                )
              ],
            ),
          ),

          /// 닫기 버튼
          InkWell(
            onTap: ()=> Navigator.pop(context),
            child: Container(
              height: 45,
              margin: const EdgeInsets.fromLTRB(15, 30, 15, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: mainColor
              ),
              child: Center(
                  child: Frame.myText(
                      text: '닫기',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 0.9
                  )
              ),
            ),
          )
        ],
      ),
    );
  }


  /// 설정 다이얼 로그
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
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
                        Container(
                            width: 190,
                            height: 31,
                            child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34),
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: Container(
                            width: 60,
                            height: 45,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    elevation: 3.0,
                                    backgroundColor: mainColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5.0)))),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Frame.myText(text: '취소', color: Colors.white),
                            ),
                          ),
                        ),
                        const Gap(1),

                        Expanded(
                          child: Container(
                            height: 45,
                            width: 60,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    elevation: 5.0,
                                    backgroundColor: mainColor,
                                    shape: const RoundedRectangleBorder(
                                        side: BorderSide(width: 1.0, color: mainColor),
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0)))),
                                onPressed: () => onPressed(),
                                child: Frame.myText(text: '확인', color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: EdgeInsets.all(0.0),
          );
        });
  }


  /// Dio Exception Dialog
  static showDioDialog(String title, String text, BuildContext mainContext, {required Function onPositive}) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
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
                      child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[


              Container(
                width: 240,
                height: 40,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => onPositive(),
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.grey.shade600))
                ),
              )

            ],
          );
        });
  }

  /// bluetooth off state
  static showMenuDialog(BuildContext mainContext, {required double height}) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              height: height,
              width: 300,
              child: Column(
                  children: [
                    Icon(Icons.error, color: mainColor, size: 40),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text('블루투스 상태', textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 190,
                              child: Text('블루투스 기능을 활성화 해주세요.', textAlign: TextAlign.center, textScaleFactor: 0.85)),
                        ],
                      ),
                    ),

              ]),
            ),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Container(
                height: 40,
                width:  240,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => {
                      Navigator.pop(context)
                    },
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }

  /// 팝업 형태로 표시
  static popup(context, {required Widget child, double width = 300, required double height,  double padding = 10,
    bool bBackgroundTapPop = true, Color color = Colors.white, double round = 15.0}) async {

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(round))),
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



  // /// AI 성분 분석
  // /// 분석 중일때 나오는 다이얼 로그
  // static showAIDialog(String title, String text, BuildContext mainContext, bool isCancelBtn) {
  //   return showDialog(
  //       context: mainContext,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return WillPopScope(
  //           onWillPop: () async {
  //             // 뒤로가기 버튼을 이용한 닫힘을 방지
  //             return false;
  //           },
  //           child: AlertDialog(
  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //             title: Center(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   SizedBox(height: 10),
  //                   Text(title, textScaleFactor: 0.95, style: TextStyle(fontWeight: FontWeight.bold)),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 25),
  //                     child: SpinKitFadingFour(
  //                         color: mainColor,
  //                         size: 70
  //                     ),
  //                   ),
  //                   Text(
  //                       '${Authorization().name}님 데이터 분석중입니다.',
  //                       textScaleFactor: 0.85,
  //                       style: TextStyle(fontWeight: FontWeight.bold, color: mainColor)
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             content: SizedBox(
  //               height: 100,
  //               child: Column(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
  //                     child: SizedBox(
  //                       height: 60,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Container(
  //                               width: 230,
  //                               child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.w500))),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             contentPadding: EdgeInsets.all(0),
  //             actionsAlignment: MainAxisAlignment.end,
  //             actionsPadding: EdgeInsets.all(0),
  //           ),
  //         );
  //       });
  // }

  // static showStartEndDialog(BuildContext mainContext, {required Function onPositive}) {
  //   late String searchStartDate;
  //   late String searchEndDate;
  //
  //   return showDialog(
  //       context: mainContext,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //           content: Container(
  //             width: 100,
  //             height: 300,
  //             decoration: const BoxDecoration(
  //                 borderRadius: BorderRadius.all(Radius.circular(18)),
  //                 color: Colors.white),
  //             child: SfDateRangePicker(
  //               minDate: DateTime(2000),
  //               maxDate: DateTime.now().add(Duration(hours: 1)),
  //               onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
  //                 if (args.value is PickerDateRange) {
  //                   searchStartDate = args.value.startDate.toString().substring(0, 10).replaceAll('-','');
  //                   searchEndDate = args.value.endDate != null ? args.value.endDate.toString().substring(0, 10).replaceAll('-','') : searchStartDate;
  //                 }
  //               },
  //               selectionMode: DateRangePickerSelectionMode.range,
  //               monthCellStyle: const DateRangePickerMonthCellStyle(
  //                 textStyle: TextStyle(color: Colors.black),
  //                 todayTextStyle: TextStyle(color: Colors.black),
  //               ),
  //               startRangeSelectionColor: Colors.blueAccent,
  //               endRangeSelectionColor: Colors.blueAccent,
  //               rangeSelectionColor: Colors.blueAccent,
  //               selectionTextStyle: const TextStyle(color: Colors.white),
  //               todayHighlightColor: Colors.black,
  //               selectionColor: Colors.deepPurple,
  //               // backgroundColor: Colors.deepPurple,
  //               allowViewNavigation: false,
  //               view: DateRangePickerView.month,
  //               headerHeight: 30,
  //               headerStyle: const DateRangePickerHeaderStyle(
  //                   textAlign: TextAlign.center,
  //                   textStyle: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black,
  //                       fontSize: 18)),
  //               monthViewSettings:
  //               const DateRangePickerMonthViewSettings(
  //                 enableSwipeSelection: false,
  //               ),
  //             ),
  //           ),
  //           contentPadding: EdgeInsets.fromLTRB(20, 30, 30, 10),
  //           actionsAlignment: MainAxisAlignment.center,
  //           actions: <Widget>[
  //             Container(
  //               height: 40,
  //               width:  140,
  //               margin: EdgeInsets.only(bottom: 10),
  //               child: TextButton(
  //                   style: TextButton.styleFrom(
  //                       elevation: 5.0,
  //                       backgroundColor: Colors.white,
  //                       shape: RoundedRectangleBorder(
  //                           side: BorderSide(width: 1.0, color: Colors.white),
  //                           borderRadius: BorderRadius.circular(5.0))),
  //                   onPressed: () => {
  //                     Navigator.pop(context)
  //                   },
  //                   child: Text('취소', textScaleFactor: 1.0, style: TextStyle(color: mainColor))
  //               ),
  //             ),
  //             Container(
  //               height: 40,
  //               width:  140,
  //               margin: EdgeInsets.only(bottom: 10),
  //               child: TextButton(
  //                   style: TextButton.styleFrom(
  //                       elevation: 5.0,
  //                       backgroundColor: mainColor,
  //                       shape: RoundedRectangleBorder(
  //                           side: BorderSide(width: 1.0, color: mainColor),
  //                           borderRadius: BorderRadius.circular(5.0))),
  //                   onPressed: () => onPositive(searchStartDate, searchEndDate),
  //                   child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
  //               ),
  //             ),
  //
  //           ],
  //         );
  //       });
  // }

  // static showCalenderDialog(BuildContext mainContext, {required Function onPositive}) {
  //   late DateTime searchDate;
  //
  //   return showDialog(
  //       context: mainContext,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //           content: Container(
  //             width: 100,
  //             height: 300,
  //             decoration: const BoxDecoration(
  //                 borderRadius: BorderRadius.all(Radius.circular(18)),
  //                 color: Colors.white),
  //             child: SfDateRangePicker(
  //               minDate: DateTime(2000),
  //               maxDate: DateTime.now().add(Duration(hours: 1)),
  //               onSelectionChanged: (DateRangePickerSelectionChangedArgs date)
  //               {
  //                String substringDate = date.value.toString().substring(0, 10).replaceAll('-','');
  //
  //                 int year     = int.parse(substringDate.substring(0, 4));
  //                 int month    = int.parse(substringDate.substring(4, 6));
  //                 int day      = int.parse(substringDate.substring(6, 8));
  //                 searchDate = DateTime(year, month, day);
  //               },
  //               selectionMode: DateRangePickerSelectionMode.single,
  //               monthCellStyle: const DateRangePickerMonthCellStyle(
  //                 textStyle: TextStyle(color: Colors.black),
  //                 todayTextStyle: TextStyle(color: Colors.black),
  //               ),
  //               selectionTextStyle: const TextStyle(color: Colors.white),
  //               todayHighlightColor: Colors.redAccent,
  //               selectionColor: mainColor,
  //               // backgroundColor: Colors.deepPurple,
  //               allowViewNavigation: false,
  //               view: DateRangePickerView.month,
  //               headerHeight: 30,
  //               headerStyle: const DateRangePickerHeaderStyle(
  //                   textAlign: TextAlign.center,
  //                   textStyle: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black,
  //                       fontSize: 18)),
  //               monthViewSettings:
  //               const DateRangePickerMonthViewSettings(
  //                 enableSwipeSelection: false,
  //               ),
  //             ),
  //           ),
  //           contentPadding: EdgeInsets.fromLTRB(20, 30, 30, 10),
  //           actionsAlignment: MainAxisAlignment.center,
  //           actions: <Widget>[
  //             Container(
  //               height: 40,
  //               width:  140,
  //               margin: EdgeInsets.only(bottom: 10),
  //               child: TextButton(
  //                   style: TextButton.styleFrom(
  //                       elevation: 1.0,
  //                       backgroundColor: Colors.white,
  //                       shape: RoundedRectangleBorder(
  //                           side: BorderSide(width: 1.0, color: Colors.white),
  //                           borderRadius: BorderRadius.circular(5.0))),
  //                   onPressed: () => {
  //                     Navigator.pop(context)
  //                   },
  //                   child: Text('취소', textScaleFactor: 1.0, style: TextStyle(color: mainColor))
  //               ),
  //             ),
  //             Container(
  //               height: 40,
  //               width:  140,
  //               margin: EdgeInsets.only(bottom: 10),
  //               child: TextButton(
  //                   style: TextButton.styleFrom(
  //                       backgroundColor: mainColor,
  //                       shape: RoundedRectangleBorder(
  //                           side: BorderSide(width: 1.0, color: mainColor),
  //                           borderRadius: BorderRadius.circular(5.0))),
  //                   onPressed: () => onPositive(searchDate),
  //                   child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
  //               ),
  //             ),
  //
  //           ],
  //         );
  //       });
  // }
}



// actions: [
//   Visibility(
//     visible: isCancelBtn,
//     child: Container(
//       width: 120,
//       height: 40,
//       margin: EdgeInsets.only(bottom: 10),
//       child: TextButton(
//           style: TextButton.styleFrom(
//               elevation: 3.0,
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                  // side: BorderSide(width: 1.0, color: Colors.grey.shade100),
//                   borderRadius: BorderRadius.circular(15.0))),
//           onPressed: ()
//           {
//             Navigator.pop(context);
//           },
//           child: Text('취소', textScaleFactor: 1.0, style: TextStyle(color: Colors.grey.shade600))
//       ),
//     ),
//   ),
//
//   Expanded(
//     child: Container(
//       height: 40,
//       width: isCancelBtn ? 120 : double.infinity,
//       child: TextButton(
//           style: TextButton.styleFrom(
//               elevation: 5.0,
//               backgroundColor: mainColor,
//               shape: RoundedRectangleBorder(
//                   side: BorderSide(width: 1.0, color: mainColor),
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(15),
//                       bottomRight: Radius.circular(15),
//                   )
//               )),
//           onPressed: ()
//           {
//             Navigator.pop(context);
//           },
//           child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
//       ),
//     ),
//   ),
// ],