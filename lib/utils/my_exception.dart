

import 'package:dio/dio.dart';

class MyException {
  static myDioException (DioExceptionType type){
    switch(type) {
      case DioExceptionType.connectionTimeout: // 네트워크 연결 상태 확인 요망 화면
      case DioExceptionType.sendTimeout:       // 네트워크 연결 상태 확인 요망 화면
      case DioExceptionType.receiveTimeout:    // 네트워크 연결 상태 확인 요망 화면
      case DioExceptionType.cancel:            // 네트워크 연결 상태 확인 요망 화면
      case DioExceptionType.connectionError:   // 네트워크 연결 상태 확인 요망 화면
        throw Exception('networkError');
      case DioExceptionType.badResponse: // 200이외의 코드 발생 잘못된 요청 화면
        throw Exception('badResponse');
      case DioExceptionType.unknown:        // 서바 상태가 불안정합니다. 다시 시도바랍니다.
      case DioExceptionType.badCertificate: // 서바 상태가 불안정합니다. 다시 시도바랍니다.
        throw Exception('unknown');
    }
  }
}