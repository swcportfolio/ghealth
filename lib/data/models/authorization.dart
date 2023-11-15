
/// Attributes to store user authorization information
class Authorization{
  late String userID; //ex)U00000
  late String userName; //ex)강**
  late String token; //ex)eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJV
  late String gneder; //ex)(M:남자,F:여자)

  // Authorization 클래스의 싱글톤 인스턴스
  static final Authorization _authInstance = Authorization.internal();

  // 싱글톤 패턴을 위한 비공개 생성자
  factory Authorization(){
    return _authInstance;
  }

  // 사용자 권한 값을 설정하는 메서드
  void setValues(
      {required String newUserID,
      required String newUserName,
      required String newToken,
      required String newGender,
      }) {
    userID = newUserID;
    userName = newUserName;
    token = newToken;
    gneder = newGender;
  }

  // Authorization의 단일 인스턴스를 제공하기 위한 팩토리 메서드
  Authorization.internal() {
    init();
  }
  // 권한 값을 초기화하는 메서드
  clean()=> init();

  // 권한 값을 초기화하는 메서드
  init() {
    userID = '';
    userName = '';
    token = '';
    gneder = '';
  }
}