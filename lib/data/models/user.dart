class UserData {
  final String userID;
  final String userName;
  final String token;
  final String gender;
  final String userIDOfD; // 동구 아이디
  final String userIDOfG; // 광산구 아이디

  UserData({
    required this.userID,
    required this.userName,
    required this.token,
    required this.gender,
    required this.userIDOfD,
    required this.userIDOfG,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userID: json['userID'],
      userName: json['userName'],
      token: json['token'],
      gender: json['gender'],
      userIDOfD: json['userIDOfD'] ?? '',
      userIDOfG: json['userIDOfG'] ?? '',
    );
  }
}
