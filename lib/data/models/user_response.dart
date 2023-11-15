import 'package:ghealth_app/data/models/status.dart';
import 'package:ghealth_app/data/models/user.dart';

class LoginResponse {
  final Status status;
  final UserData data;

  LoginResponse({required this.status, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: Status.fromJson(json['status']),
      data: UserData.fromJson(json['data']),
    );
  }
}