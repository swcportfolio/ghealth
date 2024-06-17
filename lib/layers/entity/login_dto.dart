import 'package:ghealth_app/layers/entity/status_dto.dart';

class LoginDTO {
  final StatusDTO status;
  final dynamic data;

  LoginDTO({
    required this.status,
    this.data,
  });

  factory LoginDTO.fromJson(Map<String, dynamic> json) {
    return LoginDTO(
        status: StatusDTO.fromJson(json['status']),
        data: json['data'] == ''|| json['data'].toString().contains('전화번호') || json['data'].toString().contains('인증번호')
            ? json['data'].toString()
            : LoginDataDTO.fromJson(json['data']),
    );
  }
}

/// LoginDTO의 data object
class LoginDataDTO {
  final String userID;
  final String userName;
  final String token;
  final String gender;
  final String userIDOfD; // 동구 아이디
  final String userIDOfG; // 광산구 아이디

  LoginDataDTO({
    required this.userID,
    required this.userName,
    required this.token,
    required this.gender,
    required this.userIDOfD,
    required this.userIDOfG,
  });

  factory LoginDataDTO.fromJson(Map<String, dynamic> json) {
    return LoginDataDTO(
      userID: json['userID'],
      userName: json['userName'],
      token: json['token'],
      gender: json['gender'],
      userIDOfD: json['userIDOfD'] ?? '',
      userIDOfG: json['userIDOfG'] ?? '',
    );
  }
}

