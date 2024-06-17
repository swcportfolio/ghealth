
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/data/models/reservation_default_response.dart';
import 'package:ghealth_app/data/repository/post_repository.dart';
import 'package:ghealth_app/view/home/home_frame_view.dart';
import 'package:ghealth_app/view/login/login_view.dart';
import 'package:ghealth_app/view/setting/v_terms_full.dart';
import 'package:ghealth_app/view/setting/version_view.dart';
import 'package:ghealth_app/widgets/custom_appbar.dart';
import 'package:ghealth_app/widgets/dialog.dart';
import 'package:ghealth_app/widgets/frame.dart';

import '../../common/util/nav.dart';
import '../../data/enum/snackbar_status_type.dart';
import '../../layers/presentation/tab/setting/opensource/v_opensource.dart';
import '../../main.dart';
import '../../utils/snackbar_utils.dart';

/// 설정 화면
class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final String title = '설정';

  @override
  Widget build(BuildContext context) {

    /// AccessToken 확인
    Authorization().checkAuthToken().then((result) {
      if(!result){
        SnackBarUtils.showBGWhiteSnackBar(
            '권한 만료, 재 로그인 필요합니다.', context);
        Frame.doPagePush(context, const LoginView());
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: '설정', isIconBtn: false),

      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children:
            [
              _buildMenu('버전 정보'),
              _buildMenu('이용 약관 및 정책'),
              _buildMenu('오픈소스 라이선스'),
              _buildMenu('로그 아웃'),
            ],
          ),
        ),
      ),
    );
  }

  /// Menu item widget
  _buildMenu(String text) {
    return InkWell(
      onTap: () {
        switch(text){
          case '로그 아웃': {
              CustomDialog.showSettingDialog(
                  title: '로그아웃',
                  text: '\n로그아웃 하시겠습니까?',
                  mainContext: context,
                  onPressed: () => handleLogout());
              break;
            }
          case '버전 정보': {
              Frame.doPagePush(context, const VersionView());
              break;
            }
          case '이용 약관 및 정책': {
            Nav.doPush(context, TermsFullView());
            break;
          }
          case '오픈소스 라이선스': {
            Nav.doPush(context, const OpensourceView());
            break;
          }
        }
      },
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Text(text, textScaleFactor: 1.0),
                  const Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  handleLogout() async {
    try{
      DefaultResponse response = await PostRepository().logoutDio();

      if(response.status.code == '200'){
        Authorization().clean();
        Authorization().clearSetStringData();
        SnackBarUtils.showStatusSnackBar(
            message: '로그아웃 되었습니다.',
            context: context,
            statusType: SnackBarStatusType.success
        );
        Frame.doPageAndRemoveUntil(context, const HomeFrameView());
      }
      else {
        SnackBarUtils.showDefaultSnackBar('서버가 불안정합니다. 다시 시도 바랍니다.', context);
        logger.e('=> 로그아웃 실패:${response.status.code}/  ${response.status.message}');
      }
    } on DioException catch(dioError) {
      SnackBarUtils.showDefaultSnackBar('서버가 불안정합니다. 다시 시도 바랍니다.', context);
      logger.e('=> 로그아웃 실패:${dioError.message}');
    }
  }
}
