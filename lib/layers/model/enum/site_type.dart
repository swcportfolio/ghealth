import 'package:flutter/material.dart';

enum SiteType {
  gwangsangu('광산구',
    'gslifelog.ghealth.or.kr',
    'images/gwangsangu.png',
    Color(0xff5c80fb),
    Color(0xff496acc),
  ),
  donggu('동구',
    'lifelog.ghealth.or.kr',
    'images/donggu.png',
    Color(0xff64d683),
    Color(0xff56b870),
  ); // 광산구// 동구

  const SiteType(
      this.name, this.host, this.imagePath, this.bgColor, this.subColor);

  final String name;
  final String host;
  final String imagePath;
  final Color bgColor;
  final Color subColor;
}