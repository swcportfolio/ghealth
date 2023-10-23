
class LoginModel{
  late String userID;
  late String password;

  LoginModel(this.userID, this.password);

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'password': password
    };
  }
}