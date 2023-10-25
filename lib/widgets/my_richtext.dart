
import 'package:flutter/material.dart';

class MyRichText {
  static Widget infoResultRichTxt(BuildContext context) {
    return RichText(
        textScaleFactor: 1.3,
        text: const TextSpan(
            children: [
              TextSpan(text: '지난검진에서 ', style: TextStyle(color: Colors.black)),
              TextSpan(text: '고혈암/당뇨에위험 진단', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
              TextSpan(text: '을 받으셨어요!', style: TextStyle(color: Colors.black)),
            ])
    );
  }
}