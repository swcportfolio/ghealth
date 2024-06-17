
import '../../entity/check_token_dto.dart';
import '../../entity/login_dto.dart';
import '../../entity/logout_dto.dart';
import '../../entity/send_auth_dto.dart';

abstract class AuthRepository {
  Future<LoginDTO?> login(Map<String, dynamic> toMap);
  Future<LogoutDTO?> logout();
  Future<SendAuthDTO?> sendAuth(Map<String, dynamic> toMap);
  Future<CheckTokenDTO?> checkToken();
}