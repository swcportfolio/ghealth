
import 'package:ghealth_app/layers/entity/logout_dto.dart';

import '../../../common/di/di.dart';
import '../../entity/check_token_dto.dart';
import '../../entity/login_dto.dart';
import '../../entity/send_auth_dto.dart';
import '../repository/auth_repository.dart';
import 'base_usecase.dart';

/// 로그인 유스케이스
class LoginUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final AuthRepository _authRepository;

  LoginUseCase([AuthRepository? authRepository])
      : _authRepository = authRepository ?? locator();

  @override
  Future<LoginDTO?> execute(Map<String, dynamic> toMap) {
    return _authRepository.login(toMap);
  }
}


/// 로그아웃 유스케이스
class LogoutUseCase implements NoParamUseCase<void, void> {
  final AuthRepository _authRepository;

  LogoutUseCase([AuthRepository? authRepository])
      : _authRepository = authRepository ?? locator();

  @override
  Future<LogoutDTO?> execute() {
    return _authRepository.logout();
  }
}


/// 인증번호 발송 유스케이스
class SendAuthUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final AuthRepository _authRepository;

  SendAuthUseCase([AuthRepository? authRepository])
      :_authRepository = authRepository ?? locator();

  @override
  Future<SendAuthDTO?> execute(Map<String, dynamic> toMap) {
    return _authRepository.sendAuth(toMap);
  }
}

/// Access tocken 유효성 체크 유스케이스
class CheckTokenUseCase implements NoParamUseCase<void, void> {
  final AuthRepository _authRepository;

  CheckTokenUseCase([AuthRepository? authRepository])
      :_authRepository = authRepository ?? locator();

  @override
  Future<CheckTokenDTO?> execute() {
    return _authRepository.checkToken();
  }
}