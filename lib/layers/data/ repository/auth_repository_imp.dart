
import 'package:ghealth_app/layers/entity/check_token_dto.dart';
import 'package:ghealth_app/layers/entity/logout_dto.dart';
import 'package:ghealth_app/layers/entity/send_auth_dto.dart';

import '../../../common/common.dart';
import '../../../common/util/dio/dio_manager.dart';
import '../../../main.dart';
import '../../domain/repository/auth_repository.dart';
import '../../entity/login_dto.dart';

class AuthRepositoryImp implements AuthRepository {

  /// 로그인
  @override
  Future<LoginDTO?> login(Map<String, dynamic> toMap) async {
    try {
      final response = await DioManager()
              .publicDio
              .post(loginApiUrl, data: toMap);
      if (response.statusCode == 200) {
        return  LoginDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 로그아웃
  @override
  Future<LogoutDTO?> logout() async {
    try {
      final response = await DioManager()
          .privateDio
          .post(logoutApiUrl);

      logger.i(response);
      if (response.statusCode == 200) {
        return LogoutDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }


  /// 인증번호 발송
  @override
  Future<SendAuthDTO?> sendAuth(Map<String, dynamic> toMap) async {
    try {
      final response = await DioManager()
          .publicDio
          .post(sendAuthApiUrl, data: toMap);

      logger.i(response);
      if (response.statusCode == 200) {
        return SendAuthDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 토큰 유효성 체크
  @override
  Future<CheckTokenDTO?> checkToken()  async {
    try {
      final response = await DioManager()
          .privateDio
          .get(checkTokenApiUrl);

      logger.i(response);
      if (response.statusCode == 200) {
        return CheckTokenDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }
}
