import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import '../utlis/colors.dart';


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
        fontSize: 1.0,
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
                icon: Icon(iconData, size: 30)
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
    Color color = Colors.black,
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
       decorationColor: Colors.grey,
       decorationStyle: TextDecorationStyle.solid,
       /// 밑줄의 형태, underline(아래), overline(위),  lineThrough(중간),
       decoration: TextDecoration.lineThrough,
       /// 밑줄의 두께
       decorationThickness: 3,
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


 /// Empty View
 static buildEmptyView(String text) {
   return Center(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.center,
       children:
       [
         const SizedBox(height: 20),
         Frame.myText(text: text, fontSize: 1.2, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
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
         const SizedBox(width: 7),
         Frame.myText(
             text: text,
             maxLinesCount: 2,
            fontSize: 1.1
         )
       ],
     ),
   );
 }

 static buildFutureBuilderHasError(VoidCallback updateFunction){
     return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Frame.myText(
             text: '네트워크 및 서버가 불안정합니다.',
             fontSize: 1.1,
           ),
           const SizedBox(height: 20),

           InkWell(
             onTap: () => {
               updateFunction()
             },
             child: Container(
               padding: const EdgeInsets.all(8),
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

  /// 데이터 로딩
  static buildFutureBuildProgressIndicator() {
    return Platform.isAndroid
        ? const Center(
            child: SizedBox(
                height: 40.0,
                width: 40.0,
                child: CircularProgressIndicator(strokeWidth: 2)))
        : const Center(
          child: SizedBox(
              height: 40.0,
              width: 40.0,
              child: CupertinoActivityIndicator(radius: 15)),
        );
  }

  static buildExtendedImage(AnimationController controller, String  url, double size){
   return ExtendedImage.network(
     url,
     width: size,
     height: size,
     fit: BoxFit.fill,
     cache: true,
     shape: BoxShape.circle,
     borderRadius: const BorderRadius.all(Radius.circular(30.0)),
     loadStateChanged: (ExtendedImageState state) {
       switch (state.extendedImageLoadState) {
         case LoadState.loading:
           return buildFutureBuildProgressIndicator();
         case LoadState.completed:
           return ExtendedRawImage(
             image: state.extendedImageInfo?.image,
             width: 50,
             height: 50,
           );
         case LoadState.failed:
           return GestureDetector(
             child: Image.asset(
               'images/profile_image.png',
               fit: BoxFit.fill,
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