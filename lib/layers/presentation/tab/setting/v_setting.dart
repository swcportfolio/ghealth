
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/common/util/snackbar_utils.dart';
import 'package:ghealth_app/layers/presentation/tab/setting/v_terms_full.dart';
import 'package:ghealth_app/layers/presentation/tab/setting/v_version.dart';
import 'package:ghealth_app/layers/presentation/widgets/frame_scaffold.dart';
import 'package:ghealth_app/layers/presentation/widgets/style_text.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_custom_dialog.dart';
import 'package:ghealth_app/view/home/home_frame_view.dart';

import '../../../../common/data/validate/auth_validation_mixin.dart';
import '../../../../main.dart';
import '../../../domain/usecase/auth_usecase.dart';
import '../../../entity/logout_dto.dart';
import '../../../model/authorization_test.dart';
import '../../../model/enum/snackbar_status_type.dart';
import 'opensource/v_opensource.dart';


/// 설정 화면
class SettingViewTest extends StatefulWidget   {
  const SettingViewTest({Key? key}) : super(key: key);

  @override
  State<SettingViewTest> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingViewTest> with AuthValidationMixin{

  String get title => '설정';

  @override
  void initState() {
    checkAuthToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: AppDim.small),
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
            Nav.doPush(context, const VersionView());
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
              color: AppColors.white,
              border: Border(bottom: BorderSide(
                  color: AppColors.grey,
                  width: 0.1,
              )),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                StyleText(
                  text: text,
                  size: AppDim.fontSizeSmall,
                ),
                const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: AppColors.grey,
                    size: AppDim.iconXSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  /// 로그아웃
  Future<void> handleLogout() async {
    try {
      LogoutDTO? response = await LogoutUseCase().execute();

      if (response != null && response.status.code == '200') {
        _performLogoutSuccess();
      } else {
        _performLogoutFailure('서버가 불안정합니다. 다시 시도 바랍니다.');
        logger.e('=> 로그아웃 실패:${response?.status.code}/  ${response?.status.message}');
      }
    } on DioException catch (dioError) {
      _performLogoutFailure('서버가 불안정합니다. 다시 시도 바랍니다.');
      logger.e('=> 로그아웃 실패:${dioError.message}');
    } catch (error) {
      _performLogoutFailure('알 수 없는 오류가 발생했습니다.');
      logger.e('=> 로그아웃 실패:$error');
    }
  }

  _performLogoutSuccess() {
    AuthorizationTest().clean();
    AuthorizationTest().clearSetStringData();
      SnackBarUtils.showStatusSnackBar(
        message: '로그아웃 되었습니다.',
        context: context,
        statusType: SnackBarStatusType.success,
      );
    Nav.doAndRemoveUntil(context, const HomeFrameView());
  }

  _performLogoutFailure(String message) {
      SnackBarUtils.showDefaultSnackBar(message, context);
  }
}
