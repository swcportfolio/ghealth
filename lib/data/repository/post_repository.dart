///데이터 저장소라는 뜻으로 DataLayer인 DataSource에 접근
///

import '../datasource/local_data_source.dart';
import '../datasource/remote_data_source.dart';

import '../models/health_instrumentation_response.dart';
import '../models/send_message_response.dart';
import '../models/summary_response.dart';
import '../models/user_response.dart';

/// PostRepository (post_repository.dart)
class PostRepository {
late final RemoteDataSource _remoteDataSource = RemoteDataSource();
late final LocalDataSource _localDataSource;

Future<SendMessageResponse> sendAuthMessageDio(Map<String, dynamic> data){
  return _remoteDataSource.sendAuthMessageDio(data);
}

Future<LoginResponse> loginDio(Map<String, dynamic> data){
  return _remoteDataSource.loginDio(data);
}

Future<SummaryResponse> getHealthSummaryDio(){
  return _remoteDataSource.getHealthSummaryDio();
}

Future<HealthInstrumentationResponse> getHealthInstrumentationDio(String dataType){
  return _remoteDataSource.getHealthInstrumentationDio(dataType);
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