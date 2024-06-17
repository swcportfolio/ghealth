import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ghealth_app/common/util/snackbar_utils.dart';
import 'package:ghealth_app/layers/model/authorization_test.dart';

import '../../../layers/domain/usecase/auth_usecase.dart';
import '../../../layers/presentation/auth/login_view.dart';
import '../../../main.dart';
import '../../util/nav.dart'; // 필요한 패키지 임포트

mixin AuthValidationMixin<T extends StatefulWidget> on State<T> {
  /// 서버에서 발급된 access token 유효성 체크
  Future<void> checkAuthToken(BuildContext context) async {
    if(AuthorizationTest().token.isEmpty){
      return;
    }

    try{
      final response = await CheckTokenUseCase().execute();
      if(response?.status.code == '200'){
        logger.i('=> 현재 유효한 Authorization Token 입니다');
      }
      else {
        logger.e('=> 토큰 유효성 체크 response.status.code not 200');

        if(context.mounted){
          SnackBarUtils.showBGWhiteSnackBar('권한 만료, 재 로그인 필요합니다.', context);
          Nav.doAndRemoveUntil(context, const LoginViewTest());
        }
      }
    } on DioException catch (dioError){
      logger.e('=> CheckAuthorizationToken: $dioError');

      if(dioError.message.toString().contains('500')){
        if(context.mounted) {
          SnackBarUtils.showBGWhiteSnackBar('권한 만료, 재 로그인 필요합니다.', context);
          Nav.doAndRemoveUntil(context, const LoginViewTest());
        }
      }
    }
  }
}
