import 'package:flutter/material.dart';
import 'package:ghealth_app/view/point/point_management_view.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../view/setting/my_info_view.dart';

/// 커스텀된 AppBar를 나타내는 위젯 클래스.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30.0)
        ),
        // 원하는 둥근 모서리 반지름 설정
        child: Frame.myAppbar(
          title,
          isIconBtn: true,
          onPressed: ()=> Frame.doPagePush(context, const MyInfoView()),
          iconData: Icons.account_circle_outlined,
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
