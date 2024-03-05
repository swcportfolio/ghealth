import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import '../main.dart';
import '../utils/colors.dart';


class Frame{

  /// 앱바 위젯
 static AppBar myAppbar(String title, {bool isIconBtn = false, IconData? iconData = Icons.settings_rounded , Function? onPressed}){
    return AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //     statusBarBrightness: Brightness.light,
      //     statusBarIconBrightness: Brightness.dark,
      //     statusBarColor: Colors.white
      // ),
      title: Frame.myText(
        text: title,
        fontSize: 0.9,
        fontWeight: FontWeight.w600,
        color: Colors.white
      ),
      centerTitle: true,
      backgroundColor: mainColor,
      elevation: 0.5,
      iconTheme: const IconThemeData(color: Colors.white),
      actions:
      [
        /// 채팅화면 우측 상단 아이콘 버튼
        Visibility(
          visible: isIconBtn,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () => onPressed!(),
                icon: Icon(iconData, size: 25)
            ),
          ),
        ),
      ],
    );
  }

  /// 커스텀 텍스트
  static Text myText({
    required String text,
    double fontSize = 1.0,
    Color color = defaultBlack,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign align = TextAlign.start,
    TextOverflow overflow = TextOverflow.visible,
    int maxLinesCount = 1,
    bool softWrap = false,
  }){
   return Text(
     text,
     textScaleFactor: fontSize,
     overflow: overflow,
     maxLines: maxLinesCount,
     softWrap: softWrap,
     style: TextStyle(
         color: color,
         fontWeight: fontWeight,
        fontFamily: 'pretendard'
     ),
     textAlign: align
     ,
   );
  }

 /// 밑줄 커스텀 텍스트
 static Text mySolidText({
   required String text,
   double fontSize = 1.0,
   Color color = Colors.grey,
   FontWeight fontWeight = FontWeight.normal,
   TextAlign align = TextAlign.start,
   TextOverflow overflow = TextOverflow.visible,
   TextDecoration decoration = TextDecoration.lineThrough,
   Color decorationColor = Colors.black,
   double decorationThickness = 0,
   int maxLinesCount = 1,
   bool softWrap = false,
 }){
   return Text(
     text,
     textScaleFactor: fontSize,
     overflow: overflow,
     maxLines: maxLinesCount,
     softWrap: softWrap,
     style: TextStyle(
       color: color,
       fontWeight: fontWeight,
       decorationColor: decorationColor,
       decorationStyle: TextDecorationStyle.solid,
       /// 밑줄의 형태, underline(아래), overline(위),  lineThrough(중간),
       decoration: decoration,
       /// 밑줄의 두께
       decorationThickness: decorationThickness,
     ),
     textAlign: align
     ,
   );
 }




  /// Navigator 화면 이동
  static doPagePush(BuildContext context, Widget page)
  {
   return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }


 /// Navigator 화면 이동, 바로 이전 화면 1개는 스택에서 없앰.
 static doPagePushReplace(context, Widget page)
 {
   return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
 }


 /// Navigator 화면 이동, 이전 화면 모두 삭제후 이동
 static doPageAndRemoveUntil(context, Widget page)
 {
   return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => page), (route) => false);
 }

 /// Universal 화면이동
 static Future<void> doLaunchUniversalLink(Uri uri) async {
   LaunchMode mode;
   if(Platform.isIOS){
     mode = LaunchMode.externalNonBrowserApplication;
   } else {
     mode = LaunchMode.inAppBrowserView;
   }

   final bool nativeAppLaunchSucceeded = await launchUrl(
     uri,
     mode: mode,
   );
   if (!nativeAppLaunchSucceeded) {
     await launchUrl(uri, mode: LaunchMode.externalApplication);
   }
 }


 /// Empty View
 static buildEmptyView(String text) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(20),
          Frame.myText(
              text: text,
              fontSize: 1.2,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600),
        ],
      ),
    );
  }

  static buildTag({required String text, double textSize = 0.8}){
   return Container(
     margin: const EdgeInsets.only(right: 5),
     padding: const EdgeInsets.all(5),
     decoration: BoxDecoration(
       border: Border.all(
           color: Colors.blue,
           width: 1.5,
           style: BorderStyle.solid
       ),
       borderRadius: BorderRadius.circular(30),
     ),
     child: Center (
         child: Frame.myText(
            text: text,
            fontSize: textSize,
            fontWeight: FontWeight.bold,
            color: Colors.blue)
     )
     );
 }

 static buildOathItem(String text){
   return Padding(
     padding: const EdgeInsets.only(bottom: 5),
     child: Row(
       children: [
         Image.asset('images/check.png', width: 25, height: 25),
         const Gap(7),
         Frame.myText(
             text: text,
             maxLinesCount: 2,
            fontSize: 1.1
         )
       ],
     ),
   );
 }
 static Widget buildFutureBuilderHasError(String errorMsg, VoidCallback updateFunction){
   logger.e('=> 받은 에러메시지: $errorMsg');
   switch(errorMsg) {
     case 'Exception: networkError': // 네트워크 연결 상태 확인 요망 화면
      return showMessageErrorScreen(
          '네트워크 연결 상태 확인 후\n다시 시도해주세요.', ()=>updateFunction()
      );
     case 'Exception: badResponse': // 200이외의 코드 발생 잘못된 요청 화면
       return showMessageErrorScreen(
           '서버에서 예기치 않은 응답이 발생했습니다.\n나중에 다시 시도해주세요.', ()=>updateFunction()
       );
     case 'Exception: unknown': // 서바 상태가 불안정합니다. 다시 시도바랍니다.
     return showMessageErrorScreen(
         '서버 상태가 불안정합니다.\n나중에 다시 시도해주세요.', ()=>updateFunction()
     );
     default:
      return showMessageErrorScreen(
           '서버 상태가 불안정합니다.\n나중에 다시 시도해주세요.', ()=>updateFunction()
       );
   }
 }

 static showMessageErrorScreen(
     String message,
     VoidCallback updateFunction){
   return Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         const Icon(Icons.error_outline, size: 40, color: Colors.redAccent,),
         const Gap(10),
         Frame.myText(
             text: message,
             fontSize: 1.1,
             maxLinesCount: 2,
             align: TextAlign.center
         ),
         const Gap(25),

         InkWell(
           onTap: () =>{ updateFunction() },
           child: Container(
             padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
             decoration: BoxDecoration(
               color: Colors.grey.shade100 ,
               border: Border.all(
                   color: textFieldBorderColor,
                   width: 1.5),
               borderRadius: BorderRadius.circular(30),
             ),
             child: Frame.myText(
               text: '다시 시도',
             ),
           ),
         )
       ],
     ),
   );
 }


 static showMessageHealthErrorScreen(
     String message,
     VoidCallback updateFunction){
   return Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         const Icon(Icons.error_outline, size: 40, color: Colors.redAccent,),
         const Gap(10),
         Frame.myText(
             text: message,
             fontSize: 1.1,
             maxLinesCount: 2,
             align: TextAlign.center
         ),
         const Gap(25),

         InkWell(
           onTap: () =>{ updateFunction() },
           child: Container(
             padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
             decoration: BoxDecoration(
               color: Colors.grey.shade100 ,
               border: Border.all(
                   color: textFieldBorderColor,
                   width: 1.5),
               borderRadius: BorderRadius.circular(30),
             ),
             child: Frame.myText(
               text: '다시 시도',
             ),
           ),
         )
       ],
     ),
   );
 }

 /// Empty 공용화면
 static Widget buildCommonEmptyView(String message){
   return Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Image.asset('images/empty_search_image.png', height: 60, width: 60),
         const Gap(20),
         Container(
           padding: const EdgeInsets.all(10.0),
           decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(10.0)
           ),
           child: Frame.myText(
               text: message,
               maxLinesCount: 2,
               softWrap: true,
               fontSize: 1.1,
               fontWeight: FontWeight.w500
           ),
         )
       ],
     ),
   );
 }


  /// 데이터 로딩
  static buildFutureBuildProgressIndicator() {
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
              child: CupertinoActivityIndicator(radius: 15)),
        );
  }

 /// 인증번호 전송버튼 Indicator
 static buildSendMessageProgressIndicator() {
   return Platform.isAndroid
       ? const SizedBox(
           height: 10.0,
           width: 10.0,
           child: CircularProgressIndicator(strokeWidth: 2))
       : const SizedBox(
           height: 10,
           width: 10,
           child: CupertinoActivityIndicator(radius: 8));
 }

  static buildExtendedImage(AnimationController controller, String  url, double size){
   return ExtendedImage.network(
     url,
     fit: BoxFit.fill,
     alignment: Alignment.center,
     loadStateChanged: (ExtendedImageState state) {
       switch (state.extendedImageLoadState) {
         case LoadState.loading:
           return buildFutureBuildProgressIndicator();
         case LoadState.completed:
           return ExtendedRawImage(
             image: state.extendedImageInfo?.image,
           );
         case LoadState.failed:
           return GestureDetector(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Icon(Icons.question_mark, color: mainColor),
                 const Gap(10),
                 Frame.myText(text:'사진을 불러오지 못했습니다.')
               ],
             ),
             onTap: () {
               state.reLoadImage();
             },
           );
       }
     },
   );
  }
}