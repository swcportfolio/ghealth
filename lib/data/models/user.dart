class UserData {
  final String userID;
  final String userName;
  final String token;
  final String gender;

  UserData(
      {required this.userID,
      required this.userName,
      required this.token,
      required this.gender});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userID: json['userID'],
      userName: json['userName'],
      token: json['token'],
      gender: json['gender'],
    );
  }
}
