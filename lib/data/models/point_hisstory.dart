
class PointHistory {
  late String userID;
  late String serviceType;
  late String pointType;
  late String point;
  late String pointDesc;
  late String createDT;

  PointHistory({
    required this.userID,
      required this.serviceType,
      required this.pointType,
      required this.point,
      required this.pointDesc,
      required this.createDT,
  });

  factory PointHistory.fromJson(Map<String, dynamic> json) {
    return PointHistory(
        userID: json['userID'],
        serviceType: json['serviceType']?? '',
        pointType: json['pointType'],
        point: json['point'],
        pointDesc: json['pointDesc'],
        createDT: json['createDT'],
    );
  }

  static List<PointHistory> jsonToList(dynamic json) {
    var tagObjsJson = json as List;
    return tagObjsJson.map((json) =>
        PointHistory.fromJson(json)).toList();
  }
}
