/// 권한 계정 클래스
class Authorization{
  late String uid;


  /// 한번 초기화로 계속 사용할 수 있다.
  static final Authorization _authInstance = Authorization.internal();

  factory Authorization(){
    return _authInstance;
  }

  Authorization.internal() {
    uid = '';
  }

  clear() async {
    uid = '';
  }
}