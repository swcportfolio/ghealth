import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/view/setting/setting_view.dart';
import 'package:ghealth_app/widgets/dialog.dart';
import 'package:ghealth_app/widgets/frame.dart';


/// 커스텀된 AppBar를 나타내는 위젯 클래스.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
        required this.title,
        required this.isIconBtn});

  final String title;
  final bool isIconBtn;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(30.0)),
        // 원하는 둥근 모서리 반지름 설정
        child: Frame.myAppbar(
          title,
          isIconBtn: isIconBtn,
          onPressed: () =>{
            if(Authorization().token.isEmpty){
              CustomDialog.showLoginDialog(
                title: '로그인',
                content: '인증이 필요합니다.\n 로그인화면으로 이동합니다.',
                mainContext: context
              )
            } else {
              Frame.doPagePush(context, const SettingView()),
            }
          },
          iconData: Icons.settings_sharp,
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
