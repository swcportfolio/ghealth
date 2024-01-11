///데이터 저장소라는 뜻으로 DataLayer인 DataSource에 접근
///

import 'package:ghealth_app/data/models/ai_health_response.dart';
import 'package:ghealth_app/data/models/medication_detail_response.dart';

import '../datasource/local_data_source.dart';
import '../datasource/remote_data_source.dart';

import '../models/ai_health_data.dart';
import '../models/health_blood_response.dart';
import '../models/health_instrumentation_response.dart';
import '../models/health_report_response.dart';
import '../models/mediacation_info_response.dart';
import '../models/medication_Info_data.dart';
import '../models/record_date_response.dart';
import '../models/reservation_dayoff_response.dart';
import '../models/reservation_default_response.dart';
import '../models/reservation_history_response.dart';
import '../models/reservation_possible_response.dart';
import '../models/reservation_recent_response.dart';
import '../models/send_message_response.dart';
import '../models/summary_response.dart';
import '../models/user_response.dart';

/// PostRepository (post_repository.dart)
class PostRepository {
late final RemoteDataSource _remoteDataSource = RemoteDataSource();
late final LocalDataSource _localDataSource;

Future<DefaultResponse> checkAuthDio(){
  return _remoteDataSource.checkAuthDio();
}

Future<SendMessageResponse> sendAuthMessageDio(Map<String, dynamic> data){
  return _remoteDataSource.sendAuthMessageDio(data);
}

Future<LoginResponse> loginDio(Map<String, dynamic> data){
  return _remoteDataSource.loginDio(data);
}

Future<SummaryResponse> getHealthSummaryDio(String? selectedDateTime){
  return _remoteDataSource.getHealthSummaryDio(selectedDateTime);
}

Future<HealthInstrumentationResponse> getHealthInstrumentationDio(String dataType){
  return _remoteDataSource.getHealthInstrumentationDio(dataType);
}

Future<HealthInstrumentationResponse> getHealthBloodDio(String dataType){
  return _remoteDataSource.getHealthBloodDio(dataType);
}

Future<MedicationInfoResponse> getMedicationInfoDataDio(int pageIdx){
  return _remoteDataSource.getMedicationInfoDataDio(pageIdx);
}

Future<HealthReportResponse> getHealthReportLifeLogDio(String deviceID, String selectedDate){
  return _remoteDataSource.getHealthReportLifeLogDio(deviceID, selectedDate);
}

Future<ReservationRecentResponse> getRecentReservationDio(){
  return _remoteDataSource.getRecentReservationDio();
}

Future<ReservationHistoryResponse> getHistoryReservationDio(int pageIndex){
  return _remoteDataSource.getHistoryReservationDio(pageIndex);
}

Future<ReservationDayOffResponse> getDayOffReservationDio(DateTime date){
  return _remoteDataSource.getDayOffReservationDio(date);
}

Future<ReservationPossibleResponse> getPossibleReservationDio(DateTime date){
  return _remoteDataSource.getPossibleReservationDio(date);
}

Future<DefaultResponse> saveReservationDio(Map<String, dynamic> data){
  return _remoteDataSource.saveReservationDio(data);
}

Future<DefaultResponse> cancelReservationDio(Map<String, dynamic> data){
  return _remoteDataSource.cancelReservationDio(data);
}

Future<DefaultResponse> logoutDio(){
  return _remoteDataSource.logoutDio();
}

Future<DefaultResponse> saveHealthDataDio(String dataType, Map<String, dynamic>data){
  return _remoteDataSource.saveHealthDataDio(dataType, data);
}

Future<MedicationDetailResponse> getMedicationDetail(String medicationCode){
  return _remoteDataSource.getMedicationDetailDio(medicationCode);
}

Future<RecordDateResponse> getRecordDateDio(){
  return _remoteDataSource.getRecordDateDio();
}

Future<AiHealthResponse> getAiHealthDataDio(){
  return _remoteDataSource.getAiHealthDataDio();
}


  /// 로컬에 캐싱된 게시물 목록가져옴
// Future<List<Post>> getCachedPosts() {
// return _localDataSource.getCachedPosts();
// }

/// 게시물 목록을 가져옴
// Future<List<Post>> getPosts() {
// return _remoteDataSource.getPosts();
// }
}