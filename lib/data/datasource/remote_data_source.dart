
import 'package:dio/dio.dart';
import 'package:ghealth_app/data/models/authorization.dart';
import 'package:ghealth_app/data/models/health_instrumentation_response.dart';
import 'package:ghealth_app/data/models/medication_detail_response.dart';
import 'package:ghealth_app/data/models/send_message_response.dart';
import 'package:ghealth_app/data/models/summary_response.dart';
import 'package:ghealth_app/data/models/user_response.dart';
import 'package:intl/intl.dart';

import '../../utils/custom_log_interceptor.dart';
import '../models/health_report_response.dart';
import '../models/mediacation_info_response.dart';
import '../models/reservation_dayoff_response.dart';
import '../models/reservation_default_response.dart';
import '../models/reservation_history_response.dart';
import '../models/reservation_possible_response.dart';
import '../models/reservation_recent_response.dart';
import '../repository/api_constants.dart';

/// 데이터를 가져오는 영역
class RemoteDataSource {

  Dio _createPublicDio() {
    Dio dio = Dio();
    dio.interceptors.add(CustomLogInterceptor());
    dio.options.connectTimeout =  const Duration(seconds: 7);
    dio.options.receiveTimeout =  const Duration(seconds: 7);

    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    return dio;
  }

  Dio _createPrivateDio() {
    Dio dio = Dio();
    dio.interceptors.add(CustomLogInterceptor());
    dio.options.connectTimeout =  const Duration(seconds: 7);
    dio.options.receiveTimeout =  const Duration(seconds: 7);

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'GHEALTH  ${Authorization().token}'
    };
    return dio;
  }

  /// Authorization 토큰 유효성 체크
  Future<DefaultResponse> checkAuthDio() async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(checkAuthApiUrl);

      // API 응답을 모델로 변환
      // 임시로 ReservationDefaultResponse 객체 사용
      DefaultResponse defaultResponse = DefaultResponse.fromJson(response.data);

      return defaultResponse;
    } on DioException {
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
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
    } on DioException {
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
    } on DioException {
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }


  /// 내 건강정보 보고서
  Future<SummaryResponse> getHealthSummaryDio(String? selectedDateTime) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(healthSummaryApiUrl,
          queryParameters: {'issuedDate': selectedDateTime});

      //logger.f(response.data);
      // API 응답을 모델로 변환
      SummaryResponse summaryResponse = SummaryResponse.fromJson(response.data);

      return summaryResponse;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 계측 검사 이력조회
  Future<HealthInstrumentationResponse> getHealthInstrumentationDio(String dataType) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(healthInstrumentationApiUrl,
          queryParameters: {'dataType': dataType});

      // API 응답을 모델로 변환
      HealthInstrumentationResponse healthInstrumentationResponse
                    = HealthInstrumentationResponse.fromJson(response.data);

      return healthInstrumentationResponse;
    } on DioException {
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }
  /// 계측 검사 이력조회
  Future<HealthInstrumentationResponse> getHealthBloodDio(String dataType) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(healthBloodApiUrl,
          queryParameters: {'dataType': dataType});

      // API 응답을 모델로 변환
      HealthInstrumentationResponse healthInstrumentationResponse
                    = HealthInstrumentationResponse.fromJson(response.data);

      return healthInstrumentationResponse;
    } on DioException {
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 계측 검사 이력조회
  Future<MedicationInfoResponse> getMedicationInfoDataDio(int pageIdx) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(healthMedicationInfoApiUrl,
          queryParameters: {'page': pageIdx});

      // API 응답을 모델로 변환
      MedicationInfoResponse medicationInfoResponse
                = MedicationInfoResponse.fromJson(response.data);

      return medicationInfoResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 라이프로그 건강검진 결과 조회
  Future<HealthReportResponse> getHealthReportLifeLogDio(String deviceID) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(healthLifeLogApiUrl,
          queryParameters: {'deviceID': deviceID});

      // API 응답을 모델로 변환
      HealthReportResponse healthReportResponse
                = HealthReportResponse.fromJson(response.data);

      return healthReportResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 내 최신 예약현황 조회
  Future<ReservationRecentResponse> getRecentReservationDio() async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(recentReservationApiUrl,
          queryParameters: {'serviceType': 'lifelog'});

      // API 응답을 모델로 변환
      ReservationRecentResponse reservationRecentResponse
                = ReservationRecentResponse.fromJson(response.data);

      return reservationRecentResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      rethrow;
    }
  }


  /// 방문예약 히스트로 조회
  Future<ReservationHistoryResponse> getHistoryReservationDio(int pageIdx) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(historyReservationApiUrl,
          queryParameters: {'page': pageIdx, 'serviceType': 'lifelog'});

      // API 응답을 모델로 변환
      ReservationHistoryResponse reservationHistoryResponse
                            = ReservationHistoryResponse.fromJson(response.data);

      return reservationHistoryResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 방문예약 휴일 날짜 조회
  Future<ReservationDayOffResponse> getDayOffReservationDio(DateTime date) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(dayOffReservationApiUrl,
          queryParameters: {'serviceType': 'lifelog', 'year': date.year, 'month': date.month});

      // API 응답을 모델로 변환
      ReservationDayOffResponse reservationDayOffResponse
                            = ReservationDayOffResponse.fromJson(response.data);

      return reservationDayOffResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 예약가능한 시간 조회
  Future<ReservationPossibleResponse> getPossibleReservationDio(DateTime date) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(possibleReservationApiUrl,
          queryParameters: {'serviceType': 'lifelog', 'reservationDate': DateFormat('yyyy-MM-dd').format(date)});

      // API 응답을 모델로 변환
      ReservationPossibleResponse reservationPossibleResponse
                          = ReservationPossibleResponse.fromJson(response.data);

      return reservationPossibleResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 예약 저장
  Future<DefaultResponse> saveReservationDio(Map<String, dynamic> data) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().post(saveReservationApiUrl, data: data);

      // API 응답을 모델로 변환
      DefaultResponse defaultResponse = DefaultResponse.fromJson(response.data);

      return defaultResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 예약 취소
  Future<DefaultResponse> cancelReservationDio(Map<String, dynamic> data) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().delete(cancelReservationApiUrl, data: data);

      // API 응답을 모델로 변환
      DefaultResponse defaultResponse
                        = DefaultResponse.fromJson(response.data);

      return defaultResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 예약 취소
  Future<DefaultResponse> logoutDio() async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().post(logoutApiUrl);

      // API 응답을 모델로 변환
      DefaultResponse defaultResponse
                = DefaultResponse.fromJson(response.data);

      return defaultResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }

  /// 헬스 건강 데이터 저장
  Future<DefaultResponse> saveHealthDataDio(String dataType, Map<String, dynamic> data) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio()
          .post('$saveHealthDataApiUrl$dataType', data: data);

      // API 응답을 모델로 변환
      DefaultResponse defaultResponse
            = DefaultResponse.fromJson(response.data);

      return defaultResponse;
    } on DioException catch (dioError){
      rethrow;
    } catch (error) {
      // 에러 처리
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리하도록 함
    }
  }


  /// 투약정보 상세데이터 가져오기
  Future<MedicationDetailResponse> getMedicationDetailDio(String medicationCode) async {
    try {
      // Dio를 사용하여 API 호출
      Response response = await _createPrivateDio().get(getMedicationDetailApiUrl,
          queryParameters: {'medicationCode': medicationCode});

      // API 응답을 모델로 변환
      MedicationDetailResponse medicationDetailResponse
      = MedicationDetailResponse.fromJson(response.data);

      return medicationDetailResponse;
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

