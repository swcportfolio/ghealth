import 'dart:ffi';

import 'package:ghealth_app/data/models/status.dart';
import 'package:ghealth_app/data/models/user.dart';

class LoginResponse {
  final Status status;
  final dynamic data;

  LoginResponse({required this.status, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: Status.fromJson(json['status']),
      data: json['data'] == ''|| json['data'].toString().contains('전화번호') || json['data'].toString().contains('인증번호')
          ? json['data'].toString()
          : UserData.fromJson(json['data']),
    );
  }
}