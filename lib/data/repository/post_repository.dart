///데이터 저장소라는 뜻으로 DataLayer인 DataSource에 접근
///
import '../datasource/local_data_source.dart';
import '../datasource/remote_data_source.dart';

/// PostRepository (post_repository.dart)
class PostRepository {
late final RemoteDataSource _remoteDataSource;
late final LocalDataSource _localDataSource;

/// 로컬에 캐싱된 게시물 목록가져옴
// Future<List<Post>> getCachedPosts() {
// return _localDataSource.getCachedPosts();
// }

/// 게시물 목록을 가져옴
// Future<List<Post>> getPosts() {
// return _remoteDataSource.getPosts();
// }
}