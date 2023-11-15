
import 'package:dio/dio.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/data/models/health_instrumentation_response.dart';
import 'package:ghealth_app/data/models/send_message_response.dart';
import 'package:ghealth_app/data/models/summary_response.dart';
import 'package:ghealth_app/data/models/user_response.dart';

import '../../main.dart';
import '../../utils/custom_log_interceptor.dart';
import '../repository/api_constants.dart';

/// 데이터를 가져오는 영역
class RemoteDataSource {

  Dio _createPublicDio() {
    Dio dio = Dio();
    dio.interceptors.add(CustomLogInterceptor());
    dio.options.connectTimeout =  const Duration(seconds: 6);
    dio.options.receiveTimeout =  const Duration(seconds: 6);

    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    return dio;
  }

  Dio _createPrivateDio() {
    Dio dio = Dio();
    dio.interceptors.add(CustomLogInterceptor());
    dio.options.connectTimeout =  const Duration(seconds: 6);
    dio.options.receiveTimeout =  const Duration(seconds: 6);

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'GHEALTH  ${Authorization().token}'
    };
    return dio;
  }

  /// 휴대폰 인증번호 전송
  Future<SendMessageResponse> sendAuthMessageDio(Map<String, dynamic> data) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPublicDio()
          .post(sendAuthMessageApiUrl, data: data);

      // API 응답을 모델로 변환
      SendMessageResponse sendMessageResponse = SendMessageResponse.fromJson(response.data);

      return sendMessageResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 로그인
  Future<LoginResponse> loginDio(Map<String, dynamic> data) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPublicDio()
          .post(loginApiUrl, data: data);

      // API 응답을 모델로 변환
      LoginResponse loginResponse = LoginResponse.fromJson(response.data);

      return loginResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }


  /// 내 건강정보 보고서
  Future<SummaryResponse> getHealthSummaryDio() async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(healthSummaryApiUrl);

      //logger.f(response.data);
      // API 응답을 모델로 변환
      SummaryResponse summaryResponse = SummaryResponse.fromJson(response.data);

      return summaryResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 이력조회
  Future<HealthInstrumentationResponse> getHealthInstrumentationDio(String dataType) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(healthInstrumentationApiUrl,
          queryParameters: {'dataType': dataType});

      // API 응답을 모델로 변환
      HealthInstrumentationResponse healthInstrumentationResponse
                    = HealthInstrumentationResponse.fromJson(response.data);

      return healthInstrumentationResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }


  // final _firebaseInstance = FirebaseFirestore.instance;

  // /// 앱 광고 알람 수신 업데이트
  // Future<void> updateAlarmAdvertisement(bool isAdvertisement) async {
  //   try {
  //     await _firebaseInstance
  //         .collection('users')
  //         .doc('${Authorization().uid}')
  //         .update({
  //           'isAdvertisement': isAdvertisement,
  //         }).timeout(Duration(seconds: 4));
  //
  //     mLog.i('Users AlarmAdvertisement updated!');
  //   } catch (error) {
  //     mLog.e("Failed to update users AlarmAdvertisement: $error");
  //     throw Exception(error);
  //   }
}

// Future<List<Post>> getPosts() async {
// const path = '/api/posts';
// const params = <String, String>{};
// const uri = Uri.https("flutter_sample.com", path, params);
// final res = await http.get(uri);
// if (res.statusCode == HttpStatus.ok) {
//   final data = _bytesToJson(res.bodyBytes) as List;
//   return data.map((el) => Post.fromMap(el as Map)).toList();
// } else {
//   throw Exception("Error on server");
// }
//}

// Stream<List<Todo>> getTodoListStream() {
//   return _firestore.collection('todos').snapshots().map((snapshot) {
//     return snapshot.docs.map((doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       return Todo(
//         id: doc.id,
//         title: data['title'],
//         isDone: data['isDone'],
//       );
//     }).toList();
//   });
// }

